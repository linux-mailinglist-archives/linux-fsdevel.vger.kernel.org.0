Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F5327559F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jul 2019 19:25:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729876AbfGYRXr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Jul 2019 13:23:47 -0400
Received: from ale.deltatee.com ([207.54.116.67]:39620 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729870AbfGYRXq (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Jul 2019 13:23:46 -0400
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1hqhSv-0001JF-V8; Thu, 25 Jul 2019 11:23:45 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1hqhSv-0001n8-0Z; Thu, 25 Jul 2019 11:23:41 -0600
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Stephen Bates <sbates@raithlin.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Date:   Thu, 25 Jul 2019 11:23:21 -0600
Message-Id: <20190725172335.6825-3-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190725172335.6825-1-logang@deltatee.com>
References: <20190725172335.6825-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org, hch@lst.de, sagi@grimberg.me, kbusch@kernel.org, axboe@fb.com, Chaitanya.Kulkarni@wdc.com, maxg@mellanox.com, sbates@raithlin.com, logang@deltatee.com, gregkh@linuxfoundation.org, viro@zeniv.linux.org.uk
X-SA-Exim-Mail-From: gunthorp@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        GREYLIST_ISWHITE,MYRULES_NO_TEXT autolearn=ham autolearn_force=no
        version=3.4.2
Subject: [PATCH v6 02/16] chardev: introduce cdev_get_by_path()
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

cdev_get_by_path() attempts to retrieve a struct cdev from
a path name. It is analagous to blkdev_get_by_path().

This will be necessary to create a nvme_ctrl_get_by_path()to
support NVMe-OF passthru.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
---
 fs/char_dev.c        | 34 ++++++++++++++++++++++++++++++++++
 include/linux/cdev.h |  1 +
 2 files changed, 35 insertions(+)

diff --git a/fs/char_dev.c b/fs/char_dev.c
index 5cc53bd5f654..25037d642ff8 100644
--- a/fs/char_dev.c
+++ b/fs/char_dev.c
@@ -22,6 +22,7 @@
 #include <linux/mutex.h>
 #include <linux/backing-dev.h>
 #include <linux/tty.h>
+#include <linux/namei.h>
 
 #include "internal.h"
 
@@ -403,6 +404,38 @@ static struct cdev *cdev_lookup(struct inode *inode)
 	return p;
 }
 
+struct cdev *cdev_get_by_path(const char *pathname)
+{
+	struct inode *inode;
+	struct cdev *cdev;
+	struct path path;
+	int error;
+
+	if (!pathname || !*pathname)
+		return ERR_PTR(-EINVAL);
+
+	error = kern_path(pathname, LOOKUP_FOLLOW, &path);
+	if (error)
+		return ERR_PTR(error);
+
+	if (!may_open_dev(&path)) {
+		cdev = ERR_PTR(-EACCES);
+		goto out;
+	}
+
+	inode = d_backing_inode(path.dentry);
+	if (!S_ISCHR(inode->i_mode)) {
+		cdev = ERR_PTR(-EINVAL);
+		goto out;
+	}
+
+	cdev = cdev_lookup(inode);
+
+out:
+	path_put(&path);
+	return cdev;
+}
+
 /*
  * Called every time a character special file is opened
  */
@@ -690,5 +723,6 @@ EXPORT_SYMBOL(cdev_add);
 EXPORT_SYMBOL(cdev_set_parent);
 EXPORT_SYMBOL(cdev_device_add);
 EXPORT_SYMBOL(cdev_device_del);
+EXPORT_SYMBOL(cdev_get_by_path);
 EXPORT_SYMBOL(__register_chrdev);
 EXPORT_SYMBOL(__unregister_chrdev);
diff --git a/include/linux/cdev.h b/include/linux/cdev.h
index 0e8cd6293deb..c7f2df2ca69a 100644
--- a/include/linux/cdev.h
+++ b/include/linux/cdev.h
@@ -24,6 +24,7 @@ void cdev_init(struct cdev *, const struct file_operations *);
 
 struct cdev *cdev_alloc(void);
 
+struct cdev *cdev_get_by_path(const char *pathname);
 void cdev_put(struct cdev *p);
 
 int cdev_add(struct cdev *, dev_t, unsigned);
-- 
2.20.1

