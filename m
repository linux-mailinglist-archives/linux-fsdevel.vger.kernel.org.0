Return-Path: <linux-fsdevel+bounces-38171-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FEBB9FD78C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Dec 2024 20:34:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA2DC1882746
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Dec 2024 19:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CE791F8AEA;
	Fri, 27 Dec 2024 19:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P0VigIBH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54AC81F8684;
	Fri, 27 Dec 2024 19:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735328082; cv=none; b=g7XVU9yYElh3eJsurz9I1txowQco3cmwIHMJvs9EvlgU0+5qB7cNtMmFQxTU6pLhM6kXWzTcAFIyMztQv3fnIdNkjKHJ5yC/Bgr2An/A2gXFLc5QpzQ2e1i80QTwuD3RY/FadeMzpgOzaEpHiBsMBy7XviEFpLoVsPa0Z4Yz1HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735328082; c=relaxed/simple;
	bh=iIh9tYo2datZE2SidAz0Sx18rhptCeAE7ZDM8ycXWlo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dVcGIcueqGZJo/V+ybJvdLC5MATgk5u29KWe7BD/zttTnaz35c7flMBNwB9rD77s6ipo9iJSJR9rLWqNNKnuL1gJjko2xuodpcxnQAWW2ClzfPZk2ox9txs5Pnh8Q6MZ24uRXHueiHqh77TduKuVK/VmSf3zKcnd40RPkFPoQwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P0VigIBH; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e3a1cfeb711so7031262276.0;
        Fri, 27 Dec 2024 11:34:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735328079; x=1735932879; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kJpzkYGe0ATnJKph/aDrkOAShb12CgHIBJSlyXyOjjs=;
        b=P0VigIBH71/PgP54pGIr7Jds90TbmMjWpYO6nbUKdXKUs11c3QLVLqcSn7WOdGxv/W
         QOK5EwOYHnNjF4Fs6TWYULfrv6WvkufVPytgG6juAE9akAQB1v6/kU5hv8BZQN0aEHXk
         D3FwpOBxZtK2OglN+ynEM9Gq9ywZeeOI+juGr/DNvf8e/ZLfUQpoj2z3jGloawTrd2K9
         EhM7tNrcxf6Gix2YHJVZ/Em0RguPO6w3qVBqjN1tNDYNm7oznvA/lizbUVJSVgZilO+m
         pUVWAPQYD1wCBP/S6k+YzhnnAfsxSw2T5ekRG73Q8YeX2hHrT0Q4SC7WjqBuLQVZ28MS
         hcCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735328079; x=1735932879;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kJpzkYGe0ATnJKph/aDrkOAShb12CgHIBJSlyXyOjjs=;
        b=XRj72RSzox/msE7OeeKU7T6l4k7+TAbqbEMd2MmZJ58yVBDKIkYZYKVgGRiqEwSgDc
         4I8MDuoWzfCVjFaDdu27UGX8Sl3MAch7mBxEsDNfIVemMxWAfLqP0pvT/oCFMJFs53WI
         CmTTSJd/xZyp32MQ8K6qRVvZn8uqsmZ0xv8mAonSaYmZoSHD4byXSn14JCKC4cx9Evvs
         hc8s+oex8DfxCw4dJPd0oDdUsm/ggL451SteC4bvJj0NcWAiHDaPrmpxL8w10aJ+Iqqx
         ZH3B2T8/pFhzpuQXq5oSC1CPCFo8SrPqFFICMJMN+FDZAhUSVoHWrDgQvOXr/Pc4f/74
         zDeA==
X-Gm-Message-State: AOJu0YzEK1oAZS/Hgtk1I5+DKasCfnic6m2lXzyXVokcfonWgPMZPxs5
	LiE5gIuF1IMcGReZsQmFFcW+ljD+yryA5h89QXCAJIZbYy81Quqzom4sqg==
