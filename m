Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B1D642A505
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Oct 2021 15:01:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236593AbhJLNDf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Oct 2021 09:03:35 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:13728 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232729AbhJLNDd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Oct 2021 09:03:33 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4HTG3F4r5mzWMyF;
        Tue, 12 Oct 2021 20:59:53 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Tue, 12 Oct 2021 21:01:30 +0800
Received: from huawei.com (10.175.103.91) by dggpeml500017.china.huawei.com
 (7.185.36.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 12 Oct
 2021 21:01:29 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
CC:     <viro@zeniv.linux.org.uk>
Subject: [PATCH] chardev: fix error handling in cdev_device_add()
Date:   Tue, 12 Oct 2021 21:09:15 +0800
Message-ID: <20211012130915.3426584-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

If dev->devt is not set, cdev_device_add() will not add the cdev,
when device_add failed, cdev_del() is not needed, so delete cdev
only when dev->devt is set.

Reported-by: Hulk Robot <hulkci@huawei.com>
Fixes: 233ed09d7fda ("chardev: add helper function to register...")
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 fs/char_dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/char_dev.c b/fs/char_dev.c
index ba0ded7842a7..3f667292608c 100644
--- a/fs/char_dev.c
+++ b/fs/char_dev.c
@@ -547,7 +547,7 @@ int cdev_device_add(struct cdev *cdev, struct device *dev)
 	}
 
 	rc = device_add(dev);
-	if (rc)
+	if (rc && dev->devt)
 		cdev_del(cdev);
 
 	return rc;
-- 
2.25.1

