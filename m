Return-Path: <linux-fsdevel+bounces-2481-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 834DE7E63BE
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 07:21:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B35CE1C208C5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 06:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05CC21095B;
	Thu,  9 Nov 2023 06:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="FZZimF2D"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC64DF65
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Nov 2023 06:21:02 +0000 (UTC)
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 739BF26BA
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 Nov 2023 22:20:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=Dl1U3hsH+ZZfRd8OQK17UqFasenI4TzgwGl6eAgyezU=; b=FZZimF2D3bQU5OupCF+kBO0iZL
	oRZJX9FBbyB7SNba4FSF3SECK5Qw3xz/9eRl1kDCK2NzHIlnIcZOwO3TgNYGFOZtvOkYOd7TWbFte
	cqeAFW56Fs5tGmvHQPV5xFRiQHqXpWq0nFY7QpWcSm2fuN1cOxizhDKoyT5BXxIQhZBjSxxkFSPK1
	inipJGVgfYhcN016X902Euxf0x1bPZBa3yMkYUm+Y1GnLAqg5W6Qh10lriSQQoD0DJBiIb66fh96V
	KoJFRatwC0Me6rHdiBV7qHF9kM8YeZpag2n11eylTVP7n6wzDp78UsXTRc13p3a0MJdx17OK8Y5F8
	rerpXDFA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1r0yPS-00DLjz-02;
	Thu, 09 Nov 2023 06:20:58 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>
Subject: [PATCH 12/22] Make retain_dentry() neutral with respect to refcounting
Date: Thu,  9 Nov 2023 06:20:46 +0000
Message-Id: <20231109062056.3181775-12-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231109062056.3181775-1-viro@zeniv.linux.org.uk>
References: <20231109061932.GA3181489@ZenIV>
 <20231109062056.3181775-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

retain_dentry() used to decrement refcount if and only if it returned
true.  Lift those decrements into the callers.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/dcache.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 1899376d0189..1f61a5d03d5b 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -680,7 +680,6 @@ static inline bool retain_dentry(struct dentry *dentry)
 		return false;
 
 	/* retain; LRU fodder */
-	dentry->d_lockref.count--;
 	if (unlikely(!(dentry->d_flags & DCACHE_LRU_LIST)))
 		d_lru_add(dentry);
 	else if (unlikely(!(dentry->d_flags & DCACHE_REFERENCED)))
@@ -744,6 +743,8 @@ static struct dentry *dentry_kill(struct dentry *dentry)
 	} else if (likely(!retain_dentry(dentry))) {
 		__dentry_kill(dentry);
 		return parent;
+	} else {
+		dentry->d_lockref.count--;
 	}
 	/* we are keeping it, after all */
 	if (inode)
@@ -893,6 +894,7 @@ void dput(struct dentry *dentry)
 		rcu_read_unlock();
 
 		if (likely(retain_dentry(dentry))) {
+			dentry->d_lockref.count--;
 			spin_unlock(&dentry->d_lock);
 			return;
 		}
@@ -925,6 +927,8 @@ void dput_to_list(struct dentry *dentry, struct list_head *list)
 	if (!retain_dentry(dentry)) {
 		--dentry->d_lockref.count;
 		to_shrink_list(dentry, list);
+	} else {
+		--dentry->d_lockref.count;
 	}
 	spin_unlock(&dentry->d_lock);
 }
-- 
2.39.2


