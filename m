Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B4F34BCF9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Jun 2019 17:36:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729951AbfFSPgV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Jun 2019 11:36:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54424 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726428AbfFSPgV (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Jun 2019 11:36:21 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B27B08830B;
        Wed, 19 Jun 2019 15:36:20 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-57.rdu2.redhat.com [10.10.120.57])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4CAA65C205;
        Wed, 19 Jun 2019 15:36:19 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 3/6] keys: Move the RCU locks outwards from the keyring
 search functions [ver #2]
From:   David Howells <dhowells@redhat.com>
To:     keyrings@vger.kernel.org
Cc:     dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 19 Jun 2019 16:36:18 +0100
Message-ID: <156095857859.25264.1843382792417643880.stgit@warthog.procyon.org.uk>
In-Reply-To: <156095855610.25264.16666970456822465537.stgit@warthog.procyon.org.uk>
References: <156095855610.25264.16666970456822465537.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Wed, 19 Jun 2019 15:36:20 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Move the RCU locks outwards from the keyring search functions so that it
will become possible to provide an RCU-capable partial request_key()
function in a later commit.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 Documentation/security/keys/request-key.rst |    2 -
 include/keys/request_key_auth-type.h        |    1 
 security/keys/internal.h                    |    6 +--
 security/keys/keyring.c                     |   16 ++++---
 security/keys/proc.c                        |    4 +-
 security/keys/process_keys.c                |   41 ++++++++----------
 security/keys/request_key.c                 |    8 +++-
 security/keys/request_key_auth.c            |   60 ++++++++++++++++-----------
 8 files changed, 77 insertions(+), 61 deletions(-)

diff --git a/Documentation/security/keys/request-key.rst b/Documentation/security/keys/request-key.rst
index 600ad67d1707..07af991463b5 100644
--- a/Documentation/security/keys/request-key.rst
+++ b/Documentation/security/keys/request-key.rst
@@ -148,7 +148,7 @@ The Search Algorithm
 
 A search of any particular keyring proceeds in the following fashion:
 
-  1) When the key management code searches for a key (keyring_search_aux) it
+  1) When the key management code searches for a key (keyring_search_rcu) it
      firstly calls key_permission(SEARCH) on the keyring it's starting with,
      if this denies permission, it doesn't search further.
 
