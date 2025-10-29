Return-Path: <linux-fsdevel+bounces-66213-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE456C1A2C3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 13:21:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D87ED460148
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 12:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF87933DEDC;
	Wed, 29 Oct 2025 12:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HF2azsTm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2887033A010;
	Wed, 29 Oct 2025 12:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761740438; cv=none; b=i4CHBnyFK4xB7Z5y5v1cunkjre+H7Re7vKb+xbi6C322avK2cc9SuV4UlPtiwnbpbHsoQSzcKNwt3mz/ga2MlEyaWdOig5VmEp4qZi3gYWyrYOEBQY6vsNr1UiSspNboxPgscExrYZf6sbaM1BDxfSL6lQ7Z6BCOkbdLdQpC2N8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761740438; c=relaxed/simple;
	bh=IXAKaRmQx8kCXopK1IeSRTC4xw+HPJ9tb8xoGXoljRE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=TGe8gFfP91T6bwY3rp0C+7E+01QG/7b55QfJoPc1pEwH6nicTH2WZpmA1LMoJcRLI06x8hpFsOYhKgkDBbmS0BUu62KEF/RIdn6SJNN3RT4WNsJqrTt69dhnATwummppQo0/djqeV8J6VT1+ZP6xOrDIih+nTWyH6OwMifxKrmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HF2azsTm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D105AC4CEFD;
	Wed, 29 Oct 2025 12:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761740437;
	bh=IXAKaRmQx8kCXopK1IeSRTC4xw+HPJ9tb8xoGXoljRE=;
	h=From:Subject:Date:To:Cc:From;
	b=HF2azsTmpEq32rvGJ0E58bJvw+RCB8i+aXWgMv4ludxrzkP6exs76ZTf58Qf2pPIc
	 4wNjTORsN6/fOoF7zGcO2sxa0mO6wHiQgPjcs1MspSjkSF/UOm7usBgJG5L1T9b7Fz
	 C09Qo0S+x+7V2uVwMgu5kodfKB4GkHg0dIYGRJgVYX2IU/6OUeqPAmlY6Vf10XBtMI
	 2QIoxzPzdAIYkLZ720JmOq/kWuZAT7LvBxDHh5hyX0vtDM9MCCbwC6Y9v7K082C2TH
	 AxMvC1oQ8jp4gunU7XLU6hs2xN+ObIgNaijTj426s1QTSbnwX4J/d+X7fnrsNUpNKG
	 TTmssRxnkRabA==
From: Christian Brauner <brauner@kernel.org>
Subject: [PATCH v4 00/72] nstree: listns()
Date: Wed, 29 Oct 2025 13:20:13 +0100
Message-Id: <20251029-work-namespace-nstree-listns-v4-0-2e6f823ebdc0@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAH0GAmkC/4XOwWrDMBAE0F8JOlfGu5YsJaf+R8lBkjexSCKHl
 VFagv+9cqCQUmiOc5g3cxeZOFIWu81dMJWY45RqUG8bEUaXjiTjULPAFjW02MrbxCeZ3IXy1QW
 SKc9MJM8xzynL7WEwoMFq0EFU4sp0iJ8P/mNfs3eZpGeXwriiF5dn4qb0DVjJAdbKWKWJvx6HC
 qzFn234f7uAbKUblMIenHXav5+IE52biY9iHS/4rOELDatmwGlrtcHOwB+te9bUC62rmu9Rwda
 CN/j727Is32e2laiIAQAA
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=21424; i=brauner@kernel.org;
 h=from:subject:message-id; bh=IXAKaRmQx8kCXopK1IeSRTC4xw+HPJ9tb8xoGXoljRE=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQysXWX9ea4299an7l4TfnEGYaTas9O3VtdOSVLbG1d0
 Uv+rsr+jlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIm8qWdk6OWUnS3vVVl8KGTj
 jcrXp9lVuJh6nbvSdzCKbLkZ86jmKMNfqSVhQc4LK/p9Hd/V/laTFkjc+qhGa8lUzcMHe2ZZLRB
 jBQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Hey,

As announced a while ago this is the next step building on the nstree
work from prior cycles. There's a bunch of fixes and semantic cleanups
in here and a ton of tests.

Currently listns() is relying on active namespace reference counts which
are introduced alongside this series.

While a namespace is on the namespace trees with a valid reference count
it is possible to reopen it through a namespace file handle. This is all
fine but has some issues that should be addressed.

On current kernels a namespace is visible to userspace in the
following cases:

(1) The namespace is in use by a task.
(2) The namespace is persisted through a VFS object (namespace file
    descriptor or bind-mount).
    Note that (2) only cares about direct persistence of the namespace
    itself not indirectly via e.g., file->f_cred file references or
    similar.
(3) The namespace is a hierarchical namespace type and is the parent of
    a single or multiple child namespaces.

Case (3) is interesting because it is possible that a parent namespace
might not fulfill any of (1) or (2), i.e., is invisible to userspace but
it may still be resurrected through the NS_GET_PARENT ioctl().

