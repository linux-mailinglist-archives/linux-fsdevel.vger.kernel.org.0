Return-Path: <linux-fsdevel+bounces-28208-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83EE696801B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2024 09:10:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDB322811DE
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2024 07:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6206187323;
	Mon,  2 Sep 2024 07:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="v5Ld5omY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B54E815C140;
	Mon,  2 Sep 2024 07:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725260887; cv=none; b=Ki/pIe8hssynDFF/h2VGiTuoV3tGZ/yVnFc+xMQL70jW73hwvPVqdXe8mpwAEGYvglaXlxoDFRuf36kZ75h9CQNext2Ooiy/H4fnUBwkiFLuu6hs2qBhmtSRDzYQduHc2AwAW+A98ooePu0MnMx89d9IVLou8d63Pcas3sCn+2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725260887; c=relaxed/simple;
	bh=eU7T6gTnHlMrWsrw9awh27JYBFeDxv7T93mWMUwilws=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pd9mgkrsdoj0p2/nBcu7URIToeBmApx373T8e9GdAPzfR7d78i8dVIslspjjkw/T85U2h3U1xKWhvLnKV+dW3am0Au8I152Lae9+nFJrGSV5GkNVxKoxesowFSwqwf6rSUzeWbDJQNdH5DMJu/QasmSG6pq6gIiBSFfwwCFY/W0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=v5Ld5omY; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4Wy0Ft3SQcz9td6;
	Mon,  2 Sep 2024 09:08:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1725260882;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FRErNsaR4Ah4rqWu5YTT9XyB0I4HFk2MH1pIMFZJXr8=;
	b=v5Ld5omYFbNGBX7IOWANoAY80GaF+nHU82N8IXUGQPnsAMijU0XXVtFXuv1d+L0ZGdu99q
	vT8TeN2ta5cs6+Ow82irfh6dA5mrPinnOhGoTKlCfA76Ktx8L/kp3XyDIyZi0Z06bkx8wQ
	zTC30KL27KPxc5f3x/SUHJukfUsQJ9VWXutLyhRO7y8rUajb1xOe9+fghL8OXB0+aW1FeA
	SbIYHhp2/ZVbn1V6kJMDBVlRK/WX5PFOzXdu7bYXhduB7Y5MaFzhWxSDFr4qdzEJMprLKU
	uLQl662B+RluV+ieti6+udTVPAv2Y16rg2rf8aNfkn7wfHLLNW0PVVgpNGZ3EQ==
From: Aleksa Sarai <cyphar@cyphar.com>
Date: Mon, 02 Sep 2024 17:06:29 +1000
Subject: [PATCH RFC 7/8] selftests: openat2: add CHECK_FIELDS selftests
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240902-extensible-structs-check_fields-v1-7-545e93ede2f2@cyphar.com>
References: <20240902-extensible-structs-check_fields-v1-0-545e93ede2f2@cyphar.com>
In-Reply-To: <20240902-extensible-structs-check_fields-v1-0-545e93ede2f2@cyphar.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5457; i=cyphar@cyphar.com;
 h=from:subject:message-id; bh=eU7T6gTnHlMrWsrw9awh27JYBFeDxv7T93mWMUwilws=;
 b=owGbwMvMwCWmMf3Xpe0vXfIZT6slMaRdTWFR+i2R/TFI+OW+PBWO3RcmOKTOEo4NlgzexlJhF
 BBfVh3VUcrCIMbFICumyLLNzzN00/zFV5I/rWSDmcPKBDKEgYtTACZSk8jIsGLjxAmm3vFnReP2
 aR2d8HJSw2+xA+umnDpw6NFxVZU8qXOMDOeueij++r302hKfAwXnroq9PC91T3vCUmutep51y/K
 d7HgA
X-Developer-Key: i=cyphar@cyphar.com; a=openpgp;
 fpr=C9C370B246B09F6DBCFC744C34401015D1D2D386

Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
---
 tools/testing/selftests/openat2/openat2_test.c | 122 ++++++++++++++++++++++++-
 1 file changed, 120 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/openat2/openat2_test.c b/tools/testing/selftests/openat2/openat2_test.c
index 4ca175a16ad6..8afb41d0958a 100644
--- a/tools/testing/selftests/openat2/openat2_test.c
+++ b/tools/testing/selftests/openat2/openat2_test.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Author: Aleksa Sarai <cyphar@cyphar.com>
- * Copyright (C) 2018-2019 SUSE LLC.
+ * Copyright (C) 2018-2024 SUSE LLC.
  */
 
 #define _GNU_SOURCE
@@ -29,6 +29,14 @@
 #define	O_LARGEFILE 0x8000
 #endif
 
+#ifndef CHECK_FIELDS
+#define CHECK_FIELDS (1ULL << 63)
+#endif
+
+#ifndef EEXTSYS_NOOP
+#define EEXTSYS_NOOP 134
+#endif
+
 struct open_how_ext {
 	struct open_how inner;
 	uint32_t extra1;
@@ -45,6 +53,114 @@ struct struct_test {
 	int err;
 };
 
+#define NUM_OPENAT2_CHECK_FIELDS_TESTS 1
+#define NUM_OPENAT2_CHECK_FIELDS_VARIATIONS 13
+
+static bool check(bool *failed, bool pred)
+{
+	*failed |= pred;
+	return pred;
+}
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
+			ksft_print_msg("openat2(CHECK_FIELDS) returned wrong error code: %d (%s)",
+				       fd, strerror(-fd));
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
 
@@ -320,7 +436,8 @@ void test_openat2_flags(void)
 	}
 }
 
-#define NUM_TESTS (NUM_OPENAT2_STRUCT_VARIATIONS * NUM_OPENAT2_STRUCT_TESTS + \
+#define NUM_TESTS (NUM_OPENAT2_CHECK_FIELDS_TESTS * NUM_OPENAT2_CHECK_FIELDS_VARIATIONS + \
+		   NUM_OPENAT2_STRUCT_VARIATIONS * NUM_OPENAT2_STRUCT_TESTS + \
 		   NUM_OPENAT2_FLAG_TESTS)
 
 int main(int argc, char **argv)
@@ -328,6 +445,7 @@ int main(int argc, char **argv)
 	ksft_print_header();
 	ksft_set_plan(NUM_TESTS);
 
+	test_openat2_check_fields();
 	test_openat2_struct();
 	test_openat2_flags();
 

-- 
2.46.0


