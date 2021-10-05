Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FA00423261
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Oct 2021 22:50:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236524AbhJEUw0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Oct 2021 16:52:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236222AbhJEUwY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Oct 2021 16:52:24 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA471C06174E
        for <linux-fsdevel@vger.kernel.org>; Tue,  5 Oct 2021 13:50:33 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id ls18-20020a17090b351200b001a00250584aso2439219pjb.4
        for <linux-fsdevel@vger.kernel.org>; Tue, 05 Oct 2021 13:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mWI5gmt1f2sE4WHrG7lhmtp1KhKxIzADNM6YfrEY8FI=;
        b=F3bw7oYnRNAlLTG/U8ZVUqqH8tA2z7msfRnTxbabkfxLdl8FflOtJyUtlFLVuLkLAz
         9/4XgUogAVDFqnvjDMA+N2pKl5D35ro/qGIAz5Y0v+lvE4CQFnbZ2kDEqmjWFnBK/D1g
         jd0ACG9JAl175QBrVe2zuSHE20G8rhopsMNyM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mWI5gmt1f2sE4WHrG7lhmtp1KhKxIzADNM6YfrEY8FI=;
        b=x8iEpwcmOYfARkIEuQ9E90OJt61tZbD0+3s9PaROeDT5e695gDY6Yaqn5pURIvKYAL
         59a7KLWWmjnCSs0OFwPyWTLzt9pUQJLvieMwZeFgEWvivUResmBEioaq0x5LS5/JoiqZ
         gLcnB9RFYhz8oAq+r7/ucVoTYnoKufPJaQG3fXxLM2HOPPPa0eKY35XOQTNLRItVzb9B
         O9TpX58+uzIf706dPiHXkL5Ty0JuLjS81L8BE1y0/5mYLc8B33SI+B3GK/K9dJUtcmVy
         tCQxuZjdZl2iNuuvcaHS2JsgvUjLk6ao0+/0nXAC7MY93ZyPEcdWSXtO0d+4BAMoPSwP
         UGVA==
X-Gm-Message-State: AOAM531WlPhI6oUlqLi81nI2mTpDfvNBq81aCJOSlz8mCpLDfoO+AdkQ
        msQeUF712jgV8ox5FB0/QhlQWA==
X-Google-Smtp-Source: ABdhPJxLndePGVphN7UN+zC1lVhp4XYLuJlfIX/twoOlSBWgImAvgQltIbNaNY6E3tdvZSXfFBVtrQ==
X-Received: by 2002:a17:90b:374f:: with SMTP id ne15mr6234983pjb.37.1633467032808;
        Tue, 05 Oct 2021 13:50:32 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id e1sm19119194pgi.43.2021.10.05.13.50.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 13:50:32 -0700 (PDT)
Date:   Tue, 5 Oct 2021 13:50:31 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     tj@kernel.org, gregkh@linuxfoundation.org,
        akpm@linux-foundation.org, minchan@kernel.org, jeyu@kernel.org,
        shuah@kernel.org, bvanassche@acm.org, dan.j.williams@intel.com,
        joe@perches.com, tglx@linutronix.de, rostedt@goodmis.org,
        linux-spdx@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 09/12] sysfs: fix deadlock race with module removal
Message-ID: <202110051315.B2165F455@keescook>
References: <20210927163805.808907-1-mcgrof@kernel.org>
 <20210927163805.808907-10-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210927163805.808907-10-mcgrof@kernel.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 27, 2021 at 09:38:02AM -0700, Luis Chamberlain wrote:
> When driver sysfs attributes use a lock also used on module removal we
> can race to deadlock. This happens when for instance a sysfs file on
> a driver is used, then at the same time we have module removal call
> trigger. The module removal call code holds a lock, and then the
> driver's sysfs file entry waits for the same lock. While holding the
> lock the module removal tries to remove the sysfs entries, but these
> cannot be removed yet as one is waiting for a lock. This won't complete
> as the lock is already held. Likewise module removal cannot complete,
> and so we deadlock.
> 
> This can now be easily reproducible with our sysfs selftest as follows:
> 
> ./tools/testing/selftests/sysfs/sysfs.sh -t 0027
> 
> This uses a local driver lock. Test 0028 can also be used, that uses
> the rtnl_lock():
> 
> ./tools/testing/selftests/sysfs/sysfs.sh -t 0028
> 
> To fix this we extend the struct kernfs_node with a module reference
> and use the try_module_get() after kernfs_get_active() is called. As

