Return-Path: <linux-fsdevel+bounces-1701-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 863E77DDC8A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Nov 2023 07:21:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F97F280FC3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Nov 2023 06:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 698427473;
	Wed,  1 Nov 2023 06:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="IF/ET1os"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF3BA53B1
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Nov 2023 06:21:20 +0000 (UTC)
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F940110
	for <linux-fsdevel@vger.kernel.org>; Tue, 31 Oct 2023 23:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=5+41tHy7ARJSzJbpFvlMd/+F3I2wESoLEQET99y7ENA=; b=IF/ET1osNBXHMSXZTgh0s22czi
	UzzfdfolujQUIWQMGdxi/E3G7HQ/JBwG/fyXioe7W5IFhvTBXoxIq7wWMY/bMS8UlSCGC0400gFr+
	zjsL9FdOzR8ghCY0J4HdyfOfkxB4GG/YQu6o9k4R9gVa4HPDV0CfIbxiMMei+Hwsr74LlIjdlp8G6
	igsguH9glo9bRuhnI2utCEYxeEHKyNXmAwDBIvX3FJ37W7ZfBvlXwfvJzVYfSS0OGp/cp/4BuHYrS
	tJWbE4UQ4QPsQ6UHf47vGp9rbUHPQgyCqsrYkg1l/twdGKue0zlMkJg+1ZAzgi71iF9tV0a/3lAzQ
	8xZimZnA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1qy4bC-008pbj-0F;
	Wed, 01 Nov 2023 06:21:06 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org
Subject: [PATCH 11/15] fold dentry_kill() into dput()
Date: Wed,  1 Nov 2023 06:21:00 +0000
Message-Id: <20231101062104.2104951-11-viro@zeniv.linux.org.uk>
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

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/dcache.c | 37 ++++++++++++-------------------------
 1 file changed, 12 insertions(+), 25 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 5fd6162cd994..5114514b13da 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -756,28 +756,6 @@ void d_mark_dontcache(struct inode *inode)
 }
 EXPORT_SYMBOL(d_mark_dontcache);
 
-/*
- * Finish off a dentry we've decided to kill.
- * dentry->d_lock must be held, returns with it unlocked.
- * Returns dentry requiring refcount drop, or NULL if we're done.
- */
-static struct dentry *dentry_kill(struct dentry *dentry)
-	__releases(dentry->d_lock)
-{
-
-	dentry->d_lockref.count--;
-	rcu_read_lock();
-	if (likely(lock_for_kill(dentry))) {
-		struct dentry *parent = dentry->d_parent;
-		rcu_read_unlock();
-		__dentry_kill(dentry);
-		return parent != dentry ? parent : NULL;
-	}
-	rcu_read_unlock();
-	spin_unlock(&dentry->d_lock);
-	return NULL;
-}
-
 /*
  * Try to do a lockless dput(), and return whether that was successful.
  *
@@ -915,9 +893,18 @@ void dput(struct dentry *dentry)
 		}
 
 		/* Slow case: now with the dentry lock held */
-		rcu_read_unlock();
-		dentry->d_lockref.count = 1;
-		dentry = dentry_kill(dentry);
+		if (likely(lock_for_kill(dentry))) {
+			struct dentry *parent = dentry->d_parent;
+			rcu_read_unlock();
+			__dentry_kill(dentry);
+			if (dentry == parent)
+				return;
+			dentry = parent;
+		} else {
+			rcu_read_unlock();
+			spin_unlock(&dentry->d_lock);
+			return;
+		}
 	}
 }
 EXPORT_SYMBOL(dput);
-- 
2.39.2


