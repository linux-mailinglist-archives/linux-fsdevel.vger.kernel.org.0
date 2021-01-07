Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E5EC2EC934
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Jan 2021 04:52:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726742AbhAGDvu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Jan 2021 22:51:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726051AbhAGDvt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Jan 2021 22:51:49 -0500
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 167C7C0612F1
        for <linux-fsdevel@vger.kernel.org>; Wed,  6 Jan 2021 19:51:04 -0800 (PST)
Received: by mail-il1-x136.google.com with SMTP id n9so5494094ili.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 06 Jan 2021 19:51:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9ESIHrq2WXrrg8vdq+otEoFEY3UDCWo4fFqLiWLyiZU=;
        b=xzz0djr+5kTQ6Y9HClB5XE9TMtaQrfDaqMh0YOQA3qoH2XynVDLXFomVzoLf1wI+B9
         leQAkUBrTYCiCInaWHsFFLTXB30sywTRA4VBiUWlvkYWKoUzcETto9xk1bTBrON20Sy4
         6DXXvv391fU0eAiUQ8Ut4AAEaTZHpAdeJ4z2k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9ESIHrq2WXrrg8vdq+otEoFEY3UDCWo4fFqLiWLyiZU=;
        b=AbT2IseTu6jEiwzfgZNfcJ0poZmOgFJBJxVXzZnKTG99e+IWERmT/xM5UOvJCMFD9U
         Pdbxv8QUkycX4oAfIa9WiO1CXGS7gyaPQCJIrCWoMgK1JZA+SkTerCioRvUqX9ul5ciN
         8KhBOqcApZfE76IMEHvejveMsvrpN7PqdMt4yNk2FnZNZbJC9Ugq7vgp8D3BP/BHjlok
         bMorU8Q6vZlCYhPoMfShKf03Hs/diH4Mv6bL5hwzGnU/NyUOl8kperuGpaJ590E3mVaE
         VwR3j/wnD+FZ2aBgFhfeVG4EjSU680sDwB2xfAQY5TUu9E5vs4aJk2Z8NMbIQshdKmuF
         SUdQ==
X-Gm-Message-State: AOAM531UpwV9q2b2YtKv0TJTo9wbJrVsMEL7FSIZaLbhaZxWaKjEx6Ic
        lpfLp9DZ4PtVqN4KFQWhJ8aRwL3H9dqlJASR
X-Google-Smtp-Source: ABdhPJyJ3y0DZsrdcHeJcKWIN7zk1MQdXNwAgx79RlbMZpfGkDegXyBMFNzcKSW96bIWJ7MxSlEUSA==
X-Received: by 2002:a92:cccd:: with SMTP id u13mr7236819ilq.273.1609991463120;
        Wed, 06 Jan 2021 19:51:03 -0800 (PST)
Received: from ircssh-2.c.rugged-nimbus-611.internal (80.60.198.104.bc.googleusercontent.com. [104.198.60.80])
        by smtp.gmail.com with ESMTPSA id v10sm3479295ilu.58.2021.01.06.19.51.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Jan 2021 19:51:03 -0800 (PST)
Date:   Thu, 7 Jan 2021 03:51:01 +0000
From:   Sargun Dhillon <sargun@sargun.me>
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     linux-unionfs@vger.kernel.org, miklos@szeredi.hu,
        Amir Goldstein <amir73il@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Daniel J Walsh <dwalsh@redhat.com>,
        linux-fsdevel@vger.kernel.org, David Howells <dhowells@redhat.com>,
        Chengguang Xu <cgxu519@mykernel.net>,
        Christoph Hellwig <hch@lst.de>, NeilBrown <neilb@suse.com>,
        Jan Kara <jack@suse.cz>, Jeff Layton <jlayton@redhat.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v3] overlay: Implement volatile-specific fsync error
 behaviour
Message-ID: <20210107035101.GA24166@ircssh-2.c.rugged-nimbus-611.internal>
References: <20210106083546.4392-1-sargun@sargun.me>
 <20210106194658.GA3290@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210106194658.GA3290@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 06, 2021 at 02:46:58PM -0500, Vivek Goyal wrote:
