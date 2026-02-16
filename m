Return-Path: <linux-fsdevel+bounces-77277-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AMVpK/Eck2mM1gEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77277-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Feb 2026 14:34:41 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 11A38143DAD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Feb 2026 14:34:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5464A3013C53
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Feb 2026 13:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CCB230EF81;
	Mon, 16 Feb 2026 13:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bz3aunfe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B7D28C871;
	Mon, 16 Feb 2026 13:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771248746; cv=none; b=GYKqv6F0yP7aVWsucZHg0umSDIEpb/dZ28dQGBQzPeIQTXinItImuVroxyVL5/EhTxFVLVnd+lLXJ5Q3r1GJJk9l57W+ip1l6W1D8EAZ0dR/96Knd94q6rk2nNyUcQlGOnvt+Aeed4T76EWM2jA3PXKXgcDVXDFDtIWCDeGKIP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771248746; c=relaxed/simple;
	bh=lRkBebN2DyEFUov+B67VPOUqf4avYVkt75F229kVmKA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lycIU9tpsEauM4YboOCszUbuF7fihGvg9rJNHRqMfSw+NLZPxCNu22fbVDpLPOHhUVRHaXsoFTN7lPIbJ1FwVEEV1RQzgyzYTrybUGG7Z+aCITqBdrtA76lbt6nq2i4+C0GR4zfwPS61yVXGU/iEXre5fI8tnLTEoafNLaXWpbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bz3aunfe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6441EC116C6;
	Mon, 16 Feb 2026 13:32:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771248745;
	bh=lRkBebN2DyEFUov+B67VPOUqf4avYVkt75F229kVmKA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Bz3aunfeQSsNjNdeZv+l+2mfzrW7SqsFW6w2aPYJHxtWTtGbJ7ueorBgxhU1gVxhe
	 g7waQLA/L1a0UJ+Z7yVV4usP1h3gmW7kll5xXeIGbTBVKW+FE+9Mg+vOjn2UCQfE8r
	 miev+Oy6HkW96xenVd2yAn1a7eOh6UJgf/0kKrLye9uWmIXVz8b7tAszmYhrAXmwl3
	 HIVv/u3LSzO72V2J4fSgA4x30W1u5dkG8+EZeY2yGHlI0BEdoAmw3Zne6vmOiSSnNL
	 k+vqxcKV+u+usSUMYKWvVXFGtazP4eypDw5dLaWQIEpiWv7fMIRmtkbvN81ZU9kfKr
	 JEx5TjayzWvuQ==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 16 Feb 2026 14:31:58 +0100
Subject: [PATCH 02/14] xattr: add rhashtable-based simple_xattr
 infrastructure
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260216-work-xattr-socket-v1-2-c2efa4f74cb7@kernel.org>
References: <20260216-work-xattr-socket-v1-0-c2efa4f74cb7@kernel.org>
In-Reply-To: <20260216-work-xattr-socket-v1-0-c2efa4f74cb7@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>, Josef Bacik <josef@toxicpanda.com>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-kernel@vger.kernel.org, Hugh Dickins <hughd@google.com>, 
 linux-mm@kvack.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Tejun Heo <tj@kernel.org>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Jann Horn <jannh@google.com>, 
 netdev@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=19222; i=brauner@kernel.org;
 h=from:subject:message-id; bh=lRkBebN2DyEFUov+B67VPOUqf4avYVkt75F229kVmKA=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWROlonTUGbJPHl0a927JS9eBklpqNh/vWX2ePZKztSD1
 Suv2xgUdJSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEwkbB7D/0TRXstZP6e4f2+8
 fqVuGfe6i/nm0dPiD/v8UshJe8sm+Inhv++u5+fNcmRdZl5a8PpBgq+44aeM5pZ3U3UZP/zXnyN
 dzQ0A
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77277-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 11A38143DAD
X-Rspamd-Action: no action

Add rhashtable support to the simple_xattr subsystem while keeping the
existing rbtree code fully functional. This allows consumers to be
migrated one at a time without breaking any intermediate build.

