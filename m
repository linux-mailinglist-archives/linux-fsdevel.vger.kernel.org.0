Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9BA136882C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Apr 2021 22:46:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237002AbhDVUq7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Apr 2021 16:46:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236877AbhDVUq7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Apr 2021 16:46:59 -0400
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB2CFC06174A
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Apr 2021 13:46:22 -0700 (PDT)
Received: by mail-oo1-xc35.google.com with SMTP id c12-20020a4ae24c0000b02901bad05f40e4so10239469oot.4
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Apr 2021 13:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tyhicks-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4Bv+XfMtee1/MTyZNOdjdOgixMawy7JDR2vEPs37IAs=;
        b=p1pHcSJpaaBUViLXO7+5/68TdLad+WWmAyvu4Lgz9BRJPBCsY8EEExh5q6IaUFTUDl
         KLgVX8aYsApB7mdcj7Vl3HBbPIvh/9GjiGF1v/AjcVwQvQGxQkGtyGojAXyq/tzltVuH
         NBO3muIH0aAem4Zpw6h13ZhRNbLh5Y6l4Vak/6qJiUbTBIaKxArmzi6eHA2sUBVOA/5x
         prsWTTgO1H/KTC3cANhsfGvVl9bzQ2XE//gVb/afBWgQJLxIdMSrsKRZcvgVhautzGTa
         9BPMDmJ+HyLdtlidCWL+xGGHOQRCruWLxpkla7t8/9OtieL8rAJHS01nmSF4RKSQNV3r
         sIoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4Bv+XfMtee1/MTyZNOdjdOgixMawy7JDR2vEPs37IAs=;
        b=Zxnyfwv8tkwbNuuON5kyukXC8tNjTGq8rjhQmdM0dBqhENo/4IdpKtpn47dNZiOl3s
         aVr0dkAzGUM+Mfm1nKcjxQK7dakAnMlFenxCi9dwibHh6NbqCRPIsnYNOxky/J+LrZ09
         tUwU4f2UnGWv/IZXkjllUFK+16OkNHw0GgKKzf1jGOzFoCQNKdUCak6GJk/RX87Vlzoz
         Ey0eGifZyin368Rw27GUxTHD640qeWPTILDfz4XQC8rUegmXTnFif18Tzaf/kASahzB9
         fAAYUd1CIYx6ARA54soW+/VgyoZEFtmwycLx90+GF9nTlxVwJnU7XXhCp9LkZWq4D8/J
         5mjg==
X-Gm-Message-State: AOAM533MFJdadwkECvKuMGSCvbVxDSLTWqZCBiH0RxEevCt+tAIfrdJW
        tF8jQlNvwRNttkzb6oTK/ju4UQ==
X-Google-Smtp-Source: ABdhPJzmhL8nIK8vKoIX2RGd1MQiQW0ejITHTcfESFUOlcdI72u+NKMtCwKidl6IDtgZvLwo/TeMLQ==
X-Received: by 2002:a4a:a44a:: with SMTP id w10mr321536ool.26.1619124382285;
        Thu, 22 Apr 2021 13:46:22 -0700 (PDT)
Received: from sequoia (162-237-133-238.lightspeed.rcsntx.sbcglobal.net. [162.237.133.238])
        by smtp.gmail.com with ESMTPSA id t19sm880823otm.40.2021.04.22.13.46.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Apr 2021 13:46:21 -0700 (PDT)
Date:   Thu, 22 Apr 2021 15:46:20 -0500
From:   Tyler Hicks <code@tyhicks.com>
To:     Christian Brauner <brauner@kernel.org>,
        John Johansen <john.johansen@canonical.com>
Cc:     linux-fsdevel@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        David Howells <dhowells@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>, ecryptfs@vger.kernel.org,
        linux-cachefs@redhat.com,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: Re: [PATCH 6/7] ecryptfs: switch to using a private mount
Message-ID: <20210422204620.GB177816@sequoia>
References: <20210414123750.2110159-1-brauner@kernel.org>
 <20210414123750.2110159-7-brauner@kernel.org>
 <20210419050128.GA405651@elm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210419050128.GA405651@elm>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2021-04-19 00:01:28, Tyler Hicks wrote:
