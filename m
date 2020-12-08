Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 764A92D1EFB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Dec 2020 01:32:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728458AbgLHAcS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Dec 2020 19:32:18 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:56582 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725853AbgLHAcS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Dec 2020 19:32:18 -0500
Received: from localhost (unknown [IPv6:2804:14c:132:242d::1001])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: krisman)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 7C9221F44D08;
        Tue,  8 Dec 2020 00:31:36 +0000 (GMT)
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     dhowells@redhat.com
Cc:     viro@zeniv.linux.org.uk, tytso@mit.edu, khazhy@google.com,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, kernel@collabora.com,
        Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: [PATCH 2/8] security: Add hooks to rule on setting a watch for superblock
Date:   Mon,  7 Dec 2020 21:31:11 -0300
Message-Id: <20201208003117.342047-3-krisman@collabora.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201208003117.342047-1-krisman@collabora.com>
References: <20201208003117.342047-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: David Howells <dhowells@redhat.com>

Add security hooks that will allow an LSM to rule on whether or not a watch
may be set for a supperblock.

Signed-off-by: David Howells <dhowells@redhat.com>
[Drop mount and key changes.  Rebase to mainline]
Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
---
 include/linux/lsm_hook_defs.h |  1 +
 include/linux/lsm_hooks.h     |  4 ++++
 include/linux/security.h      | 13 +++++++++++++
 security/security.c           |  6 ++++++
 4 files changed, 24 insertions(+)

diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index 32a940117e7a..8fa8533598bc 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -261,6 +261,7 @@ LSM_HOOK(int, 0, inode_getsecctx, struct inode *inode, void **ctx,
 #if defined(CONFIG_SECURITY) && defined(CONFIG_WATCH_QUEUE)
 LSM_HOOK(int, 0, post_notification, const struct cred *w_cred,
 	 const struct cred *cred, struct watch_notification *n)
+LSM_HOOK(int, 0, watch_sb, struct super_block *sb)
 #endif /* CONFIG_SECURITY && CONFIG_WATCH_QUEUE */
 
 #if defined(CONFIG_SECURITY) && defined(CONFIG_KEY_NOTIFICATIONS)
diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index c503f7ab8afb..11197bf167d3 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -1475,6 +1475,10 @@
  *	@w_cred: The credentials of the whoever set the watch.
  *	@cred: The event-triggerer's credentials
  *	@n: The notification being posted
+ * @watch_sb:
+ *	Check to see if a process is allowed to watch for event notifications
+ *	from a superblock.
+ *	@sb: The superblock to watch.
  *
  * @watch_key:
  *	Check to see if a process is allowed to watch for event notifications
diff --git a/include/linux/security.h b/include/linux/security.h
index bc2725491560..078e11a8872a 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -456,6 +456,11 @@ int security_inode_notifysecctx(struct inode *inode, void *ctx, u32 ctxlen);
 int security_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctxlen);
 int security_inode_getsecctx(struct inode *inode, void **ctx, u32 *ctxlen);
 int security_locked_down(enum lockdown_reason what);
+
+#ifdef CONFIG_WATCH_QUEUE
+int security_watch_sb(struct super_block *sb);
+#endif /* CONFIG_WATCH_QUEUE */
+
 #else /* CONFIG_SECURITY */
 
 static inline int call_blocking_lsm_notifier(enum lsm_event event, void *data)
@@ -1304,6 +1309,14 @@ static inline int security_locked_down(enum lockdown_reason what)
 {
 	return 0;
 }
+
+#ifdef CONFIG_WATCH_QUEUE
+static inline int security_watch_sb(struct super_block *sb)
+{
+	return 0;
+}
+#endif /* CONFIG_WATCH_QUEUE */
+
 #endif	/* CONFIG_SECURITY */
 
 #if defined(CONFIG_SECURITY) && defined(CONFIG_WATCH_QUEUE)
diff --git a/security/security.c b/security/security.c
index a28045dc9e7f..a23a972063cd 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2074,6 +2074,12 @@ int security_post_notification(const struct cred *w_cred,
 {
 	return call_int_hook(post_notification, 0, w_cred, cred, n);
 }
+
+int security_watch_sb(struct super_block *sb)
+{
+	return call_int_hook(watch_sb, 0, sb);
+}
+
 #endif /* CONFIG_WATCH_QUEUE */
 
 #ifdef CONFIG_KEY_NOTIFICATIONS
-- 
2.29.2

