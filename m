Return-Path: <linux-fsdevel+bounces-44400-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D2557A68391
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Mar 2025 04:16:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B811019C5B51
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Mar 2025 03:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C05F224EAB5;
	Wed, 19 Mar 2025 03:16:09 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F249C215055;
	Wed, 19 Mar 2025 03:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742354169; cv=none; b=s78hkf/Uok32P9kaweL/ooPnRnTCWN/xeVpl6LSF58O0uKPK41GV2UK+5UjrWF5MlIrNgF7CbvBFSC44J9EUNdaFrf/prNAfaSl32x8T04AwPQMsl7qwnEE/faA75/jzGl+ViWw+WHsVqnBCiztApPkd1n0ZXVZCE9oKQCqYpeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742354169; c=relaxed/simple;
	bh=9sLRRW7WxZK0FGujgs3vJrfX75dDldlyBqagS9MkTe8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ogE8yiF3B0A6EXg2C6cEuNS5rJG1OzXc+GvUl4LSpCR2FWNAqohAWgb5qNn82LrLH9qMynjXvIoDDBxR1ixLGUg7MmO+N15txCXmB51qAsFyi3DkBCr5ERWsNMNX66wfR23owuG8jpt7BBdxSQA7k+VJ2fXgjnscwaX7t2f3aik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1tujuQ-00G6ot-GH;
	Wed, 19 Mar 2025 03:15:58 +0000
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
Subject: [PATCH 6/6] VFS: change lookup_one_common and lookup_noperm_common to take a qstr
Date: Wed, 19 Mar 2025 14:01:37 +1100
Message-ID: <20250319031545.2999807-7-neil@brown.name>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250319031545.2999807-1-neil@brown.name>
References: <20250319031545.2999807-1-neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: NeilBrown <neilb@suse.de>

These function already take a qstr of course, but they also currently
take a name/len was well and fill in the qstr.
Now they take a qstr that is already filled in, which is what all the
callers have.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/namei.c | 44 +++++++++++++++++++-------------------------
 1 file changed, 19 insertions(+), 25 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 16605f7108c0..e2fb61573f13 100644
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
 
@@ -2943,17 +2939,16 @@ struct dentry *lookup_one(struct mnt_idmap *idmap, struct qstr name,
 			  struct dentry *base)
 {
 	struct dentry *dentry;
-	struct qstr this;
 	int err;
 
 	WARN_ON_ONCE(!inode_is_locked(base->d_inode));
 
-	err = lookup_one_common(idmap, name.name, base, name.len, &this);
+	err = lookup_one_common(idmap, &name, base);
 	if (err)
 		return ERR_PTR(err);
 
-	dentry = lookup_dcache(&this, base, 0);
-	return dentry ? dentry : __lookup_slow(&this, base, 0);
+	dentry = lookup_dcache(&name, base, 0);
+	return dentry ? dentry : __lookup_slow(&name, base, 0);
 }
 EXPORT_SYMBOL(lookup_one);
 
@@ -2971,17 +2966,16 @@ EXPORT_SYMBOL(lookup_one);
 struct dentry *lookup_one_unlocked(struct mnt_idmap *idmap,
 				   struct qstr name, struct dentry *base)
 {
-	struct qstr this;
 	int err;
 	struct dentry *ret;
 
-	err = lookup_one_common(idmap, name.name, base, name.len, &this);
+	err = lookup_one_common(idmap, &name, base);
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


