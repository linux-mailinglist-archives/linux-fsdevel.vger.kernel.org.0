Return-Path: <linux-fsdevel+bounces-57804-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 755B3B256BC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 00:39:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 824035C18BB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 22:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C16F2E7BD4;
	Wed, 13 Aug 2025 22:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="gD5O/oxm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D985A2FCBFF;
	Wed, 13 Aug 2025 22:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755124654; cv=none; b=RxID4N6ChPXSaSkXQuvwQE3XMGQDKGzCzbTolE0no9KIBziFZp68S8w9uDV/n5/HMQPRBuJZEJ0KJRcSqm65rvW9ASX9ROLoxIUzM8IXEXYq/839KmI7HWvec47aakz/RXKNgXSojbf+b5RnjxjjyjOVUEuF0+CL7d0x9r7QocY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755124654; c=relaxed/simple;
	bh=Hb8mvnH4oLQbKWLvZfLzzY5YJgCvX09PrP1eas9DlZo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Z4uhDtcRLJc9pvsRW0hMQ5Xho3mMKuv5BIHxQfAZ4EOpscC6K99mwqn2YiRbNAEtQ1cGI+MNtLgnlCdkwbcVHJe6WNH6s4vsOxK8kzuQn++tKlhKRW69JY50APdtJX1zrRp+TcDfbuVK9zZa7kVOTWYOqVa88Y43l/ce5n7UtXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=gD5O/oxm; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=VL+hZ46Bo0Dn9yVg0LiE2QipTWtBE8YKD5d9XgnUTI8=; b=gD5O/oxmuK4uacEJIEnBlojAY9
	zFWu9zVmCwfum0ByCA8ACqZD/FqnLojrOLrs5N5awlqRRxoBRmXUOcWyL54i2jEMaF4LCCjNhNa7n
	mqgPkeJyBhA439R69sucf21dTNnKE7H0KP0M/8xjvv6shg40xaRHKOX6veCuoJXLr3x1G9IksyWaO
	uA4lUcz0ZTBODNy06mjXzolmQw5cVwU2y4wLt8WKZJCjCLbYXGzo9dfiGCgbDn8SYUmZ4FP6hgzwG
	ohxiTQ+3LXaS+AoJ5ULupVdCcyW0MXXOh0Mq+p18xYOsctDBjyaq+lRBLziIkqe4/tGVmKuGBopZy
	vY+GnGjQ==;
Received: from [152.250.7.37] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1umK63-00Ds0c-Cp; Thu, 14 Aug 2025 00:37:27 +0200
From: =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Date: Wed, 13 Aug 2025 19:36:39 -0300
Subject: [PATCH v4 3/9] ovl: Create ovl_casefold() to support casefolded
 strncmp()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250813-tonyk-overlayfs-v4-3-357ccf2e12ad@igalia.com>
References: <20250813-tonyk-overlayfs-v4-0-357ccf2e12ad@igalia.com>
In-Reply-To: <20250813-tonyk-overlayfs-v4-0-357ccf2e12ad@igalia.com>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>, 
 Theodore Tso <tytso@mit.edu>, Gabriel Krisman Bertazi <krisman@kernel.org>
Cc: linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 kernel-dev@igalia.com, 
 =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
X-Mailer: b4 0.14.2

To add overlayfs support casefold filesystems, create a new function
ovl_casefold(), to be able to do case-insensitive strncmp().

ovl_casefold() allocates a new buffer and stores the casefolded version
of the string on it. If the allocation or the casefold operation fails,
fallback to use the original string.

The case-insentive name is then used in the rb-tree search/insertion
operation. If the name is found in the rb-tree, the name can be
discarded and the buffer is freed. If the name isn't found, it's then
stored at struct ovl_cache_entry to be used later.

Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
Changes from v3:
 - Improve commit message text
 - s/OVL_NAME_LEN/NAME_MAX
 - drop #ifdef in favor of if(IS_ENABLED)
 - use new helper sb_encoding
 - merged patch "Store casefold name..." and "Create ovl_casefold()..."
 - Guard all the casefolding inside of IS_ENABLED(UNICODE)

Changes from v2:
- Refactor the patch to do a single kmalloc() per rb_tree operation
- Instead of casefolding the cache entry name everytime per strncmp(),
  casefold it once and reuse it for every strncmp().
---
 fs/overlayfs/readdir.c | 99 ++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 87 insertions(+), 12 deletions(-)

diff --git a/fs/overlayfs/readdir.c b/fs/overlayfs/readdir.c
index b65cdfce31ce27172d28d879559f1008b9c87320..3d92c0b407fe355053ca80ef999d3520eb7d2462 100644
--- a/fs/overlayfs/readdir.c
+++ b/fs/overlayfs/readdir.c
@@ -27,6 +27,8 @@ struct ovl_cache_entry {
 	bool is_upper;
 	bool is_whiteout;
 	bool check_xwhiteout;
+	const char *cf_name;
+	int cf_len;
 	char name[];
 };
 
