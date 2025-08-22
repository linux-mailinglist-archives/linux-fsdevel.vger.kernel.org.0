Return-Path: <linux-fsdevel+bounces-58819-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E9CCB31B45
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 16:24:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E755B25C81
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 14:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBC6B30E823;
	Fri, 22 Aug 2025 14:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="fawlFvfV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3463F3093CE;
	Fri, 22 Aug 2025 14:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755872254; cv=none; b=WIeSF9XAEWuOyQtnAkhY5vFd6kaiSlyqQi9yi3G7g48nFkrKrCRmyDWOWLi7rsQ9LguMMZR/kISjFaYl1oh3lbLQ2Gp1e70hbgPlRbZP6qjZcIUW9THqrndkVG/+HcbJKAfCGFHziy28vLPY17UUiIEFg0QSoCRjO2YD6QzUGBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755872254; c=relaxed/simple;
	bh=YriVfPsUFeySF2tgLZf6tlKPTJx/jbLYBdayK/S8Qls=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oBzEHHKESoY68wtQqN46Ea3j0Ze0zcq9MQlNux2ov/J9y5Wm3LMucFlVeTGlyAPysHpjstc8RZSKKue0vsJYXYnd3XhqUSbAEsQdy6NLuwEiEVlUmZCYwURCupShVybQTEldYZybB6Q7QjIQ20PrTrHbslwh5GsZVdL5U4kII2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=fawlFvfV; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=dmGccF3aLNQnuTlSdoeKU07d8ZmxxtGTkRtVaRxnAcY=; b=fawlFvfVjwO+8n7Hkx4qk+JZvB
	gAlauqhBuapdwxrp4MBhbkyyM/ikK14kHSStsc10gxCTmMgiVcQA5SjMlYTYZXlmB0njZ9dPhXluo
	vds5cBQoaLMfN8YhEhDkMrpFTSc5ghDxBgMHczwz/F3IrRBI66xe2z8ZfZ6wYNmXnfpiHAnPlqrh0
	bgdy4b9/qmfpvtJC6sG/MmV6+8qPnknFR6hLN3H/MeOL+aXrVlE2sbvl6efCVWdNdyuZHDfZl/qtL
	H8XeZS2uYz2lmufHaY5zYDsdExwKuYW34U7uNH2HRuIVrdZpI7Y9JluDRITXXaA5i1V6dA+i1a6He
	Gai1zLrA==;
Received: from [152.250.7.37] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1upSa6-0008Fn-Sb; Fri, 22 Aug 2025 16:17:27 +0200
From: =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Date: Fri, 22 Aug 2025 11:17:07 -0300
Subject: [PATCH v6 4/9] ovl: Create ovl_casefold() to support casefolded
 strncmp()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250822-tonyk-overlayfs-v6-4-8b6e9e604fa2@igalia.com>
References: <20250822-tonyk-overlayfs-v6-0-8b6e9e604fa2@igalia.com>
In-Reply-To: <20250822-tonyk-overlayfs-v6-0-8b6e9e604fa2@igalia.com>
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

Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
Changes from v6:
 - Last version was using `strncmp(... tmp->len)` which was causing
   regressions. It should be `strncmp(... len)`.
 - Rename cf_len to c_len
 - Use c_len for tree operation: (cmp < 0 || len < tmp->c_len)
 - Remove needless kfree(cf_name)
---
 fs/overlayfs/readdir.c | 113 ++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 94 insertions(+), 19 deletions(-)

