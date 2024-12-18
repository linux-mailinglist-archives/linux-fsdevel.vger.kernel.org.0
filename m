Return-Path: <linux-fsdevel+bounces-37761-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F1AC9F6F28
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2024 22:02:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA0451890EED
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2024 21:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A14941FCD06;
	Wed, 18 Dec 2024 21:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z8Ur6Gk7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A870154BE2;
	Wed, 18 Dec 2024 21:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734555709; cv=none; b=cZZUuWtSFj+JXKqb/kjp6390kG+mZxgbSGE4GyDMUwi2QhlPCbJyMG+SSXQE713DWO9hVTSPAOlHR/od9JHk2DmmAKp1LnMsVORbItRQFzHm0KdkW5Zj5m+tJ9vSUnkUWHpAMY7hSpTb3Gp0PgNKYiE57aaZU3qLSwynRO6NWsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734555709; c=relaxed/simple;
	bh=cDO7UWdIQWbWH/F4yo3vlmDVwdRm8KqFQLlnMgpIVdg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZAZbHfDCAhLeyc3nghtFiV9TDIlLmNGxa3S7NJP6uuW+Mp+o9LTKy1DGXxOe4XskLvOg1SjYGTbGqIyhFAouGJ3Kr5wurly61AF6xM6Pr63psnpGZIUuEV+x8ewuRZcLF+But61F1f/mukMex2somuHcA2Qeko8D7x02Utq4fUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z8Ur6Gk7; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-6efe4324f96so955277b3.1;
        Wed, 18 Dec 2024 13:01:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734555705; x=1735160505; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QncxWc0ArffuexDoQAkc0V3NOWqi960DY4WYKPMB8Xc=;
        b=Z8Ur6Gk7r9u/oQ38eIrNS8wulihpr8njfBFeKb1UffM5Qw6y2WtfEnDUyh9ZT/w0h8
         WZwdmvDaYnplndn9yUi7hFSHl72nxxCmoAgZ9b+9oarMWgbE6fE8TTznGLKGRBpKEe6H
         vuJjpdys+J/RmRW1WEViIULc7GnU0jKAGLQhcEsMGxWoXntXAp2IJDjE2zfmIDt412zO
         ttEV6i2MVlEfAxYgs5Ml/hdb9Zw71aqt5tqElUcFzn7CIqxr57M5SF/YC+gi6I4+N7RY
         7I9wWIwR7T/g6CLM0n92WJvAeckYK4SPH4g6gxOgZI3YVd6TPlEQHS/HC+DmCRKfZij6
         giGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734555705; x=1735160505;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QncxWc0ArffuexDoQAkc0V3NOWqi960DY4WYKPMB8Xc=;
        b=tShT5lQpmxoKjwwKUBdlYYhHkKkWDO5P/4PhQVokLEcJpnY3KCWGW1nTH52o5glRE5
         GOLv64zdsn7QQdc917TkE/IJMCuIyreg8A/wbhosU7I/MDBBQ31RzfsJHTi6i31r6HzM
         Ql2BDCUMlk6pHIqupMywg0RadwkL5IdWCyCwa+vOGDBjFBBJ760N7c5oTtvcA5yxelTl
         IUjS4dJIoHKrcyiyYuHQliipnBbezPf6+tJcOEAFARBrUIdy8tlKBZl5DCwHZAjIaTyl
         2pSIeeI15ZUk/mVgseVfTpfo8XT+7Im+VNSM/3d9pE6ixYazaWt6S7R4xnI4aGUDm6h9
         cmyw==
X-Gm-Message-State: AOJu0Yzza9HMc6Uvj3mJMmmlL4PKXhheqnwERQwUNVJLFnwKGfcOXPX/
	iYW7qQJ0NEBFuhvLXnXU+v2gKjgvHX2IMAcdYskaYfcUJYvv8j9xbCx0lw==
X-Gm-Gg: ASbGncvbsGdftCF+ajpJQe89KVUAOgz4a7jEJZIJd7Jhr4BGWCX5NVY7nHA/KpCfnur
	bcpeU0Zyg8LRnlLUgtjUpKVg2HjHhg3x4tWerMhJKvSCf3UEEWRq/Cq3c3DsMhBDjfMQaPaCpfq
	L9qr0NaZHwwyDlaJc0Qe/1jTV/O+qN2i/9Of+cLbuah8dNYDou9sIEk+kfmYnIB11Uz0wmrWKGO
	XS/aPkG70KIVTA8cWzb0uxGcc1nF3rgFxZ3FbRzK0HkVWgtwnrWFeGjzuMYjQOxgsuL4Sz3oF21
	wJU7QuG5fspe3ww=
X-Google-Smtp-Source: AGHT+IGxWQIlECdd3SGIqn0jlH44IHvkjLyi7S8vfSq5akURyLZVBTNd182RVoG0lNaLJFB0NaNxsA==
X-Received: by 2002:a05:690c:d88:b0:6ef:a5bf:510b with SMTP id 00721157ae682-6f3ccc246b3mr34248537b3.1.1734555703582;
        Wed, 18 Dec 2024 13:01:43 -0800 (PST)
