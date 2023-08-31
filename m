Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 475F278F432
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Aug 2023 22:37:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347435AbjHaUhq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 31 Aug 2023 16:37:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347429AbjHaUho (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 Aug 2023 16:37:44 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C40F0E5F
        for <linux-fsdevel@vger.kernel.org>; Thu, 31 Aug 2023 13:37:38 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-58e49935630so21799047b3.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 31 Aug 2023 13:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693514258; x=1694119058; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xGxCZUuxbWSlNwkUI6nwNutDuYApOwCOxRWfVwGAJ3o=;
        b=aPRx0fT3CkSVIUrV1PmRN5ysG5vkys23TxgntCvZjZmRN3QniZCggOCA9k7y7K3v9h
         FrI4K80Xv1u9VMu9jmSo4bhQacOu1p2oqbOhfUI5Kbv+wMBWBXBNSCLaduV+uI4DDtq8
         Z1GFMFhr5LPG+g91Z98MRMwvrnqBy3wlV/pDdgdBz5TWQlbGqhR4FFCpUXOWQYz+CpWw
         X+YUHGmAhuIwkPHdJR5JhVYargvNqzLZlSAY2Y2BqOX/ritvItNqFvn4l5g0CiO58vz1
         APGqJ0r93JUep3jiNB4pqvtZXvMXWBurUia7FZgC64riK11fv7j/bW9yGJinxYytA67E
         vhKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693514258; x=1694119058;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xGxCZUuxbWSlNwkUI6nwNutDuYApOwCOxRWfVwGAJ3o=;
        b=Nc5jBs5sC/Hl07BK/9d7twzOdWHZ3jQwec5WfyJeLrBI4UrimnQ1ZUSX1kP8kuh59V
         nsNNHIV81JPcLSCGkECdK16s0R+q3bcDXL2wRCnWhJjGFmxNdmy66UNq94wHym4KYjHd
         97mc9IVgEgWQfRtB5e1Ex2ArTSQE7Qm98G5cakTm7nFE2xO94h/EYzqlWkQcYGclwij8
         xWTIfjFX6odsYYdCk0qnC5xB2pD03HPITxrZmKE/37nw2MwzOcvtt4h/BOlrqoXSpIqe
         bKXwoXIcHMJixnoPyVNYwBYuSSjpT+PFULY0HERw/ojppwh62c4d3dyK+XVinMSkwr5Z
         e+YA==
X-Gm-Message-State: AOJu0YzD9/nGCKWHddQ+FXfLlWpJLOQbPYMsl1tIdlnl582n7SoSOGy5
        M9qBa6Bk6li4frT8BknPa9hZWjM6AIDyUGfK
X-Google-Smtp-Source: AGHT+IERJHbjR+c/ciTN5Esvviq3kVNk3iU0MzA8FlGygkmNX9iS6RTXYbmmUYknoi7aexCc3wAuxahV5uNuP5zC
X-Received: from mclapinski.waw.corp.google.com ([2a00:79e0:9b:0:36f8:f0a:6df2:a7d5])
 (user=mclapinski job=sendgmr) by 2002:a05:690c:2b8b:b0:594:f596:e232 with
 SMTP id en11-20020a05690c2b8b00b00594f596e232mr20144ywb.2.1693514257991; Thu,
 31 Aug 2023 13:37:37 -0700 (PDT)
Date:   Thu, 31 Aug 2023 22:36:47 +0200
In-Reply-To: <20230831203647.558079-1-mclapinski@google.com>
Mime-Version: 1.0
References: <20230831203647.558079-1-mclapinski@google.com>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Message-ID: <20230831203647.558079-3-mclapinski@google.com>
Subject: [PATCH 2/2] selftests: test fcntl(F_CHECK_ORIGINAL_MEMFD)
From:   Michal Clapinski <mclapinski@google.com>
To:     Jeff Layton <jlayton@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jeff Xu <jeffxu@google.com>, Aleksa Sarai <cyphar@cyphar.com>,
        Daniel Verkamp <dverkamp@chromium.org>,
        Kees Cook <keescook@chromium.org>,
        Marc Dionne <marc.dionne@auristor.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     Michal Clapinski <mclapinski@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Signed-off-by: Michal Clapinski <mclapinski@google.com>
---
 tools/testing/selftests/memfd/memfd_test.c | 32 ++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/tools/testing/selftests/memfd/memfd_test.c b/tools/testing/selftests/memfd/memfd_test.c
index 3df008677239..4f3b7615ca87 100644
--- a/tools/testing/selftests/memfd/memfd_test.c
+++ b/tools/testing/selftests/memfd/memfd_test.c
@@ -39,6 +39,10 @@
 
 #define MFD_NOEXEC_SEAL	0x0008U
 
+#ifndef F_CHECK_ORIGINAL_MEMFD
+#define F_CHECK_ORIGINAL_MEMFD	(1024 + 15)
+#endif
+
 /*
  * Default is not to test hugetlbfs
  */
@@ -1567,6 +1571,32 @@ static void test_share_fork(char *banner, char *b_suffix)
 	close(fd);
 }
 
+static void test_fcntl_check_original(void)
+{
+	int fd, fd2;
+	char path[128];
+
+	printf("%s FCNTL-CHECK-ORIGINAL\n", memfd_str);
+	fd = sys_memfd_create("kern_memfd_exec_reopen", 0);
+	if (fd < 0) {
+		printf("memfd_create failed: %m\n");
+		abort();
+	}
+	if (fcntl(fd, F_CHECK_ORIGINAL_MEMFD) != 1) {
+		printf("fcntl(F_CHECK_ORIGINAL_MEMFD) failed\n");
+		abort();
+	}
+
+	fd2 = mfd_assert_reopen_fd(fd);
+	if (fcntl(fd2, F_CHECK_ORIGINAL_MEMFD) != 0) {
+		printf("fcntl(F_CHECK_ORIGINAL_MEMFD) failed\n");
+		abort();
+	}
+
+	close(fd);
+	close(fd2);
+}
+
 int main(int argc, char **argv)
 {
 	pid_t pid;
@@ -1609,6 +1639,8 @@ int main(int argc, char **argv)
 	test_share_open("SHARE-OPEN", "");
 	test_share_fork("SHARE-FORK", "");
 
+	test_fcntl_check_original();
+
 	/* Run test-suite in a multi-threaded environment with a shared
 	 * file-table. */
 	pid = spawn_idle_thread(CLONE_FILES | CLONE_FS | CLONE_VM);
-- 
2.42.0.283.g2d96d420d3-goog

