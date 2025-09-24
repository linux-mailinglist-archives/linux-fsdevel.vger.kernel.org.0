Return-Path: <linux-fsdevel+bounces-62551-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9199CB990B3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 11:10:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AA2619C1830
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 09:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9DA72D592A;
	Wed, 24 Sep 2025 09:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KZrCJIw2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D4A328136C
	for <linux-fsdevel@vger.kernel.org>; Wed, 24 Sep 2025 09:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758705013; cv=none; b=BXDi5K500vtLIq3rAW0s/9qsGfxdaguoXwuqKRwceARt4VGL4oH93r5OaBXL/NvmsqvfA4fFOEjcjBJOzk45CwcubQwbk+gpxP0v2LvveueyFahazMhdgY8avpRodLQHYojXBR87u+UI7pvJEZw4nUhPTFmnq0xRteUh/5FaFao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758705013; c=relaxed/simple;
	bh=xyeXTfpmfjXpSpo49hIBy1glBhX3Wg4JmR8Q4tOMJxQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dG6vj701u8qYqGwsIlMuKXCmMDopJE9QrLPBO1c61a0QB8oGzgEpU8ZguqvVX8f8QWNJTXQxNFTyYuSX6kALZtBv074Qi2fFIE1m7q6LFCyGmNPqwHxZ5gLrWG6j8bLApe3H6dLLaRx17yWqmUH52gZEqTWcUdm5JAQ4WMGX/60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=KZrCJIw2; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=rWALANFejkYC9zCl1Cl5RWrOmghprGcCTBnO6yOGl5I=; b=KZrCJIw2O490F9xKgM7/EtRuPV
	WmOQKpUhev3LsFY5Fw0M/5YHCl/NtBmbT302Ce21Glpk2pIvwj7Bl9JY1Jd2MLzK055aoseZMKVGM
	6G7MEe79kvS33785kuX/OXIf8XgOPx3i7NZDg/v8IvXCFQoo/fHk1Zso2pzCkneOq/jJhVvNQibf8
	WL8G44OMaN/lji+iPsJsNtbX6qvWFXsGOde8UmdEdEpoJ6KDjsDYADDJStdMLYZaOzZdsnEY6wE7Y
	8Jo4PgYrjs/D7i3C6KVoxLxW3Ol90u8onJQ/3YZv973/TcCp131WTYxmM9RC3E1Hnfx2bu97R9V9n
	JnK4zoSw==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1LVj-0000000CXGa-0aKU;
	Wed, 24 Sep 2025 09:10:03 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-fsdevel@vger.kernel.org,
	Dave Chinner <david@fromorbit.com>
Subject: [RFC PATCH 2/2] fs: Defer evicting inodes to a workqueue
Date: Wed, 24 Sep 2025 10:09:57 +0100
Message-ID: <20250924091000.2987157-3-willy@infradead.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250924091000.2987157-1-willy@infradead.org>
References: <20250924091000.2987157-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If we're in memory reclaim, evicting inodes is actually a bad idea.
The filesystem may need to allocate more memory to evict the inode
than it will free by evicting the inode.  It's better to defer
evicting the inode until a workqueue has time to run.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/inode.c | 36 ++++++++++++++++++++++++++++++++++--
 1 file changed, 34 insertions(+), 2 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index 9d882b0fc787..fe7899cdd50c 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -854,6 +854,34 @@ static void dispose_list(struct list_head *head)
 	}
 }
 
+static DEFINE_SPINLOCK(deferred_inode_lock);
+static LIST_HEAD(deferred_inode_list);
+
+static void dispose_inodes_wq(struct work_struct *work)
+{
+	LIST_HEAD(dispose);
+
+	spin_lock_irq(&deferred_inode_lock);
+	list_splice_init(&deferred_inode_list, &dispose);
+	spin_unlock_irq(&deferred_inode_lock);
+
+	dispose_list(&dispose);
+}
+
+static DECLARE_WORK(dispose_inode_work, dispose_inodes_wq);
+
+static void deferred_dispose_inodes(struct list_head *inodes)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&deferred_inode_lock, flags);
+	list_splice_tail(inodes, &deferred_inode_list);
+	spin_unlock_irqrestore(&deferred_inode_lock, flags);
+
+	printk("deferring some inodes\n");
+	schedule_work(&dispose_inode_work);
+}
+
 /**
  * evict_inodes	- evict all evictable inodes for a superblock
  * @sb:		superblock to operate on
@@ -897,13 +925,17 @@ void evict_inodes(struct super_block *sb)
 		if (need_resched()) {
 			spin_unlock(&sb->s_inode_list_lock);
 			cond_resched();
-			dispose_list(&dispose);
+			if (!in_reclaim())
+				dispose_list(&dispose);
 			goto again;
 		}
 	}
 	spin_unlock(&sb->s_inode_list_lock);
 
-	dispose_list(&dispose);
+	if (!in_reclaim())
+		dispose_list(&dispose);
+	else
+		deferred_dispose_inodes(&dispose);
 }
 EXPORT_SYMBOL_GPL(evict_inodes);
 
-- 
2.47.2


