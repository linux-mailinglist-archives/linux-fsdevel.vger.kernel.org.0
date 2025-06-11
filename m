Return-Path: <linux-fsdevel+bounces-51251-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D6E7AD4D9A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 09:56:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A3C2179D51
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 07:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD0F0246769;
	Wed, 11 Jun 2025 07:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="p2QHrBls"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 523D223BCE3
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Jun 2025 07:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749628483; cv=none; b=dxj8Ny3UfLbGoaynwFcU3upD+dxOX25UEArfbUbv4f4qrSPisMTQCd5GpMTLALZGe4RUdh8/7GugSfVXmxgYVkFGOIfelUO9euqZa+5tn4jaOXQ14eQGUoWTHqF8FRXDzNJQKLbd9sIAIacZb05dhHwgd7vjZmnG89bmO8Yy85k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749628483; c=relaxed/simple;
	bh=wioCNSFL36qVcWXFlsW69uDy0xOWebFyv/XA9McWPzs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LM/7PiIaeLniUpu8NZ3cIOymmkA8RrbfFUgpHwRutFl1vxoiKJvwLKbAgLy0KwOtRSktNfOMg7lDJm2sT4ZZj+RW2/EPoeuPAzYKmLEuJaK0ezNQn62T7jLgvOUDkcQkbEwdsTcBl+cSsQsGxtDrZJnxU4953FuGSNQDdTGdpD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=p2QHrBls; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=almHv/6FJ9jAiArHciD6tl1FxvZW0VAsFdJv3Hz+ENE=; b=p2QHrBlsegy/PR4/Fz/XXT8gmW
	VX4P1Bw4UrOtm447g98vB8xTubxk5FPiS7nygZbjupNvE64/+xjinVsSUf0V1TlUFuzGPUYwi2Na1
	Yv0E7b8fAxsQjgxE56WBuIP+5HT5e3IlyMqMf5Fl2CyShk3SWl+t6npVad6SjSRfRxLPsNR9iplLl
	QOl9figqPx/H9UYkLHQh9ANAgCiBiZnRMI9hi1mW2TF5u08ECTp4aQ4Gv4ro2FcQUcLSBC5qT/xiJ
	D0pN48YmIhUfYdTf9+y7kxzfGE5MBPwEyOI7ZCObkNpYvIUHeWPxiFGTMW06hRdrErtryZKZhjt7d
	/P9Lb7zw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPGIB-0000000HTxc-2N6E;
	Wed, 11 Jun 2025 07:54:39 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	jack@suse.cz,
	miklos@szeredi.hu,
	neilb@suse.de,
	torvalds@linux-foundation.org
Subject: [PATCH v2 12/21] d_alloc_parallel(): set DCACHE_PAR_LOOKUP earlier
Date: Wed, 11 Jun 2025 08:54:28 +0100
Message-ID: <20250611075437.4166635-12-viro@zeniv.linux.org.uk>
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
with !hlist_bl_unhashed(&victim->d_u.d_in_lookup_hash).  Might
be worth considering later...

Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/dcache.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 4e6ab27471a4..2adac023ba23 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -2546,13 +2546,19 @@ struct dentry *d_alloc_parallel(struct dentry *parent,
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
@@ -2636,8 +2642,6 @@ struct dentry *d_alloc_parallel(struct dentry *parent,
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


