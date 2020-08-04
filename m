Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A40423B8D2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Aug 2020 12:33:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728793AbgHDKdk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Aug 2020 06:33:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728170AbgHDKdj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Aug 2020 06:33:39 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 886F4C061757
        for <linux-fsdevel@vger.kernel.org>; Tue,  4 Aug 2020 03:33:39 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id l4so41775400ejd.13
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Aug 2020 03:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7OdZPdzwSvHqm7g1yE57slREGh+EjSxFCsqpvTzonbk=;
        b=ADWwdFbGWs4B/ikeUd3/W3NjqmaGTrpwY2+qPXtasVwoEydz3WHJxkYqeQsEvrSLT5
         BpsHhDs719A33JO9W123zhpsOHv8eWh98CSfIfmdxsBpN/6RUpaOEypJLwFHZ/8PyoXf
         zYLxSQmcy4jgUCeZKSYMdg97iheD2DqNjfQ2A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7OdZPdzwSvHqm7g1yE57slREGh+EjSxFCsqpvTzonbk=;
        b=iQm4savYQpSWRcdJy2LtLvqY3Nfh8NxuzMiN5s85nsXPQ6t/kkNYFLCHB0mp3wbpsT
         M6TqZl5/FO0omm23D1KaW3xRyEiCEeNQYs5ihBo5KZR6SjYzbTe2u7VSnF8FfOcDnb9h
         EhuTP+7tqc4+Efg7hUCewr8PO/YdZOztn15B2ukCK5kyGVTz3fylWe0zwViI1PSZ8OEW
         y2+3KlapyM9KCDW3/Amwf7g7FN2wS+ieUifq46HT8F5Zpqdh7edCdb1gPxk22c/FCz+L
         NCcrDm9NhYHGB2jr+NS2zNMdsqcrqt57FmBUV1ohDZ+8ctRuE7ZBPE2P2dJthDOT3AGE
         Ri/Q==
X-Gm-Message-State: AOAM532gbM4ZPn2Zg/qxh+EJHefAW9+IUUtblD7dY/QKu+RLHC2FYmle
        EfsOji6uKOWnQkx/QXwFN+6Ppw==
X-Google-Smtp-Source: ABdhPJwVqE32WvMqnbbzWhUokykbnLig/Ij4fLqiT+LpYqVwVytsRaB4rbhqvyAT2rGIY81cpLkLoQ==
X-Received: by 2002:a17:906:95d4:: with SMTP id n20mr21851381ejy.485.1596537218076;
        Tue, 04 Aug 2020 03:33:38 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (94-21-100-63.pool.digikabel.hu. [94.21.100.63])
        by smtp.gmail.com with ESMTPSA id lj26sm7464319ejb.26.2020.08.04.03.33.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2020 03:33:37 -0700 (PDT)
