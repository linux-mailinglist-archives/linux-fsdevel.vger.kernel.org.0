Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78C703C726E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jul 2021 16:40:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236890AbhGMOnb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Jul 2021 10:43:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:56810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236873AbhGMOnb (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Jul 2021 10:43:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B9DE461249;
        Tue, 13 Jul 2021 14:40:38 +0000 (UTC)
Date:   Tue, 13 Jul 2021 16:40:36 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
Cc:     linux-fsdevel@vger.kernel.org,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Mattias Nissler <mnissler@chromium.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Andrei Vagin <avagin@gmail.com>, linux-api@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] move_mount: allow to add a mount into an existing
 group
Message-ID: <20210713144036.3kiwqgff364hw3pt@wittgenstein>
References: <20210713115636.352504-1-ptikhomirov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210713115636.352504-1-ptikhomirov@virtuozzo.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 13, 2021 at 02:56:36PM +0300, Pavel Tikhomirov wrote:
> Previously a sharing group (shared and master ids pair) can be only
> inherited when mount is created via bindmount. This patch adds an
> ability to add an existing private mount into an existing sharing group.
> 
> With this functionality one can first create the desired mount tree from
> only private mounts (without the need to care about undesired mount
> propagation or mount creation order implied by sharing group
> dependencies), and next then setup any desired mount sharing between
> those mounts in tree as needed.
> 
> This allows CRIU to restore any set of mount namespaces, mount trees and
> sharing group trees for a container.
> 
> We have many issues with restoring mounts in CRIU related to sharing
> groups and propagation:
> - reverse sharing groups vs mount tree order requires complex mounts
>   reordering which mostly implies also using some temporary mounts
> (please see https://lkml.org/lkml/2021/3/23/569 for more info)

Thanks for working on this. We can make good use of this flag as well
when setting up mount layouts and so can systemd so I'm happy to drive
this.

> 
> - mount() syscall creates tons of mounts due to propagation
> - mount re-parenting due to propagation
> - "Mount Trap" due to propagation
> - "Non Uniform" propagation, meaning that with different tricks with
>   mount order and temporary children-"lock" mounts one can create mount
>   trees which can't be restored without those tricks
> (see https://www.linuxplumbersconf.org/event/7/contributions/640/)
> 
> With this new functionality we can resolve all the problems with
> propagation at once.
> 
> Cc: Eric W. Biederman <ebiederm@xmission.com>
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Cc: Christian Brauner <christian.brauner@ubuntu.com>
> Cc: Mattias Nissler <mnissler@chromium.org>
> Cc: Aleksa Sarai <cyphar@cyphar.com>
> Cc: Andrei Vagin <avagin@gmail.com>
> Cc: linux-fsdevel@vger.kernel.org
> Cc: linux-api@vger.kernel.org
> Cc: lkml <linux-kernel@vger.kernel.org>
> Signed-off-by: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
> 
> ---
> This is a rework of "mnt: allow to add a mount into an existing group"
> patch from Andrei. https://lkml.org/lkml/2017/4/28/20
> 
> New do_set_group is similar to do_move_mount, but with many restrictions
> of do_move_mount removed and that's why:
> 
> 1) Allow "cross-namespace" sharing group set. If we allow operation only
> with mounts from current+anon mount namespace one would still be able to
> setns(from_mntns) + open_tree(from, OPEN_TREE_CLONE) + setns(to_mntns) +
> move_mount(anon, to, MOVE_MOUNT_SET_GROUP) to set sharing group to mount

That's similar to how we can do limited delegated mounting.

> in different mount namespace with source mount. But with this approach
> we would need to create anon mount namespace and mount copy each time,
> which is just a waste of resources. So instead lets just check if we are
> allowed to modify both mount namespaces (which looks equivalent to what
> setns-es and open_tree check).
> 
> 2) Allow operating on non-root dentry of the mount. As if we prohibit it
> this would require extra care from CRIU side in places where we wan't to
> copy sharing group from mount on host (for external mounts) and user
> gives us path to non-root dentry. I don't see any problem with
> referencing mount with any dentry for sharing group setting. Also there
> is no problem with referencing one by file and one by directory.

I would prefer to not do this as it doesn't line up with any other
mount modifying syscalls.

> 
> 3) Also checks wich only apply to actually moving mount which we have in
> do_move_mount and open_tree are skipped. We don't need to check
> MNT_LOCKED, unbindable, nsfs loops and ancestor relation as we don't
> move mounts.
> 
> Also let's add some new checks (offered by Andrei):
> 
> 1) Don't allow to copy sharing from mount with narrow root to a wider
> root, so that user does not have power to receive more propagations when
> user already has.
> 
> 2) Don't allow to copy sharing from mount with locked children for the
> same reason, as user shouldn't see propagations to areas overmounted by
> locked mounts (if the user could not already do it before sharing
> adjustment).
> 
> Security note: there would be no (new) loops in sharing groups tree,
> because this new move_mount(MOVE_MOUNT_SET_GROUP) operation only adds
> one _private_ mount to one group (without moving between groups), the
> sharing groups tree itself stays unchanged after it.
> 
> In Virtuozzo we have "mount-v2" implementation, based with the original
> kernel patch from Andrei, tested for almost a year and it actually
> decreased number of bugs with mounts a lot. One can take a look on the
> implementation of sharing group restore in CRIU in "mount-v2" here:
> 
> https://src.openvz.org/projects/OVZ/repos/criu/browse/criu/mount-v2.c#898
> 
> This works almost the same with current version of patch if we replace
> mount(MS_SET_GROUP) to move_mount(MOVE_MOUNT_SET_GROUP), please see
> super-draft port for mainstream criu, this at least passes
> non-user-namespaced mount tests (zdtm.py --mounts-v2 -f ns).
> 
> https://github.com/Snorch/criu/commits/mount-v2-poc
> 
> v2: Solve the problem mentioned by Andrei:
> - check mnt_root of "to" is in the sub-tree of mnt_root of "from"
> - also check "from" has no locked mounts in subroot of "to"
> 
> ---

