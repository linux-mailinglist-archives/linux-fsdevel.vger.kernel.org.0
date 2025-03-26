Return-Path: <linux-fsdevel+bounces-45076-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87EB8A715A9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Mar 2025 12:25:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F8273B80AB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Mar 2025 11:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30BD41E51E6;
	Wed, 26 Mar 2025 11:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rtNQg6Yk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A66991D8DFB;
	Wed, 26 Mar 2025 11:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742988150; cv=none; b=qhaLHNVOnI67FO0TaIeGnM8/lB4mFEw+Vv3bgj3PYuseKMuIDtHgBLf3K0sJOCXnL6rYyYPECX52Px4KF6nkvAfrKFyB95uy5f+LgdsNhS5KP8BDQnOSVUT8xB3xnCxw1FAt13vHcyaPpzc2tcIERDyrFBkXEvgRqsdJ5z8yTiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742988150; c=relaxed/simple;
	bh=M/wSutNyy+ZGfJfHShf3iBWQw7da6uDLGlisrMuWiRo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c1fjCV216gRgfoYGzPbru4AtA0RKDfWqLdJvozNIXL6KcOZIx7bj6GgM6NAGyFob8EkUNE3/KtRoSpiJQ1zUzVSCrxjjUDyrnTFVY4vWjYlhsSX8lmTr5hoXwdqThCH7Tacky7oBTtnUCSJROhDneoPMy2ruBcbpPAojch37gEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=rtNQg6Yk; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=8GbqvDo+p6D77xOjNMaIDYrw4/7pE8LqHMvAonozkEw=; b=rtNQg6YkIwEVOQso6nFzRhw1tG
	cfBwORfr+bWDBRGs0RgAOEJmxd4Nc0nlQ6WXKUvjeCc+D8V4ItCquagnOq3z32wonkWLz9BJZ7Fy7
	yE+LKUKeBtzNC5bF6JdJ7sbb7E3DwZnfUYt1DhOFpe6AeyAttvJWD8ooh0O/QLsbvvb+vE3u7R6JG
	Yj4VouiLmIRcUC8+r/MrTJZAIpp76OviF2iSEjIdnwc81W5Fk24POjG7IBmGcfkFgCFYxSfDJuvGc
	HsWXawu149YsgzJBWqPfhNFQgV1bpReYmGFuf/AjpBYq1DbTDWF80zy5LIxcA65e33ADVLOQNTgz/
	UH1Ekxqw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.98.1 #2 (Red Hat Linux))
	id 1txOq0-00000008LLk-2ikD;
	Wed, 26 Mar 2025 11:22:24 +0000
From: Luis Chamberlain <mcgrof@kernel.org>
To: jack@suse.cz,
	hch@infradead.org,
	James.Bottomley@HansenPartnership.com,
	david@fromorbit.com,
	rafael@kernel.org,
	djwong@kernel.org,
	pavel@kernel.org,
	song@kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	gost.dev@samsung.com,
	Luis Chamberlain <mcgrof@kernel.org>
Subject: [RFC 1/6] fs: add frozen sb state helpers
Date: Wed, 26 Mar 2025 04:22:15 -0700
Message-ID: <20250326112220.1988619-2-mcgrof@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250326112220.1988619-1-mcgrof@kernel.org>
References: <20250326112220.1988619-1-mcgrof@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>

Provide helpers so that we can check a superblock frozen state.
This will make subsequent changes easier to read. This makes
no functional changes.

Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 fs/ext4/ext4_jbd2.c |  2 +-
 fs/gfs2/sys.c       |  2 +-
 fs/quota/quota.c    |  3 ++-
 fs/super.c          |  8 ++++----
 fs/xfs/xfs_trans.c  |  3 +--
 include/linux/fs.h  | 22 ++++++++++++++++++++++
 6 files changed, 31 insertions(+), 9 deletions(-)

diff --git a/fs/ext4/ext4_jbd2.c b/fs/ext4/ext4_jbd2.c
index 135e278c832e..5f5c2121d2ad 100644
--- a/fs/ext4/ext4_jbd2.c
+++ b/fs/ext4/ext4_jbd2.c
@@ -75,7 +75,7 @@ static int ext4_journal_check_start(struct super_block *sb)
 	if (WARN_ON_ONCE(sb_rdonly(sb)))
 		return -EROFS;
 