Date:   Tue, 4 Aug 2020 12:33:35 +0200
From:   Miklos Szeredi <miklos@szeredi.hu>
To:     David Howells <dhowells@redhat.com>
Cc:     viro@zeniv.linux.org.uk, torvalds@linux-foundation.org,
        raven@themaw.net, mszeredi@redhat.com, christian@brauner.io,
        jannh@google.com, darrick.wong@oracle.com, kzak@redhat.com,
        jlayton@redhat.com, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/18] fsinfo: Allow fsinfo() to look up a mount object
 by ID [ver #21]
Message-ID: <20200804103335.GB32719@miu.piliscsaba.redhat.com>
References: <159646178122.1784947.11705396571718464082.stgit@warthog.procyon.org.uk>
 <159646182832.1784947.10440560370840683639.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <159646182832.1784947.10440560370840683639.stgit@warthog.procyon.org.uk>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 03, 2020 at 02:37:08PM +0100, David Howells wrote:
> Allow the fsinfo() syscall to look up a mount object by ID rather than by
> pathname.  This is necessary as there can be multiple mounts stacked up at
> the same pathname and there's no way to look through them otherwise.
> 
> This is done by passing FSINFO_FLAGS_QUERY_MOUNT to fsinfo() in the
> parameters and then passing the mount ID as a string to fsinfo() in place
> of the filename:
> 
> 	struct fsinfo_params params = {
> 		.flags	 = FSINFO_FLAGS_QUERY_MOUNT,
> 		.request = FSINFO_ATTR_IDS,
> 	};
> 
> 	ret = fsinfo(AT_FDCWD, "21", &params, buffer, sizeof(buffer));
> 
> The caller is only permitted to query a mount object if the root directory
> of that mount connects directly to the current chroot if dfd == AT_FDCWD[*]
> or the directory specified by dfd otherwise.  Note that this is not
> available to the pathwalk of any other syscall.
> 
> [*] This needs to be something other than AT_FDCWD, perhaps AT_FDROOT.
> 
> [!] This probably needs an LSM hook.
> 
> [!] This might want to check the permissions on all the intervening dirs -
>     but it would have to do that under RCU conditions.
> 
> [!] This might want to check a CAP_* flag.

Was this reviewed by security folks?

> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> ---
> 
>  fs/fsinfo.c                 |   53 +++++++++++++++++++
>  fs/internal.h               |    1 
>  fs/namespace.c              |  117 ++++++++++++++++++++++++++++++++++++++++++-
>  include/uapi/linux/fsinfo.h |    1 
>  samples/vfs/test-fsinfo.c   |    7 ++-
>  5 files changed, 175 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/fsinfo.c b/fs/fsinfo.c
> index aef7a736e8fc..8ccbcddb4f16 100644
> --- a/fs/fsinfo.c
> +++ b/fs/fsinfo.c
> @@ -563,6 +563,56 @@ static int vfs_fsinfo_fd(unsigned int fd, struct fsinfo_context *ctx)
>  	return ret;
>  }
>  
> +/*
> + * Look up the root of a mount object.  This allows access to mount objects
> + * (and their attached superblocks) that can't be retrieved by path because
> + * they're entirely covered.
> + *
> + * We only permit access to a mount that has a direct path between either the
> + * dentry pointed to by dfd or to our chroot (if dfd is AT_FDCWD).
> + */
> +static int vfs_fsinfo_mount(int dfd, const char __user *filename,
> +			    struct fsinfo_context *ctx)
> +{
> +	struct path path;
> +	struct fd f = {};
> +	char *name;
> +	unsigned long mnt_id;
> +	int ret;
> +
> +	if (!filename)
> +		return -EINVAL;
> +
> +	name = strndup_user(filename, 32);
> +	if (IS_ERR(name))
> +		return PTR_ERR(name);
> +	ret = kstrtoul(name, 0, &mnt_id);
> +	if (ret < 0)
> +		goto out_name;
> +	if (mnt_id > INT_MAX)
> +		goto out_name;
> +
> +	if (dfd != AT_FDCWD) {
> +		ret = -EBADF;
> +		f = fdget_raw(dfd);
> +		if (!f.file)
> +			goto out_name;
> +	}
> +
> +	ret = lookup_mount_object(f.file ? &f.file->f_path : NULL,
> +				  mnt_id, &path);
> +	if (ret < 0)
> +		goto out_fd;
> +
> +	ret = vfs_fsinfo(&path, ctx);
> +	path_put(&path);
> +out_fd:
> +	fdput(f);
> +out_name:
> +	kfree(name);
> +	return ret;
> +}
> +
>  /**
>   * sys_fsinfo - System call to get filesystem information
>   * @dfd: Base directory to pathwalk from or fd referring to filesystem.
> @@ -636,6 +686,9 @@ SYSCALL_DEFINE6(fsinfo,
>  			return -EINVAL;
>  		ret = vfs_fsinfo_fd(dfd, &ctx);
>  		break;
> +	case FSINFO_FLAGS_QUERY_MOUNT:
> +		ret = vfs_fsinfo_mount(dfd, pathname, &ctx);
> +		break;
>  	default:
>  		return -EINVAL;
>  	}
> diff --git a/fs/internal.h b/fs/internal.h
> index 0b57da498f06..84bbb743a5ac 100644
> --- a/fs/internal.h
> +++ b/fs/internal.h
> @@ -89,6 +89,7 @@ extern int __mnt_want_write_file(struct file *);
>  extern void __mnt_drop_write_file(struct file *);
>  
>  extern void dissolve_on_fput(struct vfsmount *);
> +extern int lookup_mount_object(struct path *, unsigned int, struct path *);
>  extern int fsinfo_generic_mount_source(struct path *, struct fsinfo_context *);
>  
>  /*
> diff --git a/fs/namespace.c b/fs/namespace.c
> index ead8d1a16610..b2b9920ffd3c 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -64,7 +64,7 @@ static int __init set_mphash_entries(char *str)
>  __setup("mphash_entries=", set_mphash_entries);
>  
>  static u64 event;
> -static DEFINE_IDA(mnt_id_ida);
> +static DEFINE_IDR(mnt_id_ida);
>  static DEFINE_IDA(mnt_group_ida);
>  
>  static struct hlist_head *mount_hashtable __read_mostly;
> @@ -105,17 +105,27 @@ static inline struct hlist_head *mp_hash(struct dentry *dentry)
>  
>  static int mnt_alloc_id(struct mount *mnt)
>  {
> -	int res = ida_alloc(&mnt_id_ida, GFP_KERNEL);
> +	int res;
>  
> +	/* Allocate an ID, but don't set the pointer back to the mount until
> +	 * later, as once we do that, we have to follow RCU protocols to get
> +	 * rid of the mount struct.
> +	 */
> +	res = idr_alloc(&mnt_id_ida, NULL, 0, INT_MAX, GFP_KERNEL);

