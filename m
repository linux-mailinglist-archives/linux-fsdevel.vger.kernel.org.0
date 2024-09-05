Return-Path: <linux-fsdevel+bounces-28751-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AB5A96DCF3
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 17:00:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4B3F28A339
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 15:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FFA41A08B6;
	Thu,  5 Sep 2024 14:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="L+9O7ijg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD74D19D081;
	Thu,  5 Sep 2024 14:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725548287; cv=none; b=haddlrcmk9GLZu6RUvpvAuqcshcsAt5PKjq6gE5HEOZXCwwRJdl1UGxDH3SzxvWz2sslNzOMDyXik6EkkmVGbghY77x5hgnDRfIeEU7+Sae+wI2dkh7Nq0X41PNs7bo1IeGisTnfhKrmFBXB7XwHTMW5iXlN3Q0Cf51XutvBYIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725548287; c=relaxed/simple;
	bh=4XzvkTIhhT/HmkS5lBvB05Y6vkKNly+AlJMAP6Fz2PM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nUctvieBCrPIBFRp/iZtsq5cBqOYobvYbd2jZeGYB76sK6E+3nyHdKWLJDhhmzmOapbjqjYrRcmPRePkz/cVCihB+0CEGryP6y1GjFe15LZxU5DNGfE3t5+fMZ/Dwi80AzYpXce3tuc/2LES7E0oNlPLroNNOdgYTL4yi5D9AO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=L+9O7ijg; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4X02Xp3SHzz9shb;
	Thu,  5 Sep 2024 16:58:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1725548282;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ylY/xAKp0iag5FTcnJtAz27611evPoJzrroecSSdN4s=;
	b=L+9O7ijgI9hYdcMETysrohxKLIrnroE4u9IfYJogLeM30p+/z3uKXyPG92LWXajV4jS8P6
	v7fgiyKYu91gV42jzByrSgXigch9KV/pWdLJcI55MKlhl84j7AyZ9TePbKFDYohrx+gwh7
	RaWEFUE5wgyQMrru5Rlb1GNRj4kSCxVYEIH3fsO31RdPLO+p8n8GKoYpSB0L6A0WgSQ5ra
	zITRZ9gyP6r0oOJj4gUnZEVCmW3OfXxrZeTZ79W+pyATf1kwLpoXF1c3YbTPV2J34b1bmy
	KZuOD2JWwIz9wqUKwJrvkDMmxqfkVoNmUHoQY8hw2IWrFeJULyiNvev0r909Xw==
From: Aleksa Sarai <cyphar@cyphar.com>
Date: Fri, 06 Sep 2024 00:56:38 +1000
Subject: [PATCH RFC v2 06/10] selftests: openat2: add CHECK_FIELDS
 selftests
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240906-extensible-structs-check_fields-v2-6-0f46d2de9bad@cyphar.com>
References: <20240906-extensible-structs-check_fields-v2-0-0f46d2de9bad@cyphar.com>
In-Reply-To: <20240906-extensible-structs-check_fields-v2-0-0f46d2de9bad@cyphar.com>
To: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
 Juri Lelli <juri.lelli@redhat.com>, 
 Vincent Guittot <vincent.guittot@linaro.org>, 
 Dietmar Eggemann <dietmar.eggemann@arm.com>, 
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, 
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Arnd Bergmann <arnd@arndb.de>, Shuah Khan <shuah@kernel.org>
Cc: Kees Cook <kees@kernel.org>, Florian Weimer <fweimer@redhat.com>, 
 Arnd Bergmann <arnd@arndb.de>, Mark Rutland <mark.rutland@arm.com>, 
 linux-kernel@vger.kernel.org, linux-api@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Aleksa Sarai <cyphar@cyphar.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=7278; i=cyphar@cyphar.com;
 h=from:subject:message-id; bh=4XzvkTIhhT/HmkS5lBvB05Y6vkKNly+AlJMAP6Fz2PM=;
 b=owGbwMvMwCWmMf3Xpe0vXfIZT6slMaTdPLalojD5eNv9F9xp8dsT/L81R28xiBddKXigrn2+/
 8cmBdFZHaUsDGJcDLJiiizb/DxDN81ffCX500o2mDmsTCBDGLg4BWAiHAqMDBPuLHBWTwx8wyLu
 s7DknMXMI/Pfe+dt1Zqgq/u6IO7PyXsM/532l/IbpN3mcLExelp95mfE19WXPCa48G3n/JHCtWF
 PGjsA
X-Developer-Key: i=cyphar@cyphar.com; a=openpgp;
 fpr=C9C370B246B09F6DBCFC744C34401015D1D2D386