Currently namespace file handles allow much broader access to namespaces
than what is currently possible via (1)-(3). The reason is that
namespaces may remain pinned for completely internal reasons yet are
inaccessible to userspace.

For example, a user namespace my remain pinned by get_cred() calls to
stash the opener's credentials into file->f_cred. As it stands file
handles allow to resurrect such a users namespace even though this
should not be possible via (1)-(3). This is a fundamental uapi change
that we shouldn't do if we don't have to.

Consider the following insane case: Various architectures support the
CONFIG_MMU_LAZY_TLB_REFCOUNT option which uses lazy TLB destruction.
When this option is set a userspace task's struct mm_struct may be used
for kernel threads such as the idle task and will only be destroyed once
the cpu's runqueue switches back to another task. But because of ptrace()
permission checks struct mm_struct stashes the user namespace of the
task that struct mm_struct originally belonged to. The kernel thread
will take a reference on the struct mm_struct and thus pin it.

So on an idle system user namespaces can be persisted for arbitrary
amounts of time which also means that they can be resurrected using
namespace file handles. That makes no sense whatsoever. The problem is
of course excarabted on large systems with a huge number of cpus.

To handle this nicely we introduce an active reference count which
tracks (1)-(3). This is easy to do as all of these things are already
managed centrally. Only (1)-(3) will count towards the active reference
count and only namespaces which are active may be opened via namespace
file handles.

The problem is that namespaces may be resurrected. Which means that they
can become temporarily inactive and will be reactived some time later.
Currently the only example of this is the SIOGCSKNS socket ioctl. The
SIOCGSKNS ioctl allows to open a network namespace file descriptor based
on a socket file descriptor.

If a socket is tied to a network namespace that subsequently becomes
inactive but that socket is persisted by another process in another
network namespace (e.g., via SCM_RIGHTS of pidfd_getfd()) then the
SIOCGSKNS ioctl will resurrect this network namespace.

So calls to open_related_ns() and open_namespace() will end up
resurrecting the corresponding namespace tree.

Note that the active reference count does not regulate the lifetime of
the namespace itself. This is still done by the normal reference count.
The active reference count can only be elevated if the regular reference
count is elevated.

The active reference count also doesn't regulate the presence of a
namespace on the namespace trees. It only regulates its visiblity to
namespace file handles (and in later patches to listns()).

A namespace remains on the namespace trees from creation until its
actual destruction. This will allow the kernel to always reach any
namespace trivially and it will also enable subsystems like bpf to walk
the namespace lists on the system for tracing or general introspection
purposes.

Note that different namespaces have different visibility lifetimes on
current kernels. While most namespace are immediately released when the
last task using them exits, the user- and pid namespace are persisted
and thus both remain accessible via /proc/<pid>/ns/<ns_type>.

The user namespace lifetime is aliged with struct cred and is only
released through exit_creds(). However, it becomes inaccessible to
userspace once the last task using it is reaped, i.e., when
release_task() is called and all proc entries are flushed. Similarly,
the pid namespace is also visible until the last task using it has been
reaped and the associated pid numbers are freed.

The active reference counts of the user- and pid namespace are
decremented once the task is reaped.

Based on the namespace trees and the active reference count, a new
listns() system call that allows userspace to iterate through namespaces
in the system. This provides a programmatic interface to discover and
inspect namespaces, enhancing existing namespace apis.

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
Changes in v4:
- Fold __ns_ref_active_get_owner() into __ns_tree_add_raw() as suggested
  by Thomas.
- Don't use kvmalloc() instead use put_user() directly as suggested by
  Arnd.
- Various minor documentation fixes.
- Unify various codepaths in the listns() implementation.
- Link to v3: https://patch.msgid.link/20251024-work-namespace-nstree-listns-v3-0-b6241981b72b@kernel.org

Changes in v3:
- Expanded test-suite.
- Moved active reference count tracking for task-attached namespaces to
  dedicated helpers.
- Fixed active reference count leaks when creating a new process fails.
- Allow to be rescheduled when walking a a long namespace list.
- Grab reference count when accessing a namespace when walking the list.
- Link to v2: https://patch.msgid.link/20251022-work-namespace-nstree-listns-v2-0-71a588572371@kernel.org

Changes in v2:
- Fully implement the active reference count.
- Fix various minor issues.
- Expand the testsuite to test complex resurrection scenarios due to SIOCGSKNS.
- Currently each task takes an active reference on the user namespace as
  credentials can be persisted for a very long time and completely
  arbitrary reasons but we don't want to tie the lifetime of a user
  namespace being visible to userspace to the existence of some
  credentials being stashed somewhere. We want to tie it to it being
  in-use by actual tasks or vfs objects and then go away. There might be
  more clever ways of doing this but for now this is good enough.
