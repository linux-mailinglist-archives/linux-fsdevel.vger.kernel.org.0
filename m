Return-Path: <linux-fsdevel+bounces-39566-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E31BFA15A9A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Jan 2025 01:48:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42F621889265
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Jan 2025 00:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A301210A3E;
	Sat, 18 Jan 2025 00:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k7sIyE9f"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6198C4A28;
	Sat, 18 Jan 2025 00:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737161294; cv=none; b=InbVVvlZ3y/fMr/9tMDpQe5g8UQJqa/eiu5tSwS+/Q0rbWs+jYieH9LucgCIdKdMLsRj8cbAzV85qxl1LAU7qo/FEkcME81qtnpMYaK53kzRfo3Y7m0zgOJHBq+P6BU5FUqP1d4zj0K5mdtGx88QDGHRpyYmE0SGfHob2xrZlic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737161294; c=relaxed/simple;
	bh=cVs5HdLqrVfgrTTstmHEYNeQhksZsUTcDvsHgWAn2R8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vELihf8s4s9HQUABp9xUxVBUX1l4ksVzm+QpC3dXRSrmVAgB7DyQbdxfMRWoBmP2KU2ZTcSpLnYybfyWXX2AK12dfqO9EybyzAJ2LlCSXgn3lF98Hoi2ucuLjx5dJqbLnNpiQoa4y/pJgoyo+y8WrYjItWv6+ax1TrmGn5KX0tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k7sIyE9f; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e53ef7462b6so4466333276.3;
        Fri, 17 Jan 2025 16:48:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737161291; x=1737766091; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=03euZkMgladFKk/Tj75nvhR9d5dlD3L2rZrgtRkja/g=;
        b=k7sIyE9fxMj5YczPmEt1SNdBQzBAZgfIkD5bLDbJJgaA6N3/ZXpghfvlslooR8H/2j
         Kx63jd67JX96LJQyRTjuDToWXv5DXufuzO7T/fJuoN3AAZxwwZ4G7hm0Mzz10PCBZuUt
         u3V4meiw5RNrtNCrK5P8MVrelwp0twDMb+e3Lgg36Bqi7iozYMEHirdMAJR04jIrcdip
         eSbWW1HIU4/qB8w5GqsggM0uT9hEUDQk+mMV7eTfEz4OC4LIg1jYFJNyJzzKX069lVjE
         aY6b9HE5BLpG3P28FfrqI0eoei24eI758fsWtJuqHExUMQfztfKG7n/JDr1cK6IqTGat
         sX2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737161291; x=1737766091;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=03euZkMgladFKk/Tj75nvhR9d5dlD3L2rZrgtRkja/g=;
        b=fwVMi+G4ugFHpGi1Q/F8QZW3OhICpsrD9MIjdgN40CEYV3tlIbfxD7DVl8bEwxwsfo
         5vubGfdn1SoHOzd0OI8bFUjuTxh4dNE+OUoNSRLZakgIjQnTn4ur0Y4Va4H5KSx3BBfB
         bTxg7MvTBUOv7QKGLjVAZZa/JiqFwribT+G89kaTtI8FgK6DVWRJ7nazLtEzeepwDSt2
         hiz41JNZ2vim8IlrYKB3x3cW0XcNosJhFoeqze95GqDcHvKzoeq1h2Nswmn/vece4u12
         2FWiafBKou80DfrJWz6RE6vTtPwllLlbWa9P9RDfQJt4C3DuCuTfV62vIuSOwyKLo245
         t69Q==
X-Gm-Message-State: AOJu0YyP4h2ixm5/ZPZfLFP4REquZrS+bbsuNl85GJf5yYI7Th0JZNIn
	72x7iFn2J1C+SrepVnT83deFUG5YIeyBk9rtitpctLA8Uc/qyW8UfT1wig==
X-Gm-Gg: ASbGnctTr6g5w3kwMmV7j9U16T6IjfcMbQAixfGVR7gafk0w4e84fKhU3dzBQtIYmmU
	siZKBe9YA0RnuHD5SM6nW6OvCzOKyduN+5u6gCVb5B3wTfr6L6LB36BW0lZ+GOP5GMn+0ArKMn0
	gombeLtZoopP5ev2FDblxavhYyVxy6AwuvjCLdwIHKeE9HZjiCkXlN7rdhv3Q2GugDL/iF4erdc
	bPBeZXsR29sZD+tD0xlrHiISm/urI271unoPNJmvYkoK+Oa5Uxhy1M+aTaKaiEGSAp1
X-Google-Smtp-Source: AGHT+IGX+1+QSOl/DbKlaT7jqFc7VH06LfLiksDk6poqh9+HQqSwTYdx74FVlwwMdBg/v54+29sh+w==
X-Received: by 2002:a05:690c:700c:b0:6ef:641a:2a73 with SMTP id 00721157ae682-6f6eb662901mr44114167b3.9.1737161291099;
        Fri, 17 Jan 2025 16:48:11 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:71::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6f6e64745f6sm6367517b3.52.2025.01.17.16.48.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2025 16:48:10 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: fstests@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	bfoster@redhat.com,
	djwong@kernel.org,
	nirjhar@linux.ibm.com,
	zlang@redhat.com,
	kernel-team@meta.com