X-Rspamd-Queue-Id: 4X02Xp3SHzz9shb

Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
---
 tools/testing/selftests/openat2/Makefile       |   2 +
 tools/testing/selftests/openat2/openat2_test.c | 161 ++++++++++++++++++++++++-
 2 files changed, 161 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/openat2/Makefile b/tools/testing/selftests/openat2/Makefile
index 185dc76ebb5f..239a7fd0cb35 100644
--- a/tools/testing/selftests/openat2/Makefile
+++ b/tools/testing/selftests/openat2/Makefile
@@ -12,6 +12,8 @@ ifeq ($(LLVM),)
 endif
 
 LOCAL_HDRS += helpers.h
+# Needed for EEXTSYS_NOOP definition.
+CFLAGS += $(TOOLS_INCLUDES)
 
 include ../lib.mk
 
diff --git a/tools/testing/selftests/openat2/openat2_test.c b/tools/testing/selftests/openat2/openat2_test.c
index 4ca175a16ad6..9d3382bdfce9 100644
--- a/tools/testing/selftests/openat2/openat2_test.c
+++ b/tools/testing/selftests/openat2/openat2_test.c
@@ -1,11 +1,12 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Author: Aleksa Sarai <cyphar@cyphar.com>
- * Copyright (C) 2018-2019 SUSE LLC.
+ * Copyright (C) 2018-2024 SUSE LLC.
  */
 
 #define _GNU_SOURCE
 #define __SANE_USERSPACE_TYPES__ // Use ll64
+#include <errno.h>
 #include <fcntl.h>
 #include <sched.h>
 #include <sys/stat.h>
@@ -29,6 +30,10 @@
 #define	O_LARGEFILE 0x8000
 #endif
 
