Return-Path: <linux-fsdevel+bounces-1691-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16FFA7DDC80
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Nov 2023 07:21:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFA552810D7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Nov 2023 06:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B6BF5675;
	Wed,  1 Nov 2023 06:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="KwiIsE6J"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A1E65224
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Nov 2023 06:21:17 +0000 (UTC)
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 047D910A
	for <linux-fsdevel@vger.kernel.org>; Tue, 31 Oct 2023 23:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=V//OsntlN/Gep20c5b55GzSyavMNgG4NgGG0fgQjpcU=; b=KwiIsE6Jce/0SVmi7gjQIn1rE5
	Dgi4yrEBZTxJE8Hwm4S4ui0ST0VMU3KMP7QMcykvsBh0PvkA1CThdiedShpM/z5WBvYR1QEckS0XJ
	h9k7lajhluf5m8AXHSZkVrUjXtE26dUi0auzX9DeqkxRH5R7EKtdISUq0VVUY2/MZw2gzp21vyA8D
	0AYUngX0ce5ttwCfinOCAVC/9ciFQ3a6ken2bytQNTtKCnxPPi9uPbw/JVoXPqrMbgXDcmTr062iY
	aopjNWM9l0H/3GH9PXojhNVUOgiIm5RkAsei0F37uDEsJCtPASVAKcR/ry92saB42PzlqELrMyz4v
	KUXyb7RA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1qy4bB-008pbN-1Q;
	Wed, 01 Nov 2023 06:21:05 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org
Subject: [PATCH 07/15] dentry_kill(): don't bother with retain_dentry() on slow path
Date: Wed,  1 Nov 2023 06:20:56 +0000
Message-Id: <20231101062104.2104951-7-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231101062104.2104951-1-viro@zeniv.linux.org.uk>
References: <20231031061226.GC1957730@ZenIV>
 <20231101062104.2104951-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

We have already checked it and dentry used to look not worthy
of keeping.  The only hard obstacle to evicting dentry is
non-zero refcount; everything else is advisory - e.g. memory
pressure could evict any dentry found with refcount zero.
On the slow path in dentry_kill() we had dropped and regained
->d_lock; we must recheck the refcount, but everything else
is not worth bothering with.

Note that filesystem can not count upon ->d_delete() being
called for dentry - not even once.  Again, memory pressure
(as well as d_prune_aliases(), or attempted rmdir() of ancestor,
or...) will not call ->d_delete() at all.

So from the correctness point of view we are fine doing the
check only once.  And it makes things simpler down the road.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/dcache.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index c89337ae30ce..7931f5108581 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -739,14 +739,10 @@ static struct dentry *dentry_kill(struct dentry *dentry)
 	spin_lock(&dentry->d_lock);
 	parent = lock_parent(dentry);
 got_locks:
-	if (unlikely(dentry->d_lockref.count != 1)) {
-		dentry->d_lockref.count--;
-	} else if (likely(!retain_dentry(dentry))) {
-		dentry->d_lockref.count--;
+	dentry->d_lockref.count--;
+	if (likely(dentry->d_lockref.count == 0)) {
 		__dentry_kill(dentry);
 		return parent;
-	} else {
-		dentry->d_lockref.count--;
 	}
 	/* we are keeping it, after all */
 	if (inode)
-- 
2.39.2


