Return-Path: <linux-fsdevel+bounces-42530-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B746EA42EF1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 22:21:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F327E3A66F6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 21:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00599202F80;
	Mon, 24 Feb 2025 21:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="o9hHdbKm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA9D61DB363
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Feb 2025 21:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740432058; cv=none; b=PtDDkZwIbcHyt1SAQS8O4p6RqHD7pqAaDcS0rnqTOwWNwGKU8i2ZDdF8OLy1x//tscrCN/l5Yh7qPZoRKctfIXrFyuqcdfzd2VJdEN/fmAp8ZyjJPcxN0H4lHxAW3Nt5nUgY9xa1tl+ggZvDwEwJrZFqyf4ZtupjBeKLyH1A/ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740432058; c=relaxed/simple;
	bh=SZUYx1406Eo8g30ExtRhWTaR5acc5X2bPDI9r3WI2QA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vb0uQzjcjDo1c6+lGJINlMm6SyY6BH5Fh4gugJAgkjM/koM6X5Ny+abHwPaRECgfLo7Qatcw7aWt60Yfszq7X6RCePK/2pXzahUrQTvBRk3z2rc5jGFZM8CtFlyp9jPvaJ2DItJcZyWU3cHHcTXVPmu9S3c/j2kdD7xLjn+tDek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=o9hHdbKm; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=svTQOMdKGP90ZyImR5PQr/o0jl5LgMpLxKeqaOVU22M=; b=o9hHdbKmPSJAaWHNkn/8XK9yn6
	fHkN/jJa3kGXcoJOKt0PYtxqdFU9j1LG1E6MKbydUfcu8XvTdJ1V0+ThZgsXnOQkgkYIxZ6xlvU5M
	ICPHz5dyXoPssMEj49Ow7xzMWjUFQcBHKB0ay2Z8+Omkz8uDYxKe2qOQYcKtHJsCw5ZkrqZHFID3S
	RDzZ/VWPyZPqpAAXs+GqhTGJPYAJmJ2u2HZAwu2IfsaPI+4A/0Olc+DB673czmsAr7pxQmq5MTcRI
	SlPzA275OHXZklyc05NJf7CLB54ktCSEkniPKhQ5arPSyZNgJ+IfH7HSHwz53laZbYA35WjLwDGbX
	53nsmRAw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tmfsi-00000007Mxr-2KYp;
	Mon, 24 Feb 2025 21:20:52 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	Neil Brown <neilb@suse.de>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 10/21] d_alloc_parallel(): set DCACHE_PAR_LOOKUP earlier
Date: Mon, 24 Feb 2025 21:20:40 +0000
Message-ID: <20250224212051.1756517-10-viro@zeniv.linux.org.uk>
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

Do that before new dentry is visible anywhere.  It does create
a new possible state for dentries present in ->d_children/->d_sib -
DCACHE_PAR_LOOKUP present, negative, unhashed, not in in-lookup
hash chains, refcount positive.  Those are going to be skipped
by all tree-walkers (both d_walk() callbacks in fs/dcache.c and
explicit loops over children/sibling lists elsewhere) and
dput() is fine with those.

NOTE: dropping the final reference to a "normal" in-lookup dentry
(in in-lookup hash) is a bug - somebody must've forgotten to
call d_lookup_done() on it and bad things will happen.  With those
it's OK; if/when we get around to making __dentry_kill() complain
about such breakage, remember that predicate to check should
*not* be just d_in_lookup(victim) but rather a combination of that
with hlist_bl_unhashed(&victim->d_u.d_in_lookup_hash).  Might
be worth to consider later...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/dcache.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 29db27228d97..9ad7cbb5a6b0 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -2518,13 +2518,19 @@ struct dentry *d_alloc_parallel(struct dentry *parent,
 	unsigned int hash = name->hash;
 	struct hlist_bl_head *b = in_lookup_hash(parent, hash);
 	struct hlist_bl_node *node;
-	struct dentry *new = d_alloc(parent, name);
+	struct dentry *new = __d_alloc(parent->d_sb, name);
 	struct dentry *dentry;
 	unsigned seq, r_seq, d_seq;
 
 	if (unlikely(!new))
 		return ERR_PTR(-ENOMEM);
 
+	new->d_flags |= DCACHE_PAR_LOOKUP;
+	spin_lock(&parent->d_lock);
+	new->d_parent = dget_dlock(parent);
+	hlist_add_head(&new->d_sib, &parent->d_children);
+	spin_unlock(&parent->d_lock);
+
 retry:
 	rcu_read_lock();
 	seq = smp_load_acquire(&parent->d_inode->i_dir_seq);
@@ -2608,8 +2614,6 @@ struct dentry *d_alloc_parallel(struct dentry *parent,
 		return dentry;
 	}
 	rcu_read_unlock();
-	/* we can't take ->d_lock here; it's OK, though. */
-	new->d_flags |= DCACHE_PAR_LOOKUP;
 	new->d_wait = wq;
 	hlist_bl_add_head(&new->d_u.d_in_lookup_hash, b);
 	hlist_bl_unlock(b);
-- 
2.39.5


