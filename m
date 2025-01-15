Return-Path: <linux-fsdevel+bounces-39321-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DFDFA12AF9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 19:34:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE5763A7734
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 18:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FB0D1DC9A5;
	Wed, 15 Jan 2025 18:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c4st7aAR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E331E1D6DD8;
	Wed, 15 Jan 2025 18:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736965881; cv=none; b=I1sgNVnXOxxXfqTQfRQG2nLwrKo2tkOOyNziR30eA5NUNCGnMWO6L75XYjAHCjOM2KQSdG5YXO6YRREIpODCarPiG6MXSe/UDsXvj0ScIsggH3JH7ss5McQ6PNhk77mX0UgjdEc0xQ+keHlKIvkHc7fCUvE1pYlit54CwqeQEXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736965881; c=relaxed/simple;
	bh=QfB1tB8tnXFFt+T5DOegzM3Le4DaELEP1GBvlI3X4kc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rEbIgQiFDO6EFUhc0LJZe3wa01PnnPXTjMYROASj6q5c0yDaNXK+kD/qh6sDO966jkMeyGXNVYX8jDluq/iuGXLbLIspPYUjFmL26blAw9XLITdEJLQ3WvAYhZBT5D7BZn9TmI/v1Tssf5WozKTBUL2pFRxDE4tZGinY7ed5uN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c4st7aAR; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e549b0f8d57so101780276.3;
        Wed, 15 Jan 2025 10:31:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736965878; x=1737570678; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xzgg4JLl9lj74VhBcUq5J0sptKZ52PDkEwIWQ/oqMnA=;
        b=c4st7aARqz0wgxVPkTGQN90wq5p2/CFSAfsTEZ9rmBq4h+6KpUUEubOWVSlpkaNaLt
         dds5ZVaaVJAKLf+ueNaK0c4XssR1WJTxTBQzHYs9t5jVWFjBX0D8HayDFmap2ATpaclt
         UTt3XWR6yXhuynmh3ECMJanlpVYkPkxbCYIhV4ad8O+Q1L2ORTDgcctraHxYgTHtV0lu
         dVxp124eKZ/0lc9OGGFTHO2rY+wdfR05k7BQ10if2Nmk9TI8MNDRaAxnTmIkbKJuN1Ha
         dU9DrNIiSPQP3WSgFTiaER17aJtmlWU4krEvEfr0msOq+y6m8Ly4tk4lJLVAjX/PEGMU
         zjwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736965878; x=1737570678;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xzgg4JLl9lj74VhBcUq5J0sptKZ52PDkEwIWQ/oqMnA=;
        b=Iyns7CcGVw5HQDeJYdiVTN1EmBNkKLnrFgaONs8SNIeYODzpMT0uwrWcivAmGoKw/G
         GQHQoFdg3KPS0nntCXQrvfJhNCGL+H9da6KbzDTC6s7pakTTI1X1oamQOEYWbshrsdax
         wWpFvWzcraXpUPgHrISnWGKFZj+EpkSYQQD5YgxGvrPXksP+3vEcOPWPWpkdOhhg8RZC
         eBD6tpdFKBkBJQNPStC7FtIg/jAqqybD2y5jh2f4alpE1Ufy24ZwUnq5gDe9AbkuC9kC
         k23tEzES+SaMzDioAqHiH0QF4rrE/TUPR60x0oTPn/I2MHe4o68PVN7ZhSE45yiKX6UD
         zxBg==
X-Gm-Message-State: AOJu0Yz7iEbsWt3WYF41OI4oHObF/1cGiaTWIwFEIKwnL8jvvLQHfyqN
	P02sldvehVsDUcu4n/cQyZ4njlRaHDjBaP8kGBn+57KAbDwnAugaVKqTZA==
X-Gm-Gg: ASbGncu2xR52zfBOrcw7J2M9qwqJzpjZ4jyDZnIZaK85TIvWYkO6Z5dBFG3ihSechEE
	4wyrhFaNhY9vh/6tg8dpWuDt3sXc3T4JvAmvQt9ztqv6UfRSe5BdFc5BuYVIFetjY/f+xnwB8yI
	yK1ZrOtSeUQ45VPV7uu82LMEL77d7+rOv5auYG7afWe2/ugRF+sUgYQ2UfztZpSNJ8p16qBdbb8
	iUCsTn+SAT/Si1XU974bDbO9VF07KLNggfEbNiZlFAUWa+gAtZhjA==
X-Google-Smtp-Source: AGHT+IGuS3EL/ZGc3oRx4Rn+nv8ErGj9eikEz8+TZetNXKWz8XAdLznZWm5DtLHbVw4YyDlXViYfrw==
X-Received: by 2002:a05:690c:610f:b0:6ef:5688:f966 with SMTP id 00721157ae682-6f531311b4bmr259891777b3.37.1736965877724;
        Wed, 15 Jan 2025 10:31:17 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:b::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6f546dd71ebsm26323707b3.84.2025.01.15.10.31.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 10:31:17 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: fstests@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	bfoster@redhat.com,
	djwong@kernel.org,
	nirjhar@linux.ibm.com,
	zlang@redhat.com,
	kernel-team@meta.com
