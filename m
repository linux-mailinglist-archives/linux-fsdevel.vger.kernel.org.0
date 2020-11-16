Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F201E2B4D8F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Nov 2020 18:39:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387603AbgKPRil (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Nov 2020 12:38:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387596AbgKPRii (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Nov 2020 12:38:38 -0500
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C30FC0613CF
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Nov 2020 09:38:37 -0800 (PST)
Received: by mail-io1-xd44.google.com with SMTP id t8so18221680iov.8
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Nov 2020 09:38:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UFRIEcps9ffTa4CcIxjGcATNp7aDan0PdmErUPp+Wmo=;
        b=ZN4vrm1b1A/uzZvmabpjMyzAtbqfqgBu1C8klIA6oeDvMWpC+KnANTIoG8HFYDrLkC
         kciiZ7xV0sqx6pJDvKH8XcTCh2cYya2DgD4gTx5ne1PEcTuoqW7niixUQ9BgvlhJ0x9T
         knLpd1NIYLX7m6ed1XqKat6ZFgHjZleO2U7us=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UFRIEcps9ffTa4CcIxjGcATNp7aDan0PdmErUPp+Wmo=;
        b=OwpQVAVUyJohZwKAKnRw3718ICw0QQlysnJHJ5yDVsiC1kmJpxyEKKierZEdOHoRUy
         cB3gjYkw+YljfCUQvA5oXQTUVvLttJYkrO/khjvZyn2CuCdYqoCvQkB4P++FSiNhhcz9
         69JNU+uMnITfgpbBfDIeUmsME3+s4I71sa3Zu1zxLrScSbIkpPXNsK0uk7vhfijbvWnU
         tVCYd4Yo1rXcF4N4m+byCLFlemKL+pEI/p4PdHEj4lXK+KfcZ3RfEjDRh0cTiSLC5Xol
         aUi7Z1oTz5l4mpiAarzoJma/2myc+peyAiCgNWRBcFlN6Uj+HW631pJe9+HRTIihHxpI
         0e8g==
X-Gm-Message-State: AOAM532zfULlRpWab9lS95uvvpJ+/wxscexz2tsMCgg2eB6HQURx4DOy
        MGWSHxl+vWqw3KxV1otGKwPO+A==
X-Google-Smtp-Source: ABdhPJxXX18B4iXXqQ6TLy6j9amKiLZpmPuZ1jYKA1+vYBV0fz9uEbmgMseOjdwIO2RqmgHL1GIEgA==
X-Received: by 2002:a6b:6610:: with SMTP id a16mr8901069ioc.193.1605548316578;
        Mon, 16 Nov 2020 09:38:36 -0800 (PST)
Received: from ircssh-2.c.rugged-nimbus-611.internal (80.60.198.104.bc.googleusercontent.com. [104.198.60.80])
        by smtp.gmail.com with ESMTPSA id l4sm9863212ioj.41.2020.11.16.09.38.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 16 Nov 2020 09:38:35 -0800 (PST)
Date:   Mon, 16 Nov 2020 17:38:34 +0000
From:   Sargun Dhillon <sargun@sargun.me>
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     linux-unionfs@vger.kernel.org, miklos@szeredi.hu,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Daniel J Walsh <dwalsh@redhat.com>,
        David Howells <dhowells@redhat.com>,
        linux-fsdevel@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>
Subject: Re: [RFC PATCH 3/3] overlay: Add the ability to remount volatile
 directories when safe
Message-ID: <20201116173833.GA18698@ircssh-2.c.rugged-nimbus-611.internal>
References: <20201116045758.21774-1-sargun@sargun.me>
 <20201116045758.21774-4-sargun@sargun.me>
 <20201116144240.GA9190@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201116144240.GA9190@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 16, 2020 at 09:42:40AM -0500, Vivek Goyal wrote:
> On Sun, Nov 15, 2020 at 08:57:58PM -0800, Sargun Dhillon wrote:
> > Overlayfs added the ability to setup mounts where all syncs could be
> > short-circuted in (2a99ddacee43: ovl: provide a mount option "volatile").
> > 
> > A user might want to remount this fs, but we do not let the user because
> > of the "incompat" detection feature. In the case of volatile, it is safe
> > to do something like[1]:
> > 
> > $ sync -f /root/upperdir
> > $ rm -rf /root/workdir/incompat/volatile
> > 
> > There are two ways to go about this. You can call sync on the underlying
> > filesystem, check the error code, and delete the dirty file if everything
> > is clean. If you're running lots of containers on the same filesystem, or
> > you want to avoid all unnecessary I/O, this may be suboptimal.
> > 
> 
> Hi Sargun,
> 
> I had asked bunch of questions in previous mail thread to be more
> clear on your requirements but never got any response. It would
> have helped understanding your requirements better.
> 
Sorry, I didn't see your questions.


> How about following patch set which seems to sync only dirty inodes of
> upper belonging to a particular overlayfs instance.
> 
> https://lore.kernel.org/linux-unionfs/20201113065555.147276-1-cgxu519@mykernel.net/
> 
> So if could implement a mount option which ignores fsync but upon
> syncfs, only syncs dirty inodes of that overlayfs instance, it will
> make sure we are not syncing whole of the upper fs. And we could
> do this syncing on unmount of overlayfs and remove dirty file upon
> successful sync.
> 
Doing any kind of sync that involves a head-of-line blocking metadata flush,
or even data flush causes significan problems on our systems. We at some 
point did some analysis on systems in our fleet that did sync and noticed
that it has a very suboptimal effect on system-wide performance because
the sudden rush of IOPs caused our drives to stall.

I didn't dig too much into it, but on XFS, even letting users do sync
directly on their inodes could lead to trouble in terms of the spurious
burst of IOPs generated. Even though our drives can sustain a large amount
of I/O over time, a sudden burst causes our cloud provider to throttle them,
which in turn can lead to slow I/O across the system, and depending on what's
going on, this can turn into WQ stalls.

> Looks like this will be much simpler method and should be able to
> meet your requirements (As long as you are fine with syncing dirty
> upper inodes of this overlay instance on unmount).
> 
> Thanks
> Vivek
> 
> > Alternatively, you can blindly delete the dirty file, and "hope for the
> > best".
> > 
> > This patch introduces transparent functionality to check if it is
> > (relatively) safe to reuse the upperdir. It ensures that the filesystem
> > hasn't been remounted, the system hasn't been rebooted, nor has the
> > overlayfs code changed. It also checks the errseq on the superblock
> > indicating if there have been any writeback errors since the previous
> > mount. Currently, this information is not directly exposed to userspace, so
> > the user cannot make decisions based on this. Instead we checkpoint
> > this information to disk, and upon remount we see if any of it has
> > changed. Since the structure is explicitly not meant to be used
> > between different versions of the code, its stability does not
> > matter so much.
> 
> > [1]: https://lore.kernel.org/linux-unionfs/CAOQ4uxhKr+j5jFyEC2gJX8E8M19mQ3CqdTYaPZOvDQ9c0qLEzw@mail.gmail.com/T/#m6abe713e4318202ad57f301bf28a414e1d824f9c
> > 
> > Signed-off-by: Sargun Dhillon <sargun@sargun.me>
> > Cc: linux-fsdevel@vger.kernel.org
> > Cc: linux-unionfs@vger.kernel.org
> > Cc: Miklos Szeredi <miklos@szeredi.hu>
> > Cc: Amir Goldstein <amir73il@gmail.com>
> > ---
> >  Documentation/filesystems/overlayfs.rst |  5 +-
> >  fs/overlayfs/overlayfs.h                | 34 ++++++++++
> >  fs/overlayfs/readdir.c                  | 86 +++++++++++++++++++++++--
> >  fs/overlayfs/super.c                    | 22 ++++++-
> >  4 files changed, 139 insertions(+), 8 deletions(-)
> > 
> > diff --git a/Documentation/filesystems/overlayfs.rst b/Documentation/filesystems/overlayfs.rst
> > index 580ab9a0fe31..fa3faeeab727 100644
> > --- a/Documentation/filesystems/overlayfs.rst
> > +++ b/Documentation/filesystems/overlayfs.rst
> > @@ -581,7 +581,10 @@ checks for this directory and refuses to mount if present. This is a strong
> >  indicator that user should throw away upper and work directories and create
> >  fresh one. In very limited cases where the user knows that the system has
> >  not crashed and contents of upperdir are intact, The "volatile" directory
> > -can be removed.
> > +can be removed.  In certain cases it the filesystem can detect that the
> > +upperdir can be reused safely, and it will not require the user to
> > +manually delete the volatile directory.
> > +
> >  
> >  Testsuite
> >  ---------
> > diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
> > index 9eb911f243e1..980d2c930f7a 100644
> > --- a/fs/overlayfs/overlayfs.h
> > +++ b/fs/overlayfs/overlayfs.h
> > @@ -30,6 +30,11 @@ enum ovl_path_type {
> >  #define OVL_XATTR_NLINK OVL_XATTR_PREFIX "nlink"
> >  #define OVL_XATTR_UPPER OVL_XATTR_PREFIX "upper"
> >  #define OVL_XATTR_METACOPY OVL_XATTR_PREFIX "metacopy"
> > +#define OVL_XATTR_VOLATILE OVL_XATTR_PREFIX "volatile"
> > +
> > +#define OVL_INCOMPATDIR_NAME "incompat"
> > +#define OVL_VOLATILEDIR_NAME "volatile"
> > +#define OVL_VOLATILE_DIRTY_NAME "dirty"
> >  
> >  enum ovl_inode_flag {
> >  	/* Pure upper dir that may contain non pure upper entries */
> > @@ -54,6 +59,32 @@ enum {
> >  	OVL_XINO_ON,
> >  };
> >  
> > +/*
> > + * This is copied into the volatile xattr, and the user does not interact with
> > + * it. There is no stability requirement, as a reboot explicitly invalidates
> > + * a volatile workdir. It is explicitly meant not to be a stable api.
> > + *
> > + * Although this structure isn't meant to be stable it is exposed to potentially
> > + * unprivileged users. We don't do any kind of cryptographic operations with
> > + * the structure, so it could be tampered with, or inspected. Don't put
> > + * kernel memory pointers in it, or anything else that could cause problems,
> > + * or information disclosure.
> > + */
> > +struct overlay_volatile_info {
> > +	/*
> > +	 * This uniquely identifies a boot, and is reset if overlayfs itself
> > +	 * is reloaded. Therefore we check our current / known boot_id
> > +	 * against this before looking at any other fields to validate:
> > +	 * 1. Is this datastructure laid out in the way we expect? (Overlayfs
> > +	 *    module, reboot, etc...)
> > +	 * 2. Could something have changed (like the s_instance_id counter
> > +	 *    resetting)
> > +	 */
> > +	uuid_t		overlay_boot_id;
> > +	u64		s_instance_id;
> > +	errseq_t	errseq; /* Just a u32 */
> > +} __packed;
> > +
> >  /*
> >   * The tuple (fh,uuid) is a universal unique identifier for a copy up origin,
> >   * where:
> > @@ -501,3 +532,6 @@ int ovl_set_origin(struct dentry *dentry, struct dentry *lower,
> >  
> >  /* export.c */
> >  extern const struct export_operations ovl_export_operations;
> > +
> > +/* super.c */
> > +extern uuid_t overlay_boot_id;
> > diff --git a/fs/overlayfs/readdir.c b/fs/overlayfs/readdir.c
> > index f8cc15533afa..ee0d2b88a19c 100644
> > --- a/fs/overlayfs/readdir.c
> > +++ b/fs/overlayfs/readdir.c
> > @@ -1054,7 +1054,84 @@ int ovl_check_d_type_supported(struct path *realpath)
> >  	return rdd.d_type_supported;
> >  }
> >  
> > -#define OVL_INCOMPATDIR_NAME "incompat"
> > +static int ovl_check_incompat_volatile(struct ovl_cache_entry *p,
> > +				       struct path *path)
> > +{
> > +	int err, ret = -EINVAL;
> > +	struct overlay_volatile_info info;
> > +	struct dentry *d_volatile, *d_dirty;
> > +
> > +	d_volatile = lookup_one_len(p->name, path->dentry, p->len);
> > +	if (IS_ERR(d_volatile))
> > +		return PTR_ERR(d_volatile);
> > +
> > +	inode_lock_nested(d_volatile->d_inode, I_MUTEX_PARENT);
> > +	d_dirty = lookup_one_len(OVL_VOLATILE_DIRTY_NAME, d_volatile,
> > +				 strlen(OVL_VOLATILE_DIRTY_NAME));
> > +	if (IS_ERR(d_dirty)) {
> > +		err = PTR_ERR(d_dirty);
> > +		if (err != -ENOENT)
> > +			ret = err;
> > +		goto out_putvolatile;
> > +	}
> > +
> > +	if (!d_dirty->d_inode)
> > +		goto out_putdirty;
> > +
> > +	inode_lock_nested(d_dirty->d_inode, I_MUTEX_XATTR);
> > +	err = ovl_do_getxattr(d_dirty, OVL_XATTR_VOLATILE, &info, sizeof(info));
> > +	inode_unlock(d_dirty->d_inode);
> > +	if (err != sizeof(info))
> > +		goto out_putdirty;
> > +
> > +	if (!uuid_equal(&overlay_boot_id, &info.overlay_boot_id)) {
> > +		pr_debug("boot id has changed (reboot or module reloaded)\n");
> > +		goto out_putdirty;
> > +	}
> > +
> > +	if (d_dirty->d_inode->i_sb->s_instance_id != info.s_instance_id) {
> > +		pr_debug("workdir has been unmounted and remounted\n");
> > +		goto out_putdirty;
> > +	}
> > +
> > +	err = errseq_check(&d_dirty->d_inode->i_sb->s_wb_err, info.errseq);
> > +	if (err) {
> > +		pr_debug("workdir dir has experienced errors: %d\n", err);
> > +		goto out_putdirty;
> > +	}
> > +
> > +	/* Dirty file is okay, delete it. */
> > +	ret = ovl_do_unlink(d_volatile->d_inode, d_dirty);
> > +
> > +out_putdirty:
> > +	dput(d_dirty);
> > +out_putvolatile:
> > +	inode_unlock(d_volatile->d_inode);
> > +	dput(d_volatile);
> > +	return ret;
> > +}
> > +
> > +/*
> > + * check_incompat checks this specific incompat entry for incompatibility.
> > + * If it is found to be incompatible -EINVAL will be returned.
> > + *
> > + * Any other -errno indicates an unknown error, and filesystem mounting
> > + * should be aborted.
> > + */
> > +static int ovl_check_incompat(struct ovl_cache_entry *p, struct path *path)
> > +{
> > +	int err = -EINVAL;
> > +
> > +	if (!strcmp(p->name, OVL_VOLATILEDIR_NAME))
> > +		err = ovl_check_incompat_volatile(p, path);
> > +
> > +	if (err == -EINVAL)
> > +		pr_err("incompat feature '%s' cannot be mounted\n", p->name);
> > +	else
> > +		pr_debug("incompat '%s' handled: %d\n", p->name, err);
> > +
> > +	return err;
> > +}
> >  
> >  static int ovl_workdir_cleanup_recurse(struct path *path, int level)
> >  {
> > @@ -1098,10 +1175,9 @@ static int ovl_workdir_cleanup_recurse(struct path *path, int level)
> >  			if (p->len == 2 && p->name[1] == '.')
> >  				continue;
> >  		} else if (incompat) {
> > -			pr_err("overlay with incompat feature '%s' cannot be mounted\n",
> > -				p->name);
> > -			err = -EINVAL;
> > -			break;
> > +			err = ovl_check_incompat(p, path);
> > +			if (err)
> > +				break;
> >  		}
> >  		dentry = lookup_one_len(p->name, path->dentry, p->len);
> >  		if (IS_ERR(dentry))
> > diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
> > index 2ee0ba16cc7b..94980898009f 100644
> > --- a/fs/overlayfs/super.c
> > +++ b/fs/overlayfs/super.c
> > @@ -15,6 +15,7 @@
> >  #include <linux/seq_file.h>
> >  #include <linux/posix_acl_xattr.h>
> >  #include <linux/exportfs.h>
> > +#include <linux/uuid.h>
> >  #include "overlayfs.h"
> >  
> >  MODULE_AUTHOR("Miklos Szeredi <miklos@szeredi.hu>");
> > @@ -23,6 +24,7 @@ MODULE_LICENSE("GPL");
> >  
> >  
> >  struct ovl_dir_cache;
> > +uuid_t overlay_boot_id;
> >  
> >  #define OVL_MAX_STACK 500
> >  
> > @@ -1246,20 +1248,35 @@ static struct dentry *ovl_lookup_or_create(struct dentry *parent,
> >   */
> >  static int ovl_create_volatile_dirty(struct ovl_fs *ofs)
> >  {
> > +	int err;
> >  	unsigned int ctr;
> >  	struct dentry *d = dget(ofs->workbasedir);
> >  	static const char *const volatile_path[] = {
> > -		OVL_WORKDIR_NAME, "incompat", "volatile", "dirty"
> > +		OVL_WORKDIR_NAME,
> > +		OVL_INCOMPATDIR_NAME,
> > +		OVL_VOLATILEDIR_NAME,
> > +		OVL_VOLATILE_DIRTY_NAME,
> >  	};
> >  	const char *const *name = volatile_path;
> > +	struct overlay_volatile_info info = {};
> >  
> >  	for (ctr = ARRAY_SIZE(volatile_path); ctr; ctr--, name++) {
> >  		d = ovl_lookup_or_create(d, *name, ctr > 1 ? S_IFDIR : S_IFREG);
> >  		if (IS_ERR(d))
> >  			return PTR_ERR(d);
> >  	}
> > +
> > +	uuid_copy(&info.overlay_boot_id, &overlay_boot_id);
> > +	info.s_instance_id = d->d_inode->i_sb->s_instance_id;
> > +	info.errseq = errseq_sample(&d->d_inode->i_sb->s_wb_err);
> > +
> > +
> > +	err = ovl_do_setxattr(d, OVL_XATTR_VOLATILE, &info, sizeof(info), 0);
> > +	if (err == -EOPNOTSUPP)
> > +		err = 0;
> > +
> >  	dput(d);
> > -	return 0;
> > +	return err;
> >  }
> >  
> >  static int ovl_make_workdir(struct super_block *sb, struct ovl_fs *ofs,
> > @@ -2045,6 +2062,7 @@ static int __init ovl_init(void)
> >  {
> >  	int err;
> >  
> > +	uuid_gen(&overlay_boot_id);
> >  	ovl_inode_cachep = kmem_cache_create("ovl_inode",
> >  					     sizeof(struct ovl_inode), 0,
> >  					     (SLAB_RECLAIM_ACCOUNT|
> > -- 
> > 2.25.1
> > 
> 
