Return-Path: <linux-fsdevel+bounces-10583-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F0DCC84C7C2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 10:42:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6DF328DC7A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 09:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8253C22F1E;
	Wed,  7 Feb 2024 09:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="W7AeCBXs";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="VjAzIZXi";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="W7AeCBXs";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="VjAzIZXi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0482622330
	for <linux-fsdevel@vger.kernel.org>; Wed,  7 Feb 2024 09:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707298935; cv=none; b=fXNl3gigRfB5klHEGwFLHn0v7vnJH/Kg1FmM3eeW7AWfDaS2G5l0het3JReDSQ1Suk8APMKv9eWlqcIZDL8AqoaDSEOW+nw+YNqL3wlHDaNT0a3TG83JUvyT9dH/goSkhmbOngD3xLh/IEkTuZHYYpoxf/GNEE02LlPciW7hfqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707298935; c=relaxed/simple;
	bh=GD2Vl7iZaw3W8If+nBII/NDHjiuJxCgUSb6cLaOJDMM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Nf/PISZ6+knXP09Ht0IhE+2LwPoRo6q9wPlO2t2UB2GQPGeGVBTU4riOv7+4zCPCIRh3UtPhyR2iKmpa8++LrLyz250qwTJW8qlFGnPw2SeuJ6264jOXCwBPecG3WDGVqLYeIgrscmPHvyPSFz7arb4HADTHygxFACKZ45VpYps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=W7AeCBXs; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=VjAzIZXi; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=W7AeCBXs; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=VjAzIZXi; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3BB0F2216D;
	Wed,  7 Feb 2024 09:42:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707298931; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ejdK8EENmq8QuTM2pRgsR2Wsk0ObmNJA6xcfnnI9rCk=;
	b=W7AeCBXsmU4KTmH2uPM7NggeC/Uwdyp7uBCTf9QLEAcKVUxK7Io79hLoz3oo/u86Y8WeEF
	xPDzXuSLfSZVyeRIv68aF/jJ1V2PPU3gJGLKnDGTJFvwUXbGGpymGYRX7h4VKz2bs2un1N
	B2P8oGkU6PQkcujvp51BOmhtARyrpS4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707298931;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ejdK8EENmq8QuTM2pRgsR2Wsk0ObmNJA6xcfnnI9rCk=;
	b=VjAzIZXiTUJRCxZoGkrhaHYC7GPvGiI1I86ZCGfTQLgQ8kVUM87IAH8VTDgCvNnrwI1w7K
	Uldriv3q09a3CGBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707298931; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ejdK8EENmq8QuTM2pRgsR2Wsk0ObmNJA6xcfnnI9rCk=;
	b=W7AeCBXsmU4KTmH2uPM7NggeC/Uwdyp7uBCTf9QLEAcKVUxK7Io79hLoz3oo/u86Y8WeEF
	xPDzXuSLfSZVyeRIv68aF/jJ1V2PPU3gJGLKnDGTJFvwUXbGGpymGYRX7h4VKz2bs2un1N
	B2P8oGkU6PQkcujvp51BOmhtARyrpS4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707298931;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ejdK8EENmq8QuTM2pRgsR2Wsk0ObmNJA6xcfnnI9rCk=;
	b=VjAzIZXiTUJRCxZoGkrhaHYC7GPvGiI1I86ZCGfTQLgQ8kVUM87IAH8VTDgCvNnrwI1w7K
	Uldriv3q09a3CGBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2CB1313A41;
	Wed,  7 Feb 2024 09:42:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0KCICnNQw2V6UwAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 07 Feb 2024 09:42:11 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id D41E5A080C; Wed,  7 Feb 2024 10:42:10 +0100 (CET)
