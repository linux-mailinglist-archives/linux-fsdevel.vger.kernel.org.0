Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FA5638D955
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 May 2021 08:53:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231665AbhEWGxd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 23 May 2021 02:53:33 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:5520 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231644AbhEWGxd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 23 May 2021 02:53:33 -0400
Received: from dggems702-chm.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FnrY41PqDzkY2V;
        Sun, 23 May 2021 14:49:12 +0800 (CST)
Received: from dggema769-chm.china.huawei.com (10.1.198.211) by
 dggems702-chm.china.huawei.com (10.3.19.179) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Sun, 23 May 2021 14:52:01 +0800
Received: from localhost (10.174.179.215) by dggema769-chm.china.huawei.com
 (10.1.198.211) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Sun, 23
 May 2021 14:52:00 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <miklos@szeredi.hu>
CC:     <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] cuse: use DEVICE_ATTR_*() macros
Date:   Sun, 23 May 2021 14:51:52 +0800
Message-ID: <20210523065152.29632-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggema769-chm.china.huawei.com (10.1.198.211)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use DEVICE_ATTR_*() helper instead of plain DEVICE_ATTR,
which makes the code a bit shorter and easier to read.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 fs/fuse/cuse.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/fuse/cuse.c b/fs/fuse/cuse.c
index c7d882a9fe33..0df886224afe 100644
--- a/fs/fuse/cuse.c
+++ b/fs/fuse/cuse.c
@@ -574,25 +574,25 @@ static struct file_operations cuse_channel_fops; /* initialized during init */
  * CUSE exports the same set of attributes to sysfs as fusectl.
  */
 
-static ssize_t cuse_class_waiting_show(struct device *dev,
-				       struct device_attribute *attr, char *buf)
+static ssize_t waiting_show(struct device *dev,
+			    struct device_attribute *attr, char *buf)
 {
 	struct cuse_conn *cc = dev_get_drvdata(dev);
 
 	return sprintf(buf, "%d\n", atomic_read(&cc->fc.num_waiting));
 }
-static DEVICE_ATTR(waiting, 0400, cuse_class_waiting_show, NULL);
+static DEVICE_ATTR_ADMIN_RO(waiting);
 
-static ssize_t cuse_class_abort_store(struct device *dev,
-				      struct device_attribute *attr,
-				      const char *buf, size_t count)
+static ssize_t abort_store(struct device *dev,
+			   struct device_attribute *attr,
+			   const char *buf, size_t count)
 {
 	struct cuse_conn *cc = dev_get_drvdata(dev);
 
 	fuse_abort_conn(&cc->fc);
 	return count;
 }
-static DEVICE_ATTR(abort, 0200, NULL, cuse_class_abort_store);
+static DEVICE_ATTR_WO(abort);
 
 static struct attribute *cuse_class_dev_attrs[] = {
 	&dev_attr_waiting.attr,
-- 
2.17.1

