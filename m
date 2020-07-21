Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 666732285A9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jul 2020 18:30:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730330AbgGUQ2b (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Jul 2020 12:28:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728432AbgGUQ23 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Jul 2020 12:28:29 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDE07C0619DA;
        Tue, 21 Jul 2020 09:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=XAvmv1Dl0w8Zpf/KQARmzzrtRh2ODKzOSAZO8WVKkSg=; b=tXrgBqGAHo4E0VBkb2nw9VyfvD
        9IRTxUlxuz0ouJ6VjOfWwo5xwX2jtGUDhnB/PPyj7ye4XdZrTgxnlTESz22JKRwwhAXils98CWURu
        SVkOjms0QSposrqfehUAagszD2Wq0rNdV2j6QFCF5nvY/esvkPMKRxnz+G3f1g5F9w9zi2lX+9yev
        tdyWnCvLfKNrh4yNIp/FAMCvdLF29u62EWzp+xkxnT0bV062m7zdtpO6inhVrCahfFwsu0jqko3Eb
        5LpKmCWQ6XjxyLCboyCWs5ZTMhA6cCQIVUY27cvgnXaLjpIiVDMDvIKLalAhh5+ncsG5jLa8z+FGh
        aiHc6a/A==;
Received: from [2001:4bb8:18c:2acc:5b1c:6483:bd6d:e406] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jxv7w-0007Ru-OJ; Tue, 21 Jul 2020 16:28:25 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Subject: [PATCH 04/24] devtmpfs: open code do_mount
Date:   Tue, 21 Jul 2020 18:27:58 +0200
Message-Id: <20200721162818.197315-5-hch@lst.de>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200721162818.197315-1-hch@lst.de>
References: <20200721162818.197315-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Replace do_umount with an open coded version that takes the proper
kernel pointer instead of relying on the implicit set_fs(KERNEL_DS)
during early init.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/base/devtmpfs.c | 17 +++++++++++++++--
 fs/namespace.c          |  2 +-
 include/linux/mount.h   |  3 +++
 3 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/base/devtmpfs.c b/drivers/base/devtmpfs.c
index c9017e0584c003..5e8d677ee783bc 100644
--- a/drivers/base/devtmpfs.c
+++ b/drivers/base/devtmpfs.c
@@ -345,6 +345,19 @@ static int handle_remove(const char *nodename, struct device *dev)
 	return err;
 }
 
+static int devtmpfs_do_mount(const char __user *dir_name)
+{
+	struct path p;
+	int ret;
+
+	ret = kern_path(dir_name, LOOKUP_FOLLOW, &p);
+	if (ret)
+		return ret;
+	ret = path_mount("devtmpfs", &p, "devtmpfs", MS_SILENT, NULL);
+	path_put(&p);
+	return ret;
+}
+
 /*
  * If configured, or requested by the commandline, devtmpfs will be
  * auto-mounted after the kernel mounted the root filesystem.
@@ -359,7 +372,7 @@ int __init devtmpfs_mount(void)
 	if (!thread)
 		return 0;
 
-	err = do_mount("devtmpfs", "dev", "devtmpfs", MS_SILENT, NULL);
+	err = devtmpfs_do_mount("dev");
 	if (err)
 		printk(KERN_INFO "devtmpfs: error mounting %i\n", err);
 	else
@@ -385,7 +398,7 @@ static int devtmpfs_setup(void *p)
 	err = ksys_unshare(CLONE_NEWNS);
 	if (err)
 		goto out;
-	err = do_mount("devtmpfs", "/", "devtmpfs", MS_SILENT, NULL);
+	err = devtmpfs_do_mount("/");
 	if (err)
 		goto out;
 	ksys_chdir("/.."); /* will traverse into overmounted root */
diff --git a/fs/namespace.c b/fs/namespace.c
index 43834b59eff6c3..2c4d7592097485 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -3111,7 +3111,7 @@ char *copy_mount_string(const void __user *data)
  * Therefore, if this magic number is present, it carries no information
  * and must be discarded.
  */
-static int path_mount(const char *dev_name, struct path *path,
+int path_mount(const char *dev_name, struct path *path,
 		const char *type_page, unsigned long flags, void *data_page)
 {
 	unsigned int mnt_flags = 0, sb_flags;
diff --git a/include/linux/mount.h b/include/linux/mount.h
index de657bd211fa64..bf9896f86a48f4 100644
--- a/include/linux/mount.h
+++ b/include/linux/mount.h
@@ -113,4 +113,7 @@ extern bool path_is_mountpoint(const struct path *path);
 
 extern void kern_unmount_array(struct vfsmount *mnt[], unsigned int num);
 
+int path_mount(const char *dev_name, struct path *path, const char *type_page,
+		unsigned long flags, void *data_page);
+
 #endif /* _LINUX_MOUNT_H */
-- 
2.27.0

