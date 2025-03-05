Return-Path: <linux-fsdevel+bounces-43240-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CD52A4FBE6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Mar 2025 11:28:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2866D188A1F1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Mar 2025 10:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 281D6206F1A;
	Wed,  5 Mar 2025 10:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hkiHYP+N"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 345ED205E2B;
	Wed,  5 Mar 2025 10:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741170486; cv=none; b=LHcljWBJ8PMys/ZHcyWmGeCHaPnXXHQUFdIX+mGaqvAPPjRD5xMVMSA/H6ZgZMs6eLohfeoG+AjbW4Ruu+fa5wYptTkYFqmI541rnuP15LI4nusMDXKx1d8IwTDJgZDyr+PGbZTvKSc3yIvHS97N+BxF/Jd6agCWXFMyinktjYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741170486; c=relaxed/simple;
	bh=Bg4Jpln66Q+PEDFcHmFhYqF0UtivWNAgp2+vnoajqCo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ikzGpiGaabWpwVtc8GGqyh4IcwXIa+LCZy0JRGIbooFigsDym+skLLe6A8vpeZoJRVWJMUOZFAEKnzdPOZqg6UFJ55L4NUZ29D9mPLAL5q3nx4/ztxxa6S27J3rWmCzZ9svQEpTSpH96cb6TkbCNx2z4RzVenXfzlzrlIWMobPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hkiHYP+N; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-22359001f1aso149538155ad.3;
        Wed, 05 Mar 2025 02:28:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741170483; x=1741775283; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=trVCMKE7HG2WIAeh6lPmuLGb/xVwY5hELogdeFe7gl4=;
        b=hkiHYP+NhEX0CKnJF+1Ff17NUGhYYpLkEXkDG1ULovtvMw2nTCwmEtpMakorc4RCsH
         7VVCsYagqnyQirK1Ps/4t8LsMR2B2mihKoyUMGh5eElXo8TH+MSEFVg2YH94h/T1+GU2
         EYGWabhxu6vNZfWiqwVp6GUU5HlgS89F7NxRi6mqmp2epN84LqbHDQo1id6Vf1vaI1HU
         OBah6AkM/lg9IYqVFGLz05R5O6L301W1SmMcH4AftvkCFW/Wy8Kf93rWSrb/mh5lsjVG
         iM8OHkC6xbt1dPExwGlbIqEW4g7xzgWiXJL2IL5lrsn2JPrUFAB6r4Mr9asznuj9zYIj
         V8Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741170483; x=1741775283;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=trVCMKE7HG2WIAeh6lPmuLGb/xVwY5hELogdeFe7gl4=;
        b=pd/Ro8kMESCaIKpip7SHZbQ9WUSzSc92X28M4lSORrm6V0AYbA0fxR/bnWTtmKyQGq
         Bq4P0zkEdJqWIacSZBnNsATrWyuJI6iXS5PyCyKhqlWRPHurmlMb5jYZs04GqAqgDHat
         7TxQwawhfbxFas/+yVe6URfU2C3UhcGSEoQSL/wdSBrPt41ljI+IrdykeS+wCZdrSaJi
         uDfjryclGpuP69isUK07ukMvFQO0kLarMbAfgolF5UXAfYIQYydw5bgrug7QA/mAlYCL
         lEflltbtQgTToD9KFt95FGt7QwSu2l2wSoNzbIgrezeXNcbuaZQb/1QV22k+2BdUCXBx
         FY7A==
X-Gm-Message-State: AOJu0YzLpAtzg0o3V6JiMeZQAz4CCP7oRmisRuXlaDUH5vGTMnZml38f
	WMGs5af43gi8CODWUlViaCnhgnV4K8IcEvM74Iosd9MJrNJnVXvpdkISxw==
X-Gm-Gg: ASbGnctY+ADTdftgLrmkq1VNvRvWnJUMjUNDlEdYdf+3GaMsgyo9eNfQ0lpSg6iCEiX
	iXBLId0UQ91XjXNFRfYUF7OH7X7dGxnrmaQaocPfj3le3+5JCOwpIDEfPXnKBrl9adQFl8U0QZX
	tbit+3xTiO5GVmjzOYPCvkLHaOHiK3Q3mNbgEPRBfuw65kpcVs2QeegWzf+d2mc7kqL+oHYsE+N
	Q/zv9MhlsLiNIvsksfGfk86bLqiKRd9gP5WVE1GokX99B9hyEGpH4t5W68bxo+ehRd/l0bQqUu/
	OKcfx7WNWSnHheSXNgIqnPVFcv1hm1SgE0dPg6SOT7R8IC0I92A=
X-Google-Smtp-Source: AGHT+IE2r0UU7DyXQWVVb3UEv3kbiuqbtvEyxYVscdzn1QzYP09e40Lwstvq+Nv7xlXVf9ErwQt4xA==
X-Received: by 2002:a05:6a00:8d1:b0:736:55ec:ea94 with SMTP id d2e1a72fcca58-73682caa339mr4546208b3a.20.1741170483421;
        Wed, 05 Mar 2025 02:28:03 -0800 (PST)
Received: from dw-tp.ibmuc.com ([171.76.80.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7364ef011c1sm6252768b3a.111.2025.03.05.02.28.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 02:28:02 -0800 (PST)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linux-xfs@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>,
	"Darrick J . Wong" <djwong@kernel.org>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [PATCH v2 3/3] xfs_io: Add RWF_DONTCACHE support to preadv2
Date: Wed,  5 Mar 2025 15:57:48 +0530
Message-ID: <e071c0bf9acdd826f9aa96a7c2617df8aa262f8e.1741170031.git.ritesh.list@gmail.com>
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

Add per-io RWF_DONTCACHE support flag to preadv2().
This enables xfs_io to perform uncached buffered-io reads.

	e.g. xfs_io -c "pread -U -V 1 0 16K" /mnt/f1

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 io/pread.c        | 17 +++++++++++++++--
 man/man8/xfs_io.8 |  8 +++++++-
 2 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/io/pread.c b/io/pread.c
index b314fbc7..79e6570e 100644
--- a/io/pread.c
+++ b/io/pread.c
@@ -38,6 +38,9 @@ pread_help(void)
 " -Z N -- zeed the random number generator (used when reading randomly)\n"
 "         (heh, zorry, the -s/-S arguments were already in use in pwrite)\n"
 " -V N -- use vectored IO with N iovecs of blocksize each (preadv)\n"
+#ifdef HAVE_PREADV2
+" -U   -- Perform the preadv2() with Uncached/RWF_DONTCACHE\n"
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


