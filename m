Return-Path: <linux-fsdevel+bounces-78286-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OGgSEXLXnWk0SQQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78286-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 17:53:06 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C475118A19D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 17:53:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9BD4F31E8BF5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 16:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0133A3AE6FC;
	Tue, 24 Feb 2026 16:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xcq4QDlm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E013AE6F2;
	Tue, 24 Feb 2026 16:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771951152; cv=none; b=lXhmhr+dZBEzWX7BTf5sqOkV1ueWbGfxnkIaoX1SmUq2fbzEm0eVnk3ouxHdxlklzFS71BdaK2OiyZa+ybYj7WqQGCyXh5lqKye3AdQ7jBGJUVRWpJ2kQ36KenC3+zzWleSnwR7+DfTsKNJEMureKlf64GvK2Kf6C63veU4a/fU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771951152; c=relaxed/simple;
	bh=nuKjhQEKlpKE4EJIsaJmNI/R367kzvcju2p35GLCk1M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dDTk8H5k0yMfintmSY/6QMefCczAsWZbqxqwbowZT3rwZ/9nsxmfoTGFzJo7l5OgZletvDIrJgNbMWei0UGlPw/4udE4tEKxC7D7y0Ym/FqeBxN3zWOCH3kpxBbBnjruAnzaR72+Z4VSJlEC5lvz+PuwSQMc4QUwDG04JDCKhMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xcq4QDlm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF750C19425;
	Tue, 24 Feb 2026 16:39:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771951152;
	bh=nuKjhQEKlpKE4EJIsaJmNI/R367kzvcju2p35GLCk1M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Xcq4QDlmc1vCIQXy6gk8APTM1UcRMbdzoNz5rlN+Je68RVnsdNSdCuUtwyEKmV3Vh
	 OgjbS3eOCMl1XbrIMlvkKc+gsd2xwjBLZtN8bmn+HvWI5bydiiLyI2HmzZV5i7VHNV
	 S4PCsocz2FnKZXCFoGHOfGb2CODX8UFqjlbmz1Bet1+o7EDc9jeOXb3EUbjKIpdTtO
	 5PxuQGAtuu6Li5sH9D/AHYDpXKFoBpPMwVuvwDT4evvFNVxGq+qZ91zOyBUc7LDglo
	 YKWSHbV0hnqVCsN/aivKV61sMY7f+vStRMZDOlrO0PrBXil7PM4F/S+3yeE7PCaTaC
	 OCWwRDQZoOaWg==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v3 1/3] fs: add umount notifier chain for filesystem unmount notification
Date: Tue, 24 Feb 2026 11:39:06 -0500
Message-ID: <20260224163908.44060-2-cel@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-78286-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[ownmail.net,kernel.org,redhat.com,oracle.com,talpey.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.com:email]
X-Rspamd-Queue-Id: C475118A19D
X-Rspamd-Action: no action

From: Chuck Lever <chuck.lever@oracle.com>

Kernel subsystems occasionally need notification when a filesystem
is unmounted. Until now, the only mechanism available is the fs_pin
infrastructure, which has limited adoption (only BSD process
accounting uses it) and VFS maintainers consider it deprecated.

Add an SRCU notifier chain that fires during mount teardown,
following the pattern established by lease_notifier_chain in
fs/locks.c. The notifier fires after processing stuck children but
before fsnotify_vfsmount_delete(), at which point SB_ACTIVE is
still set and the superblock remains fully accessible.

The SRCU notifier type is chosen because:
 - Unmount is relatively infrequent, so the overhead of SRCU
   registration and unregistration is acceptable
 - Callbacks run in process context and may sleep
 - No cache bounces occur during chain traversal

NFSD requires this mechanism to revoke NFSv4 state (opens, locks,
delegations) and release cached file handles when a filesystem is
unmounted, avoiding EBUSY errors that occur when client state pins
the mount.

Suggested-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/namespace.c        | 69 +++++++++++++++++++++++++++++++++++++++++++
 include/linux/mount.h |  4 +++
 2 files changed, 73 insertions(+)

diff --git a/fs/namespace.c b/fs/namespace.c
index ebe19ded293a..269e007e9312 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -34,6 +34,7 @@
 #include <linux/mnt_idmapping.h>
 #include <linux/pidfs.h>
 #include <linux/nstree.h>
+#include <linux/notifier.h>
 
 #include "pnode.h"
 #include "internal.h"
@@ -73,6 +74,70 @@ static u64 event;
 static DEFINE_XARRAY_FLAGS(mnt_id_xa, XA_FLAGS_ALLOC);
 static DEFINE_IDA(mnt_group_ida);
 
