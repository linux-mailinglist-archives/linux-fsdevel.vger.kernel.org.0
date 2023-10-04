Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4D867B7F98
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Oct 2023 14:46:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242499AbjJDMqg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Oct 2023 08:46:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242394AbjJDMqf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Oct 2023 08:46:35 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E595C9
        for <linux-fsdevel@vger.kernel.org>; Wed,  4 Oct 2023 05:46:32 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C32D31F855;
        Wed,  4 Oct 2023 12:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1696423590; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OUoVyxQDPI04NNDmHhtQVcaincSOaQHC43/Y+1GZ/uQ=;
        b=q+fA0bpyoiDMgg9i3CJ3rwpMwxClR9dIiTSozDPym2lvQDzfmdZyaAK48DoLihanXG4+1/
        R7OZ6kf68gDVY2FXJrSjZG5UyBZqDCRkZt92g5u7Dp4Pd3hDFUAJp4Uj9s8Q/f/ix1wrSi
        R8Vmds5NYYbLM4SlmzKMSQfhdaY2jy8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1696423590;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OUoVyxQDPI04NNDmHhtQVcaincSOaQHC43/Y+1GZ/uQ=;
        b=HO7kkoFSU5Jhhc493Sg2u9zSHCBpRgjdqZ5bfqsGy0n1BEchfSEx1V1LNwL29a7k4Ph7Dq
        MoGpxm9xlfntKyAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AD23813A2E;
        Wed,  4 Oct 2023 12:46:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id f2zvKKZeHWXfPAAAMHmgww
        (envelope-from <chrubis@suse.cz>); Wed, 04 Oct 2023 12:46:30 +0000
From:   Cyril Hrubis <chrubis@suse.cz>
To:     ltp@lists.linux.it
Cc:     Matthew Wilcox <willy@infradead.org>, amir73il@gmail.com,
        mszeredi@redhat.com, brauner@kernel.org, viro@zeniv.linux.org.uk,
        Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Subject: [PATCH 3/3] syscalls: accept: Add tst_fd_iterate() test
Date:   Wed,  4 Oct 2023 14:47:12 +0200
Message-ID: <20231004124712.3833-4-chrubis@suse.cz>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231004124712.3833-1-chrubis@suse.cz>
References: <20231004124712.3833-1-chrubis@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 runtest/syscalls                            |  1 +
 testcases/kernel/syscalls/accept/.gitignore |  1 +
 testcases/kernel/syscalls/accept/accept01.c |  8 ----
 testcases/kernel/syscalls/accept/accept03.c | 46 +++++++++++++++++++++
 4 files changed, 48 insertions(+), 8 deletions(-)
 create mode 100644 testcases/kernel/syscalls/accept/accept03.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 8652e0bd3..25b53a724 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -3,6 +3,7 @@ abort01 abort01
 
 accept01 accept01
 accept02 accept02
+accept03 accept03
 
 accept4_01 accept4_01
 
diff --git a/testcases/kernel/syscalls/accept/.gitignore b/testcases/kernel/syscalls/accept/.gitignore
index 5b1462699..f81d4bec9 100644
--- a/testcases/kernel/syscalls/accept/.gitignore
+++ b/testcases/kernel/syscalls/accept/.gitignore
@@ -1,2 +1,3 @@
 /accept01
 /accept02
+/accept03
diff --git a/testcases/kernel/syscalls/accept/accept01.c b/testcases/kernel/syscalls/accept/accept01.c
index 85af0f8af..e5db1dfec 100644
--- a/testcases/kernel/syscalls/accept/accept01.c
+++ b/testcases/kernel/syscalls/accept/accept01.c
@@ -26,7 +26,6 @@
 struct sockaddr_in sin0, sin1, fsin1;
 
 int invalid_socketfd = 400; /* anything that is not an open file */
-int devnull_fd;
 int socket_fd;
 int udp_fd;
 
@@ -45,10 +44,6 @@ static struct test_case {
 		(struct sockaddr *)&fsin1, sizeof(fsin1), EBADF,
 		"bad file descriptor"
 	},
-	{
-		PF_INET, SOCK_STREAM, 0, &devnull_fd, (struct sockaddr *)&fsin1,
-		sizeof(fsin1), ENOTSOCK, "fd is not socket"
-	},
 	{
 		PF_INET, SOCK_STREAM, 0, &socket_fd, (struct sockaddr *)3,
 		sizeof(fsin1), EINVAL, "invalid socket buffer"
@@ -73,8 +68,6 @@ static void test_setup(void)
 	sin0.sin_port = 0;
 	sin0.sin_addr.s_addr = INADDR_ANY;
 
-	devnull_fd = SAFE_OPEN("/dev/null", O_WRONLY);
-
 	socket_fd = SAFE_SOCKET(PF_INET, SOCK_STREAM, 0);
 	SAFE_BIND(socket_fd, (struct sockaddr *)&sin0, sizeof(sin0));
 
@@ -88,7 +81,6 @@ static void test_setup(void)
 
 static void test_cleanup(void)
 {
-	SAFE_CLOSE(devnull_fd);
 	SAFE_CLOSE(socket_fd);
 	SAFE_CLOSE(udp_fd);
 }
diff --git a/testcases/kernel/syscalls/accept/accept03.c b/testcases/kernel/syscalls/accept/accept03.c
new file mode 100644
index 000000000..6bced33b6
--- /dev/null
+++ b/testcases/kernel/syscalls/accept/accept03.c
@@ -0,0 +1,46 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+/*
+ * Copyright (C) 2023 Cyril Hrubis <chrubis@suse.cz>
+ */
+
+/*\
+ * [Description]
+ *
+ * Verify that accept() returns ENOTSOCK for non-socket file descriptors.
+ */
+
+#include <sys/socket.h>
+#include <netinet/in.h>
+
+#include "tst_test.h"
+
+void check_accept(struct tst_fd *fd)
+{
+	struct sockaddr_in addr = {
+		.sin_family = AF_INET,
+		.sin_port = 0,
+		.sin_addr = {.s_addr = INADDR_ANY},
+	};
+	socklen_t size = sizeof(addr);
+
+	switch (fd->type) {
+	case TST_FD_UNIX_SOCK:
+	case TST_FD_INET_SOCK:
+		return;
+	default:
+		break;
+	}
+
+	TST_EXP_FAIL2(accept(fd->fd, (void*)&addr, &size),
+		ENOTSOCK, "accept() on %s", tst_fd_desc(fd));
+}
+
+static void verify_accept(void)
+{
+	tst_fd_iterate(check_accept);
+}
+
+static struct tst_test test = {
+	.test_all = verify_accept,
+};
-- 
2.41.0