struct simple_xattrs gains a dispatch flag and a union holding either
the rbtree (rb_root + rwlock) or rhashtable state:

  struct simple_xattrs {
      bool use_rhashtable;
      union {
          struct { struct rb_root rb_root; rwlock_t lock; };
          struct rhashtable ht;
      };
  };

simple_xattrs_init() continues to set up the rbtree path for existing
embedded-struct callers.

Add simple_xattrs_alloc() which dynamically allocates a simple_xattrs
and initializes the rhashtable path. This is the entry point for
consumers switching to pointer-based lazy allocation.

The five core functions (get, set, list, add, free) dispatch based on
the use_rhashtable flag.

Existing callers continue to use the rbtree path unchanged. As each
consumer is converted it will switch to simple_xattrs_alloc() and the
rhashtable path. Once all consumers are converted a follow-up patch
will remove the rbtree code.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/xattr.c            | 439 ++++++++++++++++++++++++++++++++++++++------------
 include/linux/xattr.h |  25 ++-
 mm/shmem.c            |   2 +-
 3 files changed, 357 insertions(+), 109 deletions(-)

diff --git a/fs/xattr.c b/fs/xattr.c
index 9cbb1917bcb2..1d98ea459b7b 100644
--- a/fs/xattr.c
+++ b/fs/xattr.c
@@ -22,6 +22,7 @@
 #include <linux/audit.h>
 #include <linux/vmalloc.h>
 #include <linux/posix_acl_xattr.h>
+#include <linux/rhashtable.h>
 
 #include <linux/uaccess.h>
 
@@ -1228,22 +1229,25 @@ void simple_xattr_free_rcu(struct simple_xattr *xattr)
  * Allocate a new xattr object and initialize respective members. The caller is
  * responsible for handling the name of the xattr.
  *
