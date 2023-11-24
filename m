Return-Path: <linux-fsdevel+bounces-3602-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D1447F6BEE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 07:04:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EDC81C20D54
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 06:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0F6E9461;
	Fri, 24 Nov 2023 06:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="pumoDACQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 539EDD73;
	Thu, 23 Nov 2023 22:04:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=YQd0sVENc8vNXo6fQBPFKWdKkcW/WYyDOS5A5P7KNmA=; b=pumoDACQA2Uo0ujIWHZBRBpsgm
	CZIGBoegoxuq/d30GAq6Pi5W9phVZkI7LreLbyXIKup34Nd8DtH9JcV8CyglqU0JPfXFNfEr8vYZD
	tOUh404G2VjiwZG4fn9moucUogjH5HFCkaGYOrzlSSBwY1Gt8Jc4Vy8larIdFXnzqT9uQ6wRNbwmU
	GvjuGMEnaozVB/LnO+/w5Pdx5x9QyD+G5vwl4EmeGHg5kWYkvEavOcPWbQ3RAjqWg3z8vpEgcrdxZ
	uK/ARVrauObzOsxj0o2xrC7b2PtjuPv7LhwAozlxKTcYoSU6UphF3qmv6pWeAJdEaH+oDAjx/1BZk
	KhJHS4GA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1r6PIc-002Ptn-32;
	Fri, 24 Nov 2023 06:04:23 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 04/21] centralize killing dentry from shrink list
Date: Fri, 24 Nov 2023 06:04:05 +0000
Message-Id: <20231124060422.576198-4-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231124060422.576198-1-viro@zeniv.linux.org.uk>
References: <20231124060200.GR38156@ZenIV>
 <20231124060422.576198-1-viro@zeniv.linux.org.uk>
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

Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/dcache.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 59f76c9a15d1..bb862a304e1b 100644
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


