Return-Path: <linux-fsdevel+bounces-39802-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E517A1878A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jan 2025 22:58:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3DB5188AEA5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jan 2025 21:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7E2D1F8934;
	Tue, 21 Jan 2025 21:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kq0ygRFr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A311F8674;
	Tue, 21 Jan 2025 21:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737496680; cv=none; b=ZZiXfumUD1al53J4Tem9ORVRfdFjqT2ATZ0zL+aKES7XQFZFUEQirALRWs3boXGlTeFGeKnPuZ88rX3Ue3Vo86Kx0Mj+6GNdGePSQ1MSoPFh0JNghju9R1vLnw2N3gMimG/HgGCmZmHM2jZrQyUaAnpMgnhAW8yTDKd2HCE9mJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737496680; c=relaxed/simple;
	bh=ZfT+H72UJS9lmhU1d+ElD4UY/bO4CP4V/vZ/3N7nJAE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cfOk1fwlxeQpJywBtBqz74TztpnT69TVp+PU8/Ozh708+GWYNysH2QCnfms69e1pJZpc419biapaUsyai44EicxIfGzumY77GdLIIp0SEvCnslY8ufw7iMaJjqWjIBfK0TmSVzTCmdENw42kTMSUdYo7Fa0gyuh6hAVzsApEeog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kq0ygRFr; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e46c6547266so8954234276.3;
        Tue, 21 Jan 2025 13:57:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737496677; x=1738101477; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SCUv7GWIoOIEwyAUPYjlg/ObKeavzlxcbY7QUbH1iAM=;
        b=Kq0ygRFrq56FT5dfbfo5K7cVVT5A9vyLVWqOQceVlXUGkCb5qgiqaslfOI5/jYaPKM
         sOKgyN0yz90d5uCOYh2D1j7j2NwvjO78P4o4h7id/BTmelbYzz5/ecrd9e5fOwOJrQ4D
         MgNX9xzoeacrkpcOh8O0bjT4/y2QBX64dTDoEKqvPXctRgYkQZNiBHGnKe3hmvGNRmh+
         hTZY1CVJOmsjvOALMrfU7DN5yhTM72hxtj4r1CsGCbGK/HRIHrrahp+NibVjhbhy2eNP
         Z6MQctxIjUQh/XPLPRArVbB2wQiqKuhEPH78Ti/nmoNFHEdHYDRVl1mZgCfn0rvtN99z
         89tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737496677; x=1738101477;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SCUv7GWIoOIEwyAUPYjlg/ObKeavzlxcbY7QUbH1iAM=;
        b=K1Yo6dGJaGwxCsrWJ5Oin3oK31fU9olmi0Xzf5olw9O5VC38EnvBmt5Cov6eI6rWwt
         AWjSstwYK3SUVvY33Cl2tmMJwDpHa3lxwk903wo4E425giU5iN9BMn+LKv7QmOvitYic
         PwaeYbJ4wIonqABQYf+v99MnKm2LLCUxAaPskxsdQAgDKvCgktcYBHZsYOKXKWsKtBdG
         srw42lv6esT1Ds93yYpMK6eKnrGERdxcigSqHyVjGpsEOrP2pTGvYom9PlOESipFC8pC
         siOG/CejmcaYjkrtqiAweXMFC0RhBbMPTOo+evO1zZhqavM7t0740UNQCBpa8vr4yx1w
         4YYw==
X-Gm-Message-State: AOJu0YwhQDS8oJrF60hFiUh1xaK0QfRy4BN/+Za574Rryq9BBSgsVKfU
	FdkW1nbxtWtUarYFckofjfkJUlvArl2B17Dmpc+Jlhlzg0HBc6texViWIw==
