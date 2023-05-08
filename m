Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 146356F9D4C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 May 2023 03:17:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232340AbjEHBRp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 7 May 2023 21:17:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232203AbjEHBRj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 7 May 2023 21:17:39 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FEDD4C37;
        Sun,  7 May 2023 18:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=4ny1Qyd51EIZ58YKw3q+aAfCx7UcmGMIn0O7WwMNHtM=; b=lg0WARWgwU+mm2tnnN6Dq/28he
        w5uZvkZdp0uy1T+muLlsYh1Q4mSzQXIex+XOagdmo3bjiJsFC9+HUXEayvh9LzYc+VSK0sfeffn5D
        t02mGNTRzhVsksIk3KlMsRkiq2zhr07Dn5gP8bhmLUdKHttmkNzN8ZfefXL1KYtMxBLpteYbfZA2I
        3M0zbi8B7xy5L9bHuLX7y2YNSOFi2GSuYdKKYycbYd3R/EnKyYZsniInQHFBjFOVduih0Ffoy6g63
        EiF9669UTNMH4SfH0HQMqKy0t5sGQMcM5HWCyYzpZ3nJ6kAyYXrhGELuRM9M/MYKOSbOFcaJsIA2Z
        rPj/+T+Q==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pvpV7-00GvZ0-2m;
        Mon, 08 May 2023 01:17:17 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     hch@infradead.org, djwong@kernel.org, sandeen@sandeen.net,
        song@kernel.org, rafael@kernel.org, gregkh@linuxfoundation.org,
        viro@zeniv.linux.org.uk, jack@suse.cz, jikos@kernel.org,
        bvanassche@acm.org, ebiederm@xmission.com
Cc:     mchehab@kernel.org, keescook@chromium.org, p.raghav@samsung.com,
        da.gomez@samsung.com, linux-fsdevel@vger.kernel.org,
        kernel@tuxforce.de, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 2/6] fs: add frozen sb state helpers
Date:   Sun,  7 May 2023 18:17:13 -0700
Message-Id: <20230508011717.4034511-3-mcgrof@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230508011717.4034511-1-mcgrof@kernel.org>
References: <20230508011717.4034511-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Provide helpers so that we can check a superblock frozen state.
This will make subsequent changes easier to read. This makes
no functional changes.

Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 fs/ext4/ext4_jbd2.c |  2 +-
 fs/gfs2/sys.c       |  2 +-
 fs/quota/quota.c    |  4 ++--
 fs/super.c          |  6 +++---
 fs/xfs/xfs_trans.c  |  3 +--
 include/linux/fs.h  | 22 ++++++++++++++++++++++
 6 files changed, 30 insertions(+), 9 deletions(-)

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
index cbb71c3520c0..e80c827acd09 100644
--- a/fs/gfs2/sys.c
+++ b/fs/gfs2/sys.c
@@ -148,7 +148,7 @@ static ssize_t uuid_show(struct gfs2_sbd *sdp, char *buf)
 static ssize_t freeze_show(struct gfs2_sbd *sdp, char *buf)
 {
 	struct super_block *sb = sdp->sd_vfs;
-	int frozen = (sb->s_writers.frozen == SB_UNFROZEN) ? 0 : 1;
+	int frozen = sb_is_unfrozen(sb) ? 0 : 1;
 
 	return snprintf(buf, PAGE_SIZE, "%d\n", frozen);
 }
diff --git a/fs/quota/quota.c b/fs/quota/quota.c
index 052f143e2e0e..66ea23e15d93 100644
--- a/fs/quota/quota.c
+++ b/fs/quota/quota.c
@@ -890,13 +890,13 @@ static struct super_block *quotactl_block(const char __user *special, int cmd)
 	sb = user_get_super(dev, excl);
 	if (!sb)
 		return ERR_PTR(-ENODEV);
-	if (thawed && sb->s_writers.frozen != SB_UNFROZEN) {
+	if (thawed && !sb_is_unfrozen(sb)) {
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
index 0e9d48846684..46c6475fc765 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -905,7 +905,7 @@ int reconfigure_super(struct fs_context *fc)
 
 	if (fc->sb_flags_mask & ~MS_RMT_MASK)
 		return -EINVAL;
-	if (sb->s_writers.frozen != SB_UNFROZEN)
+	if (!(sb_is_unfrozen(sb)))
 		return -EBUSY;
 
 	retval = security_sb_remount(sb, fc->security);
@@ -929,7 +929,7 @@ int reconfigure_super(struct fs_context *fc)
 			down_write(&sb->s_umount);
 			if (!sb->s_root)
 				return 0;
-			if (sb->s_writers.frozen != SB_UNFROZEN)
+			if (!sb_is_unfrozen(sb))
 				return -EBUSY;
 			remount_ro = !sb_rdonly(sb);
 		}
@@ -1673,7 +1673,7 @@ int freeze_super(struct super_block *sb)
 {
 	int ret;
 
-	if (sb->s_writers.frozen != SB_UNFROZEN)
+	if (!sb_is_unfrozen(sb))
 		return -EBUSY;
 
 	if (!(sb->s_flags & SB_BORN))
diff --git a/fs/xfs/xfs_trans.c b/fs/xfs/xfs_trans.c
index 8afc0c080861..26caeafc572f 100644
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
index 21a981680856..90b5bdc4071a 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1621,6 +1621,28 @@ static inline bool sb_start_intwrite_trylock(struct super_block *sb)
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
2.39.2

