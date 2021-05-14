Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E9363806EC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 May 2021 12:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232804AbhENKLj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 May 2021 06:11:39 -0400
Received: from out20-74.mail.aliyun.com ([115.124.20.74]:45977 "EHLO
        out20-74.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbhENKLi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 May 2021 06:11:38 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.04436282|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.26818-0.000419895-0.7314;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047205;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=7;RT=7;SR=0;TI=SMTPD_---.KDIoQks_1620987024;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.KDIoQks_1620987024)
          by smtp.aliyun-inc.com(10.147.41.178);
          Fri, 14 May 2021 18:10:25 +0800
Date:   Fri, 14 May 2021 18:10:31 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH v2] fsnotify: rework unlink/rmdir notify events
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        linux-fsdevel@vger.kernel.org, jack@suse.cz, amir73il@gmail.com,
        viro@zeniv.linux.org.uk
In-Reply-To: <1ff9dd79cd4938a28c3ff3045c0d639f412eb10b.1620934543.git.josef@toxicpanda.com>
References: <1ff9dd79cd4938a28c3ff3045c0d639f412eb10b.1620934543.git.josef@toxicpanda.com>
Message-Id: <20210514181030.4536.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.75.04 [en]
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

build error:
ERROR: modpost: "d_delete_notify" [fs/btrfs/btrfs.ko] undefined!
ERROR: modpost: "d_delete_notify" [fs/nfsd/nfsd.ko] undefined!

we need EXPORT_SYMBOL(d_delete_notify) ?

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2021/05/14