diff --git a/include/keys/request_key_auth-type.h b/include/keys/request_key_auth-type.h
index a726dd3f1dc6..2a046062bb42 100644
--- a/include/keys/request_key_auth-type.h
+++ b/include/keys/request_key_auth-type.h
@@ -18,6 +18,7 @@
  * Authorisation record for request_key().
  */
 struct request_key_auth {
+	struct rcu_head		rcu;
 	struct key		*target_key;
 	struct key		*dest_keyring;
 	const struct cred	*cred;
diff --git a/security/keys/internal.h b/security/keys/internal.h
index d04bff631227..3d5c08db74d2 100644
--- a/security/keys/internal.h
+++ b/security/keys/internal.h
@@ -139,11 +139,11 @@ struct keyring_search_context {
 
 extern bool key_default_cmp(const struct key *key,
 			    const struct key_match_data *match_data);
-extern key_ref_t keyring_search_aux(key_ref_t keyring_ref,
+extern key_ref_t keyring_search_rcu(key_ref_t keyring_ref,
 				    struct keyring_search_context *ctx);
 
-extern key_ref_t search_my_process_keyrings(struct keyring_search_context *ctx);
-extern key_ref_t search_process_keyrings(struct keyring_search_context *ctx);
+extern key_ref_t search_cred_keyrings_rcu(struct keyring_search_context *ctx);
+extern key_ref_t search_process_keyrings_rcu(struct keyring_search_context *ctx);
 
 extern struct key *find_keyring_by_name(const char *name, bool uid_keyring);
 
diff --git a/security/keys/keyring.c b/security/keys/keyring.c
index 67066bb58b83..afa6d4024c67 100644
--- a/security/keys/keyring.c
+++ b/security/keys/keyring.c
@@ -835,7 +835,7 @@ static bool search_nested_keyrings(struct key *keyring,
 }
 
 /**
- * keyring_search_aux - Search a keyring tree for a key matching some criteria
+ * keyring_search_rcu - Search a keyring tree for a matching key under RCU
  * @keyring_ref: A pointer to the keyring with possession indicator.
  * @ctx: The keyring search context.
  *
@@ -847,7 +847,9 @@ static bool search_nested_keyrings(struct key *keyring,
  * addition, the LSM gets to forbid keyring searches and key matches.
  *
  * The search is performed as a breadth-then-depth search up to the prescribed
- * limit (KEYRING_SEARCH_MAX_DEPTH).
+ * limit (KEYRING_SEARCH_MAX_DEPTH).  The caller must hold the RCU read lock to
+ * prevent keyrings from being destroyed or rearranged whilst they are being
+ * searched.
  *
  * Keys are matched to the type provided and are then filtered by the match
  * function, which is given the description to use in any way it sees fit.  The
@@ -866,7 +868,7 @@ static bool search_nested_keyrings(struct key *keyring,
  * In the case of a successful return, the possession attribute from
  * @keyring_ref is propagated to the returned key reference.
  */
-key_ref_t keyring_search_aux(key_ref_t keyring_ref,
+key_ref_t keyring_search_rcu(key_ref_t keyring_ref,
 			     struct keyring_search_context *ctx)
 {
 	struct key *keyring;
@@ -888,11 +890,9 @@ key_ref_t keyring_search_aux(key_ref_t keyring_ref,
 			return ERR_PTR(err);
 	}
 
-	rcu_read_lock();
 	ctx->now = ktime_get_real_seconds();
 	if (search_nested_keyrings(keyring, ctx))
 		__key_get(key_ref_to_ptr(ctx->result));
-	rcu_read_unlock();
 	return ctx->result;
 }
 
@@ -902,7 +902,7 @@ key_ref_t keyring_search_aux(key_ref_t keyring_ref,
  * @type: The type of keyring we want to find.
  * @description: The name of the keyring we want to find.
  *
- * As keyring_search_aux() above, but using the current task's credentials and
+ * As keyring_search_rcu() above, but using the current task's credentials and
  * type's default matching function and preferred search method.
  */
 key_ref_t keyring_search(key_ref_t keyring,
@@ -928,7 +928,9 @@ key_ref_t keyring_search(key_ref_t keyring,
 			return ERR_PTR(ret);
 	}
 
-	key = keyring_search_aux(keyring, &ctx);
+	rcu_read_lock();
+	key = keyring_search_rcu(keyring, &ctx);
+	rcu_read_unlock();
 
 	if (type->match_free)
 		type->match_free(&ctx.match_data);
diff --git a/security/keys/proc.c b/security/keys/proc.c
index 78ac305d715e..f081dceae3b9 100644
--- a/security/keys/proc.c
+++ b/security/keys/proc.c
@@ -179,7 +179,9 @@ static int proc_keys_show(struct seq_file *m, void *v)
 	 * skip if the key does not indicate the possessor can view it
 	 */
 	if (key->perm & KEY_POS_VIEW) {
-		skey_ref = search_my_process_keyrings(&ctx);
+		rcu_read_lock();
+		skey_ref = search_cred_keyrings_rcu(&ctx);
+		rcu_read_unlock();
 		if (!IS_ERR(skey_ref)) {
 			key_ref_put(skey_ref);
 			key_ref = make_key_ref(key, 1);
diff --git a/security/keys/process_keys.c b/security/keys/process_keys.c
index 39aaa21462bf..f8ffb06d0297 100644
--- a/security/keys/process_keys.c
+++ b/security/keys/process_keys.c
@@ -318,7 +318,8 @@ void key_fsgid_changed(struct cred *new_cred)
 
 /*
  * Search the process keyrings attached to the supplied cred for the first
- * matching key.
+ * matching key under RCU conditions (the caller must be holding the RCU read
+ * lock).
  *
  * The search criteria are the type and the match function.  The description is
  * given to the match function as a parameter, but doesn't otherwise influence
@@ -337,7 +338,7 @@ void key_fsgid_changed(struct cred *new_cred)
  * In the case of a successful return, the possession attribute is set on the
  * returned key reference.
  */
-key_ref_t search_my_process_keyrings(struct keyring_search_context *ctx)
+key_ref_t search_cred_keyrings_rcu(struct keyring_search_context *ctx)
 {
 	key_ref_t key_ref, ret, err;
 	const struct cred *cred = ctx->cred;
@@ -355,7 +356,7 @@ key_ref_t search_my_process_keyrings(struct keyring_search_context *ctx)
 
 	/* search the thread keyring first */
 	if (cred->thread_keyring) {
-		key_ref = keyring_search_aux(
+		key_ref = keyring_search_rcu(
 			make_key_ref(cred->thread_keyring, 1), ctx);
 		if (!IS_ERR(key_ref))
 			goto found;
@@ -373,7 +374,7 @@ key_ref_t search_my_process_keyrings(struct keyring_search_context *ctx)
 
 	/* search the process keyring second */
 	if (cred->process_keyring) {
-		key_ref = keyring_search_aux(
+		key_ref = keyring_search_rcu(
 			make_key_ref(cred->process_keyring, 1), ctx);
 		if (!IS_ERR(key_ref))
 			goto found;
@@ -394,7 +395,7 @@ key_ref_t search_my_process_keyrings(struct keyring_search_context *ctx)
 
 	/* search the session keyring */
 	if (cred->session_keyring) {
-		key_ref = keyring_search_aux(
+		key_ref = keyring_search_rcu(
 			make_key_ref(cred->session_keyring, 1), ctx);
 
 		if (!IS_ERR(key_ref))
@@ -415,7 +416,7 @@ key_ref_t search_my_process_keyrings(struct keyring_search_context *ctx)
 	}
 	/* or search the user-session keyring */
 	else if (READ_ONCE(cred->user->session_keyring)) {
-		key_ref = keyring_search_aux(
+		key_ref = keyring_search_rcu(
 			make_key_ref(READ_ONCE(cred->user->session_keyring), 1),
 			ctx);
 		if (!IS_ERR(key_ref))
@@ -448,16 +449,16 @@ key_ref_t search_my_process_keyrings(struct keyring_search_context *ctx)
  * the keys attached to the assumed authorisation key using its credentials if
  * one is available.
  *
- * Return same as search_my_process_keyrings().
+ * The caller must be holding the RCU read lock.
+ *
+ * Return same as search_cred_keyrings_rcu().
  */
-key_ref_t search_process_keyrings(struct keyring_search_context *ctx)
+key_ref_t search_process_keyrings_rcu(struct keyring_search_context *ctx)
 {
 	struct request_key_auth *rka;
 	key_ref_t key_ref, ret = ERR_PTR(-EACCES), err;
 
-	might_sleep();
-
-	key_ref = search_my_process_keyrings(ctx);
+	key_ref = search_cred_keyrings_rcu(ctx);
 	if (!IS_ERR(key_ref))
 		goto found;
 	err = key_ref;
@@ -472,24 +473,17 @@ key_ref_t search_process_keyrings(struct keyring_search_context *ctx)
 	    ) {
 		const struct cred *cred = ctx->cred;
 
-		/* defend against the auth key being revoked */
-		down_read(&cred->request_key_auth->sem);
-
-		if (key_validate(ctx->cred->request_key_auth) == 0) {
+		if (key_validate(cred->request_key_auth) == 0) {
 			rka = ctx->cred->request_key_auth->payload.data[0];
 
+			//// was search_process_keyrings() [ie. recursive]
 			ctx->cred = rka->cred;
-			key_ref = search_process_keyrings(ctx);
+			key_ref = search_cred_keyrings_rcu(ctx);
 			ctx->cred = cred;
 
-			up_read(&cred->request_key_auth->sem);
-
 			if (!IS_ERR(key_ref))
 				goto found;
-
 			ret = key_ref;
-		} else {
-			up_read(&cred->request_key_auth->sem);
 		}
 	}
 
@@ -504,7 +498,6 @@ key_ref_t search_process_keyrings(struct keyring_search_context *ctx)
 found:
 	return key_ref;
 }
-
 /*
  * See if the key we're looking at is the target key.
  */
@@ -691,7 +684,9 @@ key_ref_t lookup_user_key(key_serial_t id, unsigned long lflags,
 		ctx.index_key			= key->index_key;
 		ctx.match_data.raw_data		= key;
 		kdebug("check possessed");
-		skey_ref = search_process_keyrings(&ctx);
+		rcu_read_lock();
+		skey_ref = search_process_keyrings_rcu(&ctx);
+		rcu_read_unlock();
 		kdebug("possessed=%p", skey_ref);
 
 		if (!IS_ERR(skey_ref)) {
diff --git a/security/keys/request_key.c b/security/keys/request_key.c
index 244e538d113f..bf1d223ec21c 100644
--- a/security/keys/request_key.c
+++ b/security/keys/request_key.c
@@ -385,7 +385,9 @@ static int construct_alloc_key(struct keyring_search_context *ctx,
 	 * waited for locks */
 	mutex_lock(&key_construction_mutex);
 
-	key_ref = search_process_keyrings(ctx);
+	rcu_read_lock();
+	key_ref = search_process_keyrings_rcu(ctx);
+	rcu_read_unlock();
 	if (!IS_ERR(key_ref))
 		goto key_already_present;
 
@@ -561,7 +563,9 @@ struct key *request_key_and_link(struct key_type *type,
 	}
 
 	/* search all the process keyrings for a key */
-	key_ref = search_process_keyrings(&ctx);
+	rcu_read_lock();
+	key_ref = search_process_keyrings_rcu(&ctx);
+	rcu_read_unlock();
 
 	if (!IS_ERR(key_ref)) {
 		if (dest_keyring) {
diff --git a/security/keys/request_key_auth.c b/security/keys/request_key_auth.c
index ec5226557023..99ed7a8a273d 100644
--- a/security/keys/request_key_auth.c
+++ b/security/keys/request_key_auth.c
@@ -58,7 +58,7 @@ static void request_key_auth_free_preparse(struct key_preparsed_payload *prep)
 static int request_key_auth_instantiate(struct key *key,
 					struct key_preparsed_payload *prep)
 {
-	key->payload.data[0] = (struct request_key_auth *)prep->data;
+	rcu_assign_keypointer(key, (struct request_key_auth *)prep->data);
 	return 0;
 }
 
@@ -68,7 +68,7 @@ static int request_key_auth_instantiate(struct key *key,
 static void request_key_auth_describe(const struct key *key,
 				      struct seq_file *m)
 {
-	struct request_key_auth *rka = get_request_key_auth(key);
+	struct request_key_auth *rka = dereference_key_rcu(key);
 
 	seq_puts(m, "key:");
 	seq_puts(m, key->description);
@@ -83,7 +83,7 @@ static void request_key_auth_describe(const struct key *key,
 static long request_key_auth_read(const struct key *key,
 				  char __user *buffer, size_t buflen)
 {
-	struct request_key_auth *rka = get_request_key_auth(key);
+	struct request_key_auth *rka = dereference_key_locked(key);
 	size_t datalen;
 	long ret;
 
@@ -102,23 +102,6 @@ static long request_key_auth_read(const struct key *key,
 	return ret;
 }
 
-/*
- * Handle revocation of an authorisation token key.
- *
- * Called with the key sem write-locked.
- */
-static void request_key_auth_revoke(struct key *key)
-{
-	struct request_key_auth *rka = get_request_key_auth(key);
-
-	kenter("{%d}", key->serial);
-
-	if (rka->cred) {
-		put_cred(rka->cred);
-		rka->cred = NULL;
-	}
-}
-
 static void free_request_key_auth(struct request_key_auth *rka)
 {
 	if (!rka)
@@ -131,16 +114,43 @@ static void free_request_key_auth(struct request_key_auth *rka)
 	kfree(rka);
 }
 
+/*
+ * Dispose of the request_key_auth record under RCU conditions
+ */
+static void request_key_auth_rcu_disposal(struct rcu_head *rcu)
+{
+	struct request_key_auth *rka =
+		container_of(rcu, struct request_key_auth, rcu);
+
+	free_request_key_auth(rka);
+}
+
+/*
+ * Handle revocation of an authorisation token key.
+ *
+ * Called with the key sem write-locked.
+ */
+static void request_key_auth_revoke(struct key *key)
+{
+	struct request_key_auth *rka = dereference_key_locked(key);
+
+	kenter("{%d}", key->serial);
+	rcu_assign_keypointer(key, NULL);
+	call_rcu(&rka->rcu, request_key_auth_rcu_disposal);
+}
+
 /*
  * Destroy an instantiation authorisation token key.
  */
 static void request_key_auth_destroy(struct key *key)
 {
-	struct request_key_auth *rka = get_request_key_auth(key);
+	struct request_key_auth *rka = rcu_access_pointer(key->payload.rcu_data0);
 
 	kenter("{%d}", key->serial);
-
-	free_request_key_auth(rka);
+	if (rka) {
+		rcu_assign_keypointer(key, NULL);
+		call_rcu(&rka->rcu, request_key_auth_rcu_disposal);
+	}
 }
 
 /*
@@ -249,7 +259,9 @@ struct key *key_get_instantiation_authkey(key_serial_t target_id)
 
 	ctx.index_key.desc_len = sprintf(description, "%x", target_id);
 
-	authkey_ref = search_process_keyrings(&ctx);
+	rcu_read_lock();
+	authkey_ref = search_process_keyrings_rcu(&ctx);
+	rcu_read_unlock();
 
 	if (IS_ERR(authkey_ref)) {
 		authkey = ERR_CAST(authkey_ref);

