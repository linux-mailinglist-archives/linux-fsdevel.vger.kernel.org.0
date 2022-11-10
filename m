Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E5D7624270
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Nov 2022 13:37:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbiKJMhx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Nov 2022 07:37:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbiKJMhu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Nov 2022 07:37:50 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5220B6BDE7;
        Thu, 10 Nov 2022 04:37:47 -0800 (PST)
Received: from canpemm500008.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4N7LvZ678BzmV5c;
        Thu, 10 Nov 2022 20:37:30 +0800 (CST)
Received: from localhost.localdomain (10.108.234.58) by
 canpemm500008.china.huawei.com (7.192.105.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 10 Nov 2022 20:37:45 +0800
From:   Wang Boshi <wangboshi@huawei.com>
To:     <viro@zeniv.linux.org.uk>
CC:     <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] fs: Delete group check before ACL
Date:   Thu, 10 Nov 2022 20:37:44 +0800
Message-ID: <20221110123744.10827-1-wangboshi@huawei.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.108.234.58]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500008.china.huawei.com (7.192.105.151)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Skipping full file ACL checks without no Group permissions causes we
can't deny access from specific users or groups which we ban according
ACL_USER, ACL_GROUP and ACL_MASK rules, because they may pass due to
Other permissions.

Example:
  date > test_file
  setfacl -m u:1000:rwx,g:2000:rwx,u::rwx,g::rwx,o::rwx,m::0 test_file
  capsh --groups=1000 --gid=1000 --uid=1000 -- -c "cat test_file"
  capsh --groups=2000 --gid=2000 --uid=2000 -- -c "cat test_file"

Signed-off-by: Wang Boshi <wangboshi@huawei.com>
---
 fs/namei.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/namei.c b/fs/namei.c
index 578c2110df02..d5772a31b5fc 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -347,7 +347,7 @@ static int acl_permission_check(struct user_namespace *mnt_userns,
 	}
 
 	/* Do we have ACL's? */
-	if (IS_POSIXACL(inode) && (mode & S_IRWXG)) {
+	if (IS_POSIXACL(inode)) {
 		int error = check_acl(mnt_userns, inode, mask);
 		if (error != -EAGAIN)
 			return error;
-- 
2.29.2

