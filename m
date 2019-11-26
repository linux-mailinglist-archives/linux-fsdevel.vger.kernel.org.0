Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 18DBA109A21
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Nov 2019 09:29:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727150AbfKZI3X (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Nov 2019 03:29:23 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:55484 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725862AbfKZI3X (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Nov 2019 03:29:23 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id B983CDBC71DB5DDC4140;
        Tue, 26 Nov 2019 16:29:14 +0800 (CST)
Received: from localhost.localdomain (10.175.124.28) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.439.0; Tue, 26 Nov 2019 16:29:05 +0800
From:   Zhang Xiaoxu <zhangxiaoxu5@huawei.com>
To:     <viro@zeniv.linux.org.uk>, <linux-fsdevel@vger.kernel.org>,
        <zhangxiaoxu5@huawei.com>
Subject: [PATCH] posix_acl: fix memleak when set posix acl.
Date:   Tue, 26 Nov 2019 16:50:19 +0800
Message-ID: <20191126085019.20226-1-zhangxiaoxu5@huawei.com>
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
 fs/posix_acl.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/posix_acl.c b/fs/posix_acl.c
index 84ad1c90d535..b90902d7e6ad 100644
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
@@ -890,8 +890,13 @@ posix_acl_xattr_set(const struct xattr_handler *handler,
 		if (IS_ERR(acl))
 			return PTR_ERR(acl);
 	}
+
+	/* when call set_posix_acl, posix_acl_update_mode may set acl to NULL,
+	   use temporary variables p for posix_acl_release. */
+	p = acl;
 	ret = set_posix_acl(inode, handler->flags, acl);
-	posix_acl_release(acl);
+
+	posix_acl_release(p);
 	return ret;
 }
 
-- 
2.17.2

