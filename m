Return-Path: <linux-fsdevel+bounces-1702-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2E747DDC8B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Nov 2023 07:21:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DC83281B6D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Nov 2023 06:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDA6A63AF;
	Wed,  1 Nov 2023 06:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="UGTSWsCL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63DE15680
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Nov 2023 06:21:21 +0000 (UTC)
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8FE7118
	for <linux-fsdevel@vger.kernel.org>; Tue, 31 Oct 2023 23:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=a2WT2+Nor5ArukZaydSgJmmgdwCRxURWcNILbRX7aiw=; b=UGTSWsCLP8cagzaZ16jwbMWSxq
	vFKCLp9wzg9gxuuueY0fz0rZ5OghQAdnpzIJ5oC9h9TQ6OXJhu3/Bwa0s89/aYLC1sZ1SLszlpsAL
	tTnKAPaC4wWRZUOePLr5ab7gVif3VihAilDvdmS8gnnWmbYN9wtgg2irl+Ru+q/njaLRAGOy4xExx
	QszBQNpJEq+/sHH4n3zLch3UrNQ9bMCmUj52QApLdVJP7Rkoy4LEXSYNwkJWNLItW++jT5xw7fW7/
	cbmFSfM3GgNukSxH9YDXsaG/bqEX6G5Za12aEYpB/8dBg01BInS8LnSs3NIFTpBAmfBWYSLzyIXcC
	zvEsaPyw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1qy4bC-008pbt-1J;
	Wed, 01 Nov 2023 06:21:06 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org
Subject: [PATCH 13/15] shrink_dentry_list(): no need to check that dentry refcount is marked dead
Date: Wed,  1 Nov 2023 06:21:02 +0000
Message-Id: <20231101062104.2104951-13-viro@zeniv.linux.org.uk>
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

... we won't see DCACHE_MAY_FREE on anything that is *not* dead
and checking d_flags is just as cheap as checking d_count.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/dcache.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 49b3fd27559f..19f6eb6f2bde 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -1116,11 +1116,10 @@ void shrink_dentry_list(struct list_head *list)
 		spin_lock(&dentry->d_lock);
 		rcu_read_lock();
 		if (!lock_for_kill(dentry)) {
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