> On 2021-04-14 14:37:50, Christian Brauner wrote:
> > From: Christian Brauner <christian.brauner@ubuntu.com>
> > 
> > Since [1] we support creating private mounts from a given path's
> > vfsmount. This makes them very suitable for any filesystem or
> > filesystem functionality that piggybacks on paths of another filesystem.
> > Overlayfs, cachefiles, and ecryptfs are three prime examples.
> > 
> > Since private mounts aren't attached in the filesystem they aren't
> > affected by mount property changes after ecryptfs makes use of them.
> > This seems a rather desirable property as the underlying path can't e.g.
> > suddenly go from read-write to read-only and in general it means that
> > ecryptfs is always in full control of the underlying mount after the
> > user has allowed it to be used (apart from operations that affect the
> > superblock of course).
> > 
> > Besides that it also makes things simpler for a variety of other vfs
> > features. One concrete example is fanotify. When the path->mnt of the
> > path that is used as a cache has been marked with FAN_MARK_MOUNT the
> > semantics get tricky as it isn't clear whether the watchers of path->mnt
> > should get notified about fsnotify events when files are created by
> > ecryptfs via path->mnt. Using a private mount let's us elegantly
> > handle this case too and aligns the behavior of stacks created by
> > overlayfs and cachefiles.
> > 
> > This change comes with a proper simplification in how ecryptfs currently
> > handles the lower_path it stashes as private information in its
> > dentries. Currently it always does:
> > 
> >         ecryptfs_set_dentry_private(dentry, dentry_info);
> >         dentry_info->lower_path.mnt = mntget(path->mnt);
> >         dentry_info->lower_path.dentry = lower_dentry;
> > 
> > and then during .d_relase() in ecryptfs_d_release():
> > 
> >         path_put(&p->lower_path);
> > 
> > which is odd since afaict path->mnt is guaranteed to be the mnt stashed
> > during ecryptfs_mount():
> > 
> >         ecryptfs_set_dentry_private(s->s_root, root_info);
> >         root_info->lower_path = path;
> > 
> > So that mntget() seems somewhat pointless but there might be reasons
> > that I'm missing in how the interpose logic for ecryptfs works.
> > 
> > While switching to a long-term private mount via clone_private_mount()
> > let's get rid of the gratuitous mntget() and mntput()/path_put().
> > Instead, stash away the private mount in ecryptfs' s_fs_info and call
> > kern_unmount() in .kill_sb() so we only take the mntput() hit once.
> > 
> > I've added a WARN_ON_ONCE() into ecryptfs_lookup_interpose() triggering
> > if the stashed private mount and the path's mount don't match. I think
> > that would be a proper bug even without that clone_private_mount()
> > change in this patch.
> > 
> > [1]: c771d683a62e ("vfs: introduce clone_private_mount()")
> > Cc: Amir Goldstein <amir73il@gmail.com>
> > Cc: Tyler Hicks <code@tyhicks.com>
> > Cc: Miklos Szeredi <mszeredi@redhat.com>
> > Cc: ecryptfs@vger.kernel.org
> > Cc: linux-fsdevel@vger.kernel.org
> > Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
> 
> This patch and the following one both look technically correct to me. I
> do want to spend a little time manually testing these changes, though.
> I'm hoping to have that done by end of day Tuesday.

Hey Christian - I've finished testing these eCryptfs changes. I really
like some of the new properties:

 - As you mentioned, the ability for the lower mount to go read-only and
   not affect the upper mount is nice. I verified this with:
    $ echo foo > /upper/foo
    $ mount -o remount,bind,ro /lower
    $ echo bar > /upper/bar
 - I like that the lower filesystem can be entirely unmounted after the
   eCryptfs mount has been set up. This could be useful if someone
   wanted to prevent tampering with the lower filesystem while the
   eCryptfs mount is active.

Unfortunately, I think there may be temporary a blocker here. eCryptfs'
main user base has historically been Ubuntu users since Ubuntu embraced
it for encrypted home directories years ago. While encrypted home
directories are no longer supported out-of-the-box in new Ubuntu
releases, I suspect that's still the distro that most eCryptfs users use
today.

