Return-Path: <linux-fsdevel+bounces-50945-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 24F25AD159B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 01:11:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F716188B0E0
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Jun 2025 23:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EB0425DD0C;
	Sun,  8 Jun 2025 23:10:14 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A0820F069;
	Sun,  8 Jun 2025 23:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749424214; cv=none; b=N2Q99zu8wmdyI3I2k5vwEK2F4pugIYSIdBRFRxG1y0ocaDQAme4c3I8/kJfqF2el2N7kaV1yjHMHPA6BjFRw7y+BPIMdDA1JKrh9H8XDgrtIar6mHmfltXTsVehlmZ9ctAT4p6Pc1EfSnpHeDVSM+Oqo9WjhgpqoMML3w3F/tFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749424214; c=relaxed/simple;
	bh=9v7z629pikTfN/M1vRkHPo8KBPBCqPA5CvPZSsA0DSE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=izpnGpWT91hp8Ct1DdOOO/Ek6U0RHLFhWmuCEEY+9aNpKOaGqx7wssmhPYKjW6r2SetX0Mk2ap3/nPdzOxyClwhWkt5vexu9thlelDoceYf/a2tGvngk71t5iP6Ge5V3LxWXhg2y6t9rR2gQjccfzcUQCUH63ZlTs7AT9O8ixS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1uOP9O-005veq-Qq;
	Sun, 08 Jun 2025 23:10:02 +0000
From: NeilBrown <neil@brown.name>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Jan Harkes <jaharkes@cs.cmu.edu>,
	David Howells <dhowells@redhat.com>,
	Tyler Hicks <code@tyhicks.com>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Carlos Maiolino <cem@kernel.org>
Cc: linux-fsdevel@vger.kernel.org,
	coda@cs.cmu.edu,
	codalist@coda.cs.cmu.edu,
	linux-nfs@vger.kernel.org,
	netfs@lists.linux.dev,
	ecryptfs@vger.kernel.org,
	linux-unionfs@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] VFS: merge lookup_one_qstr_excl_raw() back into lookup_one_qstr_excl()
Date: Mon,  9 Jun 2025 09:09:33 +1000
Message-ID: <20250608230952.20539-2-neil@brown.name>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250608230952.20539-1-neil@brown.name>
References: <20250608230952.20539-1-neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The effect of lookup_one_qstr_excl_raw() can be achieved by passing
LOOKUP_CREATE() to lookup_one_qstr_excl() - we don't need a separate
function.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/namei.c | 37 ++++++++++++++-----------------------
 1 file changed, 14 insertions(+), 23 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 4bb889fc980b..dc42bfac5c57 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1665,9 +1665,17 @@ static struct dentry *lookup_dcache(const struct qstr *name,
 	return dentry;
 }
 
-static struct dentry *lookup_one_qstr_excl_raw(const struct qstr *name,
-					       struct dentry *base,
-					       unsigned int flags)
+/*
+ * Parent directory has inode locked exclusive.  This is one
+ * and only case when ->lookup() gets called on non in-lookup
+ * dentries - as the matter of fact, this only gets called
+ * when directory is guaranteed to have no in-lookup children
+ * at all.
+ * Will return -ENOENT if name isn't found and LOOKUP_CREATE wasn't passed.
+ * Will return -EEXIST if name is found and LOOKUP_EXCL was passed.
+ */
+struct dentry *lookup_one_qstr_excl(const struct qstr *name,
+				    struct dentry *base, unsigned int flags)
 {
 	struct dentry *dentry;
 	struct dentry *old;
@@ -1675,7 +1683,7 @@ static struct dentry *lookup_one_qstr_excl_raw(const struct qstr *name,
 
 	dentry = lookup_dcache(name, base, flags);
 	if (dentry)
-		return dentry;
+		goto found;
 
 	/* Don't create child dentry for a dead directory. */
 	dir = base->d_inode;
@@ -1691,24 +1699,7 @@ static struct dentry *lookup_one_qstr_excl_raw(const struct qstr *name,
 		dput(dentry);
 		dentry = old;
 	}
-	return dentry;
-}
-
-/*
- * Parent directory has inode locked exclusive.  This is one
- * and only case when ->lookup() gets called on non in-lookup
- * dentries - as the matter of fact, this only gets called
- * when directory is guaranteed to have no in-lookup children
- * at all.
- * Will return -ENOENT if name isn't found and LOOKUP_CREATE wasn't passed.
- * Will return -EEXIST if name is found and LOOKUP_EXCL was passed.
- */
-struct dentry *lookup_one_qstr_excl(const struct qstr *name,
-				    struct dentry *base, unsigned int flags)
-{
-	struct dentry *dentry;
-
-	dentry = lookup_one_qstr_excl_raw(name, base, flags);
+found:
 	if (IS_ERR(dentry))
 		return dentry;
 	if (d_is_negative(dentry) && !(flags & LOOKUP_CREATE)) {
@@ -2790,7 +2781,7 @@ struct dentry *kern_path_locked_negative(const char *name, struct path *path)
 	if (unlikely(type != LAST_NORM))
 		return ERR_PTR(-EINVAL);
 	inode_lock_nested(parent_path.dentry->d_inode, I_MUTEX_PARENT);
-	d = lookup_one_qstr_excl_raw(&last, parent_path.dentry, 0);
+	d = lookup_one_qstr_excl(&last, parent_path.dentry, LOOKUP_CREATE);
 	if (IS_ERR(d)) {
 		inode_unlock(parent_path.dentry->d_inode);
 		return d;
-- 
2.49.0


