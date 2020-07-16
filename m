Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09E0C222D0D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jul 2020 22:36:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbgGPUf6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Jul 2020 16:35:58 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:56717 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726836AbgGPUfh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Jul 2020 16:35:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594931735;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sGlqsraquDgu8I0zmAVqtzYIeEOB5GrV+LoXf470Egs=;
        b=OqVb7lvGUno+aBdyUjLXfV8GjdWQFuKBRgds9y2mhQCWTNrHu57iKC3xe2l5i3OD6eGraj
        UDspwaRNhKdDfxN+otV4TkvbEYHHW7/TuAEo0ifQnrCo3VOvza+HPVEVkD7N1cCfNrjbx4
        UP6KoVuSPfwcTCgcsqdzH3ocevsZxQs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-358-8K5DXL6lPOuYLyuH5dvvsw-1; Thu, 16 Jul 2020 16:35:31 -0400
X-MC-Unique: 8K5DXL6lPOuYLyuH5dvvsw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D246D108D;
        Thu, 16 Jul 2020 20:35:28 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-113.rdu2.redhat.com [10.10.112.113])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B90C060C84;
        Thu, 16 Jul 2020 20:35:25 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [RFC PATCH 4/5] keys: Split the search perms between KEY_NEED_USE and
 KEY_NEED_SEARCH
From:   David Howells <dhowells@redhat.com>
To:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Casey Schaufler <casey@schaufler-ca.com>
Cc:     dhowells@redhat.com,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Eric Biederman <ebiederm@xmission.com>, jlayton@redhat.com,
        christian@brauner.io, selinux@vger.kernel.org,
        linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, containers@lists.linux-foundation.org
Date:   Thu, 16 Jul 2020 21:35:24 +0100
Message-ID: <159493172491.3249370.12796192457457028352.stgit@warthog.procyon.org.uk>
In-Reply-To: <159493167778.3249370.8145886688150701997.stgit@warthog.procyon.org.uk>
References: <159493167778.3249370.8145886688150701997.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.22
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Allow the permission needed for a keyring search to be specified and split
the permissions between KEY_NEED_USE (the kernel wants to do something with
the key) and KEY_NEED_SEARCH (userspace wants to do something with the
key).

This primarily affects how request_key() works, differentiating implicit
calls (e.g. from filesystems) from userspace calling the request_key()
system call.

This will allow the kernel to find keys in a hidden container keyring, but
not the denizens of the container.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 certs/blacklist.c                        |    2 +-
 crypto/asymmetric_keys/asymmetric_type.c |    2 +-
 include/linux/key.h                      |    2 ++
 net/rxrpc/security.c                     |    2 +-
 security/keys/internal.h                 |    4 ++++
 security/keys/keyctl.c                   |    6 ++++--
 security/keys/keyring.c                  |   13 ++++++++-----
 security/keys/permission.c               |   31 ++++++++++++++++++++++++++++++
 security/keys/proc.c                     |    1 +
 security/keys/process_keys.c             |    8 ++++++--
 security/keys/request_key.c              |    5 +++++
 security/keys/request_key_auth.c         |    1 +
 12 files changed, 65 insertions(+), 12 deletions(-)

