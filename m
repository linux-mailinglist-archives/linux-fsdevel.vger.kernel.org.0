Return-Path: <linux-fsdevel+bounces-44111-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41A1CA628FC
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Mar 2025 09:20:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A24919C049C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Mar 2025 08:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6269E1F03C2;
	Sat, 15 Mar 2025 08:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ax+aFz/G"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 610C01EEA5D;
	Sat, 15 Mar 2025 08:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742026835; cv=none; b=hIz6JsWGDOMMrkN63YFEbEweLhQkKmJr1y/tlCmW6HYeis5N3qKPavTaVXGGaHiXTw4H05+7w2pEiiu7Lfq6Q5y76bcsqo7zDpRebDAmzSfYlbaHwU3hlD2kx7wCPaBfJWUVyzi4fJgXwd+1Wk4/9orlwnw01jQNdXLweiMPesU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742026835; c=relaxed/simple;
	bh=scQBckZeUdy0ISbBqgWhJXTDfjcQLLJ9Xy/AnU/E5K0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QMtqd4hRyMBsplOEmvanwiceysMt4vq6srELMVETptOXpkaXfVEmFQ3mMxTS1nWrUnBQQF+BjvvWEmqtXm7AZraWmphG0daPWBJXKRJyJC6kx7JNPlalS3QEE6gUCqyv5ncnGGignd4/CAq8t5qY/QMC05hGDSABpZ/6YjmGZDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ax+aFz/G; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-22580c9ee0aso52115355ad.2;
        Sat, 15 Mar 2025 01:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742026833; x=1742631633; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0r7NtJ9klln0aHhk58CJYXj/8kTnWVGVTMJNGVZQtaw=;
        b=Ax+aFz/Gt7ehiK44GSJn4kDjVkMhtuwTHdB8x4abg54bAIq0Cgash1q5EhwU71r5B+
         Vi1g1e5BEbGguTEjDa1abWSLj5fsb4mYUzD3VNk7rcuDQVa9Pz+uRAQvu4z+3g+6I/MU
         K9HpV7TssmOnUgNuAmDMABlRNnF19Tibi+So40bXOl8s/v/lZ6IQv7ja1ZoIe780IJYj
         W/poNg7uiUY1cqPl9ZGw867Txz+evkgJD81mVClUzyjwTd2rP8/gfXT/eyddSMp2E08F
         XBlV8U7iF6KwEHdx0m0ZipbAR0Ke8BtxBj10RikT5f/GJDdJatbiIRVbpCgzL27RLaJq
         vA1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742026833; x=1742631633;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0r7NtJ9klln0aHhk58CJYXj/8kTnWVGVTMJNGVZQtaw=;
        b=iXdMeMoFcxYhdsoF39PX4pSDkrfZqJBJCu0u0w1rVNPscoUQ0+iXEJdlu3GvoGBVn7
         PfM/iD6nbUN5Tg2PbFWaHgRMvVxRoesmhtnK36OWTx94G9S59Apj/5/VcOt/LUSu/2+8
         waeS1rbuuq210iKGjxcz1h9F276fXqhjUb/eY7bIpyO3IvN9klzZI6FfoTHg12rNLx9s
         ubR2rQlgXa6KAhwB4ADSaNju6Ywk1gQOYtFKQ2z9B/Cas7SXlzCbzY1cIkkN/A8nMDMC
         y5UBVdx6nK+ggeXiL/ZzvkSJkvczDyk7PuQ2nfUA0oHXWYDkxjV3/mGFEgQ2+g02QLCy
         Lb4w==
X-Forwarded-Encrypted: i=1; AJvYcCXpCYP/i13w+34G4lhCSUBFaYwLEwNpre21U+0lZlLlohz/6WoeBvdeJJ94DO+xw4NeKEckQ0GtmcuV2kOE@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2C48U0hxlfDqHopSn+gy0tU5YWfMvq4CUtu95YzTcCe7AQmtc
	YCsAeyUuHg4LVF93p6tBz6n6X0baqgSlfQjvG3/KsaM9tkTQ2xP3aZ3wDg==
X-Gm-Gg: ASbGncuhUz6LBLw+PSTgNyTPfPw4k5ww0GAxLGnrpm3A677dMgZ2Gfob+gOeUDRjYCP
	xRJQqA+q90tP4L3rhGxGU5S/dVWImFOiUZXd8gSKUUMiogdcRpKZXASlsLdbW0QW/lCW9G1OcAY
	bME77/m/p39Pb9oRxF7z3eA1zemO/g0Hfa5h4BR5HmInnmcuC+OzDvK8g//Z02Fnl25jfgSzfXu
	w6a4/JIcuWAibf4bKVWwMd2+LRA0mw6bsgtthQFpiqct52RCKQf4DbJd3ucLJN4G9ij4uc/AH+Q
	7NM/+YHnXArsw6/nzgoI5ET4eVMtKIFwo+fC0OFPrcc3E+oAiAb+TzrFiyEM