I would agree: kernfs must know about the module containing the ops
structure it has been given. (Without this, there are, at the very least,
removal races for looking at kernfs_ops structures.)

In other places in the kernel, function callback dependencies are more
explicit in that if code is holding such things, it has already taken a
module reference, etc. But kernfs is special in the sense that just
because a kernfs entry exists, we don't want to pin the module use count
too.

But simple locking isn't workable to solve this because kernfs_remove()
must be able to be called from a module_exit routine without deadlocking.
(i.e. we would create exactly the situation that caused this condition
to get noticed in the first place.)

> documented in the prior patch, we now know that once kernfs_get_active()
> is called the module is implicitly guarded to exist and cannot be removed.
> This is because the module is the one in charge of removing the same
> sysfs file it created, and removal of sysfs files on module exit will wait
> until they don't have any active references. By using a try_module_get()
> after kernfs_get_active() we yield to let module removal trump calls to
> process a sysfs operation, while also preventing module removal if a sysfs
> operation is in already progress. This prevents the deadlock.
> 
> This deadlock was first reported with the zram driver, however the live
> patching folks have acknowledged they have observed this as well with
> live patching, when a live patch is removed. I was then able to
> reproduce easily by creating a dedicated selftest for it.
> 
> A sketch of how this can happen follows, consider foo a local mutex
> part of a driver, and used on the driver's module exit routine and
> on one of its sysfs ops:
> 
> foo.c:
> static DEFINE_MUTEX(foo);
> static ssize_t foo_store(struct device *dev,
> 			 struct device_attribute *attr,
> 			 const char *buf, size_t count)
> {
> 	...
> 	mutex_lock(&foo);
> 	...
> 	mutex_lock(&foo);
> 	...
> }
> static DEVICE_ATTR_RW(foo);
> ...
> void foo_exit(void)
> {
> 	mutex_lock(&foo);
> 	...
> 	mutex_unlock(&foo);
> }
> module_exit(foo_exit);
> 
> And this can lead to this condition:
> 
> CPU A                              CPU B
>                                    foo_store()
> foo_exit()
>   mutex_lock(&foo)
>                                    mutex_lock(&foo)
>    del_gendisk(some_struct->disk);
>      device_del()
>        device_remove_groups()

Please expand this further, where does device_remove_groups() end up
waiting for that never happens?

