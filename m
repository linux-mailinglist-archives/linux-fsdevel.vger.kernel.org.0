Return-Path: <linux-fsdevel+bounces-2200-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 36E037E31F4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Nov 2023 01:04:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1565B20B60
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Nov 2023 00:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E803D80E;
	Tue,  7 Nov 2023 00:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KWOQtbs4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD3139C
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Nov 2023 00:04:40 +0000 (UTC)
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FD32D57
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Nov 2023 16:04:37 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-5bdb0be3591so539916a12.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 Nov 2023 16:04:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1699315477; x=1699920277; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gZ7Tyo8qH9aoJwRZELDU2Tn13Js2474wX9Z3rsse04E=;
        b=KWOQtbs4rGU3Wd5cQ12hlQwNGwWkjDqiAaiBMeHd7DUMgtkMKgZ46/ORa3itE3j/Xc
         D2j0dBuzPNx3qJDDtMLELBiLXhg31BXTCpK0GnBrNowiDyG0KFCP755wXruIkwd2Wch2
         kl4hdWi1IQfFDBgiXZVA82vDDQPj3IctBUIF0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699315477; x=1699920277;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gZ7Tyo8qH9aoJwRZELDU2Tn13Js2474wX9Z3rsse04E=;
        b=vWHYipms3TvdNoCYhI7bqT76K/u+M0OMRrejsD+AX6g3Sic/TDxWn2WLH030zmBBjH
         95xSdWsHrxL1e8JEpAJ/v4CtKrK/tFKuVhUyz9fN5i3/nTsGPcYSJm9NytD7q4cySGQS
         jpgKfG2RdLgOJKojuljtxLxmPTmrgJE4XG2RR5MtAX44nN3FlBTuCyU82h7YvWfgfAos
         Xyd4ifwwizS06MoktutSIaOUf0zOPGTxnLyPyUdoCKTKrQi7F2EOh/CQd/ucKNlkxcRy
         SPANdpu+ER/XMminvqPwJEg+oR86qcvG1PybR0jammKb+v9ik5gdJ6ghVL6mIs3ZUGCr
         mlcQ==
X-Gm-Message-State: AOJu0YwMzHA8DzGpH/o2Y/ktUxjBgN+wEdN6YC2NjPunsR1fkFauM7Q6
	w847wHLgamMZT/wikXaxu+Drgg==
X-Google-Smtp-Source: AGHT+IFlGAXxvTy3TIkf725Nv5fS/RpZl/5VLZlIod4EZ1u1OhXaby1ULHhklzUANQJ962E2kmZhzA==
X-Received: by 2002:a05:6a21:3b48:b0:180:dd61:72a2 with SMTP id zy8-20020a056a213b4800b00180dd6172a2mr25536850pzb.33.1699315476896;
        Mon, 06 Nov 2023 16:04:36 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id j7-20020a170902da8700b001b06c106844sm6416459plx.151.2023.11.06.16.04.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 16:04:36 -0800 (PST)
Date: Mon, 6 Nov 2023 16:04:35 -0800
From: Kees Cook <keescook@chromium.org>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Christian Brauner <christian.brauner@ubuntu.com>,
	Sargun Dhillon <sargun@sargun.me>, Serge Hallyn <serge@hallyn.com>,
	Jann Horn <jannh@google.com>,
	Henning Schild <henning.schild@siemens.com>,
	Andrei Vagin <avagin@gmail.com>, Al Viro <viro@zeniv.linux.org.uk>,
	Laurent Vivier <laurent@vivier.eu>, linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>, linux-mm@kvack.org
Subject: Re: [PATCH AUTOSEL 6.6 07/13] binfmt_misc: cleanup on filesystem
 umount
Message-ID: <202311061604.8F1A8B6771@keescook>
References: <20231106231435.3734790-1-sashal@kernel.org>
 <20231106231435.3734790-7-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231106231435.3734790-7-sashal@kernel.org>

Please drop this from -stable -- it's part of a larger refactoring that
shouldn't be backported without explicit effort/testing.

-Kees