Can you please add a simple test for this to selftests?

>  fs/namespace.c             | 65 +++++++++++++++++++++++++++++++++++++-
>  include/uapi/linux/mount.h |  3 +-
>  2 files changed, 66 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/namespace.c b/fs/namespace.c
> index ab4174a3c802..521cfd400d06 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -2684,6 +2684,66 @@ static bool check_for_nsfs_mounts(struct mount *subtree)
>  	return ret;
>  }
>  
> +static int do_set_group(struct path *from_path, struct path *to_path)
> +{
> +	struct mount *from, *to;
> +	int err;
> +
> +	from = real_mount(from_path->mnt);
> +	to = real_mount(to_path->mnt);
> +
> +	namespace_lock();
> +
> +	err = -EINVAL;
> +	/* To and From must be mounted */
> +	if (!is_mounted(&from->mnt))
> +		goto out;
> +	if (!is_mounted(&to->mnt))
> +		goto out;
> +
> +	err = -EPERM;
> +	/* We should be allowed to modify mount namespaces of both mounts */
> +	if (!ns_capable(from->mnt_ns->user_ns, CAP_SYS_ADMIN))
> +		goto out;
> +	if (!ns_capable(to->mnt_ns->user_ns, CAP_SYS_ADMIN))
> +		goto out;
> +
> +	err = -EINVAL;
> +	/* Setting sharing groups is only allowed across same superblock */
> +	if (from->mnt.mnt_sb != to->mnt.mnt_sb)
> +		goto out;
> +
> +	/* From mount root should be wider than To mount root */
> +	if (!is_subdir(to->mnt.mnt_root, from->mnt.mnt_root))
> +		goto out;
> +
> +	/* From mount should not have locked children in place of To's root */
> +	if (has_locked_children(from, to->mnt.mnt_root))
> +		goto out;
> +
> +	/* Setting sharing groups is only allowed on private mounts */
> +	if (IS_MNT_SHARED(to) || IS_MNT_SLAVE(to))
> +		goto out;
> +
> +	if (IS_MNT_SLAVE(from)) {
> +		struct mount *m = from->mnt_master;
> +
> +		list_add(&to->mnt_slave, &m->mnt_slave_list);
> +		to->mnt_master = m;
> +	}
> +
> +	if (IS_MNT_SHARED(from)) {
> +		to->mnt_group_id = from->mnt_group_id;
> +		list_add(&to->mnt_share, &from->mnt_share);
> +		set_mnt_shared(to);
> +	}

Should we report EINVAL if a private mount is passed? Though that would
require you to know in advance whether this is one so might actually be
worth doing it like you do now.

> +
> +	err = 0;
> +out:
> +	namespace_unlock();
> +	return err;
> +}
> +
>  static int do_move_mount(struct path *old_path, struct path *new_path)

Technically this could also be part of mount_setattr() (You'd need a new
struct member though.) but it's fine here too.

>  {
>  	struct mnt_namespace *ns;
> @@ -3669,7 +3729,10 @@ SYSCALL_DEFINE5(move_mount,
>  	if (ret < 0)
>  		goto out_to;
>  
> -	ret = do_move_mount(&from_path, &to_path);
> +	if (flags & MOVE_MOUNT_SET_GROUP)
> +		ret = do_set_group(&from_path, &to_path);
> +	else
> +		ret = do_move_mount(&from_path, &to_path);
>  
>  out_to:
>  	path_put(&to_path);
> diff --git a/include/uapi/linux/mount.h b/include/uapi/linux/mount.h
> index dd7a166fdf9c..4d93967f8aea 100644
> --- a/include/uapi/linux/mount.h
> +++ b/include/uapi/linux/mount.h
> @@ -73,7 +73,8 @@
>  #define MOVE_MOUNT_T_SYMLINKS		0x00000010 /* Follow symlinks on to path */
>  #define MOVE_MOUNT_T_AUTOMOUNTS		0x00000020 /* Follow automounts on to path */
>  #define MOVE_MOUNT_T_EMPTY_PATH		0x00000040 /* Empty to path permitted */
> -#define MOVE_MOUNT__MASK		0x00000077
> +#define MOVE_MOUNT_SET_GROUP		0x00000100 /* Set sharing group instead */
> +#define MOVE_MOUNT__MASK		0x00000177
>  
>  /*
>   * fsopen() flags.
> -- 
> 2.31.1
> 
