Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F888109F0A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Nov 2019 14:18:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728257AbfKZNRJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Nov 2019 08:17:09 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:7172 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728047AbfKZNRJ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Nov 2019 08:17:09 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 81B80EC6394053749B91;
        Tue, 26 Nov 2019 21:17:04 +0800 (CST)
Received: from localhost.localdomain (10.175.124.28) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.439.0; Tue, 26 Nov 2019 21:16:53 +0800
From:   Zhang Xiaoxu <zhangxiaoxu5@huawei.com>
To:     <viro@zeniv.linux.org.uk>, <linux-fsdevel@vger.kernel.org>,
        <zhangxiaoxu5@huawei.com>
Subject: [PATCH v2] posix_acl: fix memleak when set posix acl.
Date:   Tue, 26 Nov 2019 21:38:09 +0800
Message-ID: <20191126133809.2082-1-zhangxiaoxu5@huawei.com>
X-Mailer: git-send-email 2.17.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When set posix acl, it maybe call posix_acl_update_mode in some
filesystem, eg. ext4. It may set acl to NULL, so, we can't free
the acl which allocated in posix_acl_xattr_set.

Use an temp value to store the acl address for posix_acl_release.

Signed-off-by: Zhang Xiaoxu <zhangxiaoxu5@huawei.com>
---
 fs/posix_acl.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/fs/posix_acl.c b/fs/posix_acl.c
index 84ad1c90d535..0a359d06274c 100644
--- a/fs/posix_acl.c
+++ b/fs/posix_acl.c
@@ -882,7 +882,7 @@ posix_acl_xattr_set(const struct xattr_handler *handler,
 		    const char *name, const void *value,
 		    size_t size, int flags)
 {
-	struct posix_acl *acl = NULL;
+	struct posix_acl *acl = NULL, *p = NULL;
 	int ret;
 
 	if (value) {
@@ -890,8 +890,15 @@ posix_acl_xattr_set(const struct xattr_handler *handler,
 		if (IS_ERR(acl))
 			return PTR_ERR(acl);
 	}
+
+	/*
+	 * when call set_posix_acl, posix_acl_update_mode may set acl
+	 * to NULL,use temporary variables p for posix_acl_release.
+	 */
+	p = acl;
 	ret = set_posix_acl(inode, handler->flags, acl);
-	posix_acl_release(acl);
+
+	posix_acl_release(p);
 	return ret;
 }
 
-- 
2.17.2