On Mon, Nov 06, 2023 at 06:14:20PM -0500, Sasha Levin wrote:
> From: Christian Brauner <christian.brauner@ubuntu.com>
> 
> [ Upstream commit 1c5976ef0f7ad76319df748ccb99a4c7ba2ba464 ]
> 
> Currently, registering a new binary type pins the binfmt_misc
> filesystem. Specifically, this means that as long as there is at least
> one binary type registered the binfmt_misc filesystem survives all
> umounts, i.e. the superblock is not destroyed. Meaning that a umount
> followed by another mount will end up with the same superblock and the
> same binary type handlers. This is a behavior we tend to discourage for
> any new filesystems (apart from a few special filesystems such as e.g.
> configfs or debugfs). A umount operation without the filesystem being
> pinned - by e.g. someone holding a file descriptor to an open file -
> should usually result in the destruction of the superblock and all
> associated resources. This makes introspection easier and leads to
> clearly defined, simple and clean semantics. An administrator can rely
> on the fact that a umount will guarantee a clean slate making it
> possible to reinitialize a filesystem. Right now all binary types would
> need to be explicitly deleted before that can happen.
> 
> This allows us to remove the heavy-handed calls to simple_pin_fs() and
> simple_release_fs() when creating and deleting binary types. This in
> turn allows us to replace the current brittle pinning mechanism abusing
> dget() which has caused a range of bugs judging from prior fixes in [2]
> and [3]. The additional dget() in load_misc_binary() pins the dentry but
> only does so for the sake to prevent ->evict_inode() from freeing the
> node when a user removes the binary type and kill_node() is run. Which
> would mean ->interpreter and ->interp_file would be freed causing a UAF.
> 
> This isn't really nicely documented nor is it very clean because it
> relies on simple_pin_fs() pinning the filesystem as long as at least one
> binary type exists. Otherwise it would cause load_misc_binary() to hold
> on to a dentry belonging to a superblock that has been shutdown.
> Replace that implicit pinning with a clean and simple per-node refcount
> and get rid of the ugly dget() pinning. A similar mechanism exists for
> e.g. binderfs (cf. [4]). All the cleanup work can now be done in
> ->evict_inode().
> 
> In a follow-up patch we will make it possible to use binfmt_misc in
> sandboxes. We will use the cleaner semantics where a umount for the
> filesystem will cause the superblock and all resources to be
> deallocated. In preparation for this apply the same semantics to the
> initial binfmt_misc mount. Note, that this is a user-visible change and
> as such a uapi change but one that we can reasonably risk. We've
> discussed this in earlier versions of this patchset (cf. [1]).
> 
> The main user and provider of binfmt_misc is systemd. Systemd provides
> binfmt_misc via autofs since it is configurable as a kernel module and
> is used by a few exotic packages and users. As such a binfmt_misc mount
> is triggered when /proc/sys/fs/binfmt_misc is accessed and is only
> provided on demand. Other autofs on demand filesystems include EFI ESP
> which systemd umounts if the mountpoint stays idle for a certain amount
> of time. This doesn't apply to the binfmt_misc autofs mount which isn't
> touched once it is mounted meaning this change can't accidently wipe
> binary type handlers without someone having explicitly unmounted
> binfmt_misc. After speaking to systemd folks they don't expect this
> change to affect them.
> 
> In line with our general policy, if we see a regression for systemd or
> other users with this change we will switch back to the old behavior for
> the initial binfmt_misc mount and have binary types pin the filesystem
> again. But while we touch this code let's take the chance and let's
> improve on the status quo.
> 
> [1]: https://lore.kernel.org/r/20191216091220.465626-2-laurent@vivier.eu
> [2]: commit 43a4f2619038 ("exec: binfmt_misc: fix race between load_misc_binary() and kill_node()"
> [3]: commit 83f918274e4b ("exec: binfmt_misc: shift filp_close(interp_file) from kill_node() to bm_evict_inode()")
> [4]: commit f0fe2c0f050d ("binder: prevent UAF for binderfs devices II")
> 
> Link: https://lore.kernel.org/r/20211028103114.2849140-1-brauner@kernel.org (v1)
> Cc: Sargun Dhillon <sargun@sargun.me>
> Cc: Serge Hallyn <serge@hallyn.com>
> Cc: Jann Horn <jannh@google.com>
> Cc: Henning Schild <henning.schild@siemens.com>
> Cc: Andrei Vagin <avagin@gmail.com>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Cc: Laurent Vivier <laurent@vivier.eu>
> Cc: linux-fsdevel@vger.kernel.org
> Acked-by: Serge Hallyn <serge@hallyn.com>
> Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
> /* v2 */
> - Christian Brauner <christian.brauner@ubuntu.com>:
>   - Add more comments that explain what's going on.
>   - Rename functions while changing them to better reflect what they are
>     doing to make the code easier to understand.
>   - In the first version when a specific binary type handler was removed
>     either through a write to the entry's file or all binary type
>     handlers were removed by a write to the binfmt_misc mount's status
>     file all cleanup work happened during inode eviction.
>     That includes removal of the relevant entries from entry list. While
>     that works fine I disliked that model after thinking about it for a
>     bit. Because it means that there was a window were someone has
>     already removed a or all binary handlers but they could still be
>     safely reached from load_misc_binary() when it has managed to take
>     the read_lock() on the entries list while inode eviction was already
>     happening. Again, that perfectly benign but it's cleaner to remove
>     the binary handler from the list immediately meaning that ones the
>     write to then entry's file or the binfmt_misc status file returns
>     the binary type cannot be executed anymore. That gives stronger
>     guarantees to the user.
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  fs/binfmt_misc.c | 216 ++++++++++++++++++++++++++++++++++++-----------
>  1 file changed, 168 insertions(+), 48 deletions(-)
> 
> diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c
> index e0108d17b085c..cf5ed5cd4102d 100644
> --- a/fs/binfmt_misc.c
> +++ b/fs/binfmt_misc.c
> @@ -60,12 +60,11 @@ typedef struct {
>  	char *name;
>  	struct dentry *dentry;
>  	struct file *interp_file;
> +	refcount_t users;		/* sync removal with load_misc_binary() */
>  } Node;
>  
>  static DEFINE_RWLOCK(entries_lock);
>  static struct file_system_type bm_fs_type;
> -static struct vfsmount *bm_mnt;
> -static int entry_count;
>  
>  /*
>   * Max length of the register string.  Determined by:
> @@ -82,19 +81,23 @@ static int entry_count;
>   */
>  #define MAX_REGISTER_LENGTH 1920
>  
> -/*
> - * Check if we support the binfmt
> - * if we do, return the node, else NULL
> - * locking is done in load_misc_binary
> +/**
> + * search_binfmt_handler - search for a binary handler for @bprm
> + * @misc: handle to binfmt_misc instance
> + * @bprm: binary for which we are looking for a handler
> + *
> + * Search for a binary type handler for @bprm in the list of registered binary
> + * type handlers.
> + *
> + * Return: binary type list entry on success, NULL on failure
>   */
> -static Node *check_file(struct linux_binprm *bprm)
> +static Node *search_binfmt_handler(struct linux_binprm *bprm)
>  {
>  	char *p = strrchr(bprm->interp, '.');
> -	struct list_head *l;
> +	Node *e;
>  
>  	/* Walk all the registered handlers. */
> -	list_for_each(l, &entries) {
> -		Node *e = list_entry(l, Node, list);
> +	list_for_each_entry(e, &entries, list) {
>  		char *s;
>  		int j;
>  
> @@ -123,9 +126,49 @@ static Node *check_file(struct linux_binprm *bprm)
>  		if (j == e->size)
>  			return e;
>  	}
> +
>  	return NULL;
>  }
>  
> +/**
> + * get_binfmt_handler - try to find a binary type handler
> + * @misc: handle to binfmt_misc instance
> + * @bprm: binary for which we are looking for a handler
> + *
> + * Try to find a binfmt handler for the binary type. If one is found take a
> + * reference to protect against removal via bm_{entry,status}_write().
> + *
> + * Return: binary type list entry on success, NULL on failure
> + */
> +static Node *get_binfmt_handler(struct linux_binprm *bprm)
> +{
> +	Node *e;
> +
> +	read_lock(&entries_lock);
> +	e = search_binfmt_handler(bprm);
> +	if (e)
> +		refcount_inc(&e->users);
> +	read_unlock(&entries_lock);
> +	return e;
> +}
> +
> +/**
> + * put_binfmt_handler - put binary handler node
> + * @e: node to put
> + *
> + * Free node syncing with load_misc_binary() and defer final free to
> + * load_misc_binary() in case it is using the binary type handler we were
> + * requested to remove.
> + */
> +static void put_binfmt_handler(Node *e)
> +{
> +	if (refcount_dec_and_test(&e->users)) {
> +		if (e->flags & MISC_FMT_OPEN_FILE)
> +			filp_close(e->interp_file, NULL);
> +		kfree(e);
> +	}
> +}
> +
>  /*
>   * the loader itself
>   */
> @@ -139,12 +182,7 @@ static int load_misc_binary(struct linux_binprm *bprm)
>  	if (!enabled)
>  		return retval;
>  
> -	/* to keep locking time low, we copy the interpreter string */
> -	read_lock(&entries_lock);
> -	fmt = check_file(bprm);
> -	if (fmt)
> -		dget(fmt->dentry);
> -	read_unlock(&entries_lock);
> +	fmt = get_binfmt_handler(bprm);
>  	if (!fmt)
>  		return retval;
>  
> @@ -198,7 +236,16 @@ static int load_misc_binary(struct linux_binprm *bprm)
>  
>  	retval = 0;
>  ret:
> -	dput(fmt->dentry);
> +
> +	/*
> +	 * If we actually put the node here all concurrent calls to
> +	 * load_misc_binary() will have finished. We also know
> +	 * that for the refcount to be zero ->evict_inode() must have removed
> +	 * the node to be deleted from the list. All that is left for us is to
> +	 * close and free.
> +	 */
> +	put_binfmt_handler(fmt);
> +
>  	return retval;
>  }
>  
> @@ -552,30 +599,90 @@ static struct inode *bm_get_inode(struct super_block *sb, int mode)
>  	return inode;
>  }
>  
> +/**
> + * bm_evict_inode - cleanup data associated with @inode
> + * @inode: inode to which the data is attached
> + *
> + * Cleanup the binary type handler data associated with @inode if a binary type
> + * entry is removed or the filesystem is unmounted and the super block is
> + * shutdown.
> + *
> + * If the ->evict call was not caused by a super block shutdown but by a write
> + * to remove the entry or all entries via bm_{entry,status}_write() the entry
> + * will have already been removed from the list. We keep the list_empty() check
> + * to make that explicit.
> +*/
>  static void bm_evict_inode(struct inode *inode)
>  {
>  	Node *e = inode->i_private;
>  
> -	if (e && e->flags & MISC_FMT_OPEN_FILE)
> -		filp_close(e->interp_file, NULL);
> -
>  	clear_inode(inode);
> -	kfree(e);
> +
> +	if (e) {
> +		write_lock(&entries_lock);
> +		if (!list_empty(&e->list))
> +			list_del_init(&e->list);
> +		write_unlock(&entries_lock);
> +		put_binfmt_handler(e);
> +	}
>  }
>  
> -static void kill_node(Node *e)
> +/**
> + * unlink_binfmt_dentry - remove the dentry for the binary type handler
> + * @dentry: dentry associated with the binary type handler
> + *
> + * Do the actual filesystem work to remove a dentry for a registered binary
> + * type handler. Since binfmt_misc only allows simple files to be created
> + * directly under the root dentry of the filesystem we ensure that we are
> + * indeed passed a dentry directly beneath the root dentry, that the inode
> + * associated with the root dentry is locked, and that it is a regular file we
> + * are asked to remove.
> + */
> +static void unlink_binfmt_dentry(struct dentry *dentry)
>  {
> -	struct dentry *dentry;
> +	struct dentry *parent = dentry->d_parent;
> +	struct inode *inode, *parent_inode;
> +
> +	/* All entries are immediate descendants of the root dentry. */
> +	if (WARN_ON_ONCE(dentry->d_sb->s_root != parent))
> +		return;
>  
> +	/* We only expect to be called on regular files. */
> +	inode = d_inode(dentry);
> +	if (WARN_ON_ONCE(!S_ISREG(inode->i_mode)))
> +		return;
> +
> +	/* The parent inode must be locked. */
> +	parent_inode = d_inode(parent);
> +	if (WARN_ON_ONCE(!inode_is_locked(parent_inode)))
> +		return;
> +
> +	if (simple_positive(dentry)) {
> +		dget(dentry);
> +		simple_unlink(parent_inode, dentry);
> +		d_delete(dentry);
> +		dput(dentry);
> +	}
> +}
> +
> +/**
> + * remove_binfmt_handler - remove a binary type handler
> + * @misc: handle to binfmt_misc instance
> + * @e: binary type handler to remove
> + *
> + * Remove a binary type handler from the list of binary type handlers and
> + * remove its associated dentry. This is called from
> + * binfmt_{entry,status}_write(). In the future, we might want to think about
> + * adding a proper ->unlink() method to binfmt_misc instead of forcing caller's
> + * to use writes to files in order to delete binary type handlers. But it has
> + * worked for so long that it's not a pressing issue.
> + */
> +static void remove_binfmt_handler(Node *e)
> +{
>  	write_lock(&entries_lock);
>  	list_del_init(&e->list);
>  	write_unlock(&entries_lock);
> -
> -	dentry = e->dentry;
> -	drop_nlink(d_inode(dentry));
> -	d_drop(dentry);
> -	dput(dentry);
> -	simple_release_fs(&bm_mnt, &entry_count);
> +	unlink_binfmt_dentry(e->dentry);
>  }
>  
>  /* /<entry> */
> @@ -602,8 +709,8 @@ bm_entry_read(struct file *file, char __user *buf, size_t nbytes, loff_t *ppos)
>  static ssize_t bm_entry_write(struct file *file, const char __user *buffer,
>  				size_t count, loff_t *ppos)
>  {
> -	struct dentry *root;
> -	Node *e = file_inode(file)->i_private;
> +	struct inode *inode = file_inode(file);
> +	Node *e = inode->i_private;
>  	int res = parse_command(buffer, count);
>  
>  	switch (res) {
> @@ -617,13 +724,22 @@ static ssize_t bm_entry_write(struct file *file, const char __user *buffer,
>  		break;
>  	case 3:
>  		/* Delete this handler. */
> -		root = file_inode(file)->i_sb->s_root;
> -		inode_lock(d_inode(root));
> +		inode = d_inode(inode->i_sb->s_root);
> +		inode_lock(inode);
>  
> +		/*
> +		 * In order to add new element or remove elements from the list
> +		 * via bm_{entry,register,status}_write() inode_lock() on the
> +		 * root inode must be held.
> +		 * The lock is exclusive ensuring that the list can't be
> +		 * modified. Only load_misc_binary() can access but does so
> +		 * read-only. So we only need to take the write lock when we
> +		 * actually remove the entry from the list.
> +		 */
>  		if (!list_empty(&e->list))
> -			kill_node(e);
> +			remove_binfmt_handler(e);
>  
> -		inode_unlock(d_inode(root));
> +		inode_unlock(inode);
>  		break;
>  	default:
>  		return res;
> @@ -682,13 +798,7 @@ static ssize_t bm_register_write(struct file *file, const char __user *buffer,
>  	if (!inode)
>  		goto out2;
>  
> -	err = simple_pin_fs(&bm_fs_type, &bm_mnt, &entry_count);
> -	if (err) {
> -		iput(inode);
> -		inode = NULL;
> -		goto out2;
> -	}
> -
> +	refcount_set(&e->users, 1);
>  	e->dentry = dget(dentry);
>  	inode->i_private = e;
>  	inode->i_fop = &bm_entry_operations;
> @@ -732,7 +842,8 @@ static ssize_t bm_status_write(struct file *file, const char __user *buffer,
>  		size_t count, loff_t *ppos)
>  {
>  	int res = parse_command(buffer, count);
> -	struct dentry *root;
> +	Node *e, *next;
> +	struct inode *inode;
>  
>  	switch (res) {
>  	case 1:
> @@ -745,13 +856,22 @@ static ssize_t bm_status_write(struct file *file, const char __user *buffer,
>  		break;
>  	case 3:
>  		/* Delete all handlers. */
> -		root = file_inode(file)->i_sb->s_root;
> -		inode_lock(d_inode(root));
> +		inode = d_inode(file_inode(file)->i_sb->s_root);
> +		inode_lock(inode);
>  
> -		while (!list_empty(&entries))
> -			kill_node(list_first_entry(&entries, Node, list));
> +		/*
> +		 * In order to add new element or remove elements from the list
> +		 * via bm_{entry,register,status}_write() inode_lock() on the
> +		 * root inode must be held.
> +		 * The lock is exclusive ensuring that the list can't be
> +		 * modified. Only load_misc_binary() can access but does so
> +		 * read-only. So we only need to take the write lock when we
> +		 * actually remove the entry from the list.
> +		 */
> +		list_for_each_entry_safe(e, next, &entries, list)
> +			remove_binfmt_handler(e);
>  
> -		inode_unlock(d_inode(root));
> +		inode_unlock(inode);
>  		break;
>  	default:
>  		return res;
> -- 
> 2.42.0
> 

-- 
Kees Cook

