Return-Path: <linux-fsdevel+bounces-44110-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 90CACA628FA
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Mar 2025 09:20:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE149177A72
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Mar 2025 08:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10BB11EEA29;
	Sat, 15 Mar 2025 08:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bGTrR16F"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DB241662E9;
	Sat, 15 Mar 2025 08:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742026833; cv=none; b=IhkFWIm/vPdUtrIfuMH/o7t4yiQ+WH4SFCuzrh9bkmclGwoRpZYwIVKymCWwrJtpEBn3f94Ss2VcTV/e4zJb0bn9qFhDjR8XQqfJk3TvPT3NF5SwzY/svcQjFcwhiSaHLz49+PA3yvXWkaKNXbWkPems3jTbIL1EEchpf13XUIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742026833; c=relaxed/simple;
	bh=S9W51Duew2XZGYenBRa+F4G20DN69LIGQozW4gp5KpE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lc0IvLF3k9pBBzZCVH/VoEcPu+Xv36w+OR4cf2iy16pD7UWhxQfyNI+6CfD+4G3tDd7O88mGtlYoWnmtv7VuAoSoruorjvBK6omg/h03395BbSPdN1nzlOwXSPclruV+SnxsuykH1pxnkbjp7ZjUfHzkdqQ5crMBJ0EsJc4vlo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bGTrR16F; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-225477548e1so51117015ad.0;
        Sat, 15 Mar 2025 01:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742026830; x=1742631630; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZDKmCtnz6WRYvJBmz518KSHy6YVJXCeesgjz9etgMz8=;
        b=bGTrR16F6IcjkiYozcoSAAMYAqt20lK5J5mcP+2kgg0eX5OBzS5C2SlY0AuyeTtbrF
         zcilkdn4fFNRT4Q9E4AoqIKaiI5yg4B7qit4rwW48AzW4KGpuK46i6EqIS413diMcsRS
         iWgO9QIivDeg//XFwDtuQ2PzdqVRrqt3Rqk8Z6qbH7emqkxD0izz+98PxxjDFzlG3WFn
         fKw+x7Eyv38nM0zPrEtWsNJjXKNOd8oUj+6OGH6bWIkkFpttn/XRQZNh6FboRLpxK4Ek
         6l7/lRNCsKw+nNzx1ty6jJr8CQ4MBOqti3zajj3XBPQeNqkoXI3ploqLOxGubDA8zWl6
         QAHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742026830; x=1742631630;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZDKmCtnz6WRYvJBmz518KSHy6YVJXCeesgjz9etgMz8=;
        b=HDxf2MEGVL3r63ZJFwATLdT8Cyko8fkp/bZYtz/6bUvFoalZYfREAoMVhgB7FEqSly
         KdpOq2j/XbokT8SZKqDISiU6m1Q+NcmQT/Rk6f9PJjlO//nr/g5gJUx3wjG7f4iPc/Rp
         zV0Gf7hiV/GtnN6f94NRkRWUJi9rR4D+rx0PEyDYhGQEVn4IhWCk0nf3S3Gx6tIpczgB
         Z2x0fy1Pm46yMgmef38FQ9AKWBnN1HuWJhRNfJai7mKX7GaO5Iyu3NnQ3YLrxrpX9ZyZ
         qkL2CjfFbmLQ0wrMyaTPXeIe8ioTrjqZh5Ikf5XBrhAclNiBp+UcrL84wW9/IRFsBjGw
         3vIA==
X-Forwarded-Encrypted: i=1; AJvYcCVpwovIx9ewbA6ltbHmxkmz8pCFfo13UF90LzbLaQdhnrrXkVu2mF32hCD/0o0pkZHu2ajmR5CgdaYiNDxr@vger.kernel.org
X-Gm-Message-State: AOJu0YxC83iyGrCQDR2VcU/3B60HeSV7GvSGSoIOwsp7mfzF6eY97bvv
	6FwcXMigcJvHW5YMEskw7soCNljm6So29BGu4gDd7zazYZisq06Dno5XlA==
X-Gm-Gg: ASbGnctTaN9M7v/qoSkBg3i1Z8SBwmtYBmpqO1fgdBUW9myA/6oTG3Y2y0djZxR/kD3
	J33NYwCHdVzwqYFV0bkz5SxHiUwon62ozlrJqaoItIPbFZqxFSBzK2qQ8rXex9F9K3j+I2Ci2l0
	8L1TVMx6luIeH1XEFF6eOXmYh7tBOGJerVX+a9acEkcyeFIDAh1op/4DFUDOSn703NvAv235T3K
	MaiAy7RArXuwtNh44mIR4ThhhM+1XbLMjEpKIM3HE8BQRogy2zkuNDPQYSRpu//bz1n5E1NJAza
	dZfQzdOTQWWaBFDPO2DePapYYe1badFWphEQBjNA4Y7EH21lTw==
X-Google-Smtp-Source: AGHT+IG+sI+fAHY8ZG6LvqmZthtOA8k8bZQZOjWIV4pGGtfVDndNn1lV0QlbPxbPMwN/z+ZbosmrmA==
X-Received: by 2002:a17:902:ce0b:b0:223:fabd:4f99 with SMTP id d9443c01a7336-225e0a19b97mr76195005ad.5.1742026830260;
        Sat, 15 Mar 2025 01:20:30 -0700 (PDT)
Received: from dw-tp.ibmuc.com ([171.76.87.44])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6bbe7e4sm40071405ad.189.2025.03.15.01.20.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Mar 2025 01:20:29 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linux-xfs@vger.kernel.org
Cc: "Darrick J . Wong" <djwong@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	linux-fsdevel@vger.kernel.org,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [PATCH v3 2/3] xfs_io: Add RWF_DONTCACHE support to pwritev2
Date: Sat, 15 Mar 2025 13:50:12 +0530
Message-ID: <3e963c2a21a90aaf6f76eb1eec7b58267ef5bf67.1741340857.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1741340857.git.ritesh.list@gmail.com>
References: <cover.1741340857.git.ritesh.list@gmail.com>
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

Reviewed-by: Darrick J. Wong <djwong@kernel.org>
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
index fab59be4..7df71e23 100644
--- a/io/pwrite.c
+++ b/io/pwrite.c
@@ -45,6 +45,7 @@ pwrite_help(void)
 " -N   -- Perform the pwritev2() with RWF_NOWAIT\n"
 " -D   -- Perform the pwritev2() with RWF_DSYNC\n"
 " -A   -- Perform the pwritev2() with RWF_ATOMIC\n"
+" -U   -- Perform the pwritev2() with RWF_DONTCACHE\n"
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


