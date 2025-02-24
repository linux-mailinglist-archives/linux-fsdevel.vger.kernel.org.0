Return-Path: <linux-fsdevel+bounces-42513-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F47AA42EF2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 22:21:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FB481891000
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 21:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 997E91DD0E7;
	Mon, 24 Feb 2025 21:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="CJalFdNN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AACE41CEAB2
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Feb 2025 21:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740432055; cv=none; b=qpwAeMKQqrAVFp6IAYOt1BBO60jyw29TcIfAKl6bdDNL2bc0RFHpCYTbYzVuf2cdQxDyunF7qzqeZpu6oH5FnujyeFdnK63bYqzhSYNbKl+wrzfZkc9HyfeinEBPFl733NQiN8FJ+KZCH06WuRp97SP3j1RmuVCZOe5IwZ4YYB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740432055; c=relaxed/simple;
	bh=Wo4txn4dmfTosxRG3rec1YPlAWcZ/wrr91Tw3E/adLI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bkPcBdqE6YSgD4T9NWwu02VYNX/A8Mz5gQFumMqdTXJvnbQ5mOrjepvGDMe3FCdUqEZ1hyWC21FktQrdgOMCZ14bP31r/PazXaxFkWsLs7HVj9Ga8w7m+XUDbyHS0MawaPUvcIZITFE27Xaes7CAGDp7zHDQ+WN71ADJxfHvsaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=CJalFdNN; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=1F2/4S/8rFQLWDEOOs31eSIJSfaZ7JG59EE/HaotUwo=; b=CJalFdNNQRGHbWO0lOf7EsLQ7F
	+sujPZSdSc11pSNwKi/+Ebp/7OJkaQX8io1L2UDE4+0gfwqSUlqn2Mn61dWnldGKxDj6S1IXI//e1
	kDbcRLsRr3IVf0kxrGeWqkwtMvXbqCse8BjHfa7jxM7gvuE5IcoVEyF3fqrA7p2aQD5yTLXjN11GV
	8d3/6NZlqyk5YlD3CB/v7u55wLMEBnQdnAzUtBlF9zTHSSVrIIRRJYcK42fh1+kMfLMseqfbwx81z
	1VWmafsGW8PFISv9Do2HDjxV4+c7eGip5OQWPiuiseHz+Nxfuh91uLaRVJwT91n1k1Di2JDrhv0qG
	RUv10HCw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tmfsi-00000007MxD-1JJP;
	Mon, 24 Feb 2025 21:20:52 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	Neil Brown <neilb@suse.de>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 06/21] split d_flags calculation out of d_set_d_op()
Date: Mon, 24 Feb 2025 21:20:36 +0000
Message-ID: <20250224212051.1756517-6-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250224212051.1756517-1-viro@zeniv.linux.org.uk>
References: <20250224141444.GX1977892@ZenIV>
 <20250224212051.1756517-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/dcache.c | 53 ++++++++++++++++++++++++++++++-----------------------
 1 file changed, 30 insertions(+), 23 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index cd5e5139ca4c..1201149e1e2c 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -1811,33 +1811,40 @@ struct dentry *d_alloc_name(struct dentry *parent, const char *name)
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


