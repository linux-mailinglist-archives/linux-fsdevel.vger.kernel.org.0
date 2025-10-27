Return-Path: <linux-fsdevel+bounces-65716-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F5A7C0E614
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Oct 2025 15:23:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E430462937
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Oct 2025 14:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82FC730DD35;
	Mon, 27 Oct 2025 14:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l15j1k7j"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDAF6307AF8;
	Mon, 27 Oct 2025 14:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761574218; cv=none; b=VBtRNiowW+chGpAOXCuJ0QIFwK2BGFvo6847ZAYbaS/E7ZWQwA0kq/fQQt0iOUd05uOjiz1n6Ecbod/3nbf7XMbZZ2ghXQ8GuzzSQ+x1XRPbOHuGleJLlueUzhI0FJtQB+YqG1skYMLiUEDkEMPDdFKk4GDHRIfMoWbDvkwfv3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761574218; c=relaxed/simple;
	bh=CjdQ/5cQ/4q2pAY7bUWuObYvjYAlf55jd7CNlNkzwQw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MTAxgOyBw2mvzWufdn/cm335KIJnsnubUKbxRINUkotjfhsW/3B4Ok/Wm3VuBzVjT7Diip0Ls0PCZ6rzYla1thVI/ApUXbPvJvmRzKr4mivkgBdSnGYG0UgsNEuCSNwPPmW/ds8dzDDtDXI1DkzxA2mjH09KI4+14ZoJT8RH1cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l15j1k7j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0780C4CEF1;
	Mon, 27 Oct 2025 14:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761574218;
	bh=CjdQ/5cQ/4q2pAY7bUWuObYvjYAlf55jd7CNlNkzwQw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=l15j1k7jCLo+s4hGnhGp7A8XUkqktLxNJMJx4fKmNpwSuLkcy5KLodor40FA6amNU
	 6Ew4Vu0n9RvqygmH70oDQLndGJF1wSU2ju5+qLPI2Fvb4SKxlu3iTkpmai5tb6erJK
	 3BuYMemNuMFrspEojp79juujN1xOUPxY1TCTobix/2gbISH9IcJIFgyJtgenWa2wlg
	 qvoWSz4gl7gVXVIrak/QiKFh9FTb/C/hKRb2v8QGARb2d6iV9voRSVn/NNwv3lLRu0
	 z/w5ZzzSC1cWXXF2lcSfp5McsItx7vBeUq4DbBgCdVOIGG+cY+dFAfQssjugTg5aqf
	 EwCwHVuWMvX7A==
