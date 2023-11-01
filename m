Return-Path: <linux-fsdevel+bounces-1699-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 02D667DDC88
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Nov 2023 07:21:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98A57B21464
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Nov 2023 06:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 636706FC9;
	Wed,  1 Nov 2023 06:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Jr+ZZ8Ah"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B8D5690
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Nov 2023 06:21:21 +0000 (UTC)
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14910119
	for <linux-fsdevel@vger.kernel.org>; Tue, 31 Oct 2023 23:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=Ec0+hq0KYAliWa6/Vo79r/vvLGP1Ij7F88cec1tangk=; b=Jr+ZZ8AhaKDvO6jpkpKem1R1RU
	apgXwlzhweUErsu5B68F3oqi477dZtuwHj++gSr+vsi5zZAwH48/e4Td9LdHii8qsxicB97oCnbPz
	52b2kRtRZKsIXthDr8I8V12f5U3QCgK9kFpf4SqJiZohS8p2iy7lFCRz1r9xUfKVeste29bvX7eLa
	668d0a7NTfxDRh6iMOb7MLgLTKR+Qnpm4gDFdcLpGfDYEvkEbMiEbdOdsuWTW+BhYrYXgv56E02XO
	8u0BOs1OjEIEaRsEtGmNEjiy4imfLrvLhYP4kapaoB/yBBcGFfQbXOGXkBIEfOLOPO5xoA6F51qWC
	OL8I1i2g==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1qy4bC-008pbz-1j;
	Wed, 01 Nov 2023 06:21:06 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org
Subject: [PATCH 14/15] to_shrink_list(): call only if refcount is 0
Date: Wed,  1 Nov 2023 06:21:03 +0000
Message-Id: <20231101062104.2104951-14-viro@zeniv.linux.org.uk>
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

The only thing it does if refcount is not zero is d_lru_del(); no
point, IMO, seeing that plain dput() does nothing of that sort...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/dcache.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 19f6eb6f2bde..7c763a8c916b 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -915,8 +915,7 @@ __must_hold(&dentry->d_lock)
 	if (!(dentry->d_flags & DCACHE_SHRINK_LIST)) {
 		if (dentry->d_flags & DCACHE_LRU_LIST)
 			d_lru_del(dentry);
-		if (!dentry->d_lockref.count)
-			d_shrink_add(dentry, list);
+		d_shrink_add(dentry, list);
 	}
 }
 
@@ -1128,10 +1127,8 @@ void shrink_dentry_list(struct list_head *list)
 		rcu_read_unlock();
 		d_shrink_del(dentry);
 		parent = dentry->d_parent;
-		if (parent != dentry) {
-			--parent->d_lockref.count;
+		if (parent != dentry && !--parent->d_lockref.count)
 			to_shrink_list(parent, list);
-		}
 		__dentry_kill(dentry);
 	}
 }
@@ -1577,10 +1574,9 @@ void shrink_dcache_parent(struct dentry *parent)
 			} else {
 				rcu_read_unlock();
 				parent = data.victim->d_parent;
-				if (parent != data.victim) {
-					--parent->d_lockref.count;
+				if (parent != data.victim &&
+				    !--parent->d_lockref.count)
 					to_shrink_list(parent, &data.dispose);
-				}
 				__dentry_kill(data.victim);
 			}
 		}
-- 
2.39.2


