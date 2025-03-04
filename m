Return-Path: <linux-fsdevel+bounces-43087-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A715A4DD38
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 12:58:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F287189AA22
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 11:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3EAC202C56;
	Tue,  4 Mar 2025 11:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hr3NQ6GC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AADFA201110;
	Tue,  4 Mar 2025 11:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741089363; cv=none; b=btmTFPnALG8ZvI84HapslQADk2p+1KfaZH8IpmLTN1tL5TcuOqZ2tnBgMbXgPS3U8F/W9jjrMee7mRQremhCFZfgVBs9MAegjVtJVoZ1r1+na6y2U+hjuBpO2nT2Wii0Vz8b32cxZd92XjwBElhUtmaaXWYXYv77ZkribTIRgFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741089363; c=relaxed/simple;
	bh=7aOUIblDy3EQ+wgKEIG5+gEPd8j16BZ4NmPwz7jf/MI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iAc5YRUzpyUWhZKGC3xdzTNr83D5XnRwboyufRGddyF81jNDdr9/Q35aM3TJyVSS0Y9TkRoFM6lhACPVOjh2ArwvB8LK1NhWMdMV23F/vDlWPl0GscNZVibhYXc4WM065PJPmEQOW1WWMt+XNdwPr9A37NszAY53HjsOQc5DCY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hr3NQ6GC; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-223785beedfso64567945ad.1;
        Tue, 04 Mar 2025 03:56:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741089360; x=1741694160; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9cv71YHNNhKhc40mgKTnst9iKziRjeyxRfR1hT7At/o=;
        b=Hr3NQ6GCsbRCoyQeJC1Zz30N7ky0LFdOWmGhaeOW09/mLBNrStDZ5h1rwTcUh7/j8d
         /nWZTQXQH2eGiSUPfRzd5khPPdHXC9YjrjFbC10r4X/giiUmoEZRje317YHoDKKyZiU8
         dRQ/DvfFUsdOxeGgubIGO0ZxC39CSgk3+gFcze5DF9kYIE1ItslNu1xqfCfg+BAGGtTF
         w+Qapk5W2reKu/38+4VpbvGTCKOWD2PaeXv8vvYnP95e8BreY0isPzrY6KztwGARbNJE
         V+MxSg1unugnmLZrk/4wduwQuQxGxW2vf2MDTjQGN1AwgcN96mSwB7DadB2lwbLtQrZ2
         U9xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741089360; x=1741694160;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9cv71YHNNhKhc40mgKTnst9iKziRjeyxRfR1hT7At/o=;
        b=ehinw4dhaRzdfZYkMRu6DvhNQGmVDmZo1eEibLgEns2Q4NLm342/dtdWi6b+VQYyG/
         OYC6i2RasIhldL5R1Ht4AqGWXgNh5S+gs5wV2Ip6xNzy2nwjjs8jmMF06uRePC0e6up4
         nE4z712p8u/a1WmmbmmccLJPNy74HKdfa/f6QyXBfFaW7Z9LkLlvQEFEAKW3BBuMG59d
         jesyMYMKzJTzeAkXHOaHDqgkjr8QrQEXbYCZ8Viae6L7uMxtspU/QzA8kmvvY2wBh5sa
         zr5ZIKlGJaibvTTeoDsTEYQvcPjd5bR/pztbzdXz0myNe42nQpL6MkEV3vyr/MeANz0V
         KJkw==
X-Gm-Message-State: AOJu0YxGid65RTrRKsQVKZ3piJ1vQOB4qKJl5+gj8KA8WutvhaTlcyGo
	+cmgMBJzgVJCmi8B8spvLWrLkvG/Hwi6YusNEBCLQ0+FXag3e6H2EdYQeQLj
X-Gm-Gg: ASbGncsQ8otjYeX4myjZB3mFGnSONZsN5byeUf+3/4KVGQzwkXFv5ZFLt3YyNJpinkx
	BVkbl6nPC4gwyVtlIbO3flhFJWLUFF6EOdmt32n61FK9wpoY6CN0CwVHiL303eroWHpjnads1dm
	VaBrlinp5ntt6/GOLmrQwbJS2p1e5Z+UCyK939V8wlVgBmLY9CLjRGg4w/Bf9OoAurLbnn3Ct4U
	NEYx92EZ555EB6VwE+rsTI1X3N4UPviezy/JT9+VyDJmUYu09tMFrzIXhVmQ6HIphwZiIut6MPK
	HnOD16PqSsAu9dqlbQg+FT2APqKntV3liA+ui0nOenIa5VIcY+Q=
X-Google-Smtp-Source: AGHT+IG0v9Em5q6fJm2+I3Im4mwSTz2sL14sbt3KodeqzY457uFvksauY6/DfVQg7+Z189LyZtysiw==
X-Received: by 2002:a17:903:2ca:b0:223:44c5:4eb8 with SMTP id d9443c01a7336-2236924e3d8mr311730945ad.32.1741089360008;
        Tue, 04 Mar 2025 03:56:00 -0800 (PST)
Received: from dw-tp.ibmuc.com ([171.76.80.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223501d28desm94154565ad.16.2025.03.04.03.55.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 03:55:59 -0800 (PST)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linux-xfs@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>,
	"Darrick J . Wong" <djwong@kernel.org>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [PATCH v1 2/3] xfs_io: Add RWF_DONTCACHE support to pwritev2
Date: Tue,  4 Mar 2025 17:25:36 +0530
Message-ID: <1827774b8d5912ec6eb953f15e2319780f9cfa58.1741087191.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1741087191.git.ritesh.list@gmail.com>
References: <cover.1741087191.git.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add per-io RWF_DONTCACHE support flag to pwritev2().
This enables xfs_io to perform buffered-io which can drop the page
cache folios after writing.

e.g. xfs_io -fc "pwrite -U -V 1 0 16K" /mnt/f1

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 include/linux.h   | 5 +++++
 io/pwrite.c       | 8 ++++++--
 man/man8/xfs_io.8 | 8 +++++++-
 3 files changed, 18 insertions(+), 3 deletions(-)

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
index fab59be4..db335e91 100644
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
@@ -480,7 +484,7 @@ pwrite_init(void)
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


