Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B6A42D46BD
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Dec 2020 17:28:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731291AbgLIQ1E (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Dec 2020 11:27:04 -0500
Received: from mx2.suse.de ([195.135.220.15]:42014 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730349AbgLIQ1B (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Dec 2020 11:27:01 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5186FAC9A;
        Wed,  9 Dec 2020 16:26:16 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 03EC91E133E; Wed,  9 Dec 2020 17:26:16 +0100 (CET)
Date:   Wed, 9 Dec 2020 17:26:15 +0100
From:   Jan Kara <jack@suse.cz>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Jan Kara <jack@suse.cz>,
        syzbot <syzbot+f427adf9324b92652ccc@syzkaller.appspotmail.com>,
        Amir Goldstein <amir73il@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Subject: Re: kernel BUG at fs/notify/dnotify/dnotify.c:LINE! (2)
Message-ID: <20201209162615.GA2332@quack2.suse.cz>
References: <000000000000be4c9505b4c35420@google.com>
 <20201209133842.GA28118@quack2.suse.cz>
 <20201209135934.GB28118@quack2.suse.cz>
 <CAJfpegtZc=qXiQ55UOM1bhhPhhHkvPp3DzXSLS93uAfXSQ5vBw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegtZc=qXiQ55UOM1bhhPhhHkvPp3DzXSLS93uAfXSQ5vBw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 09-12-20 17:15:02, Miklos Szeredi wrote:
> On Wed, Dec 9, 2020 at 2:59 PM Jan Kara <jack@suse.cz> wrote:
> >
> > On Wed 09-12-20 14:38:42, Jan Kara wrote:
> > > Hello!
> > >
> > > so I was debugging the dnotify crash below (it's 100% reproducible for me)
> > > and I came to the following. The reproducer opens 'file0' on FUSE
> > > filesystem which is a directory at that point. Then it attached dnotify
> > > mark to the directory 'file0' and then it does something to the FUSE fs
> > > which I don't understand but the result is that when FUSE is unmounted the
> > > 'file0' inode is actually a regular file (note that I've verified this is
> > > really the same inode pointer). This then confuses dnotify which doesn't
> > > tear down its structures properly and eventually crashes. So my question
> > > is: How can an inode on FUSE filesystem morph from a dir to a regular file?
> > > I presume this could confuse much more things than just dnotify?
> > >
> > > Before I dwelve more into FUSE internals, any idea Miklos what could have
> > > gone wrong and how to debug this further?
> >
> > I've got an idea where to look and indeed it is the fuse_do_getattr() call
> > that finds attributes returned by the server are inconsistent so it calls
> > make_bad_inode() which, among other things, does:
> >
> >         inode->i_mode = S_IFREG;
> >
> > Indeed calling make_bad_inode() on a live inode doesn't look like a good
> > idea. IMHO FUSE needs to come up with some other means of marking the inode
> > as stale. Miklos?
> 
> Something like the attached.  It's untested and needs the
> fuse_is_bad() test in more ops...

The patch fixes the problem for me (the reproducer no longer crashes the
kernel). So feel free to add:

Tested-by: Jan Kara <jack@suse.cz>

								Honza

> diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
> index ff7dbeb16f88..1172179c9fba 100644
> --- a/fs/fuse/dir.c
> +++ b/fs/fuse/dir.c
> @@ -202,7 +202,7 @@ static int fuse_dentry_revalidate(struct dentry *entry, unsigned int flags)
>  	int ret;
>  
>  	inode = d_inode_rcu(entry);
> -	if (inode && is_bad_inode(inode))
> +	if (inode && fuse_is_bad(inode))
>  		goto invalid;
>  	else if (time_before64(fuse_dentry_time(entry), get_jiffies_64()) ||
>  		 (flags & LOOKUP_REVAL)) {
> @@ -1030,7 +1030,7 @@ static int fuse_do_getattr(struct inode *inode, struct kstat *stat,
>  	if (!err) {
>  		if (fuse_invalid_attr(&outarg.attr) ||
>  		    (inode->i_mode ^ outarg.attr.mode) & S_IFMT) {
> -			make_bad_inode(inode);
> +			fuse_make_bad(inode);
>  			err = -EIO;
>  		} else {
>  			fuse_change_attributes(inode, &outarg.attr,
> @@ -1327,7 +1327,7 @@ static const char *fuse_get_link(struct dentry *dentry, struct inode *inode,
>  	int err;
>  
>  	err = -EIO;
> -	if (is_bad_inode(inode))
> +	if (fuse_is_bad(inode))
>  		goto out_err;
>  
>  	if (fc->cache_symlinks)
> @@ -1375,7 +1375,7 @@ static int fuse_dir_fsync(struct file *file, loff_t start, loff_t end,
>  	struct fuse_conn *fc = get_fuse_conn(inode);
>  	int err;
>  
> -	if (is_bad_inode(inode))
> +	if (fuse_is_bad(inode))
>  		return -EIO;
>  
>  	if (fc->no_fsyncdir)
> @@ -1664,7 +1664,7 @@ int fuse_do_setattr(struct dentry *dentry, struct iattr *attr,
>  
>  	if (fuse_invalid_attr(&outarg.attr) ||
>  	    (inode->i_mode ^ outarg.attr.mode) & S_IFMT) {
> -		make_bad_inode(inode);
> +		fuse_make_bad(inode);
>  		err = -EIO;
>  		goto error;
>  	}
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index c03034e8c152..30fdb3adf9b9 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -463,7 +463,7 @@ static int fuse_flush(struct file *file, fl_owner_t id)
>  	FUSE_ARGS(args);
>  	int err;
>  
> -	if (is_bad_inode(inode))
> +	if (fuse_is_bad(inode))
>  		return -EIO;
>  
>  	err = write_inode_now(inode, 1);
> @@ -535,7 +535,7 @@ static int fuse_fsync(struct file *file, loff_t start, loff_t end,
>  	struct fuse_conn *fc = get_fuse_conn(inode);
>  	int err;
>  
> -	if (is_bad_inode(inode))
> +	if (fuse_is_bad(inode))
>  		return -EIO;
>  
>  	inode_lock(inode);
> @@ -859,7 +859,7 @@ static int fuse_readpage(struct file *file, struct page *page)
>  	int err;
>  
>  	err = -EIO;
> -	if (is_bad_inode(inode))
> +	if (fuse_is_bad(inode))
>  		goto out;
>  
>  	err = fuse_do_readpage(file, page);
> @@ -952,7 +952,7 @@ static void fuse_readahead(struct readahead_control *rac)
>  	struct fuse_conn *fc = get_fuse_conn(inode);
>  	unsigned int i, max_pages, nr_pages = 0;
>  
> -	if (is_bad_inode(inode))
> +	if (fuse_is_bad(inode))
>  		return;
>  
>  	max_pages = min_t(unsigned int, fc->max_pages,
> @@ -1555,7 +1555,7 @@ static ssize_t fuse_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
>  	struct fuse_file *ff = file->private_data;
>  	struct inode *inode = file_inode(file);
>  
> -	if (is_bad_inode(inode))
> +	if (fuse_is_bad(inode))
>  		return -EIO;
>  
>  	if (FUSE_IS_DAX(inode))
> @@ -1573,7 +1573,7 @@ static ssize_t fuse_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
>  	struct fuse_file *ff = file->private_data;
>  	struct inode *inode = file_inode(file);
>  
> -	if (is_bad_inode(inode))
> +	if (fuse_is_bad(inode))
>  		return -EIO;
>  
>  	if (FUSE_IS_DAX(inode))
> @@ -2172,7 +2172,7 @@ static int fuse_writepages(struct address_space *mapping,
>  	int err;
>  
>  	err = -EIO;
> -	if (is_bad_inode(inode))
> +	if (fuse_is_bad(inode))
>  		goto out;
>  
>  	data.inode = inode;
> @@ -2954,7 +2954,7 @@ long fuse_ioctl_common(struct file *file, unsigned int cmd,
>  	if (!fuse_allow_current_process(fc))
>  		return -EACCES;
>  
> -	if (is_bad_inode(inode))
> +	if (fuse_is_bad(inode))
>  		return -EIO;
>  
>  	return fuse_do_ioctl(file, cmd, arg, flags);
> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> index d51598017d13..8484f0053687 100644
> --- a/fs/fuse/fuse_i.h
> +++ b/fs/fuse/fuse_i.h
> @@ -172,6 +172,8 @@ enum {
>  	FUSE_I_INIT_RDPLUS,
>  	/** An operation changing file size is in progress  */
>  	FUSE_I_SIZE_UNSTABLE,
> +	/* Bad inode */
> +	FUSE_I_BAD,
>  };
>  
>  struct fuse_conn;
> @@ -858,6 +860,16 @@ static inline u64 fuse_get_attr_version(struct fuse_conn *fc)
>  	return atomic64_read(&fc->attr_version);
>  }
>  
> +static inline void fuse_make_bad(struct inode *inode)
> +{
> +	set_bit(FUSE_I_BAD, &get_fuse_inode(inode)->state);
> +}
> +
> +static inline bool fuse_is_bad(struct inode *inode)
> +{
> +	return test_bit(FUSE_I_BAD, &get_fuse_inode(inode)->state);
> +}
> +
>  /** Device operations */
>  extern const struct file_operations fuse_dev_operations;
>  
> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> index 1a47afc95f80..f94b0bb57619 100644
> --- a/fs/fuse/inode.c
> +++ b/fs/fuse/inode.c
> @@ -132,7 +132,7 @@ static void fuse_evict_inode(struct inode *inode)
>  			fi->forget = NULL;
>  		}
>  	}
> -	if (S_ISREG(inode->i_mode) && !is_bad_inode(inode)) {
> +	if (S_ISREG(inode->i_mode) && !fuse_is_bad(inode)) {
>  		WARN_ON(!list_empty(&fi->write_files));
>  		WARN_ON(!list_empty(&fi->queued_writes));
>  	}
> @@ -342,7 +342,7 @@ struct inode *fuse_iget(struct super_block *sb, u64 nodeid,
>  		unlock_new_inode(inode);
>  	} else if ((inode->i_mode ^ attr->mode) & S_IFMT) {
>  		/* Inode has changed type, any I/O on the old should fail */
> -		make_bad_inode(inode);
> +		fuse_make_bad(inode);
>  		iput(inode);
>  		goto retry;
>  	}
> diff --git a/fs/fuse/readdir.c b/fs/fuse/readdir.c
> index 3b5e91045871..3441ffa740f3 100644
> --- a/fs/fuse/readdir.c
> +++ b/fs/fuse/readdir.c
> @@ -207,7 +207,7 @@ static int fuse_direntplus_link(struct file *file,
>  			dput(dentry);
>  			goto retry;
>  		}
> -		if (is_bad_inode(inode)) {
> +		if (fuse_is_bad(inode)) {
>  			dput(dentry);
>  			return -EIO;
>  		}
> @@ -568,7 +568,7 @@ int fuse_readdir(struct file *file, struct dir_context *ctx)
>  	struct inode *inode = file_inode(file);
>  	int err;
>  
> -	if (is_bad_inode(inode))
> +	if (fuse_is_bad(inode))
>  		return -EIO;
>  
>  	mutex_lock(&ff->readdir.lock);

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
