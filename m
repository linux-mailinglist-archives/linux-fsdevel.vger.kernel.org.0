Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E0EE67B867
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jul 2019 06:08:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726378AbfGaEIG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 Jul 2019 00:08:06 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:43132 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725916AbfGaEIG (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 Jul 2019 00:08:06 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 0E4CE197A8F40876B5B6;
        Wed, 31 Jul 2019 11:21:10 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.439.0; Wed, 31 Jul 2019
 11:21:07 +0800
From:   Xiaojun Wang <wangxiaojun11@huawei.com>
To:     <linux-fsdevel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
CC:     <chao@kernel.org>
Subject: [PATCH] f2fs: fix memory leak in build_directory
Date:   Wed, 31 Jul 2019 11:27:01 +0800
Message-ID: <1564543621-123550-1-git-send-email-wangxiaojun11@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch fix bug that variable dentries going
out of scope leaks the storage it points to.

Signed-off-by: Xiaojun Wang<wangxiaojun11@huawei.com>
---
 fsck/sload.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fsck/sload.c b/fsck/sload.c
index f5a4651..e5de2e1 100644
--- a/fsck/sload.c
+++ b/fsck/sload.c
@@ -240,15 +240,18 @@ static int build_directory(struct f2fs_sb_info *sbi, const char *full_path,
 		ret = set_selinux_xattr(sbi, dentries[i].path,
 					dentries[i].ino, dentries[i].mode);
 		if (ret)
-			return ret;
+			goto out;
+	}
 
+out:
+	for (i = 0; i < entries; i++) {
 		free(dentries[i].path);
 		free(dentries[i].full_path);
 		free((void *)dentries[i].name);
 	}
 
 	free(dentries);
-	return 0;
+	return ret;
 }
 
 static int configure_files(void)
-- 
2.7.4

