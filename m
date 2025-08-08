Return-Path: <linux-fsdevel+bounces-57155-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A308B1F002
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 23:00:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5993717C28E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 21:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 386D3253F07;
	Fri,  8 Aug 2025 20:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="X9UeX77y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D25E524679F;
	Fri,  8 Aug 2025 20:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754686764; cv=none; b=CvCv7Pofo71Kv2x156roGODUXOTsBoUjwQDsawlaSzDm/stLKkQl1gPRkaLv0BTNis8fFI0hpblcB3XuSsU2dSWhfr3aXubZYiHpA1yVsm95B5uSuuLa8ek/mlzo5BmN32fd9+Or9kZ7CVAE/DB1c4SZQdvVi7OEcERAWniJzsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754686764; c=relaxed/simple;
	bh=u3dVlKVgCIToDkks6TwPSnBHVCtdx+U9LZIfDBQnw/Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=n2cnsr/7q5IBCAoXy1xnd4ZXkTg4Ix3ANR4Z9BFgnokWCfg7tsUFVeYe2K+XYi/gTkGFEODZGGJlcCIYpkpcoLf1cg3p1IONJeNzeZ/8j7I7n1DlpTJUj9RCjTkp15juayGAyzFA5Ywm1uAUQ2hEX8R0PfrT3BS2Q3wXCw9ue+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=X9UeX77y; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Lg9awdomZOsISya3sAyiL8R37JeVM+GS4Ptv56M4avs=; b=X9UeX77yU+KxevR+nY/dqEKZ+g
	a09nvP6FyVFLz/OvOiz4ZcWbmBS4tcOje8GMn3kLcq+D68laQiHXdeQFymHNSRxvmqsoz/uBdapxF
	dcDZdBcJBpM5PDOmW7jIj6d1W0y4XU5gjv7APnT/zkB+jajLkZOaOOwVmZDlCdUlmV7u6E5k6Hxkq
	JzLThdbCCAuJ3RCfDHMlEP8Bnwou1ef+yckTxMU00U+wdF44yqonkJmA6Kse1NDnuLG4FOPO7SXUr
	WeIabbD13HArdwug2PJc7MFjVQGBNiTUBF1zzygO03EBOkt97v0egyTDelmVQtz2Gcf+8X8BOHyPF
	NbEypaqA==;
Received: from [152.250.7.37] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1ukUBJ-00BiQh-H8; Fri, 08 Aug 2025 22:59:17 +0200
From: =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Date: Fri, 08 Aug 2025 17:58:44 -0300
Subject: [PATCH RFC v3 2/7] ovl: Create ovl_casefold() to support
 casefolded strncmp()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250808-tonyk-overlayfs-v3-2-30f9be426ba8@igalia.com>
References: <20250808-tonyk-overlayfs-v3-0-30f9be426ba8@igalia.com>
In-Reply-To: <20250808-tonyk-overlayfs-v3-0-30f9be426ba8@igalia.com>
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
fallback to use the original string. The caller of the function is
responsible of freeing the buffer.

The other string to be compared is casefolded in a previous step and
stored at `struct ovl_cache_entry` member `char *cf_name`.

Finally, set the strncmp() parameters to the casefold versions of the
names to achieve case-insensitive support.

For the non-casefold names, nothing changes and the rb_tree
search/insert functions just ignores this change.

Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
Changes from v2:
- Refactor the patch to do a single kmalloc() per rb_tree operation
- Instead of casefolding the cache entry name everytime per strncmp(),
  casefold it once and reuse it for every strncmp().
---
 fs/overlayfs/readdir.c | 92 +++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 80 insertions(+), 12 deletions(-)

diff --git a/fs/overlayfs/readdir.c b/fs/overlayfs/readdir.c
index 2f42fec97f76c2000f76e15c60975db567b2c6d6..422f991393dfae12bcacf326414b7ee19e486ac8 100644
--- a/fs/overlayfs/readdir.c
+++ b/fs/overlayfs/readdir.c
@@ -71,20 +71,58 @@ static struct ovl_cache_entry *ovl_cache_entry_from_node(struct rb_node *n)
 	return rb_entry(n, struct ovl_cache_entry, node);
 }
 
