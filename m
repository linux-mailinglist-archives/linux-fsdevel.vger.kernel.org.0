Return-Path: <linux-fsdevel+bounces-43997-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2667CA6082E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Mar 2025 05:58:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11B7219C2662
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Mar 2025 04:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DA5115DBA3;
	Fri, 14 Mar 2025 04:57:15 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3553136E37;
	Fri, 14 Mar 2025 04:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741928234; cv=none; b=S5+vcuKPEVq+6jnd/CuUeHrOagT4LSHWhdt9EcM4QH2XchHsYkxmBruGRVEQLDPDXVJaEjb8CA9sDbCSuwnYE4jVOl5QioL+db0MFmCcclPfKN9apuHCrEc/oKaLtW3sNg6iDKW31xQBDKaK44A1+e04dR3HsmGjzogOIvMpYyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741928234; c=relaxed/simple;
	bh=JjL88J0aetZl6wvwQcctthuQv0BgyuVD/7xuRLQTZTQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QKnI55gAKu5Jv54Bt3jCzuIj/QGJzqX60gddw5HdOTDR8CChZr6vWjXZToHAHkPU6RDFQlbEG3r/3T8n2VvM5AJUQtZClFe/PrbHTNXplmtUk3DeK5szAInhHS/CAeyvg2SxAxOqvH5ybxaYMcf5GLY6C8+ywoiD7RWrQpc/l7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1tsx6b-00E3wD-0s;
	Fri, 14 Mar 2025 04:57:09 +0000
From: NeilBrown <neil@brown.name>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	David Howells <dhowells@redhat.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 8/8] VFS: change lookup_one_common and lookup_noperm_common to take a qstr
Date: Fri, 14 Mar 2025 11:34:14 +1100
Message-ID: <20250314045655.603377-9-neil@brown.name>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250314045655.603377-1-neil@brown.name>
References: <20250314045655.603377-1-neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These function already take a qstr of course, but they also currently
take a name/len was well and fill in the qstr.
Now they take a qstr that is already filled in, which is what all the
callers have.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/namei.c | 44 +++++++++++++++++++-------------------------
 1 file changed, 19 insertions(+), 25 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index f89ed09c0b0b..a47a3795f2c7 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -2833,13 +2833,12 @@ int vfs_path_lookup(struct dentry *dentry, struct vfsmount *mnt,
 }
 EXPORT_SYMBOL(vfs_path_lookup);
 
-static int lookup_noperm_common(const char *name, struct dentry *base,
-				  int len,
-				  struct qstr *this)
+static int lookup_noperm_common(struct qstr *qname, struct dentry *base)
 {
-	this->name = name;
-	this->len = len;
-	this->hash = full_name_hash(base, name, len);
+	const char *name = qname->name;
+	u32 len = qname->len;
+
+	qname->hash = full_name_hash(base, name, len);
 	if (!len)
 		return -EACCES;
 
@@ -2856,7 +2855,7 @@ static int lookup_noperm_common(const char *name, struct dentry *base,
 	 * to use its own hash..
 	 */
 	if (base->d_flags & DCACHE_OP_HASH) {
-		int err = base->d_op->d_hash(base, this);
+		int err = base->d_op->d_hash(base, qname);
 		if (err < 0)
 			return err;
 	}
@@ -2864,10 +2863,10 @@ static int lookup_noperm_common(const char *name, struct dentry *base,
 }
 
 static int lookup_one_common(struct mnt_idmap *idmap,
-			     const char *name, struct dentry *base, int len,
-			     struct qstr *this) {
+			     struct qstr *qname, struct dentry *base)
+{
 	int err;
-	err = lookup_noperm_common(name, base, len, this);
+	err = lookup_noperm_common(qname, base);
 	if (err < 0)
 		return err;
 	return inode_permission(idmap, base->d_inode, MAY_EXEC);
@@ -2888,16 +2887,14 @@ static int lookup_one_common(struct mnt_idmap *idmap,
  */
 struct dentry *try_lookup_noperm(struct qstr *name, struct dentry *base)
 {
-	struct qstr this;
 	int err;
 
 	WARN_ON_ONCE(!inode_is_locked(base->d_inode));
 
-	err = lookup_noperm_common(name->name, base, name->len, &this);
+	err = lookup_noperm_common(name, base);
 	if (err)
 		return ERR_PTR(err);
 
-	name->hash = this.hash;
 	return lookup_dcache(name, base, 0);
 }
 EXPORT_SYMBOL(try_lookup_noperm);
@@ -2915,17 +2912,16 @@ EXPORT_SYMBOL(try_lookup_noperm);
 struct dentry *lookup_noperm(struct qstr name, struct dentry *base)
 {
 	struct dentry *dentry;
-	struct qstr this;
 	int err;
 
 	WARN_ON_ONCE(!inode_is_locked(base->d_inode));
 
-	err = lookup_noperm_common(name.name, base, name.len, &this);
+	err = lookup_noperm_common(&name, base);
 	if (err)
 		return ERR_PTR(err);
 
-	dentry = lookup_dcache(&this, base, 0);
-	return dentry ? dentry : __lookup_slow(&this, base, 0);
+	dentry = lookup_dcache(&name, base, 0);
+	return dentry ? dentry : __lookup_slow(&name, base, 0);
 }
 EXPORT_SYMBOL(lookup_noperm);
 
@@ -2943,17 +2939,16 @@ struct dentry *lookup_one(struct vfsmount *mnt, struct qstr name,
 			  struct dentry *base)
 {
 	struct dentry *dentry;
-	struct qstr this;
 	int err;
 
 	WARN_ON_ONCE(!inode_is_locked(base->d_inode));
 
-	err = lookup_one_common(mnt_idmap(mnt), name.name, base, name.len, &this);
+	err = lookup_one_common(mnt_idmap(mnt), &name, base);
 	if (err)
 		return ERR_PTR(err);
 
-	dentry = lookup_dcache(&this, base, 0);
-	return dentry ? dentry : __lookup_slow(&this, base, 0);
+	dentry = lookup_dcache(&name, base, 0);
+	return dentry ? dentry : __lookup_slow(&name, base, 0);
 }
 EXPORT_SYMBOL(lookup_one);
 
@@ -2971,17 +2966,16 @@ EXPORT_SYMBOL(lookup_one);
 struct dentry *lookup_one_unlocked(struct vfsmount *mnt,
 				   struct qstr name, struct dentry *base)
 {
-	struct qstr this;
 	int err;
 	struct dentry *ret;
 
-	err = lookup_one_common(mnt_idmap(mnt), name.name, base, name.len, &this);
+	err = lookup_one_common(mnt_idmap(mnt), &name, base);
 	if (err)
 		return ERR_PTR(err);
 
-	ret = lookup_dcache(&this, base, 0);
+	ret = lookup_dcache(&name, base, 0);
 	if (!ret)
-		ret = lookup_slow(&this, base, 0);
+		ret = lookup_slow(&name, base, 0);
 	return ret;
 }
 EXPORT_SYMBOL(lookup_one_unlocked);
-- 
2.48.1


