Return-Path: <linux-fsdevel+bounces-64851-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37368BF61CF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 13:44:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4DAE188B4DF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 11:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D699B32ED44;
	Tue, 21 Oct 2025 11:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EPlVC1He"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DBD932ED25;
	Tue, 21 Oct 2025 11:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761047031; cv=none; b=DAwhjb6pm9+2cR3v5b8IwqFHEj9gmGJQRAfA9HqDd8BV2m5IiTIoozO3oHQcvmewLMZVw895A7b/tuhUuRc8m9x4cRVVtpgrGJVjrQ9LtyImPqZMmHcIrCx1+t6x8N1e2WHJKHD1FauQOJpxJ4J4MouKzYX7A+uv+bQN4IFp9n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761047031; c=relaxed/simple;
	bh=sK0dCg220OfIojkcpKbkuzPKWkQvjQto7R5M6iKB6ss=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ulS7wrxV5p5HjAXwqMKlXd2lcWGoMaPXPFI2GtI4XriIh+cpYlGxpIbu8ae6COCfRt0NURADh9U54ZMl4NebSxXvKxUgZlMPVKscrIZIjdJo9pcu0tY4RjCzppQTfwMNlw5bByQwwojjNXXpeZ2as6Nl6/gqfd9HgBEo66jVhHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EPlVC1He; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8866C4CEF1;
	Tue, 21 Oct 2025 11:43:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761047028;
	bh=sK0dCg220OfIojkcpKbkuzPKWkQvjQto7R5M6iKB6ss=;
	h=From:Subject:Date:To:Cc:From;
	b=EPlVC1HeXTxT4vHDevfrSN2cvuclWNx0XhdEVx44hPxLApB6KTwBlax+u8owLXYbY
	 H7hlO+pWtMif2FEHrU8EZ2mwYfSy59PYbKURbboMAEW++sGKUlZJZiujgI6VGl5flW
	 ZNjKAtihJ6k1nIdvaf23Y4V/ph8g3FXA3lslkuLnvRx8Yr6fspX/NeLaKHCmVhe1J9
	 9Wf1LkdbU51X/xnu9snSbC7KopOYAABFAFjFqeWYdHeAvMj+NYTueyZgfK8HgcKF7n
	 OjAY69u9WQzIaiCvKOckr90QYMJOKgzQYoAW0KJannGiKjuVS20BPD/asQi+LGYTbj
	 wthBsoDT+iDUw==
From: Christian Brauner <brauner@kernel.org>
Subject: [PATCH RFC DRAFT 00/50] nstree: listns()
Date: Tue, 21 Oct 2025 13:43:06 +0200
Message-Id: <20251021-work-namespace-nstree-listns-v1-0-ad44261a8a5b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMpx92gC/x3MwQqCQBCA4VeROTfiCFvWLQofQLpFh3UdczFXm
 RELxHdv6/jzw7eCsnhWOCUrCC9e/Rhi0C4B19nwZPRNbMiz3FCWZ/gepcdgB9bJOsagszDjy+s
 cFI9tcyBDhSHjIBKTcOs/f/4OVXlJrtW5vMEjrtoqYy02uO7nD1ZnlnTZp1SgOIJt+wJvbyT3n
 AAAAA==
X-Change-ID: 20251020-work-namespace-nstree-listns-9fd71518515c
To: linux-fsdevel@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>, 
 Jeff Layton <jlayton@kernel.org>
Cc: Jann Horn <jannh@google.com>, Mike Yuan <me@yhndnzj.com>, 
 =?utf-8?q?Zbigniew_J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, 
 Lennart Poettering <mzxreary@0pointer.de>, 
 Daan De Meyer <daan.j.demeyer@gmail.com>, Aleksa Sarai <cyphar@cyphar.com>, 
 Amir Goldstein <amir73il@gmail.com>, Tejun Heo <tj@kernel.org>, 
 Johannes Weiner <hannes@cmpxchg.org>, Thomas Gleixner <tglx@linutronix.de>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, bpf@vger.kernel.org, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 netdev@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-96507
