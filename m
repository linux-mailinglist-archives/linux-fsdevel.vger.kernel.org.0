Return-Path: <linux-fsdevel+bounces-65086-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06ECFBFBA4A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 13:28:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5A8A3B24A9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 11:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7359C339717;
	Wed, 22 Oct 2025 11:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n9PIp5N/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9112338921;
	Wed, 22 Oct 2025 11:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761132509; cv=none; b=NmNnzVGw/F+coKJbVsKgboskw9bgxZjncrZ8KiCMzLh3f19vaQb9IHgoBRl5d70nYpNqAEv4MsTWcuraGHYFTpF4cHvB5ps78xD9SqIo+ZFbVBT4yslKzbgbM8GkC40qOjISGAS0d3t5IAVUuuMf/8+tZcY+Sd6ab4R0dcPBXTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761132509; c=relaxed/simple;
	bh=HK1tER5cJLrWKlUVFJYX8QkxT3I0HTQ78VkpAXwtlr8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TxyGWwcMb35R5smyN2Sb5QhkfAd3HDi8fPH5Dw/WHTNrD3xjbJ+dig97SUfIqIorJ9rS5deAFruJw5ajNlteieHlsTBeA2wJKOnBSkvHARb9+f/0MqynvL8a4cvRjTxId8ixzYgGOOASl5ng2XuovH3WaCp0AK5odkA6C/jBF0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n9PIp5N/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B41CC4CEE7;
	Wed, 22 Oct 2025 11:28:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761132509;
	bh=HK1tER5cJLrWKlUVFJYX8QkxT3I0HTQ78VkpAXwtlr8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=n9PIp5N/BVCWCCa5XvkyUCnRt6OfkY9w1GbNWtn2n+58DrvENuEcmO7QJbIwNwtr3
	 0p8lVbbyWdFt3C9SKvoeZlPlpSHwYVJqtRwQ8Z4SJ6kzMf/bYXyP0VhWkAxjGW+QWl
	 sv/nD78o1DaH5ULLGtElE2Jq6XPuNVCQ1YuC6oOGA5uFVoZJlr757IilyWYsAHUD1i
	 ULF51+L4ug3zTYc33IGIHvMSKgJ4SlM1sNZxbxsQfliYU7TyVlrT19C47cMVwt2gEu
	 cnra04n+brdS0b0gizaQywLdIgGkjmlklUGEdSYLcMcWJH0OrRAhq5uTzTFNMVlQds
	 jrlVYOc1+v3uQ==
Message-ID: <97bb1f9baba905e0e8bde62cce858b0def091d5c.camel@kernel.org>
Subject: Re: [PATCH RFC DRAFT 00/50] nstree: listns()
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
Date: Wed, 22 Oct 2025 07:28:26 -0400
In-Reply-To: <20251021-work-namespace-nstree-listns-v1-0-ad44261a8a5b@kernel.org>
References: 
	<20251021-work-namespace-nstree-listns-v1-0-ad44261a8a5b@kernel.org>
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

On Tue, 2025-10-21 at 13:43 +0200, Christian Brauner wrote:
> Hey,
>=20
> As announced a while ago this is the next step building on the nstree
> work from prior cycles. There's a bunch of fixes and semantic cleanups
> in here and a ton of tests.
>=20
> I need helper here!: Consider the following current design:
>=20
> Currently listns() is relying on active namespace reference counts which
> are introduced alongside this series.
>=20
> The active reference count of a namespace consists of the live tasks
> that make use of this namespace and any namespace file descriptors that
> explicitly pin the namespace.
>=20
> Once all tasks making use of this namespace have exited or reaped, all
> namespace file descriptors for that namespace have been closed and all
> bind-mounts for that namespace unmounted it ceases to appear in the
> listns() output.
>=20
> My reason for introducing the active reference count was that namespaces
> might obviously still be pinned internally for various reasons. For
> example the user namespace might still be pinned because there are still
> open files that have stashed the openers credentials in file->f_cred, or
> the last reference might be put with an rcu delay keeping that namespace
> active on the namespace lists.
>=20
> But one particularly strange example is CONFIG_MMU_LAZY_TLB_REFCOUNT=3Dy.
> Various architectures support the CONFIG_MMU_LAZY_TLB_REFCOUNT option
> which uses lazy TLB destruction.
>=20
> When this option is set a userspace task's struct mm_struct may be used
> for kernel threads such as the idle task and will only be destroyed once
> the cpu's runqueue switches back to another task. So the kernel thread
> will take a reference on the struct mm_struct pinning it.
>=20
> And for ptrace() based access checks struct mm_struct stashes the user
> namespace of the task that struct mm_struct belonged to originally and
> thus takes a reference to the users namespace and pins it.
>=20
> So on an idle system such user namespaces can be persisted for pretty
> arbitrary amounts of time via struct mm_struct.
>=20
> Now, without the active reference count regulating visibility all
> namespace that still are pinned in some way on the system will appear in
> the listns() output and can be reopened using namespace file handles.
>=20
> Of course that requires suitable privileges and it's not really a
> concern per se because a task could've also persist the namespace
> recorded in struct mm_struct explicitly and then the idle task would
> still reuse that struct mm_struct and another task could still happily
> setns() to it afaict and reuse it for something else.
>=20
> The active reference count though has drawbacks itself. Namely that
> socket files break the assumption that namespaces can only be opened if
> there's either live processes pinning the namespace or there are file
> descriptors open that pin the namespace itself as the socket SIOCGSKNS
> ioctl() can be used to open a network namespace based on a socket which
> only indirectly pins a network namespace.
>=20
> So that punches a whole in the active reference count tracking. So this
> will have to be handled as right now socket file descriptors that pin a
> network namespace that don't have an active reference anymore (no live
> processes, not explicit persistence via namespace fds) can't be used to
> issue a SIOCGSKNS ioctl() to open the associated network namespace.
>=20