- * Return: On success a new xattr object is returned. On failure NULL is
- * returned.
+ * Return: New xattr object on success, NULL if @value is NULL, ERR_PTR on
+ * failure.
  */
 struct simple_xattr *simple_xattr_alloc(const void *value, size_t size)
 {
 	struct simple_xattr *new_xattr;
 	size_t len;
 
+	if (!value)
+		return NULL;
+
 	/* wrap around? */
 	len = sizeof(*new_xattr) + size;
 	if (len < sizeof(*new_xattr))
-		return NULL;
+		return ERR_PTR(-ENOMEM);
 
 	new_xattr = kvmalloc(len, GFP_KERNEL_ACCOUNT);
 	if (!new_xattr)
-		return NULL;
+		return ERR_PTR(-ENOMEM);
 
 	new_xattr->size = size;
 	memcpy(new_xattr->value, value, size);
@@ -1287,6 +1291,33 @@ static int rbtree_simple_xattr_node_cmp(struct rb_node *new_node,
 	return rbtree_simple_xattr_cmp(xattr->name, node);
 }
 
+static u32 simple_xattr_hashfn(const void *data, u32 len, u32 seed)
+{
+	const char *name = data;
+	return jhash(name, strlen(name), seed);
+}
+
+static u32 simple_xattr_obj_hashfn(const void *obj, u32 len, u32 seed)
+{
+	const struct simple_xattr *xattr = obj;
+	return jhash(xattr->name, strlen(xattr->name), seed);
+}
+
+static int simple_xattr_obj_cmpfn(struct rhashtable_compare_arg *arg,
+				   const void *obj)
+{
+	const struct simple_xattr *xattr = obj;
+	return strcmp(xattr->name, arg->key);
+}
+
+static const struct rhashtable_params simple_xattr_params = {
+	.head_offset    = offsetof(struct simple_xattr, hash_node),
+	.hashfn         = simple_xattr_hashfn,
+	.obj_hashfn     = simple_xattr_obj_hashfn,
+	.obj_cmpfn      = simple_xattr_obj_cmpfn,
+	.automatic_shrinking = true,
+};
+
 /**
  * simple_xattr_get - get an xattr object
  * @xattrs: the header of the xattr object
@@ -1306,22 +1337,41 @@ int simple_xattr_get(struct simple_xattrs *xattrs, const char *name,
 		     void *buffer, size_t size)
 {
 	struct simple_xattr *xattr = NULL;
-	struct rb_node *rbp;
 	int ret = -ENODATA;
 
-	read_lock(&xattrs->lock);
-	rbp = rb_find(name, &xattrs->rb_root, rbtree_simple_xattr_cmp);
-	if (rbp) {
-		xattr = rb_entry(rbp, struct simple_xattr, rb_node);
-		ret = xattr->size;
-		if (buffer) {
-			if (size < xattr->size)
-				ret = -ERANGE;
-			else
-				memcpy(buffer, xattr->value, xattr->size);
+	if (xattrs->use_rhashtable) {
+		guard(rcu)();
+		xattr = rhashtable_lookup(&xattrs->ht, name,
+					  simple_xattr_params);
+		if (xattr) {
+			ret = xattr->size;
+			if (buffer) {
+				if (size < xattr->size)
+					ret = -ERANGE;
+				else
+					memcpy(buffer, xattr->value,
+					       xattr->size);
+			}
+		}
+	} else {
+		struct rb_node *rbp;
+
+		read_lock(&xattrs->lock);
+		rbp = rb_find(name, &xattrs->rb_root,
+			      rbtree_simple_xattr_cmp);
+		if (rbp) {
+			xattr = rb_entry(rbp, struct simple_xattr, rb_node);
+			ret = xattr->size;
+			if (buffer) {
+				if (size < xattr->size)
+					ret = -ERANGE;
+				else
+					memcpy(buffer, xattr->value,
+					       xattr->size);
+			}
 		}
+		read_unlock(&xattrs->lock);
 	}
-	read_unlock(&xattrs->lock);
 	return ret;
 }
 
@@ -1355,78 +1405,134 @@ struct simple_xattr *simple_xattr_set(struct simple_xattrs *xattrs,
 				      const char *name, const void *value,
 				      size_t size, int flags)
 {
-	struct simple_xattr *old_xattr = NULL, *new_xattr = NULL;
-	struct rb_node *parent = NULL, **rbp;
-	int err = 0, ret;
+	struct simple_xattr *old_xattr = NULL;
+	int err = 0;
 
-	/* value == NULL means remove */
-	if (value) {
-		new_xattr = simple_xattr_alloc(value, size);
-		if (!new_xattr)
-			return ERR_PTR(-ENOMEM);
+	CLASS(simple_xattr, new_xattr)(value, size);
+	if (IS_ERR(new_xattr))
+		return new_xattr;
 
+	if (new_xattr) {
 		new_xattr->name = kstrdup(name, GFP_KERNEL_ACCOUNT);
-		if (!new_xattr->name) {
-			simple_xattr_free(new_xattr);
+		if (!new_xattr->name)
 			return ERR_PTR(-ENOMEM);
-		}
 	}
 
-	write_lock(&xattrs->lock);
-	rbp = &xattrs->rb_root.rb_node;
-	while (*rbp) {
-		parent = *rbp;
-		ret = rbtree_simple_xattr_cmp(name, *rbp);
-		if (ret < 0)
-			rbp = &(*rbp)->rb_left;
-		else if (ret > 0)
-			rbp = &(*rbp)->rb_right;
-		else
-			old_xattr = rb_entry(*rbp, struct simple_xattr, rb_node);
-		if (old_xattr)
-			break;
-	}
+	if (xattrs->use_rhashtable) {
+		/*
+		 * Lookup is safe without RCU here since writes are
+		 * serialized by the caller.
+		 */
+		old_xattr = rhashtable_lookup_fast(&xattrs->ht, name,
+						   simple_xattr_params);
+
+		if (old_xattr) {
+			/* Fail if XATTR_CREATE is requested and the xattr exists. */
+			if (flags & XATTR_CREATE)
+				return ERR_PTR(-EEXIST);
+
+			if (new_xattr) {
+				err = rhashtable_replace_fast(&xattrs->ht,
+							     &old_xattr->hash_node,
+							     &new_xattr->hash_node,
+							     simple_xattr_params);
+				if (err)
+					return ERR_PTR(err);
+			} else {
+				err = rhashtable_remove_fast(&xattrs->ht,
+							    &old_xattr->hash_node,
+							    simple_xattr_params);
+				if (err)
+					return ERR_PTR(err);
+			}
+		} else {
+			/* Fail if XATTR_REPLACE is requested but no xattr is found. */
+			if (flags & XATTR_REPLACE)
+				return ERR_PTR(-ENODATA);
+
+			/*
+			 * If XATTR_CREATE or no flags are specified together
+			 * with a new value simply insert it.
+			 */
+			if (new_xattr) {
+				err = rhashtable_insert_fast(&xattrs->ht,
+							    &new_xattr->hash_node,
+							    simple_xattr_params);
+				if (err)
+					return ERR_PTR(err);
+			}
 
-	if (old_xattr) {
-		/* Fail if XATTR_CREATE is requested and the xattr exists. */
-		if (flags & XATTR_CREATE) {
-			err = -EEXIST;
-			goto out_unlock;
+			/*
+			 * If XATTR_CREATE or no flags are specified and
+			 * neither an old or new xattr exist then we don't
+			 * need to do anything.
+			 */
 		}
-
-		if (new_xattr)
-			rb_replace_node(&old_xattr->rb_node,
-					&new_xattr->rb_node, &xattrs->rb_root);
-		else
-			rb_erase(&old_xattr->rb_node, &xattrs->rb_root);
 	} else {
-		/* Fail if XATTR_REPLACE is requested but no xattr is found. */
-		if (flags & XATTR_REPLACE) {
-			err = -ENODATA;
-			goto out_unlock;
-		}
+		struct rb_node *parent = NULL, **rbp;
+		int ret;
 
-		/*
-		 * If XATTR_CREATE or no flags are specified together with a
-		 * new value simply insert it.
-		 */
-		if (new_xattr) {
-			rb_link_node(&new_xattr->rb_node, parent, rbp);
-			rb_insert_color(&new_xattr->rb_node, &xattrs->rb_root);
+		write_lock(&xattrs->lock);
+		rbp = &xattrs->rb_root.rb_node;
+		while (*rbp) {
+			parent = *rbp;
+			ret = rbtree_simple_xattr_cmp(name, *rbp);
+			if (ret < 0)
+				rbp = &(*rbp)->rb_left;
+			else if (ret > 0)
+				rbp = &(*rbp)->rb_right;
+			else
+				old_xattr = rb_entry(*rbp, struct simple_xattr,
+						     rb_node);
+			if (old_xattr)
+				break;
 		}
 
-		/*
-		 * If XATTR_CREATE or no flags are specified and neither an
-		 * old or new xattr exist then we don't need to do anything.
-		 */
-	}
+		if (old_xattr) {
+			/* Fail if XATTR_CREATE is requested and the xattr exists. */
+			if (flags & XATTR_CREATE) {
+				err = -EEXIST;
+				goto out_unlock;
+			}
+
+			if (new_xattr)
+				rb_replace_node(&old_xattr->rb_node,
+						&new_xattr->rb_node,
+						&xattrs->rb_root);
+			else
+				rb_erase(&old_xattr->rb_node,
+					 &xattrs->rb_root);
+		} else {
+			/* Fail if XATTR_REPLACE is requested but no xattr is found. */
+			if (flags & XATTR_REPLACE) {
+				err = -ENODATA;
+				goto out_unlock;
+			}
+
+			/*
+			 * If XATTR_CREATE or no flags are specified together
+			 * with a new value simply insert it.
+			 */
+			if (new_xattr) {
+				rb_link_node(&new_xattr->rb_node, parent, rbp);
+				rb_insert_color(&new_xattr->rb_node,
+						&xattrs->rb_root);
+			}
+
+			/*
+			 * If XATTR_CREATE or no flags are specified and
+			 * neither an old or new xattr exist then we don't
+			 * need to do anything.
+			 */
+		}
 
 out_unlock:
-	write_unlock(&xattrs->lock);
-	if (!err)
-		return old_xattr;
-	simple_xattr_free(new_xattr);
-	return ERR_PTR(err);
+		write_unlock(&xattrs->lock);
+		if (err)
+			return ERR_PTR(err);
+	}
+	retain_and_null_ptr(new_xattr);
+	return old_xattr;
 }
 
 static bool xattr_is_trusted(const char *name)
@@ -1467,7 +1573,6 @@ ssize_t simple_xattr_list(struct inode *inode, struct simple_xattrs *xattrs,
 {
 	bool trusted = ns_capable_noaudit(&init_user_ns, CAP_SYS_ADMIN);
 	struct simple_xattr *xattr;
-	struct rb_node *rbp;
 	ssize_t remaining_size = size;
 	int err = 0;
 
@@ -1487,23 +1592,62 @@ ssize_t simple_xattr_list(struct inode *inode, struct simple_xattrs *xattrs,
 	remaining_size -= err;
 	err = 0;
 
-	read_lock(&xattrs->lock);
-	for (rbp = rb_first(&xattrs->rb_root); rbp; rbp = rb_next(rbp)) {
-		xattr = rb_entry(rbp, struct simple_xattr, rb_node);
+	if (!xattrs)
+		return size - remaining_size;
 
-		/* skip "trusted." attributes for unprivileged callers */
-		if (!trusted && xattr_is_trusted(xattr->name))
-			continue;
+	if (xattrs->use_rhashtable) {
+		struct rhashtable_iter iter;
 
-		/* skip MAC labels; these are provided by LSM above */
-		if (xattr_is_maclabel(xattr->name))
-			continue;
+		rhashtable_walk_enter(&xattrs->ht, &iter);
+		rhashtable_walk_start(&iter);
 
-		err = xattr_list_one(&buffer, &remaining_size, xattr->name);
-		if (err)
-			break;
+		while ((xattr = rhashtable_walk_next(&iter)) != NULL) {
+			if (IS_ERR(xattr)) {
+				if (PTR_ERR(xattr) == -EAGAIN)
+					continue;
+				err = PTR_ERR(xattr);
+				break;
+			}
+
+			/* skip "trusted." attributes for unprivileged callers */
+			if (!trusted && xattr_is_trusted(xattr->name))
+				continue;
+
+			/* skip MAC labels; these are provided by LSM above */
+			if (xattr_is_maclabel(xattr->name))
+				continue;
+
+			err = xattr_list_one(&buffer, &remaining_size,
+					     xattr->name);
+			if (err)
+				break;
+		}
+
+		rhashtable_walk_stop(&iter);
+		rhashtable_walk_exit(&iter);
+	} else {
+		struct rb_node *rbp;
+
+		read_lock(&xattrs->lock);
+		for (rbp = rb_first(&xattrs->rb_root); rbp;
+		     rbp = rb_next(rbp)) {
+			xattr = rb_entry(rbp, struct simple_xattr, rb_node);
+
+			/* skip "trusted." attributes for unprivileged callers */
+			if (!trusted && xattr_is_trusted(xattr->name))
+				continue;
+
+			/* skip MAC labels; these are provided by LSM above */
+			if (xattr_is_maclabel(xattr->name))
+				continue;
+
+			err = xattr_list_one(&buffer, &remaining_size,
+					     xattr->name);
+			if (err)
+				break;
+		}
+		read_unlock(&xattrs->lock);
 	}
-	read_unlock(&xattrs->lock);
 
 	return err ? err : size - remaining_size;
 }
@@ -1536,9 +1680,16 @@ static bool rbtree_simple_xattr_less(struct rb_node *new_node,
 void simple_xattr_add(struct simple_xattrs *xattrs,
 		      struct simple_xattr *new_xattr)
 {
-	write_lock(&xattrs->lock);
-	rb_add(&new_xattr->rb_node, &xattrs->rb_root, rbtree_simple_xattr_less);
-	write_unlock(&xattrs->lock);
+	if (xattrs->use_rhashtable) {
+		WARN_ON(rhashtable_insert_fast(&xattrs->ht,
+					       &new_xattr->hash_node,
+					       simple_xattr_params));
+	} else {
+		write_lock(&xattrs->lock);
+		rb_add(&new_xattr->rb_node, &xattrs->rb_root,
+		       rbtree_simple_xattr_less);
+		write_unlock(&xattrs->lock);
+	}
 }
 
 /**
@@ -1549,10 +1700,80 @@ void simple_xattr_add(struct simple_xattrs *xattrs,
  */
 void simple_xattrs_init(struct simple_xattrs *xattrs)
 {
+	xattrs->use_rhashtable = false;
 	xattrs->rb_root = RB_ROOT;
 	rwlock_init(&xattrs->lock);
 }
 
+/**
+ * simple_xattrs_alloc - allocate and initialize a new xattr header
+ *
+ * Dynamically allocate a simple_xattrs header and initialize the
+ * underlying rhashtable. This is intended for consumers that want
+ * rhashtable-based xattr storage.
+ *
+ * Return: On success a new simple_xattrs is returned. On failure an
+ * ERR_PTR is returned.
+ */
+struct simple_xattrs *simple_xattrs_alloc(void)
+{
+	struct simple_xattrs *xattrs __free(kfree) = NULL;
+
+	xattrs = kzalloc(sizeof(*xattrs), GFP_KERNEL);
+	if (!xattrs)
+		return ERR_PTR(-ENOMEM);
+
+	xattrs->use_rhashtable = true;
+	if (rhashtable_init(&xattrs->ht, &simple_xattr_params))
+		return ERR_PTR(-ENOMEM);
+
+	return no_free_ptr(xattrs);
+}
+
+/**
+ * simple_xattrs_lazy_alloc - get or allocate xattrs for a set operation
+ * @xattrsp: pointer to the xattrs pointer (may point to NULL)
+ * @value: value being set (NULL means remove)
+ * @flags: xattr set flags
+ *
+ * For lazily-allocated xattrs on the write path. If no xattrs exist yet
+ * and this is a remove operation, returns the appropriate result without
+ * allocating. Otherwise ensures xattrs is allocated and published with
+ * store-release semantics.
+ *
+ * Return: On success a valid pointer to the xattrs is returned. On
+ * failure or early-exit an ERR_PTR or NULL is returned. Callers should
+ * check with IS_ERR_OR_NULL() and propagate with PTR_ERR() which
+ * correctly returns 0 for the NULL no-op case.
+ */
+struct simple_xattrs *simple_xattrs_lazy_alloc(struct simple_xattrs **xattrsp,
+					       const void *value, int flags)
+{
+	struct simple_xattrs *xattrs;
+
+	xattrs = READ_ONCE(*xattrsp);
+	if (xattrs)
+		return xattrs;
+
+	if (!value)
+		return (flags & XATTR_REPLACE) ? ERR_PTR(-ENODATA) : NULL;
+
+	xattrs = simple_xattrs_alloc();
+	if (!IS_ERR(xattrs))
+		smp_store_release(xattrsp, xattrs);
+	return xattrs;
+}
+
+static void simple_xattr_ht_free(void *ptr, void *arg)
+{
+	struct simple_xattr *xattr = ptr;
+	size_t *freed_space = arg;
+
+	if (freed_space)
+		*freed_space += simple_xattr_space(xattr->name, xattr->size);
+	simple_xattr_free(xattr);
+}
+
 /**
  * simple_xattrs_free - free xattrs
  * @xattrs: xattr header whose xattrs to destroy
@@ -1563,22 +1784,28 @@ void simple_xattrs_init(struct simple_xattrs *xattrs)
  */
 void simple_xattrs_free(struct simple_xattrs *xattrs, size_t *freed_space)
 {
-	struct rb_node *rbp;
-
 	if (freed_space)
 		*freed_space = 0;
-	rbp = rb_first(&xattrs->rb_root);
-	while (rbp) {
-		struct simple_xattr *xattr;
-		struct rb_node *rbp_next;
-
-		rbp_next = rb_next(rbp);
-		xattr = rb_entry(rbp, struct simple_xattr, rb_node);
-		rb_erase(&xattr->rb_node, &xattrs->rb_root);
-		if (freed_space)
-			*freed_space += simple_xattr_space(xattr->name,
-							   xattr->size);
-		simple_xattr_free(xattr);
-		rbp = rbp_next;
+
+	if (xattrs->use_rhashtable) {
+		rhashtable_free_and_destroy(&xattrs->ht,
+					    simple_xattr_ht_free, freed_space);
+	} else {
+		struct rb_node *rbp;
+
+		rbp = rb_first(&xattrs->rb_root);
+		while (rbp) {
+			struct simple_xattr *xattr;
+			struct rb_node *rbp_next;
+
+			rbp_next = rb_next(rbp);
+			xattr = rb_entry(rbp, struct simple_xattr, rb_node);
+			rb_erase(&xattr->rb_node, &xattrs->rb_root);
+			if (freed_space)
+				*freed_space += simple_xattr_space(xattr->name,
+								   xattr->size);
+			simple_xattr_free(xattr);
+			rbp = rbp_next;
+		}
 	}
 }
diff --git a/include/linux/xattr.h b/include/linux/xattr.h
index 1328f2bfd2ce..ee4fd40717a0 100644
--- a/include/linux/xattr.h
+++ b/include/linux/xattr.h
@@ -107,8 +107,14 @@ static inline const char *xattr_prefix(const struct xattr_handler *handler)
 }
 
 struct simple_xattrs {
-	struct rb_root rb_root;
-	rwlock_t lock;
+	bool use_rhashtable;
+	union {
+		struct {
+			struct rb_root rb_root;
+			rwlock_t lock;
+		};
+		struct rhashtable ht;
+	};
 };
 
 struct simple_xattr {
@@ -121,6 +127,9 @@ struct simple_xattr {
 };
 
 void simple_xattrs_init(struct simple_xattrs *xattrs);
+struct simple_xattrs *simple_xattrs_alloc(void);
+struct simple_xattrs *simple_xattrs_lazy_alloc(struct simple_xattrs **xattrsp,
+					       const void *value, int flags);
 void simple_xattrs_free(struct simple_xattrs *xattrs, size_t *freed_space);
 size_t simple_xattr_space(const char *name, size_t size);
 struct simple_xattr *simple_xattr_alloc(const void *value, size_t size);
@@ -137,4 +146,16 @@ void simple_xattr_add(struct simple_xattrs *xattrs,
 		      struct simple_xattr *new_xattr);
 int xattr_list_one(char **buffer, ssize_t *remaining_size, const char *name);
 
+DEFINE_CLASS(simple_xattr,
+	     struct simple_xattr *,
+	     if (!IS_ERR_OR_NULL(_T)) simple_xattr_free(_T),
+	     simple_xattr_alloc(value, size),
+	     const void *value, size_t size)
+
+DEFINE_CLASS(simple_xattrs,
+            struct simple_xattrs *,
+            if (!IS_ERR_OR_NULL(_T)) { simple_xattrs_free(_T, NULL); kfree(_T); },
+            simple_xattrs_alloc(),
+            void)
+
 #endif	/* _LINUX_XATTR_H */
diff --git a/mm/shmem.c b/mm/shmem.c
index 063b4c3e4ccb..fc8020ce2e9f 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -4293,7 +4293,7 @@ static int shmem_initxattrs(struct inode *inode,
 
 	for (xattr = xattr_array; xattr->name != NULL; xattr++) {
 		new_xattr = simple_xattr_alloc(xattr->value, xattr->value_len);
-		if (!new_xattr)
+		if (IS_ERR(new_xattr))
 			break;
 
 		len = strlen(xattr->name) + 1;

-- 
2.47.3


