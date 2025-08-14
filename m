Return-Path: <linux-fsdevel+bounces-57935-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B1EAB26D97
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 19:26:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A7DC1885629
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 17:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E54EB305E0E;
	Thu, 14 Aug 2025 17:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="HcJp8o/Y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C000F30149E;
	Thu, 14 Aug 2025 17:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755192160; cv=none; b=hURI6jJgLoIEH1tsePdGAsgxmYLKXKdgczkDPOD6NK5f3ir1JmiPR3TI+gwh4Tmuq6pkM0Gid6jtzhiZjXIYPwpiWm7e1RCHivPQ74ZNY5phzIn/Ea/6lKR6Ei4M08/IhIDQMFjb6NYZPIuZYZUwDXDowY0QAIlkwKQVubYWy1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755192160; c=relaxed/simple;
	bh=M4TPYzZp4OdVlLGt/hFzuO36iWBf3nEMvUFomb7pdcs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bJssi8t/e1nZd05QzWMqMZK/pRtzSKg6KYSWmHsBP6ARWlBn3W5TnwgFvPsl6FJwGKO29RRZkQqw9RwLzASBH/4NmSqTvoSuXKTFypgyYegDxyYmjL5ixh3nTFzhzIxZ2bK3xFA4DnwvfBULJ1c7z7rGfMZ5j6RxehtjiIclx9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=HcJp8o/Y; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=0TSM6wiN7+0xaf/TZVXiizqDgESUpJS6CI+RSwry49o=; b=HcJp8o/YbCUw0CdWC09kAiTC9e
	i5PvwTp5l3qGbvC4kthp7K0crSZ7FFJFe3xsyj7slHbj8DH3vgEfA5BZpV28DWZT4COuVFvUs1zAm
	uvP2gZ8sgMq6eJjickHAtQZthf6AZeHU4FHRkFN4SAK/1BVfm/3Icn5PQLHrlf7CFuRYdQ2nGtfzK
	ewkWK0XtjQlKue7LTmXjzKO9oGpejgiIXTjg2l3Sx3Uyn3kYtofkbJnxLdjOUzeOi9QLB2X3SLULc
	hIng7+kfhTWqpXBgiuZQyGhvafmsZ+wT5HruqJi9gPzdFsUgfuE4qB4gDpwjYo9pDsezuRmVTT5Po
	9znPsM6A==;
Received: from [152.250.7.37] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1umbeq-00EDyT-UG; Thu, 14 Aug 2025 19:22:33 +0200
From: =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Date: Thu, 14 Aug 2025 14:22:15 -0300
Subject: [PATCH v5 4/9] ovl: Create ovl_casefold() to support casefolded
 strncmp()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250814-tonyk-overlayfs-v5-4-c5b80a909cbd@igalia.com>
References: <20250814-tonyk-overlayfs-v5-0-c5b80a909cbd@igalia.com>
In-Reply-To: <20250814-tonyk-overlayfs-v5-0-c5b80a909cbd@igalia.com>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>, 
 Theodore Tso <tytso@mit.edu>, Gabriel Krisman Bertazi <krisman@kernel.org>
Cc: linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 kernel-dev@igalia.com, 
 =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
X-Mailer: b4 0.14.2

To add overlayfs support casefold layers, create a new function
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
Changes from v4:
 - Move the consumer/free buffer logic out to the caller
 - s/aux/c_name

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
 fs/overlayfs/readdir.c | 115 +++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 97 insertions(+), 18 deletions(-)

diff --git a/fs/overlayfs/readdir.c b/fs/overlayfs/readdir.c
index b65cdfce31ce27172d28d879559f1008b9c87320..803ac6a7516d0156ae7793ee1ff884dbbf2e20b0 100644
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
@@ -174,48 +209,55 @@ static struct ovl_cache_entry *ovl_cache_entry_new(struct ovl_readdir_data *rdd,
 	return p;
 }
 
