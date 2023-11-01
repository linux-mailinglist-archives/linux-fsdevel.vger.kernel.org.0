Return-Path: <linux-fsdevel+bounces-1692-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 012547DDC81
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Nov 2023 07:21:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E133B21178
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Nov 2023 06:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7022F5681;
	Wed,  1 Nov 2023 06:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="MEy9hrrp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 721914C7D
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Nov 2023 06:21:14 +0000 (UTC)
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 753CD107
	for <linux-fsdevel@vger.kernel.org>; Tue, 31 Oct 2023 23:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=SvPxrMZFAiSVcjZWENm2ZenEXh8APeZaBdN2UZkjwDo=; b=MEy9hrrpouORBCSjxbR+1Mk/t4
	4odDq918z9AKf5e7no7jg/ShROfE0/IRA5V0zcBPggSTuMLpZlUbfyA4n70S/EcyUk/x4nOxZ2oGq
	J7ulQ0JIuWdxg72TtPwWxrvtwGvykFvnu+eCw89yvT/UnUfZH2DLoLG2K/V0a34FRc/mEY6GkAC/I
	PyJ4QCpRf2QZ7nW/WT4NxKg6Fx2F7/zTKdCXc6WLuMjh6ZPfFy89yG5W8g75wDqD6XaKtm0OWH8n+
	Zy8jOlLUPu9XHvkHaPXqXmlHML2jyLyKmkqCcFLttHfF+IZ3XhHFCp11Z7BVWTwr/Gc1PVHqLHJ5n
	+LBVw3/g==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1qy4bB-008pbD-0T;
	Wed, 01 Nov 2023 06:21:05 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org
Subject: [PATCH 05/15] retain_dentry(): lift decrement of ->d_count into callers
Date: Wed,  1 Nov 2023 06:20:54 +0000
Message-Id: <20231101062104.2104951-5-viro@zeniv.linux.org.uk>
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
 fs/dcache.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 3a160717620b..0114b5195535 100644
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