> A regression was introduced by 116b9731ad76 (v5.3, "fsnotify: add empty
> fsnotify_{unlink,rmdir}() hooks"), which moved the fsnotify event for
> unlink and rmdir to before the d_delete.  This was noticed by a tool we
> have internally for validating a FUSE file system.  This tool watches
> for IN_DELETE events and then stat's the file to make sure the file was
> actually deleted.  This started failing on our newer kernels, and it was
> traced to this patch.
> 
> The problem is there's a slight window where we emit the event and
> we delete the dentry.  We can easily get the event before we've called
> d_delete, and then stat the file before we're able to remove it.  This
> is easily reproducible with the following reproducer
> 
> static int failed = 0;
> 
> static void *watch_inotify(void *arg)
> {
> 	char name_buf[4096];
> 	char *buf = malloc(EVENT_BUF_LEN);
> 	char *directory = (char *)arg;
> 	int fd;
> 	int wd;
> 
> 	if (!buf) {
> 		fprintf(stderr, "Failed to allocate inotify buf\n");
> 		return NULL;
> 	}
> 
> 	fd = inotify_init();
> 	if (fd < 0) {
> 		fprintf(stderr, "Failed to init inotify %d %s\n",
> 				errno, strerror(errno));
> 		return NULL;
> 	}
> 
> 	wd = inotify_add_watch(fd, directory, IN_DELETE);
> 	if (wd < 0) {
> 		fprintf(stderr, "inotify watch failed %d %s\n", errno,
> 				strerror(errno));
> 		close(fd);
> 		return NULL;
> 	}
> 
> 	while (!failed) {
> 		ssize_t len = read(fd, buf, EVENT_BUF_LEN);
> 		size_t cur = 0;
> 
> 		if (len < 0) {
> 			fprintf(stderr, "failed to read from inotify %d %s\n",
> 					errno, strerror(errno));
> 			break;
> 		}
> 
> 		while (cur < len) {
> 			struct inotify_event *event =
> 				(struct inotify_event *)(buf + cur);
> 			struct stat st;
> 			int ret;
> 
> 			cur += EVENT_SIZE + event->len;
> 			if (event->len == 0)
> 				continue;
> 			if (!(event->mask & IN_DELETE))
> 				continue;
> 			ret = snprintf(name_buf, 4096, "%s/%s", directory,
> 					event->name);
> 			if (ret < 0) {
> 				fprintf(stderr, "Couldn't snprintf %d (%s)\n",
> 						errno, strerror(errno));
> 				break;
> 			}
> 			if (ret >= 4096) {
> 				fprintf(stderr, "Name was truncated, pick a shorter dir name\n");
> 				break;
> 			}
> 			ret = stat(name_buf, &st);
> 			if (!ret) {
> 				fprintf(stderr, "Found file %s after a delete event\n",
> 						name_buf);
> 				failed = 1;
> 				break;
> 			}
> 		}
> 	}
> 	inotify_rm_watch( fd, wd );
> 	close(fd);
> 	return NULL;
> }
> 
> int main(int argc, char **argv)
> {
> 	char buf[4096];
> 	char *dir;
> 	pthread_t inotify_thread;
> 	int ret, i;
> 
> 	if (argc != 2) {
> 		fprintf(stderr, "Must specify a directory to use\n");
> 		return 1;
> 	}
> 
> 	dir = strdup(argv[1]);
> 	if (!dir) {
> 		fprintf(stderr, "Couldn't dup directory\n");
> 		return 1;
> 	}
> 
> 	printf("Creating files...\n");
> 	for (i = 0; i < NR_FILES; i++) {
> 		ret = snprintf(buf, 4096, "%s/file_%d", dir, i);
> 		if (ret < 0) {
> 			fprintf(stderr, "Couldn't snprintf %d (%s)\n",
> 					errno, strerror(errno));
> 			goto out;
> 		}
> 		if (ret >= 4096) {
> 			fprintf(stderr, "Name was truncated, pick a shorter dir name\n");
> 			goto out;
> 		}
> 		ret = creat(buf, 0600);
> 		if (ret < 0) {
> 			fprintf(stderr, "Failed to create %s %d %s\n",
> 					buf, errno, strerror(errno));
> 			goto out;
> 		}
> 		close(ret);
> 	}
> 
> 	printf("Starting inotify thread\n");
> 	ret = pthread_create(&inotify_thread, NULL, watch_inotify, dir);
> 	if (ret) {
> 		fprintf(stderr, "Couldn't create inotify thread %d (%s)\n",
> 				errno, strerror(errno));
> 		goto out;
> 	}
> 
> 	printf("Sleeping for a second\n");
> 	sleep(1);
> 	printf("Starting delete\n");
> 	for (i = 0; i < NR_FILES; i++) {
> 		ret = snprintf(buf, 4096, "%s/file_%d", dir, i);
> 		if (ret < 0) {
> 			fprintf(stderr, "Couldn't snprintf %d (%s)\n",
> 					errno, strerror(errno));
> 			goto out_pthread;
> 		}
> 		if (ret >= 4096) {
> 			fprintf(stderr, "Name was truncated, pick a shorter dir name\n");
> 			goto out_pthread;
> 		}
> 		ret = unlink(buf);
> 		if (ret)
> 			goto out_pthread;
> 	}
> out_pthread:
> 	pthread_cancel(inotify_thread);
> 	pthread_join(inotify_thread, NULL);
> out:
> 	free(dir);
> 	return ret ? 1 : failed;
> }
> 
> Fix this by introducing a d_delete_notify() and a fsnotify_delete()
> helper.  d_delete_notify() will hold onto the dentry inode, do the
> d_delete, and then call fsnotify_delete() so that we avoid the race.
> Then fix up all callers of the fsnotify_unlink/fsnotify_rmdir helpers to
> either use d_delete_notify(), or use the fsnotify_delete() helper with
> the appropriate changes to protect the lifetime of the inode.  This
> patch makes the test no longer fail.
> 
> Fixes: 116b9731ad76 ("fsnotify: add empty fsnotify_{unlink,rmdir}() hooks")
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
> v1->v2:
> - Took Amir's suggestion and wrapped all the weird work into a d_delete_notify()
>   helper and used that everywhere.
> - Removed fsnotify_unlink/fsnotify_rmdir, replaced it with a fsnotify_delete()
>   helper.
> 
>  fs/btrfs/ioctl.c         |  6 ++----
>  fs/configfs/dir.c        |  6 ++----
>  fs/dcache.c              | 18 ++++++++++++++++++
>  fs/devpts/inode.c        |  7 ++++++-
>  fs/libfs.c               | 10 +++++-----
>  fs/namei.c               |  6 ++----
>  fs/nfsd/nfsctl.c         |  3 +--
>  include/linux/dcache.h   |  1 +
>  include/linux/fsnotify.h | 25 +++++++------------------
>  net/sunrpc/rpc_pipe.c    | 15 +++++++++++----
>  10 files changed, 55 insertions(+), 42 deletions(-)
> 
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index 5dc2fd843ae3..d9854db80e28 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -2990,10 +2990,8 @@ static noinline int btrfs_ioctl_snap_destroy(struct file *file,
>  	btrfs_inode_lock(inode, 0);
>  	err = btrfs_delete_subvolume(dir, dentry);
>  	btrfs_inode_unlock(inode, 0);
> -	if (!err) {
> -		fsnotify_rmdir(dir, dentry);
> -		d_delete(dentry);
> -	}
> +	if (!err)
> +		d_delete_notify(dir, dentry);
>  
>  out_dput:
>  	dput(dentry);
> diff --git a/fs/configfs/dir.c b/fs/configfs/dir.c
> index ac5e0c0e9181..2f187766f2e2 100644
> --- a/fs/configfs/dir.c
> +++ b/fs/configfs/dir.c
> @@ -1805,8 +1805,7 @@ void configfs_unregister_group(struct config_group *group)
>  	configfs_detach_group(&group->cg_item);
>  	d_inode(dentry)->i_flags |= S_DEAD;
>  	dont_mount(dentry);
> -	fsnotify_rmdir(d_inode(parent), dentry);
> -	d_delete(dentry);
> +	d_delete_notify(d_inode(parent), dentry);
>  	inode_unlock(d_inode(parent));
>  
>  	dput(dentry);
> @@ -1947,10 +1946,9 @@ void configfs_unregister_subsystem(struct configfs_subsystem *subsys)
>  	configfs_detach_group(&group->cg_item);
>  	d_inode(dentry)->i_flags |= S_DEAD;
>  	dont_mount(dentry);
> -	fsnotify_rmdir(d_inode(root), dentry);
>  	inode_unlock(d_inode(dentry));
>  
> -	d_delete(dentry);
> +	d_delete_notify(d_inode(root), dentry);
>  
>  	inode_unlock(d_inode(root));
>  
> diff --git a/fs/dcache.c b/fs/dcache.c
> index cf871a81f4fd..b342696c07f9 100644
> --- a/fs/dcache.c
> +++ b/fs/dcache.c
> @@ -2511,6 +2511,24 @@ void d_delete(struct dentry * dentry)
>  }
>  EXPORT_SYMBOL(d_delete);
>  
> +/**
> + * d_delete_notify - delete a dentry and emit the fsnotify event
> + * @dir: The directory containing the dentry
> + * @dentry: The dentry to delete
> + *
> + * This operates exactly as d_delete, but also emits the fsnotify event for the
> + * deletion as well.
> + */
> +void d_delete_notify(struct inode *dir, struct dentry *dentry)
> +{
> +	struct inode *inode = dentry->d_inode;
> +
> +	ihold(inode);
> +	d_delete(dentry);
> +	fsnotify_delete(dir, dentry, inode);
> +	iput(inode);
> +}
> +
>  static void __d_rehash(struct dentry *entry)
>  {
>  	struct hlist_bl_head *b = d_hash(entry->d_name.hash);
> diff --git a/fs/devpts/inode.c b/fs/devpts/inode.c
> index 42e5a766d33c..714e6f9b74f5 100644
> --- a/fs/devpts/inode.c
> +++ b/fs/devpts/inode.c
> @@ -617,12 +617,17 @@ void *devpts_get_priv(struct dentry *dentry)
>   */
>  void devpts_pty_kill(struct dentry *dentry)
>  {
> +	struct inode *dir = d_inode(dentry->d_parent);
> +	struct inode *inode = d_inode(dentry);
> +
>  	WARN_ON_ONCE(dentry->d_sb->s_magic != DEVPTS_SUPER_MAGIC);
>  
> +	ihold(inode);
>  	dentry->d_fsdata = NULL;
>  	drop_nlink(dentry->d_inode);
> -	fsnotify_unlink(d_inode(dentry->d_parent), dentry);
>  	d_drop(dentry);
> +	fsnotify_delete(dir, dentry, inode);
> +	iput(inode);
>  	dput(dentry);	/* d_alloc_name() in devpts_pty_new() */
>  }
>  
> diff --git a/fs/libfs.c b/fs/libfs.c
> index e9b29c6ffccb..189e12dc5d9b 100644
> --- a/fs/libfs.c
> +++ b/fs/libfs.c
> @@ -271,7 +271,7 @@ void simple_recursive_removal(struct dentry *dentry,
>  	struct dentry *this = dget(dentry);
>  	while (true) {
>  		struct dentry *victim = NULL, *child;
> -		struct inode *inode = this->d_inode;
> +		struct inode *inode = this->d_inode, *victim_inode;
>  
>  		inode_lock(inode);
>  		if (d_is_dir(this))
> @@ -283,19 +283,19 @@ void simple_recursive_removal(struct dentry *dentry,
>  			clear_nlink(inode);
>  			inode_unlock(inode);
>  			victim = this;
> +			victim_inode = d_inode(victim);
> +			ihold(victim_inode);
>  			this = this->d_parent;
>  			inode = this->d_inode;
>  			inode_lock(inode);
>  			if (simple_positive(victim)) {
>  				d_invalidate(victim);	// avoid lost mounts
> -				if (d_is_dir(victim))
> -					fsnotify_rmdir(inode, victim);
> -				else
> -					fsnotify_unlink(inode, victim);
> +				fsnotify_delete(inode, victim, victim_inode);
>  				if (callback)
>  					callback(victim);
>  				dput(victim);		// unpin it
>  			}
> +			iput(victim_inode);
>  			if (victim == dentry) {
>  				inode->i_ctime = inode->i_mtime =
>  					current_time(inode);
> diff --git a/fs/namei.c b/fs/namei.c
> index 79b0ff9b151e..40c3ea4e5eae 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -3900,13 +3900,12 @@ int vfs_rmdir(struct user_namespace *mnt_userns, struct inode *dir,
>  	dentry->d_inode->i_flags |= S_DEAD;
>  	dont_mount(dentry);
>  	detach_mounts(dentry);
> -	fsnotify_rmdir(dir, dentry);
>  
>  out:
>  	inode_unlock(dentry->d_inode);
>  	dput(dentry);
>  	if (!error)
> -		d_delete(dentry);
> +		d_delete_notify(dir, dentry);
>  	return error;
>  }
>  EXPORT_SYMBOL(vfs_rmdir);
> @@ -4026,7 +4025,6 @@ int vfs_unlink(struct user_namespace *mnt_userns, struct inode *dir,
>  			if (!error) {
>  				dont_mount(dentry);
>  				detach_mounts(dentry);
> -				fsnotify_unlink(dir, dentry);
>  			}
>  		}
>  	}
> @@ -4036,7 +4034,7 @@ int vfs_unlink(struct user_namespace *mnt_userns, struct inode *dir,
>  	/* We don't d_delete() NFS sillyrenamed files--they still exist. */
>  	if (!error && !(dentry->d_flags & DCACHE_NFSFS_RENAMED)) {
>  		fsnotify_link_count(target);
> -		d_delete(dentry);
> +		d_delete_notify(dir, dentry);
>  	}
>  
>  	return error;
> diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> index c2c3d9077dc5..e95d122ef50d 100644
> --- a/fs/nfsd/nfsctl.c
> +++ b/fs/nfsd/nfsctl.c
> @@ -1337,8 +1337,7 @@ void nfsd_client_rmdir(struct dentry *dentry)
>  	dget(dentry);
>  	ret = simple_rmdir(dir, dentry);
>  	WARN_ON_ONCE(ret);
> -	fsnotify_rmdir(dir, dentry);
> -	d_delete(dentry);
> +	d_delete_notify(dir, dentry);
>  	dput(dentry);
>  	inode_unlock(dir);
>  }
> diff --git a/include/linux/dcache.h b/include/linux/dcache.h
> index 9e23d33bb6f1..86df9b269f0e 100644
> --- a/include/linux/dcache.h
> +++ b/include/linux/dcache.h
> @@ -234,6 +234,7 @@ extern struct dentry * d_instantiate_anon(struct dentry *, struct inode *);
>  extern void __d_drop(struct dentry *dentry);
>  extern void d_drop(struct dentry *dentry);
>  extern void d_delete(struct dentry *);
> +extern void d_delete_notify(struct inode *dir, struct dentry *dentry);
>  extern void d_set_d_op(struct dentry *dentry, const struct dentry_operations *op);
>  
>  /* allocate/de-allocate */
> diff --git a/include/linux/fsnotify.h b/include/linux/fsnotify.h
> index f8acddcf54fb..7bb06324c6b3 100644
> --- a/include/linux/fsnotify.h
> +++ b/include/linux/fsnotify.h
> @@ -204,16 +204,18 @@ static inline void fsnotify_link(struct inode *dir, struct inode *inode,
>  }
>  
>  /*
> - * fsnotify_unlink - 'name' was unlinked
> + * fsnotify_delete - 'name' was unlinked
>   *
>   * Caller must make sure that dentry->d_name is stable.
>   */
> -static inline void fsnotify_unlink(struct inode *dir, struct dentry *dentry)
> +static inline void fsnotify_delete(struct inode *dir, struct dentry *dentry,
> +				   struct inode *inode)
>  {
> -	/* Expected to be called before d_delete() */
> -	WARN_ON_ONCE(d_is_negative(dentry));
> +	__u32 mask = FS_DELETE;
>  
> -	fsnotify_dirent(dir, dentry, FS_DELETE);
> +	if (S_ISDIR(inode->i_mode))
> +		mask |= FS_ISDIR;
> +	fsnotify_name(dir, mask, inode, &dentry->d_name, 0);
>  }
>  
>  /*
> @@ -226,19 +228,6 @@ static inline void fsnotify_mkdir(struct inode *inode, struct dentry *dentry)
>  	fsnotify_dirent(inode, dentry, FS_CREATE | FS_ISDIR);
>  }
>  
> -/*
> - * fsnotify_rmdir - directory 'name' was removed
> - *
> - * Caller must make sure that dentry->d_name is stable.
> - */
> -static inline void fsnotify_rmdir(struct inode *dir, struct dentry *dentry)
> -{
> -	/* Expected to be called before d_delete() */
> -	WARN_ON_ONCE(d_is_negative(dentry));
> -
> -	fsnotify_dirent(dir, dentry, FS_DELETE | FS_ISDIR);
> -}
> -
>  /*
>   * fsnotify_access - file was read
>   */
> diff --git a/net/sunrpc/rpc_pipe.c b/net/sunrpc/rpc_pipe.c
> index 09c000d490a1..5dca896a60ab 100644
> --- a/net/sunrpc/rpc_pipe.c
> +++ b/net/sunrpc/rpc_pipe.c
> @@ -596,26 +596,33 @@ static int __rpc_mkpipe_dentry(struct inode *dir, struct dentry *dentry,
>  
>  static int __rpc_rmdir(struct inode *dir, struct dentry *dentry)
>  {
> +	struct inode *inode = d_inode(dentry);
>  	int ret;
>  
>  	dget(dentry);
> +	ihold(inode);
>  	ret = simple_rmdir(dir, dentry);
> -	if (!ret)
> -		fsnotify_rmdir(dir, dentry);
>  	d_delete(dentry);
> +	if (!ret)
> +		fsnotify_delete(dir, dentry, inode);
> +	iput(inode);
>  	dput(dentry);
>  	return ret;
>  }
>  
>  static int __rpc_unlink(struct inode *dir, struct dentry *dentry)
>  {
> +	struct inode *inode;
>  	int ret;
>  
>  	dget(dentry);
> +	inode = d_inode(dentry);
> +	ihold(inode);
>  	ret = simple_unlink(dir, dentry);
> -	if (!ret)
> -		fsnotify_unlink(dir, dentry);
>  	d_delete(dentry);
> +	if (!ret)
> +		fsnotify_delete(dir, dentry, inode);
> +	iput(inode);
>  	dput(dentry);
>  	return ret;
>  }
> -- 
> 2.26.3


