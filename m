Return-Path: <linux-fsdevel+bounces-2474-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 623D77E63B9
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 07:21:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27EA9B20EDB
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 06:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EFAC101D5;
	Thu,  9 Nov 2023 06:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="k4COfvS+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8FF1D511
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Nov 2023 06:21:00 +0000 (UTC)
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A532426B3
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 Nov 2023 22:20:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=af420oe9NRQhAzfLHkPI5lOdq9yCGuAuQ/ZWtCMhJ3I=; b=k4COfvS+Ilyo7paai088t9Ieq9
	ETFO5fuEPgmu02k8AWx+u/lQrTEB/VoF7IlD/hjgLp7j/8tKRZTIOPHIG2G0rNTBLA227s0axdhez
	7OahiRPJuiF0YOQzW1ifpLFR+Wp2qygD8wC84lBrtbO00IVrYbRa58/JeVFPBLF26k5ECosW5p3ao
	HbQfeP2Z54QgwnPWHPxqWFjtBRoBWICO43lIzFfCfoLAuExiTBRn+TD/O8YoeJ0h+i6hp+zKS/X7D
	YA7VOfjuD0QebtxISisWE5EQb6iI7pYX51NNl+9Yk7Iww4u3/sZ04j/m1jnCCCZt4R2vNqKVuegcI
	Il7K0lTA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1r0yPR-00DLjT-0g;
	Thu, 09 Nov 2023 06:20:57 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>
Subject: [PATCH 07/22] shrink_dentry_list(): no need to check that dentry refcount is marked dead
Date: Thu,  9 Nov 2023 06:20:41 +0000
Message-Id: <20231109062056.3181775-7-viro@zeniv.linux.org.uk>
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

... we won't see DCACHE_MAY_FREE on anything that is *not* dead
and checking d_flags is just as cheap as checking refcount.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/dcache.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 1476f2d6e9ea..5371f32eb4bb 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -1186,11 +1186,10 @@ void shrink_dentry_list(struct list_head *list)
 		spin_lock(&dentry->d_lock);
 		rcu_read_lock();
 		if (!shrink_lock_dentry(dentry)) {
-			bool can_free = false;
+			bool can_free;
 			rcu_read_unlock();
 			d_shrink_del(dentry);
-			if (dentry->d_lockref.count < 0)
-				can_free = dentry->d_flags & DCACHE_MAY_FREE;
+			can_free = dentry->d_flags & DCACHE_MAY_FREE;
 			spin_unlock(&dentry->d_lock);
 			if (can_free)
 				dentry_free(dentry);
-- 
2.39.2