X-Developer-Signature: v=1; a=openpgp-sha256; l=16671; i=brauner@kernel.org;
 h=from:subject:message-id; bh=sK0dCg220OfIojkcpKbkuzPKWkQvjQto7R5M6iKB6ss=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWR8L3yzpv1D6LG52XNZXbI0Th9Z8rm5TOEJm0qL5X0Tc
 6XnG9z8OkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACZSpMTwzzizPvUN5y/FFrNp
 G87GlL+d8tvQk/+9d7Dfm8a3i4zYexn+R3GL5hoIvVPPUetatVCySLq2Sqi3JujMlQ9/120yctz
 HDwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Hey,

As announced a while ago this is the next step building on the nstree
work from prior cycles. There's a bunch of fixes and semantic cleanups
in here and a ton of tests.

I need helper here!: Consider the following current design:

Currently listns() is relying on active namespace reference counts which
are introduced alongside this series.

The active reference count of a namespace consists of the live tasks
that make use of this namespace and any namespace file descriptors that
explicitly pin the namespace.

Once all tasks making use of this namespace have exited or reaped, all
namespace file descriptors for that namespace have been closed and all
bind-mounts for that namespace unmounted it ceases to appear in the
listns() output.

My reason for introducing the active reference count was that namespaces
might obviously still be pinned internally for various reasons. For
example the user namespace might still be pinned because there are still
open files that have stashed the openers credentials in file->f_cred, or
the last reference might be put with an rcu delay keeping that namespace
active on the namespace lists.

But one particularly strange example is CONFIG_MMU_LAZY_TLB_REFCOUNT=y.
Various architectures support the CONFIG_MMU_LAZY_TLB_REFCOUNT option
which uses lazy TLB destruction.

When this option is set a userspace task's struct mm_struct may be used
for kernel threads such as the idle task and will only be destroyed once
the cpu's runqueue switches back to another task. So the kernel thread
will take a reference on the struct mm_struct pinning it.

And for ptrace() based access checks struct mm_struct stashes the user
namespace of the task that struct mm_struct belonged to originally and
thus takes a reference to the users namespace and pins it.

So on an idle system such user namespaces can be persisted for pretty
arbitrary amounts of time via struct mm_struct.

Now, without the active reference count regulating visibility all
namespace that still are pinned in some way on the system will appear in
the listns() output and can be reopened using namespace file handles.

Of course that requires suitable privileges and it's not really a
concern per se because a task could've also persist the namespace
recorded in struct mm_struct explicitly and then the idle task would
still reuse that struct mm_struct and another task could still happily
setns() to it afaict and reuse it for something else.

The active reference count though has drawbacks itself. Namely that
socket files break the assumption that namespaces can only be opened if
there's either live processes pinning the namespace or there are file
descriptors open that pin the namespace itself as the socket SIOCGSKNS
ioctl() can be used to open a network namespace based on a socket which
only indirectly pins a network namespace.

So that punches a whole in the active reference count tracking. So this
will have to be handled as right now socket file descriptors that pin a
network namespace that don't have an active reference anymore (no live
processes, not explicit persistence via namespace fds) can't be used to
issue a SIOCGSKNS ioctl() to open the associated network namespace.

So two options I see if the api is based on ids:

(1) We use the active reference count and somehow also make it work with
    sockets.
(2) The active reference count is not needed and we say that listns() is
    an introspection system call anyway so we just always list
    namespaces regardless of why they are still pinned: files,
    mm_struct, network devices, everything is fair game.
(3) Throw hands up in the air and just not do it.

=====================================================================

Add a new listns() system call that allows userspace to iterate through
namespaces in the system. This provides a programmatic interface to
discover and inspect namespaces, enhancing existing namespace apis.

Currently, there is no direct way for userspace to enumerate namespaces
in the system. Applications must resort to scanning /proc/<pid>/ns/
across all processes, which is:

1. Inefficient - requires iterating over all processes
2. Incomplete - misses inactive namespaces that aren't attached to any
   running process but are kept alive by file descriptors, bind mounts,
   or parent namespace references