-static bool ovl_cache_entry_add_rb(struct ovl_readdir_data *rdd,
-				  const char *name, int len, u64 ino,
+/* Return 0 for found, 1 for added, <0 for error */
+static int ovl_cache_entry_add_rb(struct ovl_readdir_data *rdd,
+				  const char *name, int len,
+				  const char *cf_name, int cf_len,
+				  u64 ino,
 				  unsigned int d_type)
 {
 	struct rb_node **newp = &rdd->root->rb_node;
 	struct rb_node *parent = NULL;
 	struct ovl_cache_entry *p;
 
-	if (ovl_cache_entry_find_link(name, len, &newp, &parent))
-		return true;
+	if (ovl_cache_entry_find_link(cf_name, cf_len, &newp, &parent))
+		return 0;
 
-	p = ovl_cache_entry_new(rdd, name, len, ino, d_type);
+	p = ovl_cache_entry_new(rdd, name, len, cf_name, cf_len, ino, d_type);
 	if (p == NULL) {
 		rdd->err = -ENOMEM;
-		return false;
+		return -ENOMEM;
 	}
 
 	list_add_tail(&p->l_node, rdd->list);
 	rb_link_node(&p->node, parent, newp);
 	rb_insert_color(&p->node, rdd->root);
 
-	return true;
+	return 1;
 }
 
-static bool ovl_fill_lowest(struct ovl_readdir_data *rdd,
+/* Return 0 for found, 1 for added, <0 for error */
+static int ovl_fill_lowest(struct ovl_readdir_data *rdd,
 			   const char *name, int namelen,
+			   const char *cf_name, int cf_len,
 			   loff_t offset, u64 ino, unsigned int d_type)
 {
 	struct ovl_cache_entry *p;
 
-	p = ovl_cache_entry_find(rdd->root, name, namelen);
+	p = ovl_cache_entry_find(rdd->root, cf_name, cf_len);
 	if (p) {
 		list_move_tail(&p->l_node, &rdd->middle);
+		return 0;
 	} else {
-		p = ovl_cache_entry_new(rdd, name, namelen, ino, d_type);
+		p = ovl_cache_entry_new(rdd, name, namelen, cf_name, cf_len,
+					ino, d_type);
 		if (p == NULL)
 			rdd->err = -ENOMEM;
 		else
 			list_add_tail(&p->l_node, &rdd->middle);
 	}
 
-	return rdd->err == 0;
+	return rdd->err ?: 1;
 }
 
 void ovl_cache_free(struct list_head *list)
@@ -223,8 +265,11 @@ void ovl_cache_free(struct list_head *list)
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
@@ -260,12 +305,38 @@ static bool ovl_fill_merge(struct dir_context *ctx, const char *name,
 {
 	struct ovl_readdir_data *rdd =
 		container_of(ctx, struct ovl_readdir_data, ctx);
+	struct ovl_fs *ofs = OVL_FS(rdd->dentry->d_sb);
+	char *cf_name = NULL;
+	int c_len = 0;
+	int ret;
+
+	const char *c_name = NULL;
+
+	if (ofs->casefold)
+		c_len = ovl_casefold(rdd->map, name, namelen, &cf_name);
+
+	if (c_len <= 0) {
+		c_name = name;
+		c_len = namelen;
+	} else {
+		c_name = cf_name;
+	}
 
 	rdd->count++;
 	if (!rdd->is_lowest)
-		return ovl_cache_entry_add_rb(rdd, name, namelen, ino, d_type);
+		ret = ovl_cache_entry_add_rb(rdd, name, namelen, c_name, c_len, ino, d_type);
 	else
-		return ovl_fill_lowest(rdd, name, namelen, offset, ino, d_type);
+		ret = ovl_fill_lowest(rdd, name, namelen, c_name, c_len, offset, ino, d_type);
+
+	/*
+	 * If ret == 1, that means that c_name is being used as part of struct
+	 * ovl_cache_entry and will be freed at ovl_cache_free(). Otherwise,
+	 * c_name was found in the rb-tree so we can free it here.
+	 */
+	if (ret != 1 && c_name != name)
+		kfree(c_name);
+
+	return ret >= 0;
 }
 
 static int ovl_check_whiteouts(const struct path *path, struct ovl_readdir_data *rdd)
@@ -357,12 +428,18 @@ static int ovl_dir_read_merged(struct dentry *dentry, struct list_head *list,
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
@@ -555,7 +632,7 @@ static bool ovl_fill_plain(struct dir_context *ctx, const char *name,
 		container_of(ctx, struct ovl_readdir_data, ctx);
 
 	rdd->count++;
-	p = ovl_cache_entry_new(rdd, name, namelen, ino, d_type);
+	p = ovl_cache_entry_new(rdd, name, namelen, NULL, 0, ino, d_type);
 	if (p == NULL) {
 		rdd->err = -ENOMEM;
 		return false;
@@ -1023,6 +1100,8 @@ int ovl_check_empty_dir(struct dentry *dentry, struct list_head *list)
 
 del_entry:
 		list_del(&p->l_node);
+		if (p->cf_name != p->name)
+			kfree(p->cf_name);
 		kfree(p);
 	}
 

-- 
2.50.1


