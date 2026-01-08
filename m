Return-Path: <linux-fsdevel+bounces-72699-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 10D83D007B2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 08 Jan 2026 01:41:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D372A30422A1
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jan 2026 00:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05A2C1DDC1D;
	Thu,  8 Jan 2026 00:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mg4MKFr+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6031F32C8B;
	Thu,  8 Jan 2026 00:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767832826; cv=none; b=NBD5IRPqi9ExZllTNGJObTBjidMNe+U3MGF+9PB/3Y2tW9FqdGhRiLf6oFJyPMGo12O2qimlvQq5UTrpBiKXWo5rRuub1vQlpDcI9f4ulG6kQNeB7eXlXcLJdoy+dcz51A6Cb9HBqmXqXoBgoux/4cEs12hXFio0ZoIVo/k0HYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767832826; c=relaxed/simple;
	bh=Y2TeSJuRq1ULlfcb2Eh3mmGFskHc2aaTfA4ZlENRgMc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T4Y82CLGrMQ6gYAlVdA6UXB0m9ctrcU08mFR4zIXrGmo+c2cxFd4q7a3gOf9SE+tpMHPJ1eROlyUE24Q0bpSygDsOSZxE9bl/NCRycrLA1WGRdeiY52htEUCJd987ThZWnPc2fKX0UPgxDz6oVuw8i5iTNmZAMS3FRATYl52qPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mg4MKFr+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CCB2C19423;
	Thu,  8 Jan 2026 00:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767832825;
	bh=Y2TeSJuRq1ULlfcb2Eh3mmGFskHc2aaTfA4ZlENRgMc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Mg4MKFr+/0rLSE7+XGHfM42eTvpzwHK7SRlTNQrEHpeNe3gQuezUbDn/QmqhAaiY9
	 zQyGdr9tGhXmSZpZJgJDuQEk9NJANaSfbKMSDqmZ4hZrFHg/Vttk44mA5poWwLsizJ
	 0zgRS6h5gbbuN+bEJbwePvflVjWaCw2kl3htZlhWsCzs1VTGAABvBQDVbFsGBisSqb
	 /7PZqmCJCg3HFZaC9oz6FWNGEIaY9oO9S7QKfOyon97YdCWSVei/QbPRWJWSqsry11
	 87ptK8wzBTyTzKWFT28PlXGEFGRvA9hFhQLdhXaJ9P1rFIb02Z5LEh6xyZ0l8czuvV
	 tJz75AKzd7n3A==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v2 5/6] nfsd: revoke NFSv4 state when filesystem is unmounted
Date: Wed,  7 Jan 2026 19:40:15 -0500
Message-ID: <20260108004016.3907158-6-cel@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260108004016.3907158-1-cel@kernel.org>
References: <20260108004016.3907158-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

When an NFS server's local filesystem is unmounted while NFS
clients are still accessing it, NFSv4 state holds files open
which pins the filesystem, preventing unmount.

Currently, administrators have to manually revoke that state via
/proc/fs/nfsd/unlock_fs before a formerly exported filesystem
can be unmounted.

Use the kernel's fs_pin mechanism to detect filesystem unmounts
and revoke NFSv4 state and NLM locks associated with that
filesystem. An xarray in nfsd_net tracks per-superblock pins. When
any NFS state is created, a pin is registered (idempotently) for
that superblock. When the filesystem is unmounted, VFS invokes the
kill callback which queues work to:
 - Cancel ongoing async COPY operations (nfsd4_cancel_copy_by_sb)
 - Release NLM locks (nlmsvc_unlock_all_by_sb)
 - Revoke NFSv4 state (nfsd4_revoke_states)

The code uses pin_insert_sb() to register superblock-only pins
rather than pin_insert() which registers both mount and superblock
pins. This is necessary because the VFS unmount sequence calls
mnt_pin_kill() before clearing SB_ACTIVE, but group_pin_kill()
after. Callers of nfsd_pin_sb() hold open file references, so
SB_ACTIVE cannot be cleared during pin registration; a
WARN_ON_ONCE guards against unexpected violations.

The revocation work runs on a dedicated workqueue (nfsd_pin_wq) to
avoid deadlocks since the VFS kill callback runs with locks held.
Synchronization between VFS unmount and NFSD shutdown uses
xa_erase() atomicity: the path that successfully erases the xarray
entry triggers work.

