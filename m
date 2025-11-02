Return-Path: <linux-fsdevel+bounces-66700-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CFEF4C299A0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 03 Nov 2025 00:13:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5749D4E763F
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 Nov 2025 23:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6983723E229;
	Sun,  2 Nov 2025 23:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PuJHWf5Q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD47FBF0;
	Sun,  2 Nov 2025 23:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762125180; cv=none; b=Gk1+7b4AHK1PugpGYGXu+zV1Alr32xpeLJOAzOxsoe8+Pg04dKzH1lqPraV2X3Zl4UHSXW//mAEZuaMKA17hyoNYXOns7a/oGI96w9FAbikK8MvJkm55wS4nWkOuoy/LhxAy2WmpH1Hxw2W/AjdX1wP8yegNTSNdNrt0Lzii84o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762125180; c=relaxed/simple;
	bh=cGkMTHsB8KDBO29SWa3Ddou/5I92syohHmicpkOp1gE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SpsD6lcwVMszaOyzYPJm/s8VdSadzmw7pXRFgLWQJLkjEyZwb93LuRrvMPiE1u59NEw8uwCQK/0q48BjZ36tGdJWzB12MoWZFmbW3bLtm0FYd7lS1DSLAIi17b+4Hp4bbRc6W094mnYl0IiXAcgDiGj3WPNAuiU4i7izsdvmN6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PuJHWf5Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C7EBC116B1;
	Sun,  2 Nov 2025 23:12:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762125180;
	bh=cGkMTHsB8KDBO29SWa3Ddou/5I92syohHmicpkOp1gE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=PuJHWf5QOtj85JakloNql/uu5nOrYio9MgaFm2RCmepFQZxASJcw8/T4AW/T+bs0B
	 JEvejPqAQa9sY8ExaF88Q52rUv6bS51JJGGv/O25muO2ypznfc58D2aZKLj0JBj/90
	 aDQxan1RNA5MQoXiQh/PWOLpmkC4uqhL5YtgslzQTCWCVbt7UIV4Q/MqV+21K9SD3/
	 8VsLvWpaD4K1LLWSbwQYWq4e375358lcT5db9bzVyhFqED24ah/Jugj2xkWpn/VN5/
	 BvvLuQc8kC3WM7r3pgKSo9WfA6eZguSWcqnhWgDxPZ3z8SMI0M5y0Q85q5YIaUq37D
	 ruNxkGRchQeYw==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 03 Nov 2025 00:12:42 +0100
Subject: [PATCH 3/8] cred: make init_cred static
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251103-work-creds-init_cred-v1-3-cb3ec8711a6a@kernel.org>
References: <20251103-work-creds-init_cred-v1-0-cb3ec8711a6a@kernel.org>
In-Reply-To: <20251103-work-creds-init_cred-v1-0-cb3ec8711a6a@kernel.org>
To: Jens Axboe <axboe@kernel.dk>, 
 Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-96507
X-Developer-Signature: v=1; a=openpgp-sha256; l=3779; i=brauner@kernel.org;
 h=from:subject:message-id; bh=cGkMTHsB8KDBO29SWa3Ddou/5I92syohHmicpkOp1gE=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSyPy0VT12w1k/MTaE2JrPtsxn/TY6Nphm/PpwqWcP7Z
 LvF7dmTOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACbCs5OR4eO+dQtaJF5avb+9
 Q6dAKnops8KxNQ2MIh02p+6G5TpONmD4Hx55TCb/+DT+PZbPhQ9oXJvPqvTM62p0t2zqyaDlS6b
 2cQIA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

There's zero need to expose struct init_cred. The very few places that
need access can just go through init_task which is already exported.

Link: https://patch.msgid.link/20251031-work-creds-init_cred-v1-2-cbf0400d6e0e@kernel.org
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 include/linux/init_task.h    |  1 -
 init/init_task.c             | 27 +++++++++++++++++++++++++++
 kernel/cred.c                | 27 ---------------------------
 security/keys/process_keys.c |  2 +-
 4 files changed, 28 insertions(+), 29 deletions(-)

diff --git a/include/linux/init_task.h b/include/linux/init_task.h
index bccb3f1f6262..a6cb241ea00c 100644
--- a/include/linux/init_task.h
+++ b/include/linux/init_task.h
@@ -25,7 +25,6 @@
 extern struct files_struct init_files;
 extern struct fs_struct init_fs;
 extern struct nsproxy init_nsproxy;
