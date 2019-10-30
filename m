Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70672E9EE4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Oct 2019 16:27:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727188AbfJ3P1b (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Oct 2019 11:27:31 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:48003 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726255AbfJ3P1a (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Oct 2019 11:27:30 -0400
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1iPpsG-0003Y1-Ol; Wed, 30 Oct 2019 16:27:04 +0100
Received: from sha by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1iPpsF-0005nA-Sp; Wed, 30 Oct 2019 16:27:03 +0100
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-mtd@lists.infradead.org, Jan Kara <jack@suse.com>,
        Richard Weinberger <richard@nod.at>, kernel@pengutronix.de,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH 03/10] quota: Introduce dquot_enable_sb()
Date:   Wed, 30 Oct 2019 16:26:55 +0100
Message-Id: <20191030152702.14269-4-s.hauer@pengutronix.de>
X-Mailer: git-send-email 2.24.0.rc1
In-Reply-To: <20191030152702.14269-1-s.hauer@pengutronix.de>
References: <20191030152702.14269-1-s.hauer@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-fsdevel@vger.kernel.org
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

To support filesystems that do not store the quota informations in an
inode create dquot_enable_sb(). This is a variant of dquot_enable()
which takes a superblock instead of an inode This is a variant of
dquot_enable() which takes a superblock instead of an inode.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 fs/quota/dquot.c         | 21 +++++++++++++++++----
 include/linux/quotaops.h |  2 ++
 2 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
index bbe3be21ff43..93bcdb83b69a 100644
--- a/fs/quota/dquot.c
+++ b/fs/quota/dquot.c
@@ -2473,11 +2473,9 @@ EXPORT_SYMBOL(dquot_quota_on);
  * More powerful function for turning on quotas allowing setting
  * of individual quota flags
  */
-int dquot_enable(struct inode *inode, int type, int format_id,
-		 unsigned int flags)
+static int __dquot_enable(struct super_block *sb, struct inode *inode,
+			  int type, int format_id, unsigned int flags)
 {
-	struct super_block *sb = inode->i_sb;
-
 	/* Just unsuspend quotas? */
 	BUG_ON(flags & DQUOT_SUSPENDED);
 	/* s_umount should be held in exclusive mode */
@@ -2502,8 +2500,23 @@ int dquot_enable(struct inode *inode, int type, int format_id,
 
 	return vfs_load_quota_inode(sb, inode, type, format_id, flags);
 }
+
+int dquot_enable(struct inode *inode, int type, int format_id,
+		 unsigned int flags)
+{
+	struct super_block *sb = inode->i_sb;
+
+	return __dquot_enable(sb, inode, type, format_id, flags);
+}
 EXPORT_SYMBOL(dquot_enable);
 
+int dquot_enable_sb(struct super_block *sb, int type,
+		    int format_id, unsigned int flags)
+{
+	return __dquot_enable(sb, NULL, type, format_id, flags);
+}
+EXPORT_SYMBOL(dquot_enable_sb);
+
 /*
  * This function is used when filesystem needs to initialize quotas
  * during mount time.
diff --git a/include/linux/quotaops.h b/include/linux/quotaops.h
index 185d94829701..9c0f76e5e0b1 100644
--- a/include/linux/quotaops.h
+++ b/include/linux/quotaops.h
@@ -89,6 +89,8 @@ int dquot_file_open(struct inode *inode, struct file *file);
 
 int dquot_enable(struct inode *inode, int type, int format_id,
 	unsigned int flags);
+int dquot_enable_sb(struct super_block *sb, int type, int format_id,
+		    unsigned int flags);
 int dquot_quota_on(struct super_block *sb, int type, int format_id,
 	const struct path *path);
 int dquot_quota_on_mount(struct super_block *sb, char *qf_name,
-- 
2.24.0.rc1