+#ifndef CHECK_FIELDS
+#define CHECK_FIELDS (1ULL << 63)
+#endif
+
 struct open_how_ext {
 	struct open_how inner;
 	uint32_t extra1;
@@ -45,6 +50,152 @@ struct struct_test {
 	int err;
 };
 
+static bool check(bool *failed, bool pred)
+{
+	*failed |= pred;
+	return pred;
+}
+
+#define NUM_OPENAT2_CHECK_FIELDS_BAD_TESTS 2
+
+static void test_openat2_check_fields_bad(const char *name, size_t struct_size)
+{
+	int fd, expected_err;
+	bool failed = false;
+	struct open_how how = {};
+	void (*resultfn)(const char *msg, ...) = ksft_test_result_pass;
+
+	if (struct_size < sizeof(struct open_how))
+		expected_err = -EINVAL;
+	if (struct_size > 4096)
+		expected_err = -E2BIG;
+
+	if (!openat2_supported) {
+		ksft_print_msg("openat2(2) unsupported\n");
+		resultfn = ksft_test_result_skip;
+		goto skip;
+	}
+
+	fd = raw_openat2(AT_FDCWD, "", &how, CHECK_FIELDS | struct_size);
+	if (check(&failed, fd != expected_err))
+		ksft_print_msg("openat2(CHECK_FIELDS) returned wrong error code: %d (%s) != %d (%s)\n",
+			       fd, strerror(-fd),
+			       expected_err, strerror(-expected_err));
+
+	if (fd >= 0)
+		close(fd);
+
+	if (failed)
+		resultfn = ksft_test_result_fail;
+
+skip:
+	resultfn("openat2(CHECK_FIELDS) with %s returns %d (%s)\n", name,
+		 expected_err, strerror(-expected_err));
+	fflush(stdout);
+}
+
+#define NUM_OPENAT2_CHECK_FIELDS_TESTS 1
+#define NUM_OPENAT2_CHECK_FIELDS_VARIATIONS 13
+
+static void test_openat2_check_fields(void)
+{
+	int misalignments[] = { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 11, 17, 87 };
+
+	for (int i = 0; i < ARRAY_LEN(misalignments); i++) {
+		int fd, misalign = misalignments[i];
+		bool failed = false;
+		char *fdpath = NULL;
+		void (*resultfn)(const char *msg, ...) = ksft_test_result_pass;
+
+		struct open_how_ext how_ext = {}, *how_copy = &how_ext;
+		void *copy = NULL;
+
+		if (!openat2_supported) {
+			ksft_print_msg("openat2(2) unsupported\n");
+			resultfn = ksft_test_result_skip;
+			goto skip;
+		}
+
+		if (misalign) {
+			/*
+			 * Explicitly misalign the structure copying it with
+			 * the given (mis)alignment offset. The other data is
+			 * set to zero and we verify this afterwards to make
+			 * sure CHECK_FIELDS doesn't write outside the buffer.
+			 */
+			copy = malloc(misalign*2 + sizeof(how_ext));
+			how_copy = copy + misalign;
+			memset(copy, 0x00, misalign*2 + sizeof(how_ext));
+			memcpy(how_copy, &how_ext, sizeof(how_ext));
+		}
+
+		fd = raw_openat2(AT_FDCWD, ".", how_copy, CHECK_FIELDS | sizeof(*how_copy));
+		if (check(&failed, (fd != -EEXTSYS_NOOP)))
+			ksft_print_msg("openat2(CHECK_FIELDS) returned wrong error code: %d (%s) != %d\n",
+				       fd, strerror(-fd), -EEXTSYS_NOOP);
+		if (fd >= 0) {
+			fdpath = fdreadlink(fd);
+			close(fd);
+		}
+
+		if (failed) {
+			ksft_print_msg("openat2(CHECK_FIELDS) unexpectedly returned ");
+			if (fdpath)
+				ksft_print_msg("%d['%s']\n", fd, fdpath);
+			else
+				ksft_print_msg("%d (%s)\n", fd, strerror(-fd));
+		}
+
+		if (check(&failed, !(how_copy->inner.flags & O_PATH)))
+			ksft_print_msg("openat2(CHECK_FIELDS) returned flags is missing O_PATH (0x%.16x): 0x%.16llx\n",
+				       O_PATH, how_copy->inner.flags);
+
+		if (check(&failed, (how_copy->inner.mode != 07777)))
+			ksft_print_msg("openat2(CHECK_FIELDS) returned mode is invalid (0o%o): 0o%.4llo\n",
+				       07777, how_copy->inner.mode);
+
+		if (check(&failed, !(how_copy->inner.resolve & RESOLVE_IN_ROOT)))
+			ksft_print_msg("openat2(CHECK_FIELDS) returned resolve flags is missing RESOLVE_IN_ROOT (0x%.16x): 0x%.16llx\n",
+				       RESOLVE_IN_ROOT, how_copy->inner.resolve);
+
+		/* Verify that the buffer space outside the struct wasn't written to. */
+		if (check(&failed, how_copy->extra1 != 0))
+			ksft_print_msg("openat2(CHECK_FIELDS) touched a byte outside open_how (extra1): 0x%x\n",
+				       how_copy->extra1);
+		if (check(&failed, how_copy->extra2 != 0))
+			ksft_print_msg("openat2(CHECK_FIELDS) touched a byte outside open_how (extra2): 0x%x\n",
+				       how_copy->extra2);
+		if (check(&failed, how_copy->extra3 != 0))
+			ksft_print_msg("openat2(CHECK_FIELDS) touched a byte outside open_how (extra3): 0x%x\n",
+				       how_copy->extra3);
+
+		if (misalign) {
+			for (size_t i = 0; i < misalign; i++) {
+				char *p = copy + i;
+				if (check(&failed, *p != '\x00'))
+					ksft_print_msg("openat2(CHECK_FIELDS) touched a byte outside the size: buffer[%ld] = 0x%.2x\n",
+						       p - (char *) copy, *p);
+			}
+			for (size_t i = 0; i < misalign; i++) {
+				char *p = copy + misalign + sizeof(how_ext) + i;
+				if (check(&failed, *p != '\x00'))
+					ksft_print_msg("openat2(CHECK_FIELDS) touched a byte outside the size: buffer[%ld] = 0x%.2x\n",
+						       p - (char *) copy, *p);
+			}
+		}
+
+		if (failed)
+			resultfn = ksft_test_result_fail;
+
+skip:
+		resultfn("openat2(CHECK_FIELDS) [misalign=%d]\n", misalign);
+
+		free(copy);
+		free(fdpath);
+		fflush(stdout);
+	}
+}
+
 #define NUM_OPENAT2_STRUCT_TESTS 7
 #define NUM_OPENAT2_STRUCT_VARIATIONS 13
 
@@ -320,7 +471,9 @@ void test_openat2_flags(void)
 	}
 }
 
-#define NUM_TESTS (NUM_OPENAT2_STRUCT_VARIATIONS * NUM_OPENAT2_STRUCT_TESTS + \
+#define NUM_TESTS (NUM_OPENAT2_CHECK_FIELDS_TESTS * NUM_OPENAT2_CHECK_FIELDS_VARIATIONS + \
+		   NUM_OPENAT2_CHECK_FIELDS_BAD_TESTS + \
+		   NUM_OPENAT2_STRUCT_VARIATIONS * NUM_OPENAT2_STRUCT_TESTS + \
 		   NUM_OPENAT2_FLAG_TESTS)
 
 int main(int argc, char **argv)
@@ -328,6 +481,10 @@ int main(int argc, char **argv)
 	ksft_print_header();
 	ksft_set_plan(NUM_TESTS);
 
+	test_openat2_check_fields();
+	test_openat2_check_fields_bad("small struct (< v0)", 0);
+	test_openat2_check_fields_bad("large struct (> PAGE_SIZE)", 0xF000);
+
 	test_openat2_struct();
 	test_openat2_flags();
 

-- 
2.46.0


