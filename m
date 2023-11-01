Return-Path: <linux-fsdevel+bounces-1693-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20BAB7DDC82
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Nov 2023 07:21:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8241DB21270
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Nov 2023 06:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75A666130;
	Wed,  1 Nov 2023 06:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="uOpuA62q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22AA44C77
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Nov 2023 06:21:14 +0000 (UTC)
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65AE8103
	for <linux-fsdevel@vger.kernel.org>; Tue, 31 Oct 2023 23:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=PB+QJiXgv7sl+bi1VPVybedtn0XOVtO2m/ve7LmZ9Uo=; b=uOpuA62qeF33kd5aTwUvz7n0SU
	sn2Rn5E/VzV8e7j0ahY0LPKGPc7JgTYkU/yhhP8NSJ6iBYm+tts7jfRuba68PvHxATqsZb3690qv1
	DjrxNknil1J9Ilf4/lfPwSmttdKY2RSy3mGWlKbpoUxh6pWy45J6XxPo0dqLQT6B2A/OPTDymNAcf
	AuJxeEPSp9Ctaz0DQYWLsb/rUrYBvs5ZpXgTXXxW6MQeyHaCc9IWpvo9Cb2d83YiNiO0YKN4CnGiO
	pkaBsNNpkhSOIhnq1b3ii5shURgt1hA3sFOuSo6CUq71HXzmS3fXiB5X7wAeYGhOk9W6tdB1ZJu0D
	0DaBSTRA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1qy4bB-008pb9-04;
	Wed, 01 Nov 2023 06:21:05 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org
Subject: [PATCH 04/15] __dput_to_list(): do decrement of refcount in the caller
Date: Wed,  1 Nov 2023 06:20:53 +0000
Message-Id: <20231101062104.2104951-4-viro@zeniv.linux.org.uk>
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

... and rename it to to_shrink_list(), seeing that it no longer
does dropping any references

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/dcache.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 4108312f2426..3a160717620b 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -902,16 +902,13 @@ void dput(struct dentry *dentry)
 }
 EXPORT_SYMBOL(dput);
 
-static void __dput_to_list(struct dentry *dentry, struct list_head *list)
+static void to_shrink_list(struct dentry *dentry, struct list_head *list)
 __must_hold(&dentry->d_lock)
 {
-	if (dentry->d_flags & DCACHE_SHRINK_LIST) {
-		/* let the owner of the list it's on deal with it */
-		--dentry->d_lockref.count;
-	} else {
+	if (!(dentry->d_flags & DCACHE_SHRINK_LIST)) {
 		if (dentry->d_flags & DCACHE_LRU_LIST)
 			d_lru_del(dentry);
-		if (!--dentry->d_lockref.count)
+		if (!dentry->d_lockref.count)
 			d_shrink_add(dentry, list);
 	}
 }
@@ -925,8 +922,10 @@ void dput_to_list(struct dentry *dentry, struct list_head *list)
 	}
 	rcu_read_unlock();
 	dentry->d_lockref.count = 1;
-	if (!retain_dentry(dentry))
-		__dput_to_list(dentry, list);
+	if (!retain_dentry(dentry)) {
+		--dentry->d_lockref.count;
+		to_shrink_list(dentry, list);
+	}
 	spin_unlock(&dentry->d_lock);
 }
 
@@ -1184,8 +1183,10 @@ void shrink_dentry_list(struct list_head *list)
 		rcu_read_unlock();
 		d_shrink_del(dentry);
 		parent = dentry->d_parent;
-		if (parent != dentry)
-			__dput_to_list(parent, list);
+		if (parent != dentry) {
+			--parent->d_lockref.count;
+			to_shrink_list(parent, list);
+		}
 		__dentry_kill(dentry);
 	}
 }
@@ -1631,8 +1632,10 @@ void shrink_dcache_parent(struct dentry *parent)
 			} else {
 				rcu_read_unlock();
 				parent = data.victim->d_parent;
-				if (parent != data.victim)
-					__dput_to_list(parent, &data.dispose);
+				if (parent != data.victim) {
+					--parent->d_lockref.count;
+					to_shrink_list(parent, &data.dispose);
+				}
 				__dentry_kill(data.victim);
 			}
 		}
-- 
2.39.2