X-Gm-Gg: ASbGncuPZBa4xBFSU1z/0HU1VkVyyCLACe1AMrkndp4RpoVVaf6N+slGnCYO5qGdbM9
	dIMNaDLFqBChLiwb7DrcCwnKAm6PnhCpfsuSOvlDuCClR7GimXVUFxi/mOkwsHGROA9TJnHmk+0
	+iexnTj/9bvT8BeUKUHFhkCPtTM+r97oPRq4cczPn6AidWnGoKc0qPzSgugr0a6H6orhAbZvRUq
	FN8xTqRjvl2lDjkZqp3sDtHs1YR9KBHyTKeKj1RbjXtrTQ49fIUpA==
X-Google-Smtp-Source: AGHT+IHjVWY0W9peoSoxpIf1iHDG+rvz/EE12fWKYTJcNmfLSaW4w6tEam2y+EKxU6jMwFbGpl9BVg==
X-Received: by 2002:a05:690c:690b:b0:6ef:7372:1131 with SMTP id 00721157ae682-6f3f8251854mr182587667b3.41.1735328079239;
        Fri, 27 Dec 2024 11:34:39 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:d::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6f3e77ed577sm44143297b3.76.2024.12.27.11.34.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Dec 2024 11:34:39 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: fstests@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	bfoster@redhat.com,
	djwong@kernel.org,
	nirjhar@linux.ibm.com,
	kernel-team@meta.com
Subject: [PATCH v2 1/2] fsx: support reads/writes from buffers backed by hugepages
Date: Fri, 27 Dec 2024 11:33:10 -0800
Message-ID: <20241227193311.1799626-2-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241227193311.1799626-1-joannelkoong@gmail.com>
References: <20241227193311.1799626-1-joannelkoong@gmail.com>
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
---
 ltp/fsx.c | 108 ++++++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 97 insertions(+), 11 deletions(-)

diff --git a/ltp/fsx.c b/ltp/fsx.c
index 41933354..fb6a9b31 100644
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
@@ -2856,6 +2858,95 @@ keep_running(void)
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
+			exit(100);
+		}
+		good_buf = init_hugepages_buf(maxfilelen, hugepage_size, writebdy);
+		if (!good_buf) {
+			prterr("init_hugepages_buf failed for good_buf");
+			exit(101);
+		}
+
+		temp_buf = init_hugepages_buf(maxoplen, hugepage_size, readbdy);
+		if (!temp_buf) {
+			prterr("init_hugepages_buf failed for temp_buf");
+			exit(101);
+		}
+	} else {
+		unsigned long good_buf_len = maxfilelen + writebdy;
+		unsigned long temp_buf_len = maxoplen + readbdy;
+
+		good_buf = (char *) malloc(good_buf_len);
+		memset(good_buf, '\0', good_buf_len);
+		temp_buf = (char *) malloc(temp_buf_len);
+		memset(temp_buf, '\0', temp_buf_len);
+	}
+	good_buf = round_ptr_up(good_buf, writebdy, 0);
+	temp_buf = round_ptr_up(temp_buf, readbdy, 0);
+}
+
 static struct option longopts[] = {
 	{"replay-ops", required_argument, 0, 256},
 	{"record-ops", optional_argument, 0, 255},
@@ -2883,7 +2974,7 @@ main(int argc, char **argv)
 	setvbuf(stdout, (char *)0, _IOLBF, 0); /* line buffered stdout */
 
 	while ((ch = getopt_long(argc, argv,
-				 "0b:c:de:fg:i:j:kl:m:no:p:qr:s:t:uw:xyABD:EFJKHzCILN:OP:RS:UWXZ",
+				 "0b:c:de:fg:hi:j:kl:m:no:p:qr:s:t:uw:xyABD:EFJKHzCILN:OP:RS:UWXZ",
 				 longopts, NULL)) != EOF)
 		switch (ch) {
 		case 'b':
@@ -2916,6 +3007,9 @@ main(int argc, char **argv)
 		case 'g':
 			filldata = *optarg;
 			break;
+		case 'h':
+			hugepages = 1;
+			break;
 		case 'i':
 			integrity = 1;
 			logdev = strdup(optarg);
@@ -3229,15 +3323,7 @@ main(int argc, char **argv)
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