This needs to be a separate patch.

>  	if (res < 0)
>  		return res;
>  	mnt->mnt_id = res;
>  	return 0;
>  }
>  
> +static void mnt_publish_id(struct mount *mnt)
> +{
> +	idr_replace(&mnt_id_ida, mnt, mnt->mnt_id);
> +}
> +
>  static void mnt_free_id(struct mount *mnt)
>  {
> -	ida_free(&mnt_id_ida, mnt->mnt_id);
> +	idr_remove(&mnt_id_ida, mnt->mnt_id);
>  }
>  
>  /*
> @@ -975,6 +985,7 @@ struct vfsmount *vfs_create_mount(struct fs_context *fc)
>  	lock_mount_hash();
>  	list_add_tail(&mnt->mnt_instance, &mnt->mnt.mnt_sb->s_mounts);
>  	unlock_mount_hash();
> +	mnt_publish_id(mnt);
>  	return &mnt->mnt;
>  }
>  EXPORT_SYMBOL(vfs_create_mount);
> @@ -1068,6 +1079,7 @@ static struct mount *clone_mnt(struct mount *old, struct dentry *root,
>  	lock_mount_hash();
>  	list_add_tail(&mnt->mnt_instance, &sb->s_mounts);
>  	unlock_mount_hash();
> +	mnt_publish_id(mnt);
>  
>  	if ((flag & CL_SLAVE) ||
>  	    ((flag & CL_SHARED_TO_SLAVE) && IS_MNT_SHARED(old))) {
> @@ -4151,4 +4163,103 @@ int fsinfo_generic_mount_source(struct path *path, struct fsinfo_context *ctx)
>  	return m.count + 1;
>  }
>  
> +/*
> + * See if one path point connects directly to another by ancestral relationship
> + * across mountpoints.  Must call with the RCU read lock held.
> + */
> +static bool are_paths_connected(struct path *ancestor, struct path *to_check)
> +{
> +	struct mount *mnt, *parent;
> +	struct path cursor;
> +	unsigned seq;
> +	bool connected;
> +
> +	seq = 0;
> +restart:
> +	cursor = *to_check;
> +
> +	read_seqbegin_or_lock(&rename_lock, &seq);
> +	while (cursor.mnt != ancestor->mnt) {
> +		mnt = real_mount(cursor.mnt);
> +		parent = READ_ONCE(mnt->mnt_parent);
> +		if (mnt == parent)
> +			goto failed;
> +		cursor.dentry = READ_ONCE(mnt->mnt_mountpoint);
> +		cursor.mnt = &parent->mnt;
> +	}
> +
> +	while (cursor.dentry != ancestor->dentry) {
> +		if (cursor.dentry == cursor.mnt->mnt_root ||
> +		    IS_ROOT(cursor.dentry))
> +			goto failed;
> +		cursor.dentry = READ_ONCE(cursor.dentry->d_parent);
> +	}
> +
> +	connected = true;
> +out:
> +	done_seqretry(&rename_lock, seq);
> +	return connected;
> +
> +failed:
> +	if (need_seqretry(&rename_lock, seq)) {
> +		seq = 1;
> +		goto restart;
> +	}
> +	connected = false;
> +	goto out;
> +}
> +
> +/**
> + * lookup_mount_object - Look up a vfsmount object by ID
> + * @root: The mount root must connect backwards to this point (or chroot if NULL).
> + * @id: The ID of the mountpoint.
> + * @_mntpt: Where to return the resulting mountpoint path.
> + *
> + * Look up the root of the mount with the corresponding ID.  This is only
> + * permitted if that mount connects directly to the specified root/chroot.
> + */
> +int lookup_mount_object(struct path *root, unsigned int mnt_id, struct path *_mntpt)
> +{
> +	struct mount *mnt;
> +	struct path stop, mntpt = {};
> +	int ret = -EPERM;
> +
> +	if (!root)
> +		get_fs_root(current->fs, &stop);
> +	else
> +		stop = *root;
> +
> +	rcu_read_lock();
> +	lock_mount_hash();
> +	mnt = idr_find(&mnt_id_ida, mnt_id);
> +	if (!mnt)
> +		goto out_unlock_mh;
> +	if (mnt->mnt.mnt_flags & (MNT_SYNC_UMOUNT | MNT_UMOUNT | MNT_DOOMED))
> +		goto out_unlock_mh;
> +	if (mnt_get_count(mnt) == 0)
> +		goto out_unlock_mh;
> +	mnt_add_count(mnt, 1);
> +	mntpt.mnt = &mnt->mnt;
> +	mntpt.dentry = dget(mnt->mnt.mnt_root);
> +	unlock_mount_hash();
> +
> +	if (are_paths_connected(&stop, &mntpt)) {
> +		*_mntpt = mntpt;
> +		mntpt.mnt = NULL;
> +		mntpt.dentry = NULL;
> +		ret = 0;
> +	}
> +
> +out_unlock:
> +	rcu_read_unlock();
> +	if (!root)
> +		path_put(&stop);
> +	path_put(&mntpt);
> +	return ret;
> +
> +out_unlock_mh:
> +	unlock_mount_hash();
> +	goto out_unlock;
> +}
> +
>  #endif /* CONFIG_FSINFO */
> diff --git a/include/uapi/linux/fsinfo.h b/include/uapi/linux/fsinfo.h
> index a27e92b68266..d24e47762a07 100644
> --- a/include/uapi/linux/fsinfo.h
> +++ b/include/uapi/linux/fsinfo.h
> @@ -44,6 +44,7 @@ struct fsinfo_params {
>  #define FSINFO_FLAGS_QUERY_MASK	0x0007 /* What object should fsinfo() query? */
>  #define FSINFO_FLAGS_QUERY_PATH	0x0000 /* - path, specified by dirfd,pathname,AT_EMPTY_PATH */
>  #define FSINFO_FLAGS_QUERY_FD	0x0001 /* - fd specified by dirfd */
> +#define FSINFO_FLAGS_QUERY_MOUNT 0x0002	/* - mount object (path=>mount_id, dirfd=>subtree) */
>  	__u32	request;	/* ID of requested attribute */
>  	__u32	Nth;		/* Instance of it (some may have multiple) */
>  	__u32	Mth;		/* Subinstance of Nth instance */
> diff --git a/samples/vfs/test-fsinfo.c b/samples/vfs/test-fsinfo.c
> index 634f30b7e67f..dfa44bba8bbd 100644
> --- a/samples/vfs/test-fsinfo.c
> +++ b/samples/vfs/test-fsinfo.c
> @@ -593,7 +593,7 @@ int main(int argc, char **argv)
>  	bool meta = false;
>  	int raw = 0, opt, Nth, Mth;
>  
> -	while ((opt = getopt(argc, argv, "Madlr"))) {
> +	while ((opt = getopt(argc, argv, "Madmlr"))) {
>  		switch (opt) {
>  		case 'M':
>  			meta = true;
> @@ -609,6 +609,10 @@ int main(int argc, char **argv)
>  			params.at_flags &= ~AT_SYMLINK_NOFOLLOW;
>  			params.flags = FSINFO_FLAGS_QUERY_PATH;
>  			continue;
> +		case 'm':
> +			params.resolve_flags = 0;
> +			params.flags = FSINFO_FLAGS_QUERY_MOUNT;
> +			continue;
>  		case 'r':
>  			raw = 1;
>  			continue;
> @@ -621,6 +625,7 @@ int main(int argc, char **argv)
>  
>  	if (argc != 1) {
>  		printf("Format: test-fsinfo [-Madlr] <path>\n");
> +		printf("Format: test-fsinfo [-Mdr] -m <mnt_id>\n");
>  		exit(2);
>  	}
>  
> 
> 