X-Gm-Gg: ASbGncs6GLRQ9x7Ixt5SY6NHcUMRxxc2nQGOZPad4u1VdQD3XcdeE2Zk5yHZ5boKLZD
	Aa9qrLYhDEKCS6sLQ7bHfGtopakLdINtXZwhGyZbDCjU3mFSUpAVHvE+NFcNGDy5CF/Sltx6qin
	KmcuM29a+TdT7oIezHpPl9zaSi6hQm1349ICxPETaXSCV/BMW1V4WJtzl9Zn03hyYCTrlAMWtei
	BCPuKnpQPlUZA03FlliDQfZAHvx1N+Zyi3VbgvF4KbLWZ+6xKbGADhvcER1wpkd9SA=
X-Google-Smtp-Source: AGHT+IE6bhf00Ia6mF1FLlaECw7dfSYYPvqtnYsPR2qLKs3kQEMr634cVemMcDqVgwLLwgFnZyVOHA==
X-Received: by 2002:a05:6902:18c4:b0:e58:1353:2663 with SMTP id 3f1490d57ef6-e5813532852mr563553276.10.1737496677362;
        Tue, 21 Jan 2025 13:57:57 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:3::])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e580936ae55sm222650276.4.2025.01.21.13.57.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2025 13:57:57 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: fstests@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	bfoster@redhat.com,
	djwong@kernel.org,
	nirjhar@linux.ibm.com,
	zlang@redhat.com,
	kernel-team@meta.com
Subject: [PATCH v5 1/2] fsx: support reads/writes from buffers backed by hugepages
Date: Tue, 21 Jan 2025 13:56:40 -0800
Message-ID: <20250121215641.1764359-2-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250121215641.1764359-1-joannelkoong@gmail.com>
References: <20250121215641.1764359-1-joannelkoong@gmail.com>
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
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
---
 ltp/fsx.c | 166 +++++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 153 insertions(+), 13 deletions(-)

diff --git a/ltp/fsx.c b/ltp/fsx.c
index 41933354..3be383c6 100644
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
@@ -2833,11 +2846,41 @@ __test_fallocate(int mode, const char *mode_str)
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
+	int ret;
+
+	/* re-collapse every 16k fsxops after we start */
+	if (!numops || (numops & ((1U << 14) - 1)))
+		return;
+
+	ret = madvise(hugepages_info.orig_good_buf,
+		      hugepages_info.good_buf_size, MADV_COLLAPSE);
+	if (ret)
+		prt("collapsing hugepages for good_buf failed (numops=%llu): %s\n",
+		     numops, strerror(errno));
+	ret = madvise(hugepages_info.orig_temp_buf,
+		      hugepages_info.temp_buf_size, MADV_COLLAPSE);
+	if (ret)
+		prt("collapsing hugepages for temp_buf failed (numops=%llu): %s\n",
+		     numops, strerror(errno));
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
 
@@ -2856,6 +2899,103 @@ keep_running(void)
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
@@ -2883,7 +3023,7 @@ main(int argc, char **argv)
 	setvbuf(stdout, (char *)0, _IOLBF, 0); /* line buffered stdout */
 
 	while ((ch = getopt_long(argc, argv,
-				 "0b:c:de:fg:i:j:kl:m:no:p:qr:s:t:uw:xyABD:EFJKHzCILN:OP:RS:UWXZ",
+				 "0b:c:de:fg:hi:j:kl:m:no:p:qr:s:t:uw:xyABD:EFJKHzCILN:OP:RS:UWXZ",
 				 longopts, NULL)) != EOF)
 		switch (ch) {
 		case 'b':
@@ -2916,6 +3056,14 @@ main(int argc, char **argv)
 		case 'g':
 			filldata = *optarg;
 			break;
+		case 'h':
+#ifndef MADV_COLLAPSE
+			fprintf(stderr, "MADV_COLLAPSE not supported. "
+				"Can't support -h\n");
+			exit(86);
+#endif
+			hugepages = 1;
+			break;
 		case 'i':
 			integrity = 1;
 			logdev = strdup(optarg);
@@ -3229,15 +3377,7 @@ main(int argc, char **argv)
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


