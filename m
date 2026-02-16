Return-Path: <linux-fsdevel+bounces-77284-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iIchGtQdk2mM1gEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77284-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Feb 2026 14:38:28 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D764E143E71
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Feb 2026 14:38:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2C6F830AF4E1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Feb 2026 13:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CB98311C38;
	Mon, 16 Feb 2026 13:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V62U8/Qj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC6C311975;
	Mon, 16 Feb 2026 13:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771248771; cv=none; b=BG6TTj+nL9c+FS8v5m66UGDYLBQBAe/+RTXr1pXRTqbV+hZM64j3vvW73QjaD+wrgZxPxM1YjZE63shVWUViwY3Z98xGZbRvGtCmSx2DF8w1Fe+RuyuHLQEpxIlduhRyJLGGaIZkKaWcbuBF76BnTtVhdIMvKHUInjU3cyHYd+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771248771; c=relaxed/simple;
	bh=JWJ0LlOygERvwjt59MZEWYplPXeoWPP4MOafVL9EkMk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UcnSSL426GFSK5PoZ0J/vBvH6XsO0Cc9qzNlKX4r9Ltg+JUkgja3Nvau0j38QFZWmIV0VKukzmGr04//Zy0cLyIfINLMDnJZwipEtRBmuDVfttzVKh9Tm8d+TBW6LPQFbK002gXBmcxSnQEeJhaul2mnshAH1VLaNb+/ILXcPDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V62U8/Qj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94854C19424;
	Mon, 16 Feb 2026 13:32:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771248771;
	bh=JWJ0LlOygERvwjt59MZEWYplPXeoWPP4MOafVL9EkMk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=V62U8/QjirJ13wSb8V/oo5CuvZaDH10OxO/5NKTeBt8+ZgOx20ElbtNIMbkAYJvjn
	 rMuuc1cB7NxEEk15DoZ2yphohhqy9IDgs/3We3S/wYXe1JzFZaA/i0wmFfrhfjqSJ9
	 IBhW16W+de+jyBIraagX92JCVMklOXJtu/UPSBUjjGdHfh410Z3qjOuhMg7rPHP8In
	 bJMdhSvBBoztlVWVwKt03VIT8OwFCpyAGwcrGyhZTU4V5OqTYsHzqe2rgxdTacA4CX
	 O/Cdowq/Rlpr331x1Q70nz1KiWVKPoWKNnF+rasICFNc5CDBdBdaYglUNVcLCf2NUJ
	 mCFAt2/n2CE8w==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 16 Feb 2026 14:32:05 +0100
Subject: [PATCH 09/14] xattr: move user limits for xattrs to generic infra
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260216-work-xattr-socket-v1-9-c2efa4f74cb7@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=8059; i=brauner@kernel.org;
 h=from:subject:message-id; bh=JWJ0LlOygERvwjt59MZEWYplPXeoWPP4MOafVL9EkMk=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWROlonTOp3LVHmeXSq9ZH9L4dZlfY+/PDvh8jdoxQxmQ
 VWXVbN2dJSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzE2IaR4VdxSfXvMw+a81ma
 FLO7H8hxC0/uXFu5v3T1ntIJV7L7zRgZ9v9KE4phuq96yljdndEmj8/jm13Pl7qq3+3f9hwsq1n
 OBQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77284-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D764E143E71
X-Rspamd-Action: no action

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/kernfs/inode.c           | 75 ++-------------------------------------------
 fs/kernfs/kernfs-internal.h |  3 +-
 fs/xattr.c                  | 65 +++++++++++++++++++++++++++++++++++++++
 include/linux/kernfs.h      |  2 --
 include/linux/xattr.h       | 18 +++++++++++
 5 files changed, 87 insertions(+), 76 deletions(-)

diff --git a/fs/kernfs/inode.c b/fs/kernfs/inode.c
index dfc3315b5afc..1de10500842d 100644
--- a/fs/kernfs/inode.c
+++ b/fs/kernfs/inode.c
@@ -45,8 +45,7 @@ static struct kernfs_iattrs *__kernfs_iattrs(struct kernfs_node *kn, bool alloc)
 	ret->ia_mtime = ret->ia_atime;
 	ret->ia_ctime = ret->ia_atime;
 
-	atomic_set(&ret->nr_user_xattrs, 0);
-	atomic_set(&ret->user_xattr_size, 0);
+	simple_xattr_limits_init(&ret->xattr_limits);
 
 	/* If someone raced us, recognize it. */
 	if (!try_cmpxchg(&kn->iattr, &attr, ret))
@@ -355,69 +354,6 @@ static int kernfs_vfs_xattr_set(const struct xattr_handler *handler,
 	return kernfs_xattr_set(kn, name, value, size, flags);
 }
 
