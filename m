Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19F0A611AC
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Jul 2019 17:00:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbfGFPAz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 6 Jul 2019 11:00:55 -0400
Received: from mx1.mailbox.org ([80.241.60.212]:43204 "EHLO mx1.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726607AbfGFPAy (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 6 Jul 2019 11:00:54 -0400
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:105:465:1:1:0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx1.mailbox.org (Postfix) with ESMTPS id 5557250266;
        Sat,  6 Jul 2019 17:00:50 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by hefe.heinlein-support.de (hefe.heinlein-support.de [91.198.250.172]) (amavisd-new, port 10030)
        with ESMTP id AhUDKWrxSzUZ; Sat,  6 Jul 2019 17:00:43 +0200 (CEST)
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Arnd Bergmann <arnd@arndb.de>,
        David Howells <dhowells@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     Aleksa Sarai <cyphar@cyphar.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Andy Lutomirski <luto@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>,
        Christian Brauner <christian@brauner.io>,
        Tycho Andersen <tycho@tycho.ws>,
        David Drysdale <drysdale@google.com>,
        Chanho Min <chanho.min@lge.com>,
        Oleg Nesterov <oleg@redhat.com>, Aleksa Sarai <asarai@suse.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        containers@lists.linux-foundation.org, linux-alpha@vger.kernel.org,
        linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, sparclinux@vger.kernel.org
Subject: [PATCH v9 09/10] kselftest: save-and-restore errno to allow for %m formatting
Date:   Sun,  7 Jul 2019 00:57:36 +1000
Message-Id: <20190706145737.5299-10-cyphar@cyphar.com>
In-Reply-To: <20190706145737.5299-1-cyphar@cyphar.com>
References: <20190706145737.5299-1-cyphar@cyphar.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Previously, using "%m" in a ksft_* format string can result in strange
output because the errno value wasn't saved before calling other libc
functions. The solution is to simply save and restore the errno before
we format the user-supplied format string.

Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
---
 tools/testing/selftests/kselftest.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/tools/testing/selftests/kselftest.h b/tools/testing/selftests/kselftest.h
index ec15c4f6af55..0ac49d91a260 100644
--- a/tools/testing/selftests/kselftest.h
+++ b/tools/testing/selftests/kselftest.h
@@ -10,6 +10,7 @@
 #ifndef __KSELFTEST_H
 #define __KSELFTEST_H
 
+#include <errno.h>
 #include <stdlib.h>
 #include <unistd.h>
 #include <stdarg.h>
@@ -81,58 +82,68 @@ static inline void ksft_print_cnts(void)
 
 static inline void ksft_print_msg(const char *msg, ...)
 {
+	int saved_errno = errno;
 	va_list args;
 
 	va_start(args, msg);
 	printf("# ");
+	errno = saved_errno;
 	vprintf(msg, args);
 	va_end(args);
 }
 
 static inline void ksft_test_result_pass(const char *msg, ...)
 {
+	int saved_errno = errno;
 	va_list args;
 
 	ksft_cnt.ksft_pass++;
 
 	va_start(args, msg);
 	printf("ok %d ", ksft_test_num());
+	errno = saved_errno;
 	vprintf(msg, args);
 	va_end(args);
 }
 
 static inline void ksft_test_result_fail(const char *msg, ...)
 {
+	int saved_errno = errno;
 	va_list args;
 
 	ksft_cnt.ksft_fail++;
 
 	va_start(args, msg);
 	printf("not ok %d ", ksft_test_num());
+	errno = saved_errno;
 	vprintf(msg, args);
 	va_end(args);
 }
 
 static inline void ksft_test_result_skip(const char *msg, ...)
 {
+	int saved_errno = errno;
 	va_list args;
 
 	ksft_cnt.ksft_xskip++;
 
 	va_start(args, msg);
 	printf("not ok %d # SKIP ", ksft_test_num());
+	errno = saved_errno;
 	vprintf(msg, args);
 	va_end(args);
 }
 
 static inline void ksft_test_result_error(const char *msg, ...)
 {
+	int saved_errno = errno;
 	va_list args;
 
 	ksft_cnt.ksft_error++;
 
 	va_start(args, msg);
 	printf("not ok %d # error ", ksft_test_num());
+	errno = saved_errno;
 	vprintf(msg, args);
 	va_end(args);
 }
@@ -152,10 +163,12 @@ static inline int ksft_exit_fail(void)
 
 static inline int ksft_exit_fail_msg(const char *msg, ...)
 {
+	int saved_errno = errno;
 	va_list args;
 
 	va_start(args, msg);
 	printf("Bail out! ");
+	errno = saved_errno;
 	vprintf(msg, args);
 	va_end(args);
 
@@ -178,10 +191,12 @@ static inline int ksft_exit_xpass(void)
 static inline int ksft_exit_skip(const char *msg, ...)
 {
 	if (msg) {
+		int saved_errno = errno;
 		va_list args;
 
 		va_start(args, msg);
 		printf("not ok %d # SKIP ", 1 + ksft_test_num());
+		errno = saved_errno;
 		vprintf(msg, args);
 		va_end(args);
 	} else {
-- 
2.22.0