From: Jan Kara <jack@suse.cz>
To: <linux-fsdevel@vger.kernel.org>
Cc: Jan Kara <jack@suse.cz>
Subject: [PATCH 2/2] quota: Properly annotate i_dquot arrays with __rcu
Date: Wed,  7 Feb 2024 10:42:05 +0100
Message-Id: <20240207094210.17065-2-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240207093810.6579-1-jack@suse.cz>
References: <20240207093810.6579-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8230; i=jack@suse.cz; h=from:subject; bh=GD2Vl7iZaw3W8If+nBII/NDHjiuJxCgUSb6cLaOJDMM=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBlw1BsptLCKQ8OkU/02ZROumWxtQIM5Y4ZwsBPF2/B Ai6DcWeJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZcNQbAAKCRCcnaoHP2RA2S8hCA Dp4gLaDFPsNTRX5ED4uBkCkSBXAOmjexy1K507mbJFQlO74QME3WKD9biGWLmr9Z9frw0AdnCCK0hx OQ5I02brqmcVELpzyk09KP623slfeC+Guj5t8kDrY68/oc94PhnXln/qDpAGNDPGBAjs6Q2VooglwK vFPWny7O3ZcA03R5or9ruL0IEkpa7mlJC/gW+ni4XqffQm3VO/Qr6gW7SqmmXsjGYe4HFaYRdBS9bC 9leYOQrvP8tCm8o7lj7AmN+JB9CPaHsSdsOEXLR+jWqbim+PVchw7hdY3DIc6RMsZ33hDsYEgNvdmj SCe2pNTzNc9EG9r2EljmkZBCoCCGms
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: 0.70
X-Spamd-Result: default: False [0.70 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_TWO(0.00)[2];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Flag: NO

Dquots pointed to from i_dquot arrays in inodes are protected by
dquot_srcu. Annotate them as such and change .get_dquots callback to
return properly annotated pointer to make sparse happy.

Fixes: b9ba6f94b238 ("quota: remove dqptr_sem")
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext2/ext2.h           | 2 +-
 fs/ext2/super.c          | 2 +-
 fs/ext4/ext4.h           | 2 +-
 fs/ext4/super.c          | 2 +-
 fs/f2fs/f2fs.h           | 2 +-
 fs/f2fs/super.c          | 2 +-
 fs/jfs/jfs_incore.h      | 2 +-
 fs/jfs/super.c           | 2 +-
 fs/ocfs2/inode.h         | 2 +-
 fs/ocfs2/super.c         | 2 +-
 fs/quota/dquot.c         | 3 +--
 fs/reiserfs/reiserfs.h   | 2 +-
 fs/reiserfs/super.c      | 2 +-
 include/linux/fs.h       | 2 +-
 include/linux/shmem_fs.h | 2 +-
 mm/shmem.c               | 2 +-
 16 files changed, 16 insertions(+), 17 deletions(-)

diff --git a/fs/ext2/ext2.h b/fs/ext2/ext2.h
index 677a9ad45dcb..f38bdd46e4f7 100644
--- a/fs/ext2/ext2.h
+++ b/fs/ext2/ext2.h
@@ -674,7 +674,7 @@ struct ext2_inode_info {
 	struct inode	vfs_inode;
 	struct list_head i_orphan;	/* unlinked but open inodes */
 #ifdef CONFIG_QUOTA
-	struct dquot *i_dquot[MAXQUOTAS];
+	struct dquot __rcu *i_dquot[MAXQUOTAS];
 #endif
 };
 
diff --git a/fs/ext2/super.c b/fs/ext2/super.c
index 01f9addc8b1f..6d8587505cea 100644
--- a/fs/ext2/super.c
+++ b/fs/ext2/super.c
@@ -320,7 +320,7 @@ static ssize_t ext2_quota_read(struct super_block *sb, int type, char *data, siz
 static ssize_t ext2_quota_write(struct super_block *sb, int type, const char *data, size_t len, loff_t off);
 static int ext2_quota_on(struct super_block *sb, int type, int format_id,
 			 const struct path *path);
-static struct dquot **ext2_get_dquots(struct inode *inode)
+static struct dquot __rcu **ext2_get_dquots(struct inode *inode)
 {
 	return EXT2_I(inode)->i_dquot;
 }
diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 023571f8dd1b..4fb938ba3f35 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1158,7 +1158,7 @@ struct ext4_inode_info {
 	tid_t i_datasync_tid;
 
 #ifdef CONFIG_QUOTA
-	struct dquot *i_dquot[MAXQUOTAS];
+	struct dquot __rcu *i_dquot[MAXQUOTAS];
 #endif
 
 	/* Precomputed uuid+inum+igen checksum for seeding inode checksums */
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 0f931d0c227d..32bd83adf0bb 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1600,7 +1600,7 @@ static ssize_t ext4_quota_write(struct super_block *sb, int type,
 static int ext4_quota_enable(struct super_block *sb, int type, int format_id,
 			     unsigned int flags);
 
-static struct dquot **ext4_get_dquots(struct inode *inode)
+static struct dquot __rcu **ext4_get_dquots(struct inode *inode)
 {
 	return EXT4_I(inode)->i_dquot;
 }
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 65294e3b0bef..31554e2a0a32 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -829,7 +829,7 @@ struct f2fs_inode_info {
 	spinlock_t i_size_lock;		/* protect last_disk_size */
 
 #ifdef CONFIG_QUOTA
-	struct dquot *i_dquot[MAXQUOTAS];
+	struct dquot __rcu *i_dquot[MAXQUOTAS];
 
 	/* quota space reservation, managed internally by quota code */
 	qsize_t i_reserved_quota;
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index d45ab0992ae5..18cc4829f7e8 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -2768,7 +2768,7 @@ int f2fs_dquot_initialize(struct inode *inode)
 	return dquot_initialize(inode);
 }
 
-static struct dquot **f2fs_get_dquots(struct inode *inode)
+static struct dquot __rcu **f2fs_get_dquots(struct inode *inode)
 {
 	return F2FS_I(inode)->i_dquot;
 }
diff --git a/fs/jfs/jfs_incore.h b/fs/jfs/jfs_incore.h
index dd4264aa9bed..10934f9a11be 100644
--- a/fs/jfs/jfs_incore.h
+++ b/fs/jfs/jfs_incore.h
@@ -92,7 +92,7 @@ struct jfs_inode_info {
 		} link;
 	} u;
 #ifdef CONFIG_QUOTA
-	struct dquot *i_dquot[MAXQUOTAS];
+	struct dquot __rcu *i_dquot[MAXQUOTAS];
 #endif
 	u32 dev;	/* will die when we get wide dev_t */
 	struct inode	vfs_inode;
diff --git a/fs/jfs/super.c b/fs/jfs/super.c
index 8d8e556bd610..ff135a43b5b7 100644
--- a/fs/jfs/super.c
+++ b/fs/jfs/super.c
@@ -824,7 +824,7 @@ static ssize_t jfs_quota_write(struct super_block *sb, int type,
 	return len - towrite;
 }
 
-static struct dquot **jfs_get_dquots(struct inode *inode)
+static struct dquot __rcu **jfs_get_dquots(struct inode *inode)
 {
 	return JFS_IP(inode)->i_dquot;
 }
diff --git a/fs/ocfs2/inode.h b/fs/ocfs2/inode.h
index 82b28fdacc7e..accf03d4765e 100644
--- a/fs/ocfs2/inode.h
+++ b/fs/ocfs2/inode.h
@@ -65,7 +65,7 @@ struct ocfs2_inode_info
 	tid_t i_sync_tid;
 	tid_t i_datasync_tid;
 
-	struct dquot *i_dquot[MAXQUOTAS];
+	struct dquot __rcu *i_dquot[MAXQUOTAS];
 };
 
 /*
diff --git a/fs/ocfs2/super.c b/fs/ocfs2/super.c
index 6b906424902b..1259fe02cd53 100644
--- a/fs/ocfs2/super.c
+++ b/fs/ocfs2/super.c
@@ -122,7 +122,7 @@ static int ocfs2_susp_quotas(struct ocfs2_super *osb, int unsuspend);
 static int ocfs2_enable_quotas(struct ocfs2_super *osb);
 static void ocfs2_disable_quotas(struct ocfs2_super *osb);
 
-static struct dquot **ocfs2_get_dquots(struct inode *inode)
+static struct dquot __rcu **ocfs2_get_dquots(struct inode *inode)
 {
 	return OCFS2_I(inode)->i_dquot;
 }
diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
index 3a16867a6fbd..51ff554dc875 100644
--- a/fs/quota/dquot.c
+++ b/fs/quota/dquot.c
@@ -1002,8 +1002,7 @@ EXPORT_SYMBOL(dqget);
 
 static inline struct dquot __rcu **i_dquot(struct inode *inode)
 {
-	/* Force __rcu for now until filesystems are fixed */
-	return (struct dquot __rcu **)inode->i_sb->s_op->get_dquots(inode);
+	return inode->i_sb->s_op->get_dquots(inode);
 }
 
 static int dqinit_needed(struct inode *inode, int type)
diff --git a/fs/reiserfs/reiserfs.h b/fs/reiserfs/reiserfs.h
index 725667880e62..b65549164590 100644
--- a/fs/reiserfs/reiserfs.h
+++ b/fs/reiserfs/reiserfs.h
@@ -97,7 +97,7 @@ struct reiserfs_inode_info {
 	struct rw_semaphore i_xattr_sem;
 #endif
 #ifdef CONFIG_QUOTA
-	struct dquot *i_dquot[MAXQUOTAS];
+	struct dquot __rcu *i_dquot[MAXQUOTAS];
 #endif
 
 	struct inode vfs_inode;
diff --git a/fs/reiserfs/super.c b/fs/reiserfs/super.c
index 67b5510beded..7b3d5aeb2a6f 100644
--- a/fs/reiserfs/super.c
+++ b/fs/reiserfs/super.c
@@ -802,7 +802,7 @@ static ssize_t reiserfs_quota_write(struct super_block *, int, const char *,
 static ssize_t reiserfs_quota_read(struct super_block *, int, char *, size_t,
 				   loff_t);
 
-static struct dquot **reiserfs_get_dquots(struct inode *inode)
+static struct dquot __rcu **reiserfs_get_dquots(struct inode *inode)
 {
 	return REISERFS_I(inode)->i_dquot;
 }
diff --git a/include/linux/fs.h b/include/linux/fs.h
index ed5966a70495..d0b849e4f6cd 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2159,7 +2159,7 @@ struct super_operations {
 #ifdef CONFIG_QUOTA
 	ssize_t (*quota_read)(struct super_block *, int, char *, size_t, loff_t);
 	ssize_t (*quota_write)(struct super_block *, int, const char *, size_t, loff_t);
-	struct dquot **(*get_dquots)(struct inode *);
+	struct dquot __rcu **(*get_dquots)(struct inode *);
 #endif
 	long (*nr_cached_objects)(struct super_block *,
 				  struct shrink_control *);
diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
index 2caa6b86106a..66828dfc6e74 100644
--- a/include/linux/shmem_fs.h
+++ b/include/linux/shmem_fs.h
@@ -37,7 +37,7 @@ struct shmem_inode_info {
 	unsigned int		fsflags;	/* for FS_IOC_[SG]ETFLAGS */
 	atomic_t		stop_eviction;	/* hold when working on inode */
 #ifdef CONFIG_TMPFS_QUOTA
-	struct dquot		*i_dquot[MAXQUOTAS];
+	struct dquot __rcu	*i_dquot[MAXQUOTAS];
 #endif
 	struct inode		vfs_inode;
 };
diff --git a/mm/shmem.c b/mm/shmem.c
index d7c84ff62186..791a6dc16324 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -311,7 +311,7 @@ static void shmem_disable_quotas(struct super_block *sb)
 		dquot_quota_off(sb, type);
 }
 
-static struct dquot **shmem_get_dquots(struct inode *inode)
+static struct dquot __rcu **shmem_get_dquots(struct inode *inode)
 {
 	return SHMEM_I(inode)->i_dquot;
 }
-- 
2.35.3


