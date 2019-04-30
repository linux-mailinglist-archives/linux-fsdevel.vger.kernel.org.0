Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47552FC5A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2019 17:07:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbfD3PHv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Apr 2019 11:07:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37916 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725950AbfD3PHu (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Apr 2019 11:07:50 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DF0D930BB344;
        Tue, 30 Apr 2019 15:07:49 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-61.rdu2.redhat.com [10.10.120.61])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2C97B1001E66;
        Tue, 30 Apr 2019 15:07:48 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 08/11] keys: Include target namespace in match criteria [ver
 #2]
From:   David Howells <dhowells@redhat.com>
To:     ebiederm@xmission.com
Cc:     keyrings@vger.kernel.org, dhowells@redhat.com,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        dwalsh@redhat.com, vgoyal@redhat.com
Date:   Tue, 30 Apr 2019 16:07:47 +0100
Message-ID: <155663686738.31331.14037065651903278208.stgit@warthog.procyon.org.uk>
In-Reply-To: <155663679069.31331.3777091898004242996.stgit@warthog.procyon.org.uk>
References: <155663679069.31331.3777091898004242996.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Tue, 30 Apr 2019 15:07:49 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Currently a key has a standard matching criteria of { type, description } and
this is used to only allow keys with unique criteria in a keyring.  This
means, however, that you cannot have keys with the same type and description
but a different target namespace in the same keyring.

This is a potential problem for a containerised environment where, say, a
container is made up of some parts of its mount space involving netfs
superblocks from two different network namespaces.

This is also a problem for shared system management keyrings such as the DNS
records keyring or the NFS idmapper keyring that might contain keys from
different network namespaces.

Fix this by including a namespace component in a key's matching criteria.
Keyring types are marked to indicate which, if any, namespace is relevant to
keys of that type, and that namespace is set when the key is created from the
current task's namespace set.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 include/linux/key.h        |   11 +++++++++++
 security/keys/gc.c         |    2 +-
 security/keys/key.c        |    1 +
 security/keys/keyring.c    |   36 ++++++++++++++++++++++++++++++++++--
 security/keys/persistent.c |    1 +
 5 files changed, 48 insertions(+), 3 deletions(-)

diff --git a/include/linux/key.h b/include/linux/key.h
index 214b1824c20c..c02f6e171b8c 100644
--- a/include/linux/key.h
+++ b/include/linux/key.h
@@ -82,9 +82,16 @@ struct cred;
 
 struct key_type;
 struct key_owner;
+struct key_tag;
 struct keyring_list;
 struct keyring_name;
 
+struct key_tag {
+	struct rcu_head		rcu;
+	refcount_t		usage;
+	bool			removed;	/* T when subject removed */
+};
+
 struct keyring_index_key {
 	/* [!] If this structure is altered, the union in struct key must change too! */
 	unsigned long		hash;			/* Hash value */
@@ -101,6 +108,7 @@ struct keyring_index_key {
 		unsigned long x;
 	};
 	struct key_type		*type;
+	struct key_tag		*domain_tag;	/* Domain of operation */
 	const char		*description;
 };
 
@@ -218,6 +226,7 @@ struct key {
 			unsigned long	hash;
 			unsigned long	len_desc;
 			struct key_type	*type;		/* type of key */
+			struct key_tag	*domain_tag;	/* Domain of operation */
 			char		*description;
 		};
 	};
