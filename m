Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70B55FC4C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2019 17:07:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbfD3PH1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Apr 2019 11:07:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48604 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725950AbfD3PH0 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Apr 2019 11:07:26 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 62C9166991;
        Tue, 30 Apr 2019 15:07:26 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-61.rdu2.redhat.com [10.10.120.61])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8B85A5D785;
        Tue, 30 Apr 2019 15:07:24 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 05/11] keys: Add a 'recurse' flag for keyring searches [ver
 #2]
From:   David Howells <dhowells@redhat.com>
To:     ebiederm@xmission.com
Cc:     keyrings@vger.kernel.org, dhowells@redhat.com,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        dwalsh@redhat.com, vgoyal@redhat.com
Date:   Tue, 30 Apr 2019 16:07:23 +0100
Message-ID: <155663684365.31331.17072752052528463604.stgit@warthog.procyon.org.uk>
In-Reply-To: <155663679069.31331.3777091898004242996.stgit@warthog.procyon.org.uk>
References: <155663679069.31331.3777091898004242996.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Tue, 30 Apr 2019 15:07:26 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add a 'recurse' flag for keyring searches so that the flag can be omitted
and recursion disabled, thereby allowing just the nominated keyring to be
searched and none of the children.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 Documentation/security/keys/core.rst     |   10 ++++++----
 certs/blacklist.c                        |    2 +-
 crypto/asymmetric_keys/asymmetric_type.c |    2 +-
 include/linux/key.h                      |    3 ++-
 lib/digsig.c                             |    2 +-
 net/rxrpc/security.c                     |    2 +-
 security/integrity/digsig_asymmetric.c   |    4 ++--
 security/keys/internal.h                 |    1 +
 security/keys/keyctl.c                   |    2 +-
 security/keys/keyring.c                  |   12 ++++++++++--
 security/keys/proc.c                     |    3 ++-
 security/keys/process_keys.c             |    3 ++-
 security/keys/request_key.c              |    3 ++-
 security/keys/request_key_auth.c         |    3 ++-
 14 files changed, 34 insertions(+), 18 deletions(-)

diff --git a/Documentation/security/keys/core.rst b/Documentation/security/keys/core.rst
index 9521c4207f01..99079b664036 100644
--- a/Documentation/security/keys/core.rst
+++ b/Documentation/security/keys/core.rst
@@ -1159,11 +1159,13 @@ payload contents" for more information.
 
 	key_ref_t keyring_search(key_ref_t keyring_ref,
 				 const struct key_type *type,
-				 const char *description)
+				 const char *description,
+				 bool recurse)
 
-    This searches the keyring tree specified for a matching key. Error ENOKEY
-    is returned upon failure (use IS_ERR/PTR_ERR to determine). If successful,
-    the returned key will need to be released.
+    This searches the specified keyring only (recurse == false) or keyring tree
+    (recurse == true) specified for a matching key. Error ENOKEY is returned
+    upon failure (use IS_ERR/PTR_ERR to determine). If successful, the returned
+    key will need to be released.
 
     The possession attribute from the keyring reference is used to control
     access through the permissions mask and is propagated to the returned key
diff --git a/certs/blacklist.c b/certs/blacklist.c
index 3a507b9e2568..181cb7fa9540 100644
--- a/certs/blacklist.c
+++ b/certs/blacklist.c
@@ -128,7 +128,7 @@ int is_hash_blacklisted(const u8 *hash, size_t hash_len, const char *type)
 	*p = 0;
 
 	kref = keyring_search(make_key_ref(blacklist_keyring, true),
-			      &key_type_blacklist, buffer);
+			      &key_type_blacklist, buffer, false);
 	if (!IS_ERR(kref)) {
 		key_ref_put(kref);
 		ret = -EKEYREJECTED;
diff --git a/crypto/asymmetric_keys/asymmetric_type.c b/crypto/asymmetric_keys/asymmetric_type.c
index 69a0788a7de5..084027ef3121 100644
--- a/crypto/asymmetric_keys/asymmetric_type.c
+++ b/crypto/asymmetric_keys/asymmetric_type.c
@@ -87,7 +87,7 @@ struct key *find_asymmetric_key(struct key *keyring,
 	pr_debug("Look up: \"%s\"\n", req);
 
 	ref = keyring_search(make_key_ref(keyring, 1),
-			     &key_type_asymmetric, req);
+			     &key_type_asymmetric, req, true);
 	if (IS_ERR(ref))
 		pr_debug("Request for key '%s' err %ld\n", req, PTR_ERR(ref));
 	kfree(req);
diff --git a/include/linux/key.h b/include/linux/key.h
index b39f5876b66d..433f86fc8661 100644
--- a/include/linux/key.h
+++ b/include/linux/key.h
@@ -333,7 +333,8 @@ extern int keyring_clear(struct key *keyring);
 
 extern key_ref_t keyring_search(key_ref_t keyring,
 				struct key_type *type,
-				const char *description);
+				const char *description,
+				bool recurse);
 
 extern int keyring_add_key(struct key *keyring,
 			   struct key *key);