3. Permission-heavy - requires access to /proc for many processes
4. No ordering or ownership.
5. No filtering per namespace type: Must always iterate and check all
   namespaces.

The list goes on. The listns() system call solves these problems by
providing direct kernel-level enumeration of namespaces. It is similar
to listmount() but obviously tailored to namespaces.

/*
 * @req: Pointer to struct ns_id_req specifying search parameters
 * @ns_ids: User buffer to receive namespace IDs
 * @nr_ns_ids: Size of ns_ids buffer (maximum number of IDs to return)
 * @flags: Reserved for future use (must be 0)
 */
ssize_t listns(const struct ns_id_req *req, u64 *ns_ids,
               size_t nr_ns_ids, unsigned int flags);

Returns:
- On success: Number of namespace IDs written to ns_ids
- On error: Negative error code

/*
 * @size: Structure size
 * @ns_id: Starting point for iteration; use 0 for first call, then
 *         use the last returned ID for subsequent calls to paginate
 * @ns_type: Bitmask of namespace types to include (from enum ns_type):
 *           0: Return all namespace types
 *           MNT_NS: Mount namespaces
 *           NET_NS: Network namespaces
 *           USER_NS: User namespaces
 *           etc. Can be OR'd together
 * @user_ns_id: Filter results to namespaces owned by this user namespace:
 *              0: Return all namespaces (subject to permission checks)
 *              LISTNS_CURRENT_USER: Namespaces owned by caller's user namespace
 *              Other value: Namespaces owned by the specified user namespace ID
 */
struct ns_id_req {
        __u32 size;         /* sizeof(struct ns_id_req) */
        __u32 spare;        /* Reserved, must be 0 */
        __u64 ns_id;        /* Last seen namespace ID (for pagination) */
        __u32 ns_type;      /* Filter by namespace type(s) */
        __u32 spare2;       /* Reserved, must be 0 */
        __u64 user_ns_id;   /* Filter by owning user namespace */
};

Example 1: List all namespaces

void list_all_namespaces(void)
{
	struct ns_id_req req = {
		.size = sizeof(req),
		.ns_id = 0,      /* Start from beginning */
		.ns_type = 0,    /* All types */
		.user_ns_id = 0, /* All user namespaces */
	};
	uint64_t ids[100];
	ssize_t ret;

	printf("All namespaces in the system:\n");
	do {
		ret = listns(&req, ids, 100, 0);
		if (ret < 0) {
			perror("listns");
			break;
		}

		for (ssize_t i = 0; i < ret; i++)
			printf("  Namespace ID: %llu\n", (unsigned long long)ids[i]);

		/* Continue from last seen ID */
		if (ret > 0)
			req.ns_id = ids[ret - 1];
	} while (ret == 100); /* Buffer was full, more may exist */
}

Example 2 : List network namespaces only

void list_network_namespaces(void)
{
	struct ns_id_req req = {
		.size = sizeof(req),
		.ns_id = 0,
		.ns_type = NET_NS, /* Only network namespaces */
		.user_ns_id = 0,
	};
	uint64_t ids[100];
	ssize_t ret;

	ret = listns(&req, ids, 100, 0);
	if (ret < 0) {
		perror("listns");
		return;
	}

	printf("Network namespaces: %zd found\n", ret);
	for (ssize_t i = 0; i < ret; i++)
		printf("  netns ID: %llu\n", (unsigned long long)ids[i]);
}

Example 3 : List namespaces owned by current user namespace

void list_owned_namespaces(void)
{
	struct ns_id_req req = {
		.size = sizeof(req),
		.ns_id = 0,
		.ns_type = 0,                      /* All types */
		.user_ns_id = LISTNS_CURRENT_USER, /* Current userns */
	};
	uint64_t ids[100];
	ssize_t ret;

	ret = listns(&req, ids, 100, 0);
	if (ret < 0) {
		perror("listns");
		return;
	}

	printf("Namespaces owned by my user namespace: %zd\n", ret);
	for (ssize_t i = 0; i < ret; i++)
		printf("  ns ID: %llu\n", (unsigned long long)ids[i]);
}

