Return-Path: <linux-fsdevel+bounces-2473-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E6A357E63B6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 07:21:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E844281288
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 06:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89FEBF512;
	Thu,  9 Nov 2023 06:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="AHpWUzRt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 477DFD307
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Nov 2023 06:20:59 +0000 (UTC)
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EFA626B1
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 Nov 2023 22:20:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=DTPyMFGMxqBUgkHNvTYyVNefwv3L9prayceKiT3qoA4=; b=AHpWUzRtKADJjdHAlLJP7IkAto
	klZcLKZsRZ2J4BWCZ0wgMwCvbWAVlo0rkBFF3YWIrPSFr4cRGVmXaltvhkjfSOm/onK5tcgBqnrxw
	cr/6XMMTQ9Va59p/nMKHL28iKARkxtYSVql2HciNCAhwDDnd0HT2DQ/4PBOZKxZZWm/sw5IK8dn1M
	UeFINxU579KzQTXCbe3STAyH2cNer6OR+5DSQO3LoiP96np1LL+W7M4eZ04yVeQiNi463CNSyfDj7
	0meWMnKC3TVF9vTaQoTVjeiAvv7UKyUpuBbRCdl2GKMB/pMafPzw40rgv2UkeMyP5v+EoSkAD5xRz
	uoeF/ZUg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1r0yPQ-00DLjJ-32;
	Thu, 09 Nov 2023 06:20:56 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>
Subject: [PATCH 05/22] centralize killing dentry from shrink list
Date: Thu,  9 Nov 2023 06:20:39 +0000
Message-Id: <20231109062056.3181775-5-viro@zeniv.linux.org.uk>
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

new helper unifying identical bits of shrink_dentry_list() and
shring_dcache_for_umount()

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/dcache.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 1b8ec1a9bf1c..56af55f2b7d9 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -1174,10 +1174,18 @@ static bool shrink_lock_dentry(struct dentry *dentry)
 	return false;
 }
 
+static inline void shrink_kill(struct dentry *victim, struct list_head *list)
+{
+	struct dentry *parent = victim->d_parent;
+	if (parent != victim)
+		__dput_to_list(parent, list);
+	__dentry_kill(victim);
+}
+
 void shrink_dentry_list(struct list_head *list)
 {
 	while (!list_empty(list)) {
-		struct dentry *dentry, *parent;
+		struct dentry *dentry;
 
 		dentry = list_entry(list->prev, struct dentry, d_lru);
 		spin_lock(&dentry->d_lock);
@@ -1195,10 +1203,7 @@ void shrink_dentry_list(struct list_head *list)
 		}
 		rcu_read_unlock();
 		d_shrink_del(dentry);
-		parent = dentry->d_parent;
-		if (parent != dentry)
-			__dput_to_list(parent, list);
-		__dentry_kill(dentry);
+		shrink_kill(dentry, list);
 	}
 }
 
@@ -1629,17 +1634,13 @@ void shrink_dcache_parent(struct dentry *parent)
 		data.victim = NULL;
 		d_walk(parent, &data, select_collect2);
 		if (data.victim) {
-			struct dentry *parent;
 			spin_lock(&data.victim->d_lock);
 			if (!shrink_lock_dentry(data.victim)) {
 				spin_unlock(&data.victim->d_lock);
 				rcu_read_unlock();
 			} else {
 				rcu_read_unlock();
-				parent = data.victim->d_parent;
-				if (parent != data.victim)
-					__dput_to_list(parent, &data.dispose);
-				__dentry_kill(data.victim);
+				shrink_kill(data.victim, &data.dispose);
 			}
 		}
 		if (!list_empty(&data.dispose))
-- 
2.39.2