diff --git a/lib/digsig.c b/lib/digsig.c
index 6ba6fcd92dd1..abec995a0982 100644
--- a/lib/digsig.c
+++ b/lib/digsig.c
@@ -221,7 +221,7 @@ int digsig_verify(struct key *keyring, const char *sig, int siglen,
 		/* search in specific keyring */
 		key_ref_t kref;
 		kref = keyring_search(make_key_ref(keyring, 1UL),
-						&key_type_user, name);
+				      &key_type_user, name, true);
 		if (IS_ERR(kref))
 			key = ERR_CAST(kref);
 		else
diff --git a/net/rxrpc/security.c b/net/rxrpc/security.c
index c4479afe8ae7..2cfc7125bc41 100644
--- a/net/rxrpc/security.c
+++ b/net/rxrpc/security.c
@@ -148,7 +148,7 @@ int rxrpc_init_server_conn_security(struct rxrpc_connection *conn)
 
 	/* look through the service's keyring */
 	kref = keyring_search(make_key_ref(rx->securities, 1UL),
-			      &key_type_rxrpc_s, kdesc);
+			      &key_type_rxrpc_s, kdesc, true);
 	if (IS_ERR(kref)) {
 		read_unlock(&local->services_lock);
 		_leave(" = %ld [search]", PTR_ERR(kref));
diff --git a/security/integrity/digsig_asymmetric.c b/security/integrity/digsig_asymmetric.c
index d775e03fbbcc..fa52fbaef520 100644
--- a/security/integrity/digsig_asymmetric.c
+++ b/security/integrity/digsig_asymmetric.c
@@ -39,7 +39,7 @@ static struct key *request_asymmetric_key(struct key *keyring, uint32_t keyid)
 		key_ref_t kref;
 
 		kref = keyring_search(make_key_ref(key, 1),
-				     &key_type_asymmetric, name);
+				      &key_type_asymmetric, name, true);
 		if (!IS_ERR(kref)) {
 			pr_err("Key '%s' is in ima_blacklist_keyring\n", name);
 			return ERR_PTR(-EKEYREJECTED);
@@ -51,7 +51,7 @@ static struct key *request_asymmetric_key(struct key *keyring, uint32_t keyid)
 		key_ref_t kref;
 
 		kref = keyring_search(make_key_ref(keyring, 1),
-				      &key_type_asymmetric, name);
+				      &key_type_asymmetric, name, true);
 		if (IS_ERR(kref))
 			key = ERR_CAST(kref);
 		else