> 
> In this situation foo_store() is waiting for the mutex foo to
> become unlocked, but that won't happen until module removal is complete.
> But module removal won't complete until the sysfs file being poked at
> completes which is waiting for a lock already held.
> 
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c |  4 +-
>  fs/kernfs/dir.c                        | 44 ++++++++++++++++++----
>  fs/kernfs/file.c                       |  6 ++-
>  fs/kernfs/kernfs-internal.h            |  3 +-
>  fs/kernfs/symlink.c                    |  3 +-
>  fs/sysfs/dir.c                         |  2 +-
>  fs/sysfs/file.c                        |  6 ++-
>  fs/sysfs/group.c                       |  3 +-
>  include/linux/kernfs.h                 | 14 ++++---
>  include/linux/sysfs.h                  | 52 ++++++++++++++++++++------
>  kernel/cgroup/cgroup.c                 |  2 +-
>  11 files changed, 105 insertions(+), 34 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index b57b3db9a6a7..4edf3b37fd2c 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -209,7 +209,7 @@ static int rdtgroup_add_file(struct kernfs_node *parent_kn, struct rftype *rft)
>  
>  	kn = __kernfs_create_file(parent_kn, rft->name, rft->mode,
>  				  GLOBAL_ROOT_UID, GLOBAL_ROOT_GID,
> -				  0, rft->kf_ops, rft, NULL, NULL);
> +				  0, rft->kf_ops, rft, NULL, NULL, NULL);
>  	if (IS_ERR(kn))
>  		return PTR_ERR(kn);
>  
> @@ -2482,7 +2482,7 @@ static int mon_addfile(struct kernfs_node *parent_kn, const char *name,
>  
>  	kn = __kernfs_create_file(parent_kn, name, 0444,
>  				  GLOBAL_ROOT_UID, GLOBAL_ROOT_GID, 0,
> -				  &kf_mondata_ops, priv, NULL, NULL);
> +				  &kf_mondata_ops, priv, NULL, NULL, NULL);
>  	if (IS_ERR(kn))
>  		return PTR_ERR(kn);
>  
> diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
> index ba581429bf7b..e841201fd11b 100644
> --- a/fs/kernfs/dir.c
> +++ b/fs/kernfs/dir.c
> @@ -14,6 +14,7 @@
>  #include <linux/slab.h>
>  #include <linux/security.h>
>  #include <linux/hash.h>
> +#include <linux/module.h>
>  
>  #include "kernfs-internal.h"
>  
> @@ -414,12 +415,29 @@ static bool kernfs_unlink_sibling(struct kernfs_node *kn)
>   */
>  struct kernfs_node *kernfs_get_active(struct kernfs_node *kn)
>  {
> +	int v;
> +
>  	if (unlikely(!kn))
>  		return NULL;
>  
>  	if (!atomic_inc_unless_negative(&kn->active))
>  		return NULL;
>  
> +	/*
> +	 * If a module created the kernfs_node, the module cannot possibly be
> +	 * removed if the above atomic_inc_unless_negative() succeeded. So the
> +	 * try_module_get() below is not to protect the lifetime of the module
> +	 * as that is already guaranteed. The try_module_get() below is used
> +	 * to ensure that we don't deadlock in case a kernfs operation and
> +	 * module removal used a shared lock.
> +	 */
> +	if (!try_module_get(kn->owner)) {
> +		v = atomic_dec_return(&kn->active);
> +		if (unlikely(v == KN_DEACTIVATED_BIAS))
> +			wake_up_all(&kernfs_root(kn)->deactivate_waitq);
> +		return NULL;
> +	}

The special casing in here makes me think this isn't happening the right
place. (i.e this looks like an open-coded version of kernfs_put_active())

> +
>  	if (kernfs_lockdep(kn))
>  		rwsem_acquire_read(&kn->dep_map, 0, 1, _RET_IP_);
>  	return kn;
> @@ -442,6 +460,13 @@ void kernfs_put_active(struct kernfs_node *kn)
>  	if (kernfs_lockdep(kn))
>  		rwsem_release(&kn->dep_map, _RET_IP_);
>  	v = atomic_dec_return(&kn->active);
> +
> +	/*
> +	 * We prevent module exit *until* we know for sure all possible
> +	 * kernfs ops are done.
> +	 */
> +	module_put(kn->owner);
> +
>  	if (likely(v != KN_DEACTIVATED_BIAS))
>  		return;

What I don't understand, however, is what kernfs_get/put_active() is
intending to do -- it looks like it's trying to provide an interruption
point for open kernfs file operations?

This all seems extremely complex for what seems like it should just be a
global "am I being removed?" bool?

Regardless, while I do see the logic of associating the module get/put
with get/put of kernfs "active", why is it not better tied to strictly
kernfs open/close? That would seem to be much simpler and not require
any special handling?

For example, why does this not work?


diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
index 60e2a86c535e..e44502ac244d 100644
--- a/fs/kernfs/file.c
+++ b/fs/kernfs/file.c
@@ -525,6 +525,9 @@ static int kernfs_get_open_node(struct kernfs_node *kn,
 {
 	struct kernfs_open_node *on, *new_on = NULL;
 
+	if (!try_module_get(kn->owner))
+		return -ENODEV;
+
  retry:
 	mutex_lock(&kernfs_open_file_mutex);
 	spin_lock_irq(&kernfs_open_node_lock);
@@ -592,6 +595,7 @@ static void kernfs_put_open_node(struct kernfs_node *kn,
 	mutex_unlock(&kernfs_open_file_mutex);
 
 	kfree(on);
+	module_put(kn->owner);
 }
 
 static int kernfs_fop_open(struct inode *inode, struct file *file)
@@ -719,6 +723,7 @@ static int kernfs_fop_open(struct inode *inode, struct file *file)
 	kfree(of);
 err_out:
 	kernfs_put_active(kn);
+	module_put(kn->owner);
 	return error;
 }
 


>  
> @@ -572,7 +597,8 @@ static struct kernfs_node *__kernfs_new_node(struct kernfs_root *root,
>  					     struct kernfs_node *parent,
>  					     const char *name, umode_t mode,
>  					     kuid_t uid, kgid_t gid,
> -					     unsigned flags)
> +					     unsigned flags,
> +					     struct module *owner)
>  {
>  	struct kernfs_node *kn;
>  	u32 id_highbits;
> @@ -607,6 +633,7 @@ static struct kernfs_node *__kernfs_new_node(struct kernfs_root *root,
>  	kn->name = name;
>  	kn->mode = mode;
>  	kn->flags = flags;
> +	kn->owner = owner;
>  
>  	if (!uid_eq(uid, GLOBAL_ROOT_UID) || !gid_eq(gid, GLOBAL_ROOT_GID)) {
>  		struct iattr iattr = {
> @@ -640,12 +667,13 @@ static struct kernfs_node *__kernfs_new_node(struct kernfs_root *root,
>  struct kernfs_node *kernfs_new_node(struct kernfs_node *parent,
>  				    const char *name, umode_t mode,
>  				    kuid_t uid, kgid_t gid,
> -				    unsigned flags)
> +				    unsigned flags,
> +				    struct module *owner)
>  {
>  	struct kernfs_node *kn;
>  
>  	kn = __kernfs_new_node(kernfs_root(parent), parent,
> -			       name, mode, uid, gid, flags);
> +			       name, mode, uid, gid, flags, owner);
>  	if (kn) {
>  		kernfs_get(parent);
>  		kn->parent = parent;
> @@ -927,7 +955,7 @@ struct kernfs_root *kernfs_create_root(struct kernfs_syscall_ops *scops,
>  
>  	kn = __kernfs_new_node(root, NULL, "", S_IFDIR | S_IRUGO | S_IXUGO,
>  			       GLOBAL_ROOT_UID, GLOBAL_ROOT_GID,
> -			       KERNFS_DIR);
> +			       KERNFS_DIR, NULL);
>  	if (!kn) {
>  		idr_destroy(&root->ino_idr);
>  		kfree(root);
> @@ -969,20 +997,22 @@ void kernfs_destroy_root(struct kernfs_root *root)
>   * @gid: gid of the new directory
>   * @priv: opaque data associated with the new directory
>   * @ns: optional namespace tag of the directory
> + * @owner: if set, the module owner of this directory
>   *
>   * Returns the created node on success, ERR_PTR() value on failure.
>   */
>  struct kernfs_node *kernfs_create_dir_ns(struct kernfs_node *parent,
>  					 const char *name, umode_t mode,
>  					 kuid_t uid, kgid_t gid,
> -					 void *priv, const void *ns)
> +					 void *priv, const void *ns,
> +					 struct module *owner)
>  {
>  	struct kernfs_node *kn;
>  	int rc;
>  
>  	/* allocate */
>  	kn = kernfs_new_node(parent, name, mode | S_IFDIR,
> -			     uid, gid, KERNFS_DIR);
> +			     uid, gid, KERNFS_DIR, owner);
>  	if (!kn)
>  		return ERR_PTR(-ENOMEM);
>  
> @@ -1014,7 +1044,7 @@ struct kernfs_node *kernfs_create_empty_dir(struct kernfs_node *parent,
>  
>  	/* allocate */
>  	kn = kernfs_new_node(parent, name, S_IRUGO|S_IXUGO|S_IFDIR,
> -			     GLOBAL_ROOT_UID, GLOBAL_ROOT_GID, KERNFS_DIR);
> +			     GLOBAL_ROOT_UID, GLOBAL_ROOT_GID, KERNFS_DIR, NULL);
>  	if (!kn)
>  		return ERR_PTR(-ENOMEM);
>  
> diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
> index 4479c6580333..0e125287e050 100644
> --- a/fs/kernfs/file.c
> +++ b/fs/kernfs/file.c
> @@ -978,6 +978,7 @@ const struct file_operations kernfs_file_fops = {
>   * @priv: private data for the file
>   * @ns: optional namespace tag of the file
>   * @key: lockdep key for the file's active_ref, %NULL to disable lockdep
> + * @owner: if set, the module owner of the file
>   *
>   * Returns the created node on success, ERR_PTR() value on error.
>   */
> @@ -987,7 +988,8 @@ struct kernfs_node *__kernfs_create_file(struct kernfs_node *parent,
>  					 loff_t size,
>  					 const struct kernfs_ops *ops,
>  					 void *priv, const void *ns,
> -					 struct lock_class_key *key)
> +					 struct lock_class_key *key,
> +					 struct module *owner)
>  {
>  	struct kernfs_node *kn;
>  	unsigned flags;
> @@ -996,7 +998,7 @@ struct kernfs_node *__kernfs_create_file(struct kernfs_node *parent,
>  	flags = KERNFS_FILE;
>  
>  	kn = kernfs_new_node(parent, name, (mode & S_IALLUGO) | S_IFREG,
> -			     uid, gid, flags);
> +			     uid, gid, flags, owner);
>  	if (!kn)
>  		return ERR_PTR(-ENOMEM);
>  
> diff --git a/fs/kernfs/kernfs-internal.h b/fs/kernfs/kernfs-internal.h
> index 9e3abf597e2d..6d275d661987 100644
> --- a/fs/kernfs/kernfs-internal.h
> +++ b/fs/kernfs/kernfs-internal.h
> @@ -134,7 +134,8 @@ int kernfs_add_one(struct kernfs_node *kn);
>  struct kernfs_node *kernfs_new_node(struct kernfs_node *parent,
>  				    const char *name, umode_t mode,
>  				    kuid_t uid, kgid_t gid,
> -				    unsigned flags);
> +				    unsigned flags,
> +				    struct module *owner);
>  
>  /*
>   * file.c
> diff --git a/fs/kernfs/symlink.c b/fs/kernfs/symlink.c
> index 19a6c71c6ff5..5a053eebee52 100644
> --- a/fs/kernfs/symlink.c
> +++ b/fs/kernfs/symlink.c
> @@ -36,7 +36,8 @@ struct kernfs_node *kernfs_create_link(struct kernfs_node *parent,
>  		gid = target->iattr->ia_gid;
>  	}
>  
> -	kn = kernfs_new_node(parent, name, S_IFLNK|0777, uid, gid, KERNFS_LINK);
> +	kn = kernfs_new_node(parent, name, S_IFLNK|0777, uid, gid, KERNFS_LINK,
> +			     target->owner);
>  	if (!kn)
>  		return ERR_PTR(-ENOMEM);
>  
> diff --git a/fs/sysfs/dir.c b/fs/sysfs/dir.c
> index b6b6796e1616..9763c2fde3c7 100644
> --- a/fs/sysfs/dir.c
> +++ b/fs/sysfs/dir.c
> @@ -57,7 +57,7 @@ int sysfs_create_dir_ns(struct kobject *kobj, const void *ns)
>  	kobject_get_ownership(kobj, &uid, &gid);
>  
>  	kn = kernfs_create_dir_ns(parent, kobject_name(kobj), 0755, uid, gid,
> -				  kobj, ns);
> +				  kobj, ns, NULL);
>  	if (IS_ERR(kn)) {
>  		if (PTR_ERR(kn) == -EEXIST)
>  			sysfs_warn_dup(parent, kobject_name(kobj));
> diff --git a/fs/sysfs/file.c b/fs/sysfs/file.c
> index 42dcf96881b6..af9e91fd1a92 100644
> --- a/fs/sysfs/file.c
> +++ b/fs/sysfs/file.c
> @@ -292,7 +292,8 @@ int sysfs_add_file_mode_ns(struct kernfs_node *parent,
>  #endif
>  
>  	kn = __kernfs_create_file(parent, attr->name, mode & 0777, uid, gid,
> -				  PAGE_SIZE, ops, (void *)attr, ns, key);
> +				  PAGE_SIZE, ops, (void *)attr, ns, key,
> +				  attr->owner);
>  	if (IS_ERR(kn)) {
>  		if (PTR_ERR(kn) == -EEXIST)
>  			sysfs_warn_dup(parent, attr->name);
> @@ -327,7 +328,8 @@ int sysfs_add_bin_file_mode_ns(struct kernfs_node *parent,
>  #endif
>  
>  	kn = __kernfs_create_file(parent, attr->name, mode & 0777, uid, gid,
> -				  battr->size, ops, (void *)attr, ns, key);
> +				  battr->size, ops, (void *)attr, ns, key,
> +				  attr->owner);
>  	if (IS_ERR(kn)) {
>  		if (PTR_ERR(kn) == -EEXIST)
>  			sysfs_warn_dup(parent, attr->name);
> diff --git a/fs/sysfs/group.c b/fs/sysfs/group.c
> index eeb0e3099421..372864d1cb54 100644
> --- a/fs/sysfs/group.c
> +++ b/fs/sysfs/group.c
> @@ -135,7 +135,8 @@ static int internal_create_group(struct kobject *kobj, int update,
>  		} else {
>  			kn = kernfs_create_dir_ns(kobj->sd, grp->name,
>  						  S_IRWXU | S_IRUGO | S_IXUGO,
> -						  uid, gid, kobj, NULL);
> +						  uid, gid, kobj, NULL,
> +						  grp->owner);
>  			if (IS_ERR(kn)) {
>  				if (PTR_ERR(kn) == -EEXIST)
>  					sysfs_warn_dup(kobj->sd, grp->name);
> diff --git a/include/linux/kernfs.h b/include/linux/kernfs.h
> index cd968ee2b503..818b00ebd107 100644
> --- a/include/linux/kernfs.h
> +++ b/include/linux/kernfs.h
> @@ -161,6 +161,7 @@ struct kernfs_node {
>  	unsigned short		flags;
>  	umode_t			mode;
>  	struct kernfs_iattrs	*iattr;
> +	struct module           *owner;
>  };
>  
>  /*
> @@ -370,7 +371,8 @@ void kernfs_destroy_root(struct kernfs_root *root);
>  struct kernfs_node *kernfs_create_dir_ns(struct kernfs_node *parent,
>  					 const char *name, umode_t mode,
>  					 kuid_t uid, kgid_t gid,
> -					 void *priv, const void *ns);
> +					 void *priv, const void *ns,
> +					 struct module *owner);
>  struct kernfs_node *kernfs_create_empty_dir(struct kernfs_node *parent,
>  					    const char *name);
>  struct kernfs_node *__kernfs_create_file(struct kernfs_node *parent,
> @@ -379,7 +381,8 @@ struct kernfs_node *__kernfs_create_file(struct kernfs_node *parent,
>  					 loff_t size,
>  					 const struct kernfs_ops *ops,
>  					 void *priv, const void *ns,
> -					 struct lock_class_key *key);
> +					 struct lock_class_key *key,
> +					 struct module *owner);
>  struct kernfs_node *kernfs_create_link(struct kernfs_node *parent,
>  				       const char *name,
>  				       struct kernfs_node *target);
> @@ -472,14 +475,15 @@ static inline void kernfs_destroy_root(struct kernfs_root *root) { }
>  static inline struct kernfs_node *
>  kernfs_create_dir_ns(struct kernfs_node *parent, const char *name,
>  		     umode_t mode, kuid_t uid, kgid_t gid,
> -		     void *priv, const void *ns)
> +		     void *priv, const void *ns, struct module *owner)
>  { return ERR_PTR(-ENOSYS); }
>  
>  static inline struct kernfs_node *
>  __kernfs_create_file(struct kernfs_node *parent, const char *name,
>  		     umode_t mode, kuid_t uid, kgid_t gid,
>  		     loff_t size, const struct kernfs_ops *ops,
> -		     void *priv, const void *ns, struct lock_class_key *key)
> +		     void *priv, const void *ns, struct lock_class_key *key,
> +		     struct module *owner)
>  { return ERR_PTR(-ENOSYS); }
>  
>  static inline struct kernfs_node *
> @@ -566,7 +570,7 @@ kernfs_create_dir(struct kernfs_node *parent, const char *name, umode_t mode,
>  {
>  	return kernfs_create_dir_ns(parent, name, mode,
>  				    GLOBAL_ROOT_UID, GLOBAL_ROOT_GID,
> -				    priv, NULL);
> +				    priv, NULL, parent->owner);
>  }
>  
>  static inline int kernfs_remove_by_name(struct kernfs_node *parent,
> diff --git a/include/linux/sysfs.h b/include/linux/sysfs.h
> index e3f1e8ac1f85..babbabb460dc 100644
> --- a/include/linux/sysfs.h
> +++ b/include/linux/sysfs.h
> @@ -30,6 +30,7 @@ enum kobj_ns_type;
>  struct attribute {
>  	const char		*name;
>  	umode_t			mode;
> +	struct module           *owner;
>  #ifdef CONFIG_DEBUG_LOCK_ALLOC
>  	bool			ignore_lockdep:1;
>  	struct lock_class_key	*key;
> @@ -80,6 +81,7 @@ do {							\
>   * @attrs:	Pointer to NULL terminated list of attributes.
>   * @bin_attrs:	Pointer to NULL terminated list of binary attributes.
>   *		Either attrs or bin_attrs or both must be provided.
> + * @module:	If set, module responsible for this attribute group
>   */
>  struct attribute_group {
>  	const char		*name;
> @@ -89,6 +91,7 @@ struct attribute_group {
>  						  struct bin_attribute *, int);
>  	struct attribute	**attrs;
>  	struct bin_attribute	**bin_attrs;
> +	struct module           *owner;
>  };
>  
>  /*
> @@ -100,38 +103,52 @@ struct attribute_group {
>  
>  #define __ATTR(_name, _mode, _show, _store) {				\
>  	.attr = {.name = __stringify(_name),				\
> -		 .mode = VERIFY_OCTAL_PERMISSIONS(_mode) },		\
> +		 .mode = VERIFY_OCTAL_PERMISSIONS(_mode),               \
> +		 .owner  = THIS_MODULE,                                 \
> +	},                                                             \
>  	.show	= _show,						\
>  	.store	= _store,						\
>  }
>  
>  #define __ATTR_PREALLOC(_name, _mode, _show, _store) {			\
>  	.attr = {.name = __stringify(_name),				\
> -		 .mode = SYSFS_PREALLOC | VERIFY_OCTAL_PERMISSIONS(_mode) },\
> +		 .mode = SYSFS_PREALLOC | VERIFY_OCTAL_PERMISSIONS(_mode),\
> +		 .owner  = THIS_MODULE,                                 \
> +	},                                                              \
>  	.show	= _show,						\
>  	.store	= _store,						\
>  }
>  
>  #define __ATTR_RO(_name) {						\
> -	.attr	= { .name = __stringify(_name), .mode = 0444 },		\
> +	.attr	= { .name = __stringify(_name),                         \
> +		    .mode = 0444,					\
> +		    .owner  = THIS_MODULE,				\
> +		},                                                     \
>  	.show	= _name##_show,						\
>  }
>  
>  #define __ATTR_RO_MODE(_name, _mode) {					\
>  	.attr	= { .name = __stringify(_name),				\
> -		    .mode = VERIFY_OCTAL_PERMISSIONS(_mode) },		\
> +		    .mode = VERIFY_OCTAL_PERMISSIONS(_mode),            \
> +		    .owner  = THIS_MODULE,				\
> +	},                                                              \
>  	.show	= _name##_show,						\
>  }
>  
>  #define __ATTR_RW_MODE(_name, _mode) {					\
>  	.attr	= { .name = __stringify(_name),				\
> -		    .mode = VERIFY_OCTAL_PERMISSIONS(_mode) },		\
> +		    .mode = VERIFY_OCTAL_PERMISSIONS(_mode),            \
> +		    .owner  = THIS_MODULE,                              \
> +	},								\
>  	.show	= _name##_show,						\
>  	.store	= _name##_store,					\
>  }
>  
>  #define __ATTR_WO(_name) {						\
> -	.attr	= { .name = __stringify(_name), .mode = 0200 },		\
> +	.attr	= { .name = __stringify(_name),                         \
> +		    .mode = 0200,					\
> +		    .owner  = THIS_MODULE,				\
> +	},                                                              \
>  	.store	= _name##_store,					\
>  }
>  
> @@ -141,8 +158,11 @@ struct attribute_group {
>  
>  #ifdef CONFIG_DEBUG_LOCK_ALLOC
>  #define __ATTR_IGNORE_LOCKDEP(_name, _mode, _show, _store) {	\
> -	.attr = {.name = __stringify(_name), .mode = _mode,	\
> -			.ignore_lockdep = true },		\
> +	.attr = {.name = __stringify(_name),                    \
> +		 .mode = _mode,					\
> +		 .ignore_lockdep = true,                        \
> +		 .owner  = THIS_MODULE,                         \
> +	},							\
>  	.show		= _show,				\
>  	.store		= _store,				\
>  }
> @@ -159,6 +179,7 @@ static const struct attribute_group *_name##_groups[] = {	\
>  #define ATTRIBUTE_GROUPS(_name)					\
>  static const struct attribute_group _name##_group = {		\
>  	.attrs = _name##_attrs,					\
> +	.owner = THIS_MODULE,					\
>  };								\
>  __ATTRIBUTE_GROUPS(_name)
>  
> @@ -199,20 +220,29 @@ struct bin_attribute {
>  
>  /* macros to create static binary attributes easier */
>  #define __BIN_ATTR(_name, _mode, _read, _write, _size) {		\
> -	.attr = { .name = __stringify(_name), .mode = _mode },		\
> +	.attr = { .name = __stringify(_name),                           \
> +		   .mode = _mode,					\
> +		   .owner = THIS_MODULE,				\
> +	},								\
>  	.read	= _read,						\
>  	.write	= _write,						\
>  	.size	= _size,						\
>  }
>  
>  #define __BIN_ATTR_RO(_name, _size) {					\
> -	.attr	= { .name = __stringify(_name), .mode = 0444 },		\
> +	.attr	= { .name = __stringify(_name),                         \
> +		    .mode = 0444,					\
> +		    .owner = THIS_MODULE,				\
> +	},								\
>  	.read	= _name##_read,						\
>  	.size	= _size,						\
>  }
>  
>  #define __BIN_ATTR_WO(_name, _size) {					\
> -	.attr	= { .name = __stringify(_name), .mode = 0200 },		\
> +	.attr	= { .name = __stringify(_name),                         \
> +		    .mode = 0200,					\
> +		    .owner = THIS_MODULE,				\
> +	},								\
>  	.write	= _name##_write,					\
>  	.size	= _size,						\
>  }
> diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
> index 9e0390000025..c6b0a28f599c 100644
> --- a/kernel/cgroup/cgroup.c
> +++ b/kernel/cgroup/cgroup.c
> @@ -3975,7 +3975,7 @@ static int cgroup_add_file(struct cgroup_subsys_state *css, struct cgroup *cgrp,
>  				  cgroup_file_mode(cft),
>  				  GLOBAL_ROOT_UID, GLOBAL_ROOT_GID,
>  				  0, cft->kf_ops, cft,
> -				  NULL, key);
> +				  NULL, key, NULL);
>  	if (IS_ERR(kn))
>  		return PTR_ERR(kn);
>  
> -- 
> 2.30.2
> 

-- 
Kees Cook
