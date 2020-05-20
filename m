Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06C0B1DBCF2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 May 2020 20:34:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbgETSeG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 May 2020 14:34:06 -0400
Received: from mga01.intel.com ([192.55.52.88]:49544 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726510AbgETSeG (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 May 2020 14:34:06 -0400
IronPort-SDR: /qoIdQ/3yGZM96X46ViR/C7Cc6fpUBgO/EA11MPzp/Gb6da8I32bmhG9TSBplu6JlgcYmN+x51
 z24UjS4MsqGg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2020 11:34:05 -0700
IronPort-SDR: inQU0SeZy+ZsfOc31YVmUroqAI4RRp1d+ieKKViNm60J3QwGRSI8o5y+0O9z0a8O8nijdjftaE
 ICZ166qYICFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,414,1583222400"; 
   d="scan'208";a="412121303"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.147])
  by orsmga004.jf.intel.com with ESMTP; 20 May 2020 11:34:04 -0700
Date:   Wed, 20 May 2020 11:34:04 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-ext4@vger.kernel.org,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Eric Biggers <ebiggers@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>, Jeff Moyer <jmoyer@redhat.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 7/8] fs/ext4: Introduce DAX inode flag
Message-ID: <20200520183404.GE3660833@iweiny-DESK2.sc.intel.com>
References: <20200520055753.3733520-1-ira.weiny@intel.com>
 <20200520055753.3733520-8-ira.weiny@intel.com>
 <20200520141138.GE30597@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200520141138.GE30597@quack2.suse.cz>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 20, 2020 at 04:11:38PM +0200, Jan Kara wrote:
> On Tue 19-05-20 22:57:52, ira.weiny@intel.com wrote:
> > From: Ira Weiny <ira.weiny@intel.com>
> > 
> > Add a flag to preserve FS_XFLAG_DAX in the ext4 inode.
> > 
> > Set the flag to be user visible and changeable.  Set the flag to be
> > inherited.  Allow applications to change the flag at any time with the
> > exception of if VERITY or ENCRYPT is set.
> > 
> > Disallow setting VERITY or ENCRYPT if DAX is set.
> > 
> > Finally, on regular files, flag the inode to not be cached to facilitate
> > changing S_DAX on the next creation of the inode.
> > 
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 
> The patch looks good to me. You can add:
> 
> Reviewed-by: Jan Kara <jack@suse.cz>
> 
> One comment below:
> 
> > diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> > index 5ba65eb0e2ef..be9713e898eb 100644
> > --- a/fs/ext4/super.c
> > +++ b/fs/ext4/super.c
> > @@ -1323,6 +1323,9 @@ static int ext4_set_context(struct inode *inode, const void *ctx, size_t len,
> >  	if (WARN_ON_ONCE(IS_DAX(inode) && i_size_read(inode)))
> >  		return -EINVAL;
> 
> AFAIU this check is here so that fscrypt_inherit_context() is able call us
> and we can clear S_DAX flag.

Basically yes that is true.  It is IMO somewhat convoluted because I think ext4
probably could have prevented S_DAX from being set in __ext4_new_inode() in the
first place.  But that is a clean up I was not prepared to make last night.

> So can't we rather move this below the
> EXT4_INODE_DAX check and change this to
> 
> 	IS_DAX(inode) && !(inode->i_flags & I_NEW)
> 
> ? Because as I'm reading the code now, this should never trigger?

I agree this should never trigger.  But I don't see how the order of the checks
maters much.  But changing this to !new is probably worth doing to make it
clear what we really mean here.

I think that is a follow on patch.  In addition, if we don't set S_DAX at all
in __ext4_new_inode() this check could then be what I had originally with the warn on.

	if (WARN_ON_ONCE(IS_DAX(inode)))
		...

... because it would be considered a bug to be setting DAX on inodes which are
going to be encrypted..

Ira

Something like this:  (compiled only)

commit 6cd5aed3cd9e2c10e3fb7c6dd23918580532f256 (HEAD -> lck-4071-b13-v4)
Author: Ira Weiny <ira.weiny@intel.com>
Date:   Wed May 20 11:32:50 2020 -0700

    RFC: do not set S_DAX on an inode which is going to be encrypted

diff --git a/fs/ext4/ialloc.c b/fs/ext4/ialloc.c
index 7941c140723f..be80cb639d74 100644
--- a/fs/ext4/ialloc.c
+++ b/fs/ext4/ialloc.c
@@ -844,6 +844,9 @@ struct inode *__ext4_new_inode(handle_t *handle, struct inode *dir,
                return ERR_PTR(-ENOMEM);
        ei = EXT4_I(inode);
 
+       if (encrypt)
+               ext4_set_inode_flag(inode, EXT4_INODE_ENCRYPT);
+
        /*
         * Initialize owners and quota early so that we don't have to account
         * for quota initialization worst case in standard inode creating
@@ -1165,6 +1168,7 @@ struct inode *__ext4_new_inode(handle_t *handle, struct inode *dir,
                err = fscrypt_inherit_context(dir, inode, handle, true);
                if (err)
                        goto fail_free_drop;
+               ext4_clear_inode_state(inode, EXT4_STATE_MAY_INLINE_DATA);
        }
 
        if (!(ei->i_flags & EXT4_EA_INODE_FL)) {
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index be9713e898eb..099b87864f55 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1320,7 +1320,10 @@ static int ext4_set_context(struct inode *inode, const void *ctx, size_t len,
        if (inode->i_ino == EXT4_ROOT_INO)
                return -EPERM;
 
-       if (WARN_ON_ONCE(IS_DAX(inode) && i_size_read(inode)))
+       /* S_DAX should never be set here because encryption is not compatible
+        * with DAX
+        */
+       if (WARN_ON_ONCE(IS_DAX(inode)))
                return -EINVAL;
 
        if (ext4_test_inode_flag(inode, EXT4_INODE_DAX))
@@ -1337,22 +1340,11 @@ static int ext4_set_context(struct inode *inode, const void *ctx, size_t len,
         * being set on an existing inode in its own transaction.  Only in the
         * latter case should the "retry on ENOSPC" logic be used.
         */
-
        if (handle) {
                res = ext4_xattr_set_handle(handle, inode,
                                            EXT4_XATTR_INDEX_ENCRYPTION,
                                            EXT4_XATTR_NAME_ENCRYPTION_CONTEXT,
                                            ctx, len, 0);
-               if (!res) {
-                       ext4_set_inode_flag(inode, EXT4_INODE_ENCRYPT);
-                       ext4_clear_inode_state(inode,
-                                       EXT4_STATE_MAY_INLINE_DATA);
-                       /*
-                        * Update inode->i_flags - S_ENCRYPTED will be enabled,
-                        * S_DAX may be disabled
-                        */
-                       ext4_set_inode_flags(inode, false);
-               }
                return res;
        }