-	WARN_ON(sb->s_writers.frozen == SB_FREEZE_COMPLETE);
+	WARN_ON(sb_is_frozen(sb));
 	journal = EXT4_SB(sb)->s_journal;
 	/*
 	 * Special case here: if the journal has aborted behind our
diff --git a/fs/gfs2/sys.c b/fs/gfs2/sys.c
index ecc699f8d9fc..08ec5904a208 100644
--- a/fs/gfs2/sys.c
+++ b/fs/gfs2/sys.c
@@ -156,7 +156,7 @@ static ssize_t uuid_show(struct gfs2_sbd *sdp, char *buf)
 static ssize_t freeze_show(struct gfs2_sbd *sdp, char *buf)
 {
 	struct super_block *sb = sdp->sd_vfs;
-	int frozen = (sb->s_writers.frozen == SB_UNFROZEN) ? 0 : 1;
+	int frozen = sb_is_unfrozen(sb) ? 0 : 1;
 
 	return snprintf(buf, PAGE_SIZE, "%d\n", frozen);
 }
diff --git a/fs/quota/quota.c b/fs/quota/quota.c
index 7c2b75a44485..9b4e0a80f386 100644
--- a/fs/quota/quota.c
+++ b/fs/quota/quota.c
@@ -890,11 +890,12 @@ static struct super_block *quotactl_block(const char __user *special, int cmd)
 	sb = user_get_super(dev, excl);
 	if (!sb)
 		return ERR_PTR(-ENODEV);
-	if (thawed && sb->s_writers.frozen != SB_UNFROZEN) {
+	if (thawed && !sb_is_unfrozen(sb)) {
 		if (excl)
 			up_write(&sb->s_umount);
 		else
 			up_read(&sb->s_umount);
+
 		/* Wait for sb to unfreeze */
 		sb_start_write(sb);
 		sb_end_write(sb);
diff --git a/fs/super.c b/fs/super.c
index 97a17f9d9023..117bd1bfe09f 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -1029,7 +1029,7 @@ int reconfigure_super(struct fs_context *fc)
 
 	if (fc->sb_flags_mask & ~MS_RMT_MASK)
 		return -EINVAL;
-	if (sb->s_writers.frozen != SB_UNFROZEN)
+	if (!(sb_is_unfrozen(sb)))
 		return -EBUSY;
 
 	retval = security_sb_remount(sb, fc->security);
@@ -1053,7 +1053,7 @@ int reconfigure_super(struct fs_context *fc)
 			__super_lock_excl(sb);
 			if (!sb->s_root)
 				return 0;
-			if (sb->s_writers.frozen != SB_UNFROZEN)
+			if (!sb_is_unfrozen(sb))
 				return -EBUSY;
 			remount_ro = !sb_rdonly(sb);
 		}
@@ -2009,7 +2009,7 @@ int freeze_super(struct super_block *sb, enum freeze_holder who)
 	atomic_inc(&sb->s_active);
 
 retry:
-	if (sb->s_writers.frozen == SB_FREEZE_COMPLETE) {
+	if (sb_is_frozen(sb)) {
 		if (may_freeze(sb, who))
 			ret = !!WARN_ON_ONCE(freeze_inc(sb, who) == 1);
 		else
@@ -2019,7 +2019,7 @@ int freeze_super(struct super_block *sb, enum freeze_holder who)
 		return ret;
 	}
 
-	if (sb->s_writers.frozen != SB_UNFROZEN) {
+	if (sb_is_unfrozen(sb)) {
 		ret = wait_for_partially_frozen(sb);
 		if (ret) {
 			deactivate_locked_super(sb);
diff --git a/fs/xfs/xfs_trans.c b/fs/xfs/xfs_trans.c
index c6657072361a..3a5088865064 100644
--- a/fs/xfs/xfs_trans.c
+++ b/fs/xfs/xfs_trans.c
@@ -269,8 +269,7 @@ xfs_trans_alloc(
 	 * Zero-reservation ("empty") transactions can't modify anything, so
 	 * they're allowed to run while we're frozen.
 	 */
-	WARN_ON(resp->tr_logres > 0 &&
-		mp->m_super->s_writers.frozen == SB_FREEZE_COMPLETE);
+	WARN_ON(resp->tr_logres > 0 && sb_is_frozen(mp->m_super));
 	ASSERT(!(flags & XFS_TRANS_RES_FDBLKS) ||
 	       xfs_has_lazysbcount(mp));
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 016b0fe1536e..1d9a9c557e1a 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1971,6 +1971,28 @@ static inline bool sb_start_intwrite_trylock(struct super_block *sb)
 	return __sb_start_write_trylock(sb, SB_FREEZE_FS);
 }
 
+/**
+ * sb_is_frozen - is superblock frozen
+ * @sb: the super to check
+ *
+ * Returns true if the super is frozen.
+ */
+static inline bool sb_is_frozen(struct super_block *sb)
+{
+	return sb->s_writers.frozen == SB_FREEZE_COMPLETE;
+}
+
+/**
+ * sb_is_unfrozen - is superblock unfrozen
+ * @sb: the super to check
+ *
+ * Returns true if the super is unfrozen.
+ */
+static inline bool sb_is_unfrozen(struct super_block *sb)
+{
+	return sb->s_writers.frozen == SB_UNFROZEN;
+}
+
 bool inode_owner_or_capable(struct mnt_idmap *idmap,
 			    const struct inode *inode);
 
-- 
2.47.2


