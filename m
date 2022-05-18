Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2E0452B45B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 May 2022 10:07:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232939AbiERH7d (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 May 2022 03:59:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232896AbiERH7c (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 May 2022 03:59:32 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4561712719B;
        Wed, 18 May 2022 00:59:31 -0700 (PDT)
Received: from kwepemi500013.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4L350f4WXkzQk9h;
        Wed, 18 May 2022 15:56:34 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (7.193.23.68) by
 kwepemi500013.china.huawei.com (7.221.188.120) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 18 May 2022 15:59:28 +0800
Received: from huawei.com (10.175.127.227) by kwepemm600013.china.huawei.com
 (7.193.23.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 18 May
 2022 15:59:28 +0800
From:   Zhihao Cheng <chengzhihao1@huawei.com>
To:     <keescook@chromium.org>, <viro@zeniv.linux.org.uk>,
        <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <chengzhihao1@huawei.com>,
        <yukuai3@huawei.com>
Subject: [PATCH -next] exec: Remove redundant check in do_open_execat/uselib
Date:   Wed, 18 May 2022 16:12:27 +0800
Message-ID: <20220518081227.1278192-1-chengzhihao1@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600013.china.huawei.com (7.193.23.68)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

There is a false positive WARNON happening in execve(2)/uselib(2)
syscalls with concurrent noexec-remount.

       execveat                           remount
do_open_execat(path/bin)
  do_filp_open
    path_openat
      do_open
        may_open
          path_noexec() // PASS
	                            remount(path->mnt, MS_NOEXEC)
WARNON(path_noexec(&file->f_path)) // path_noexec() checks fail

Since may_open() has already checked the same conditions, fix it by
removing 'S_ISREG' and 'path_noexec' check in do_open_execat()/uselib(2).

Fixes: 0fd338b2d2cdf8 ("exec: move path_noexec() check earlier")
Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 fs/exec.c | 22 +---------------------
 1 file changed, 1 insertion(+), 21 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index e3e55d5e0be1..0f8ea7e9e03c 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -141,16 +141,6 @@ SYSCALL_DEFINE1(uselib, const char __user *, library)
 	if (IS_ERR(file))
 		goto out;
 
-	/*
-	 * may_open() has already checked for this, so it should be
-	 * impossible to trip now. But we need to be extra cautious
-	 * and check again at the very end too.
-	 */
-	error = -EACCES;
-	if (WARN_ON_ONCE(!S_ISREG(file_inode(file)->i_mode) ||
-			 path_noexec(&file->f_path)))
-		goto exit;
-
 	fsnotify_open(file);
 
 	error = -ENOEXEC;
@@ -169,7 +159,7 @@ SYSCALL_DEFINE1(uselib, const char __user *, library)
 			break;
 	}
 	read_unlock(&binfmt_lock);
-exit:
+
 	fput(file);
 out:
   	return error;
@@ -919,16 +909,6 @@ static struct file *do_open_execat(int fd, struct filename *name, int flags)
 	if (IS_ERR(file))
 		goto out;
 
-	/*
-	 * may_open() has already checked for this, so it should be
-	 * impossible to trip now. But we need to be extra cautious
-	 * and check again at the very end too.
-	 */
-	err = -EACCES;
-	if (WARN_ON_ONCE(!S_ISREG(file_inode(file)->i_mode) ||
-			 path_noexec(&file->f_path)))
-		goto exit;
-
 	err = deny_write_access(file);
 	if (err)
 		goto exit;
-- 
2.31.1

