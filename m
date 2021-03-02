Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FB3C32A518
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Mar 2021 16:59:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443367AbhCBLrM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Mar 2021 06:47:12 -0500
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:57358 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1836040AbhCBGdG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Mar 2021 01:33:06 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0UQ3O2-B_1614666743;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0UQ3O2-B_1614666743)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 02 Mar 2021 14:32:24 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH] xattr: switch to vmemdup_user()
Date:   Tue,  2 Mar 2021 14:32:21 +0800
Message-Id: <1614666741-16796-1-git-send-email-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Replace opencoded alloc and copy with vmemdup_user()

fixed the following coccicheck:
./fs/xattr.c:561:11-19: WARNING opportunity for vmemdup_user

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 fs/xattr.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/fs/xattr.c b/fs/xattr.c
index b3444e0..b947ad2 100644
--- a/fs/xattr.c
+++ b/fs/xattr.c
@@ -558,11 +558,10 @@ int __vfs_setxattr_noperm(struct user_namespace *mnt_userns,
 	if (size) {
 		if (size > XATTR_SIZE_MAX)
 			return -E2BIG;
-		kvalue = kvmalloc(size, GFP_KERNEL);
-		if (!kvalue)
-			return -ENOMEM;
-		if (copy_from_user(kvalue, value, size)) {
-			error = -EFAULT;
+		kvalue = vmemdup_user(value, size);
+
+		if (IS_ERR(kvalue)) {
+			r = PTR_ERR(kvalue);
 			goto out;
 		}
 		if ((strcmp(kname, XATTR_NAME_POSIX_ACL_ACCESS) == 0) ||
-- 
1.8.3.1