diff --git a/security/keys/internal.h b/security/keys/internal.h
index 3154ba59a2f0..8ac7573bf23b 100644
--- a/security/keys/internal.h
+++ b/security/keys/internal.h
@@ -123,6 +123,7 @@ struct keyring_search_context {
 #define KEYRING_SEARCH_NO_CHECK_PERM	0x0008	/* Don't check permissions */
 #define KEYRING_SEARCH_DETECT_TOO_DEEP	0x0010	/* Give an error on excessive depth */
 #define KEYRING_SEARCH_SKIP_EXPIRED	0x0020	/* Ignore expired keys (intention to replace) */
+#define KEYRING_SEARCH_RECURSE		0x0040	/* Search child keyrings also */
 
 	int (*iterator)(const void *object, void *iterator_data);
 
diff --git a/security/keys/keyctl.c b/security/keys/keyctl.c
index 3e4053a217c3..d2023d550bd6 100644
--- a/security/keys/keyctl.c
+++ b/security/keys/keyctl.c
@@ -704,7 +704,7 @@ long keyctl_keyring_search(key_serial_t ringid,
 	}
 
 	/* do the search */
-	key_ref = keyring_search(keyring_ref, ktype, description);
+	key_ref = keyring_search(keyring_ref, ktype, description, true);
 	if (IS_ERR(key_ref)) {
 		ret = PTR_ERR(key_ref);
 
diff --git a/security/keys/keyring.c b/security/keys/keyring.c
index 7f5f8d76dd7d..29a6e3255157 100644
--- a/security/keys/keyring.c
+++ b/security/keys/keyring.c
@@ -685,6 +685,9 @@ static bool search_nested_keyrings(struct key *keyring,
 	 * Non-keyrings avoid the leftmost branch of the root entirely (root
 	 * slots 1-15).
 	 */
+	if (!(ctx->flags & KEYRING_SEARCH_RECURSE))
+		goto not_this_keyring;
+
 	ptr = READ_ONCE(keyring->keys.root);
 	if (!ptr)
 		goto not_this_keyring;
@@ -885,13 +888,15 @@ key_ref_t keyring_search_aux(key_ref_t keyring_ref,
  * @keyring: The root of the keyring tree to be searched.
  * @type: The type of keyring we want to find.
  * @description: The name of the keyring we want to find.
+ * @recurse: True to search the children of @keyring also
  *
  * As keyring_search_aux() above, but using the current task's credentials and
  * type's default matching function and preferred search method.
  */
 key_ref_t keyring_search(key_ref_t keyring,
 			 struct key_type *type,
-			 const char *description)
+			 const char *description,
+			 bool recurse)
 {
 	struct keyring_search_context ctx = {
 		.index_key.type		= type,
@@ -906,6 +911,8 @@ key_ref_t keyring_search(key_ref_t keyring,
 	key_ref_t key;
 	int ret;
 
+	if (recurse)
+		ctx.flags |= KEYRING_SEARCH_RECURSE;
 	if (type->match_preparse) {
 		ret = type->match_preparse(&ctx.match_data);
 		if (ret < 0)
@@ -1170,7 +1177,8 @@ static int keyring_detect_cycle(struct key *A, struct key *B)
 		.flags			= (KEYRING_SEARCH_NO_STATE_CHECK |
 					   KEYRING_SEARCH_NO_UPDATE_TIME |
 					   KEYRING_SEARCH_NO_CHECK_PERM |
-					   KEYRING_SEARCH_DETECT_TOO_DEEP),
+					   KEYRING_SEARCH_DETECT_TOO_DEEP |
+					   KEYRING_SEARCH_RECURSE),
 	};
 
 	rcu_read_lock();
diff --git a/security/keys/proc.c b/security/keys/proc.c
index 78ac305d715e..8695f6108da9 100644
--- a/security/keys/proc.c
+++ b/security/keys/proc.c
@@ -170,7 +170,8 @@ static int proc_keys_show(struct seq_file *m, void *v)
 		.match_data.cmp		= lookup_user_key_possessed,
 		.match_data.raw_data	= key,
 		.match_data.lookup_type	= KEYRING_SEARCH_LOOKUP_DIRECT,
-		.flags			= KEYRING_SEARCH_NO_STATE_CHECK,
+		.flags			= (KEYRING_SEARCH_NO_STATE_CHECK |
+					   KEYRING_SEARCH_RECURSE),
 	};
 
 	key_ref = make_key_ref(key, 0);
diff --git a/security/keys/process_keys.c b/security/keys/process_keys.c
index f05f7125a7d5..70fa20888ca8 100644
--- a/security/keys/process_keys.c
+++ b/security/keys/process_keys.c
@@ -540,7 +540,8 @@ key_ref_t lookup_user_key(key_serial_t id, unsigned long lflags,
 	struct keyring_search_context ctx = {
 		.match_data.cmp		= lookup_user_key_possessed,
 		.match_data.lookup_type	= KEYRING_SEARCH_LOOKUP_DIRECT,
-		.flags			= KEYRING_SEARCH_NO_STATE_CHECK,
+		.flags			= (KEYRING_SEARCH_NO_STATE_CHECK |
+					   KEYRING_SEARCH_RECURSE),
 	};
 	struct request_key_auth *rka;
 	struct key *key;
diff --git a/security/keys/request_key.c b/security/keys/request_key.c
index a5b74b7758f7..39802540ffff 100644
--- a/security/keys/request_key.c
+++ b/security/keys/request_key.c
@@ -537,7 +537,8 @@ struct key *request_key_and_link(struct key_type *type,
 		.match_data.raw_data	= description,
 		.match_data.lookup_type	= KEYRING_SEARCH_LOOKUP_DIRECT,
 		.flags			= (KEYRING_SEARCH_DO_STATE_CHECK |
-					   KEYRING_SEARCH_SKIP_EXPIRED),
+					   KEYRING_SEARCH_SKIP_EXPIRED |
+					   KEYRING_SEARCH_RECURSE),
 	};
 	struct key *key;
 	key_ref_t key_ref;
diff --git a/security/keys/request_key_auth.c b/security/keys/request_key_auth.c
index bda6201c6c45..b83930581f4d 100644
--- a/security/keys/request_key_auth.c
+++ b/security/keys/request_key_auth.c
@@ -242,7 +242,8 @@ struct key *key_get_instantiation_authkey(key_serial_t target_id)
 		.match_data.cmp		= key_default_cmp,
 		.match_data.raw_data	= description,
 		.match_data.lookup_type	= KEYRING_SEARCH_LOOKUP_DIRECT,
-		.flags			= KEYRING_SEARCH_DO_STATE_CHECK,
+		.flags			= (KEYRING_SEARCH_DO_STATE_CHECK |
+					   KEYRING_SEARCH_RECURSE),
 	};
 	struct key *authkey;
 	key_ref_t authkey_ref;

