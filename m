Return-Path: <linux-fsdevel+bounces-3827-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 05C927F8E8B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Nov 2023 21:12:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 373931C20A5E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Nov 2023 20:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C14F2FE3B;
	Sat, 25 Nov 2023 20:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="N14uncTx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 201E8182;
	Sat, 25 Nov 2023 12:11:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=MXd1D7yrhiKOU6TnSrHtQJWPS/0VvoZfIFu1ppuy74Y=; b=N14uncTx4JMNyU5OFWglHbH2bZ
	0AgVwOC6P/HTaLgEyAMcnsSEHNPqqJ0PSE/6p1B/GZE2P4/ZgTrAigHx/9GIW0ChEIfdFEch7D5fS
	EGSRaN+92wJ955vDqvPJO9sGjRTxwn+b5xoE0eguizSQCrYL6RyGN/h26EwYfYNQabRqAjVLQcJjH
	ne+P2/ky55mbFPomJSmnCfz3TC190ihS+5jUc4fpzCMlSYK0S4uMfCzLNdbh7sGP5fopwTkW1XBa4
	yXND41vhkQNjTyNM0vHFefNTDc8Dk58QYkXBgpeDW1ZZKTW+Z8a55b68RzQEc3Yn6k/VFoUNJr0EP
	sful3ZWw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1r6z0G-003A53-2T;
	Sat, 25 Nov 2023 20:11:48 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Mo Zou <lostzoumo@gmail.com>,
	Jan Kara <jack@suse.cz>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 8/9] kill lock_two_inodes()
Date: Sat, 25 Nov 2023 20:11:46 +0000
Message-Id: <20231125201147.753695-8-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231125201147.753695-1-viro@zeniv.linux.org.uk>
References: <20231125201015.GA38156@ZenIV>
 <20231125201147.753695-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

There's only one caller left (lock_two_nondirectories()), and it
needs less complexity.  Fold lock_two_inodes() in there and
simplify.

Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/inode.c    | 49 ++++++-------------------------------------------
 fs/internal.h |  2 --
 2 files changed, 6 insertions(+), 45 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index edcd8a61975f..453d5be1a014 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -1087,48 +1087,6 @@ void discard_new_inode(struct inode *inode)
 }
 EXPORT_SYMBOL(discard_new_inode);
 
-/**
- * lock_two_inodes - lock two inodes (may be regular files but also dirs)
- *
- * Lock any non-NULL argument. The caller must make sure that if he is passing
- * in two directories, one is not ancestor of the other.  Zero, one or two
- * objects may be locked by this function.
- *
- * @inode1: first inode to lock
- * @inode2: second inode to lock
- * @subclass1: inode lock subclass for the first lock obtained
- * @subclass2: inode lock subclass for the second lock obtained
- */
-void lock_two_inodes(struct inode *inode1, struct inode *inode2,
-		     unsigned subclass1, unsigned subclass2)
-{
-	if (!inode1 || !inode2) {
-		/*
-		 * Make sure @subclass1 will be used for the acquired lock.
-		 * This is not strictly necessary (no current caller cares) but
-		 * let's keep things consistent.
-		 */
-		if (!inode1)
-			swap(inode1, inode2);
-		goto lock;
-	}
-
-	/*
-	 * If one object is directory and the other is not, we must make sure
-	 * to lock directory first as the other object may be its child.
-	 */
-	if (S_ISDIR(inode2->i_mode) == S_ISDIR(inode1->i_mode)) {
-		if (inode1 > inode2)
-			swap(inode1, inode2);
-	} else if (!S_ISDIR(inode1->i_mode))
-		swap(inode1, inode2);
-lock:
-	if (inode1)
-		inode_lock_nested(inode1, subclass1);
-	if (inode2 && inode2 != inode1)
-		inode_lock_nested(inode2, subclass2);
-}
-
 /**
  * lock_two_nondirectories - take two i_mutexes on non-directory objects
  *
@@ -1144,7 +1102,12 @@ void lock_two_nondirectories(struct inode *inode1, struct inode *inode2)
 		WARN_ON_ONCE(S_ISDIR(inode1->i_mode));
 	if (inode2)
 		WARN_ON_ONCE(S_ISDIR(inode2->i_mode));
-	lock_two_inodes(inode1, inode2, I_MUTEX_NORMAL, I_MUTEX_NONDIR2);
+	if (inode1 > inode2)
+		swap(inode1, inode2);
+	if (inode1)
+		inode_lock(inode1);
+	if (inode2 && inode2 != inode1)
+		inode_lock_nested(inode2, I_MUTEX_NONDIR2);
 }
 EXPORT_SYMBOL(lock_two_nondirectories);
 
diff --git a/fs/internal.h b/fs/internal.h
index 58e43341aebf..de67b02226e5 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -196,8 +196,6 @@ extern long prune_icache_sb(struct super_block *sb, struct shrink_control *sc);
 int dentry_needs_remove_privs(struct mnt_idmap *, struct dentry *dentry);
 bool in_group_or_capable(struct mnt_idmap *idmap,
 			 const struct inode *inode, vfsgid_t vfsgid);
-void lock_two_inodes(struct inode *inode1, struct inode *inode2,
-		     unsigned subclass1, unsigned subclass2);
 
 /*
  * fs-writeback.c
-- 
2.39.2