If state revocation takes an unexpectedly long time (e.g., when
re-exporting an NFS mount whose backend server is unresponsive),
periodic warnings are emitted every 30 seconds. The wait is
interruptible: if interrupted before work starts, cancel_work()
removes the queued work and revocation runs directly in the
unmount context; if work is already running, the kill callback
returns and revocation continues in the background. Open files
keep the superblock alive until revocation closes them. Note that
NFSD remains pinned until revocation completes.

The pin infrastructure is placed in a new file (pin.c) because it
is agnostic to NFS protocol version. This will become more apparent
with the next patch.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/Makefile    |   2 +-
 fs/nfsd/netns.h     |   4 +
 fs/nfsd/nfs4state.c |  26 +++++
 fs/nfsd/nfsctl.c    |  10 +-
 fs/nfsd/pin.c       | 272 ++++++++++++++++++++++++++++++++++++++++++++
 fs/nfsd/state.h     |   7 ++
 6 files changed, 318 insertions(+), 3 deletions(-)
 create mode 100644 fs/nfsd/pin.c

diff --git a/fs/nfsd/Makefile b/fs/nfsd/Makefile
index f0da4d69dc74..b9ef1fe13164 100644
--- a/fs/nfsd/Makefile
+++ b/fs/nfsd/Makefile
@@ -13,7 +13,7 @@ nfsd-y			+= trace.o
 nfsd-y 			+= nfssvc.o nfsctl.o nfsfh.o vfs.o \
 			   export.o auth.o lockd.o nfscache.o \
 			   stats.o filecache.o nfs3proc.o nfs3xdr.o \
-			   netlink.o
+			   netlink.o pin.o
 nfsd-$(CONFIG_NFSD_V2) += nfsproc.o nfsxdr.o
 nfsd-$(CONFIG_NFSD_V2_ACL) += nfs2acl.o
 nfsd-$(CONFIG_NFSD_V3_ACL) += nfs3acl.o
diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
index 9fa600602658..d9cf8e4f8ae9 100644
--- a/fs/nfsd/netns.h
+++ b/fs/nfsd/netns.h
@@ -13,6 +13,7 @@
 #include <linux/filelock.h>
 #include <linux/nfs4.h>
 #include <linux/percpu_counter.h>
+#include <linux/xarray.h>
 #include <linux/percpu-refcount.h>
 #include <linux/siphash.h>
 #include <linux/sunrpc/stats.h>