@@ -45,6 +47,7 @@ struct ovl_readdir_data {
 	struct list_head *list;
 	struct list_head middle;
 	struct ovl_cache_entry *first_maybe_whiteout;
+	struct unicode_map *map;
 	int count;
 	int err;
 	bool is_upper;
@@ -66,6 +69,27 @@ static struct ovl_cache_entry *ovl_cache_entry_from_node(struct rb_node *n)
 	return rb_entry(n, struct ovl_cache_entry, node);
 }
 
+static int ovl_casefold(struct unicode_map *map, const char *str, int len, char **dst)
+{
+	const struct qstr qstr = { .name = str, .len = len };
+	int cf_len;
+
+	if (!IS_ENABLED(CONFIG_UNICODE) || !map || is_dot_dotdot(str, len))
+		return 0;
+
+	*dst = kmalloc(NAME_MAX, GFP_KERNEL);
+
+	if (dst) {
+		cf_len = utf8_casefold(map, &qstr, *dst, NAME_MAX);
+
+		if (cf_len > 0)
+			return cf_len;
+	}
+
+	kfree(*dst);
+	return 0;
+}
+
 static bool ovl_cache_entry_find_link(const char *name, int len,
 				      struct rb_node ***link,
 				      struct rb_node **parent)
@@ -79,7 +103,7 @@ static bool ovl_cache_entry_find_link(const char *name, int len,
 
 		*parent = *newp;
 		tmp = ovl_cache_entry_from_node(*newp);
-		cmp = strncmp(name, tmp->name, len);
+		cmp = strncmp(name, tmp->cf_name, tmp->cf_len);
 		if (cmp > 0)
 			newp = &tmp->node.rb_right;
 		else if (cmp < 0 || len < tmp->len)
@@ -101,7 +125,7 @@ static struct ovl_cache_entry *ovl_cache_entry_find(struct rb_root *root,
 	while (node) {
 		struct ovl_cache_entry *p = ovl_cache_entry_from_node(node);
 
-		cmp = strncmp(name, p->name, len);
+		cmp = strncmp(name, p->cf_name, p->cf_len);
 		if (cmp > 0)
 			node = p->node.rb_right;
 		else if (cmp < 0 || len < p->len)
@@ -145,13 +169,16 @@ static bool ovl_calc_d_ino(struct ovl_readdir_data *rdd,
 
 static struct ovl_cache_entry *ovl_cache_entry_new(struct ovl_readdir_data *rdd,
 						   const char *name, int len,
+						   const char *cf_name, int cf_len,
 						   u64 ino, unsigned int d_type)
 {
 	struct ovl_cache_entry *p;
 
 	p = kmalloc(struct_size(p, name, len + 1), GFP_KERNEL);
-	if (!p)
+	if (!p) {
+		kfree(cf_name);
 		return NULL;
+	}
 
 	memcpy(p->name, name, len);
 	p->name[len] = '\0';
@@ -167,6 +194,14 @@ static struct ovl_cache_entry *ovl_cache_entry_new(struct ovl_readdir_data *rdd,
 	/* Defer check for overlay.whiteout to ovl_iterate() */
 	p->check_xwhiteout = rdd->in_xwhiteouts_dir && d_type == DT_REG;
 
+	if (cf_name && cf_name != name) {
+		p->cf_name = cf_name;
+		p->cf_len = cf_len;
+	} else {
+		p->cf_name = p->name;
+		p->cf_len = len;
+	}
+
 	if (d_type == DT_CHR) {
 		p->next_maybe_whiteout = rdd->first_maybe_whiteout;
 		rdd->first_maybe_whiteout = p;
@@ -175,17 +210,24 @@ static struct ovl_cache_entry *ovl_cache_entry_new(struct ovl_readdir_data *rdd,
 }
 
 static bool ovl_cache_entry_add_rb(struct ovl_readdir_data *rdd,
-				  const char *name, int len, u64 ino,
+				  const char *name, int len,
+				  const char *cf_name, int cf_len,
+				  u64 ino,
 				  unsigned int d_type)
 {
 	struct rb_node **newp = &rdd->root->rb_node;
 	struct rb_node *parent = NULL;
 	struct ovl_cache_entry *p;
 
-	if (ovl_cache_entry_find_link(name, len, &newp, &parent))
+	if (ovl_cache_entry_find_link(cf_name, cf_len, &newp, &parent)) {
+		if (cf_name != name) {
+			kfree(cf_name);
+			cf_name = NULL;
+		}
 		return true;
+	}
 
-	p = ovl_cache_entry_new(rdd, name, len, ino, d_type);
+	p = ovl_cache_entry_new(rdd, name, len, cf_name, cf_len, ino, d_type);
 	if (p == NULL) {
 		rdd->err = -ENOMEM;
 		return false;
@@ -200,15 +242,21 @@ static bool ovl_cache_entry_add_rb(struct ovl_readdir_data *rdd,
 
 static bool ovl_fill_lowest(struct ovl_readdir_data *rdd,
 			   const char *name, int namelen,
+			   const char *cf_name, int cf_len,
 			   loff_t offset, u64 ino, unsigned int d_type)
 {
 	struct ovl_cache_entry *p;
 
-	p = ovl_cache_entry_find(rdd->root, name, namelen);
+	p = ovl_cache_entry_find(rdd->root, cf_name, cf_len);
 	if (p) {
 		list_move_tail(&p->l_node, &rdd->middle);
+		if (cf_name != name) {
+			kfree(cf_name);
+			cf_name = NULL;
+		}
 	} else {
-		p = ovl_cache_entry_new(rdd, name, namelen, ino, d_type);
+		p = ovl_cache_entry_new(rdd, name, namelen, cf_name, cf_len,
+					ino, d_type);
 		if (p == NULL)
 			rdd->err = -ENOMEM;
 		else
@@ -223,8 +271,11 @@ void ovl_cache_free(struct list_head *list)
 	struct ovl_cache_entry *p;
 	struct ovl_cache_entry *n;
 
-	list_for_each_entry_safe(p, n, list, l_node)
+	list_for_each_entry_safe(p, n, list, l_node) {
+		if (p->cf_name != p->name)
+			kfree(p->cf_name);
 		kfree(p);
+	}
 
 	INIT_LIST_HEAD(list);
 }
@@ -260,12 +311,28 @@ static bool ovl_fill_merge(struct dir_context *ctx, const char *name,
 {
 	struct ovl_readdir_data *rdd =
 		container_of(ctx, struct ovl_readdir_data, ctx);
+	struct ovl_fs *ofs = OVL_FS(rdd->dentry->d_sb);
+	const char *aux = NULL;
+	char *cf_name = NULL;
+	int cf_len = 0;
+
+	if (ofs->casefold)
+		cf_len = ovl_casefold(rdd->map, name, namelen, &cf_name);
+
+	if (cf_len <= 0) {
+		aux = name;
+		cf_len = namelen;
+	} else {
+		aux = cf_name;
+	}
 
 	rdd->count++;
 	if (!rdd->is_lowest)
-		return ovl_cache_entry_add_rb(rdd, name, namelen, ino, d_type);
+		return ovl_cache_entry_add_rb(rdd, name, namelen, aux, cf_len,
+					      ino, d_type);
 	else
-		return ovl_fill_lowest(rdd, name, namelen, offset, ino, d_type);
+		return ovl_fill_lowest(rdd, name, namelen, aux, cf_len,
+				       offset, ino, d_type);
 }
 
 static int ovl_check_whiteouts(const struct path *path, struct ovl_readdir_data *rdd)
@@ -357,12 +424,18 @@ static int ovl_dir_read_merged(struct dentry *dentry, struct list_head *list,
 		.list = list,
 		.root = root,
 		.is_lowest = false,
+		.map = NULL,
 	};
 	int idx, next;
 	const struct ovl_layer *layer;
+	struct ovl_fs *ofs = OVL_FS(dentry->d_sb);
 
 	for (idx = 0; idx != -1; idx = next) {
 		next = ovl_path_next(idx, dentry, &realpath, &layer);
+
+		if (ofs->casefold)
+			rdd.map = sb_encoding(realpath.dentry->d_sb);
+
 		rdd.is_upper = ovl_dentry_upper(dentry) == realpath.dentry;
 		rdd.in_xwhiteouts_dir = layer->has_xwhiteouts &&
 					ovl_dentry_has_xwhiteouts(dentry);
@@ -555,7 +628,7 @@ static bool ovl_fill_plain(struct dir_context *ctx, const char *name,
 		container_of(ctx, struct ovl_readdir_data, ctx);
 
 	rdd->count++;
-	p = ovl_cache_entry_new(rdd, name, namelen, ino, d_type);
+	p = ovl_cache_entry_new(rdd, name, namelen, NULL, 0, ino, d_type);
 	if (p == NULL) {
 		rdd->err = -ENOMEM;
 		return false;
@@ -1023,6 +1096,8 @@ int ovl_check_empty_dir(struct dentry *dentry, struct list_head *list)
 
 del_entry:
 		list_del(&p->l_node);
+		if (p->cf_name != p->name)
+			kfree(p->cf_name);
 		kfree(p);
 	}
 

-- 
2.50.1