Subject: [PATCH v3 1/2] fsx: support reads/writes from buffers backed by hugepages
Date: Wed, 15 Jan 2025 10:31:06 -0800
Message-ID: <20250115183107.3124743-2-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250115183107.3124743-1-joannelkoong@gmail.com>
References: <20250115183107.3124743-1-joannelkoong@gmail.com>
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
 ltp/fsx.c | 119 +++++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 108 insertions(+), 11 deletions(-)

diff --git a/ltp/fsx.c b/ltp/fsx.c
index 41933354..8d3a2e2c 100644
--- a/ltp/fsx.c
+++ b/ltp/fsx.c
@@ -190,6 +190,7 @@ int	o_direct;			/* -Z */
 int	aio = 0;
 int	uring = 0;
 int	mark_nr = 0;
+int	hugepages = 0;                  /* -h flag */
 
 int page_size;
 int page_mask;
@@ -2471,7 +2472,7 @@ void
 usage(void)
 {
 	fprintf(stdout, "usage: %s",
-		"fsx [-dfknqxyzBEFHIJKLORWXZ0]\n\
+		"fsx [-dfhknqxyzBEFHIJKLORWXZ0]\n\
 	   [-b opnum] [-c Prob] [-g filldata] [-i logdev] [-j logid]\n\
 	   [-l flen] [-m start:end] [-o oplen] [-p progressinterval]\n\
 	   [-r readbdy] [-s style] [-t truncbdy] [-w writebdy]\n\
@@ -2484,6 +2485,7 @@ usage(void)
 	-e: pollute post-eof on size changes (default 0)\n\
 	-f: flush and invalidate cache after I/O\n\
 	-g X: write character X instead of random generated data\n\
+	-h hugepages: use buffers backed by hugepages for reads/writes\n\
 	-i logdev: do integrity testing, logdev is the dm log writes device\n\
 	-j logid: prefix debug log messsages with this id\n\
 	-k: do not truncate existing file and use its size as upper bound on file size\n\
@@ -2856,6 +2858,101 @@ keep_running(void)
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
+#ifdef MADV_COLLAPSE
+static void *
+init_hugepages_buf(unsigned len, int hugepage_size, int alignment)
+{
+	void *buf;
+	long buf_size = roundup(len, hugepage_size) + alignment;
+
+	if (posix_memalign(&buf, hugepage_size, buf_size)) {
+		prterr("posix_memalign for buf");
+		return NULL;
+	}
+	memset(buf, '\0', buf_size);
+	if (madvise(buf, buf_size, MADV_COLLAPSE)) {
+		prterr("madvise collapse for buf");
+		free(buf);
+		return NULL;
+	}
+
+	return buf;
+}
+#else
+static void *
+init_hugepages_buf(unsigned len, int hugepage_size, int alignment)
+{
+	return NULL;
+}
+#endif
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
+		good_buf = init_hugepages_buf(maxfilelen, hugepage_size, writebdy);
+		if (!good_buf) {
+			prterr("init_hugepages_buf failed for good_buf");
+			exit(103);
+		}
+
+		temp_buf = init_hugepages_buf(maxoplen, hugepage_size, readbdy);
+		if (!temp_buf) {
+			prterr("init_hugepages_buf failed for temp_buf");
+			exit(103);
+		}
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
@@ -2883,7 +2980,7 @@ main(int argc, char **argv)
 	setvbuf(stdout, (char *)0, _IOLBF, 0); /* line buffered stdout */
 
 	while ((ch = getopt_long(argc, argv,
-				 "0b:c:de:fg:i:j:kl:m:no:p:qr:s:t:uw:xyABD:EFJKHzCILN:OP:RS:UWXZ",
+				 "0b:c:de:fg:hi:j:kl:m:no:p:qr:s:t:uw:xyABD:EFJKHzCILN:OP:RS:UWXZ",
 				 longopts, NULL)) != EOF)
 		switch (ch) {
 		case 'b':
@@ -2916,6 +3013,14 @@ main(int argc, char **argv)
 		case 'g':
 			filldata = *optarg;
 			break;
+		case 'h':
+			#ifndef MADV_COLLAPSE
+				fprintf(stderr, "MADV_COLLAPSE not supported. "
+					"Can't support -h\n");
+				exit(86);
+			#endif
+			hugepages = 1;
+			break;
 		case 'i':
 			integrity = 1;
 			logdev = strdup(optarg);
@@ -3229,15 +3334,7 @@ main(int argc, char **argv)
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