Example 4 : List multiple namespace types

void list_network_and_mount_namespaces(void)
{
	struct ns_id_req req = {
		.size = sizeof(req),
		.ns_id = 0,
		.ns_type = NET_NS | MNT_NS, /* Network and mount */
		.user_ns_id = 0,
	};
	uint64_t ids[100];
	ssize_t ret;

	ret = listns(&req, ids, 100, 0);
	printf("Network and mount namespaces: %zd found\n", ret);
}

Example 5 : Pagination through large namespace sets

void list_all_with_pagination(void)
{
	struct ns_id_req req = {
		.size = sizeof(req),
		.ns_id = 0,
		.ns_type = 0,
		.user_ns_id = 0,
	};
	uint64_t ids[50];
	size_t total = 0;
	ssize_t ret;

	printf("Enumerating all namespaces with pagination:\n");

	while (1) {
		ret = listns(&req, ids, 50, 0);
		if (ret < 0) {
			perror("listns");
			break;
		}
		if (ret == 0)
			break; /* No more namespaces */

		total += ret;
		printf("  Batch: %zd namespaces\n", ret);

		/* Last ID in this batch becomes start of next batch */
		req.ns_id = ids[ret - 1];

		if (ret < 50)
			break; /* Partial batch = end of results */
	}

	printf("Total: %zu namespaces\n", total);
}

listns() respects namespace isolation and capabilities:

(1) Global listing (user_ns_id = 0):
    - Requires CAP_SYS_ADMIN in the namespace's owning user namespace
    - OR the namespace must be in the caller's namespace context (e.g.,
      a namespace the caller is currently using)
    - User namespaces additionally allow listing if the caller has
      CAP_SYS_ADMIN in that user namespace itself
(2) Owner-filtered listing (user_ns_id != 0):
    - Requires CAP_SYS_ADMIN in the specified owner user namespace
    - OR the namespace must be in the caller's namespace context
    - This allows unprivileged processes to enumerate namespaces they own
