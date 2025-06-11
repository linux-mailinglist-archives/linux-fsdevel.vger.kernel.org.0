Return-Path: <linux-fsdevel+bounces-51249-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 80C60AD4D95
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 09:56:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 768871BC085B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 07:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9037A245010;
	Wed, 11 Jun 2025 07:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="N8wfeHNK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D1EE23ABB6
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Jun 2025 07:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749628483; cv=none; b=ru/eW8FVa4GbIDyjHzCdAqL8722E9BJpendCMIgqO7uY7SGSlCwgXiqh2QGlXeB2eSmEzYaMT20brOjj1Ajl39aDDOYUpMXlTiBSY5G4tuPzgBejIr3JTMVcLnlSmrr2b8SQNM4Tsr8Iv7SMSkZKdWiZkwGSeuakaIgfv49nUJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749628483; c=relaxed/simple;
	bh=hFqVzd9bVmIe53ZtlAamaM7TA8K8shkJQzENvQ5idNw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FC9LXJJ14oHHaCqXwi/hjF12purFAzrOvaoJLGYeMlotPIn3rthyOSgiscBg2R7nK5DgHgS0Q0EYRL9ORljnl+LT5iDfg4cFwOksMTiXvXRkXU5G+cNv42cSdVtgZWX6O368p9oHZCpGYbaV66DO3tc9J9aUu1ndblD9qE8EMzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=N8wfeHNK; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=rWHZnmERRBKwzC8XvkuSjvA5irsKfmbXV1ERxCMVVZE=; b=N8wfeHNKclz+aIF27enCbJ6DiO
	jWinQtYqIUtxL7MmCVvheKMmGAczKspbZRbxpe9pCLAy2eylFLFm9CG4NhOyKFPmLtaOM33ZuM3PJ
	pxVGKEALOGwGF4QMUEl04IcDyyu9R3BUu9zLzW2rCXTTZ3haBIfwljSI/t26PFTkuJkK916pII+9X
	K6ObI2HjF2qHQvDJUd5sVi1zj38GLR2kEAkmNm8Yz9uDmrJhI6s0ylVVBtWeYqeyu1VdFaneUtH7K
	3MQcXw95zKzwgtf7sucihAvJ87PGdxpKqNEzK8RKdlYkOrL8Gz6YE6bPpK1S24IKDVIKKLJSh6yoT
	y5KczP/A==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPGIB-0000000HTxN-11eb;
	Wed, 11 Jun 2025 07:54:39 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	jack@suse.cz,
	miklos@szeredi.hu,
	neilb@suse.de,
	torvalds@linux-foundation.org
Subject: [PATCH v2 11/21] make d_set_d_op() static
Date: Wed, 11 Jun 2025 08:54:27 +0100
Message-ID: <20250611075437.4166635-11-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250611075437.4166635-1-viro@zeniv.linux.org.uk>
References: <20250611075023.GJ299672@ZenIV>
 <20250611075437.4166635-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

Convert the last user (d_alloc_pseudo()) and be done with that.
Any out-of-tree filesystem using it should switch to d_splice_alias_ops()
or, better yet, check whether it really needs to have ->d_op vary among
its dentries.

Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 Documentation/filesystems/porting.rst | 11 +++++++++++
 fs/dcache.c                           |  6 +++---
 include/linux/dcache.h                |  1 -
 3 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/Documentation/filesystems/porting.rst b/Documentation/filesystems/porting.rst
index b16139e91942..579f17df46cf 100644
--- a/Documentation/filesystems/porting.rst
+++ b/Documentation/filesystems/porting.rst
@@ -1256,3 +1256,14 @@ an extra reference to new mount - it should be returned with refcount 1.
 
 If your filesystem sets the default dentry_operations, use set_default_d_op()
 rather than manually setting sb->s_d_op.
+
+---
+
+**mandatory**
+
+d_set_d_op() is no longer exported (or public, for that matter); _if_
+your filesystem really needed that, make use of d_splice_alias_ops()
+to have them set.  Better yet, think hard whether you need different
+->d_op for different dentries - if not, just use set_default_d_op()
+at mount time and be done with that.  Currently procfs is the only
+thing that really needs ->d_op varying between dentries.
diff --git a/fs/dcache.c b/fs/dcache.c
index 7519c5f66f79..4e6ab27471a4 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -1821,8 +1821,9 @@ struct dentry *d_alloc_pseudo(struct super_block *sb, const struct qstr *name)
 	struct dentry *dentry = __d_alloc(sb, name);
 	if (likely(dentry)) {
 		dentry->d_flags |= DCACHE_NORCU;
+		/* d_op_flags(&anon_ops) is 0 */
 		if (!dentry->d_op)
-			d_set_d_op(dentry, &anon_ops);
+			dentry->d_op = &anon_ops;
 	}
 	return dentry;
 }
@@ -1864,7 +1865,7 @@ static unsigned int d_op_flags(const struct dentry_operations *op)
 	return flags;
 }
 
-void d_set_d_op(struct dentry *dentry, const struct dentry_operations *op)
+static void d_set_d_op(struct dentry *dentry, const struct dentry_operations *op)
 {
 	unsigned int flags = d_op_flags(op);
 	WARN_ON_ONCE(dentry->d_op);
@@ -1873,7 +1874,6 @@ void d_set_d_op(struct dentry *dentry, const struct dentry_operations *op)
 	if (flags)
 		dentry->d_flags |= flags;
 }
-EXPORT_SYMBOL(d_set_d_op);
 
 void set_default_d_op(struct super_block *s, const struct dentry_operations *ops)
 {
diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index be7ae058fa90..cc3e1c1a3454 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -237,7 +237,6 @@ extern void d_instantiate_new(struct dentry *, struct inode *);
 extern void __d_drop(struct dentry *dentry);
 extern void d_drop(struct dentry *dentry);
 extern void d_delete(struct dentry *);
-extern void d_set_d_op(struct dentry *dentry, const struct dentry_operations *op);
 
 /* allocate/de-allocate */
 extern struct dentry * d_alloc(struct dentry *, const struct qstr *);
-- 
2.39.5


