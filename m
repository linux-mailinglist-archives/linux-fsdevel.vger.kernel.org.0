Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A168813B6A0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2020 01:57:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728880AbgAOA53 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Jan 2020 19:57:29 -0500
Received: from mga09.intel.com ([134.134.136.24]:41193 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728795AbgAOA53 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Jan 2020 19:57:29 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Jan 2020 16:57:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,320,1574150400"; 
   d="scan'208";a="225393056"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
  by orsmga003.jf.intel.com with ESMTP; 14 Jan 2020 16:57:28 -0800
Date:   Tue, 14 Jan 2020 16:57:28 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH V2 08/12] fs/xfs: Add lock/unlock mode to xfs
Message-ID: <20200115005727.GB23311@iweiny-DESK2.sc.intel.com>
References: <20200110192942.25021-1-ira.weiny@intel.com>
 <20200110192942.25021-9-ira.weiny@intel.com>
 <20200113221957.GN8247@magnolia>
 <20200114003521.GB29860@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200114003521.GB29860@iweiny-DESK2.sc.intel.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 13, 2020 at 04:35:21PM -0800, 'Ira Weiny' wrote:
> On Mon, Jan 13, 2020 at 02:19:57PM -0800, Darrick J. Wong wrote:
> > On Fri, Jan 10, 2020 at 11:29:38AM -0800, ira.weiny@intel.com wrote:
> > > From: Ira Weiny <ira.weiny@intel.com>
> 
> [snip]
> 
> > >  
> > > diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
> > > index 401da197f012..e8fd95b75e5b 100644
> > > --- a/fs/xfs/xfs_inode.c
> > > +++ b/fs/xfs/xfs_inode.c
> > > @@ -142,12 +142,12 @@ xfs_ilock_attr_map_shared(
> > >   *
> > >   * Basic locking order:
> > >   *
> > > - * i_rwsem -> i_mmap_lock -> page_lock -> i_ilock
> > > + * i_rwsem -> i_dax_sem -> i_mmap_lock -> page_lock -> i_ilock
> > 
> > Mmmmmm, more locks.  Can we skip the extra lock if CONFIG_FSDAX=n or if
> > the filesystem devices don't support DAX at all?
> 
> I'll look into it.
> 
> > 
> > Also, I don't think we're actually following the i_rwsem -> i_daxsem
> > order in fallocate, and possibly elsewhere too?
> 
> I'll have to verify.  It took a lot of iterations to get the order working so
> I'm not going to claim perfection.

Yes this was inconsistent.  The code was right WRT i_rwsem.

mmap_sem may have issues:

What about this?

diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
index c5d11b70d067..8808782a085e 100644
--- a/fs/xfs/xfs_inode.c
+++ b/fs/xfs/xfs_inode.c
@@ -142,12 +142,12 @@ xfs_ilock_attr_map_shared(
  *
  * Basic locking order:
  *
- * i_rwsem -> i_dax_sem -> i_mmap_lock -> page_lock -> i_ilock
+ * i_dax_sem -> i_rwsem -> i_mmap_lock -> page_lock -> i_ilock
  *
  * mmap_sem locking order:
  *
  * i_rwsem -> page lock -> mmap_sem
- * mmap_sem -> i_dax_sem -> i_mmap_lock -> page_lock
+ * i_dax_sem -> mmap_sem -> i_mmap_lock -> page_lock
  *
  * The difference in mmap_sem locking order mean that we cannot hold the
  * i_mmap_lock over syscall based read(2)/write(2) based IO. These IO paths can
diff --git a/mm/mmap.c b/mm/mmap.c
index e6b68924b7ca..b500aef30b27 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1547,18 +1547,12 @@ unsigned long do_mmap(struct file *file, unsigned long addr,
                        vm_flags |= VM_NORESERVE;
        }
 
-       if (file)
-               lock_inode_mode(file_inode(file));
-
        addr = mmap_region(file, addr, len, vm_flags, pgoff, uf);
        if (!IS_ERR_VALUE(addr) &&
            ((vm_flags & VM_LOCKED) ||
             (flags & (MAP_POPULATE | MAP_NONBLOCK)) == MAP_POPULATE))
                *populate = len;
 
-       if (file)
-               unlock_inode_mode(file_inode(file));
-
        return addr;
 }
 
diff --git a/mm/util.c b/mm/util.c
index 988d11e6c17c..1cfead8cd1ce 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -501,11 +501,18 @@ unsigned long vm_mmap_pgoff(struct file *file, unsigned long addr,
 
        ret = security_mmap_file(file, prot, flag);
        if (!ret) {
-               if (down_write_killable(&mm->mmap_sem))
+               if (file)
+                       lock_inode_mode(file_inode(file));
+               if (down_write_killable(&mm->mmap_sem)) {
+                       if (file)
+                               unlock_inode_mode(file_inode(file));
                        return -EINTR;
+               }
                ret = do_mmap_pgoff(file, addr, len, prot, flag, pgoff,
                                    &populate, &uf);
                up_write(&mm->mmap_sem);
+               if (file)
+                       unlock_inode_mode(file_inode(file));
                userfaultfd_unmap_complete(mm, &uf);
                if (populate)
                        mm_populate(ret, populate);

