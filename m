Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B8FC139DF6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2020 01:20:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729246AbgANAUG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Jan 2020 19:20:06 -0500
Received: from mga12.intel.com ([192.55.52.136]:23483 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728865AbgANAUG (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Jan 2020 19:20:06 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Jan 2020 16:20:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,430,1571727600"; 
   d="scan'208";a="422976956"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
  by fmsmga005.fm.intel.com with ESMTP; 13 Jan 2020 16:20:05 -0800
Date:   Mon, 13 Jan 2020 16:20:05 -0800
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
Subject: Re: [RFC PATCH V2 07/12] fs: Add locking for a dynamic inode 'mode'
Message-ID: <20200114002005.GA29860@iweiny-DESK2.sc.intel.com>
References: <20200110192942.25021-1-ira.weiny@intel.com>
 <20200110192942.25021-8-ira.weiny@intel.com>
 <20200113221218.GM8247@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200113221218.GM8247@magnolia>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 13, 2020 at 02:12:18PM -0800, Darrick J. Wong wrote:
> On Fri, Jan 10, 2020 at 11:29:37AM -0800, ira.weiny@intel.com wrote:
> > From: Ira Weiny <ira.weiny@intel.com>

[snip]

> >  
> >  The File Object
> >  ---------------
> > @@ -437,6 +459,8 @@ As of kernel 2.6.22, the following members are defined:
> >  		int (*atomic_open)(struct inode *, struct dentry *, struct file *,
> >  				   unsigned open_flag, umode_t create_mode);
> >  		int (*tmpfile) (struct inode *, struct dentry *, umode_t);
> > +		void (*lock_mode)(struct inode *);
> > +		void (*unlock_mode)(struct inode *);
> 
> Yikes.  "mode" has a specific meaning for inodes, and this lock isn't
> related to i_mode.  This lock protects aops from changing while an
> address space operation is in use.

Ah...  yea ok mode is a bad name.

> 
> >  	};
> >  
> >  Again, all methods are called without any locks being held, unless
> > @@ -584,6 +608,12 @@ otherwise noted.
> >  	atomically creating, opening and unlinking a file in given
> >  	directory.
> >  
> > +``lock_mode``
> > +	called to prevent operations which depend on the inode's mode from
> > +        proceeding should a mode change be in progress
> 
> "Inodes can't change mode, because files do not suddenly become
> directories". ;)

Yea sorry.

> 
> Oh, you meant "lock_XXXX is called to prevent a change in the pagecache
> mode from proceeding while there are address space operations in
> progress".  So these are really more aops get and put functions...

At first I actually did have aops get/put functions but this is really
protecting more than the aops vector because as Christoph said there are file
operations which need to be protected not just address space operations.

But I agree "mode" is a bad name...  Sorry...

> 
> > +``unlock_mode``
> > +	called when critical mode dependent operation is complete
> >  
> >  The Address Space Object
> >  ========================
> > diff --git a/fs/ioctl.c b/fs/ioctl.c
> > index 7c9a5df5a597..ed6ab5303a24 100644
> > --- a/fs/ioctl.c
> > +++ b/fs/ioctl.c
> > @@ -55,18 +55,29 @@ EXPORT_SYMBOL(vfs_ioctl);
> >  static int ioctl_fibmap(struct file *filp, int __user *p)
> >  {
> >  	struct address_space *mapping = filp->f_mapping;
> > +	struct inode *inode = filp->f_inode;
> >  	int res, block;
> >  
> > +	lock_inode_mode(inode);
> > +
> >  	/* do we support this mess? */
> > -	if (!mapping->a_ops->bmap)
> > -		return -EINVAL;
> > -	if (!capable(CAP_SYS_RAWIO))
> > -		return -EPERM;
> > +	if (!mapping->a_ops->bmap) {
> > +		res = -EINVAL;
> > +		goto out;
> > +	}
> > +	if (!capable(CAP_SYS_RAWIO)) {
> > +		res = -EPERM;
> > +		goto out;
> 
> Why does the order of these checks change here?

I don't understand?  The order does not change we just can't return without
releasing the lock.  And to protect against bmap changing the lock needs to be
taken first.

[snip]

> >  
> > +static inline void lock_inode_mode(struct inode *inode)
> 
> inode_aops_get()?

Let me think on this.  This is not just getting a reference to the aops vector.
It is more than that...  and inode_get is not right either!  ;-P

> 
> > +{
> > +	WARN_ON_ONCE(inode->i_op->lock_mode &&
> > +		     !inode->i_op->unlock_mode);
> > +	if (inode->i_op->lock_mode)
> > +		inode->i_op->lock_mode(inode);
> > +}
> > +static inline void unlock_inode_mode(struct inode *inode)
> > +{
> > +	WARN_ON_ONCE(inode->i_op->unlock_mode &&
> > +		     !inode->i_op->lock_mode);
> > +	if (inode->i_op->unlock_mode)
> > +		inode->i_op->unlock_mode(inode);
> > +}
> > +
> >  static inline ssize_t call_read_iter(struct file *file, struct kiocb *kio,
> >  				     struct iov_iter *iter)
> 
> inode_aops_put()?

...  something like that but not 'aops'...

Ira

> 
> --D
> 
