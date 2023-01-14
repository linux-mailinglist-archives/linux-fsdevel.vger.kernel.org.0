Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2455866A787
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Jan 2023 01:34:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231316AbjANAe1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Jan 2023 19:34:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbjANAeY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Jan 2023 19:34:24 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C98B87900;
        Fri, 13 Jan 2023 16:34:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=IeTyRT1URJ9c1HQKi2te15AVFiQCa+Kz07HOu9irdJY=; b=nvR9nf1kBrzgW7uu/ealzYsDiE
        H3ibZFaIPMG5IKrsxG67uEROIu6OVsd0nxNWspOlc1a0AWolaSU5EPLbHi/+ojua/FyIQ4DO6omr4
        MqdKkTp/Po4kSryh1dipcvhKBwdVE1G2ia29pmYoLOuMCVg6PVD2ontp9gBofxGB2b1sZ09g6mjEe
        ZGrCo3zxTmkiMCh7T4EbCMjVpV/MYPx6SzJ83nXDmwYvStUyV64qTivkstPWWLWOWu1ASeDcXzgqo
        1zSGGRBFNHrKbeaxaG7hc1OUjIOO9IW9lShcrpMF4zvzvnvIeoTNrfDqaGdughXEhM9TGFHGo17WI
        9sgdh9Bg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pGUUs-004tvz-UW; Sat, 14 Jan 2023 00:34:10 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     hch@infradead.org, djwong@kernel.org, song@kernel.org,
        rafael@kernel.org, gregkh@linuxfoundation.org,
        viro@zeniv.linux.org.uk, jack@suse.cz, bvanassche@acm.org,
        ebiederm@xmission.com
Cc:     mchehab@kernel.org, keescook@chromium.org, p.raghav@samsung.com,
        linux-fsdevel@vger.kernel.org, kernel@tuxforce.de,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [RFC v3 02/24] fs: add frozen sb state helpers
Date:   Fri, 13 Jan 2023 16:33:47 -0800
Message-Id: <20230114003409.1168311-3-mcgrof@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230114003409.1168311-1-mcgrof@kernel.org>
References: <20230114003409.1168311-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Provide helpers so that we can check a superblock frozen state.
This will make subsequent changes easier to read. This makes
no functional changes.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 fs/ext4/ext4_jbd2.c |  2 +-
 fs/gfs2/sys.c       |  2 +-
 fs/quota/quota.c    |  4 ++--
 fs/super.c          |  4 ++--
 fs/xfs/xfs_trans.c  |  3 +--
 include/linux/fs.h  | 22 ++++++++++++++++++++++
 6 files changed, 29 insertions(+), 8 deletions(-)

diff --git a/fs/ext4/ext4_jbd2.c b/fs/ext4/ext4_jbd2.c
index 77f318ec8abb..ef441f15053b 100644
--- a/fs/ext4/ext4_jbd2.c
+++ b/fs/ext4/ext4_jbd2.c
@@ -72,7 +72,7 @@ static int ext4_journal_check_start(struct super_block *sb)
 
 	if (sb_rdonly(sb))
 		return -EROFS;
-	WARN_ON(sb->s_writers.frozen == SB_FREEZE_COMPLETE);
+	WARN_ON(sb_is_frozen(sb));
 	journal = EXT4_SB(sb)->s_journal;
 	/*
 	 * Special case here: if the journal has aborted behind our
diff --git a/fs/gfs2/sys.c b/fs/gfs2/sys.c
index d0b80552a678..b98be03d0d1e 100644
--- a/fs/gfs2/sys.c
+++ b/fs/gfs2/sys.c
@@ -146,7 +146,7 @@ static ssize_t uuid_show(struct gfs2_sbd *sdp, char *buf)
 static ssize_t freeze_show(struct gfs2_sbd *sdp, char *buf)
 {
 	struct super_block *sb = sdp->sd_vfs;
-	int frozen = (sb->s_writers.frozen == SB_UNFROZEN) ? 0 : 1;
+	int frozen = sb_is_unfrozen(sb) ? 0 : 1;
 
 	return snprintf(buf, PAGE_SIZE, "%d\n", frozen);
 }
diff --git a/fs/quota/quota.c b/fs/quota/quota.c
index 052f143e2e0e..d8147c21bf03 100644
--- a/fs/quota/quota.c
+++ b/fs/quota/quota.c
@@ -890,13 +890,13 @@ static struct super_block *quotactl_block(const char __user *special, int cmd)
 	sb = user_get_super(dev, excl);
 	if (!sb)
 		return ERR_PTR(-ENODEV);
-	if (thawed && sb->s_writers.frozen != SB_UNFROZEN) {
+	if (thawed && sb_is_unfrozen(sb)) {
 		if (excl)
 			up_write(&sb->s_umount);
 		else
 			up_read(&sb->s_umount);
 		wait_event(sb->s_writers.wait_unfrozen,
-			   sb->s_writers.frozen == SB_UNFROZEN);
+			   sb_is_unfrozen(sb));
 		put_super(sb);
 		goto retry;
 	}
diff --git a/fs/super.c b/fs/super.c
index a31a41b313f3..fdcf5a87af0a 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -883,7 +883,7 @@ int reconfigure_super(struct fs_context *fc)
 
 	if (fc->sb_flags_mask & ~MS_RMT_MASK)
 		return -EINVAL;
-	if (sb->s_writers.frozen != SB_UNFROZEN)
+	if (!(sb_is_unfrozen(sb)))
 		return -EBUSY;
 
 	retval = security_sb_remount(sb, fc->security);
@@ -907,7 +907,7 @@ int reconfigure_super(struct fs_context *fc)
 			down_write(&sb->s_umount);
 			if (!sb->s_root)
 				return 0;
-			if (sb->s_writers.frozen != SB_UNFROZEN)
+			if (!sb_is_unfrozen(sb))
 				return -EBUSY;
 			remount_ro = !sb_rdonly(sb);
 		}
diff --git a/fs/xfs/xfs_trans.c b/fs/xfs/xfs_trans.c
index 7bd16fbff534..ceb4890a4c96 100644
--- a/fs/xfs/xfs_trans.c
+++ b/fs/xfs/xfs_trans.c
@@ -267,8 +267,7 @@ xfs_trans_alloc(
 	 * Zero-reservation ("empty") transactions can't modify anything, so
 	 * they're allowed to run while we're frozen.
 	 */
-	WARN_ON(resp->tr_logres > 0 &&
-		mp->m_super->s_writers.frozen == SB_FREEZE_COMPLETE);
+	WARN_ON(resp->tr_logres > 0 && sb_is_frozen(mp->m_super));
 	ASSERT(!(flags & XFS_TRANS_RES_FDBLKS) ||
 	       xfs_has_lazysbcount(mp));
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 5042f5ab74a4..c0cab61f9f9a 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1604,6 +1604,28 @@ static inline bool sb_start_intwrite_trylock(struct super_block *sb)
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
 bool inode_owner_or_capable(struct user_namespace *mnt_userns,
 			    const struct inode *inode);
 
-- 
2.35.1

