Return-Path: <linux-fsdevel+bounces-51244-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D948AD4D90
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 09:56:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FD25189FF36
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 07:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 861A4241136;
	Wed, 11 Jun 2025 07:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="j6AgqQES"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 294CB23AB9D
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Jun 2025 07:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749628482; cv=none; b=q0w2VDLV+TY0kTckPhauaMWf3+uyGyY1sAdXE8OI49Ve81IPOx/ZJ9kq/X+T9tl4HS6AvHRfZuy0TK2kyKvrV3FsPT99SvlEcBb6n5PrU2A6y8AIokfClilGpVFwAo/o96DHytHMTMcJSmuqRktLolexRWZo2GVio1uJGS4TY/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749628482; c=relaxed/simple;
	bh=2zZR808jcEHV0z3YlVMpaylIKp3A+CqSH7vT+tatRhI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JVGRi4mLjfJV0F9wjAaOCLcLoh1UYvuognkh0BYXEYGmc6EvQw9v0+R8ReWB3ooczWQgGhjiuhxnMDapdSECMt1AJaDxE8DcbyFn412vG61dXAPlkzxaMulcBPCW1uvfIthVEkokprgsl54waRw3xY8UFu7zCOU5CK60XjWbQhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=j6AgqQES; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=UXwsW2bcRm8N2q6DMdJprisfMgZwPvLTJn5/X3aCHH8=; b=j6AgqQESSyGwSqmdH+FkNqkd1z
	2rf8beDVH0vF3qICltYOA5vy9fvBo/xAwWsm6jeN9rjz5soGS7xTSEFb8m2dNoe5ZsEsTg7plSXri
	fodwvy0iJ9K4xp8Xssxr9cfRvC9bcptACr4TN64PqiMXl0dn88ILM6RA7t1cn1rcrawXts9KA8dQA
	pxA/f/GlOv6gllOsQNGU3EycsVWlde7qxxBhjSc1z36Mop/TRHBYCaGNGvyuLddy32wyj0gK9wZ6/
	VeqOtp7GZIz4+ZzK/40HY6FydgMKRAfULhOUUWrvSLLskTHOoQkWSbIAZy9w1u1w/r++32L8IpH5Q
	3F4Odo0Q==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPGIA-0000000HTwa-2RI8;
	Wed, 11 Jun 2025 07:54:38 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	jack@suse.cz,
	miklos@szeredi.hu,
	neilb@suse.de,
	torvalds@linux-foundation.org
Subject: [PATCH v2 07/21] split d_flags calculation out of d_set_d_op()
Date: Wed, 11 Jun 2025 08:54:23 +0100
Message-ID: <20250611075437.4166635-7-viro@zeniv.linux.org.uk>
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

Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/dcache.c | 53 ++++++++++++++++++++++++++++++-----------------------
 1 file changed, 30 insertions(+), 23 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 2ed875558ccc..f998e26c9cd4 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -1837,33 +1837,40 @@ struct dentry *d_alloc_name(struct dentry *parent, const char *name)
 }
 EXPORT_SYMBOL(d_alloc_name);
 
+#define DCACHE_OP_FLAGS \
+	(DCACHE_OP_HASH | DCACHE_OP_COMPARE | DCACHE_OP_REVALIDATE | \
+	 DCACHE_OP_WEAK_REVALIDATE | DCACHE_OP_DELETE | DCACHE_OP_REAL)
+
+static unsigned int d_op_flags(const struct dentry_operations *op)
+{
+	unsigned int flags = 0;
+	if (op) {
+		if (op->d_hash)
+			flags |= DCACHE_OP_HASH;
+		if (op->d_compare)
+			flags |= DCACHE_OP_COMPARE;
+		if (op->d_revalidate)
+			flags |= DCACHE_OP_REVALIDATE;
+		if (op->d_weak_revalidate)
+			flags |= DCACHE_OP_WEAK_REVALIDATE;
+		if (op->d_delete)
+			flags |= DCACHE_OP_DELETE;
+		if (op->d_prune)
+			flags |= DCACHE_OP_PRUNE;
+		if (op->d_real)
+			flags |= DCACHE_OP_REAL;
+	}
+	return flags;
+}
+
 void d_set_d_op(struct dentry *dentry, const struct dentry_operations *op)
 {
+	unsigned int flags = d_op_flags(op);
 	WARN_ON_ONCE(dentry->d_op);
-	WARN_ON_ONCE(dentry->d_flags & (DCACHE_OP_HASH	|
-				DCACHE_OP_COMPARE	|
-				DCACHE_OP_REVALIDATE	|
-				DCACHE_OP_WEAK_REVALIDATE	|
-				DCACHE_OP_DELETE	|
-				DCACHE_OP_REAL));
+	WARN_ON_ONCE(dentry->d_flags & DCACHE_OP_FLAGS);
 	dentry->d_op = op;
-	if (!op)
-		return;
-	if (op->d_hash)
-		dentry->d_flags |= DCACHE_OP_HASH;
-	if (op->d_compare)
-		dentry->d_flags |= DCACHE_OP_COMPARE;
-	if (op->d_revalidate)
-		dentry->d_flags |= DCACHE_OP_REVALIDATE;
-	if (op->d_weak_revalidate)
-		dentry->d_flags |= DCACHE_OP_WEAK_REVALIDATE;
-	if (op->d_delete)
-		dentry->d_flags |= DCACHE_OP_DELETE;
-	if (op->d_prune)
-		dentry->d_flags |= DCACHE_OP_PRUNE;
-	if (op->d_real)
-		dentry->d_flags |= DCACHE_OP_REAL;
-
+	if (flags)
+		dentry->d_flags |= flags;
 }
 EXPORT_SYMBOL(d_set_d_op);
 
-- 
2.39.5