Subject: [PATCH v4 1/2] fsx: support reads/writes from buffers backed by hugepages
Date: Fri, 17 Jan 2025 16:47:58 -0800
Message-ID: <20250118004759.2772065-2-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250118004759.2772065-1-joannelkoong@gmail.com>
References: <20250118004759.2772065-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for reads/writes from buffers backed by hugepages.
This can be enabled through the '-h' flag. This flag should only be used
on systems where THP capabilities are enabled.

This is motivated by a recent bug that was due to faulty handling of
userspace buffers backed by hugepages. This patch is a mitigation
against problems like this in the future.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Reviewed-by: Brian Foster <bfoster@redhat.com>
---
 ltp/fsx.c | 165 +++++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 152 insertions(+), 13 deletions(-)

diff --git a/ltp/fsx.c b/ltp/fsx.c
index 41933354..1513755f 100644
--- a/ltp/fsx.c
+++ b/ltp/fsx.c
@@ -190,6 +190,16 @@ int	o_direct;			/* -Z */
 int	aio = 0;
 int	uring = 0;
 int	mark_nr = 0;
+int	hugepages = 0;                  /* -h flag */
+
+/* Stores info needed to periodically collapse hugepages */
+struct hugepages_collapse_info {
+	void *orig_good_buf;
+	long good_buf_size;
+	void *orig_temp_buf;
+	long temp_buf_size;
+};
+struct hugepages_collapse_info hugepages_info;
 
 int page_size;
 int page_mask;