Message-ID: <5ab02765a247dbaebc7d1224ee20a3bc01adc330.camel@kernel.org>
Subject: Re: [PATCH v3 00/70] nstree: listns()
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
Date: Mon, 27 Oct 2025 10:10:15 -0400
In-Reply-To: <20251024-work-namespace-nstree-listns-v3-0-b6241981b72b@kernel.org>
References: 
	<20251024-work-namespace-nstree-listns-v3-0-b6241981b72b@kernel.org>
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
> Hey,
>=20
> As announced a while ago this is the next step building on the nstree
> work from prior cycles. There's a bunch of fixes and semantic cleanups
> in here and a ton of tests.
>=20
> Currently listns() is relying on active namespace reference counts which
> are introduced alongside this series.
>=20
> While a namespace is on the namespace trees with a valid reference count
> it is possible to reopen it through a namespace file handle. This is all
> fine but has some issues that should be addressed.
>=20
> On current kernels a namespace is visible to userspace in the
> following cases:
>=20
> (1) The namespace is in use by a task.
> (2) The namespace is persisted through a VFS object (namespace file
>     descriptor or bind-mount).
>     Note that (2) only cares about direct persistence of the namespace
>     itself not indirectly via e.g., file->f_cred file references or
>     similar.
> (3) The namespace is a hierarchical namespace type and is the parent of
>     a single or multiple child namespaces.
>=20
> Case (3) is interesting because it is possible that a parent namespace
> might not fulfill any of (1) or (2), i.e., is invisible to userspace but
> it may still be resurrected through the NS_GET_PARENT ioctl().
>=20
> Currently namespace file handles allow much broader access to namespaces
> than what is currently possible via (1)-(3). The reason is that
> namespaces may remain pinned for completely internal reasons yet are
> inaccessible to userspace.
>=20
> For example, a user namespace my remain pinned by get_cred() calls to
> stash the opener's credentials into file->f_cred. As it stands file
> handles allow to resurrect such a users namespace even though this
> should not be possible via (1)-(3). This is a fundamental uapi change
> that we shouldn't do if we don't have to.
>=20
> Consider the following insane case: Various architectures support the
> CONFIG_MMU_LAZY_TLB_REFCOUNT option which uses lazy TLB destruction.
> When this option is set a userspace task's struct mm_struct may be used
> for kernel threads such as the idle task and will only be destroyed once
> the cpu's runqueue switches back to another task. But because of ptrace()
> permission checks struct mm_struct stashes the user namespace of the
> task that struct mm_struct originally belonged to. The kernel thread
> will take a reference on the struct mm_struct and thus pin it.
>=20
> So on an idle system user namespaces can be persisted for arbitrary
> amounts of time which also means that they can be resurrected using
> namespace file handles. That makes no sense whatsoever. The problem is
> of course excarabted on large systems with a huge number of cpus.
>=20
> To handle this nicely we introduce an active reference count which
> tracks (1)-(3). This is easy to do as all of these things are already
> managed centrally. Only (1)-(3) will count towards the active reference
> count and only namespaces which are active may be opened via namespace
> file handles.
>=20
> The problem is that namespaces may be resurrected. Which means that they
> can become temporarily inactive and will be reactived some time later.
> Currently the only example of this is the SIOGCSKNS socket ioctl. The
> SIOCGSKNS ioctl allows to open a network namespace file descriptor based
> on a socket file descriptor.
>=20
> If a socket is tied to a network namespace that subsequently becomes
> inactive but that socket is persisted by another process in another
> network namespace (e.g., via SCM_RIGHTS of pidfd_getfd()) then the
> SIOCGSKNS ioctl will resurrect this network namespace.
>=20
> So calls to open_related_ns() and open_namespace() will end up
> resurrecting the corresponding namespace tree.
>=20
> Note that the active reference count does not regulate the lifetime of
> the namespace itself. This is still done by the normal reference count.
> The active reference count can only be elevated if the regular reference
> count is elevated.
>=20
> The active reference count also doesn't regulate the presence of a
> namespace on the namespace trees. It only regulates its visiblity to
> namespace file handles (and in later patches to listns()).
>=20
> A namespace remains on the namespace trees from creation until its
> actual destruction. This will allow the kernel to always reach any
> namespace trivially and it will also enable subsystems like bpf to walk
> the namespace lists on the system for tracing or general introspection
> purposes.
>=20
> Note that different namespaces have different visibility lifetimes on
> current kernels. While most namespace are immediately released when the
> last task using them exits, the user- and pid namespace are persisted
> and thus both remain accessible via /proc/<pid>/ns/<ns_type>.
>=20
> The user namespace lifetime is aliged with struct cred and is only
> released through exit_creds(). However, it becomes inaccessible to
> userspace once the last task using it is reaped, i.e., when
> release_task() is called and all proc entries are flushed. Similarly,
> the pid namespace is also visible until the last task using it has been
> reaped and the associated pid numbers are freed.
>=20
> The active reference counts of the user- and pid namespace are
> decremented once the task is reaped.
>=20
> Based on the namespace trees and the active reference count, a new
> listns() system call that allows userspace to iterate through namespaces
> in the system. This provides a programmatic interface to discover and
> inspect namespaces, enhancing existing namespace apis.
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
> Changes in v3:
> - Expanded test-suite.
> - Moved active reference count tracking for task-attached namespaces to
>   dedicated helpers.
> - Fixed active reference count leaks when creating a new process fails.
> - Allow to be rescheduled when walking a a long namespace list.
> - Grab reference count when accessing a namespace when walking the list.
> - Link to v2: https://patch.msgid.link/20251022-work-namespace-nstree-lis=
tns-v2-0-71a588572371@kernel.org
>=20
> Changes in v2:
> - Fully implement the active reference count.
> - Fix various minor issues.
> - Expand the testsuite to test complex resurrection scenarios due to SIOC=
GSKNS.
> - Currently each task takes an active reference on the user namespace as
>   credentials can be persisted for a very long time and completely
>   arbitrary reasons but we don't want to tie the lifetime of a user
>   namespace being visible to userspace to the existence of some
>   credentials being stashed somewhere. We want to tie it to it being
>   in-use by actual tasks or vfs objects and then go away. There might be
>   more clever ways of doing this but for now this is good enough.
> - TODO: Add detailed tests for multi-threaded namespace sharing.
> - Link to v1: https://patch.msgid.link/20251021-work-namespace-nstree-lis=
tns-v1-0-ad44261a8a5b@kernel.org
>=20
> ---
> Christian Brauner (70):
>       libfs: allow to specify s_d_flags
>       nsfs: use inode_just_drop()
>       nsfs: raise DCACHE_DONTCACHE explicitly
>       pidfs: raise DCACHE_DONTCACHE explicitly
>       nsfs: raise SB_I_NODEV and SB_I_NOEXEC
>       cgroup: add cgroup namespace to tree after owner is set
>       nstree: simplify return
>       ns: initialize ns_list_node for initial namespaces
>       ns: add __ns_ref_read()
>       ns: rename to exit_nsproxy_namespaces()
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
>       selftests/namespaces: eigth listns() test
>       selftests/namespaces: ninth listns() test
>       selftests/namespaces: first listns() permission test
>       selftests/namespaces: second listns() permission test
>       selftests/namespaces: third listns() permission test
>       selftests/namespaces: fourth listns() permission test
>       selftests/namespaces: fifth listns() permission test
>       selftests/namespaces: sixth listns() permission test
>       selftests/namespaces: seventh listns() permission test
>       selftests/namespaces: first inactive namespace resurrection test
>       selftests/namespaces: second inactive namespace resurrection test
>       selftests/namespaces: third inactive namespace resurrection test
>       selftests/namespaces: fourth inactive namespace resurrection test
>       selftests/namespaces: fifth inactive namespace resurrection test
>       selftests/namespaces: sixth inactive namespace resurrection test
>       selftests/namespaces: seventh inactive namespace resurrection test
>       selftests/namespaces: eigth inactive namespace resurrection test
>       selftests/namespaces: ninth inactive namespace resurrection test
>       selftests/namespaces: tenth inactive namespace resurrection test
>       selftests/namespaces: eleventh inactive namespace resurrection test
>       selftests/namespaces: twelth inactive namespace resurrection test
>       selftests/namespace: first threaded active reference count test
>       selftests/namespace: second threaded active reference count test
>       selftests/namespace: third threaded active reference count test
>       selftests/namespace: commit_creds() active reference tests
>       selftests/namespace: add stress test
>       selftests/namespace: test listns() pagination
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
>  fs/nsfs.c                                          |   95 +-
>  fs/pidfs.c                                         |    1 +
>  include/linux/ns_common.h                          |  166 +-
>  include/linux/nsfs.h                               |    3 +
>  include/linux/nsproxy.h                            |    5 +-
>  include/linux/nstree.h                             |   26 +-
>  include/linux/pseudo_fs.h                          |    1 +
>  include/linux/syscalls.h                           |    4 +
>  include/linux/user_namespace.h                     |    4 +-
>  include/uapi/asm-generic/unistd.h                  |    4 +-
>  include/uapi/linux/nsfs.h                          |   58 +
>  init/version-timestamp.c                           |    5 +
>  ipc/msgutil.c                                      |    5 +
>  ipc/namespace.c                                    |    1 +
>  kernel/cgroup/cgroup.c                             |   11 +-
>  kernel/cgroup/namespace.c                          |    3 +-
>  kernel/cred.c                                      |    6 +
>  kernel/exit.c                                      |    3 +-
>  kernel/fork.c                                      |    3 +-
>  kernel/nscommon.c                                  |  227 +-
>  kernel/nsproxy.c                                   |   25 +-
>  kernel/nstree.c                                    |  540 +++-
>  kernel/pid.c                                       |   10 +
>  kernel/pid_namespace.c                             |    1 +
>  kernel/time/namespace.c                            |    6 +
>  kernel/user.c                                      |    5 +
>  kernel/user_namespace.c                            |    1 +
>  kernel/utsname.c                                   |    1 +
>  net/core/net_namespace.c                           |    3 +-
>  scripts/syscall.tbl                                |    1 +
>  tools/include/uapi/linux/nsfs.h                    |   70 +
>  tools/testing/selftests/filesystems/utils.c        |    2 +-
>  tools/testing/selftests/namespaces/.gitignore      |    7 +
>  tools/testing/selftests/namespaces/Makefile        |   20 +-
>  .../selftests/namespaces/cred_change_test.c        |  814 ++++++
>  .../selftests/namespaces/listns_pagination_bug.c   |  138 +
>  .../selftests/namespaces/listns_permissions_test.c |  759 ++++++
>  tools/testing/selftests/namespaces/listns_test.c   |  679 +++++
>  .../selftests/namespaces/ns_active_ref_test.c      | 2672 ++++++++++++++=
++++++
>  .../testing/selftests/namespaces/siocgskns_test.c  | 1824 +++++++++++++
>  tools/testing/selftests/namespaces/stress_test.c   |  626 +++++
>  tools/testing/selftests/namespaces/wrappers.h      |   35 +
>  60 files changed, 8835 insertions(+), 60 deletions(-)
> ---
> base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
> change-id: 20251020-work-namespace-nstree-listns-9fd71518515c

This looks pretty great overall, Christian. Nice work!

I hate the fact that we have to deal with resurrection here since it
makes things much messier, but I don't see a great alternative. I found
the nsfs filehandle format, btw, so that seems fine.

You can add this to patches 1-19, though I'd still prefer that you
split the ns_owner_tree handling out of patch #17 and into a separate
patch.

Reviewed-by: Jeff Layton <jlayton@kernel.org>