diff --git a/certs/blacklist.c b/certs/blacklist.c
index aff83e3a9f49..29c3cb6254d9 100644
--- a/certs/blacklist.c
+++ b/certs/blacklist.c
@@ -123,7 +123,7 @@ int is_hash_blacklisted(const u8 *hash, size_t hash_len, const char *type)
 	*p = 0;
 
 	kref = keyring_search(make_key_ref(blacklist_keyring, true),
-			      &key_type_blacklist, buffer, false);
+			      &key_type_blacklist, buffer, KEY_NEED_USE, false);
 	if (!IS_ERR(kref)) {
 		key_ref_put(kref);
 		ret = -EKEYREJECTED;
diff --git a/crypto/asymmetric_keys/asymmetric_type.c b/crypto/asymmetric_keys/asymmetric_type.c
index 6e5fc8e31f01..4559ac2f0bb7 100644
--- a/crypto/asymmetric_keys/asymmetric_type.c
+++ b/crypto/asymmetric_keys/asymmetric_type.c
@@ -83,7 +83,7 @@ struct key *find_asymmetric_key(struct key *keyring,
 	pr_debug("Look up: \"%s\"\n", req);
 
 	ref = keyring_search(make_key_ref(keyring, 1),
-			     &key_type_asymmetric, req, true);
+			     &key_type_asymmetric, req, KEY_NEED_USE, true);
 	if (IS_ERR(ref))
 		pr_debug("Request for key '%s' err %ld\n", req, PTR_ERR(ref));
 	kfree(req);
diff --git a/include/linux/key.h b/include/linux/key.h
index 94a6d51464b5..0db5539366e7 100644
--- a/include/linux/key.h
+++ b/include/linux/key.h
@@ -296,6 +296,7 @@ extern struct key *key_alloc(struct key_type *type,
 #define KEY_ALLOC_BUILT_IN		0x0004	/* Key is built into kernel */
 #define KEY_ALLOC_BYPASS_RESTRICTION	0x0008	/* Override the check on restricted keyrings */
 #define KEY_ALLOC_UID_KEYRING		0x0010	/* allocating a user or user session keyring */
+#define KEY_ALLOC_USERSPACE_REQUEST	0x0020	/* Userspace requested the key */
 
 extern void key_revoke(struct key *key);
 extern void key_invalidate(struct key *key);
@@ -432,6 +433,7 @@ extern int keyring_clear(struct key *keyring);
 extern key_ref_t keyring_search(key_ref_t keyring,
 				struct key_type *type,
 				const char *description,
+				enum key_need_perm need_perm,
 				bool recurse);
 
 extern int keyring_add_key(struct key *keyring,
diff --git a/net/rxrpc/security.c b/net/rxrpc/security.c
index 9b1fb9ed0717..23077cfe3d44 100644
--- a/net/rxrpc/security.c
+++ b/net/rxrpc/security.c
@@ -141,7 +141,7 @@ bool rxrpc_look_up_server_security(struct rxrpc_local *local, struct rxrpc_sock
 
 	/* look through the service's keyring */
 	kref = keyring_search(make_key_ref(rx->securities, 1UL),
-			      &key_type_rxrpc_s, kdesc, true);
+			      &key_type_rxrpc_s, kdesc, KEY_NEED_USE, true);
 	if (IS_ERR(kref)) {
 		trace_rxrpc_abort(0, "SVK",
 				  sp->hdr.cid, sp->hdr.callNumber, sp->hdr.seq,
diff --git a/security/keys/internal.h b/security/keys/internal.h
index af2c9531c435..d0d1bce95674 100644
--- a/security/keys/internal.h
+++ b/security/keys/internal.h
@@ -131,6 +131,7 @@ struct keyring_search_context {
 	struct keyring_index_key index_key;
 	const struct cred	*cred;
 	struct key_match_data	match_data;
+	enum key_need_perm	need_perm;	/* Permission required for search */
 	unsigned		flags;
 #define KEYRING_SEARCH_NO_STATE_CHECK	0x0001	/* Skip state checks */
 #define KEYRING_SEARCH_DO_STATE_CHECK	0x0002	/* Override NO_STATE_CHECK */
@@ -196,6 +197,9 @@ extern void key_gc_keytype(struct key_type *ktype);
 extern int key_task_permission(const key_ref_t key_ref,
 			       const struct cred *cred,
 			       enum key_need_perm need_perm);
+extern int key_search_permission(const key_ref_t key_ref,
+				 struct keyring_search_context *ctx,
+				 enum key_need_perm need_perm);
 extern unsigned int key_acl_to_perm(const struct key_acl *acl);
 extern long key_set_acl(struct key *key, struct key_acl *acl);
 extern void key_put_acl(struct key_acl *acl);
diff --git a/security/keys/keyctl.c b/security/keys/keyctl.c
index fae2df676e30..54a2bfff9af2 100644
--- a/security/keys/keyctl.c
+++ b/security/keys/keyctl.c
@@ -225,7 +225,8 @@ SYSCALL_DEFINE4(request_key, const char __user *, _type,
 	key = request_key_and_link(ktype, description, NULL, callout_info,
 				   callout_len, NULL, NULL,
 				   key_ref_to_ptr(dest_ref),
-				   KEY_ALLOC_IN_QUOTA);
+				   KEY_ALLOC_IN_QUOTA |
+				   KEY_ALLOC_USERSPACE_REQUEST);
 	if (IS_ERR(key)) {
 		ret = PTR_ERR(key);
 		goto error5;
@@ -685,7 +686,8 @@ long keyctl_keyring_search(key_serial_t ringid,
 	}
 
 	/* do the search */
-	key_ref = keyring_search(keyring_ref, ktype, description, true);
+	key_ref = keyring_search(keyring_ref, ktype, description,
+				 KEY_NEED_SEARCH, true);
 	if (IS_ERR(key_ref)) {
 		ret = PTR_ERR(key_ref);
 
diff --git a/security/keys/keyring.c b/security/keys/keyring.c
index f14aabf27a51..1779c95b428c 100644
--- a/security/keys/keyring.c
+++ b/security/keys/keyring.c
@@ -621,8 +621,8 @@ static int keyring_search_iterator(const void *object, void *iterator_data)
 
 	/* key must have search permissions */
 	if (!(ctx->flags & KEYRING_SEARCH_NO_CHECK_PERM) &&
-	    key_task_permission(make_key_ref(key, ctx->possessed),
-				ctx->cred, KEY_NEED_SEARCH) < 0) {
+	    key_search_permission(make_key_ref(key, ctx->possessed),
+				  ctx, ctx->need_perm) < 0) {
 		ctx->result = ERR_PTR(-EACCES);
 		kleave(" = %d [!perm]", ctx->skipped_ret);
 		goto skipped;
@@ -798,8 +798,8 @@ static bool search_nested_keyrings(struct key *keyring,
 
 		/* Search a nested keyring */
 		if (!(ctx->flags & KEYRING_SEARCH_NO_CHECK_PERM) &&
-		    key_task_permission(make_key_ref(key, ctx->possessed),
-					ctx->cred, KEY_NEED_SEARCH) < 0)
+		    key_search_permission(make_key_ref(key, ctx->possessed),
+					  ctx, KEY_NEED_SEARCH) < 0)
 			continue;
 
 		/* stack the current position */
@@ -921,7 +921,7 @@ key_ref_t keyring_search_rcu(key_ref_t keyring_ref,
 		return ERR_PTR(-ENOTDIR);
 
 	if (!(ctx->flags & KEYRING_SEARCH_NO_CHECK_PERM)) {
-		err = key_task_permission(keyring_ref, ctx->cred, KEY_NEED_SEARCH);
+		err = key_search_permission(keyring_ref, ctx, ctx->need_perm);
 		if (err < 0)
 			return ERR_PTR(err);
 	}
@@ -937,6 +937,7 @@ key_ref_t keyring_search_rcu(key_ref_t keyring_ref,
  * @keyring: The root of the keyring tree to be searched.
  * @type: The type of keyring we want to find.
  * @description: The name of the keyring we want to find.
+ * @need_perm: The permission required of the target key.
  * @recurse: True to search the children of @keyring also
  *
  * As keyring_search_rcu() above, but using the current task's credentials and
@@ -945,6 +946,7 @@ key_ref_t keyring_search_rcu(key_ref_t keyring_ref,
 key_ref_t keyring_search(key_ref_t keyring,
 			 struct key_type *type,
 			 const char *description,
+			 enum key_need_perm need_perm,
 			 bool recurse)
 {
 	struct keyring_search_context ctx = {
@@ -955,6 +957,7 @@ key_ref_t keyring_search(key_ref_t keyring,
 		.match_data.cmp		= key_default_cmp,
 		.match_data.raw_data	= description,
 		.match_data.lookup_type	= KEYRING_SEARCH_LOOKUP_DIRECT,
+		.need_perm		= need_perm,
 		.flags			= KEYRING_SEARCH_DO_STATE_CHECK,
 	};
 	key_ref_t key;
diff --git a/security/keys/permission.c b/security/keys/permission.c
index 0bb7f6b695f4..3ae4d9aedc3a 100644
--- a/security/keys/permission.c
+++ b/security/keys/permission.c
@@ -253,6 +253,37 @@ int key_task_permission(const key_ref_t key_ref, const struct cred *cred,
 	return security_key_permission(key_ref, cred, need_perm, notes);
 }
 
+/**
+ * key_search_permission - Check a key can be searched for
+ * @key_ref: The key to check.
+ * @cred: The credentials to use.
+ * @need_perm: The permission required.
+ *
+ * Check to see whether permission is granted to use a key in the desired way,
+ * but permit the security modules to override.
+ *
+ * The caller must hold the RCU readlock.
+ *
+ * Returns 0 if successful, -EACCES if access is denied based on the
+ * permissions bits or the LSM check.
+ */
+int key_search_permission(const key_ref_t key_ref,
+			  struct keyring_search_context *ctx,
+			  enum key_need_perm need_perm)
+{
+	unsigned int allow, notes = 0;
+	int ret;
+
+	allow = key_resolve_acl(key_ref, ctx->cred);
+
+	ret = check_key_permission(key_ref, ctx->cred, allow, need_perm, &notes);
+	if (ret < 0)
+		return ret;
+
+	/* Let the LSMs be the final arbiter */
+	return security_key_permission(key_ref, ctx->cred, need_perm, notes);
+}
+
 /**
  * key_validate - Validate a key.
  * @key: The key to be validated.
diff --git a/security/keys/proc.c b/security/keys/proc.c
index c68ec5f98659..a6b349ee1759 100644
--- a/security/keys/proc.c
+++ b/security/keys/proc.c
@@ -174,6 +174,7 @@ static int proc_keys_show(struct seq_file *m, void *v)
 		.match_data.cmp		= lookup_user_key_possessed,
 		.match_data.raw_data	= key,
 		.match_data.lookup_type	= KEYRING_SEARCH_LOOKUP_DIRECT,
+		.need_perm		= KEY_NEED_SEARCH,
 		.flags			= (KEYRING_SEARCH_NO_STATE_CHECK |
 					   KEYRING_SEARCH_RECURSE),
 	};
diff --git a/security/keys/process_keys.c b/security/keys/process_keys.c
index 11227101bea0..3721f96dd6fb 100644
--- a/security/keys/process_keys.c
+++ b/security/keys/process_keys.c
@@ -135,7 +135,8 @@ int look_up_user_keyrings(struct key **_user_keyring,
 	 */
 	snprintf(buf, sizeof(buf), "_uid.%u", uid);
 	uid_keyring_r = keyring_search(make_key_ref(reg_keyring, true),
-				       &key_type_keyring, buf, false);
+				       &key_type_keyring, buf, KEY_NEED_SEARCH,
+				       false);
 	kdebug("_uid %p", uid_keyring_r);
 	if (uid_keyring_r == ERR_PTR(-EAGAIN)) {
 		uid_keyring = keyring_alloc(buf, cred->user->uid, INVALID_GID,
@@ -157,7 +158,8 @@ int look_up_user_keyrings(struct key **_user_keyring,
 	/* Get a default session keyring (which might also exist already) */
 	snprintf(buf, sizeof(buf), "_uid_ses.%u", uid);
 	session_keyring_r = keyring_search(make_key_ref(reg_keyring, true),
-					   &key_type_keyring, buf, false);
+					   &key_type_keyring, buf, KEY_NEED_SEARCH,
+					   false);
 	kdebug("_uid_ses %p", session_keyring_r);
 	if (session_keyring_r == ERR_PTR(-EAGAIN)) {
 		session_keyring = keyring_alloc(buf, cred->user->uid, INVALID_GID,
@@ -230,6 +232,7 @@ struct key *get_user_session_keyring_rcu(const struct cred *cred)
 		.match_data.cmp		= key_default_cmp,
 		.match_data.raw_data	= buf,
 		.match_data.lookup_type	= KEYRING_SEARCH_LOOKUP_DIRECT,
+		.need_perm		= KEY_NEED_SEARCH,
 		.flags			= KEYRING_SEARCH_DO_STATE_CHECK,
 	};
 
@@ -648,6 +651,7 @@ key_ref_t lookup_user_key(key_serial_t id, unsigned long lflags,
 	struct keyring_search_context ctx = {
 		.match_data.cmp		= lookup_user_key_possessed,
 		.match_data.lookup_type	= KEYRING_SEARCH_LOOKUP_DIRECT,
+		.need_perm		= KEY_NEED_SEARCH,
 		.flags			= (KEYRING_SEARCH_NO_STATE_CHECK |
 					   KEYRING_SEARCH_RECURSE),
 	};
diff --git a/security/keys/request_key.c b/security/keys/request_key.c
index 2b84efb420cb..479ae0573d1e 100644
--- a/security/keys/request_key.c
+++ b/security/keys/request_key.c
@@ -567,6 +567,7 @@ struct key *request_key_and_link(struct key_type *type,
 		.match_data.cmp		= key_default_cmp,
 		.match_data.raw_data	= description,
 		.match_data.lookup_type	= KEYRING_SEARCH_LOOKUP_DIRECT,
+		.need_perm		= KEY_NEED_USE,
 		.flags			= (KEYRING_SEARCH_DO_STATE_CHECK |
 					   KEYRING_SEARCH_SKIP_EXPIRED |
 					   KEYRING_SEARCH_RECURSE),
@@ -579,6 +580,9 @@ struct key *request_key_and_link(struct key_type *type,
 	       ctx.index_key.type->name, ctx.index_key.description,
 	       callout_info, callout_len, aux, dest_keyring, flags);
 
+	if (flags & KEY_ALLOC_USERSPACE_REQUEST)
+		ctx.need_perm = KEY_NEED_SEARCH;
+
 	if (type->match_preparse) {
 		ret = type->match_preparse(&ctx.match_data);
 		if (ret < 0) {
@@ -774,6 +778,7 @@ struct key *request_key_rcu(struct key_type *type,
 		.match_data.cmp		= key_default_cmp,
 		.match_data.raw_data	= description,
 		.match_data.lookup_type	= KEYRING_SEARCH_LOOKUP_DIRECT,
+		.need_perm		= KEY_NEED_USE,
 		.flags			= (KEYRING_SEARCH_DO_STATE_CHECK |
 					   KEYRING_SEARCH_SKIP_EXPIRED),
 	};
diff --git a/security/keys/request_key_auth.c b/security/keys/request_key_auth.c
index ee8c5fe6ed61..f8f77af152de 100644
--- a/security/keys/request_key_auth.c
+++ b/security/keys/request_key_auth.c
@@ -264,6 +264,7 @@ struct key *key_get_instantiation_authkey(key_serial_t target_id)
 		.match_data.cmp		= key_default_cmp,
 		.match_data.raw_data	= description,
 		.match_data.lookup_type	= KEYRING_SEARCH_LOOKUP_DIRECT,
+		.need_perm		= KEY_NEED_USE,
 		.flags			= (KEYRING_SEARCH_DO_STATE_CHECK |
 					   KEYRING_SEARCH_RECURSE),
 	};


