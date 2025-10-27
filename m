Return-Path: <linux-fsdevel+bounces-65715-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45025C0E440
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Oct 2025 15:11:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74A07421154
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Oct 2025 14:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B558F306B3D;
	Mon, 27 Oct 2025 14:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rhk7If0L"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F8822D7B1;
	Mon, 27 Oct 2025 14:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761573859; cv=none; b=HXvZbfNySCQ3X/r5K7InoQbul6NWAMO2h8Xg6/gdC1IrtsG82BPU9ti97dTvXozXc7WI/ugySC2l2ieB3V6fCvoarYaaRjjeBBEHei7pZzG9CjgEoLLYxuqeQX8vNuRhToUw6QzIzEFJUKYUYTjlYqQKAgKU63rgl3kPT4cp5io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761573859; c=relaxed/simple;
	bh=8m6HekK2vqnWmOZFGTVdVX8NpWM4Za5yEX0MoytUOIM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NSQ9MHSHfsmIUECA2e2B3Kfk1tXTziZXr3NmDWX6YGfu5SO4mxgLJmaDuq/eFqFU31HvDPabQg7tgP7ZTwvi2n5Bg+iUovQjL6iaWQzc4cXN1LJ3LJv1LnRlXZmvkrUgr+GU/zKkO/ACa7wnvFCSxl08QGcH/E0Yow5OhtIR/9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rhk7If0L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B07A7C4CEFF;
	Mon, 27 Oct 2025 14:04:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761573858;
	bh=8m6HekK2vqnWmOZFGTVdVX8NpWM4Za5yEX0MoytUOIM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=rhk7If0LqX6yF+Jbbep/+gtPHPzE0PDQrR9UnEUK+lQV5DOFEoi3ci06S9bpZkt9p
	 TWYYN6ixXFcomL50ArAQe4Xoa1VB9p3zJ0eiqsyD3TtPBfuTbWTEx1e4NDq+ore1zn
	 /ZjwTaApXMp4pjP14LrmvBSoPMF2qi0s+au/LyHwYeSq9PwpmxC0X1A+EZJ8cJ9GqP
	 V8jhSsOCDDz6rWtQ9z9rnimfiaWD4GI+7qO3XzPbBKWO+qtYM2Wj06sNQB2LZkwRxn
	 V9vlHf1AR9bEMSH8CJg5mHki+vSH1NvvD65b/sHEw5A+uqVp4Cc7BhqMHp6IlLR7mq
	 ueN/nQ0TqL+Vw==
Message-ID: <c2cdf48188312c108f2b3aa07ea353acdd32e999.camel@kernel.org>
Subject: Re: [PATCH v3 17/70] nstree: add listns()
From: Jeff Layton <jlayton@kernel.org>
To: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, 
 Josef Bacik <josef@toxicpanda.com>
Cc: Jann Horn <jannh@google.com>, Mike Yuan <me@yhndnzj.com>, Zbigniew
 =?UTF-8?Q?J=C4=99drzejewski-Szmek?=	 <zbyszek@in.waw.pl>, Lennart
 Poettering <mzxreary@0pointer.de>, Daan De Meyer	
 <daan.j.demeyer@gmail.com>, Aleksa Sarai <cyphar@cyphar.com>, Amir
 Goldstein	 <amir73il@gmail.com>, Tejun Heo <tj@kernel.org>, Johannes Weiner
	 <hannes@cmpxchg.org>, Thomas Gleixner <tglx@linutronix.de>, Alexander Viro
	 <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, bpf@vger.kernel.org,
  Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 netdev@vger.kernel.org, Arnd Bergmann	 <arnd@arndb.de>
Date: Mon, 27 Oct 2025 10:04:15 -0400
In-Reply-To: <20251024-work-namespace-nstree-listns-v3-17-b6241981b72b@kernel.org>
References: 
	<20251024-work-namespace-nstree-listns-v3-0-b6241981b72b@kernel.org>
	 <20251024-work-namespace-nstree-listns-v3-17-b6241981b72b@kernel.org>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-10-24 at 12:52 +0200, Christian Brauner wrote:
> Add a new listns() system call that allows userspace to iterate through
> namespaces in the system. This provides a programmatic interface to
> discover and inspect namespaces, enhancing existing namespace apis.
>=20
> Currently, there is no direct way for userspace to enumerate namespaces
> in the system. Applications must resort to scanning /proc/<pid>/ns/
> across all processes, which is:
>=20
> 1. Inefficient - requires iterating over all processes
> 2. Incomplete - misses inactive namespaces that aren't attached to any
>    running process but are kept alive by file descriptors, bind mounts,
>    or parent namespace references
> 3. Permission-heavy - requires access to /proc for many processes
> 4. No ordering or ownership.
> 5. No filtering per namespace type: Must always iterate and check all
>    namespaces.
>=20
> The list goes on. The listns() system call solves these problems by
> providing direct kernel-level enumeration of namespaces. It is similar
> to listmount() but obviously tailored to namespaces.
>=20
> /*
>  * @req: Pointer to struct ns_id_req specifying search parameters
>  * @ns_ids: User buffer to receive namespace IDs
>  * @nr_ns_ids: Size of ns_ids buffer (maximum number of IDs to return)
>  * @flags: Reserved for future use (must be 0)
>  */
> ssize_t listns(const struct ns_id_req *req, u64 *ns_ids,
>                size_t nr_ns_ids, unsigned int flags);
>=20
> Returns:
> - On success: Number of namespace IDs written to ns_ids
> - On error: Negative error code
>=20
> /*
>  * @size: Structure size
>  * @ns_id: Starting point for iteration; use 0 for first call, then
>  *         use the last returned ID for subsequent calls to paginate
>  * @ns_type: Bitmask of namespace types to include (from enum ns_type):
>  *           0: Return all namespace types
>  *           MNT_NS: Mount namespaces
>  *           NET_NS: Network namespaces
>  *           USER_NS: User namespaces
>  *           etc. Can be OR'd together
>  * @user_ns_id: Filter results to namespaces owned by this user namespace=
:
>  *              0: Return all namespaces (subject to permission checks)
>  *              LISTNS_CURRENT_USER: Namespaces owned by caller's user na=
mespace
>  *              Other value: Namespaces owned by the specified user names=
pace ID
>  */
> struct ns_id_req {
>         __u32 size;         /* sizeof(struct ns_id_req) */
>         __u32 spare;        /* Reserved, must be 0 */
>         __u64 ns_id;        /* Last seen namespace ID (for pagination) */
>         __u32 ns_type;      /* Filter by namespace type(s) */
>         __u32 spare2;       /* Reserved, must be 0 */
>         __u64 user_ns_id;   /* Filter by owning user namespace */
> };
>=20
> Example 1: List all namespaces
>=20
> void list_all_namespaces(void)
> {
>     struct ns_id_req req =3D {
>         .size =3D sizeof(req),
>         .ns_id =3D 0,          /* Start from beginning */
>         .ns_type =3D 0,        /* All types */
>         .user_ns_id =3D 0,     /* All user namespaces */
>     };
>     uint64_t ids[100];
>     ssize_t ret;
>=20
>     printf("All namespaces in the system:\n");
>     do {
>         ret =3D listns(&req, ids, 100, 0);
>         if (ret < 0) {
>             perror("listns");
>             break;
>         }
>=20
>         for (ssize_t i =3D 0; i < ret; i++)
>             printf("  Namespace ID: %llu\n", (unsigned long long)ids[i]);
>=20
>         /* Continue from last seen ID */
>         if (ret > 0)
>             req.ns_id =3D ids[ret - 1];
>     } while (ret =3D=3D 100);  /* Buffer was full, more may exist */
> }
>=20
> Example 2: List network namespaces only
>=20
> void list_network_namespaces(void)
> {
>     struct ns_id_req req =3D {
>         .size =3D sizeof(req),
>         .ns_id =3D 0,
>         .ns_type =3D NET_NS,   /* Only network namespaces */
>         .user_ns_id =3D 0,
>     };
>     uint64_t ids[100];
>     ssize_t ret;
>=20
>     ret =3D listns(&req, ids, 100, 0);
>     if (ret < 0) {
>         perror("listns");
>         return;
>     }
>=20
>     printf("Network namespaces: %zd found\n", ret);
>     for (ssize_t i =3D 0; i < ret; i++)
>         printf("  netns ID: %llu\n", (unsigned long long)ids[i]);
> }
>=20
> Example 3: List namespaces owned by current user namespace
>=20
> void list_owned_namespaces(void)
> {
>     struct ns_id_req req =3D {
>         .size =3D sizeof(req),
>         .ns_id =3D 0,
>         .ns_type =3D 0,                      /* All types */
>         .user_ns_id =3D LISTNS_CURRENT_USER, /* Current userns */
>     };
>     uint64_t ids[100];
>     ssize_t ret;
>=20
>     ret =3D listns(&req, ids, 100, 0);
>     if (ret < 0) {
>         perror("listns");
>         return;
>     }
>=20
>     printf("Namespaces owned by my user namespace: %zd\n", ret);
>     for (ssize_t i =3D 0; i < ret; i++)
>         printf("  ns ID: %llu\n", (unsigned long long)ids[i]);
> }
>=20
> Example 4: List multiple namespace types
>=20
> void list_network_and_mount_namespaces(void)
> {
>     struct ns_id_req req =3D {
>         .size =3D sizeof(req),
>         .ns_id =3D 0,
>         .ns_type =3D NET_NS | MNT_NS,  /* Network and mount */
>         .user_ns_id =3D 0,
>     };
>     uint64_t ids[100];
>     ssize_t ret;
>=20
>     ret =3D listns(&req, ids, 100, 0);
>     printf("Network and mount namespaces: %zd found\n", ret);
> }
>=20
> Example 5: Pagination through large namespace sets
>=20
> void list_all_with_pagination(void)
> {
>     struct ns_id_req req =3D {
>         .size =3D sizeof(req),
>         .ns_id =3D 0,
>         .ns_type =3D 0,
>         .user_ns_id =3D 0,
>     };
>     uint64_t ids[50];
>     size_t total =3D 0;
>     ssize_t ret;
>=20
>     printf("Enumerating all namespaces with pagination:\n");
>=20
>     while (1) {
>         ret =3D listns(&req, ids, 50, 0);
>         if (ret < 0) {
>             perror("listns");
>             break;
>         }
>         if (ret =3D=3D 0)
>             break;  /* No more namespaces */
>=20
>         total +=3D ret;
>         printf("  Batch: %zd namespaces\n", ret);
>=20
>         /* Last ID in this batch becomes start of next batch */
>         req.ns_id =3D ids[ret - 1];
>=20
>         if (ret < 50)
>             break;  /* Partial batch =3D end of results */
>     }
>=20
>     printf("Total: %zu namespaces\n", total);
> }
>=20
> Permission Model
>=20
> listns() respects namespace isolation and capabilities:
>=20
> (1) Global listing (user_ns_id =3D 0):
>     - Requires CAP_SYS_ADMIN in the namespace's owning user namespace
>     - OR the namespace must be in the caller's namespace context (e.g.,
>       a namespace the caller is currently using)
>     - User namespaces additionally allow listing if the caller has
>       CAP_SYS_ADMIN in that user namespace itself
> (2) Owner-filtered listing (user_ns_id !=3D 0):
>     - Requires CAP_SYS_ADMIN in the specified owner user namespace
>     - OR the namespace must be in the caller's namespace context
>     - This allows unprivileged processes to enumerate namespaces they own
> (3) Visibility:
>     - Only "active" namespaces are listed
>     - A namespace is active if it has a non-zero __ns_ref_active count
>     - This includes namespaces used by running processes, held by open
>       file descriptors, or kept active by bind mounts
>     - Inactive namespaces (kept alive only by internal kernel
>       references) are not visible via listns()
>=20
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
>  fs/namespace.c                 |   1 +
>  fs/nsfs.c                      |  39 ++++
>  include/linux/ns_common.h      |   5 +-
>  include/linux/syscalls.h       |   4 +
>  include/linux/user_namespace.h |   4 +-
>  include/uapi/linux/nsfs.h      |  44 +++++
>  init/version-timestamp.c       |   1 +
>  ipc/msgutil.c                  |   1 +
>  kernel/cgroup/cgroup.c         |   1 +
>  kernel/nscommon.c              |   3 +
>  kernel/nstree.c                | 417 +++++++++++++++++++++++++++++++++++=
+++++-
>  kernel/pid.c                   |   1 +
>  kernel/time/namespace.c        |   1 +
>  kernel/user.c                  |   1 +
>  14 files changed, 516 insertions(+), 7 deletions(-)
>=20
> diff --git a/fs/namespace.c b/fs/namespace.c
> index d460ca79f0e7..980296b0ec86 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -5996,6 +5996,7 @@ struct mnt_namespace init_mnt_ns =3D {
>  	.mounts		=3D RB_ROOT,
>  	.poll		=3D __WAIT_QUEUE_HEAD_INITIALIZER(init_mnt_ns.poll),
>  	.ns.ns_list_node =3D LIST_HEAD_INIT(init_mnt_ns.ns.ns_list_node),
> +	.ns.ns_unified_list_node =3D LIST_HEAD_INIT(init_mnt_ns.ns.ns_unified_l=
ist_node),
>  	.ns.ns_owner_entry =3D LIST_HEAD_INIT(init_mnt_ns.ns.ns_owner_entry),
>  	.ns.ns_owner =3D LIST_HEAD_INIT(init_mnt_ns.ns.ns_owner),
>  };
> diff --git a/fs/nsfs.c b/fs/nsfs.c
> index 19dc28742a42..5c21fdc79796 100644
> --- a/fs/nsfs.c
> +++ b/fs/nsfs.c
> @@ -471,6 +471,45 @@ static int nsfs_encode_fh(struct inode *inode, u32 *=
fh, int *max_len,
>  	return FILEID_NSFS;
>  }
> =20
> +bool is_current_namespace(struct ns_common *ns)
> +{
> +	switch (ns->ns_type) {
> +#ifdef CONFIG_CGROUPS
> +	case CLONE_NEWCGROUP:
> +		return current_in_namespace(to_cg_ns(ns));
> +#endif
> +#ifdef CONFIG_IPC_NS
> +	case CLONE_NEWIPC:
> +		return current_in_namespace(to_ipc_ns(ns));
> +#endif
> +	case CLONE_NEWNS:
> +		return current_in_namespace(to_mnt_ns(ns));
> +#ifdef CONFIG_NET_NS
> +	case CLONE_NEWNET:
> +		return current_in_namespace(to_net_ns(ns));
> +#endif
> +#ifdef CONFIG_PID_NS
> +	case CLONE_NEWPID:
> +		return current_in_namespace(to_pid_ns(ns));
> +#endif
> +#ifdef CONFIG_TIME_NS
> +	case CLONE_NEWTIME:
> +		return current_in_namespace(to_time_ns(ns));
> +#endif
> +#ifdef CONFIG_USER_NS
> +	case CLONE_NEWUSER:
> +		return current_in_namespace(to_user_ns(ns));
> +#endif
> +#ifdef CONFIG_UTS_NS
> +	case CLONE_NEWUTS:
> +		return current_in_namespace(to_uts_ns(ns));
> +#endif
> +	default:
> +		VFS_WARN_ON_ONCE(true);
> +		return false;
> +	}
> +}
> +
>  static struct dentry *nsfs_fh_to_dentry(struct super_block *sb, struct f=
id *fh,
>  					int fh_len, int fh_type)
>  {
> diff --git a/include/linux/ns_common.h b/include/linux/ns_common.h
> index 88dce67e06e4..95b3e2aa177d 100644
> --- a/include/linux/ns_common.h
> +++ b/include/linux/ns_common.h
> @@ -123,8 +123,10 @@ struct ns_common {
>  				struct rb_node ns_tree_node;
>  				struct list_head ns_list_node;
>  			};
> -			struct /* namespace ownership list */ {
> +			struct /* namespace ownership rbtree and list */ {
> +				struct rb_root ns_owner_tree; /* rbtree of namespaces owned by this =
namespace */
>  				struct list_head ns_owner; /* list of namespaces owned by this names=
pace */
> +				struct rb_node ns_owner_tree_node; /* node in the owner namespace's =
rbtree */


The changelog doesn't mention why these fields are being added.

I'd prefer to see the parts of this patch that deal with the above
fields added in a separate patch. I'm guessing that you added them here
because this patch adds the need to check ns ownership for listns(),
but I think it warrants a separate patch and changelog explaining
what's going on.

>  				struct list_head ns_owner_entry; /* node in the owner namespace's ns=
_owned list */
>  			};
>  			atomic_t __ns_ref_active; /* do not use directly */
> @@ -133,6 +135,7 @@ struct ns_common {
>  	};
>  };
> =20
> +bool is_current_namespace(struct ns_common *ns);
>  int __ns_common_init(struct ns_common *ns, u32 ns_type, const struct pro=
c_ns_operations *ops, int inum);
>  void __ns_common_free(struct ns_common *ns);
> =20
> diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
> index 66c06fcdfe19..cf84d98964b2 100644
> --- a/include/linux/syscalls.h
> +++ b/include/linux/syscalls.h
> @@ -77,6 +77,7 @@ struct cachestat_range;
>  struct cachestat;
>  struct statmount;
>  struct mnt_id_req;
> +struct ns_id_req;
>  struct xattr_args;
>  struct file_attr;
> =20
> @@ -437,6 +438,9 @@ asmlinkage long sys_statmount(const struct mnt_id_req=
 __user *req,
>  asmlinkage long sys_listmount(const struct mnt_id_req __user *req,
>  			      u64 __user *mnt_ids, size_t nr_mnt_ids,
>  			      unsigned int flags);
> +asmlinkage long sys_listns(const struct ns_id_req __user *req,
> +			   u64 __user *ns_ids, size_t nr_ns_ids,
> +			   unsigned int flags);
>  asmlinkage long sys_truncate(const char __user *path, long length);
>  asmlinkage long sys_ftruncate(unsigned int fd, off_t length);
>  #if BITS_PER_LONG =3D=3D 32
> diff --git a/include/linux/user_namespace.h b/include/linux/user_namespac=
e.h
> index 9a9aebbf96b9..9c3be157397e 100644
> --- a/include/linux/user_namespace.h
> +++ b/include/linux/user_namespace.h
> @@ -166,13 +166,13 @@ static inline void set_userns_rlimit_max(struct use=
r_namespace *ns,
>  	ns->rlimit_max[type] =3D max <=3D LONG_MAX ? max : LONG_MAX;
>  }
> =20
> -#ifdef CONFIG_USER_NS
> -
>  static inline struct user_namespace *to_user_ns(struct ns_common *ns)
>  {
>  	return container_of(ns, struct user_namespace, ns);
>  }
> =20
> +#ifdef CONFIG_USER_NS
> +
>  static inline struct user_namespace *get_user_ns(struct user_namespace *=
ns)
>  {
>  	if (ns)
> diff --git a/include/uapi/linux/nsfs.h b/include/uapi/linux/nsfs.h
> index f8bc2aad74d6..a25e38d1c874 100644
> --- a/include/uapi/linux/nsfs.h
> +++ b/include/uapi/linux/nsfs.h
> @@ -81,4 +81,48 @@ enum init_ns_id {
>  #endif
>  };
> =20
> +enum ns_type {
> +	TIME_NS    =3D (1ULL << 7),  /* CLONE_NEWTIME */
> +	MNT_NS     =3D (1ULL << 17), /* CLONE_NEWNS */
> +	CGROUP_NS  =3D (1ULL << 25), /* CLONE_NEWCGROUP */
> +	UTS_NS     =3D (1ULL << 26), /* CLONE_NEWUTS */
> +	IPC_NS     =3D (1ULL << 27), /* CLONE_NEWIPC */
> +	USER_NS    =3D (1ULL << 28), /* CLONE_NEWUSER */
> +	PID_NS     =3D (1ULL << 29), /* CLONE_NEWPID */
> +	NET_NS     =3D (1ULL << 30), /* CLONE_NEWNET */
> +};
> +
> +/**
> + * struct ns_id_req - namespace ID request structure
> + * @size: size of this structure
> + * @spare: reserved for future use
> + * @filter: filter mask
> + * @ns_id: last namespace id
> + * @user_ns_id: owning user namespace ID
> + *
> + * Structure for passing namespace ID and miscellaneous parameters to
> + * statns(2) and listns(2).
> + *
> + * For statns(2) @param represents the request mask.
> + * For listns(2) @param represents the last listed mount id (or zero).
> + */
> +struct ns_id_req {
> +	__u32 size;
> +	__u32 spare;
> +	__u64 ns_id;
> +	struct /* listns */ {
> +		__u32 ns_type;
> +		__u32 spare2;
> +		__u64 user_ns_id;
> +	};
> +};
> +
> +/*
> + * Special @user_ns_id value that can be passed to listns()
> + */
> +#define LISTNS_CURRENT_USER 0xffffffffffffffff /* Caller's userns */
> +
> +/* List of all ns_id_req versions. */
> +#define NS_ID_REQ_SIZE_VER0 32 /* sizeof first published struct */
> +
>  #endif /* __LINUX_NSFS_H */
> diff --git a/init/version-timestamp.c b/init/version-timestamp.c
> index e5c278dabecf..cd6f435d5fde 100644
> --- a/init/version-timestamp.c
> +++ b/init/version-timestamp.c
> @@ -22,6 +22,7 @@ struct uts_namespace init_uts_ns =3D {
>  	.user_ns =3D &init_user_ns,
>  	.ns.inum =3D ns_init_inum(&init_uts_ns),
>  	.ns.ns_list_node =3D LIST_HEAD_INIT(init_uts_ns.ns.ns_list_node),
> +	.ns.ns_unified_list_node =3D LIST_HEAD_INIT(init_uts_ns.ns.ns_unified_l=
ist_node),
>  	.ns.ns_owner_entry =3D LIST_HEAD_INIT(init_uts_ns.ns.ns_owner_entry),
>  	.ns.ns_owner =3D LIST_HEAD_INIT(init_uts_ns.ns.ns_owner),
>  #ifdef CONFIG_UTS_NS
> diff --git a/ipc/msgutil.c b/ipc/msgutil.c
> index ce1de73725c0..3708f325228d 100644
> --- a/ipc/msgutil.c
> +++ b/ipc/msgutil.c
> @@ -32,6 +32,7 @@ struct ipc_namespace init_ipc_ns =3D {
>  	.user_ns =3D &init_user_ns,
>  	.ns.inum =3D ns_init_inum(&init_ipc_ns),
>  	.ns.ns_list_node =3D LIST_HEAD_INIT(init_ipc_ns.ns.ns_list_node),
> +	.ns.ns_unified_list_node =3D LIST_HEAD_INIT(init_ipc_ns.ns.ns_unified_l=
ist_node),
>  	.ns.ns_owner_entry =3D LIST_HEAD_INIT(init_ipc_ns.ns.ns_owner_entry),
>  	.ns.ns_owner =3D LIST_HEAD_INIT(init_ipc_ns.ns.ns_owner),
>  #ifdef CONFIG_IPC_NS
> diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
> index 9fa082e2eb1a..a0eee0785080 100644
> --- a/kernel/cgroup/cgroup.c
> +++ b/kernel/cgroup/cgroup.c
> @@ -258,6 +258,7 @@ struct cgroup_namespace init_cgroup_ns =3D {
>  	.root_cset	=3D &init_css_set,
>  	.ns.ns_type	=3D ns_common_type(&init_cgroup_ns),
>  	.ns.ns_list_node =3D LIST_HEAD_INIT(init_cgroup_ns.ns.ns_list_node),
> +	.ns.ns_unified_list_node =3D LIST_HEAD_INIT(init_cgroup_ns.ns.ns_unifie=
d_list_node),
>  	.ns.ns_owner_entry =3D LIST_HEAD_INIT(init_cgroup_ns.ns.ns_owner_entry)=
,
>  	.ns.ns_owner =3D LIST_HEAD_INIT(init_cgroup_ns.ns.ns_owner),
>  };
> diff --git a/kernel/nscommon.c b/kernel/nscommon.c
> index ba46de0637c3..def79b549c52 100644
> --- a/kernel/nscommon.c
> +++ b/kernel/nscommon.c
> @@ -62,7 +62,10 @@ int __ns_common_init(struct ns_common *ns, u32 ns_type=
, const struct proc_ns_ope
>  	ns->ns_type =3D ns_type;
>  	RB_CLEAR_NODE(&ns->ns_tree_node);
>  	RB_CLEAR_NODE(&ns->ns_unified_tree_node);
> +	RB_CLEAR_NODE(&ns->ns_owner_tree_node);
>  	INIT_LIST_HEAD(&ns->ns_list_node);
> +	INIT_LIST_HEAD(&ns->ns_unified_list_node);
> +	ns->ns_owner_tree =3D RB_ROOT;
>  	INIT_LIST_HEAD(&ns->ns_owner);
>  	INIT_LIST_HEAD(&ns->ns_owner_entry);
> =20
> diff --git a/kernel/nstree.c b/kernel/nstree.c
> index 829682bb04a1..5fd50d73f0ae 100644
> --- a/kernel/nstree.c
> +++ b/kernel/nstree.c
> @@ -2,11 +2,15 @@
> =20
>  #include <linux/nstree.h>
>  #include <linux/proc_ns.h>
> +#include <linux/rculist.h>
> +#include <linux/syscalls.h>
>  #include <linux/vfsdebug.h>
>  #include <linux/user_namespace.h>
> +#include <linux/rcupdate_wait.h>
> =20
>  __cacheline_aligned_in_smp DEFINE_SEQLOCK(ns_tree_lock);
>  static struct rb_root ns_unified_tree =3D RB_ROOT; /* protected by ns_tr=
ee_lock */
> +static LIST_HEAD(ns_unified_list); /* protected by ns_tree_lock */
> =20
>  /**
>   * struct ns_tree - Namespace tree
> @@ -83,6 +87,13 @@ static inline struct ns_common *node_to_ns_unified(con=
st struct rb_node *node)
>  	return rb_entry(node, struct ns_common, ns_unified_tree_node);
>  }
> =20
> +static inline struct ns_common *node_to_ns_owner(const struct rb_node *n=
ode)
> +{
> +	if (!node)
> +		return NULL;
> +	return rb_entry(node, struct ns_common, ns_owner_tree_node);
> +}
> +
>  static inline int ns_cmp(struct rb_node *a, const struct rb_node *b)
>  {
>  	struct ns_common *ns_a =3D node_to_ns(a);
> @@ -111,6 +122,20 @@ static inline int ns_cmp_unified(struct rb_node *a, =
const struct rb_node *b)
>  	return 0;
>  }
> =20
> +static inline int ns_cmp_owner(struct rb_node *a, const struct rb_node *=
b)
> +{
> +	struct ns_common *ns_a =3D node_to_ns_owner(a);
> +	struct ns_common *ns_b =3D node_to_ns_owner(b);
> +	u64 ns_id_a =3D ns_a->ns_id;
> +	u64 ns_id_b =3D ns_b->ns_id;
> +
> +	if (ns_id_a < ns_id_b)
> +		return -1;
> +	if (ns_id_a > ns_id_b)
> +		return 1;
> +	return 0;
> +}
> +
>  void __ns_tree_add_raw(struct ns_common *ns, struct ns_tree *ns_tree)
>  {
>  	struct rb_node *node, *prev;
> @@ -134,7 +159,13 @@ void __ns_tree_add_raw(struct ns_common *ns, struct =
ns_tree *ns_tree)
>  	else
>  		list_add_rcu(&ns->ns_list_node, &node_to_ns(prev)->ns_list_node);
> =20
> +	/* Add to unified tree and list */
>  	rb_find_add_rcu(&ns->ns_unified_tree_node, &ns_unified_tree, ns_cmp_uni=
fied);
> +	prev =3D rb_prev(&ns->ns_unified_tree_node);
> +	if (!prev)
> +		list_add_rcu(&ns->ns_unified_list_node, &ns_unified_list);
> +	else
> +		list_add_rcu(&ns->ns_unified_list_node, &node_to_ns_unified(prev)->ns_=
unified_list_node);
> =20
>  	if (ops) {
>  		struct user_namespace *user_ns;
> @@ -144,7 +175,16 @@ void __ns_tree_add_raw(struct ns_common *ns, struct =
ns_tree *ns_tree)
>  		if (user_ns) {
>  			struct ns_common *owner =3D &user_ns->ns;
>  			VFS_WARN_ON_ONCE(owner->ns_type !=3D CLONE_NEWUSER);
> -			list_add_tail_rcu(&ns->ns_owner_entry, &owner->ns_owner);
> +
> +			/* Insert into owner's rbtree */
> +			rb_find_add_rcu(&ns->ns_owner_tree_node, &owner->ns_owner_tree, ns_cm=
p_owner);
> +
> +			/* Insert into owner's list in sorted order */
> +			prev =3D rb_prev(&ns->ns_owner_tree_node);
> +			if (!prev)
> +				list_add_rcu(&ns->ns_owner_entry, &owner->ns_owner);
> +			else
> +				list_add_rcu(&ns->ns_owner_entry, &node_to_ns_owner(prev)->ns_owner_=
entry);
>  		} else {
>  			/* Only the initial user namespace doesn't have an owner. */
>  			VFS_WARN_ON_ONCE(ns !=3D to_ns_common(&init_user_ns));
> @@ -157,16 +197,36 @@ void __ns_tree_add_raw(struct ns_common *ns, struct=
 ns_tree *ns_tree)
> =20
>  void __ns_tree_remove(struct ns_common *ns, struct ns_tree *ns_tree)
>  {
> +	const struct proc_ns_operations *ops =3D ns->ops;
> +	struct user_namespace *user_ns;
> +
>  	VFS_WARN_ON_ONCE(RB_EMPTY_NODE(&ns->ns_tree_node));
>  	VFS_WARN_ON_ONCE(list_empty(&ns->ns_list_node));
>  	VFS_WARN_ON_ONCE(ns->ns_type !=3D ns_tree->type);
> =20
>  	write_seqlock(&ns_tree_lock);
>  	rb_erase(&ns->ns_tree_node, &ns_tree->ns_tree);
> -	rb_erase(&ns->ns_unified_tree_node, &ns_unified_tree);
> -	list_bidir_del_rcu(&ns->ns_list_node);
>  	RB_CLEAR_NODE(&ns->ns_tree_node);
> -	list_bidir_del_rcu(&ns->ns_owner_entry);
> +
> +	list_bidir_del_rcu(&ns->ns_list_node);
> +
> +	rb_erase(&ns->ns_unified_tree_node, &ns_unified_tree);
> +	RB_CLEAR_NODE(&ns->ns_unified_tree_node);
> +
> +	list_bidir_del_rcu(&ns->ns_unified_list_node);
> +
> +	/* Remove from owner's rbtree if this namespace has an owner */
> +	if (ops) {
> +		user_ns =3D ops->owner(ns);
> +		if (user_ns) {
> +			struct ns_common *owner =3D &user_ns->ns;
> +			rb_erase(&ns->ns_owner_tree_node, &owner->ns_owner_tree);
> +			RB_CLEAR_NODE(&ns->ns_owner_tree_node);
> +		}
> +
> +		list_bidir_del_rcu(&ns->ns_owner_entry);
> +	}
> +
>  	write_sequnlock(&ns_tree_lock);
>  }

The above changes in this file seem like they ought to be part of a
different patch. This is adding=20

>  EXPORT_SYMBOL_GPL(__ns_tree_remove);
> @@ -312,3 +372,352 @@ u64 __ns_tree_gen_id(struct ns_common *ns, u64 id)
>  		ns->ns_id =3D atomic64_inc_return(&namespace_cookie);
>  	return ns->ns_id;
>  }
> +
> +struct klistns {
> +	u64 *kns_ids;
> +	u32 nr_ns_ids;
> +	u64 last_ns_id;
> +	u64 user_ns_id;
> +	u32 ns_type;
> +	struct user_namespace *user_ns;
> +	struct ns_common *first_ns;
> +};
> +
> +static void __free_klistns_free(const struct klistns *kls)
> +{
> +	if (kls->user_ns_id !=3D LISTNS_CURRENT_USER)
> +		put_user_ns(kls->user_ns);
> +	if (kls->first_ns)
> +		kls->first_ns->ops->put(kls->first_ns);
> +	kvfree(kls->kns_ids);
> +}
> +
> +#define NS_ALL (PID_NS | USER_NS | MNT_NS | UTS_NS | IPC_NS | NET_NS | C=
GROUP_NS | TIME_NS)
> +
> +static int copy_ns_id_req(const struct ns_id_req __user *req,
> +			  struct ns_id_req *kreq)
> +{
> +	int ret;
> +	size_t usize;
> +
> +	BUILD_BUG_ON(sizeof(struct ns_id_req) !=3D NS_ID_REQ_SIZE_VER0);
> +
> +	ret =3D get_user(usize, &req->size);
> +	if (ret)
> +		return -EFAULT;
> +	if (unlikely(usize > PAGE_SIZE))
> +		return -E2BIG;
> +	if (unlikely(usize < NS_ID_REQ_SIZE_VER0))
> +		return -EINVAL;
> +	memset(kreq, 0, sizeof(*kreq));
> +	ret =3D copy_struct_from_user(kreq, sizeof(*kreq), req, usize);
> +	if (ret)
> +		return ret;
> +	if (kreq->spare !=3D 0)
> +		return -EINVAL;
> +	if (kreq->ns_type & ~NS_ALL)
> +		return -EOPNOTSUPP;
> +	return 0;
> +}
> +
> +static inline int prepare_klistns(struct klistns *kls, struct ns_id_req =
*kreq,
> +				  size_t nr_ns_ids)
> +{
> +	kls->last_ns_id =3D kreq->ns_id;
> +	kls->user_ns_id =3D kreq->user_ns_id;
> +	kls->nr_ns_ids =3D nr_ns_ids;
> +	kls->ns_type =3D kreq->ns_type;
> +
> +	kls->kns_ids =3D kvmalloc_array(nr_ns_ids, sizeof(*kls->kns_ids),
> +				      GFP_KERNEL_ACCOUNT);
> +	if (!kls->kns_ids)
> +		return -ENOMEM;
> +
> +	return 0;
> +}
> +
> +/*
> + * Lookup a namespace owned by owner with id >=3D ns_id.
> + * Returns the namespace with the smallest id that is >=3D ns_id.
> + */
> +static struct ns_common *lookup_ns_owner_at(u64 ns_id, struct ns_common =
*owner)
> +{
> +	struct ns_common *ret =3D NULL;
> +	struct rb_node *node;
> +
> +	VFS_WARN_ON_ONCE(owner->ns_type !=3D CLONE_NEWUSER);
> +
> +	read_seqlock_excl(&ns_tree_lock);
> +	node =3D owner->ns_owner_tree.rb_node;
> +
> +	while (node) {
> +		struct ns_common *ns =3D node_to_ns_owner(node);
> +
> +		if (ns_id <=3D ns->ns_id) {
> +			ret =3D ns;
> +			if (ns_id =3D=3D ns->ns_id)
> +				break;
> +			node =3D node->rb_left;
> +		} else {
> +			node =3D node->rb_right;
> +		}
> +	}
> +
> +	if (ret && !ns_get_unless_inactive(ret))
> +		ret =3D NULL;
> +	read_sequnlock_excl(&ns_tree_lock);
> +	return ret;
> +}
> +
> +static struct ns_common *lookup_ns_id(u64 mnt_ns_id, int ns_type)
> +{
> +	struct ns_common *ns;
> +
> +	guard(rcu)();
> +	ns =3D ns_tree_lookup_rcu(mnt_ns_id, ns_type);
> +	if (!ns)
> +		return NULL;
> +
> +	if (!ns_get_unless_inactive(ns))
> +		return NULL;
> +
> +	return ns;
> +}
> +
> +static ssize_t do_listns_userns(struct klistns *kls)
> +{
> +	u64 *ns_ids =3D kls->kns_ids;
> +	size_t nr_ns_ids =3D kls->nr_ns_ids;
> +	struct ns_common *ns =3D NULL, *first_ns =3D NULL;
> +	const struct list_head *head;
> +	bool userns_capable;
> +	ssize_t ret;
> +
> +	VFS_WARN_ON_ONCE(!kls->user_ns_id);
> +
> +	if (kls->user_ns_id =3D=3D LISTNS_CURRENT_USER)
> +		ns =3D to_ns_common(current_user_ns());
> +	else if (kls->user_ns_id)
> +		ns =3D lookup_ns_id(kls->user_ns_id, CLONE_NEWUSER);
> +	if (!ns)
> +		return -EINVAL;
> +	kls->user_ns =3D to_user_ns(ns);
> +
> +	/*
> +	 * Use the rbtree to find the first namespace we care about and
> +	 * then use it's list entry to iterate from there.
> +	 */
> +	if (kls->last_ns_id) {
> +		kls->first_ns =3D lookup_ns_owner_at(kls->last_ns_id + 1, ns);
> +		if (!kls->first_ns)
> +			return -ENOENT;
> +		first_ns =3D kls->first_ns;
> +	}
> +
> +	ret =3D 0;
> +	head =3D &to_ns_common(kls->user_ns)->ns_owner;
> +	userns_capable =3D ns_capable_noaudit(kls->user_ns, CAP_SYS_ADMIN);
> +	guard(rcu)();
> +	if (!first_ns)
> +		first_ns =3D list_entry_rcu(head->next, typeof(*ns), ns_owner_entry);
> +	for (ns =3D first_ns; &ns->ns_owner_entry !=3D head && nr_ns_ids;
> +	     ns =3D list_entry_rcu(ns->ns_owner_entry.next, typeof(*ns), ns_own=
er_entry)) {
> +		if (kls->ns_type && !(kls->ns_type & ns->ns_type))
> +			continue;
> +		if (!ns_get_unless_inactive(ns))
> +			continue;
> +		if (userns_capable || is_current_namespace(ns) ||
> +		    ((ns->ns_type =3D=3D CLONE_NEWUSER) && ns_capable_noaudit(to_user_=
ns(ns), CAP_SYS_ADMIN))) {
> +			*ns_ids =3D ns->ns_id;
> +			ns_ids++;
> +			nr_ns_ids--;
> +			ret++;
> +		}
> +		if (need_resched())
> +			cond_resched_rcu();
> +		/* doesn't sleep */
> +		ns->ops->put(ns);
> +	}
> +
> +	return ret;
> +}
> +
> +/*
> + * Lookup a namespace with id >=3D ns_id in either the unified tree or a=
 type-specific tree.
> + * Returns the namespace with the smallest id that is >=3D ns_id.
> + */
> +static struct ns_common *lookup_ns_id_at(u64 ns_id, int ns_type)
> +{
> +	struct ns_common *ret =3D NULL;
> +	struct ns_tree *ns_tree =3D NULL;
> +	struct rb_node *node;
> +
> +	if (ns_type) {
> +		ns_tree =3D ns_tree_from_type(ns_type);
> +		if (!ns_tree)
> +			return NULL;
> +	}
> +
> +	read_seqlock_excl(&ns_tree_lock);
> +	if (ns_tree)
> +		node =3D ns_tree->ns_tree.rb_node;
> +	else
> +		node =3D ns_unified_tree.rb_node;
> +
> +	while (node) {
> +		struct ns_common *ns;
> +
> +		if (ns_type)
> +			ns =3D node_to_ns(node);
> +		else
> +			ns =3D node_to_ns_unified(node);
> +
> +		if (ns_id <=3D ns->ns_id) {
> +			if (ns_type)
> +				ret =3D node_to_ns(node);
> +			else
> +				ret =3D node_to_ns_unified(node);
> +			if (ns_id =3D=3D ns->ns_id)
> +				break;
> +			node =3D node->rb_left;
> +		} else {
> +			node =3D node->rb_right;
> +		}
> +	}
> +
> +	if (ret && !ns_get_unless_inactive(ret))
> +		ret =3D NULL;
> +	read_sequnlock_excl(&ns_tree_lock);
> +	return ret;
> +}
> +
> +static inline struct ns_common *first_ns_common(const struct list_head *=
head,
> +						struct ns_tree *ns_tree)
> +{
> +	if (ns_tree)
> +		return list_entry_rcu(head->next, struct ns_common, ns_list_node);
> +	return list_entry_rcu(head->next, struct ns_common, ns_unified_list_nod=
e);
> +}
> +
> +static inline struct ns_common *next_ns_common(struct ns_common *ns,
> +					       struct ns_tree *ns_tree)
> +{
> +	if (ns_tree)
> +		return list_entry_rcu(ns->ns_list_node.next, struct ns_common, ns_list=
_node);
> +	return list_entry_rcu(ns->ns_unified_list_node.next, struct ns_common, =
ns_unified_list_node);
> +}
> +
> +static inline bool ns_common_is_head(struct ns_common *ns,
> +				     const struct list_head *head,
> +				     struct ns_tree *ns_tree)
> +{
> +	if (ns_tree)
> +		return &ns->ns_list_node =3D=3D head;
> +	return &ns->ns_unified_list_node =3D=3D head;
> +}
> +
> +static ssize_t do_listns(struct klistns *kls)
> +{
> +	u64 *ns_ids =3D kls->kns_ids;
> +	size_t nr_ns_ids =3D kls->nr_ns_ids;
> +	struct ns_common *ns, *first_ns =3D NULL;
> +	struct ns_tree *ns_tree =3D NULL;
> +	const struct list_head *head;
> +	struct user_namespace *user_ns;
> +	u32 ns_type;
> +	ssize_t ret;
> +
> +	if (hweight32(kls->ns_type) =3D=3D 1)
> +		ns_type =3D kls->ns_type;
> +	else
> +		ns_type =3D 0;
> +
> +	if (ns_type) {
> +		ns_tree =3D ns_tree_from_type(ns_type);
> +		if (!ns_tree)
> +			return -EINVAL;
> +	}
> +
> +	if (kls->last_ns_id) {
> +		kls->first_ns =3D lookup_ns_id_at(kls->last_ns_id + 1, ns_type);
> +		if (!kls->first_ns)
> +			return -ENOENT;
> +		first_ns =3D kls->first_ns;
> +	}
> +
> +	ret =3D 0;
> +	if (ns_tree)
> +		head =3D &ns_tree->ns_list;
> +	else
> +		head =3D &ns_unified_list;
> +
> +	guard(rcu)();
> +	if (!first_ns)
> +		first_ns =3D first_ns_common(head, ns_tree);
> +
> +	for (ns =3D first_ns; !ns_common_is_head(ns, head, ns_tree) && nr_ns_id=
s;
> +	     ns =3D next_ns_common(ns, ns_tree)) {
> +		if (kls->ns_type && !(kls->ns_type & ns->ns_type))
> +			continue;
> +		if (!ns_get_unless_inactive(ns))
> +			continue;
> +		/* Check permissions */
> +		if (!ns->ops)
> +			user_ns =3D NULL;
> +		else
> +			user_ns =3D ns->ops->owner(ns);
> +		if (!user_ns)
> +			user_ns =3D &init_user_ns;
> +		if (ns_capable_noaudit(user_ns, CAP_SYS_ADMIN) ||
> +		    is_current_namespace(ns) ||
> +		    ((ns->ns_type =3D=3D CLONE_NEWUSER) && ns_capable_noaudit(to_user_=
ns(ns), CAP_SYS_ADMIN))) {
> +			*ns_ids++ =3D ns->ns_id;
> +			nr_ns_ids--;
> +			ret++;
> +		}
> +		if (need_resched())
> +			cond_resched_rcu();
> +		/* doesn't sleep */
> +		ns->ops->put(ns);
> +	}
> +
> +	return ret;
> +}
> +
> +SYSCALL_DEFINE4(listns, const struct ns_id_req __user *, req,
> +		u64 __user *, ns_ids, size_t, nr_ns_ids, unsigned int, flags)
> +{
> +	struct klistns klns __free(klistns_free) =3D {};
> +	const size_t maxcount =3D 1000000;
> +	struct ns_id_req kreq;
> +	ssize_t ret;
> +
> +	if (flags)
> +		return -EINVAL;
> +
> +	if (unlikely(nr_ns_ids > maxcount))
> +		return -EOVERFLOW;
> +
> +	if (!access_ok(ns_ids, nr_ns_ids * sizeof(*ns_ids)))
> +		return -EFAULT;
> +
> +	ret =3D copy_ns_id_req(req, &kreq);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D prepare_klistns(&klns, &kreq, nr_ns_ids);
> +	if (ret)
> +		return ret;
> +
> +	if (kreq.user_ns_id)
> +		ret =3D do_listns_userns(&klns);
> +	else
> +		ret =3D do_listns(&klns);
> +	if (ret <=3D 0)
> +		return ret;
> +
> +	if (copy_to_user(ns_ids, klns.kns_ids, ret * sizeof(*ns_ids)))
> +		return -EFAULT;
> +
> +	return ret;
> +}
> diff --git a/kernel/pid.c b/kernel/pid.c
> index 8134c40b2584..22a0440a62fa 100644
> --- a/kernel/pid.c
> +++ b/kernel/pid.c
> @@ -80,6 +80,7 @@ struct pid_namespace init_pid_ns =3D {
>  	.user_ns =3D &init_user_ns,
>  	.ns.inum =3D ns_init_inum(&init_pid_ns),
>  	.ns.ns_list_node =3D LIST_HEAD_INIT(init_pid_ns.ns.ns_list_node),
> +	.ns.ns_unified_list_node =3D LIST_HEAD_INIT(init_pid_ns.ns.ns_unified_l=
ist_node),
>  	.ns.ns_owner_entry =3D LIST_HEAD_INIT(init_pid_ns.ns.ns_owner_entry),
>  	.ns.ns_owner =3D LIST_HEAD_INIT(init_pid_ns.ns.ns_owner),
>  #ifdef CONFIG_PID_NS
> diff --git a/kernel/time/namespace.c b/kernel/time/namespace.c
> index 15cb74267c75..acbeec049263 100644
> --- a/kernel/time/namespace.c
> +++ b/kernel/time/namespace.c
> @@ -489,6 +489,7 @@ struct time_namespace init_time_ns =3D {
>  	.ns.ns_owner =3D LIST_HEAD_INIT(init_time_ns.ns.ns_owner),
>  	.frozen_offsets	=3D true,
>  	.ns.ns_list_node =3D LIST_HEAD_INIT(init_time_ns.ns.ns_list_node),
> +	.ns.ns_unified_list_node =3D LIST_HEAD_INIT(init_time_ns.ns.ns_unified_=
list_node),
>  };
> =20
>  void __init time_ns_init(void)
> diff --git a/kernel/user.c b/kernel/user.c
> index e392768ccd44..68fe16617d38 100644
> --- a/kernel/user.c
> +++ b/kernel/user.c
> @@ -72,6 +72,7 @@ struct user_namespace init_user_ns =3D {
>  	.group =3D GLOBAL_ROOT_GID,
>  	.ns.inum =3D ns_init_inum(&init_user_ns),
>  	.ns.ns_list_node =3D LIST_HEAD_INIT(init_user_ns.ns.ns_list_node),
> +	.ns.ns_unified_list_node =3D LIST_HEAD_INIT(init_user_ns.ns.ns_unified_=
list_node),
>  	.ns.ns_owner_entry =3D LIST_HEAD_INIT(init_user_ns.ns.ns_owner_entry),
>  	.ns.ns_owner =3D LIST_HEAD_INIT(init_user_ns.ns.ns_owner),
>  #ifdef CONFIG_USER_NS

--=20
Jeff Layton <jlayton@kernel.org>