@@ -268,6 +277,7 @@ extern struct key *key_alloc(struct key_type *type,
 extern void key_revoke(struct key *key);
 extern void key_invalidate(struct key *key);
 extern void key_put(struct key *key);
+extern bool key_put_tag(struct key_tag *tag);
 
 static inline struct key *__key_get(struct key *key)
 {
@@ -428,6 +438,7 @@ extern void key_init(void);
 #define key_fsgid_changed(t)		do { } while(0)
 #define key_init()			do { } while(0)
 #define key_free_user_ns(ns)		do { } while(0)
+#define key_put_subject(s)		do { } while(0)
 
 #endif /* CONFIG_KEYS */
 #endif /* __KERNEL__ */
diff --git a/security/keys/gc.c b/security/keys/gc.c
index 634e96b380e8..83d279fb7793 100644
--- a/security/keys/gc.c
+++ b/security/keys/gc.c
@@ -154,7 +154,7 @@ static noinline void key_gc_unused_keys(struct list_head *keys)
 			atomic_dec(&key->user->nikeys);
 
 		key_user_put(key->user);
-
+		key_put_tag(key->domain_tag);
 		kfree(key->description);
 
 		memzero_explicit(key, sizeof(*key));
diff --git a/security/keys/key.c b/security/keys/key.c
index 1568b0028ba4..8cd0f98e4fa3 100644
--- a/security/keys/key.c
+++ b/security/keys/key.c
@@ -317,6 +317,7 @@ struct key *key_alloc(struct key_type *type, const char *desc,
 		goto security_error;
 
 	/* publish the key by giving it a serial number */
+	refcount_inc(&key->domain_tag->usage);
 	atomic_inc(&user->nkeys);
 	key_alloc_serial(key);
 
diff --git a/security/keys/keyring.c b/security/keys/keyring.c
index 1fc9219ed002..0898d6d91d41 100644
--- a/security/keys/keyring.c
+++ b/security/keys/keyring.c
@@ -175,6 +175,9 @@ static void hash_key_type_and_desc(struct keyring_index_key *index_key)
 	type = (unsigned long)index_key->type;
 	acc = mult_64x32_and_fold(type, desc_len + 13);
 	acc = mult_64x32_and_fold(acc, 9207);
+	piece = (unsigned long)index_key->domain_tag;
+	acc = mult_64x32_and_fold(acc, piece);
+	acc = mult_64x32_and_fold(acc, 9207);
 
 	for (;;) {
 		n = desc_len;
@@ -208,16 +211,36 @@ static void hash_key_type_and_desc(struct keyring_index_key *index_key)
 
 /*
  * Finalise an index key to include a part of the description actually in the
- * index key and to add in the hash too.
+ * index key, to set the domain tag and to calculate the hash.
  */
 void key_set_index_key(struct keyring_index_key *index_key)
 {
+	static struct key_tag default_domain_tag = { .usage = REFCOUNT_INIT(1), };
 	size_t n = min_t(size_t, index_key->desc_len, sizeof(index_key->desc));
+
 	memcpy(index_key->desc, index_key->description, n);
 
+	index_key->domain_tag = &default_domain_tag;
 	hash_key_type_and_desc(index_key);
 }
 
+/**
+ * key_put_tag - Release a ref on a tag.
+ * @tag: The tag to release.
+ *
+ * This releases a reference the given tag and returns true if that ref was the
+ * last one.
+ */
+bool key_put_tag(struct key_tag *tag)
+{
+	if (refcount_dec_and_test(&tag->usage)) {
+		kfree_rcu(tag, rcu);
+		return true;
+	}
+
+	return false;
+}
+
 /*
  * Build the next index key chunk.
  *
@@ -238,8 +261,10 @@ static unsigned long keyring_get_key_chunk(const void *data, int level)
 		return index_key->x;
 	case 2:
 		return (unsigned long)index_key->type;
+	case 3:
+		return (unsigned long)index_key->domain_tag;
 	default:
-		level -= 3;
+		level -= 4;
 		if (desc_len <= sizeof(index_key->desc))
 			return 0;
 
@@ -268,6 +293,7 @@ static bool keyring_compare_object(const void *object, const void *data)
 	const struct key *key = keyring_ptr_to_key(object);
 
 	return key->index_key.type == index_key->type &&
+		key->index_key.domain_tag == index_key->domain_tag &&
 		key->index_key.desc_len == index_key->desc_len &&
 		memcmp(key->index_key.description, index_key->description,
 		       index_key->desc_len) == 0;
@@ -309,6 +335,12 @@ static int keyring_diff_objects(const void *object, const void *data)
 		goto differ;
 	level += sizeof(unsigned long);
 
+	seg_a = (unsigned long)a->domain_tag;
+	seg_b = (unsigned long)b->domain_tag;
+	if ((seg_a ^ seg_b) != 0)
+		goto differ;
+	level += sizeof(unsigned long);
+
 	i = sizeof(a->desc);
 	if (a->desc_len <= i)
 		goto same;
diff --git a/security/keys/persistent.c b/security/keys/persistent.c
index 90303fe4a394..9944d855a28d 100644
--- a/security/keys/persistent.c
+++ b/security/keys/persistent.c
@@ -84,6 +84,7 @@ static long key_get_persistent(struct user_namespace *ns, kuid_t uid,
 	long ret;
 
 	/* Look in the register if it exists */
+	memset(&index_key, 0, sizeof(index_key));
 	index_key.type = &key_type_keyring;
 	index_key.description = buf;
 	index_key.desc_len = sprintf(buf, "_persistent.%u", from_kuid(ns, uid));

