Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 863A48D2DB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2019 14:19:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbfHNMTV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Aug 2019 08:19:21 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:47499 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726522AbfHNMTV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Aug 2019 08:19:21 -0400
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1hxsEp-0005kE-Ee; Wed, 14 Aug 2019 14:18:47 +0200
Received: from sha by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1hxsEm-00081c-Nj; Wed, 14 Aug 2019 14:18:44 +0200
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-mtd@lists.infradead.org, Jan Kara <jack@suse.com>,
        Richard Weinberger <richard@nod.at>, kernel@pengutronix.de,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH 05/11] quota: Allow to pass quotactl a mountpoint
Date:   Wed, 14 Aug 2019 14:18:28 +0200
Message-Id: <20190814121834.13983-6-s.hauer@pengutronix.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190814121834.13983-1-s.hauer@pengutronix.de>
References: <20190814121834.13983-1-s.hauer@pengutronix.de>
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

So far quotactl only allows a path to a block device to specify a
filesystem to work on. For filesystems that don't work on block devices
such as UBIFS there is no block device, so let quotactl take the
mountpoint as an alternative way.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 fs/quota/quota.c   | 69 ++++++++++++++++++++++++++++++++--------------
 fs/super.c         | 17 ++++++++++++
 include/linux/fs.h |  1 +
 3 files changed, 67 insertions(+), 20 deletions(-)

diff --git a/fs/quota/quota.c b/fs/quota/quota.c
index 64a212576a72..6d9807092ae1 100644
--- a/fs/quota/quota.c
+++ b/fs/quota/quota.c
@@ -19,6 +19,7 @@
 #include <linux/types.h>
 #include <linux/writeback.h>
 #include <linux/nospec.h>
+#include <linux/mount.h>
 
 static int check_quotactl_permission(struct super_block *sb, int type, int cmd,
 				     qid_t id)
@@ -781,16 +782,53 @@ static bool quotactl_cmd_onoff(int cmd)
 		 (cmd == Q_XQUOTAON) || (cmd == Q_XQUOTAOFF);
 }
 
+static struct super_block *quotactl_block(const char __user *special)
+{
+#ifdef CONFIG_BLOCK
+	struct block_device *bdev;
+	struct filename *tmp = getname(special);
+
+	if (IS_ERR(tmp))
+		return ERR_CAST(tmp);
+	bdev = lookup_bdev(tmp->name);
+	putname(tmp);
+	if (IS_ERR(bdev))
+		return ERR_CAST(bdev);
+
+	bdput(bdev);
+
+	return get_super(bdev);
+#else
+	return ERR_PTR(-ENODEV);
+#endif
+}
+
+static struct super_block *quotactl_path(const char __user *special)
+{
+	struct super_block *sb;
+	struct path path;
+	int ret;
+
+	ret = user_path_at(AT_FDCWD, special, LOOKUP_FOLLOW|LOOKUP_AUTOMOUNT, &path);
+	if (ret)
+		return ERR_PTR(ret);
+
+	sb = path.mnt->mnt_sb;
+
+	reference_super(sb);
+
+	path_put(&path);
+
+	return sb;
+}
+
 /*
  * look up a superblock on which quota ops will be performed
  * - use the name of a block device to find the superblock thereon
  */
-static struct super_block *quotactl_block(const char __user *special, int cmd)
+static struct super_block *quotactl_get_super(const char __user *special, int cmd)
 {
-#ifdef CONFIG_BLOCK
-	struct block_device *bdev;
 	struct super_block *sb;
-	struct filename *tmp = getname(special);
 	bool thawed = false, exclusive;
 	int ret;
 
@@ -802,18 +840,12 @@ static struct super_block *quotactl_block(const char __user *special, int cmd)
 		exclusive = false;
 	}
 
-	if (IS_ERR(tmp))
-		return ERR_CAST(tmp);
-	bdev = lookup_bdev(tmp->name);
-	putname(tmp);
-	if (IS_ERR(bdev))
-		return ERR_CAST(bdev);
-
-	bdput(bdev);
-
-	sb = get_super(bdev);
-	if (!sb)
-		return ERR_PTR(-ENODEV);
+	sb = quotactl_block(special);
+	if (IS_ERR(sb)) {
+		sb = quotactl_path(special);
+		if (IS_ERR(sb))
+			return ERR_CAST(sb);
+	}
 
 	if (thawed) {
 		ret = wait_super_thawed(sb, exclusive);
@@ -827,9 +859,6 @@ static struct super_block *quotactl_block(const char __user *special, int cmd)
 	}
 
 	return sb;
-#else
-	return ERR_PTR(-ENODEV);
-#endif
 }
 
 /*
@@ -873,7 +902,7 @@ int kernel_quotactl(unsigned int cmd, const char __user *special,
 			pathp = &path;
 	}
 
-	sb = quotactl_block(special, cmds);
+	sb = quotactl_get_super(special, cmds);
 	if (IS_ERR(sb)) {
 		ret = PTR_ERR(sb);
 		goto out;
diff --git a/fs/super.c b/fs/super.c
index 13380ffcbd8d..b23641f94557 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -819,6 +819,23 @@ int wait_super_thawed(struct super_block *sb, bool excl)
 }
 EXPORT_SYMBOL(wait_super_thawed);
 
+/**
+ * reference_super - get a reference to a given superblock
+ * @sb: superblock to get the reference from
+ *
+ * Takes a reference to a superblock. Can be used as when the superblock
+ * is known and leaves it in a state as if get_super had been called.
+ */
+void reference_super(struct super_block *sb)
+{
+	spin_lock(&sb_lock);
+	sb->s_count++;
+	spin_unlock(&sb_lock);
+
+	down_read(&sb->s_umount);
+}
+EXPORT_SYMBOL_GPL(reference_super);
+
 /**
  * get_active_super - get an active reference to the superblock of a device
  * @bdev: device to get the superblock for
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 59d9ea62942a..66aa9e5490d0 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3223,6 +3223,7 @@ extern struct super_block *get_super(struct block_device *);
 extern int wait_super_thawed(struct super_block *sb, bool excl);
 extern struct super_block *get_active_super(struct block_device *bdev);
 extern int super_wait_thawed(struct super_block *sb, bool excl);
+extern void reference_super(struct super_block *sb);
 extern void drop_super(struct super_block *sb);
 extern void drop_super_exclusive(struct super_block *sb);
 extern void iterate_supers(void (*)(struct super_block *, void *), void *);
-- 
2.20.1