-extern struct cred init_cred;
 
 #ifndef CONFIG_VIRT_CPU_ACCOUNTING_NATIVE
 #define INIT_PREV_CPUTIME(x)	.prev_cputime = {			\
diff --git a/init/init_task.c b/init/init_task.c
index a55e2189206f..d970a847b657 100644
--- a/init/init_task.c
+++ b/init/init_task.c
@@ -62,6 +62,33 @@ unsigned long init_shadow_call_stack[SCS_SIZE / sizeof(long)] = {
 };
 #endif
 
+/* init to 2 - one for init_task, one to ensure it is never freed */
+static struct group_info init_groups = { .usage = REFCOUNT_INIT(2) };
+
+/*
+ * The initial credentials for the initial task
+ */
+static struct cred init_cred = {
+	.usage			= ATOMIC_INIT(4),
+	.uid			= GLOBAL_ROOT_UID,
+	.gid			= GLOBAL_ROOT_GID,
+	.suid			= GLOBAL_ROOT_UID,
+	.sgid			= GLOBAL_ROOT_GID,
+	.euid			= GLOBAL_ROOT_UID,
+	.egid			= GLOBAL_ROOT_GID,
+	.fsuid			= GLOBAL_ROOT_UID,
+	.fsgid			= GLOBAL_ROOT_GID,
+	.securebits		= SECUREBITS_DEFAULT,
+	.cap_inheritable	= CAP_EMPTY_SET,
+	.cap_permitted		= CAP_FULL_SET,
+	.cap_effective		= CAP_FULL_SET,
+	.cap_bset		= CAP_FULL_SET,
+	.user			= INIT_USER,
+	.user_ns		= &init_user_ns,
+	.group_info		= &init_groups,
+	.ucounts		= &init_ucounts,
+};
+
 /*
  * Set up the first task table, touch at your own risk!. Base=0,
  * limit=0x1fffff (=2MB)
diff --git a/kernel/cred.c b/kernel/cred.c
index dbf6b687dc5c..ac87ed9d43b1 100644
--- a/kernel/cred.c
+++ b/kernel/cred.c
@@ -35,33 +35,6 @@ do {									\
 
 static struct kmem_cache *cred_jar;
 
-/* init to 2 - one for init_task, one to ensure it is never freed */
-static struct group_info init_groups = { .usage = REFCOUNT_INIT(2) };
-
-/*
- * The initial credentials for the initial task
- */
-struct cred init_cred = {
-	.usage			= ATOMIC_INIT(4),
-	.uid			= GLOBAL_ROOT_UID,
-	.gid			= GLOBAL_ROOT_GID,
-	.suid			= GLOBAL_ROOT_UID,
-	.sgid			= GLOBAL_ROOT_GID,
-	.euid			= GLOBAL_ROOT_UID,
-	.egid			= GLOBAL_ROOT_GID,
-	.fsuid			= GLOBAL_ROOT_UID,
-	.fsgid			= GLOBAL_ROOT_GID,
-	.securebits		= SECUREBITS_DEFAULT,
-	.cap_inheritable	= CAP_EMPTY_SET,
-	.cap_permitted		= CAP_FULL_SET,
-	.cap_effective		= CAP_FULL_SET,
-	.cap_bset		= CAP_FULL_SET,
-	.user			= INIT_USER,
-	.user_ns		= &init_user_ns,
-	.group_info		= &init_groups,
-	.ucounts		= &init_ucounts,
-};
-
 /*
  * The RCU callback to actually dispose of a set of credentials
  */
diff --git a/security/keys/process_keys.c b/security/keys/process_keys.c
index b5d5333ab330..a63c46bb2d14 100644
--- a/security/keys/process_keys.c
+++ b/security/keys/process_keys.c
@@ -51,7 +51,7 @@ static struct key *get_user_register(struct user_namespace *user_ns)
 	if (!reg_keyring) {
 		reg_keyring = keyring_alloc(".user_reg",
 					    user_ns->owner, INVALID_GID,
-					    &init_cred,
+					    kernel_cred(),
 					    KEY_POS_WRITE | KEY_POS_SEARCH |
 					    KEY_USR_VIEW | KEY_USR_READ,
 					    0,

-- 
2.47.3


