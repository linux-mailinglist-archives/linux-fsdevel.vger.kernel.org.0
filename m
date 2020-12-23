Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36AE52E20AA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Dec 2020 20:03:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727901AbgLWTBn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Dec 2020 14:01:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:54578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727100AbgLWTBn (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Dec 2020 14:01:43 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A7CEE22225;
        Wed, 23 Dec 2020 19:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608750061;
        bh=K3eNk2k+XId8iNUM5HFQyVWpWlz8Iaz3JosBBBcoS8A=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=VOXfuxeoXwJl27kvlpzUCBqKoRUvgF+U31lmxqxavINRuHeZ2lc1C99J9rSw6g+Cs
         LtYwNLPRO+2MtNinRFe6xzPN0YTb4yUWnBRjpANcBzHiR03rEOxufJYVD7DJxiU0yO
         Frxg1OcgYVxog9HfevKM6ud5FvIejgvDtI/ujfCtKTDnIAf8RQSg6gZcdO4UUtTfOR
         oSsBwIMxl3jzypMupxuYmAQYzAGLRNmEL/kreMXOX2qtEQ+bih0/BzG4IIHXmINOzL
         hNyZli2V8KeXSmk0MWcj+C4cFvD54PZQ5APMxq8dyj7vm5S8BJacg3yZyYZLA0hkBh
         n94oiOVFrO8rQ==
Message-ID: <3b7706bf28ab6c4bf2e7dae6faea15441a919937.camel@kernel.org>
Subject: Re: [PATCH 3/3] overlayfs: Report writeback errors on upper
From:   Jeff Layton <jlayton@kernel.org>
To:     Sargun Dhillon <sargun@sargun.me>, Vivek Goyal <vgoyal@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-unionfs@vger.kernel.org, amir73il@gmail.com,
        miklos@szeredi.hu, willy@infradead.org, jack@suse.cz,
        neilb@suse.com, viro@zeniv.linux.org.uk, hch@lst.de
Date:   Wed, 23 Dec 2020 14:00:59 -0500
In-Reply-To: <20201223182026.GA9935@ircssh-2.c.rugged-nimbus-611.internal>
References: <20201221195055.35295-1-vgoyal@redhat.com>
         <20201221195055.35295-4-vgoyal@redhat.com>
         <20201223182026.GA9935@ircssh-2.c.rugged-nimbus-611.internal>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.38.2 (3.38.2-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 2020-12-23 at 18:20 +0000, Sargun Dhillon wrote:
> On Mon, Dec 21, 2020 at 02:50:55PM -0500, Vivek Goyal wrote:
> > Currently syncfs() and fsync() seem to be two interfaces which check and
> > return writeback errors on superblock to user space. fsync() should
> > work fine with overlayfs as it relies on underlying filesystem to
> > do the check and return error. For example, if ext4 is on upper filesystem,
> > then ext4_sync_file() calls file_check_and_advance_wb_err(file) on
> > upper file and returns error. So overlayfs does not have to do anything
> > special.
> > 
> > But with syncfs(), error check happens in vfs in syncfs() w.r.t
> > overlay_sb->s_wb_err. Given overlayfs is stacked filesystem, it
> > does not do actual writeback and all writeback errors are recorded
> > on underlying filesystem. So sb->s_wb_err is never updated hence
> > syncfs() does not work with overlay.
> > 
> > Jeff suggested that instead of trying to propagate errors to overlay
> > super block, why not simply check for errors against upper filesystem
> > super block. I implemented this idea.
> > 
> > Overlay file has "since" value which needs to be initialized at open
> > time. Overlay overrides VFS initialization and re-initializes
> > f->f_sb_err w.r.t upper super block. Later when
> > ovl_sb->errseq_check_advance() is called, f->f_sb_err is used as
> > since value to figure out if any error on upper sb has happened since
> > then.
> > 
> > Note, Right now this patch only deals with regular file and directories.
> > Yet to deal with special files like device inodes, socket, fifo etc.
> > 
> > Suggested-by: Jeff Layton <jlayton@kernel.org>
> > Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> > ---
> >  fs/overlayfs/file.c      |  1 +
> >  fs/overlayfs/overlayfs.h |  1 +
> >  fs/overlayfs/readdir.c   |  1 +
> >  fs/overlayfs/super.c     | 23 +++++++++++++++++++++++
> >  fs/overlayfs/util.c      | 13 +++++++++++++
> >  5 files changed, 39 insertions(+)
> > 
> > diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
> > index efccb7c1f9bc..7b58a44dcb71 100644
> > --- a/fs/overlayfs/file.c
> > +++ b/fs/overlayfs/file.c
> > @@ -163,6 +163,7 @@ static int ovl_open(struct inode *inode, struct file *file)
> >  		return PTR_ERR(realfile);
> >  
> > 
> >  	file->private_data = realfile;
> > +	ovl_init_file_errseq(file);
> >  
> > 
> >  	return 0;
> >  }
> > diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
> > index f8880aa2ba0e..47838abbfb3d 100644
> > --- a/fs/overlayfs/overlayfs.h
> > +++ b/fs/overlayfs/overlayfs.h
> > @@ -322,6 +322,7 @@ int ovl_check_metacopy_xattr(struct ovl_fs *ofs, struct dentry *dentry);
> >  bool ovl_is_metacopy_dentry(struct dentry *dentry);
> >  char *ovl_get_redirect_xattr(struct ovl_fs *ofs, struct dentry *dentry,
> >  			     int padding);
> > +void ovl_init_file_errseq(struct file *file);
> >  
> > 
> >  static inline bool ovl_is_impuredir(struct super_block *sb,
> >  				    struct dentry *dentry)
> > diff --git a/fs/overlayfs/readdir.c b/fs/overlayfs/readdir.c
> > index 01620ebae1bd..0c48f1545483 100644
> > --- a/fs/overlayfs/readdir.c
> > +++ b/fs/overlayfs/readdir.c
> > @@ -960,6 +960,7 @@ static int ovl_dir_open(struct inode *inode, struct file *file)
> >  	od->is_real = ovl_dir_is_real(file->f_path.dentry);
> >  	od->is_upper = OVL_TYPE_UPPER(type);
> >  	file->private_data = od;
> > +	ovl_init_file_errseq(file);
> >  
> > 
> >  	return 0;
> >  }
> > diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
> > index 290983bcfbb3..d99867983722 100644
> > --- a/fs/overlayfs/super.c
> > +++ b/fs/overlayfs/super.c
> > @@ -390,6 +390,28 @@ static int ovl_remount(struct super_block *sb, int *flags, char *data)
> >  	return ret;
> >  }
> >  
> > 
> > +static int ovl_errseq_check_advance(struct super_block *sb, struct file *file)
> > +{
> > +	struct ovl_fs *ofs = sb->s_fs_info;
> > +	struct super_block *upper_sb;
> > +	int ret;
> > +
> > +	if (!ovl_upper_mnt(ofs))
> > +		return 0;
> > +
> > +	upper_sb = ovl_upper_mnt(ofs)->mnt_sb;
> > +
> > +	if (!errseq_check(&upper_sb->s_wb_err, file->f_sb_err))
> > +		return 0;
> > +
> > +	/* Something changed, must use slow path */
> > +	spin_lock(&file->f_lock);
> > +	ret = errseq_check_and_advance(&upper_sb->s_wb_err, &file->f_sb_err);
> > +	spin_unlock(&file->f_lock);
> > +
> > +	return ret;
> > +}
> > +
> >  static const struct super_operations ovl_super_operations = {
> >  	.alloc_inode	= ovl_alloc_inode,
> >  	.free_inode	= ovl_free_inode,
> > @@ -400,6 +422,7 @@ static const struct super_operations ovl_super_operations = {
> >  	.statfs		= ovl_statfs,
> >  	.show_options	= ovl_show_options,
> >  	.remount_fs	= ovl_remount,
> > +	.errseq_check_advance	= ovl_errseq_check_advance,
> >  };
> >  
> > 
> >  enum {
> > diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
> > index 23f475627d07..a1742847f3a8 100644
> > --- a/fs/overlayfs/util.c
> > +++ b/fs/overlayfs/util.c
> > @@ -950,3 +950,16 @@ char *ovl_get_redirect_xattr(struct ovl_fs *ofs, struct dentry *dentry,
> >  	kfree(buf);
> >  	return ERR_PTR(res);
> >  }
> > +
> > +void ovl_init_file_errseq(struct file *file)
> > +{
> > +	struct super_block *sb = file_dentry(file)->d_sb;
> > +	struct ovl_fs *ofs = sb->s_fs_info;
> > +	struct super_block *upper_sb;
> > +
> > +	if (!ovl_upper_mnt(ofs))
> > +		return;
> > +
> > +	upper_sb = ovl_upper_mnt(ofs)->mnt_sb;
> > +	file->f_sb_err = errseq_sample(&upper_sb->s_wb_err);
> > +}
> > -- 
> > 2.25.4
> > 
> 
> I fail to see why this is neccessary if you incorporate error reporting into the 
> sync_fs callback. Why is this separate from that callback? If you pickup Jeff's
> patch that adds the 2nd flag to errseq for "observed", you should be able to
> stash the first errseq seen in the ovl_fs struct, and do the check-and-return
> in there instead instead of adding this new infrastructure.
> 
> IMHO, if we're going to fix this, sync_fs should be replaced, and there should 
> be a generic_sync_fs wrapper which does the errseq, callback, and sync blockdev, 
> but then filesystems should be able to override it and do the requisite work.

The big problem is that ->sync_fs is called in several different
contexts. For syncfs(), yes, but also for sync(), some quota handling,
etc.

In most of those, we don't want to do an errseq_check_and_advance
because we don't have a way to send that error back to userland at all
(e.g., sync()), or reporting a writeback error might not make sense.
(e.g. quotactl()).

IOW, we need to be able to distinguish the context in which the sync_fs
is being performed before "scraping" the error.

Cheers,
-- 
Jeff Layton <jlayton@kernel.org>

