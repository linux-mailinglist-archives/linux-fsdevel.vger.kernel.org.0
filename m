Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22F6E752113
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jul 2023 14:19:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234646AbjGMMT3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Jul 2023 08:19:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234660AbjGMMT1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Jul 2023 08:19:27 -0400
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D02E2691;
        Thu, 13 Jul 2023 05:19:25 -0700 (PDT)
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4R1tvY219Sz9scb;
        Thu, 13 Jul 2023 14:19:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
        t=1689250761;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=xpxD6jJvH2NdvxBxxbA/xwwWPK026oBkIsxvhSiVppQ=;
        b=cylZYD1v3/ux3bOiBo3SI+1bkuoVoVNqjUBtUccqLVf/rjbGuRgjZ0Z6usXEm/u3ktL1v8
        71xqGF6BjvRUpF2MnI9/7rMzhIJe/qPc8YUXWpj0UYEfTX9ESVdtOBLWqZLgY7p++dgdWJ
        u3LO9hPOjKSXDO1Hdr9TLWSe9AaFE1cVOGBWKLQOC3KS9lCI8780JZMgKP2RRkDvY6wB8k
        O/ESIRtcVJZPbUKsdZQMUgeQ8k77eFHC/zczIBMUoA+jhMfQO7oJ+Ey0zEVYj5s+ez7voJ
        3U9095AoedknarhqdaeQj74FN+bFWJ21aH9h5d0W5dmoY/1l3hvYwrOffueUmA==
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>,
        Dave Chinner <dchinner@redhat.com>,
        xu xin <cgel.zte@gmail.com>, Al Viro <viro@zeniv.linux.org.uk>,
        Stefan Roesch <shr@devkernel.io>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Zhihao Cheng <chengzhihao1@huawei.com>,
        "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Janis Danisevskis <jdanis@google.com>,
        Kees Cook <keescook@chromium.org>
Cc:     stable@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH] procfs: block chmod on /proc/thread-self/comm
Date:   Thu, 13 Jul 2023 22:19:04 +1000
Message-ID: <20230713121907.9693-1-cyphar@cyphar.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4R1tvY219Sz9scb
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Due to an oversight in commit 1b3044e39a89 ("procfs: fix pthread
cross-thread naming if !PR_DUMPABLE") in switching from REG to NOD,
chmod operations on /proc/thread-self/comm were no longer blocked as
they are on almost all other procfs files.

A very similar situation with /proc/self/environ was used to as a root
exploit a long time ago, but procfs has SB_I_NOEXEC so this is simply a
correctness issue.

Ref: https://lwn.net/Articles/191954/
Ref: 6d76fa58b050 ("Don't allow chmod() on the /proc/<pid>/ files")
Fixes: 1b3044e39a89 ("procfs: fix pthread cross-thread naming if !PR_DUMPABLE")
Cc: stable@vger.kernel.org # v4.7+
Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
---
 fs/proc/base.c                               | 3 ++-
 tools/testing/selftests/nolibc/nolibc-test.c | 4 ++++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index 05452c3b9872..7394229816f3 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -3583,7 +3583,8 @@ static int proc_tid_comm_permission(struct mnt_idmap *idmap,
 }
 
 static const struct inode_operations proc_tid_comm_inode_operations = {
-		.permission = proc_tid_comm_permission,
+		.setattr	= proc_setattr,
+		.permission	= proc_tid_comm_permission,
 };
 
 /*
diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index 486334981e60..08f0969208eb 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -580,6 +580,10 @@ int run_syscall(int min, int max)
 		CASE_TEST(chmod_net);         EXPECT_SYSZR(proc, chmod("/proc/self/net", 0555)); break;
 		CASE_TEST(chmod_self);        EXPECT_SYSER(proc, chmod("/proc/self", 0555), -1, EPERM); break;
 		CASE_TEST(chown_self);        EXPECT_SYSER(proc, chown("/proc/self", 0, 0), -1, EPERM); break;
+		CASE_TEST(chmod_self_comm);   EXPECT_SYSER(proc, chmod("/proc/self/comm", 0777), -1, EPERM); break;
+		CASE_TEST(chmod_tid_comm);    EXPECT_SYSER(proc, chmod("/proc/thread-self/comm", 0777), -1, EPERM); break;
+		CASE_TEST(chmod_self_environ);EXPECT_SYSER(proc, chmod("/proc/self/environ", 0777), -1, EPERM); break;
+		CASE_TEST(chmod_tid_environ); EXPECT_SYSER(proc, chmod("/proc/thread-self/environ", 0777), -1, EPERM); break;
 		CASE_TEST(chroot_root);       EXPECT_SYSZR(euid0, chroot("/")); break;
 		CASE_TEST(chroot_blah);       EXPECT_SYSER(1, chroot("/proc/self/blah"), -1, ENOENT); break;
 		CASE_TEST(chroot_exe);        EXPECT_SYSER(proc, chroot("/proc/self/exe"), -1, ENOTDIR); break;
-- 
2.41.0

