Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C90619836C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Mar 2020 20:30:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727469AbgC3SaG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Mar 2020 14:30:06 -0400
Received: from smtp-42af.mail.infomaniak.ch ([84.16.66.175]:54265 "EHLO
        smtp-42af.mail.infomaniak.ch" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727522AbgC3SaC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Mar 2020 14:30:02 -0400
Received: from smtp-2-0001.mail.infomaniak.ch (unknown [10.5.36.108])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 48rgx26ghWzlhfxt;
        Mon, 30 Mar 2020 20:29:58 +0200 (CEST)
Received: from ns3096276.ip-94-23-54.eu (unknown [94.23.54.103])
        by smtp-2-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 48rgx16CWXzllKQq;
        Mon, 30 Mar 2020 20:29:57 +0200 (CEST)
Subject: Re: [PATCH v15 05/10] fs,landlock: Support filesystem access-control
To:     linux-kernel@vger.kernel.org
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@amacapital.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Casey Schaufler <casey@schaufler-ca.com>,
        James Morris <jmorris@namei.org>, Jann Horn <jann@thejh.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mickael.salaun@ssi.gouv.fr>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Shuah Khan <shuah@kernel.org>,
        Vincent Dagonneau <vincent.dagonneau@ssi.gouv.fr>,
        kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-security-module@vger.kernel.org, x86@kernel.org
References: <20200326202731.693608-1-mic@digikod.net>
 <20200326202731.693608-6-mic@digikod.net>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Message-ID: <66ab44b6-4681-9cfd-4adc-c30a88764fe2@digikod.net>
Date:   Mon, 30 Mar 2020 20:29:57 +0200
User-Agent: 
MIME-Version: 1.0
In-Reply-To: <20200326202731.693608-6-mic@digikod.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Antivirus: Dr.Web (R) for Unix mail servers drweb plugin ver.6.0.2.8
X-Antivirus-Code: 0x100000
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The next version will improve the rule layers as described here:
https://lore.kernel.org/lkml/e07fe473-1801-01cc-12ae-b3167f95250e@digikod.net/


On 26/03/2020 21:27, Mickaël Salaün wrote:
> Thanks to the Landlock objects and ruleset, it is possible to identify
> inodes according to a process's domain.  To enable an unprivileged
> process to express a file hierarchy, it first needs to open a directory
> (or a file) and pass this file descriptor to the kernel through
> landlock(2).  When checking if a file access request is allowed, we walk
> from the requested dentry to the real root, following the different
> mount layers.  The access to each "tagged" inodes are collected
> according to their rule layer level, and ANDed to create access to the
> requested file hierarchy.  This makes possible to identify a lot of
> files without tagging every inodes nor modifying the filesystem, while
> still following the view and understanding the user has from the
> filesystem.
> 
> Signed-off-by: Mickaël Salaün <mic@digikod.net>
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Cc: Andy Lutomirski <luto@amacapital.net>
> Cc: James Morris <jmorris@namei.org>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Serge E. Hallyn <serge@hallyn.com>
> ---
> 
> Changes since v14:
> * Simplify the object, rule and ruleset management at the expense of a
>   less aggressive memory freeing (contributed by Jann Horn, with
>   additional modifications):
>   - Rewrite release_inode() to use inode->sb->s_landlock_inode_refs.
>   - Remove useless checks in landlock_release_inodes(), clean object
>     pointer according to the new struct landlock_object and wait for all
>     iput() to complete.
>   - Rewrite get_inode_object() according to the new struct
>     landlock_object.  If there is a race-condition when cleaning up an
>     object, we retry until the concurrent thread finished the object
>     cleaning.
>   Cf. https://lore.kernel.org/lkml/CAG48ez21bEn0wL1bbmTiiu8j9jP5iEWtHOwz4tURUJ+ki0ydYw@mail.gmail.com/
> * Fix nested domains by implementing a notion of layer level and depth:
>   - Check for matching level ranges when walking through a file path.
>   - Only allow access if every layer granted the access request.
> * Handles files without mount points (e.g. pipes).
> * Hardens path walk by checking inode pointer values.
> * Prefetches d_parent when walking to the root directory.
> * Remove useless inode_alloc_security hook() (suggested by Jann Horn):
>   already initialized by lsm_inode_alloc().
> * Remove the inode_free_security hook.
> * Remove access checks that may be required for FD-only requests:
>   truncate, getattr, lock, chmod, chown, chgrp, ioctl.  This will be
>   handle in a future evolution of Landlock, but right now the goal is to
>   lighten the code to ease review.
> * Constify variables.
> * Move ABI checks into syscall.c .
> * Cosmetic variable renames.
> 
> Changes since v11:
> * Add back, revamp and make a fully working filesystem access-control
>   based on paths and inodes.
> * Remove the eBPF dependency.
> 
> Previous version:
> https://lore.kernel.org/lkml/20190721213116.23476-6-mic@digikod.net/
> ---
>  MAINTAINERS                |   1 +
>  fs/super.c                 |   2 +
>  include/linux/fs.h         |   5 +
>  include/linux/landlock.h   |  22 ++
>  security/landlock/Makefile |   2 +-
>  security/landlock/fs.c     | 561 +++++++++++++++++++++++++++++++++++++
>  security/landlock/fs.h     |  42 +++
>  security/landlock/setup.c  |   6 +
>  security/landlock/setup.h  |   2 +
>  9 files changed, 642 insertions(+), 1 deletion(-)
>  create mode 100644 include/linux/landlock.h
>  create mode 100644 security/landlock/fs.c
>  create mode 100644 security/landlock/fs.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f8fa29e0f550..3e917d9abce3 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9364,6 +9364,7 @@ L:	linux-security-module@vger.kernel.org
>  W:	https://landlock.io
>  T:	git https://github.com/landlock-lsm/linux.git
>  S:	Supported
> +F:	include/linux/landlock.h
>  F:	include/uapi/linux/landlock.h
>  F:	security/landlock/
>  K:	landlock
> diff --git a/fs/super.c b/fs/super.c
> index cd352530eca9..4ad6a64a1706 100644
> --- a/fs/super.c
> +++ b/fs/super.c
> @@ -34,6 +34,7 @@
>  #include <linux/cleancache.h>
>  #include <linux/fscrypt.h>
>  #include <linux/fsnotify.h>
> +#include <linux/landlock.h>
>  #include <linux/lockdep.h>
>  #include <linux/user_namespace.h>
>  #include <linux/fs_context.h>
> @@ -454,6 +455,7 @@ void generic_shutdown_super(struct super_block *sb)
>  		evict_inodes(sb);
>  		/* only nonzero refcount inodes can have marks */
>  		fsnotify_sb_delete(sb);
> +		landlock_release_inodes(sb);
>  
>  		if (sb->s_dio_done_wq) {
>  			destroy_workqueue(sb->s_dio_done_wq);
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index abedbffe2c9e..24e2e9b5a704 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -1512,6 +1512,11 @@ struct super_block {
>  	/* Pending fsnotify inode refs */
>  	atomic_long_t s_fsnotify_inode_refs;
>  
> +#ifdef CONFIG_SECURITY_LANDLOCK
> +	/* References to Landlock underlying objects */
> +	atomic_long_t s_landlock_inode_refs;
> +#endif
> +
>  	/* Being remounted read-only */
>  	int s_readonly_remount;
>  
> diff --git a/include/linux/landlock.h b/include/linux/landlock.h
> new file mode 100644
> index 000000000000..0fb16d130b0a
> --- /dev/null
> +++ b/include/linux/landlock.h
> @@ -0,0 +1,22 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Landlock LSM - public kernel headers
> + *
> + * Copyright © 2016-2019 Mickaël Salaün <mic@digikod.net>
> + * Copyright © 2018-2019 ANSSI
> + */
> +
> +#ifndef _LINUX_LANDLOCK_H
> +#define _LINUX_LANDLOCK_H
> +
> +#include <linux/fs.h>
> +
> +#ifdef CONFIG_SECURITY_LANDLOCK
> +extern void landlock_release_inodes(struct super_block *sb);
> +#else
> +static inline void landlock_release_inodes(struct super_block *sb)
> +{
> +}
> +#endif
> +
> +#endif /* _LINUX_LANDLOCK_H */
> diff --git a/security/landlock/Makefile b/security/landlock/Makefile
> index f1d1eb72fa76..92e3d80ab8ed 100644
> --- a/security/landlock/Makefile
> +++ b/security/landlock/Makefile
> @@ -1,4 +1,4 @@
>  obj-$(CONFIG_SECURITY_LANDLOCK) := landlock.o
>  
>  landlock-y := setup.o object.o ruleset.o \
> -	cred.o ptrace.o
> +	cred.o ptrace.o fs.o
> diff --git a/security/landlock/fs.c b/security/landlock/fs.c
> new file mode 100644
> index 000000000000..9531e9c6664d
> --- /dev/null
> +++ b/security/landlock/fs.c
> @@ -0,0 +1,561 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Landlock LSM - Filesystem management and hooks
> + *
> + * Copyright © 2016-2020 Mickaël Salaün <mic@digikod.net>
> + * Copyright © 2018-2020 ANSSI
> + */
> +
> +#include <linux/compiler_types.h>
> +#include <linux/dcache.h>
> +#include <linux/fs.h>
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/landlock.h>
> +#include <linux/list.h>
> +#include <linux/lsm_hooks.h>
> +#include <linux/mount.h>
> +#include <linux/namei.h>
> +#include <linux/path.h>
> +#include <linux/prefetch.h>
> +#include <linux/rcupdate.h>
> +#include <linux/spinlock.h>
> +#include <linux/stat.h>
> +#include <linux/types.h>
> +#include <linux/wait_bit.h>
> +#include <linux/workqueue.h>
> +#include <uapi/linux/landlock.h>
> +
> +#include "common.h"
> +#include "cred.h"
> +#include "fs.h"
> +#include "object.h"
> +#include "ruleset.h"
> +#include "setup.h"
> +
> +/* Underlying object management */
> +
> +static void release_inode(struct landlock_object *const object)
> +	__releases(object->lock)
> +{
> +	struct inode *const inode = object->underobj;
> +	struct super_block *sb;
> +
> +	if (!inode) {
> +		spin_unlock(&object->lock);
> +		return;
> +	}
> +
> +	spin_lock(&inode->i_lock);
> +	/*
> +	 * Make sure that if the filesystem is concurrently unmounted,
> +	 * landlock_release_inodes() will wait for us to finish iput().
> +	 */
> +	sb = inode->i_sb;
> +	atomic_long_inc(&sb->s_landlock_inode_refs);
> +	rcu_assign_pointer(inode_landlock(inode)->object, NULL);
> +	spin_unlock(&inode->i_lock);
> +	spin_unlock(&object->lock);
> +	/*
> +	 * Now, new rules can safely be tied to @inode.
> +	 */
> +
> +	iput(inode);
> +	if (atomic_long_dec_and_test(&sb->s_landlock_inode_refs))
> +		wake_up_var(&sb->s_landlock_inode_refs);
> +}
> +
> +static const struct landlock_object_underops landlock_fs_underops = {
> +	.release = release_inode
> +};
> +
> +/*
> + * Release the inodes used in a security policy.
> + *
> + * Cf. fsnotify_unmount_inodes()
> + */
> +void landlock_release_inodes(struct super_block *const sb)
> +{
> +	struct inode *inode, *iput_inode = NULL;
> +
> +	if (!landlock_initialized)
> +		return;
> +
> +	spin_lock(&sb->s_inode_list_lock);
> +	list_for_each_entry(inode, &sb->s_inodes, i_sb_list) {
> +		struct landlock_inode_security *inode_sec =
> +			inode_landlock(inode);
> +		struct landlock_object *object;
> +		bool do_put = false;
> +
> +		rcu_read_lock();
> +		object = rcu_dereference(inode_sec->object);
> +		if (!object) {
> +			rcu_read_unlock();
> +			continue;
> +		}
> +
> +		spin_lock(&object->lock);
> +		if (object->underobj) {
> +			object->underobj = NULL;
> +			do_put = true;
> +			spin_lock(&inode->i_lock);
> +			rcu_assign_pointer(inode_sec->object, NULL);
> +			spin_unlock(&inode->i_lock);
> +		}
> +		spin_unlock(&object->lock);
> +		rcu_read_unlock();
> +		if (!do_put)
> +			/*
> +			 * A concurrent iput() in release_inode() is ongoing
> +			 * and we will just wait for it to finish.
> +			 */
> +			continue;
> +
> +		/*
> +		 * At this point, we own the ihold() reference that was
> +		 * originally set up by get_inode_object(). Therefore we can
> +		 * drop the list lock and know that the inode won't disappear
> +		 * from under us until the next loop walk.
> +		 */
> +		spin_unlock(&sb->s_inode_list_lock);
> +		/*
> +		 * We can now actually put the previous inode, which is not
> +		 * needed anymore for the loop walk.
> +		 */
> +		if (iput_inode)
> +			iput(iput_inode);
> +		iput_inode = inode;
> +		spin_lock(&sb->s_inode_list_lock);
> +	}
> +	spin_unlock(&sb->s_inode_list_lock);
> +	if (iput_inode)
> +		iput(iput_inode);
> +
> +	/*
> +	 * Wait for pending iput() in release_inode().
> +	 */
> +	wait_var_event(&sb->s_landlock_inode_refs,
> +			!atomic_long_read(&sb->s_landlock_inode_refs));
> +}
> +
> +/* Ruleset management */
> +
> +static struct landlock_object *get_inode_object(struct inode *const inode)
> +{
> +	struct landlock_object *object, *new_object;
> +	struct landlock_inode_security *inode_sec = inode_landlock(inode);
> +
> +	rcu_read_lock();
> +retry:
> +	object = rcu_dereference(inode_sec->object);
> +	if (object) {
> +		if (likely(refcount_inc_not_zero(&object->usage))) {
> +			rcu_read_unlock();
> +			return object;
> +		}
> +		/*
> +		 * We're racing with release_inode(), the object is going away.
> +		 * Wait for release_inode(), then retry.
> +		 */
> +		spin_lock(&object->lock);
> +		spin_unlock(&object->lock);
> +		goto retry;
> +	}
> +	rcu_read_unlock();
> +
> +	/*
> +	 * If there is no object tied to @inode, then create a new one (without
> +	 * holding any locks).
> +	 */
> +	new_object = landlock_create_object(&landlock_fs_underops, inode);
> +
> +	spin_lock(&inode->i_lock);
> +	object = rcu_dereference_protected(inode_sec->object,
> +			lockdep_is_held(&inode->i_lock));
> +	if (unlikely(object)) {
> +		/* Someone else just created the object, bail out and retry. */
> +		kfree(new_object);
> +		spin_unlock(&inode->i_lock);
> +
> +		rcu_read_lock();
> +		goto retry;
> +	} else {
> +		rcu_assign_pointer(inode_sec->object, new_object);
> +		/*
> +		 * @inode will be released by landlock_release_inodes() on its
> +		 * super-block shutdown.
> +		 */
> +		ihold(inode);
> +		spin_unlock(&inode->i_lock);
> +		return new_object;
> +	}
> +}
> +
> +/*
> + * @path: Should have been checked by get_path_from_fd().
> + */
> +int landlock_append_fs_rule(struct landlock_ruleset *const ruleset,
> +		const struct path *const path, u32 access_hierarchy)
> +{
> +	int err;
> +	struct landlock_rule rule = {};
> +
> +	/* Transforms relative access rights to absolute ones. */
> +	access_hierarchy |= _LANDLOCK_ACCESS_FS_MASK &
> +		~ruleset->fs_access_mask;
> +	rule.access.self = access_hierarchy;
> +	rule.access.beneath = access_hierarchy;
> +	rule.object = get_inode_object(d_backing_inode(path->dentry));
> +	mutex_lock(&ruleset->lock);
> +	err = landlock_insert_rule(ruleset, &rule, false);
> +	mutex_unlock(&ruleset->lock);
> +	/*
> +	 * No need to check for an error because landlock_insert_rule()
> +	 * increment the refcount for the new rule, if any.
> +	 */
> +	landlock_put_object(rule.object);
> +	return err;
> +}
> +
> +/* Access-control management */
> +
> +static bool check_access_path_continue(
> +		const struct landlock_ruleset *const domain,
> +		const struct path *const path, const u32 access_request,
> +		const bool check_self, bool *const allow,
> +		u32 *const layer_level)
> +{
> +	const struct landlock_rule *rule;
> +	const struct inode *inode;
> +	bool next = true;
> +
> +	inode = d_backing_inode(path->dentry);
> +	if (WARN_ON_ONCE(!inode)) {
> +		/*
> +		 * Access denied when the absolute path contains a dentry
> +		 * without inode.
> +		 */
> +		*allow = false;
> +		return false;
> +	}
> +	prefetch(path->dentry->d_parent);
> +	rcu_read_lock();
> +	rule = landlock_find_rule(domain,
> +			rcu_dereference(inode_landlock(inode)->object));
> +	rcu_read_unlock();
> +
> +	/* Checks for a matching layer level range. */
> +	if (rule && (rule->layer_level - rule->layer_depth) < *layer_level &&
> +			*layer_level <= rule->layer_level) {
> +		*allow = ((check_self ? rule->access.self :
> +					rule->access.beneath) & access_request)
> +				== access_request;
> +		if (*allow) {
> +			*layer_level -= rule->layer_depth;
> +			/* Stops when reaching the last layer. */
> +			next = (*layer_level > 0);
> +		} else {
> +			next = false;
> +		}
> +	}
> +	return next;
> +}
> +
> +static int check_access_path(const struct landlock_ruleset *const domain,
> +		const struct path *const path, u32 access_request)
> +{
> +	bool allow = false;
> +	struct path walker_path;
> +	u32 walker_layer_level = domain->top_layer_level;
> +
> +	if (WARN_ON_ONCE(!path))
> +		return 0;
> +	/*
> +	 * An access request which is not handled by the domain should be
> +	 * allowed.
> +	 */
> +	access_request &= domain->fs_access_mask;
> +	if (access_request == 0)
> +		return 0;
> +	walker_path = *path;
> +	path_get(&walker_path);
> +	if (check_access_path_continue(domain, &walker_path, access_request,
> +				true, &allow, &walker_layer_level)) {
> +		/*
> +		 * We need to walk through all the hierarchy to not miss any
> +		 * relevant restriction.
> +		 */
> +		do {
> +			struct dentry *parent_dentry;
> +
> +jump_up:
> +			/*
> +			 * Does not work with orphaned/private mounts like
> +			 * overlayfs layers for now (cf. ovl_path_real() and
> +			 * ovl_path_open()).
> +			 */
> +			if (walker_path.dentry == walker_path.mnt->mnt_root) {
> +				if (follow_up(&walker_path)) {
> +					/* Ignores hidden mount points. */
> +					goto jump_up;
> +				} else {
> +					/*
> +					 * Stops at the real root.  Denies
> +					 * access because not all layers have
> +					 * granted access.
> +					 */
> +					allow = false;
> +					break;
> +				}
> +			}
> +			if (IS_ROOT(walker_path.dentry)) {
> +				/*
> +				 * Stops at directory without mount points
> +				 * (e.g. pipes).  Denies access because not all
> +				 * layers have granted access.
> +				 */
> +				allow = false;
> +				break;
> +			}
> +			parent_dentry = dget_parent(walker_path.dentry);
> +			dput(walker_path.dentry);
> +			walker_path.dentry = parent_dentry;
> +		} while (check_access_path_continue(domain, &walker_path,
> +					access_request, false, &allow,
> +					&walker_layer_level));
> +	}
> +	path_put(&walker_path);
> +	return allow ? 0 : -EACCES;
> +}
> +
> +static inline int current_check_access_path(const struct path *const path,
> +		const u32 access_request)
> +{
> +	struct landlock_ruleset *dom;
> +
> +	dom = landlock_get_current_domain();
> +	if (!dom)
> +		return 0;
> +	return check_access_path(dom, path, access_request);
> +}
> +
> +/* Super-block hooks */
> +
> +/*
> + * Because a Landlock security policy is defined according to the filesystem
> + * layout (i.e. the mount namespace), changing it may grant access to files not
> + * previously allowed.
> + *
> + * To make it simple, deny any filesystem layout modification by landlocked
> + * processes.  Non-landlocked processes may still change the namespace of a
> + * landlocked process, but this kind of threat must be handled by a system-wide
> + * access-control security policy.
> + *
> + * This could be lifted in the future if Landlock can safely handle mount
> + * namespace updates requested by a landlocked process.  Indeed, we could
> + * update the current domain (which is currently read-only) by taking into
> + * account the accesses of the source and the destination of a new mount point.
> + * However, it would also require to make all the child domains dynamically
> + * inherit these new constraints.  Anyway, for backward compatibility reasons,
> + * a dedicated user space option would be required (e.g. as a ruleset command
> + * option).
> + */
> +static int hook_sb_mount(const char *const dev_name,
> +		const struct path *const path, const char *const type,
> +		const unsigned long flags, void *const data)
> +{
> +	if (!landlock_get_current_domain())
> +		return 0;
> +	return -EPERM;
> +}
> +
> +static int hook_move_mount(const struct path *const from_path,
> +		const struct path *const to_path)
> +{
> +	if (!landlock_get_current_domain())
> +		return 0;
> +	return -EPERM;
> +}
> +
> +/*
> + * Removing a mount point may reveal a previously hidden file hierarchy, which
> + * may then grant access to files, which may have previously been forbidden.
> + */
> +static int hook_sb_umount(struct vfsmount *const mnt, const int flags)
> +{
> +	if (!landlock_get_current_domain())
> +		return 0;
> +	return -EPERM;
> +}
> +
> +static int hook_sb_remount(struct super_block *const sb, void *const mnt_opts)
> +{
> +	if (!landlock_get_current_domain())
> +		return 0;
> +	return -EPERM;
> +}
> +
> +/*
> + * pivot_root(2), like mount(2), changes the current mount namespace.  It must
> + * then be forbidden for a landlocked process.
> + *
> + * However, chroot(2) may be allowed because it only changes the relative root
> + * directory of the current process.
> + */
> +static int hook_sb_pivotroot(const struct path *const old_path,
> +		const struct path *const new_path)
> +{
> +	if (!landlock_get_current_domain())
> +		return 0;
> +	return -EPERM;
> +}
> +
> +/* Path hooks */
> +
> +static int hook_path_link(struct dentry *const old_dentry,
> +		const struct path *const new_dir,
> +		struct dentry *const new_dentry)
> +{
> +	return current_check_access_path(new_dir, LANDLOCK_ACCESS_FS_LINK_TO);
> +}
> +
> +static int hook_path_mkdir(const struct path *const dir,
> +		struct dentry *const dentry, const umode_t mode)
> +{
> +	return current_check_access_path(dir, LANDLOCK_ACCESS_FS_MAKE_DIR);
> +}
> +
> +static inline u32 get_mode_access(const umode_t mode)
> +{
> +	switch (mode & S_IFMT) {
> +	case S_IFLNK:
> +		return LANDLOCK_ACCESS_FS_MAKE_SYM;
> +	case S_IFREG:
> +		return LANDLOCK_ACCESS_FS_MAKE_REG;
> +	case S_IFDIR:
> +		return LANDLOCK_ACCESS_FS_MAKE_DIR;
> +	case S_IFCHR:
> +		return LANDLOCK_ACCESS_FS_MAKE_CHAR;
> +	case S_IFBLK:
> +		return LANDLOCK_ACCESS_FS_MAKE_BLOCK;
> +	case S_IFIFO:
> +		return LANDLOCK_ACCESS_FS_MAKE_FIFO;
> +	case S_IFSOCK:
> +		return LANDLOCK_ACCESS_FS_MAKE_SOCK;
> +	default:
> +		WARN_ON_ONCE(1);
> +		return 0;
> +	}
> +}
> +
> +static int hook_path_mknod(const struct path *const dir,
> +		struct dentry *const dentry, const umode_t mode,
> +		const unsigned int dev)
> +{
> +	return current_check_access_path(dir, get_mode_access(mode));
> +}
> +
> +static int hook_path_symlink(const struct path *const dir,
> +		struct dentry *const dentry, const char *const old_name)
> +{
> +	return current_check_access_path(dir, LANDLOCK_ACCESS_FS_MAKE_SYM);
> +}
> +
> +static int hook_path_unlink(const struct path *const dir,
> +		struct dentry *const dentry)
> +{
> +	return current_check_access_path(dir, LANDLOCK_ACCESS_FS_UNLINK);
> +}
> +
> +static int hook_path_rmdir(const struct path *const dir,
> +		struct dentry *const dentry)
> +{
> +	return current_check_access_path(dir, LANDLOCK_ACCESS_FS_RMDIR);
> +}
> +
> +static int hook_path_rename(const struct path *const old_dir,
> +		struct dentry *const old_dentry,
> +		const struct path *const new_dir,
> +		struct dentry *const new_dentry)
> +{
> +	struct landlock_ruleset *dom;
> +	int err;
> +
> +	dom = landlock_get_current_domain();
> +	if (!dom)
> +		return 0;
> +	err = check_access_path(dom, old_dir, LANDLOCK_ACCESS_FS_RENAME_FROM);
> +	if (err)
> +		return err;
> +	return check_access_path(dom, new_dir, LANDLOCK_ACCESS_FS_RENAME_TO);
> +}
> +
> +static int hook_path_chroot(const struct path *const path)
> +{
> +	return current_check_access_path(path, LANDLOCK_ACCESS_FS_CHROOT);
> +}
> +
> +/* File hooks */
> +
> +static inline u32 get_file_access(const struct file *const file)
> +{
> +	u32 access = 0;
> +
> +	if (file->f_mode & FMODE_READ) {
> +		/* A directory can only be opened in read mode. */
> +		if (S_ISDIR(file_inode(file)->i_mode))
> +			access |= LANDLOCK_ACCESS_FS_READ_DIR;
> +		else
> +			access |= LANDLOCK_ACCESS_FS_READ_FILE;
> +	}
> +	/*
> +	 * A LANDLOCK_ACCESS_FS_APPEND could be added be we also need to check
> +	 * fcntl(2).
> +	 */
> +	if (file->f_mode & FMODE_WRITE)
> +		access |= LANDLOCK_ACCESS_FS_WRITE_FILE;
> +	/* __FMODE_EXEC is indeed part of f_flags, not f_mode. */
> +	if (file->f_flags & __FMODE_EXEC)
> +		access |= LANDLOCK_ACCESS_FS_EXECUTE;
> +	return access;
> +}
> +
> +static int hook_file_open(struct file *const file)
> +{
> +	if (WARN_ON_ONCE(!file))
> +		return 0;
> +	if (!file_inode(file))
> +		return -ENOENT;
> +	/*
> +	 * Because a file may be opened with O_PATH, get_file_access() may
> +	 * return 0.  This case will be handled with a future Landlock
> +	 * evolution.
> +	 */
> +	return current_check_access_path(&file->f_path, get_file_access(file));
> +}
> +
> +static struct security_hook_list landlock_hooks[] __lsm_ro_after_init = {
> +	LSM_HOOK_INIT(sb_mount, hook_sb_mount),
> +	LSM_HOOK_INIT(move_mount, hook_move_mount),
> +	LSM_HOOK_INIT(sb_umount, hook_sb_umount),
> +	LSM_HOOK_INIT(sb_remount, hook_sb_remount),
> +	LSM_HOOK_INIT(sb_pivotroot, hook_sb_pivotroot),
> +
> +	LSM_HOOK_INIT(path_link, hook_path_link),
> +	LSM_HOOK_INIT(path_mkdir, hook_path_mkdir),
> +	LSM_HOOK_INIT(path_mknod, hook_path_mknod),
> +	LSM_HOOK_INIT(path_symlink, hook_path_symlink),
> +	LSM_HOOK_INIT(path_unlink, hook_path_unlink),
> +	LSM_HOOK_INIT(path_rmdir, hook_path_rmdir),
> +	LSM_HOOK_INIT(path_rename, hook_path_rename),
> +	LSM_HOOK_INIT(path_chroot, hook_path_chroot),
> +
> +	LSM_HOOK_INIT(file_open, hook_file_open),
> +};
> +
> +__init void landlock_add_hooks_fs(void)
> +{
> +	security_add_hooks(landlock_hooks, ARRAY_SIZE(landlock_hooks),
> +			LANDLOCK_NAME);
> +}
> diff --git a/security/landlock/fs.h b/security/landlock/fs.h
> new file mode 100644
> index 000000000000..2cf55ed1e800
> --- /dev/null
> +++ b/security/landlock/fs.h
> @@ -0,0 +1,42 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Landlock LSM - Filesystem management and hooks
> + *
> + * Copyright © 2017-2020 Mickaël Salaün <mic@digikod.net>
> + * Copyright © 2018-2020 ANSSI
> + */
> +
> +#ifndef _SECURITY_LANDLOCK_FS_H
> +#define _SECURITY_LANDLOCK_FS_H
> +
> +#include <linux/fs.h>
> +#include <linux/init.h>
> +#include <linux/rcupdate.h>
> +
> +#include "ruleset.h"
> +#include "setup.h"
> +
> +struct landlock_inode_security {
> +	/*
> +	 * @object: Weak pointer to an allocated object.  All writes (i.e.
> +	 * creating a new object or removing one) are protected by the
> +	 * underlying inode->i_lock.  Disassociating @object from the inode is
> +	 * additionally protected by @object->lock, from the time @object's
> +	 * usage refcount drops to zero to the time this pointer is nulled out.
> +	 * Cf. release_inode().
> +	 */
> +	struct landlock_object __rcu *object;
> +};
> +
> +static inline struct landlock_inode_security *inode_landlock(
> +		const struct inode *const inode)
> +{
> +	return inode->i_security + landlock_blob_sizes.lbs_inode;
> +}
> +
> +__init void landlock_add_hooks_fs(void);
> +
> +int landlock_append_fs_rule(struct landlock_ruleset *const ruleset,
> +		const struct path *const path, u32 access_hierarchy);
> +
> +#endif /* _SECURITY_LANDLOCK_FS_H */
> diff --git a/security/landlock/setup.c b/security/landlock/setup.c
> index a40822135d13..f77fc7749f49 100644
> --- a/security/landlock/setup.c
> +++ b/security/landlock/setup.c
> @@ -11,11 +11,15 @@
>  
>  #include "common.h"
>  #include "cred.h"
> +#include "fs.h"
>  #include "ptrace.h"
>  #include "setup.h"
>  
> +bool landlock_initialized __lsm_ro_after_init = false;
> +
>  struct lsm_blob_sizes landlock_blob_sizes __lsm_ro_after_init = {
>  	.lbs_cred = sizeof(struct landlock_cred_security),
> +	.lbs_inode = sizeof(struct landlock_inode_security),
>  };
>  
>  static int __init landlock_init(void)
> @@ -23,6 +27,8 @@ static int __init landlock_init(void)
>  	pr_info("Registering hooks.\n");
>  	landlock_add_hooks_cred();
>  	landlock_add_hooks_ptrace();
> +	landlock_add_hooks_fs();
> +	landlock_initialized = true;
>  	return 0;
>  }
>  
> diff --git a/security/landlock/setup.h b/security/landlock/setup.h
> index 9fdbf33fcc33..1daffab1ab4b 100644
> --- a/security/landlock/setup.h
> +++ b/security/landlock/setup.h
> @@ -11,6 +11,8 @@
>  
>  #include <linux/lsm_hooks.h>
>  
> +extern bool landlock_initialized;
> +
>  extern struct lsm_blob_sizes landlock_blob_sizes;
>  
>  #endif /* _SECURITY_LANDLOCK_SETUP_H */
> 