+/*
+ * Kernel subsystems can register to be notified when a filesystem is
+ * unmounted. This is used by (e.g.) nfsd to revoke state associated
+ * with files on the filesystem being unmounted.
+ */
+static struct srcu_notifier_head umount_notifier_chain;
+
+/**
+ * umount_register_notifier - register for unmount notifications
+ * @nb: notifier_block to register
+ *
+ * Registers a notifier to be called when any filesystem is
+ * unmounted. The callback is invoked after stuck children are
+ * processed but before fsnotify_vfsmount_delete(), while SB_ACTIVE
+ * is still set and the superblock remains fully accessible.
+ *
+ * Callback signature:
+ *   int (*callback)(struct notifier_block *nb,
+ *                   unsigned long val, void *data)
+ *
+ *   @val:  always 0 (reserved for future extension)
+ *   @data: struct super_block * for the unmounting filesystem
+ *
+ * Callbacks run in process context and may sleep. Return
+ * NOTIFY_DONE from the callback; return values are ignored and
+ * cannot prevent unmount. Callbacks must handle their own error
+ * recovery internally.
+ *
+ * The notification fires once per mount instance. Bind mounts of
+ * the same filesystem trigger multiple callbacks with the same
+ * super_block pointer; callbacks must handle duplicate
+ * notifications idempotently.
+ *
+ * The super_block pointer is valid only for the duration of the
+ * callback. Callbacks must not retain this pointer for
+ * asynchronous use; to access the filesystem after the callback
+ * returns, acquire a separate reference (e.g., via an open file)
+ * during callback execution.
+ *
+ * Returns: 0 on success, negative error code on failure.
+ */
+int umount_register_notifier(struct notifier_block *nb)
+{
+	return srcu_notifier_chain_register(&umount_notifier_chain, nb);
+}
+EXPORT_SYMBOL_GPL(umount_register_notifier);
+
+/**
+ * umount_unregister_notifier - unregister an unmount notifier
+ * @nb: notifier_block to unregister
+ *
+ * Unregisters a previously registered notifier. This function may
+ * block due to SRCU synchronization.
+ *
+ * Must not be called from within a notifier callback; doing so
+ * causes deadlock. Must be called before module unload if the
+ * notifier_block resides in module memory.
+ */
+void umount_unregister_notifier(struct notifier_block *nb)
+{
+	srcu_notifier_chain_unregister(&umount_notifier_chain, nb);
+}
+EXPORT_SYMBOL_GPL(umount_unregister_notifier);
+
 /* Don't allow confusion with old 32bit mount ID */
 #define MNT_UNIQUE_ID_OFFSET (1ULL << 31)
 static u64 mnt_id_ctr = MNT_UNIQUE_ID_OFFSET;
@@ -1307,6 +1372,8 @@ static void cleanup_mnt(struct mount *mnt)
 		hlist_del(&m->mnt_umount);
 		mntput(&m->mnt);
 	}
+	/* Notify registrants before superblock deactivation */
+	srcu_notifier_call_chain(&umount_notifier_chain, 0, mnt->mnt.mnt_sb);
 	fsnotify_vfsmount_delete(&mnt->mnt);
 	dput(mnt->mnt.mnt_root);
 	deactivate_super(mnt->mnt.mnt_sb);
@@ -6189,6 +6256,8 @@ void __init mnt_init(void)
 {
 	int err;
 
+	srcu_init_notifier_head(&umount_notifier_chain);
+
 	mnt_cache = kmem_cache_create("mnt_cache", sizeof(struct mount),
 			0, SLAB_HWCACHE_ALIGN|SLAB_PANIC|SLAB_ACCOUNT, NULL);
 
diff --git a/include/linux/mount.h b/include/linux/mount.h
index acfe7ef86a1b..9a46ab40dffd 100644
--- a/include/linux/mount.h
+++ b/include/linux/mount.h
@@ -21,6 +21,7 @@ struct file_system_type;
 struct fs_context;
 struct file;
 struct path;
+struct notifier_block;
 
 enum mount_flags {
 	MNT_NOSUID	= 0x01,
@@ -109,4 +110,7 @@ extern void kern_unmount_array(struct vfsmount *mnt[], unsigned int num);
 
 extern int cifs_root_data(char **dev, char **opts);
 
+int umount_register_notifier(struct notifier_block *nb);
+void umount_unregister_notifier(struct notifier_block *nb);
+
 #endif /* _LINUX_MOUNT_H */
-- 
2.53.0