> On Wed, Jan 06, 2021 at 12:35:46AM -0800, Sargun Dhillon wrote:
> > Overlayfs's volatile option allows the user to bypass all forced sync calls
> > to the upperdir filesystem. This comes at the cost of safety. We can never
> > ensure that the user's data is intact, but we can make a best effort to
> > expose whether or not the data is likely to be in a bad state.
> > 
> > The best way to handle this in the time being is that if an overlayfs's
> > upperdir experiences an error after a volatile mount occurs, that error
> > will be returned on fsync, fdatasync, sync, and syncfs. This is
> > contradictory to the traditional behaviour of VFS which fails the call
> > once, and only raises an error if a subsequent fsync error has occurred,
> > and been raised by the filesystem.
> > 
> > One awkward aspect of the patch is that we have to manually set the
> > superblock's errseq_t after the sync_fs callback as opposed to just
> > returning an error from syncfs. This is because the call chain looks
> > something like this:
> > 
> > sys_syncfs ->
> > 	sync_filesystem ->
> > 		__sync_filesystem ->
> > 			/* The return value is ignored here
> > 			sb->s_op->sync_fs(sb)
> > 			_sync_blockdev
> > 		/* Where the VFS fetches the error to raise to userspace */
> > 		errseq_check_and_advance
> > 
> > Because of this we call errseq_set every time the sync_fs callback occurs.
> 
> Why not start capturing return code of ->sync_fs and then return error
> from ovl->sync_fs. And then you don't have to do errseq_set(ovl_sb). 
> 
> I already posted a patch to capture retrun code from ->sync_fs.
> 
> https://lore.kernel.org/linux-fsdevel/20201221195055.35295-2-vgoyal@redhat.com/
> 

The idea of this patch is to go into stable, and a minimal patch to prevent 
overlayfs volatile mounts from expressing unintended behaviour. I think that 
your changes are still valid, and can sit atop this [and you can remove the 
errseq_set].

I believe the consensus was that changing the behaviour for all filesystems
presented undue risk to have the patch land in stable.

> 
> > Due to the nature of this seen / unseen dichotomy, if the upperdir is an
> > inconsistent state at the initial mount time, overlayfs will refuse to
> > mount, as overlayfs cannot get a snapshot of the upperdir's errseq that
> > will increment on error until the user calls syncfs.
> > 
> > Signed-off-by: Sargun Dhillon <sargun@sargun.me>
> > Suggested-by: Amir Goldstein <amir73il@gmail.com>
> > Cc: linux-fsdevel@vger.kernel.org
> > Cc: linux-unionfs@vger.kernel.org
> > Cc: Jeff Layton <jlayton@redhat.com>
> > Cc: Miklos Szeredi <miklos@szeredi.hu>
> > Cc: Amir Goldstein <amir73il@gmail.com>
> > Cc: Vivek Goyal <vgoyal@redhat.com>
> > Cc: Matthew Wilcox <willy@infradead.org>
> > ---
> >  Documentation/filesystems/overlayfs.rst |  8 +++++++
> >  fs/overlayfs/file.c                     |  5 ++--
> >  fs/overlayfs/overlayfs.h                |  1 +
> >  fs/overlayfs/ovl_entry.h                |  2 ++
> >  fs/overlayfs/readdir.c                  |  5 ++--
> >  fs/overlayfs/super.c                    | 32 +++++++++++++++++++------
> >  fs/overlayfs/util.c                     | 27 +++++++++++++++++++++
> >  7 files changed, 69 insertions(+), 11 deletions(-)
> > 
> > diff --git a/Documentation/filesystems/overlayfs.rst b/Documentation/filesystems/overlayfs.rst
> > index 580ab9a0fe31..3af569cea6a7 100644
> > --- a/Documentation/filesystems/overlayfs.rst
> > +++ b/Documentation/filesystems/overlayfs.rst
> > @@ -575,6 +575,14 @@ without significant effort.
> >  The advantage of mounting with the "volatile" option is that all forms of
> >  sync calls to the upper filesystem are omitted.
> >  
> > +In order to avoid a giving a false sense of safety, the syncfs (and fsync)
> > +semantics of volatile mounts are slightly different than that of the rest of
> > +VFS.  If any error occurs on the upperdir's filesystem after a volatile mount
>                 ^^^
> shoud we say "If any writeback error occurs...."
> 
Sure.

> > +takes place, all sync functions will return the last error observed on the
> > +upperdir filesystem.  Once this condition is reached, the filesystem will not
> > +recover, and every subsequent sync call will return an error, even if the
> > +upperdir has not experience a new error since the last sync call.
> 
> Once filesystem fails, do we want to continue to return latest error on
> upper? Or we just mark filesystem failed internally and once failed
> we always return a fixed error, say -EIO. That way we don't have to
> call errseq_check() on every filesystem call. I am assuming at some
> point of time we will extend this to other filesystem functions
> like read()/write()/mmap() etc. Filesystem has failed at this point 
> of time and user is supposed to throw away upper and restart.
> 
I think we talked about this on another thread -- adding filesystem shutdown[1]. I 
think that once we land this, we can go a number of ways in -next and add shutdown,
direct error return, and volatile remount, but I'd rather get something into stable
which is minimal earlier than later.

