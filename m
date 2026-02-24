Return-Path: <linux-fsdevel+bounces-78287-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cIH0BTLWnWk0SQQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78287-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 17:47:46 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B15018A072
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 17:47:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B406831EA361
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 16:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7E473AE70D;
	Tue, 24 Feb 2026 16:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tZLM9wKd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D393AE6F2;
	Tue, 24 Feb 2026 16:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771951153; cv=none; b=fQadetJWL795xU1wHcL09BwDDQ2qIhdNwLC5ubfnTiKpKbr5Ei1lStGK5kiYEmU38O5iivnWaAiHwmFm8owMAxvJHbhK40zDBydtY+/cb8RL2I8Ft2j/EtF0e6XWe3+s2krC5ivVF+l+EmnJvg/YL1boJOKfbI7T/+vg5QT11kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771951153; c=relaxed/simple;
	bh=9clOHcgbdO4lewCbPq+twqADjEi+SDDtferQgm6dDmQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J51GQl6tLPGfFXO5lj+QVHcpEc/DpZYdxOYRzMlOwWcbvI7+UJMmNRxYRlLmc2Kng1/2CNyKJSGZwrY9A6Lu6ZB+B26hTG1yJGX8KMOxibzdgRzl/NDR1AL4mcmBNrYvunSpcUDpXSKgKa4vujNJMP/vZ4dnfJBdP7F139mkP0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tZLM9wKd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0692C116D0;
	Tue, 24 Feb 2026 16:39:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771951153;
	bh=9clOHcgbdO4lewCbPq+twqADjEi+SDDtferQgm6dDmQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tZLM9wKdlTqQsLGeqk/8uK2dqtfoAdCuO1cJcFjwJDPeN2Wl8PomjMkyqwn45/gCO
	 F3Iseljwcs0hAN/3Ib+44z07apVti1oBM+MXTjaN56QTPeLivgnobTiEwQWtSs4qJA
	 6TDvWqZT5l09pGtpSMC/iJxSkC96n3Eb/GkeC+Dbj/sJUq6i5S5uNuBV5BLOxi063X
	 FIuqmukTtRTn3I1Ei1xefGKWK7oa06/mdXBKTvjBoLzePMK04jd+oS7LV24XHJFVzr
	 33zzs1xsCEcp4KWnwMA+vWz9CLmKdMLQgE3HXIpEI8Lwcmlukv67IN+vgiwcI/pX/a
	 Flmzm5XbMFiiA==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v3 2/3] nfsd: revoke NFSv4 state when filesystem is unmounted
