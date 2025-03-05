Return-Path: <linux-fsdevel+bounces-43239-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ECAEA4FBE3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Mar 2025 11:28:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D4BC3A9EDD
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Mar 2025 10:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E0532066F7;
	Wed,  5 Mar 2025 10:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d5G/HjCw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 922B62066FD;
	Wed,  5 Mar 2025 10:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741170483; cv=none; b=t043Aeay50qvmt7esc99oaIg+i41kIkQ623zKm9NRTg96vGXv3GdhIEhUawaFbLnwsCNrGx12jIorgui3q1Ub1XrzhqFoIv5coDYxcPJJjyT3iNPD7G/nbvAKsyQL/xLrwLNk4ypeVEDkjf7L1YRxgednNdrZ0OLrAuegNDkgkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741170483; c=relaxed/simple;
	bh=GBLlYgnkfy70m5cmJyaCbQCSXS94MLI9+56JOSnSQdM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CNfNBhhmzsp7G640CjAJmjDUUuLSdaxIl3NkS15mvhn2yQbA9ZDwihY9CnC92lfVs+7uS5bZ1ag3j/zn+UYyPsPh5RaU1Nqux8DXwreJ2mNXtlbHi8nteUK0uxOordJQTQsJ2k1uqUpCm+r5RV+fqGdKfWooz47V89N4lWHf9oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d5G/HjCw; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-22374f56453so124605215ad.0;
        Wed, 05 Mar 2025 02:28:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741170480; x=1741775280; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m5MQYHxeHAfGZF8CSah4zpdhnfKZ8814DwTVzOpxx/E=;
        b=d5G/HjCweA6KYuarg0HchYkOm8ET7355eycJvXtaiVd2uup3b3Cv6WoxmQTfqCtY90
         ScLCBU6Fs+OIO89WvR8c5uZkVJVB4/ptPK/kn3cx3YjsZzbcT+7RIGHiFVNWoCHVqs0C
         YKGyaPfJq8aTGFOqZBzi+eaF6/pJTV22I+90+7DdFfWavGlh5k7YWE/L3dVo+gk4VYEc
         a9yuZBUvbmUb39wSWaNrRK267bSSBwJbc4Acili7dNWjCvnBJagVTXhxTp8iK+lgMFOE
         iI0VUOprOW4kbW79cJsCEidbN7X6+y+bviQXSz1b1u6VlfFh0kxEVTdwxJ0ksLFOWGCU
         tZLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741170480; x=1741775280;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m5MQYHxeHAfGZF8CSah4zpdhnfKZ8814DwTVzOpxx/E=;
        b=w3a4KtM3EZRnZUp/YqQfS2Q3CeQofXDEGMmc1FMCdMYawRId0teXK7CcVXFvcEz7Se
         rrBG8LHqAv4GfKMH1zztJIi3mPpDwJYV4qJUXL/V23NwFPp0sGYTQsLfYPk1k09d8qJq
         2XjsI8+dUslieUlibaELvTJvuRC8nrhYy8asQs5Gk7tKjOU0BprEjVHGqkoJqZGf1cx0
         e94s2TsfYCM4AwEMoZy6H4KNa4O2hA0EklP7HymAS7TCuvIYZS7VnUzr8Z1WmUIisGnS
         st99M65p+ahHz4lqRA3HekDaXOObrSupvutp9fpA3W0zcQf2eo3YQVc4XB0f3GNWUB5p
         2k8Q==
X-Gm-Message-State: AOJu0YwYxjXeXf3tmmUS5gIJI/iZT1qTYj8SLz2Yf2eMlVUrdUyEmaEI
	i3+KDov9ZIwTeD6hO2xC88L8bsyLxwHXaKWIzN5xLzevc9glK5JQ8Jd1vA==
X-Gm-Gg: ASbGncvCLqRWZtVk1q40IzO89PxOm9Z0fwwe44pEEIVJdE7wbOZeVandCyn0D06e96i
	LsKQF8sWOxTzqdaN+yQrY57zgOkabqBhkr5gVXk2b5m+NBq9VVSAUrFlhEwyHrOw1rDBBRcI2mF
	/Xb87UdYuZEyHaeNWwxssbmUgd1t+pT4NPOXemsWIHG0A5ST/925WfYq95tqRJB2beHj87kX9TE
	vUhJmi9B4/lqLzs4ml+ji/ML/XCIRFCyjzFHof2C6hY/njEDkgMufJV0mCTtjClAuywyveZlRiv
	kLt340Xyi6eT2Mdk5IkTRd8TxKJuIUazl6RoBSg2wiKsoZ4NCHE=
X-Google-Smtp-Source: AGHT+IHT+xqBJu5vLs92hTvbcIE+VzY9IktlnRB/C0o/Y4AfDbiNKlewSHOwlLoR1q03ycaR+bB0Yg==
X-Received: by 2002:a05:6a00:b81:b0:730:8a5b:6e61 with SMTP id d2e1a72fcca58-73682b4b1dbmr4052289b3a.2.1741170480328;
        Wed, 05 Mar 2025 02:28:00 -0800 (PST)
