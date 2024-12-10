Return-Path: <linux-fsdevel+bounces-36883-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 843409EA600
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2024 03:49:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65CE2188BC5B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2024 02:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE7531D2B0E;
	Tue, 10 Dec 2024 02:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="tueO/suz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71CD21AAA2F;
	Tue, 10 Dec 2024 02:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733798912; cv=none; b=gVPgCorLbvFDUeyLpVWGeVvXzclSesawJLomSV2walUczE2z+yx18M+RDaFmrh+Tf3AYGez+bty5CnPALYJoCjykp1+6tvGKUZpjckqgardQ/E9MqNdQAFQCMlLMrS9y0515i2icbcL1af7cOhFyAqq3u20TJ4EGV3ZBqymx6K0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733798912; c=relaxed/simple;
	bh=0bTdncsjoAki6Q/sVnT/88MBbvQ8ijphl7e3axc+dWs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mSR3KErjHvFORtkWI4t2IyzWOxsMyb6f4mTvx0pzobgHpZ8Z0cPzTitk0CHdR1ZW8A3j47Empx2ZyhJBra0+VPPHQ9iDg3XY2fSlft+SGbkx2i3KGa8M3ATpA2WoNScrepdS2mKKbXi5Tl8UrToL4gW+wkjtgZ4I52KEdXL1WtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=tueO/suz; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=OwzwWqtJRF9uqXKKqFbXfz7VMk0w6bXSQMfi/uIOrkE=; b=tueO/suzUI+HmPTrqVP3ZkOVGK
	Mp3+rjcadl8/tIIOF5RpRJQbs9qvlMMkoYCfCm3St2unYJqJfuSv+3bAw38PUrb5cfXpoJLfKmm0x
	l5wpupxiitLvCb7NLnNbwgeD9J8H/VebCYnawoTlCQ76tnCQdV2S/pPhwRvdBSnKS7LCF+Sy4oLl8
	OZILac96n0d4lNRagN5XScX7/YPX5caZvA4LWavzsStE3WFX+wGaIa2u5H9za4oVq4Yx+DfVGzLoU
	WhHMQhPlPSkmf8qFaC5hgE2+CqIFOTpTIJ6RhGED4AEecrBXpziHsIkXiY0TB5ajfPvxRE1rBuqxw
	UIY2J3OQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tKqIV-00000006lS4-3tac;
	Tue, 10 Dec 2024 02:48:27 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org,
	linux-ext4@vger.kernel.org
Subject: [PATCH 5/5] ext4 fast_commit: make use of name_snapshot primitives
Date: Tue, 10 Dec 2024 02:48:27 +0000
Message-ID: <20241210024827.1612355-5-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241210024827.1612355-1-viro@zeniv.linux.org.uk>
References: <20241210024523.GD3387508@ZenIV>
 <20241210024827.1612355-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

... rather than open-coding them (and doing pointless work with extra
allocations, etc. for long names).

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/ext4/fast_commit.c | 29 +++++------------------------
 fs/ext4/fast_commit.h |  3 +--
 2 files changed, 6 insertions(+), 26 deletions(-)

diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
index 26c4fc37edcf..da4263a14a20 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -322,9 +322,7 @@ void ext4_fc_del(struct inode *inode)
 	WARN_ON(!list_empty(&ei->i_fc_dilist));
 	spin_unlock(&sbi->s_fc_lock);
 
-	if (fc_dentry->fcd_name.name &&
-		fc_dentry->fcd_name.len > DNAME_INLINE_LEN)
-		kfree(fc_dentry->fcd_name.name);
+	release_dentry_name_snapshot(&fc_dentry->fcd_name);
 	kmem_cache_free(ext4_fc_dentry_cachep, fc_dentry);
 
 	return;
@@ -449,22 +447,7 @@ static int __track_dentry_update(handle_t *handle, struct inode *inode,
 	node->fcd_op = dentry_update->op;
 	node->fcd_parent = dir->i_ino;
 	node->fcd_ino = inode->i_ino;
-	if (dentry->d_name.len > DNAME_INLINE_LEN) {
-		node->fcd_name.name = kmalloc(dentry->d_name.len, GFP_NOFS);
-		if (!node->fcd_name.name) {
-			kmem_cache_free(ext4_fc_dentry_cachep, node);
-			ext4_fc_mark_ineligible(sb, EXT4_FC_REASON_NOMEM, handle);
-			mutex_lock(&ei->i_fc_lock);
-			return -ENOMEM;
-		}
-		memcpy((u8 *)node->fcd_name.name, dentry->d_name.name,
-			dentry->d_name.len);
-	} else {
-		memcpy(node->fcd_iname, dentry->d_name.name,
-			dentry->d_name.len);
-		node->fcd_name.name = node->fcd_iname;
-	}
-	node->fcd_name.len = dentry->d_name.len;
+	take_dentry_name_snapshot(&node->fcd_name, dentry);
 	INIT_LIST_HEAD(&node->fcd_dilist);
 	spin_lock(&sbi->s_fc_lock);
 	if (sbi->s_journal->j_flags & JBD2_FULL_COMMIT_ONGOING ||
@@ -832,7 +815,7 @@ static bool ext4_fc_add_dentry_tlv(struct super_block *sb, u32 *crc,
 {
 	struct ext4_fc_dentry_info fcd;
 	struct ext4_fc_tl tl;
-	int dlen = fc_dentry->fcd_name.len;
+	int dlen = fc_dentry->fcd_name.name.len;
 	u8 *dst = ext4_fc_reserve_space(sb,
 			EXT4_FC_TAG_BASE_LEN + sizeof(fcd) + dlen, crc);
 
@@ -847,7 +830,7 @@ static bool ext4_fc_add_dentry_tlv(struct super_block *sb, u32 *crc,
 	dst += EXT4_FC_TAG_BASE_LEN;
 	memcpy(dst, &fcd, sizeof(fcd));
 	dst += sizeof(fcd);
-	memcpy(dst, fc_dentry->fcd_name.name, dlen);
+	memcpy(dst, fc_dentry->fcd_name.name.name, dlen);
 
 	return true;
 }
@@ -1328,9 +1311,7 @@ static void ext4_fc_cleanup(journal_t *journal, int full, tid_t tid)
 		list_del_init(&fc_dentry->fcd_dilist);
 		spin_unlock(&sbi->s_fc_lock);
 
-		if (fc_dentry->fcd_name.name &&
-			fc_dentry->fcd_name.len > DNAME_INLINE_LEN)
-			kfree(fc_dentry->fcd_name.name);
+		release_dentry_name_snapshot(&fc_dentry->fcd_name);
 		kmem_cache_free(ext4_fc_dentry_cachep, fc_dentry);
 		spin_lock(&sbi->s_fc_lock);
 	}
diff --git a/fs/ext4/fast_commit.h b/fs/ext4/fast_commit.h
index 2fadb2c4780c..3bd534e4dbbf 100644
--- a/fs/ext4/fast_commit.h
+++ b/fs/ext4/fast_commit.h
@@ -109,8 +109,7 @@ struct ext4_fc_dentry_update {
 	int fcd_op;		/* Type of update create / unlink / link */
 	int fcd_parent;		/* Parent inode number */
 	int fcd_ino;		/* Inode number */
-	struct qstr fcd_name;	/* Dirent name */
-	unsigned char fcd_iname[DNAME_INLINE_LEN];	/* Dirent name string */
+	struct name_snapshot fcd_name;	/* Dirent name */
 	struct list_head fcd_list;
 	struct list_head fcd_dilist;
 };
-- 
2.39.5