+static int ovl_casefold(struct unicode_map *map, const char *str, int len, char **dst)
+{
+#if IS_ENABLED(CONFIG_UNICODE)
+	const struct qstr qstr = { .name = str, .len = len };
+	int cf_len;
+
+	if (!map || is_dot_dotdot(str, len))
+		return -1;
+
+	*dst = kmalloc(OVL_NAME_LEN, GFP_KERNEL);
+
+	if (dst) {
+		cf_len = utf8_casefold(map, &qstr, *dst, OVL_NAME_LEN);
+
+		if (cf_len > 0)
+			return cf_len;
+	}
+#endif
+
+	return -1;
+}
+
 static bool ovl_cache_entry_find_link(const char *name, int len,
 				      struct rb_node ***link,
-				      struct rb_node **parent)
+				      struct rb_node **parent,
+				      struct unicode_map *map)
 {
+	int ret;
+	char *dst = NULL;
 	bool found = false;
+	const char *str = name;
 	struct rb_node **newp = *link;
 
+	ret = ovl_casefold(map, name, len, &dst);
+
+	if (ret > 0) {
+		str = dst;
+		len = ret;
+	}
+
 	while (!found && *newp) {
 		int cmp;
+		char *aux;
 		struct ovl_cache_entry *tmp;
 
 		*parent = *newp;
+
 		tmp = ovl_cache_entry_from_node(*newp);
-		cmp = strncmp(name, tmp->name, len);
+
+		aux = tmp->cf_name ? tmp->cf_name : tmp->name;
+
+		cmp = strncmp(str, aux, len);
 		if (cmp > 0)
 			newp = &tmp->node.rb_right;
 		else if (cmp < 0 || len < tmp->len)
@@ -94,27 +132,50 @@ static bool ovl_cache_entry_find_link(const char *name, int len,
 	}
 	*link = newp;
 
+	kfree(dst);
+
 	return found;
 }
 
 static struct ovl_cache_entry *ovl_cache_entry_find(struct rb_root *root,
-						    const char *name, int len)
+						    const char *name, int len,
+						    struct unicode_map *map)
 {
 	struct rb_node *node = root->rb_node;
-	int cmp;
+	struct ovl_cache_entry *p;
+	const char *str = name;
+	bool found = false;
+	char *dst = NULL;
+	int cmp, ret;
+
+	ret = ovl_casefold(map, name, len, &dst);
+
+	if (ret > 0) {
+		str = dst;
+		len = ret;
+	}
+
+	while (!found && node) {
+		char *aux;
 
-	while (node) {
-		struct ovl_cache_entry *p = ovl_cache_entry_from_node(node);
+		p = ovl_cache_entry_from_node(node);
 
-		cmp = strncmp(name, p->name, len);
+		aux = p->cf_name ? p->cf_name : p->name;
+
+		cmp = strncmp(str, aux, len);
 		if (cmp > 0)
 			node = p->node.rb_right;
 		else if (cmp < 0 || len < p->len)
 			node = p->node.rb_left;
 		else
-			return p;
+			found = true;
 	}
 
+	kfree(dst);
+
+	if (found)
+		return p;
+
 	return NULL;
 }
 
@@ -212,7 +273,7 @@ static bool ovl_cache_entry_add_rb(struct ovl_readdir_data *rdd,
 	struct rb_node *parent = NULL;
 	struct ovl_cache_entry *p;
 
-	if (ovl_cache_entry_find_link(name, len, &newp, &parent))
+	if (ovl_cache_entry_find_link(name, len, &newp, &parent, rdd->map))
 		return true;
 
 	p = ovl_cache_entry_new(rdd, name, len, ino, d_type);
@@ -234,7 +295,7 @@ static bool ovl_fill_lowest(struct ovl_readdir_data *rdd,
 {
 	struct ovl_cache_entry *p;
 
-	p = ovl_cache_entry_find(rdd->root, name, namelen);
+	p = ovl_cache_entry_find(rdd->root, name, namelen, rdd->map);
 	if (p) {
 		list_move_tail(&p->l_node, &rdd->middle);
 	} else {
@@ -640,7 +701,8 @@ static int ovl_dir_read_impure(const struct path *path,  struct list_head *list,
 			struct rb_node *parent = NULL;
 
 			if (WARN_ON(ovl_cache_entry_find_link(p->name, p->len,
-							      &newp, &parent)))
+							      &newp, &parent,
+							      rdd.map)))
 				return -EIO;
 
 			rb_link_node(&p->node, parent, newp);
@@ -701,6 +763,7 @@ struct ovl_readdir_translate {
 	struct dir_context *orig_ctx;
 	struct ovl_dir_cache *cache;
 	struct dir_context ctx;
+	struct unicode_map *map;
 	u64 parent_ino;
 	int fsid;
 	int xinobits;
@@ -721,7 +784,7 @@ static bool ovl_fill_real(struct dir_context *ctx, const char *name,
 	} else if (rdt->cache) {
 		struct ovl_cache_entry *p;
 
-		p = ovl_cache_entry_find(&rdt->cache->root, name, namelen);
+		p = ovl_cache_entry_find(&rdt->cache->root, name, namelen, rdt->map);
 		if (p)
 			ino = p->ino;
 	} else if (rdt->xinobits) {
@@ -763,11 +826,16 @@ static int ovl_iterate_real(struct file *file, struct dir_context *ctx)
 		.orig_ctx = ctx,
 		.xinobits = ovl_xino_bits(ofs),
 		.xinowarn = ovl_xino_warn(ofs),
+		.map      = NULL,
 	};
 
 	if (rdt.xinobits && lower_layer)
 		rdt.fsid = lower_layer->fsid;
 
+#if IS_ENABLED(CONFIG_UNICODE)
+	rdt.map = dir->d_sb->s_encoding;
+#endif
+
 	if (OVL_TYPE_MERGE(ovl_path_type(dir->d_parent))) {
 		struct kstat stat;
 		struct path statpath = file->f_path;

-- 
2.50.1