Received: from dw-tp.ibmuc.com ([171.76.80.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7364ef011c1sm6252768b3a.111.2025.03.05.02.27.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 02:27:59 -0800 (PST)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linux-xfs@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>,
	"Darrick J . Wong" <djwong@kernel.org>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [PATCH v2 2/3] xfs_io: Add RWF_DONTCACHE support to pwritev2
Date: Wed,  5 Mar 2025 15:57:47 +0530
Message-ID: <57bd6d327ac8ed2f8e9859f1e42775622a8b9d09.1741170031.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1741170031.git.ritesh.list@gmail.com>
References: <cover.1741170031.git.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add per-io RWF_DONTCACHE support flag to pwritev2().
This enables xfs_io to perform uncached buffered-io writes.

e.g. xfs_io -fc "pwrite -U -V 1 0 16K" /mnt/f1

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 include/linux.h   |  5 +++++
 io/pwrite.c       | 14 ++++++++++++--
 man/man8/xfs_io.8 |  8 +++++++-
 3 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/include/linux.h b/include/linux.h
index b3516d54..6e83e073 100644
--- a/include/linux.h
+++ b/include/linux.h
@@ -237,6 +237,11 @@ struct fsxattr {
 #define RWF_ATOMIC	((__kernel_rwf_t)0x00000040)
 #endif
 
+/* buffered IO that drops the cache after reading or writing data */
+#ifndef RWF_DONTCACHE
+#define RWF_DONTCACHE	((__kernel_rwf_t)0x00000080)
+#endif
+
 /*
  * Reminder: anything added to this file will be compiled into downstream
  * userspace projects!
diff --git a/io/pwrite.c b/io/pwrite.c
index fab59be4..5fb0253f 100644
--- a/io/pwrite.c
+++ b/io/pwrite.c
@@ -45,6 +45,7 @@ pwrite_help(void)
 " -N   -- Perform the pwritev2() with RWF_NOWAIT\n"
 " -D   -- Perform the pwritev2() with RWF_DSYNC\n"
 " -A   -- Perform the pwritev2() with RWF_ATOMIC\n"
+" -U   -- Perform the pwritev2() with Uncached/RWF_DONTCACHE\n"
 #endif
 "\n"));
 }
@@ -285,7 +286,7 @@ pwrite_f(
 	init_cvtnum(&fsblocksize, &fssectsize);
 	bsize = fsblocksize;
 
-	while ((c = getopt(argc, argv, "Ab:BCdDf:Fi:NqRs:OS:uV:wWZ:")) != EOF) {
+	while ((c = getopt(argc, argv, "Ab:BCdDf:Fi:NqRs:OS:uUV:wWZ:")) != EOF) {
 		switch (c) {
 		case 'b':
 			tmp = cvtnum(fsblocksize, fssectsize, optarg);
@@ -328,6 +329,9 @@ pwrite_f(
 		case 'A':
 			pwritev2_flags |= RWF_ATOMIC;
 			break;
+		case 'U':
+			pwritev2_flags |= RWF_DONTCACHE;
+			break;
 #endif
 		case 's':
 			skip = cvtnum(fsblocksize, fssectsize, optarg);
@@ -392,6 +396,12 @@ pwrite_f(
 		exitcode = 1;
 		return command_usage(&pwrite_cmd);
 	}
+	if (pwritev2_flags != 0 && vectors == 0) {
+		printf(_("pwritev2 flags require vectored I/O (-V)\n"));
+		exitcode = 1;
+		return command_usage(&pwrite_cmd);
+	}
+
 	offset = cvtnum(fsblocksize, fssectsize, argv[optind]);
 	if (offset < 0) {
 		printf(_("non-numeric offset argument -- %s\n"), argv[optind]);
@@ -480,7 +490,7 @@ pwrite_init(void)
 	pwrite_cmd.argmax = -1;
 	pwrite_cmd.flags = CMD_NOMAP_OK | CMD_FOREIGN_OK;
 	pwrite_cmd.args =
-_("[-i infile [-qAdDwNOW] [-s skip]] [-b bs] [-S seed] [-FBR [-Z N]] [-V N] off len");
+_("[-i infile [-qAdDwNOUW] [-s skip]] [-b bs] [-S seed] [-FBR [-Z N]] [-V N] off len");
 	pwrite_cmd.oneline =
 		_("writes a number of bytes at a specified offset");
 	pwrite_cmd.help = pwrite_help;
diff --git a/man/man8/xfs_io.8 b/man/man8/xfs_io.8
index 59d5ddc5..47af5232 100644
--- a/man/man8/xfs_io.8
+++ b/man/man8/xfs_io.8
@@ -244,7 +244,7 @@ See the
 .B pread
 command.
 .TP
-.BI "pwrite [ \-i " file " ] [ \-qAdDwNOW ] [ \-s " skip " ] [ \-b " size " ] [ \-S " seed " ] [ \-FBR [ \-Z " zeed " ] ] [ \-V " vectors " ] " "offset length"
+.BI "pwrite [ \-i " file " ] [ \-qAdDwNOUW ] [ \-s " skip " ] [ \-b " size " ] [ \-S " seed " ] [ \-FBR [ \-Z " zeed " ] ] [ \-V " vectors " ] " "offset length"
 Writes a range of bytes in a specified blocksize from the given
 .IR offset .
 The bytes written can be either a set pattern or read in from another
@@ -287,6 +287,12 @@ Perform the
 call with
 .IR RWF_ATOMIC .
 .TP
+.B \-U
+Perform the
+.BR pwritev2 (2)
+call with
+.IR RWF_DONTCACHE .
+.TP
 .B \-O
 perform pwrite once and return the (maybe partial) bytes written.
 .TP
-- 
2.48.1