@@ -219,6 +220,9 @@ struct nfsd_net {
 	/* last time an admin-revoke happened for NFSv4.0 */
 	time64_t		nfs40_last_revoke;
 
+	/* fs_pin tracking for automatic state revocation on unmount */
+	struct xarray		nfsd_sb_pins;
+
 #if IS_ENABLED(CONFIG_NFS_LOCALIO)
 	/* Local clients to be invalidated when net is shut down */
 	spinlock_t              local_clients_lock;
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 1efab85c647d..dc4ff2035bf0 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -6451,6 +6451,16 @@ nfsd4_process_open2(struct svc_rqst *rqstp, struct svc_fh *current_fh, struct nf
 		status = nfserr_bad_stateid;
 		if (nfsd4_is_deleg_cur(open))
 			goto out;
+		/*
+		 * Pin the superblock so unmount can trigger revocation
+		 * of NFSv4 state (opens, locks, delegations) held by
+		 * clients on this filesystem. nfsd_pin_sb() returns
+		 * immediately if a pin already exists for this sb.
+		 */
+		status = nfsd_pin_sb(SVC_NET(rqstp),
+				     current_fh->fh_export->ex_path.mnt);
+		if (status)
+			goto out;
 	}
 
 	if (!stp) {
@@ -8987,6 +8997,8 @@ static int nfs4_state_create_net(struct net *net)
 	spin_lock_init(&nn->blocked_locks_lock);
 	INIT_LIST_HEAD(&nn->blocked_locks_lru);
 
+	nfsd_sb_pins_init(nn);
+
 	INIT_DELAYED_WORK(&nn->laundromat_work, laundromat_main);
 	/* Make sure this cannot run until client tracking is initialised */
 	disable_delayed_work(&nn->laundromat_work);
@@ -9104,6 +9116,8 @@ nfs4_state_shutdown_net(struct net *net)
 	struct list_head *pos, *next, reaplist;
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
 
+	nfsd_sb_pins_shutdown(nn);
+
 	shrinker_free(nn->nfsd_client_shrinker);
 	cancel_work_sync(&nn->nfsd_shrinker_work);
 	disable_delayed_work_sync(&nn->laundromat_work);
@@ -9458,6 +9472,18 @@ nfsd_get_dir_deleg(struct nfsd4_compound_state *cstate,
 	if (rfp != fp) {
 		put_nfs4_file(fp);
 		fp = rfp;
+	} else {
+		/*
+		 * Pin the superblock so unmount can trigger revocation
+		 * of directory delegations held by clients on this
+		 * filesystem. nfsd_pin_sb() returns immediately if a
+		 * pin already exists for this sb.
+		 */
+		if (nfsd_pin_sb(clp->net,
+				cstate->current_fh.fh_export->ex_path.mnt)) {
+			put_nfs4_file(fp);
+			return ERR_PTR(-EAGAIN);
+		}
 	}
 
 	/* if this client already has one, return that it's unavailable */
diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index 30caefb2522f..5fccc88ece76 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -2325,9 +2325,12 @@ static int __init init_nfsd(void)
 	retval = nfsd4_create_laundry_wq();
 	if (retval)
 		goto out_free_cld;
+	retval = nfsd_pin_init();
+	if (retval)
+		goto out_free_laundry;
 	retval = register_filesystem(&nfsd_fs_type);
 	if (retval)
-		goto out_free_nfsd4;
+		goto out_free_pin;
 	retval = genl_register_family(&nfsd_nl_family);
 	if (retval)
 		goto out_free_filesystem;
@@ -2341,7 +2344,9 @@ static int __init init_nfsd(void)
 	genl_unregister_family(&nfsd_nl_family);
 out_free_filesystem:
 	unregister_filesystem(&nfsd_fs_type);
-out_free_nfsd4:
+out_free_pin:
+	nfsd_pin_exit();
+out_free_laundry:
 	nfsd4_destroy_laundry_wq();
 out_free_cld:
 	unregister_cld_notifier();
@@ -2364,6 +2369,7 @@ static void __exit exit_nfsd(void)
 	remove_proc_entry("fs/nfs", NULL);
 	genl_unregister_family(&nfsd_nl_family);
 	unregister_filesystem(&nfsd_fs_type);
+	nfsd_pin_exit();
 	nfsd4_destroy_laundry_wq();
 	unregister_cld_notifier();
 	unregister_pernet_subsys(&nfsd_net_ops);
diff --git a/fs/nfsd/pin.c b/fs/nfsd/pin.c
new file mode 100644
index 000000000000..eefa4baff82c
--- /dev/null
+++ b/fs/nfsd/pin.c
@@ -0,0 +1,272 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Filesystem pin management for NFSD.
+ *
+ * When a local filesystem is unmounted while NFS clients hold state,
+ * this code automatically revokes that state so the unmount can proceed.
+ *
+ * Copyright (C) 2025 Oracle. All rights reserved.
+ *
+ * Author: Chuck Lever <chuck.lever@oracle.com>
+ */
+
+#include <linux/fs.h>
+#include <linux/fs_pin.h>
+#include <linux/slab.h>
+#include <linux/sunrpc/svc.h>
+#include <linux/lockd/lockd.h>
+
+#include "nfsd.h"
+#include "netns.h"
+#include "state.h"
+
+#define NFSDDBG_FACILITY	NFSDDBG_PROC
+
+static struct workqueue_struct *nfsd_pin_wq;
+
+/*
+ * Structure to track fs_pin per superblock for automatic state revocation
+ * when a filesystem is unmounted.
+ */
+struct nfsd_fs_pin {
+	struct fs_pin		pin;
+	struct super_block	*sb;
+	struct net		*net;
+	struct work_struct	work;
+	struct completion	done;
+	struct rcu_head		rcu;
+};
+
+static void nfsd_fs_pin_kill(struct fs_pin *pin);
+
+static void nfsd_fs_pin_free_rcu(struct rcu_head *rcu)
+{
+	struct nfsd_fs_pin *p = container_of(rcu, struct nfsd_fs_pin, rcu);
+
+	put_net(p->net);
+	kfree(p);
+}
+
+/*
+ * Work function for nfsd_fs_pin - runs in process context.
+ * Cancels async COPYs, releases NLM locks, and revokes NFSv4 state for
+ * the superblock.
+ */
+static void nfsd_fs_pin_work(struct work_struct *work)
+{
+	struct nfsd_fs_pin *p = container_of(work, struct nfsd_fs_pin, work);
+	struct nfsd_net *nn = net_generic(p->net, nfsd_net_id);
+
+	pr_info("nfsd: unmount of %s, revoking NFS state\n", p->sb->s_id);
+
+	nfsd4_cancel_copy_by_sb(p->net, p->sb);
+	/* Errors are logged by lockd; no recovery is possible. */
+	(void)nlmsvc_unlock_all_by_sb(p->sb);
+	nfsd4_revoke_states(nn, p->sb);
+
+	pr_info("nfsd: state revocation for %s complete\n", p->sb->s_id);
+
+	pin_remove(&p->pin);
+	complete(&p->done);
+	call_rcu(&p->rcu, nfsd_fs_pin_free_rcu);
+}
+
+/* Interval for progress warnings during unmount (in seconds) */
+#define NFSD_STATE_REVOKE_INTERVAL	30
+
+/**
+ * nfsd_fs_pin_kill - Kill callback for nfsd_fs_pin
+ * @pin: fs_pin representing filesystem to be unmounted
+ *
+ * Queues state revocation and waits for completion. If interrupted,
+ * returns early; the work function handles cleanup. Open files keep
+ * the superblock alive until revocation closes them.
+ *
+ * Synchronization with nfsd_sb_pins_destroy(): xa_erase() is atomic,
+ * so exactly one of the two paths erases the entry and triggers work.
+ */
+static void nfsd_fs_pin_kill(struct fs_pin *pin)
+{
+	struct nfsd_fs_pin *p = container_of(pin, struct nfsd_fs_pin, pin);
+	struct nfsd_net *nn = net_generic(p->net, nfsd_net_id);
+	unsigned int elapsed = 0;
+	long ret;
+
+	if (!xa_erase(&nn->nfsd_sb_pins, (unsigned long)p->sb))
+		return;
+
+	queue_work(nfsd_pin_wq, &p->work);
+
+	/*
+	 * Block until state revocation completes. Periodic warnings help
+	 * diagnose stuck operations (e.g., re-exports of an NFS mount
+	 * whose backend server is unresponsive).
+	 *
+	 * The work function handles pin_remove() and freeing, so this
+	 * callback can return early on interrupt. Open files keep the
+	 * superblock alive until revocation closes them. Note that NFSD
+	 * remains pinned until revocation completes.
+	 */
+	for (;;) {
+		ret = wait_for_completion_interruptible_timeout(&p->done,
+						NFSD_STATE_REVOKE_INTERVAL * HZ);
+		if (ret > 0)
+			return;
+
+		if (ret == -ERESTARTSYS) {
+			/*
+			 * Interrupted by signal. If the work has not yet
+			 * started, cancel it and run in this context: a
+			 * successful cancel_work() means no other context
+			 * will execute the work function, so it must run
+			 * here to ensure state revocation occurs.
+			 *
+			 * If already running, return and let work complete
+			 * in background; open files keep superblock alive.
+			 */
+			if (cancel_work(&p->work)) {
+				pr_warn("nfsd: unmount of %s interrupted, revoking state in unmount context\n",
+					p->sb->s_id);
+				nfsd_fs_pin_work(&p->work);
+				return;
+			}
+			pr_warn("nfsd: unmount of %s interrupted; mount remains pinned until state revocation completes\n",
+				p->sb->s_id);
+			return;
+		}
+
+		/* Timed out - print warning and continue waiting */
+		elapsed += NFSD_STATE_REVOKE_INTERVAL;
+		pr_warn("nfsd: unmount of %s blocked for %u seconds waiting for NFS state revocation\n",
+			p->sb->s_id, elapsed);
+	}
+}
+
+/**
+ * nfsd_pin_sb - register a superblock to enable state revocation
+ * @net: network namespace
+ * @mnt: vfsmount for the filesystem
+ *
+ * If NFS state is created for a file on this filesystem, pin the
+ * superblock so the kill callback can revoke that state on unmount.
+ * Returns nfs_ok on success, or an NFS error on failure.
+ *
+ * This function is idempotent - if a pin already exists for the
+ * superblock, no new pin is created.
+ */
+__be32 nfsd_pin_sb(struct net *net, struct vfsmount *mnt)
+{
+	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
+	struct super_block *sb = mnt->mnt_sb;
+	struct nfsd_fs_pin *new, *old;
+
+	old = xa_load(&nn->nfsd_sb_pins, (unsigned long)sb);
+	if (old)
+		return nfs_ok;
+
+	new = kzalloc(sizeof(*new), GFP_KERNEL);
+	if (!new)
+		return nfserr_jukebox;
+
+	new->sb = sb;
+	new->net = get_net(net);
+	init_fs_pin(&new->pin, nfsd_fs_pin_kill);
+	INIT_WORK(&new->work, nfsd_fs_pin_work);
+	init_completion(&new->done);
+
+	old = xa_cmpxchg(&nn->nfsd_sb_pins, (unsigned long)sb, NULL, new,
+			 GFP_KERNEL);
+	if (old) {
+		/*
+		 * Another task beat us to it. Even if the winner has not
+		 * yet called pin_insert_sb(), returning here is safe: the
+		 * caller holds an open file reference that prevents
+		 * unmount from completing until state creation finishes.
+		 */
+		put_net(new->net);
+		kfree(new);
+		return nfs_ok;
+	}
+
+	pin_insert_sb(&new->pin, mnt);
+
+	/*
+	 * Callers hold an open file reference, so unmount cannot clear
+	 * SB_ACTIVE while this function executes. Warn if this assumption
+	 * is violated, but handle it gracefully by cleaning up and
+	 * returning an error.
+	 */
+	if (WARN_ON_ONCE(!(READ_ONCE(sb->s_flags) & SB_ACTIVE))) {
+		new = xa_erase(&nn->nfsd_sb_pins, (unsigned long)sb);
+		if (new) {
+			pin_remove(&new->pin);
+			call_rcu(&new->rcu, nfsd_fs_pin_free_rcu);
+		}
+		return nfserr_stale;
+	}
+
+	return nfs_ok;
+}
+
+/**
+ * nfsd_sb_pins_init - initialize the superblock pins xarray
+ * @nn: nfsd_net for this network namespace
+ */
+void nfsd_sb_pins_init(struct nfsd_net *nn)
+{
+	xa_init(&nn->nfsd_sb_pins);
+}
+
+/*
+ * Clean up all fs_pins during NFSD shutdown.
+ *
+ * xa_erase() synchronizes with nfsd_fs_pin_kill(): the path that
+ * successfully erases an xarray entry performs cleanup for that pin.
+ * A NULL return indicates the VFS unmount path is performing cleanup.
+ */
+static void nfsd_sb_pins_destroy(struct nfsd_net *nn)
+{
+	struct nfsd_fs_pin *p;
+	unsigned long index;
+
+	xa_for_each(&nn->nfsd_sb_pins, index, p) {
+		p = xa_erase(&nn->nfsd_sb_pins, index);
+		if (!p)
+			continue; /* VFS unmount path handling this pin */
+		pin_remove(&p->pin);
+		call_rcu(&p->rcu, nfsd_fs_pin_free_rcu);
+	}
+	xa_destroy(&nn->nfsd_sb_pins);
+}
+
+/**
+ * nfsd_sb_pins_shutdown - shutdown superblock pins for a network namespace
+ * @nn: nfsd_net for this network namespace
+ *
+ * Must be called during nfsd shutdown before tearing down client state.
+ * Flushes any pending work and waits for RCU callbacks to complete.
+ */
+void nfsd_sb_pins_shutdown(struct nfsd_net *nn)
+{
+	nfsd_sb_pins_destroy(nn);
+	flush_workqueue(nfsd_pin_wq);
+	/*
+	 * Wait for RCU callbacks from nfsd_sb_pins_destroy() to complete.
+	 * These callbacks release network namespace references via put_net()
+	 * which must happen before the namespace teardown continues.
+	 */
+	rcu_barrier();
+}
+
+int nfsd_pin_init(void)
+{
+	nfsd_pin_wq = alloc_workqueue("nfsd_pin", WQ_UNBOUND, 0);
+	if (!nfsd_pin_wq)
+		return -ENOMEM;
+	return 0;
+}
+
+void nfsd_pin_exit(void)
+{
+	destroy_workqueue(nfsd_pin_wq);
+}
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index e415b8200fff..1494dd34759f 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -853,6 +853,13 @@ static inline void nfsd4_revoke_states(struct nfsd_net *nn, struct super_block *
 }
 #endif
 
+/* superblock pin management (pin.c) */
+int nfsd_pin_init(void);
+void nfsd_pin_exit(void);
+__be32 nfsd_pin_sb(struct net *net, struct vfsmount *mnt);
+void nfsd_sb_pins_init(struct nfsd_net *nn);
+void nfsd_sb_pins_shutdown(struct nfsd_net *nn);
+
 /* grace period management */
 bool nfsd4_force_end_grace(struct nfsd_net *nn);
 
-- 
2.52.0