@@ -2471,7 +2481,7 @@ void
 usage(void)
 {
 	fprintf(stdout, "usage: %s",
-		"fsx [-dfknqxyzBEFHIJKLORWXZ0]\n\
+		"fsx [-dfhknqxyzBEFHIJKLORWXZ0]\n\
 	   [-b opnum] [-c Prob] [-g filldata] [-i logdev] [-j logid]\n\
 	   [-l flen] [-m start:end] [-o oplen] [-p progressinterval]\n\
 	   [-r readbdy] [-s style] [-t truncbdy] [-w writebdy]\n\
@@ -2483,8 +2493,11 @@ usage(void)
 	-d: debug output for all operations\n\
 	-e: pollute post-eof on size changes (default 0)\n\
 	-f: flush and invalidate cache after I/O\n\
-	-g X: write character X instead of random generated data\n\
-	-i logdev: do integrity testing, logdev is the dm log writes device\n\
+	-g X: write character X instead of random generated data\n"
+#ifdef MADV_COLLAPSE
+"	-h hugepages: use buffers backed by hugepages for reads/writes\n"
+#endif
+"	-i logdev: do integrity testing, logdev is the dm log writes device\n\
 	-j logid: prefix debug log messsages with this id\n\
 	-k: do not truncate existing file and use its size as upper bound on file size\n\
 	-l flen: the upper bound on file size (default 262144)\n\
@@ -2833,11 +2846,40 @@ __test_fallocate(int mode, const char *mode_str)
 #endif
 }
 
+/*
+ * Reclaim may break up hugepages, so do a best-effort collapse every once in
+ * a while.
+ */
+static void
+collapse_hugepages(void)
+{
+#ifdef MADV_COLLAPSE
+	int interval = 1 << 14; /* 16k */
+	int ret;
+
+	if (numops && (numops & (interval - 1)) == 0) {
+		ret = madvise(hugepages_info.orig_good_buf,
+			      hugepages_info.good_buf_size, MADV_COLLAPSE);
+		if (ret)
+			prt("collapsing hugepages for good_buf failed (numops=%llu): %s\n",
+			     numops, strerror(errno));
+		ret = madvise(hugepages_info.orig_temp_buf,
+			      hugepages_info.temp_buf_size, MADV_COLLAPSE);
+		if (ret)
+			prt("collapsing hugepages for temp_buf failed (numops=%llu): %s\n",
+			     numops, strerror(errno));
+	}
+#endif
+}
+
 bool
 keep_running(void)
 {
 	int ret;
 
+	if (hugepages)
+	        collapse_hugepages();
+
 	if (deadline.tv_nsec) {
 		struct timespec now;
 
@@ -2856,6 +2898,103 @@ keep_running(void)
 	return numops-- != 0;
 }
 
+static long
+get_hugepage_size(void)
+{
+	const char str[] = "Hugepagesize:";
+	size_t str_len =  sizeof(str) - 1;
+	unsigned int hugepage_size = 0;
+	char buffer[64];
+	FILE *file;
+
+	file = fopen("/proc/meminfo", "r");
+	if (!file) {
+		prterr("get_hugepage_size: fopen /proc/meminfo");
+		return -1;
+	}
+	while (fgets(buffer, sizeof(buffer), file)) {
+		if (strncmp(buffer, str, str_len) == 0) {
+			sscanf(buffer + str_len, "%u", &hugepage_size);
+			break;
+		}
+	}
+	fclose(file);
+	if (!hugepage_size) {
+		prterr("get_hugepage_size: failed to find "
+			"hugepage size in /proc/meminfo\n");
+		return -1;
+	}
+
+	/* convert from KiB to bytes */
+	return hugepage_size << 10;
+}
+
+static void *
+init_hugepages_buf(unsigned len, int hugepage_size, int alignment, long *buf_size)
+{
+	void *buf = NULL;
+#ifdef MADV_COLLAPSE
+	int ret;
+	long size = roundup(len, hugepage_size) + alignment;
+
+	ret = posix_memalign(&buf, hugepage_size, size);
+	if (ret) {
+		prterr("posix_memalign for buf");
+		return NULL;
+	}
+	memset(buf, '\0', size);
+	ret = madvise(buf, size, MADV_COLLAPSE);
+	if (ret) {
+		prterr("madvise collapse for buf");
+		free(buf);
+		return NULL;
+	}
+
+	*buf_size = size;
+#endif
+	return buf;
+}
+
+static void
+init_buffers(void)
+{
+	int i;
+
+	original_buf = (char *) malloc(maxfilelen);
+	for (i = 0; i < maxfilelen; i++)
+		original_buf[i] = random() % 256;
+	if (hugepages) {
+		long hugepage_size = get_hugepage_size();
+		if (hugepage_size == -1) {
+			prterr("get_hugepage_size()");
+			exit(102);
+		}
+		good_buf = init_hugepages_buf(maxfilelen, hugepage_size, writebdy,
+					      &hugepages_info.good_buf_size);
+		if (!good_buf) {
+			prterr("init_hugepages_buf failed for good_buf");
+			exit(103);
+		}
+		hugepages_info.orig_good_buf = good_buf;
+
+		temp_buf = init_hugepages_buf(maxoplen, hugepage_size, readbdy,
+					      &hugepages_info.temp_buf_size);
+		if (!temp_buf) {
+			prterr("init_hugepages_buf failed for temp_buf");
+			exit(103);
+		}
+		hugepages_info.orig_temp_buf = temp_buf;
+	} else {
+		unsigned long good_buf_len = maxfilelen + writebdy;
+		unsigned long temp_buf_len = maxoplen + readbdy;
+
+		good_buf = calloc(1, good_buf_len);
+		temp_buf = calloc(1, temp_buf_len);
+	}
+	good_buf = round_ptr_up(good_buf, writebdy, 0);
+	temp_buf = round_ptr_up(temp_buf, readbdy, 0);
+}
+
 static struct option longopts[] = {
 	{"replay-ops", required_argument, 0, 256},
 	{"record-ops", optional_argument, 0, 255},
@@ -2883,7 +3022,7 @@ main(int argc, char **argv)
 	setvbuf(stdout, (char *)0, _IOLBF, 0); /* line buffered stdout */
 
 	while ((ch = getopt_long(argc, argv,
-				 "0b:c:de:fg:i:j:kl:m:no:p:qr:s:t:uw:xyABD:EFJKHzCILN:OP:RS:UWXZ",
+				 "0b:c:de:fg:hi:j:kl:m:no:p:qr:s:t:uw:xyABD:EFJKHzCILN:OP:RS:UWXZ",
 				 longopts, NULL)) != EOF)
 		switch (ch) {
 		case 'b':
@@ -2916,6 +3055,14 @@ main(int argc, char **argv)
 		case 'g':
 			filldata = *optarg;
 			break;
+		case 'h':
+#ifndef MADV_COLLAPSE
+				fprintf(stderr, "MADV_COLLAPSE not supported. "
+					"Can't support -h\n");
+				exit(86);
+#endif
+			hugepages = 1;
+			break;
 		case 'i':
 			integrity = 1;
 			logdev = strdup(optarg);
@@ -3229,15 +3376,7 @@ main(int argc, char **argv)
 			exit(95);
 		}
 	}
-	original_buf = (char *) malloc(maxfilelen);
-	for (i = 0; i < maxfilelen; i++)
-		original_buf[i] = random() % 256;
-	good_buf = (char *) malloc(maxfilelen + writebdy);
-	good_buf = round_ptr_up(good_buf, writebdy, 0);
-	memset(good_buf, '\0', maxfilelen);
-	temp_buf = (char *) malloc(maxoplen + readbdy);
-	temp_buf = round_ptr_up(temp_buf, readbdy, 0);
-	memset(temp_buf, '\0', maxoplen);
+	init_buffers();
 	if (lite) {	/* zero entire existing file */
 		ssize_t written;
 
-- 
2.47.1