Is this capability something we need to preserve? It seems like the
fact that SIOCGSKNS works when there are no active references left
might have been an accident. Is there a legit use-case for allowing
that?

I don't see a problem with active+passive refcounts. They're more
complicated to deal with, but we've used them elsewhere so it's a
pattern we all know (even if we don't necessarily love them).

I'll also point out that net namespaces already have two refcounts for
this exact reason. Do you plan to replace the passive refcount in
struct net with the new passive refcount you're implementing here?

> So two options I see if the api is based on ids:
>=20
> (1) We use the active reference count and somehow also make it work with
>     sockets.
> (2) The active reference count is not needed and we say that listns() is
>     an introspection system call anyway so we just always list
>     namespaces regardless of why they are still pinned: files,
>     mm_struct, network devices, everything is fair game.
> (3) Throw hands up in the air and just not do it.
>=20

Is listns() the only reason we'd need a active/passive refcounts? It
seems like we might need them for other reasons (e.g. struct net).

In any case, given that this is a privileged syscall, I don't
necessarily see a problem with #2 here. Leaked namespaces can be a
problem and we don't have good visibility into them at the moment.

IMO, even if you keep the active+passive refcounts, it would be good to
be able to tell listns() to return all the namespaces, and not just the
ones that are still active. Maybe that can be the first flag for this
new syscall?

> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
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
> 	struct ns_id_req req =3D {
> 		.size =3D sizeof(req),
> 		.ns_id =3D 0,      /* Start from beginning */
> 		.ns_type =3D 0,    /* All types */
> 		.user_ns_id =3D 0, /* All user namespaces */
> 	};
> 	uint64_t ids[100];
> 	ssize_t ret;
>=20
> 	printf("All namespaces in the system:\n");
> 	do {
> 		ret =3D listns(&req, ids, 100, 0);
> 		if (ret < 0) {
> 			perror("listns");
> 			break;
> 		}
>=20
> 		for (ssize_t i =3D 0; i < ret; i++)
> 			printf("  Namespace ID: %llu\n", (unsigned long long)ids[i]);
>=20
> 		/* Continue from last seen ID */
> 		if (ret > 0)
> 			req.ns_id =3D ids[ret - 1];
> 	} while (ret =3D=3D 100); /* Buffer was full, more may exist */
> }
>=20
> Example 2 : List network namespaces only
>=20
> void list_network_namespaces(void)
> {
> 	struct ns_id_req req =3D {
> 		.size =3D sizeof(req),
> 		.ns_id =3D 0,
> 		.ns_type =3D NET_NS, /* Only network namespaces */
> 		.user_ns_id =3D 0,
> 	};
> 	uint64_t ids[100];
> 	ssize_t ret;
>=20
> 	ret =3D listns(&req, ids, 100, 0);
> 	if (ret < 0) {
> 		perror("listns");
> 		return;
> 	}
>=20
> 	printf("Network namespaces: %zd found\n", ret);
> 	for (ssize_t i =3D 0; i < ret; i++)
> 		printf("  netns ID: %llu\n", (unsigned long long)ids[i]);
> }
>=20
> Example 3 : List namespaces owned by current user namespace
>=20
> void list_owned_namespaces(void)
> {
> 	struct ns_id_req req =3D {
> 		.size =3D sizeof(req),
> 		.ns_id =3D 0,
> 		.ns_type =3D 0,                      /* All types */
> 		.user_ns_id =3D LISTNS_CURRENT_USER, /* Current userns */
> 	};
> 	uint64_t ids[100];
> 	ssize_t ret;
>=20
> 	ret =3D listns(&req, ids, 100, 0);
> 	if (ret < 0) {
> 		perror("listns");
> 		return;
> 	}
>=20
> 	printf("Namespaces owned by my user namespace: %zd\n", ret);
> 	for (ssize_t i =3D 0; i < ret; i++)
> 		printf("  ns ID: %llu\n", (unsigned long long)ids[i]);
> }
>=20
> Example 4 : List multiple namespace types
>=20
> void list_network_and_mount_namespaces(void)
> {
> 	struct ns_id_req req =3D {
> 		.size =3D sizeof(req),
> 		.ns_id =3D 0,
> 		.ns_type =3D NET_NS | MNT_NS, /* Network and mount */
> 		.user_ns_id =3D 0,
> 	};
> 	uint64_t ids[100];
> 	ssize_t ret;
>=20
> 	ret =3D listns(&req, ids, 100, 0);
> 	printf("Network and mount namespaces: %zd found\n", ret);
> }
>=20
> Example 5 : Pagination through large namespace sets
>=20
> void list_all_with_pagination(void)
> {
> 	struct ns_id_req req =3D {
> 		.size =3D sizeof(req),
> 		.ns_id =3D 0,
> 		.ns_type =3D 0,
> 		.user_ns_id =3D 0,
> 	};
> 	uint64_t ids[50];
> 	size_t total =3D 0;
> 	ssize_t ret;
>=20
> 	printf("Enumerating all namespaces with pagination:\n");
>=20
> 	while (1) {
> 		ret =3D listns(&req, ids, 50, 0);
> 		if (ret < 0) {
> 			perror("listns");
> 			break;
> 		}
> 		if (ret =3D=3D 0)
> 			break; /* No more namespaces */
>=20
> 		total +=3D ret;
> 		printf("  Batch: %zd namespaces\n", ret);
>=20
> 		/* Last ID in this batch becomes start of next batch */
> 		req.ns_id =3D ids[ret - 1];
>=20
> 		if (ret < 50)
> 			break; /* Partial batch =3D end of results */
> 	}
>=20
> 	printf("Total: %zu namespaces\n", total);
> }
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
> Christian Brauner (50):
>       libfs: allow to specify s_d_flags
>       nsfs: use inode_just_drop()
>       nsfs: raise DCACHE_DONTCACHE explicitly
>       pidfs: raise DCACHE_DONTCACHE explicitly
>       nsfs: raise SB_I_NODEV and SB_I_NOEXEC
>       nstree: simplify return
>       ns: initialize ns_list_node for initial namespaces
>       ns: add __ns_ref_read()
>       ns: add active reference count
>       ns: use anonymous struct to group list member
>       nstree: introduce a unified tree
>       nstree: allow lookup solely based on inode
>       nstree: assign fixed ids to the initial namespaces
>       ns: maintain list of owned namespaces
>       nstree: add listns()
>       arch: hookup listns() system call
>       nsfs: update tools header
>       selftests/filesystems: remove CLONE_NEWPIDNS from setup_userns() he=
lper
>       selftests/namespaces: first active reference count tests
>       selftests/namespaces: second active reference count tests
>       selftests/namespaces: third active reference count tests
>       selftests/namespaces: fourth active reference count tests
>       selftests/namespaces: fifth active reference count tests
>       selftests/namespaces: sixth active reference count tests
>       selftests/namespaces: seventh active reference count tests
>       selftests/namespaces: eigth active reference count tests
>       selftests/namespaces: ninth active reference count tests
>       selftests/namespaces: tenth active reference count tests
>       selftests/namespaces: eleventh active reference count tests
>       selftests/namespaces: twelth active reference count tests
>       selftests/namespaces: thirteenth active reference count tests
>       selftests/namespaces: fourteenth active reference count tests
>       selftests/namespaces: fifteenth active reference count tests
>       selftests/namespaces: add listns() wrapper
>       selftests/namespaces: first listns() test
>       selftests/namespaces: second listns() test
>       selftests/namespaces: third listns() test
>       selftests/namespaces: fourth listns() test
>       selftests/namespaces: fifth listns() test
>       selftests/namespaces: sixth listns() test
>       selftests/namespaces: seventh listns() test
>       selftests/namespaces: ninth listns() test
>       selftests/namespaces: ninth listns() test
>       selftests/namespaces: first listns() permission test
>       selftests/namespaces: second listns() permission test
>       selftests/namespaces: third listns() permission test
>       selftests/namespaces: fourth listns() permission test
>       selftests/namespaces: fifth listns() permission test
>       selftests/namespaces: sixth listns() permission test
>       selftests/namespaces: seventh listns() permission test
>=20
>  arch/alpha/kernel/syscalls/syscall.tbl             |    1 +
>  arch/arm/tools/syscall.tbl                         |    1 +
>  arch/arm64/tools/syscall_32.tbl                    |    1 +
>  arch/m68k/kernel/syscalls/syscall.tbl              |    1 +
>  arch/microblaze/kernel/syscalls/syscall.tbl        |    1 +
>  arch/mips/kernel/syscalls/syscall_n32.tbl          |    1 +
>  arch/mips/kernel/syscalls/syscall_n64.tbl          |    1 +
>  arch/mips/kernel/syscalls/syscall_o32.tbl          |    1 +
>  arch/parisc/kernel/syscalls/syscall.tbl            |    1 +
>  arch/powerpc/kernel/syscalls/syscall.tbl           |    1 +
>  arch/s390/kernel/syscalls/syscall.tbl              |    1 +
>  arch/sh/kernel/syscalls/syscall.tbl                |    1 +
>  arch/sparc/kernel/syscalls/syscall.tbl             |    1 +
>  arch/x86/entry/syscalls/syscall_32.tbl             |    1 +
>  arch/x86/entry/syscalls/syscall_64.tbl             |    1 +
>  arch/xtensa/kernel/syscalls/syscall.tbl            |    1 +
>  fs/libfs.c                                         |    1 +
>  fs/namespace.c                                     |    8 +-
>  fs/nsfs.c                                          |   79 +-
>  fs/pidfs.c                                         |    1 +
>  include/linux/ns_common.h                          |  147 +-
>  include/linux/nsfs.h                               |    3 +
>  include/linux/nstree.h                             |   26 +-
>  include/linux/pseudo_fs.h                          |    1 +
>  include/linux/syscalls.h                           |    4 +
>  include/uapi/asm-generic/unistd.h                  |    4 +-
>  include/uapi/linux/nsfs.h                          |   58 +
>  init/version-timestamp.c                           |    5 +
>  ipc/msgutil.c                                      |    5 +
>  ipc/namespace.c                                    |    1 +
>  kernel/cgroup/cgroup.c                             |    5 +
>  kernel/cgroup/namespace.c                          |    1 +
>  kernel/cred.c                                      |   17 +
>  kernel/exit.c                                      |    1 +
>  kernel/nscommon.c                                  |   59 +-
>  kernel/nsproxy.c                                   |    7 +
>  kernel/nstree.c                                    |  527 ++++-
>  kernel/pid.c                                       |   15 +
>  kernel/pid_namespace.c                             |    1 +
>  kernel/time/namespace.c                            |    6 +
>  kernel/user.c                                      |    5 +
>  kernel/user_namespace.c                            |    1 +
>  kernel/utsname.c                                   |    1 +
>  net/core/net_namespace.c                           |    3 +-
>  scripts/syscall.tbl                                |    1 +
>  tools/include/uapi/linux/nsfs.h                    |   70 +
>  tools/testing/selftests/filesystems/utils.c        |    2 +-
>  tools/testing/selftests/namespaces/.gitignore      |    3 +
>  tools/testing/selftests/namespaces/Makefile        |    7 +-
>  .../selftests/namespaces/listns_permissions_test.c |  777 +++++++
>  tools/testing/selftests/namespaces/listns_test.c   |  656 ++++++
>  .../selftests/namespaces/ns_active_ref_test.c      | 2226 ++++++++++++++=
++++++
>  tools/testing/selftests/namespaces/wrappers.h      |   35 +
>  53 files changed, 4737 insertions(+), 48 deletions(-)
> ---
> base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
> change-id: 20251020-work-namespace-nstree-listns-9fd71518515c

--=20
Jeff Layton <jlayton@kernel.org>