Date: Tue, 24 Feb 2026 11:39:07 -0500
Message-ID: <20260224163908.44060-3-cel@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260224163908.44060-1-cel@kernel.org>
References: <20260224163908.44060-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-78287-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[ownmail.net,kernel.org,redhat.com,oracle.com,talpey.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8B15018A072
X-Rspamd-Action: no action

From: Chuck Lever <chuck.lever@oracle.com>

When an NFS server's local filesystem is unmounted while NFS clients
are still accessing it, NFSv4 state holds files open which pins the
filesystem, preventing unmount.

Previously, administrators had to manually revoke state via
/proc/fs/nfsd/unlock_fs before a formerly exported filesystem could
be unmounted.

Register with the VFS umount notifier chain to detect filesystem
unmounts and revoke NFSv4 state and NLM locks associated with that
filesystem. An xarray in nfsd_net tracks per-superblock entries.
When NFS state is created for a file on a given superblock, an entry
is registered (idempotently) for that superblock. When the filesystem
is unmounted, VFS invokes the notifier callback which queues work to:

 - Cancel ongoing async COPY operations (nfsd4_cancel_copy_by_sb)
 - Release NLM locks (nlmsvc_unlock_all_by_sb)
 - Revoke NFSv4 state (nfsd4_revoke_states)

Each network namespace registers its own notifier_block, allowing the
callback to directly access the correct nfsd_net via container_of().

The revocation work runs on a dedicated workqueue (nfsd_sb_wq) to
avoid deadlocks since the VFS notifier callback should not block for
extended periods. Synchronization between VFS unmount and NFSD shutdown
uses xa_erase() atomicity: the path that successfully erases the xarray
entry triggers work.

If state revocation takes an unexpectedly long time (e.g., when
re-exporting an NFS mount whose backend server is unresponsive),
periodic warnings are emitted every 30 seconds. The wait is
interruptible: if interrupted before work starts, cancel_work()
removes the queued work and revocation runs directly in the unmount
context; if work is already running, the callback returns and
revocation continues in the background. Open files keep the superblock
alive until revocation closes them.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/Makefile    |   2 +-
 fs/nfsd/netns.h     |   5 +
 fs/nfsd/nfs4state.c |  29 +++++
 fs/nfsd/nfsctl.c    |  10 +-
 fs/nfsd/sb_watch.c  | 273 ++++++++++++++++++++++++++++++++++++++++++++
 fs/nfsd/state.h     |   7 ++
 6 files changed, 323 insertions(+), 3 deletions(-)
 create mode 100644 fs/nfsd/sb_watch.c

diff --git a/fs/nfsd/Makefile b/fs/nfsd/Makefile
index f0da4d69dc74..bf6146283165 100644
--- a/fs/nfsd/Makefile
+++ b/fs/nfsd/Makefile
@@ -13,7 +13,7 @@ nfsd-y			+= trace.o
 nfsd-y 			+= nfssvc.o nfsctl.o nfsfh.o vfs.o \
 			   export.o auth.o lockd.o nfscache.o \
 			   stats.o filecache.o nfs3proc.o nfs3xdr.o \
-			   netlink.o
+			   netlink.o sb_watch.o
 nfsd-$(CONFIG_NFSD_V2) += nfsproc.o nfsxdr.o
 nfsd-$(CONFIG_NFSD_V2_ACL) += nfs2acl.o
 nfsd-$(CONFIG_NFSD_V3_ACL) += nfs3acl.o
diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
index 9fa600602658..bc6004c85a4d 100644
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
@@ -219,6 +220,10 @@ struct nfsd_net {
 	/* last time an admin-revoke happened for NFSv4.0 */
 	time64_t		nfs40_last_revoke;
 
+	/* Superblock watch for automatic state revocation on unmount */
+	struct xarray		nfsd_sb_watches;
+	struct notifier_block	nfsd_umount_notifier;
+
 #if IS_ENABLED(CONFIG_NFS_LOCALIO)
 	/* Local clients to be invalidated when net is shut down */
 	spinlock_t              local_clients_lock;
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 6b9c399b89df..d35a578db1c0 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -6463,6 +6463,16 @@ nfsd4_process_open2(struct svc_rqst *rqstp, struct svc_fh *current_fh, struct nf
 		status = nfserr_bad_stateid;
 		if (nfsd4_is_deleg_cur(open))
 			goto out;
+		/*
+		 * Watch the superblock so unmount can trigger revocation
+		 * of NFSv4 state (opens, locks, delegations) held by
+		 * clients on this filesystem. nfsd_sb_watch() returns
+		 * immediately if a watch already exists for this sb.
+		 */
+		status = nfsd_sb_watch(SVC_NET(rqstp),
+				       current_fh->fh_export->ex_path.mnt);
+		if (status)
+			goto out;
 	}
 
 	if (!stp) {
@@ -9010,8 +9020,13 @@ static int nfs4_state_create_net(struct net *net)
 
 	shrinker_register(nn->nfsd_client_shrinker);
 
+	if (nfsd_sb_watch_setup(nn))
+		goto err_sb_entries;
+
 	return 0;
 
+err_sb_entries:
+	shrinker_free(nn->nfsd_client_shrinker);
 err_shrinker:
 	put_net(net);
 	kfree(nn->sessionid_hashtbl);
@@ -9111,6 +9126,8 @@ nfs4_state_shutdown_net(struct net *net)
 	struct list_head *pos, *next, reaplist;
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
 
+	nfsd_sb_watch_shutdown(nn);
+
 	shrinker_free(nn->nfsd_client_shrinker);
 	cancel_work_sync(&nn->nfsd_shrinker_work);
 	disable_delayed_work_sync(&nn->laundromat_work);
@@ -9465,6 +9482,18 @@ nfsd_get_dir_deleg(struct nfsd4_compound_state *cstate,
 	if (rfp != fp) {
 		put_nfs4_file(fp);
 		fp = rfp;
+	} else {
+		/*
+		 * Watch the superblock so unmount can trigger revocation
+		 * of directory delegations held by clients on this
+		 * filesystem. nfsd_sb_watch() returns immediately if a
+		 * watch already exists for this sb.
+		 */
+		if (nfsd_sb_watch(clp->net,
+				  cstate->current_fh.fh_export->ex_path.mnt)) {
+			put_nfs4_file(fp);
+			return ERR_PTR(-EAGAIN);
+		}
 	}
 
 	/* if this client already has one, return that it's unavailable */
diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index e9acd2cd602c..5d8a95a48ff9 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -2268,9 +2268,12 @@ static int __init init_nfsd(void)
 	retval = nfsd4_create_laundry_wq();
 	if (retval)
 		goto out_free_cld;
+	retval = nfsd_sb_watch_init();
+	if (retval)
+		goto out_free_laundry;
 	retval = register_filesystem(&nfsd_fs_type);
 	if (retval)
-		goto out_free_nfsd4;
+		goto out_free_sb;
 	retval = genl_register_family(&nfsd_nl_family);
 	if (retval)
 		goto out_free_filesystem;
@@ -2284,7 +2287,9 @@ static int __init init_nfsd(void)
 	genl_unregister_family(&nfsd_nl_family);
 out_free_filesystem:
 	unregister_filesystem(&nfsd_fs_type);
-out_free_nfsd4:
+out_free_sb:
+	nfsd_sb_watch_exit();
+out_free_laundry:
 	nfsd4_destroy_laundry_wq();
 out_free_cld:
 	unregister_cld_notifier();
@@ -2307,6 +2312,7 @@ static void __exit exit_nfsd(void)
 	remove_proc_entry("fs/nfs", NULL);
 	genl_unregister_family(&nfsd_nl_family);
 	unregister_filesystem(&nfsd_fs_type);
+	nfsd_sb_watch_exit();
 	nfsd4_destroy_laundry_wq();
 	unregister_cld_notifier();
 	unregister_pernet_subsys(&nfsd_net_ops);
diff --git a/fs/nfsd/sb_watch.c b/fs/nfsd/sb_watch.c
new file mode 100644
index 000000000000..8f711956a12e
--- /dev/null
+++ b/fs/nfsd/sb_watch.c
@@ -0,0 +1,273 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Superblock watch for automatic NFSv4 state revocation on unmount.
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
+#include <linux/mount.h>
+#include <linux/slab.h>
+#include <linux/sunrpc/svc.h>
+#include <linux/lockd/lockd.h>
+
+#include "nfsd.h"
+#include "netns.h"
+#include "state.h"
+#include "filecache.h"
+
+#define NFSDDBG_FACILITY	NFSDDBG_PROC
+
+static struct workqueue_struct *nfsd_sb_watch_wq;
+
+/* Interval for progress warnings during unmount (in seconds) */
+#define NFSD_STATE_REVOKE_INTERVAL	30
+
+/*
+ * Watch record for a superblock with NFS state. When the filesystem
+ * is unmounted, the notifier callback finds this record and triggers
+ * state revocation.
+ */
+struct nfsd_sb_watch {
+	struct super_block	*sb;
+	struct net		*net;
+	struct work_struct	work;
+	struct completion	done;
+	struct rcu_head		rcu;
+};
+
+static void nfsd_sb_watch_free_rcu(struct rcu_head *rcu)
+{
+	struct nfsd_sb_watch *watch = container_of(rcu, struct nfsd_sb_watch, rcu);
+
+	put_net(watch->net);
+	kfree(watch);
+}
+
+/*
+ * Work function for nfsd_sb_watch - runs in process context.
+ * Cancels async COPYs, releases NLM locks, revokes NFSv4 state, and closes
+ * cached NFSv2/3 files for the superblock.
+ */
+static void nfsd_sb_revoke_work(struct work_struct *work)
+{
+	struct nfsd_sb_watch *watch = container_of(work, struct nfsd_sb_watch, work);
+	struct nfsd_net *nn = net_generic(watch->net, nfsd_net_id);
+
+	pr_info("nfsd: unmount of %s, revoking NFS state\n", watch->sb->s_id);
+
+	nfsd4_cancel_copy_by_sb(watch->net, watch->sb);
+	/* Errors are logged by lockd; no recovery is possible. */
+	(void)nlmsvc_unlock_all_by_sb(watch->sb);
+	nfsd4_revoke_states(nn, watch->sb);
+
+	pr_info("nfsd: state revocation for %s complete\n", watch->sb->s_id);
+
+	complete(&watch->done);
+	call_rcu(&watch->rcu, nfsd_sb_watch_free_rcu);
+}
+
+/*
+ * Trigger state revocation for a superblock and wait for completion.
+ *
+ * The xa_erase() ensures exactly one path (either this notification or
+ * NFSD shutdown) handles cleanup for a given watch record.
+ */
+static void nfsd_sb_trigger_revoke(struct nfsd_net *nn, struct super_block *sb)
+{
+	struct nfsd_sb_watch *watch;
+	unsigned int elapsed = 0;
+	long ret;
+
+	watch = xa_erase(&nn->nfsd_sb_watches, (unsigned long)sb);
+	if (!watch)
+		return;
+
+	queue_work(nfsd_sb_watch_wq, &watch->work);
+
+	/*
+	 * Block until state revocation completes. Periodic warnings help
+	 * diagnose stuck operations (e.g., re-exports of an NFS mount
+	 * whose backend server is unresponsive).
+	 *
+	 * The work function handles freeing, so this function can return
+	 * early on interrupt. Open files keep the superblock alive until
+	 * revocation closes them.
+	 */
+	for (;;) {
+		ret = wait_for_completion_interruptible_timeout(&watch->done,
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
+			 * If already running, cancel_work() waits for
+			 * completion before returning false.
+			 */
+			if (cancel_work(&watch->work)) {
+				pr_warn("nfsd: unmount of %s interrupted, revoking state in unmount context\n",
+					sb->s_id);
+				nfsd_sb_revoke_work(&watch->work);
+				return;
+			}
+			pr_warn("nfsd: unmount of %s interrupted; revocation continues in background\n",
+				sb->s_id);
+			return;
+		}
+
+		/* Timed out - print warning and continue waiting */
+		elapsed += NFSD_STATE_REVOKE_INTERVAL;
+		pr_warn("nfsd: unmount of %s blocked for %u seconds waiting for NFS state revocation\n",
+			sb->s_id, elapsed);
+	}
+}
+
+/*
+ * Notifier callback invoked when any filesystem is unmounted.
+ * Check if this superblock is being watched and trigger revocation.
+ */
+static int nfsd_umount_notifier_call(struct notifier_block *nb,
+				     unsigned long action, void *data)
+{
+	struct nfsd_net *nn = container_of(nb, struct nfsd_net, nfsd_umount_notifier);
+	struct super_block *sb = data;
+
+	nfsd_sb_trigger_revoke(nn, sb);
+	return NOTIFY_DONE;
+}
+
+/**
+ * nfsd_sb_watch - watch a superblock for unmount to trigger state revocation
+ * @net: network namespace
+ * @mnt: vfsmount for the filesystem
+ *
+ * When NFS state is created for a file on this filesystem, register a
+ * watch so the umount notifier can revoke that state on unmount.
+ * Returns nfs_ok on success, or an NFS error on failure.
+ *
+ * This function is idempotent - if a watch already exists for the
+ * superblock, no new watch is created.
+ */
+__be32 nfsd_sb_watch(struct net *net, struct vfsmount *mnt)
+{
+	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
+	struct super_block *sb = mnt->mnt_sb;
+	struct nfsd_sb_watch *new;
+	int ret;
+
+	if (xa_load(&nn->nfsd_sb_watches, (unsigned long)sb))
+		return nfs_ok;
+
+	new = kzalloc(sizeof(*new), GFP_KERNEL);
+	if (!new)
+		return nfserr_jukebox;
+
+	new->sb = sb;
+	new->net = get_net(net);
+	INIT_WORK(&new->work, nfsd_sb_revoke_work);
+	init_completion(&new->done);
+
+	ret = xa_insert(&nn->nfsd_sb_watches, (unsigned long)sb, new, GFP_KERNEL);
+	if (ret) {
+		/*
+		 * Another task beat us to it. Even if the winner has not
+		 * yet completed insertion, returning here is safe: the
+		 * caller holds an open file reference that prevents
+		 * unmount from completing until state creation finishes.
+		 */
+		put_net(new->net);
+		kfree(new);
+		return nfs_ok;
+	}
+
+	/*
+	 * Callers hold an open file reference, so unmount cannot clear
+	 * SB_ACTIVE while this function executes. Warn if this assumption
+	 * is violated, but handle it gracefully by cleaning up and
+	 * returning an error.
+	 */
+	if (WARN_ON_ONCE(!(READ_ONCE(sb->s_flags) & SB_ACTIVE))) {
+		new = xa_erase(&nn->nfsd_sb_watches, (unsigned long)sb);
+		if (new) {
+			put_net(new->net);
+			kfree(new);
+		}
+		return nfserr_stale;
+	}
+
+	return nfs_ok;
+}
+
+/**
+ * nfsd_sb_watch_setup - initialize umount watch for a network namespace
+ * @nn: nfsd_net for this network namespace
+ *
+ * Called during nfs4_state_create_net(). Registers with the VFS umount
+ * notifier chain to receive callbacks when filesystems are unmounted.
+ */
+int nfsd_sb_watch_setup(struct nfsd_net *nn)
+{
+	xa_init(&nn->nfsd_sb_watches);
+	nn->nfsd_umount_notifier.notifier_call = nfsd_umount_notifier_call;
+	return umount_register_notifier(&nn->nfsd_umount_notifier);
+}
+
+/*
+ * Clean up all watch records during NFSD shutdown.
+ *
+ * xa_erase() synchronizes with nfsd_sb_trigger_revoke(): the path that
+ * successfully erases an xarray entry performs cleanup for that entry.
+ * A NULL return indicates the umount notification path is handling cleanup.
+ */
+static void nfsd_sb_watches_destroy(struct nfsd_net *nn)
+{
+	struct nfsd_sb_watch *watch;
+	unsigned long index;
+
+	xa_for_each(&nn->nfsd_sb_watches, index, watch) {
+		watch = xa_erase(&nn->nfsd_sb_watches, index);
+		if (!watch)
+			continue; /* Umount notification path handling this */
+		cancel_work_sync(&watch->work);
+		put_net(watch->net);
+		kfree(watch);
+	}
+	xa_destroy(&nn->nfsd_sb_watches);
+}
+
+/**
+ * nfsd_sb_watch_shutdown - shutdown umount watch for a network namespace
+ * @nn: nfsd_net for this network namespace
+ *
+ * Must be called during nfsd shutdown before tearing down client state.
+ */
+void nfsd_sb_watch_shutdown(struct nfsd_net *nn)
+{
+	umount_unregister_notifier(&nn->nfsd_umount_notifier);
+	nfsd_sb_watches_destroy(nn);
+}
+
+int nfsd_sb_watch_init(void)
+{
+	nfsd_sb_watch_wq = alloc_workqueue("nfsd_sb_watch", WQ_UNBOUND, 0);
+	if (!nfsd_sb_watch_wq)
+		return -ENOMEM;
+	return 0;
+}
+
+void nfsd_sb_watch_exit(void)
+{
+	destroy_workqueue(nfsd_sb_watch_wq);
+}
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index 6fcbf1e427d4..4b57d04f868a 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -853,6 +853,13 @@ static inline void nfsd4_cancel_copy_by_sb(struct net *net, struct super_block *
 }
 #endif
 
+/* superblock watch for unmount notification (sb_watch.c) */
+int nfsd_sb_watch_init(void);
+void nfsd_sb_watch_exit(void);
+__be32 nfsd_sb_watch(struct net *net, struct vfsmount *mnt);
+int nfsd_sb_watch_setup(struct nfsd_net *nn);
+void nfsd_sb_watch_shutdown(struct nfsd_net *nn);
+
 /* grace period management */
 bool nfsd4_force_end_grace(struct nfsd_net *nn);
 
-- 
2.53.0