Received: from localhost (fwdproxy-nha-013.fbsv.net. [2a03:2880:25ff:d::face:b00c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6f288fc4f11sm26135667b3.24.2024.12.18.13.01.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 13:01:43 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: fstests@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH 1/2] fsx: support reads/writes from buffers backed by hugepages
Date: Wed, 18 Dec 2024 13:01:21 -0800
Message-ID: <20241218210122.3809198-2-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241218210122.3809198-1-joannelkoong@gmail.com>
References: <20241218210122.3809198-1-joannelkoong@gmail.com>
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

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 ltp/fsx.c | 100 +++++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 92 insertions(+), 8 deletions(-)

diff --git a/ltp/fsx.c b/ltp/fsx.c
index 41933354..3656fd9f 100644
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
@@ -2856,6 +2858,56 @@ keep_running(void)
 	return numops-- != 0;
 }
 
+static long
+get_hugepage_size(void)
+{
+	const char *str = "Hugepagesize:";
+	long hugepage_size = -1;
+	char buffer[64];
+	FILE *file;
+
+	file = fopen("/proc/meminfo", "r");
+	if (!file) {
+		prterr("get_hugepage_size: fopen /proc/meminfo");
+		return -1;
+	}
+	while (fgets(buffer, sizeof(buffer), file)) {
+		if (strncmp(buffer, str, strlen(str)) == 0) {
+			sscanf(buffer + strlen(str), "%ld", &hugepage_size);
+			break;
+		}
+	}
+	fclose(file);
+	if (hugepage_size == -1) {
+		prterr("get_hugepage_size: failed to find "
+			"hugepage size in /proc/meminfo\n");
+		return -1;
+	}
+
+	/* convert from KiB to bytes  */
+	return hugepage_size * 1024;
+}
+
+static void *
+init_hugepages_buf(unsigned len, long hugepage_size)
+{
+	void *buf;
+	long buf_size = roundup(len, hugepage_size);
+
+	if (posix_memalign(&buf, hugepage_size, buf_size)) {
+		prterr("posix_memalign for buf");
+		return NULL;
+	}
+	memset(buf, '\0', len);
+	if (madvise(buf, buf_size, MADV_COLLAPSE)) {
+		prterr("madvise collapse for buf");
+		free(buf);
+		return NULL;
+	}
+
+	return buf;
+}
+
 static struct option longopts[] = {
 	{"replay-ops", required_argument, 0, 256},
 	{"record-ops", optional_argument, 0, 255},
@@ -2883,7 +2935,7 @@ main(int argc, char **argv)
 	setvbuf(stdout, (char *)0, _IOLBF, 0); /* line buffered stdout */
 
 	while ((ch = getopt_long(argc, argv,
-				 "0b:c:de:fg:i:j:kl:m:no:p:qr:s:t:uw:xyABD:EFJKHzCILN:OP:RS:UWXZ",
+				 "0b:c:de:fg:hi:j:kl:m:no:p:qr:s:t:uw:xyABD:EFJKHzCILN:OP:RS:UWXZ",
 				 longopts, NULL)) != EOF)
 		switch (ch) {
 		case 'b':
@@ -2916,6 +2968,9 @@ main(int argc, char **argv)
 		case 'g':
 			filldata = *optarg;
 			break;
+		case 'h':
+			hugepages = 1;
+			break;
 		case 'i':
 			integrity = 1;
 			logdev = strdup(optarg);
@@ -3232,12 +3287,41 @@ main(int argc, char **argv)
 	original_buf = (char *) malloc(maxfilelen);
 	for (i = 0; i < maxfilelen; i++)
 		original_buf[i] = random() % 256;
-	good_buf = (char *) malloc(maxfilelen + writebdy);
-	good_buf = round_ptr_up(good_buf, writebdy, 0);
-	memset(good_buf, '\0', maxfilelen);
-	temp_buf = (char *) malloc(maxoplen + readbdy);
-	temp_buf = round_ptr_up(temp_buf, readbdy, 0);
-	memset(temp_buf, '\0', maxoplen);
+	if (hugepages) {
+		long hugepage_size;
+
+		hugepage_size = get_hugepage_size();
+		if (hugepage_size == -1) {
+			prterr("get_hugepage_size()");
+			exit(99);
+		}
+
+		if (writebdy != 1 && writebdy != hugepage_size)
+			prt("ignoring write alignment (since -h is enabled)");
+
+		if (readbdy != 1 && readbdy != hugepage_size)
+			prt("ignoring read alignment (since -h is enabled)");
+
+		good_buf = init_hugepages_buf(maxfilelen, hugepage_size);
+		if (!good_buf) {
+			prterr("init_hugepages_buf failed for good_buf");
+			exit(100);
+		}
+
+		temp_buf = init_hugepages_buf(maxoplen, hugepage_size);
+		if (!temp_buf) {
+			prterr("init_hugepages_buf failed for temp_buf");
+			exit(101);
+		}
+	} else {
+		good_buf = (char *) malloc(maxfilelen + writebdy);
+		good_buf = round_ptr_up(good_buf, writebdy, 0);
+		memset(good_buf, '\0', maxfilelen);
+
+		temp_buf = (char *) malloc(maxoplen + readbdy);
+		temp_buf = round_ptr_up(temp_buf, readbdy, 0);
+		memset(temp_buf, '\0', maxoplen);
+	}
 	if (lite) {	/* zero entire existing file */
 		ssize_t written;
 
-- 
2.47.1