diff --git a/fs/overlayfs/readdir.c b/fs/overlayfs/readdir.c
index b65cdfce31ce27172d28d879559f1008b9c87320..dfc661b7bc3f87efbf14991e97cee169400d823b 100644
--- a/fs/overlayfs/readdir.c
+++ b/fs/overlayfs/readdir.c
@@ -27,6 +27,8 @@ struct ovl_cache_entry {
 	bool is_upper;
 	bool is_whiteout;
 	bool check_xwhiteout;
+	const char *c_name;
+	int c_len;
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
@@ -79,10 +103,10 @@ static bool ovl_cache_entry_find_link(const char *name, int len,
 
 		*parent = *newp;
 		tmp = ovl_cache_entry_from_node(*newp);
-		cmp = strncmp(name, tmp->name, len);
+		cmp = strncmp(name, tmp->c_name, len);
 		if (cmp > 0)
 			newp = &tmp->node.rb_right;
-		else if (cmp < 0 || len < tmp->len)
+		else if (cmp < 0 || len < tmp->c_len)
 			newp = &tmp->node.rb_left;
 		else
 			found = true;
@@ -101,10 +125,10 @@ static struct ovl_cache_entry *ovl_cache_entry_find(struct rb_root *root,
 	while (node) {
 		struct ovl_cache_entry *p = ovl_cache_entry_from_node(node);
 
-		cmp = strncmp(name, p->name, len);
+		cmp = strncmp(name, p->c_name, len);
 		if (cmp > 0)
 			node = p->node.rb_right;
-		else if (cmp < 0 || len < p->len)
+		else if (cmp < 0 || len < p->c_len)
 			node = p->node.rb_left;
 		else
 			return p;
@@ -145,6 +169,7 @@ static bool ovl_calc_d_ino(struct ovl_readdir_data *rdd,
 
 static struct ovl_cache_entry *ovl_cache_entry_new(struct ovl_readdir_data *rdd,
 						   const char *name, int len,
+						   const char *c_name, int c_len,
 						   u64 ino, unsigned int d_type)
 {
 	struct ovl_cache_entry *p;
@@ -167,6 +192,14 @@ static struct ovl_cache_entry *ovl_cache_entry_new(struct ovl_readdir_data *rdd,
 	/* Defer check for overlay.whiteout to ovl_iterate() */
 	p->check_xwhiteout = rdd->in_xwhiteouts_dir && d_type == DT_REG;
 
+	if (c_name && c_name != name) {
+		p->c_name = c_name;
+		p->c_len = c_len;
+	} else {
+		p->c_name = p->name;
+		p->c_len = len;
+	}
+
 	if (d_type == DT_CHR) {
 		p->next_maybe_whiteout = rdd->first_maybe_whiteout;
 		rdd->first_maybe_whiteout = p;
@@ -174,48 +207,55 @@ static struct ovl_cache_entry *ovl_cache_entry_new(struct ovl_readdir_data *rdd,
 	return p;
 }
 
-static bool ovl_cache_entry_add_rb(struct ovl_readdir_data *rdd,
-				  const char *name, int len, u64 ino,
+/* Return 0 for found, 1 for added, <0 for error */
+static int ovl_cache_entry_add_rb(struct ovl_readdir_data *rdd,
+				  const char *name, int len,
+				  const char *c_name, int c_len,
+				  u64 ino,
 				  unsigned int d_type)
 {
 	struct rb_node **newp = &rdd->root->rb_node;
 	struct rb_node *parent = NULL;
 	struct ovl_cache_entry *p;
 
-	if (ovl_cache_entry_find_link(name, len, &newp, &parent))
-		return true;
+	if (ovl_cache_entry_find_link(c_name, c_len, &newp, &parent))
+		return 0;
 
-	p = ovl_cache_entry_new(rdd, name, len, ino, d_type);
+	p = ovl_cache_entry_new(rdd, name, len, c_name, c_len, ino, d_type);
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
+			   const char *c_name, int c_len,
 			   loff_t offset, u64 ino, unsigned int d_type)
 {
 	struct ovl_cache_entry *p;
 
-	p = ovl_cache_entry_find(rdd->root, name, namelen);
+	p = ovl_cache_entry_find(rdd->root, c_name, c_len);
 	if (p) {
 		list_move_tail(&p->l_node, &rdd->middle);
+		return 0;
 	} else {
-		p = ovl_cache_entry_new(rdd, name, namelen, ino, d_type);
+		p = ovl_cache_entry_new(rdd, name, namelen, c_name, c_len,
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
@@ -223,8 +263,11 @@ void ovl_cache_free(struct list_head *list)
 	struct ovl_cache_entry *p;
 	struct ovl_cache_entry *n;
 
-	list_for_each_entry_safe(p, n, list, l_node)
+	list_for_each_entry_safe(p, n, list, l_node) {
+		if (p->c_name != p->name)
+			kfree(p->c_name);
 		kfree(p);
+	}
 
 	INIT_LIST_HEAD(list);
 }
@@ -260,12 +303,36 @@ static bool ovl_fill_merge(struct dir_context *ctx, const char *name,
 {
 	struct ovl_readdir_data *rdd =
 		container_of(ctx, struct ovl_readdir_data, ctx);
+	struct ovl_fs *ofs = OVL_FS(rdd->dentry->d_sb);
+	const char *c_name = NULL;
+	char *cf_name = NULL;
+	int c_len = 0, ret;
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
+		if (p->c_name != p->name)
+			kfree(p->c_name);
 		kfree(p);
 	}
 

-- 
2.50.1