We know that AppArmor is the default LSM in use in Ubuntu. However,
AppArmor does not know how to handle private mounts. This was most
recently discussed in the unprivileged overlay mounts thread:

 https://lore.kernel.org/linux-security-module/9b8236eb-b3c4-6e0f-edb8-833172c7c2c7@canonical.com/

When an AppArmor confined process is interacting with an eCryptfs mount,
I see disconnected path denials from AppArmor for the lower paths when
your private mount patches are applied:

 audit: type=1400 audit(1619121587.568:50): apparmor="DENIED" operation="open" info="Failed name lookup - disconnected path" error=-13 profile="privatemnt" name="foo" pid=5992 comm="bash" requested_mask="wr" denied_mask="wr" fsuid=1000 ouid=1000

I'd rather wait for AppArmor to better handle private mounts because I
think existing users will definitely see a negative impact from these
changes and I don't think that the positive user-facing impacts outweigh
the negative.

I don't see any related changes in the AppArmor tree but I've cc'ed John
in case he's made any progress here.

Tyler

> Tyler
> 
> > ---
> >  fs/ecryptfs/dentry.c          |  6 +++++-
> >  fs/ecryptfs/ecryptfs_kernel.h |  9 +++++++++
> >  fs/ecryptfs/inode.c           |  5 ++++-
> >  fs/ecryptfs/main.c            | 29 ++++++++++++++++++++++++-----
> >  4 files changed, 42 insertions(+), 7 deletions(-)
> > 
> > diff --git a/fs/ecryptfs/dentry.c b/fs/ecryptfs/dentry.c
> > index 44606f079efb..e5edafa165d4 100644
> > --- a/fs/ecryptfs/dentry.c
> > +++ b/fs/ecryptfs/dentry.c
> > @@ -67,7 +67,11 @@ static void ecryptfs_d_release(struct dentry *dentry)
> >  {
> >  	struct ecryptfs_dentry_info *p = dentry->d_fsdata;
> >  	if (p) {
> > -		path_put(&p->lower_path);
> > +		/*
> > +		 * p->lower_path.mnt is a private mount which will be released
> > +		 * when the superblock shuts down so we only need to dput here.
> > +		 */
> > +		dput(p->lower_path.dentry);
> >  		call_rcu(&p->rcu, ecryptfs_dentry_free_rcu);
> >  	}
> >  }
> > diff --git a/fs/ecryptfs/ecryptfs_kernel.h b/fs/ecryptfs/ecryptfs_kernel.h
> > index e6ac78c62ca4..f89d0f7bb3fe 100644
> > --- a/fs/ecryptfs/ecryptfs_kernel.h
> > +++ b/fs/ecryptfs/ecryptfs_kernel.h
> > @@ -352,6 +352,7 @@ struct ecryptfs_mount_crypt_stat {
> >  struct ecryptfs_sb_info {
> >  	struct super_block *wsi_sb;
> >  	struct ecryptfs_mount_crypt_stat mount_crypt_stat;
> > +	struct vfsmount *mnt;
> >  };
> >  
> >  /* file private data. */
> > @@ -496,6 +497,14 @@ ecryptfs_set_superblock_lower(struct super_block *sb,
> >  	((struct ecryptfs_sb_info *)sb->s_fs_info)->wsi_sb = lower_sb;
> >  }
> >  
> > +static inline void
> > +ecryptfs_set_superblock_lower_mnt(struct super_block *sb,
> > +				  struct vfsmount *mnt)
> > +{
> > +	struct ecryptfs_sb_info *sbi = sb->s_fs_info;
> > +	sbi->mnt = mnt;
> > +}
> > +
> >  static inline struct ecryptfs_dentry_info *
> >  ecryptfs_dentry_to_private(struct dentry *dentry)
> >  {
> > diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
> > index 18e9285fbb4c..204df4bf476d 100644
> > --- a/fs/ecryptfs/inode.c
> > +++ b/fs/ecryptfs/inode.c
> > @@ -324,6 +324,7 @@ static struct dentry *ecryptfs_lookup_interpose(struct dentry *dentry,
> >  				     struct dentry *lower_dentry)
> >  {
> >  	struct path *path = ecryptfs_dentry_to_lower_path(dentry->d_parent);
> > +	struct ecryptfs_sb_info *sb_info = ecryptfs_superblock_to_private(dentry->d_sb);
> >  	struct inode *inode, *lower_inode;
> >  	struct ecryptfs_dentry_info *dentry_info;
> >  	int rc = 0;
> > @@ -339,7 +340,9 @@ static struct dentry *ecryptfs_lookup_interpose(struct dentry *dentry,
> >  	BUG_ON(!d_count(lower_dentry));
> >  
> >  	ecryptfs_set_dentry_private(dentry, dentry_info);
> > -	dentry_info->lower_path.mnt = mntget(path->mnt);
> > +	/* Warn if we somehow ended up with an unexpected path. */
> > +	WARN_ON_ONCE(path->mnt != sb_info->mnt);
> > +	dentry_info->lower_path.mnt = path->mnt;
> >  	dentry_info->lower_path.dentry = lower_dentry;
> >  
> >  	/*
> > diff --git a/fs/ecryptfs/main.c b/fs/ecryptfs/main.c
> > index cdf40a54a35d..3ba2c0f349a3 100644
> > --- a/fs/ecryptfs/main.c
> > +++ b/fs/ecryptfs/main.c
> > @@ -476,6 +476,7 @@ static struct file_system_type ecryptfs_fs_type;
> >  static struct dentry *ecryptfs_mount(struct file_system_type *fs_type, int flags,
> >  			const char *dev_name, void *raw_data)
> >  {
> > +	struct vfsmount *mnt;
> >  	struct super_block *s;
> >  	struct ecryptfs_sb_info *sbi;
> >  	struct ecryptfs_mount_crypt_stat *mount_crypt_stat;
> > @@ -537,6 +538,16 @@ static struct dentry *ecryptfs_mount(struct file_system_type *fs_type, int flags
> >  		goto out_free;
> >  	}
> >  
> > +	mnt = clone_private_mount(&path);
> > +	if (IS_ERR(mnt)) {
> > +		rc = PTR_ERR(mnt);
> > +		pr_warn("Failed to create private mount for ecryptfs\n");
> > +		goto out_free;
> > +	}
> > +
> > +	/* Record our long-term lower mount. */
> > +	ecryptfs_set_superblock_lower_mnt(s, mnt);
> > +
> >  	if (check_ruid && !uid_eq(d_inode(path.dentry)->i_uid, current_uid())) {
> >  		rc = -EPERM;
> >  		printk(KERN_ERR "Mount of device (uid: %d) not owned by "
> > @@ -590,9 +601,15 @@ static struct dentry *ecryptfs_mount(struct file_system_type *fs_type, int flags
> >  	if (!root_info)
> >  		goto out_free;
> >  
> > +	/* Use our private mount from now on. */
> > +	root_info->lower_path.mnt = mnt;
> > +	root_info->lower_path.dentry = dget(path.dentry);
> > +
> > +	/* We created a private clone of this mount above so drop the path. */
> > +	path_put(&path);
> > +
> >  	/* ->kill_sb() will take care of root_info */
> >  	ecryptfs_set_dentry_private(s->s_root, root_info);
> > -	root_info->lower_path = path;
> >  
> >  	s->s_flags |= SB_ACTIVE;
> >  	return dget(s->s_root);
> > @@ -619,11 +636,13 @@ static struct dentry *ecryptfs_mount(struct file_system_type *fs_type, int flags
> >  static void ecryptfs_kill_block_super(struct super_block *sb)
> >  {
> >  	struct ecryptfs_sb_info *sb_info = ecryptfs_superblock_to_private(sb);
> > +
> >  	kill_anon_super(sb);
> > -	if (!sb_info)
> > -		return;
> > -	ecryptfs_destroy_mount_crypt_stat(&sb_info->mount_crypt_stat);
> > -	kmem_cache_free(ecryptfs_sb_info_cache, sb_info);
> > +	if (sb_info) {
> > +		kern_unmount(sb_info->mnt);
> > +		ecryptfs_destroy_mount_crypt_stat(&sb_info->mount_crypt_stat);
> > +		kmem_cache_free(ecryptfs_sb_info_cache, sb_info);
> > +	}
> >  }
> >  
> >  static struct file_system_type ecryptfs_fs_type = {
> > -- 
> > 2.27.0
> > 
