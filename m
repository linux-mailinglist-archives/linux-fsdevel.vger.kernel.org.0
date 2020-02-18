Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D5C2162879
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2020 15:36:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727862AbgBROgf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Feb 2020 09:36:35 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:53123 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726700AbgBROgf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Feb 2020 09:36:35 -0500
Received: from ip5f5bf7ec.dynamic.kabel-deutschland.de ([95.91.247.236] helo=wittgenstein.fritz.box)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1j43yC-0000fF-K3; Tue, 18 Feb 2020 14:35:28 +0000
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     =?UTF-8?q?St=C3=A9phane=20Graber?= <stgraber@ubuntu.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Aleksa Sarai <cyphar@cyphar.com>, Jann Horn <jannh@google.com>
Cc:     smbarber@chromium.org, Seth Forshee <seth.forshee@canonical.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Serge Hallyn <serge@hallyn.com>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Phil Estes <estesp@gmail.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        containers@lists.linux-foundation.org,
        linux-security-module@vger.kernel.org, linux-api@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH v3 23/25] keys: handle fsid mappings
Date:   Tue, 18 Feb 2020 15:34:09 +0100
Message-Id: <20200218143411.2389182-24-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200218143411.2389182-1-christian.brauner@ubuntu.com>
References: <20200218143411.2389182-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Similar to proc and sysfs let keys use kfsids which are always mapped according
to id mappings.

Suggested-by: Jann Horn <jannh@google.com>
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
/* v2 */
patch not present

/* v3 */
patch added
- Jann Horn <jannh@google.com>:
  - Add patch to handle the keyrings.
---
 security/keys/key.c              |  2 +-
 security/keys/permission.c       |  4 ++--
 security/keys/process_keys.c     |  6 ++++--
 security/keys/request_key.c      | 10 +++++-----
 security/keys/request_key_auth.c |  2 +-
 5 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/security/keys/key.c b/security/keys/key.c
