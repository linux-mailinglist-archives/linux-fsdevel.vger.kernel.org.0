Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4E6073A695
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jun 2023 18:54:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231532AbjFVQxi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Jun 2023 12:53:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231464AbjFVQxC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Jun 2023 12:53:02 -0400
Received: from forward103b.mail.yandex.net (forward103b.mail.yandex.net [178.154.239.150])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7448010A;
        Thu, 22 Jun 2023 09:53:00 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-39.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-39.sas.yp-c.yandex.net [IPv6:2a02:6b8:c08:2087:0:640:7bf5:0])
        by forward103b.mail.yandex.net (Yandex) with ESMTP id EBB2F60042;
        Thu, 22 Jun 2023 19:52:55 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-39.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id kqJAlpLDeKo0-WCEAxOU1;
        Thu, 22 Jun 2023 19:52:55 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1687452775;
        bh=XIPYaudU5FYSMvmqvzeAFOUYfxsNw/JihAyfWPOa0Mk=;
        h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
        b=dtbxP3VuBYFTACo2/NNg8BgriPOGvD8mlH4JRSK8G1b7hIUI2xHHASVC+2UrivFQH
         RU+faJUezXDo45eBlcpYBRhWQObfeN0hHcuitQhLe1EGuwSWX/48SdlXPNlmTjnoZo
         AVQ0iOAdwGHtg1KM8ZXksCYIAD4O0SoMLLxxwP+E=
Authentication-Results: mail-nwsmtp-smtp-production-main-39.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From:   Stas Sergeev <stsp2@yandex.ru>
To:     linux-kernel@vger.kernel.org
Cc:     Stas Sergeev <stsp2@yandex.ru>, Jeff Layton <jlayton@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org, linux-api@vger.kernel.org
Subject: [PATCH 2/2] selftests: add OFD lock tests
Date:   Thu, 22 Jun 2023 21:52:24 +0500
Message-Id: <20230622165225.2772076-3-stsp2@yandex.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230622165225.2772076-1-stsp2@yandex.ru>
References: <20230622165225.2772076-1-stsp2@yandex.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Test the basic locking stuff on 2 fds: multiple read locks,
conflicts between read and write locks, use of len==0 for queries.
Also tests for F_UNLCK F_OFD_GETLK extension.

Signed-off-by: Stas Sergeev <stsp2@yandex.ru>

CC: Jeff Layton <jlayton@kernel.org>
CC: Chuck Lever <chuck.lever@oracle.com>
CC: Alexander Viro <viro@zeniv.linux.org.uk>
CC: Christian Brauner <brauner@kernel.org>
CC: linux-fsdevel@vger.kernel.org
CC: linux-kernel@vger.kernel.org
CC: Shuah Khan <shuah@kernel.org>
CC: linux-kselftest@vger.kernel.org
CC: linux-api@vger.kernel.org

---
 tools/testing/selftests/filelock/Makefile   |   5 +
 tools/testing/selftests/filelock/ofdlocks.c | 132 ++++++++++++++++++++
 2 files changed, 137 insertions(+)
 create mode 100644 tools/testing/selftests/filelock/Makefile
 create mode 100644 tools/testing/selftests/filelock/ofdlocks.c