-static int kernfs_vfs_user_xattr_add(struct kernfs_node *kn,
-				     const char *full_name,
-				     struct simple_xattrs *xattrs,
-				     const void *value, size_t size, int flags)
-{
-	struct kernfs_iattrs *attr = kernfs_iattrs_noalloc(kn);
-	atomic_t *sz = &attr->user_xattr_size;
-	atomic_t *nr = &attr->nr_user_xattrs;
-	struct simple_xattr *old_xattr;
-	int ret;
-
-	if (atomic_inc_return(nr) > KERNFS_MAX_USER_XATTRS) {
-		ret = -ENOSPC;
-		goto dec_count_out;
-	}
-
-	if (atomic_add_return(size, sz) > KERNFS_USER_XATTR_SIZE_LIMIT) {
-		ret = -ENOSPC;
-		goto dec_size_out;
-	}
-
-	old_xattr = simple_xattr_set(xattrs, full_name, value, size, flags);
-	if (!old_xattr)
-		return 0;
-
-	if (IS_ERR(old_xattr)) {
-		ret = PTR_ERR(old_xattr);
-		goto dec_size_out;
-	}
-
-	ret = 0;
-	size = old_xattr->size;
-	simple_xattr_free_rcu(old_xattr);
-dec_size_out:
-	atomic_sub(size, sz);
-dec_count_out:
-	atomic_dec(nr);
-	return ret;
-}
-
-static int kernfs_vfs_user_xattr_rm(struct kernfs_node *kn,
-				    const char *full_name,
-				    struct simple_xattrs *xattrs,
-				    const void *value, size_t size, int flags)
-{
-	struct kernfs_iattrs *attr = kernfs_iattrs_noalloc(kn);
-	atomic_t *sz = &attr->user_xattr_size;
-	atomic_t *nr = &attr->nr_user_xattrs;
-	struct simple_xattr *old_xattr;
-
-	old_xattr = simple_xattr_set(xattrs, full_name, value, size, flags);
-	if (!old_xattr)
-		return 0;
-
-	if (IS_ERR(old_xattr))
-		return PTR_ERR(old_xattr);
-
-	atomic_sub(old_xattr->size, sz);
-	atomic_dec(nr);
-	simple_xattr_free_rcu(old_xattr);
-	return 0;
-}
-
 static int kernfs_vfs_user_xattr_set(const struct xattr_handler *handler,
 				     struct mnt_idmap *idmap,
 				     struct dentry *unused, struct inode *inode,
@@ -440,13 +376,8 @@ static int kernfs_vfs_user_xattr_set(const struct xattr_handler *handler,
 	if (IS_ERR_OR_NULL(xattrs))
 		return PTR_ERR(xattrs);
 
-	if (value)
-		return kernfs_vfs_user_xattr_add(kn, full_name, xattrs,
-						 value, size, flags);
-	else
-		return kernfs_vfs_user_xattr_rm(kn, full_name, xattrs,
-						value, size, flags);
-
+	return simple_xattr_set_limited(xattrs, &attrs->xattr_limits,
+					full_name, value, size, flags);
 }
 
 static const struct xattr_handler kernfs_trusted_xattr_handler = {
diff --git a/fs/kernfs/kernfs-internal.h b/fs/kernfs/kernfs-internal.h
index 1324ed8c0661..1d3831e3a270 100644
--- a/fs/kernfs/kernfs-internal.h
+++ b/fs/kernfs/kernfs-internal.h
@@ -27,8 +27,7 @@ struct kernfs_iattrs {
 	struct timespec64	ia_ctime;
 
 	struct simple_xattrs	*xattrs;
-	atomic_t		nr_user_xattrs;
-	atomic_t		user_xattr_size;
+	struct simple_xattr_limits xattr_limits;
 };
 
 struct kernfs_root {
diff --git a/fs/xattr.c b/fs/xattr.c
index 328ed7558dfc..5e559b1c651f 100644
--- a/fs/xattr.c
+++ b/fs/xattr.c
@@ -1427,6 +1427,71 @@ struct simple_xattr *simple_xattr_set(struct simple_xattrs *xattrs,
 	return old_xattr;
 }
 
+static inline void simple_xattr_limits_dec(struct simple_xattr_limits *limits,
+					   size_t size)
+{
+	atomic_sub(size, &limits->xattr_size);
+	atomic_dec(&limits->nr_xattrs);
+}
+
+static inline int simple_xattr_limits_inc(struct simple_xattr_limits *limits,
+					  size_t size)
+{
+	if (atomic_inc_return(&limits->nr_xattrs) > SIMPLE_XATTR_MAX_NR) {
+		atomic_dec(&limits->nr_xattrs);
+		return -ENOSPC;
+	}
+
+	if (atomic_add_return(size, &limits->xattr_size) <= SIMPLE_XATTR_MAX_SIZE)
+		return 0;
+
+	simple_xattr_limits_dec(limits, size);
+	return -ENOSPC;
+}
+
+/**
+ * simple_xattr_set_limited - set an xattr with per-inode user.* limits
+ * @xattrs: the header of the xattr object
+ * @limits: per-inode limit counters for user.* xattrs
+ * @name: the name of the xattr to set or remove
+ * @value: the value to store (NULL to remove)
+ * @size: the size of @value
+ * @flags: XATTR_CREATE, XATTR_REPLACE, or 0
+ *
+ * Like simple_xattr_set(), but enforces per-inode count and total value size
+ * limits for user.* xattrs. Uses speculative pre-increment of the atomic
+ * counters to avoid races without requiring external locks.
+ *
+ * Return: On success zero is returned. On failure a negative error code is
+ * returned.
+ */
+int simple_xattr_set_limited(struct simple_xattrs *xattrs,
+			     struct simple_xattr_limits *limits,
+			     const char *name, const void *value,
+			     size_t size, int flags)
+{
+	struct simple_xattr *old_xattr;
+	int ret;
+
+	if (value) {
+		ret = simple_xattr_limits_inc(limits, size);
+		if (ret)
+			return ret;
+	}
+
+	old_xattr = simple_xattr_set(xattrs, name, value, size, flags);
+	if (IS_ERR(old_xattr)) {
+		if (value)
+			simple_xattr_limits_dec(limits, size);
+		return PTR_ERR(old_xattr);
+	}
+	if (old_xattr) {
+		simple_xattr_limits_dec(limits, old_xattr->size);
+		simple_xattr_free_rcu(old_xattr);
+	}
+	return 0;
+}
+
 static bool xattr_is_trusted(const char *name)
 {
 	return !strncmp(name, XATTR_TRUSTED_PREFIX, XATTR_TRUSTED_PREFIX_LEN);
diff --git a/include/linux/kernfs.h b/include/linux/kernfs.h
index b5a5f32fdfd1..d8f57f0af5e4 100644
--- a/include/linux/kernfs.h
+++ b/include/linux/kernfs.h
@@ -99,8 +99,6 @@ enum kernfs_node_type {
 
 #define KERNFS_TYPE_MASK		0x000f
 #define KERNFS_FLAG_MASK		~KERNFS_TYPE_MASK
-#define KERNFS_MAX_USER_XATTRS		128
-#define KERNFS_USER_XATTR_SIZE_LIMIT	(128 << 10)
 
 enum kernfs_node_flag {
 	KERNFS_ACTIVATED	= 0x0010,
diff --git a/include/linux/xattr.h b/include/linux/xattr.h
index f60357d9f938..90a43a117127 100644
--- a/include/linux/xattr.h
+++ b/include/linux/xattr.h
@@ -118,6 +118,20 @@ struct simple_xattr {
 	char value[];
 };
 
+#define SIMPLE_XATTR_MAX_NR		128
+#define SIMPLE_XATTR_MAX_SIZE		(128 << 10)
+
+struct simple_xattr_limits {
+	atomic_t	nr_xattrs;	/* current user.* xattr count */
+	atomic_t	xattr_size;	/* current total user.* value bytes */
+};
+
+static inline void simple_xattr_limits_init(struct simple_xattr_limits *limits)
+{
+	atomic_set(&limits->nr_xattrs, 0);
+	atomic_set(&limits->xattr_size, 0);
+}
+
 int simple_xattrs_init(struct simple_xattrs *xattrs);
 struct simple_xattrs *simple_xattrs_alloc(void);
 struct simple_xattrs *simple_xattrs_lazy_alloc(struct simple_xattrs **xattrsp,
@@ -132,6 +146,10 @@ int simple_xattr_get(struct simple_xattrs *xattrs, const char *name,
 struct simple_xattr *simple_xattr_set(struct simple_xattrs *xattrs,
 				      const char *name, const void *value,
 				      size_t size, int flags);
+int simple_xattr_set_limited(struct simple_xattrs *xattrs,
+			     struct simple_xattr_limits *limits,
+			     const char *name, const void *value,
+			     size_t size, int flags);
 ssize_t simple_xattr_list(struct inode *inode, struct simple_xattrs *xattrs,
 			  char *buffer, size_t size);
 int simple_xattr_add(struct simple_xattrs *xattrs,

-- 
2.47.3


