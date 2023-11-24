Return-Path: <linux-fsdevel+bounces-3638-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D0F67F6C23
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 07:08:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E7F21C20DBC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 06:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52E39F9DF;
	Fri, 24 Nov 2023 06:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="s+KqJZmM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7467C1BC8;
	Thu, 23 Nov 2023 22:06:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=VjM8UELksu5zNpfR8ee4vJkJ+dnnCsDAYWeIQHyVnWY=; b=s+KqJZmMT4AjyS3g50E8FDl7os
	OzHLNeIhNja+T0e8HRuBxTMZ9FcZhHwBzSmSDHmWC4V7BHurM8hB6KGmXuORA1fdn/0SA+34jPGzR
	BN8eq1lRxOIdlLB72d1bhQ6r8nSo7PxkZzBIOwPqpWjxfUZ8yX9xR0KPVH9myEU/ifyQW+7LGZhN1
	chadDl4pZ1h6n4UPlVm0ptA8bNkS5aUMtXD1l+Nlah1VI3MzHpyc9jaIDFpQ2g2epuw6tZu03q6N5
	oJhV4C5VfHPmzdN3gdfq3F5oeWqQSrLq9ZPWInyCwKYGFPja/SYS9vRR4Sn4HjzVth1N0/OWzsvKl
	Ob5oFt9g==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1r6PKy-002Q1y-0D;
	Fri, 24 Nov 2023 06:06:48 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 19/20] kill DCACHE_MAY_FREE
Date: Fri, 24 Nov 2023 06:06:43 +0000
Message-Id: <20231124060644.576611-19-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231124060644.576611-1-viro@zeniv.linux.org.uk>
References: <20231124060553.GA575483@ZenIV>
 <20231124060644.576611-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

With the new ordering in __dentry_kill() it has become redundant -
it's set if and only if both DCACHE_DENTRY_KILLED and DCACHE_SHRINK_LIST
are set.

We set it in __dentry_kill(), after having set DCACHE_DENTRY_KILLED
with the only condition being that DCACHE_SHRINK_LIST is there;
all of that is done without dropping ->d_lock and the only place
that checks that flag (shrink_dentry_list()) does so under ->d_lock,
after having found the victim on its shrink list.  Since DCACHE_SHRINK_LIST
is set only when placing dentry into shrink list and removed only by
shrink_dentry_list() itself, a check for DCACHE_DENTRY_KILLED in
there would be equivalent to check for DCACHE_MAY_FREE.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/dcache.c            | 6 ++----
 include/linux/dcache.h | 1 -
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 26080f094508..64d8c1d36acb 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -614,10 +614,8 @@ static struct dentry *__dentry_kill(struct dentry *dentry)
 	}
 	spin_lock_nested(&dentry->d_lock, DENTRY_D_LOCK_NESTED);
 	dentry_unlist(dentry);
-	if (dentry->d_flags & DCACHE_SHRINK_LIST) {
-		dentry->d_flags |= DCACHE_MAY_FREE;
+	if (dentry->d_flags & DCACHE_SHRINK_LIST)
 		can_free = false;
-	}
 	spin_unlock(&dentry->d_lock);
 	if (likely(can_free))
 		dentry_free(dentry);
@@ -1072,7 +1070,7 @@ void shrink_dentry_list(struct list_head *list)
 			bool can_free;
 			rcu_read_unlock();
 			d_shrink_del(dentry);
-			can_free = dentry->d_flags & DCACHE_MAY_FREE;
+			can_free = dentry->d_flags & DCACHE_DENTRY_KILLED;
 			spin_unlock(&dentry->d_lock);
 			if (can_free)
 				dentry_free(dentry);
diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index b4449a1a47ff..48b393545ec2 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -202,7 +202,6 @@ struct dentry_operations {
 #define DCACHE_SPECIAL_TYPE		(5 << 20) /* Other file type */
 #define DCACHE_SYMLINK_TYPE		(6 << 20) /* Symlink */
 
-#define DCACHE_MAY_FREE			BIT(23)
 #define DCACHE_NOKEY_NAME		BIT(25) /* Encrypted name encoded without key */
 #define DCACHE_OP_REAL			BIT(26)
 
-- 
2.39.2