index 718bf7217420..bfb17e8210d7 100644
--- a/security/keys/key.c
+++ b/security/keys/key.c
@@ -923,7 +923,7 @@ key_ref_t key_create_or_update(key_ref_t keyring_ref,
 
 	/* allocate a new key */
 	key = key_alloc(index_key.type, index_key.description,
-			cred->fsuid, cred->fsgid, cred, perm, flags, NULL);
+			cred->kfsuid, cred->kfsgid, cred, perm, flags, NULL);
 	if (IS_ERR(key)) {
 		key_ref = ERR_CAST(key);
 		goto error_link_end;
diff --git a/security/keys/permission.c b/security/keys/permission.c
index 085f907b64ac..847187ca6b41 100644
--- a/security/keys/permission.c
+++ b/security/keys/permission.c
@@ -33,7 +33,7 @@ int key_task_permission(const key_ref_t key_ref, const struct cred *cred,
 	key = key_ref_to_ptr(key_ref);
 
 	/* use the second 8-bits of permissions for keys the caller owns */
-	if (uid_eq(key->uid, cred->fsuid)) {
+	if (uid_eq(key->uid, cred->kfsuid)) {
 		kperm = key->perm >> 16;
 		goto use_these_perms;
 	}
@@ -41,7 +41,7 @@ int key_task_permission(const key_ref_t key_ref, const struct cred *cred,
 	/* use the third 8-bits of permissions for keys the caller has a group
 	 * membership in common with */
 	if (gid_valid(key->gid) && key->perm & KEY_GRP_ALL) {
-		if (gid_eq(key->gid, cred->fsgid)) {
+		if (gid_eq(key->gid, cred->kfsgid)) {
 			kperm = key->perm >> 8;
 			goto use_these_perms;
 		}
diff --git a/security/keys/process_keys.c b/security/keys/process_keys.c
index 09541de31f2f..32376f0fbb42 100644
--- a/security/keys/process_keys.c
+++ b/security/keys/process_keys.c
@@ -379,7 +379,7 @@ void key_fsuid_changed(struct cred *new_cred)
 	/* update the ownership of the thread keyring */
 	if (new_cred->thread_keyring) {
 		down_write(&new_cred->thread_keyring->sem);
-		new_cred->thread_keyring->uid = new_cred->fsuid;
+		new_cred->thread_keyring->uid = new_cred->kfsuid;
 		up_write(&new_cred->thread_keyring->sem);
 	}
 }
@@ -392,7 +392,7 @@ void key_fsgid_changed(struct cred *new_cred)
 	/* update the ownership of the thread keyring */
 	if (new_cred->thread_keyring) {
 		down_write(&new_cred->thread_keyring->sem);
-		new_cred->thread_keyring->gid = new_cred->fsgid;
+		new_cred->thread_keyring->gid = new_cred->kfsgid;
 		up_write(&new_cred->thread_keyring->sem);
 	}
 }
@@ -923,10 +923,12 @@ void key_change_session_keyring(struct callback_head *twork)
 	new-> euid	= old-> euid;
 	new-> suid	= old-> suid;
 	new->fsuid	= old->fsuid;
+	new->kfsuid	= old->kfsuid;
 	new->  gid	= old->  gid;
 	new-> egid	= old-> egid;
 	new-> sgid	= old-> sgid;
 	new->fsgid	= old->fsgid;
+	new->kfsgid	= old->kfsgid;
 	new->user	= get_uid(old->user);
 	new->user_ns	= get_user_ns(old->user_ns);
 	new->group_info	= get_group_info(old->group_info);
diff --git a/security/keys/request_key.c b/security/keys/request_key.c
index 957b9e3e1492..254a7c2f3fde 100644
--- a/security/keys/request_key.c
+++ b/security/keys/request_key.c
@@ -134,7 +134,7 @@ static int call_sbin_request_key(struct key *authkey, void *aux)
 	sprintf(desc, "_req.%u", key->serial);
 
 	cred = get_current_cred();
-	keyring = keyring_alloc(desc, cred->fsuid, cred->fsgid, cred,
+	keyring = keyring_alloc(desc, cred->kfsuid, cred->kfsgid, cred,
 				KEY_POS_ALL | KEY_USR_VIEW | KEY_USR_READ,
 				KEY_ALLOC_QUOTA_OVERRUN, NULL, NULL);
 	put_cred(cred);
@@ -149,8 +149,8 @@ static int call_sbin_request_key(struct key *authkey, void *aux)
 		goto error_link;
 
 	/* record the UID and GID */
-	sprintf(uid_str, "%d", from_kuid(&init_user_ns, cred->fsuid));
-	sprintf(gid_str, "%d", from_kgid(&init_user_ns, cred->fsgid));
+	sprintf(uid_str, "%d", from_kuid(&init_user_ns, cred->kfsuid));
+	sprintf(gid_str, "%d", from_kgid(&init_user_ns, cred->kfsgid));
 
 	/* we say which key is under construction */
 	sprintf(key_str, "%d", key->serial);
@@ -390,7 +390,7 @@ static int construct_alloc_key(struct keyring_search_context *ctx,
 		perm |= KEY_POS_WRITE;
 
 	key = key_alloc(ctx->index_key.type, ctx->index_key.description,
-			ctx->cred->fsuid, ctx->cred->fsgid, ctx->cred,
+			ctx->cred->kfsuid, ctx->cred->kfsgid, ctx->cred,
 			perm, flags, NULL);
 	if (IS_ERR(key))
 		goto alloc_failed;
@@ -490,7 +490,7 @@ static struct key *construct_key_and_link(struct keyring_search_context *ctx,
 	if (ret)
 		goto error;
 
-	user = key_user_lookup(current_fsuid());
+	user = key_user_lookup(current_kfsuid());
 	if (!user) {
 		ret = -ENOMEM;
 		goto error_put_dest_keyring;
diff --git a/security/keys/request_key_auth.c b/security/keys/request_key_auth.c
index ecba39c93fd9..26808146897c 100644
--- a/security/keys/request_key_auth.c
+++ b/security/keys/request_key_auth.c
@@ -215,7 +215,7 @@ struct key *request_key_auth_new(struct key *target, const char *op,
 	sprintf(desc, "%x", target->serial);
 
 	authkey = key_alloc(&key_type_request_key_auth, desc,
-			    cred->fsuid, cred->fsgid, cred,
+			    cred->kfsuid, cred->kfsgid, cred,
 			    KEY_POS_VIEW | KEY_POS_READ | KEY_POS_SEARCH | KEY_POS_LINK |
 			    KEY_USR_VIEW, KEY_ALLOC_NOT_IN_QUOTA, NULL);
 	if (IS_ERR(authkey)) {
-- 
2.25.0