> > +
> >  When overlay is mounted with "volatile" option, the directory
> >  "$workdir/work/incompat/volatile" is created.  During next mount, overlay
> >  checks for this directory and refuses to mount if present. This is a strong
> > diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
> > index a1f72ac053e5..5c5c3972ebd0 100644
> > --- a/fs/overlayfs/file.c
> > +++ b/fs/overlayfs/file.c
> > @@ -445,8 +445,9 @@ static int ovl_fsync(struct file *file, loff_t start, loff_t end, int datasync)
> >  	const struct cred *old_cred;
> >  	int ret;
> >  
> > -	if (!ovl_should_sync(OVL_FS(file_inode(file)->i_sb)))
> > -		return 0;
> > +	ret = ovl_sync_status(OVL_FS(file_inode(file)->i_sb));
> > +	if (ret <= 0)
> > +		return ret;
> >  
> >  	ret = ovl_real_fdget_meta(file, &real, !datasync);
> >  	if (ret)
> > diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
> > index f8880aa2ba0e..9f7af98ae200 100644
> > --- a/fs/overlayfs/overlayfs.h
> > +++ b/fs/overlayfs/overlayfs.h
> > @@ -322,6 +322,7 @@ int ovl_check_metacopy_xattr(struct ovl_fs *ofs, struct dentry *dentry);
> >  bool ovl_is_metacopy_dentry(struct dentry *dentry);
> >  char *ovl_get_redirect_xattr(struct ovl_fs *ofs, struct dentry *dentry,
> >  			     int padding);
> > +int ovl_sync_status(struct ovl_fs *ofs);
> >  
> >  static inline bool ovl_is_impuredir(struct super_block *sb,
> >  				    struct dentry *dentry)
> > diff --git a/fs/overlayfs/ovl_entry.h b/fs/overlayfs/ovl_entry.h
> > index 1b5a2094df8e..b208eba5d0b6 100644
> > --- a/fs/overlayfs/ovl_entry.h
> > +++ b/fs/overlayfs/ovl_entry.h
> > @@ -79,6 +79,8 @@ struct ovl_fs {
> >  	atomic_long_t last_ino;
> >  	/* Whiteout dentry cache */
> >  	struct dentry *whiteout;
> > +	/* r/o snapshot of upperdir sb's only taken on volatile mounts */
> > +	errseq_t errseq;
> >  };
> >  
> >  static inline struct vfsmount *ovl_upper_mnt(struct ovl_fs *ofs)
> > diff --git a/fs/overlayfs/readdir.c b/fs/overlayfs/readdir.c
> > index 01620ebae1bd..a273ef901e57 100644
> > --- a/fs/overlayfs/readdir.c
> > +++ b/fs/overlayfs/readdir.c
> > @@ -909,8 +909,9 @@ static int ovl_dir_fsync(struct file *file, loff_t start, loff_t end,
> >  	struct file *realfile;
> >  	int err;
> >  
> > -	if (!ovl_should_sync(OVL_FS(file->f_path.dentry->d_sb)))
> > -		return 0;
> > +	err = ovl_sync_status(OVL_FS(file->f_path.dentry->d_sb));
> > +	if (err <= 0)
> > +		return err;
> >  
> >  	realfile = ovl_dir_real_file(file, true);
> >  	err = PTR_ERR_OR_ZERO(realfile);
> > diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
> > index 290983bcfbb3..b917b456bbb4 100644
> > --- a/fs/overlayfs/super.c
> > +++ b/fs/overlayfs/super.c
> > @@ -261,11 +261,18 @@ static int ovl_sync_fs(struct super_block *sb, int wait)
> >  	struct super_block *upper_sb;
> >  	int ret;
> >  
> > -	if (!ovl_upper_mnt(ofs))
> > -		return 0;
> > +	ret = ovl_sync_status(ofs);
> > +	/*
> > +	 * We have to always set the err, because the return value isn't
> > +	 * checked in syncfs, and instead indirectly return an error via
> > +	 * the sb's writeback errseq, which VFS inspects after this call.
> > +	 */
> > +	if (ret < 0)
> > +		errseq_set(&sb->s_wb_err, ret);
> 
> Again, I think we can simplify this. If we just capture return code of
> ->sync_fs in VFS and return to user space, we can simply return an
> error instead of trying to play this game of setting errseq on overlay
> superblock.
> 
> Thanks
> Vivek
> 
If you want to land that in stable, I'm fine with returning an error directly, 
but I'll leave that up to Al and Matthew.

[1]: https://lore.kernel.org/linux-unionfs/CAOQ4uxhra_RB98gJ7ovGhbUV1atCR1rMPnf63tT37WtrNC0asg@mail.gmail.com/T/#u
