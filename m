Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D1305BE55E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Sep 2022 14:12:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230346AbiITMMg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Sep 2022 08:12:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230341AbiITMMf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Sep 2022 08:12:35 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6454E6BD6E;
        Tue, 20 Sep 2022 05:12:31 -0700 (PDT)
Received: from dggpeml500022.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MX0j12T20zpSyJ;
        Tue, 20 Sep 2022 20:09:41 +0800 (CST)
Received: from dggpeml500008.china.huawei.com (7.185.36.147) by
 dggpeml500022.china.huawei.com (7.185.36.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 20 Sep 2022 20:12:29 +0800
Received: from huawei.com (10.67.175.34) by dggpeml500008.china.huawei.com
 (7.185.36.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 20 Sep
 2022 20:12:28 +0800
From:   Ren Zhijie <renzhijie2@huawei.com>
To:     <ebiederm@xmission.com>, <keescook@chromium.org>,
        <viro@zeniv.linux.org.uk>
CC:     <linux-mm@kvack.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <tanghui20@huawei.com>
Subject: [PATCH] exec: Force binary name when argv is empty
Date:   Tue, 20 Sep 2022 20:08:12 +0800
Message-ID: <20220920120812.231417-1-renzhijie2@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.175.34]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500008.china.huawei.com (7.185.36.147)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Hui Tang <tanghui20@huawei.com>

First run './execv-main execv-child', there is empty in 'COMMAND' column
when run 'ps -u'.

 USER       PID %CPU %MEM    VSZ   RSS TTY    [...] TIME COMMAND
 root       368  0.3  0.0   4388   764 ttyS0        0:00 ./execv-main
 root       369  0.6  0.0   4520   812 ttyS0        0:00

The program 'execv-main' as follows:

 int main(int argc, char **argv)
 {
   char *execv_argv[] = {NULL};
   pid_t pid = fork();

   if (pid == 0) {
     execv(argv[1], execv_argv);
   } else if (pid > 0) {
     wait(NULL);
   }
   return 0;
 }

So replace empty string ("") added with the name of binary
when calling execve with a NULL argv.

Fixes: dcd46d897adb ("exec: Force single empty string when argv is empty")
Signed-off-by: Hui Tang <tanghui20@huawei.com>
---
 fs/exec.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 939d76e23935..7d1909a89a57 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -494,8 +494,8 @@ static int bprm_stack_limits(struct linux_binprm *bprm)
 	 * signal to the parent that the child has run out of stack space.
 	 * Instead, calculate it here so it's possible to fail gracefully.
 	 *
-	 * In the case of argc = 0, make sure there is space for adding a
-	 * empty string (which will bump argc to 1), to ensure confused
+	 * In the case of argc = 0, make sure there is space for adding
+	 * bprm->filename (which will bump argc to 1), to ensure confused
 	 * userspace programs don't start processing from argv[1], thinking
 	 * argc can never be 0, to keep them from walking envp by accident.
 	 * See do_execveat_common().
@@ -1900,7 +1900,7 @@ static int do_execveat_common(int fd, struct filename *filename,
 
 	retval = count(argv, MAX_ARG_STRINGS);
 	if (retval == 0)
-		pr_warn_once("process '%s' launched '%s' with NULL argv: empty string added\n",
+		pr_warn_once("process '%s' launched '%s' with NULL argv: bprm->filename added\n",
 			     current->comm, bprm->filename);
 	if (retval < 0)
 		goto out_free;
@@ -1929,13 +1929,13 @@ static int do_execveat_common(int fd, struct filename *filename,
 		goto out_free;
 
 	/*
-	 * When argv is empty, add an empty string ("") as argv[0] to
+	 * When argv is empty, add bprm->filename as argv[0] to
 	 * ensure confused userspace programs that start processing
 	 * from argv[1] won't end up walking envp. See also
 	 * bprm_stack_limits().
 	 */
 	if (bprm->argc == 0) {
-		retval = copy_string_kernel("", bprm);
+		retval = copy_string_kernel(bprm->filename, bprm);
 		if (retval < 0)
 			goto out_free;
 		bprm->argc = 1;
-- 
2.17.1