(3) Visibility:
    - Only "active" namespaces are listed
    - A namespace is active if it has a non-zero __ns_ref_active count
    - This includes namespaces used by running processes, held by open
      file descriptors, or kept active by bind mounts
    - Inactive namespaces (kept alive only by internal kernel
      references) are not visible via listns()

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
Christian Brauner (50):
      libfs: allow to specify s_d_flags
      nsfs: use inode_just_drop()
      nsfs: raise DCACHE_DONTCACHE explicitly
      pidfs: raise DCACHE_DONTCACHE explicitly
      nsfs: raise SB_I_NODEV and SB_I_NOEXEC
      nstree: simplify return
      ns: initialize ns_list_node for initial namespaces
      ns: add __ns_ref_read()
      ns: add active reference count
      ns: use anonymous struct to group list member
      nstree: introduce a unified tree
      nstree: allow lookup solely based on inode
      nstree: assign fixed ids to the initial namespaces
      ns: maintain list of owned namespaces
      nstree: add listns()
      arch: hookup listns() system call
      nsfs: update tools header
      selftests/filesystems: remove CLONE_NEWPIDNS from setup_userns() helper
      selftests/namespaces: first active reference count tests
      selftests/namespaces: second active reference count tests
      selftests/namespaces: third active reference count tests
      selftests/namespaces: fourth active reference count tests
      selftests/namespaces: fifth active reference count tests
      selftests/namespaces: sixth active reference count tests
      selftests/namespaces: seventh active reference count tests
      selftests/namespaces: eigth active reference count tests
      selftests/namespaces: ninth active reference count tests
      selftests/namespaces: tenth active reference count tests
      selftests/namespaces: eleventh active reference count tests
      selftests/namespaces: twelth active reference count tests
      selftests/namespaces: thirteenth active reference count tests
      selftests/namespaces: fourteenth active reference count tests
      selftests/namespaces: fifteenth active reference count tests
      selftests/namespaces: add listns() wrapper
      selftests/namespaces: first listns() test
      selftests/namespaces: second listns() test
      selftests/namespaces: third listns() test
      selftests/namespaces: fourth listns() test
      selftests/namespaces: fifth listns() test
      selftests/namespaces: sixth listns() test
      selftests/namespaces: seventh listns() test
      selftests/namespaces: ninth listns() test
      selftests/namespaces: ninth listns() test
      selftests/namespaces: first listns() permission test
      selftests/namespaces: second listns() permission test
      selftests/namespaces: third listns() permission test
      selftests/namespaces: fourth listns() permission test
      selftests/namespaces: fifth listns() permission test
      selftests/namespaces: sixth listns() permission test
      selftests/namespaces: seventh listns() permission test

 arch/alpha/kernel/syscalls/syscall.tbl             |    1 +
 arch/arm/tools/syscall.tbl                         |    1 +
 arch/arm64/tools/syscall_32.tbl                    |    1 +
 arch/m68k/kernel/syscalls/syscall.tbl              |    1 +
 arch/microblaze/kernel/syscalls/syscall.tbl        |    1 +
 arch/mips/kernel/syscalls/syscall_n32.tbl          |    1 +
 arch/mips/kernel/syscalls/syscall_n64.tbl          |    1 +
 arch/mips/kernel/syscalls/syscall_o32.tbl          |    1 +
 arch/parisc/kernel/syscalls/syscall.tbl            |    1 +
 arch/powerpc/kernel/syscalls/syscall.tbl           |    1 +
 arch/s390/kernel/syscalls/syscall.tbl              |    1 +
 arch/sh/kernel/syscalls/syscall.tbl                |    1 +
 arch/sparc/kernel/syscalls/syscall.tbl             |    1 +
 arch/x86/entry/syscalls/syscall_32.tbl             |    1 +
 arch/x86/entry/syscalls/syscall_64.tbl             |    1 +
 arch/xtensa/kernel/syscalls/syscall.tbl            |    1 +
 fs/libfs.c                                         |    1 +
 fs/namespace.c                                     |    8 +-
 fs/nsfs.c                                          |   79 +-
 fs/pidfs.c                                         |    1 +
 include/linux/ns_common.h                          |  147 +-
 include/linux/nsfs.h                               |    3 +
 include/linux/nstree.h                             |   26 +-
 include/linux/pseudo_fs.h                          |    1 +
 include/linux/syscalls.h                           |    4 +
 include/uapi/asm-generic/unistd.h                  |    4 +-
 include/uapi/linux/nsfs.h                          |   58 +
 init/version-timestamp.c                           |    5 +
 ipc/msgutil.c                                      |    5 +
 ipc/namespace.c                                    |    1 +
 kernel/cgroup/cgroup.c                             |    5 +
 kernel/cgroup/namespace.c                          |    1 +
 kernel/cred.c                                      |   17 +
 kernel/exit.c                                      |    1 +
 kernel/nscommon.c                                  |   59 +-
 kernel/nsproxy.c                                   |    7 +
 kernel/nstree.c                                    |  527 ++++-
 kernel/pid.c                                       |   15 +
 kernel/pid_namespace.c                             |    1 +
 kernel/time/namespace.c                            |    6 +
 kernel/user.c                                      |    5 +
 kernel/user_namespace.c                            |    1 +
 kernel/utsname.c                                   |    1 +
 net/core/net_namespace.c                           |    3 +-
 scripts/syscall.tbl                                |    1 +
 tools/include/uapi/linux/nsfs.h                    |   70 +
 tools/testing/selftests/filesystems/utils.c        |    2 +-
 tools/testing/selftests/namespaces/.gitignore      |    3 +
 tools/testing/selftests/namespaces/Makefile        |    7 +-
 .../selftests/namespaces/listns_permissions_test.c |  777 +++++++
 tools/testing/selftests/namespaces/listns_test.c   |  656 ++++++
 .../selftests/namespaces/ns_active_ref_test.c      | 2226 ++++++++++++++++++++
 tools/testing/selftests/namespaces/wrappers.h      |   35 +
 53 files changed, 4737 insertions(+), 48 deletions(-)
---
base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
change-id: 20251020-work-namespace-nstree-listns-9fd71518515c