X-Google-Smtp-Source: AGHT+IGK/14wNJTEiKy5DE8PsCS/c/oPToivZVbGCOUp4OzjXzRQtXhOUktxOkPAteyEy2I63UBENw==
X-Received: by 2002:a17:90b:5405:b0:2fe:7fea:ca34 with SMTP id 98e67ed59e1d1-30151d7af87mr6137635a91.32.1742026832960;
        Sat, 15 Mar 2025 01:20:32 -0700 (PDT)
Received: from dw-tp.ibmuc.com ([171.76.87.44])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6bbe7e4sm40071405ad.189.2025.03.15.01.20.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Mar 2025 01:20:32 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linux-xfs@vger.kernel.org
Cc: "Darrick J . Wong" <djwong@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	linux-fsdevel@vger.kernel.org,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [PATCH v3 3/3] xfs_io: Add RWF_DONTCACHE support to preadv2
Date: Sat, 15 Mar 2025 13:50:13 +0530
Message-ID: <af58062f6e4e0f2acc72884f2a398cd8dcfcae2c.1741340857.git.ritesh.list@gmail.com>
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

Add per-io RWF_DONTCACHE support flag to preadv2().
This enables xfs_io to perform uncached buffered-io reads.

	e.g. xfs_io -c "pread -U -V 1 0 16K" /mnt/f1

Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 io/pread.c        | 17 +++++++++++++++--
 man/man8/xfs_io.8 |  8 +++++++-
 2 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/io/pread.c b/io/pread.c
index b314fbc7..606bfe36 100644
--- a/io/pread.c
+++ b/io/pread.c
@@ -38,6 +38,9 @@ pread_help(void)
 " -Z N -- zeed the random number generator (used when reading randomly)\n"
 "         (heh, zorry, the -s/-S arguments were already in use in pwrite)\n"
 " -V N -- use vectored IO with N iovecs of blocksize each (preadv)\n"
+#ifdef HAVE_PREADV2
+" -U   -- Perform the preadv2() with RWF_DONTCACHE\n"
+#endif
 "\n"
 " When in \"random\" mode, the number of read operations will equal the\n"
 " number required to do a complete forward/backward scan of the range.\n"
@@ -388,7 +391,7 @@ pread_f(
 	init_cvtnum(&fsblocksize, &fssectsize);
 	bsize = fsblocksize;

-	while ((c = getopt(argc, argv, "b:BCFRquvV:Z:")) != EOF) {
+	while ((c = getopt(argc, argv, "b:BCFRquUvV:Z:")) != EOF) {
 		switch (c) {
 		case 'b':
 			tmp = cvtnum(fsblocksize, fssectsize, optarg);
@@ -417,6 +420,11 @@ pread_f(
 		case 'u':
 			uflag = 1;
 			break;
+#ifdef HAVE_PREADV2
+		case 'U':
+			preadv2_flags |= RWF_DONTCACHE;
+			break;
+#endif
 		case 'v':
 			vflag = 1;
 			break;
@@ -446,6 +454,11 @@ pread_f(
 		exitcode = 1;
 		return command_usage(&pread_cmd);
 	}
+	if (preadv2_flags != 0 && vectors == 0) {
+		printf(_("preadv2 flags require vectored I/O (-V)\n"));
+		exitcode = 1;
+		return command_usage(&pread_cmd);
+	}

 	offset = cvtnum(fsblocksize, fssectsize, argv[optind]);
 	if (offset < 0 && (direction & (IO_RANDOM|IO_BACKWARD))) {
@@ -514,7 +527,7 @@ pread_init(void)
 	pread_cmd.argmin = 2;
 	pread_cmd.argmax = -1;
 	pread_cmd.flags = CMD_NOMAP_OK | CMD_FOREIGN_OK;
-	pread_cmd.args = _("[-b bs] [-qv] [-i N] [-FBR [-Z N]] off len");
+	pread_cmd.args = _("[-b bs] [-qUv] [-i N] [-FBR [-Z N]] off len");
 	pread_cmd.oneline = _("reads a number of bytes at a specified offset");
 	pread_cmd.help = pread_help;

diff --git a/man/man8/xfs_io.8 b/man/man8/xfs_io.8
index 47af5232..df508054 100644
--- a/man/man8/xfs_io.8
+++ b/man/man8/xfs_io.8
@@ -200,7 +200,7 @@ option will set the file permissions to read-write (0644). This allows xfs_io to
 set up mismatches between the file permissions and the open file descriptor
 read/write mode to exercise permission checks inside various syscalls.
 .TP
-.BI "pread [ \-b " bsize " ] [ \-qv ] [ \-FBR [ \-Z " seed " ] ] [ \-V " vectors " ] " "offset length"
+.BI "pread [ \-b " bsize " ] [ \-qUv ] [ \-FBR [ \-Z " seed " ] ] [ \-V " vectors " ] " "offset length"
 Reads a range of bytes in a specified blocksize from the given
 .IR offset .
 .RS 1.0i
@@ -214,6 +214,12 @@ requests will be split. The default blocksize is 4096 bytes.
 .B \-q
 quiet mode, do not write anything to standard output.
 .TP
+.B \-U
+Perform the
+.BR preadv2 (2)
+call with
+.IR RWF_DONTCACHE .
+.TP
 .B \-v
 dump the contents of the buffer after reading,
 by default only the count of bytes actually read is dumped.
--
2.48.1