diff --git a/tools/testing/selftests/filelock/Makefile b/tools/testing/selftests/filelock/Makefile
new file mode 100644
index 000000000000..478e82f8b464
--- /dev/null
+++ b/tools/testing/selftests/filelock/Makefile
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0
+
+TEST_GEN_PROGS := ofdlocks
+
+include ../lib.mk
diff --git a/tools/testing/selftests/filelock/ofdlocks.c b/tools/testing/selftests/filelock/ofdlocks.c
new file mode 100644
index 000000000000..1ccb2b9b5ead
--- /dev/null
+++ b/tools/testing/selftests/filelock/ofdlocks.c
@@ -0,0 +1,132 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#define _GNU_SOURCE
+#include <fcntl.h>
+#include <assert.h>
+#include <stdio.h>
+#include <unistd.h>
+#include <string.h>
+#include "../kselftest.h"
+
+static int lock_set(int fd, struct flock *fl)
+{
+	int ret;
+
+	fl->l_pid = 0;		// needed for OFD locks
+	fl->l_whence = SEEK_SET;
+	ret = fcntl(fd, F_OFD_SETLK, fl);
+	if (ret)
+		perror("fcntl()");
+	return ret;
+}
+
+static int lock_get(int fd, struct flock *fl)
+{
+	int ret;
+
+	fl->l_pid = 0;		// needed for OFD locks
+	fl->l_whence = SEEK_SET;
+	ret = fcntl(fd, F_OFD_GETLK, fl);
+	if (ret)
+		perror("fcntl()");
+	return ret;
+}
+
+int main(void)
+{
+	int rc;
+	struct flock fl, fl2;
+	int fd = open("/tmp/aa", O_RDWR | O_CREAT | O_EXCL, 0600);
+	int fd2 = open("/tmp/aa", O_RDONLY);
+
+	unlink("aa");
+	assert(fd != -1);
+	assert(fd2 != -1);
+	ksft_print_msg("[INFO] opened fds %i %i\n", fd, fd2);
+
+	/* Set some read lock */
+	fl.l_type = F_RDLCK;
+	fl.l_start = 5;
+	fl.l_len = 3;
+	rc = lock_set(fd, &fl);
+	if (rc == 0) {
+		ksft_print_msg
+		    ("[SUCCESS] set OFD read lock on first fd\n");
+	} else {
+		ksft_print_msg("[FAIL] to set OFD read lock on first fd\n");
+		return -1;
+	}
+	/* Make sure read locks do not conflict on different fds. */
+	fl.l_type = F_RDLCK;
+	fl.l_start = 5;
+	fl.l_len = 1;
+	rc = lock_get(fd2, &fl);
+	if (rc != 0)
+		return -1;
+	if (fl.l_type != F_UNLCK) {
+		ksft_print_msg("[FAIL] read locks conflicted\n");
+		return -1;
+	}
+	/* Make sure read/write locks do conflict on different fds. */
+	fl.l_type = F_WRLCK;
+	fl.l_start = 5;
+	fl.l_len = 1;
+	rc = lock_get(fd2, &fl);
+	if (rc != 0)
+		return -1;
+	if (fl.l_type != F_UNLCK) {
+		ksft_print_msg
+		    ("[SUCCESS] read and write locks conflicted\n");
+	} else {
+		ksft_print_msg
+		    ("[SUCCESS] read and write locks not conflicted\n");
+		return -1;
+	}
+	/* Get info about the lock on first fd. */
+	fl.l_type = F_UNLCK;
+	fl.l_start = 5;
+	fl.l_len = 1;
+	rc = lock_get(fd, &fl);
+	if (rc != 0) {
+		ksft_print_msg
+		    ("[FAIL] F_OFD_GETLK with F_UNLCK not supported\n");
+		return -1;
+	}
+	if (fl.l_type != F_UNLCK) {
+		ksft_print_msg
+		    ("[SUCCESS] F_UNLCK test returns: locked, type %i pid %i len %zi\n",
+		     fl.l_type, fl.l_pid, fl.l_len);
+	} else {
+		ksft_print_msg
+		    ("[FAIL] F_OFD_GETLK with F_UNLCK did not return lock info\n");
+		return -1;
+	}
+	/* Try the same but by locking everything by len==0. */
+	fl2.l_type = F_UNLCK;
+	fl2.l_start = 0;
+	fl2.l_len = 0;
+	rc = lock_get(fd, &fl2);
+	if (rc != 0) {
+		ksft_print_msg
+		    ("[FAIL] F_OFD_GETLK with F_UNLCK not supported\n");
+		return -1;
+	}
+	if (memcmp(&fl, &fl2, sizeof(fl))) {
+		ksft_print_msg
+		    ("[FAIL] F_UNLCK test returns: locked, type %i pid %i len %zi\n",
+		     fl.l_type, fl.l_pid, fl.l_len);
+		return -1;
+	}
+	ksft_print_msg("[SUCCESS] F_UNLCK with len==0 returned the same\n");
+	/* Get info about the lock on second fd - no locks on it. */
+	fl.l_type = F_UNLCK;
+	fl.l_start = 0;
+	fl.l_len = 0;
+	lock_get(fd2, &fl);
+	if (fl.l_type != F_UNLCK) {
+		ksft_print_msg
+		    ("[FAIL] F_OFD_GETLK with F_UNLCK return lock info from another fd\n");
+		return -1;
+	}
+	return 0;
+}
-- 
2.39.2