- TODO: Add detailed tests for multi-threaded namespace sharing.
- Link to v1: https://patch.msgid.link/20251021-work-namespace-nstree-listns-v1-0-ad44261a8a5b@kernel.org

---
Christian Brauner (72):
      libfs: allow to specify s_d_flags
      nsfs: use inode_just_drop()
      nsfs: raise DCACHE_DONTCACHE explicitly
      pidfs: raise DCACHE_DONTCACHE explicitly
      nsfs: raise SB_I_NODEV and SB_I_NOEXEC
      cgroup: add cgroup namespace to tree after owner is set
      nstree: simplify return
      ns: initialize ns_list_node for initial namespaces
      ns: add __ns_ref_read()
      ns: rename to exit_nsproxy_namespaces()
      ns: add active reference count
      ns: use anonymous struct to group list member
      nstree: introduce a unified tree
      nstree: allow lookup solely based on inode
      nstree: assign fixed ids to the initial namespaces
      nstree: maintain list of owned namespaces
      nstree: simplify rbtree comparison helpers
      nstree: add unified namespace list
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
      selftests/namespaces: eigth listns() test
      selftests/namespaces: ninth listns() test
      selftests/namespaces: first listns() permission test
      selftests/namespaces: second listns() permission test
      selftests/namespaces: third listns() permission test
      selftests/namespaces: fourth listns() permission test
      selftests/namespaces: fifth listns() permission test
      selftests/namespaces: sixth listns() permission test
      selftests/namespaces: seventh listns() permission test
      selftests/namespaces: first inactive namespace resurrection test
      selftests/namespaces: second inactive namespace resurrection test
      selftests/namespaces: third inactive namespace resurrection test
      selftests/namespaces: fourth inactive namespace resurrection test
      selftests/namespaces: fifth inactive namespace resurrection test
      selftests/namespaces: sixth inactive namespace resurrection test
      selftests/namespaces: seventh inactive namespace resurrection test
      selftests/namespaces: eigth inactive namespace resurrection test
      selftests/namespaces: ninth inactive namespace resurrection test
      selftests/namespaces: tenth inactive namespace resurrection test
      selftests/namespaces: eleventh inactive namespace resurrection test
      selftests/namespaces: twelth inactive namespace resurrection test
      selftests/namespace: first threaded active reference count test
      selftests/namespace: second threaded active reference count test
      selftests/namespace: third threaded active reference count test
      selftests/namespace: commit_creds() active reference tests
      selftests/namespace: add stress test
      selftests/namespace: test listns() pagination

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
 fs/namespace.c                                     |    7 +-
 fs/nsfs.c                                          |   94 +-
 fs/pidfs.c                                         |    1 +
 include/linux/ns_common.h                          |  165 +-
 include/linux/nsfs.h                               |    3 +
 include/linux/nsproxy.h                            |    5 +-
 include/linux/nstree.h                             |   26 +-
 include/linux/pseudo_fs.h                          |    1 +
 include/linux/syscalls.h                           |    4 +
 include/linux/user_namespace.h                     |    4 +-
 include/uapi/asm-generic/unistd.h                  |    4 +-
 include/uapi/linux/nsfs.h                          |   58 +
 init/version-timestamp.c                           |    5 +
 ipc/msgutil.c                                      |    5 +
 kernel/cgroup/cgroup.c                             |   11 +-
 kernel/cgroup/namespace.c                          |    2 +-
 kernel/cred.c                                      |    6 +
 kernel/exit.c                                      |    3 +-
 kernel/fork.c                                      |    3 +-
 kernel/nscommon.c                                  |  220 +-
 kernel/nsproxy.c                                   |   25 +-
 kernel/nstree.c                                    |  610 ++++-
 kernel/pid.c                                       |   10 +
 kernel/time/namespace.c                            |    5 +
 kernel/user.c                                      |    5 +
 net/core/net_namespace.c                           |    2 +-
 scripts/syscall.tbl                                |    1 +
 tools/include/uapi/linux/nsfs.h                    |   70 +
 tools/testing/selftests/filesystems/utils.c        |    2 +-
 tools/testing/selftests/namespaces/.gitignore      |    7 +
 tools/testing/selftests/namespaces/Makefile        |   20 +-
 .../selftests/namespaces/cred_change_test.c        |  814 ++++++
 .../selftests/namespaces/listns_pagination_bug.c   |  138 +
 .../selftests/namespaces/listns_permissions_test.c |  759 ++++++
 tools/testing/selftests/namespaces/listns_test.c   |  679 +++++
 .../selftests/namespaces/ns_active_ref_test.c      | 2672 ++++++++++++++++++++
 .../testing/selftests/namespaces/siocgskns_test.c  | 1824 +++++++++++++
 tools/testing/selftests/namespaces/stress_test.c   |  626 +++++
 tools/testing/selftests/namespaces/wrappers.h      |   35 +
 56 files changed, 8879 insertions(+), 69 deletions(-)
---
base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
change-id: 20251020-work-namespace-nstree-listns-9fd71518515c


