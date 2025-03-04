Return-Path: <linux-fsdevel+bounces-43088-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EDA9A4DD2F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 12:57:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4AE377A4D31
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 11:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D84AD202F67;
	Tue,  4 Mar 2025 11:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zmf8xNNA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD706202C53;
	Tue,  4 Mar 2025 11:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741089365; cv=none; b=kuhGAWLOuyELwLXi3hjbtPF5TnepWxIq4Akr1pOVKpKe1Jo/l+wLod47xYdznJtiWTxH5UMjawyFEGAibSB5iTYWsK3h5duFmumy2ocP6xsNSzhrxOJ+28mTBgnw3m5Fa06S1i8wQHd5YSMjuE4qM0JV5eFXDCocuAfeXW+q2Zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741089365; c=relaxed/simple;
	bh=covBOvnp9U2GZTtmioJd31CmPfKsqA23Z8qUeQ8Rsuc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MJgDU7PYV9zMF92vgR0LskdlxVbJAPJCzWGenL5VCpU+25+g+XPI9KlRVWVAglpKU7tNIwm8++fqZjiVcTtghRhM1p40zG8GNzMzSwNHTt+TSwtoxs1Qigh39HKr/GCp8MUxwtzm7Vgst0Btl4k4wX9U/+1N1DIcZ1DH1UjMltk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zmf8xNNA; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2232aead377so106734725ad.0;
        Tue, 04 Mar 2025 03:56:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741089363; x=1741694163; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xxAqpP0ovEprhHiBJr2y/st3WpGGcsBAKP5Mc83hkVA=;
        b=Zmf8xNNA8taTDvjaevJIDsriEba1VjY/xL69/Mp59lSyrUFKD50AhYAL4N0u9oVuJC
         WPQMR904yqNjq8/dQDXjOEK63hob8FGTtmGPVDStSwsYtmCASa2LSey0X8C7q1vPfzdh
         rgPesUsKD9+8ZDj8NBBzgNyOc528OQP13l7oOG3AM/LyzEQoLNL/g8JTQ7S4AIOSTFaq
         EUApQHJrd34OkTrtna70W4wtgkphoz8ZnVPKZ3n2myO5akto+oE56LeH6gemMj1EeW9D
         uCC8YIZt+sWoAZ2pvVUja9on8ByDpbSkr0gtdUiwdtNQaoeKvR4MOdDSw7/83QGhSvgJ
         pdXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741089363; x=1741694163;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xxAqpP0ovEprhHiBJr2y/st3WpGGcsBAKP5Mc83hkVA=;
        b=YQcqDrHTJoBqQf7nKDG11Ui8MaYU1ff4S2Lr0QGdGU53YSZZRYnd03IQyWbHGIuojk
         CkHjO74guWRAp9FlY/86WsVoWAHSupN/n2Bgrrxxc5NdNK6uZhSiY5ciODRYFkDKjrME
         K3WItMd1HXyN5A4ODklkASayZQymdoOFxe6TI12dxGLyubC2/b19XC0UjHWbmjT9dNTf
         whnNtL6KDFrc0HduOm+57Ly6C7R5genIqH/DI14WsnxqJlJJG7lp3viJbNxcBXEZYfyE
         oCuiO1tdHDDomdqmLwNeeFtCAcYYuZcHEF3kLD3hN8bnw+3vexNgQlw02HlD5ywLZu4H
         0Kxg==
X-Gm-Message-State: AOJu0YxCYRajezQgxqzlN3+l//gsI7O+Jk6fum9vPEAGsnBzhu91e0Ab
	1J72f5xKOikvVW/3i1bhSAQXv4CvBge0388Z8OoSZH1xv6QMGBPbXXi9+R5Y
X-Gm-Gg: ASbGncsu04faYr44hCPne9EvjHHZbWvJ/PzHc14ZlaE00g+nys8DQ0KFTLaZ+K4GDhr
	YjyUBJch6gENx9ekgLZ4E0TdbZUbLQ1QfRYeBlNvodhWjS4JsM2zwWgsKManjUUGVsjPBQQ3Y6h
	fJorku9t9FXhhsk9PnEj45+Nznb5s16qeTVAVn59bV6hm+urnlyVJfAyL923a7gTsvbjKvGxSiv
	WXFjPgVPInJPwSmyetUfb57exwTKpZDJ1DcZnzDb4/MZNkh8z2wegeFTyjxMfSkfDBhGIp1/pzf
	h8fqdOWc2JtOvYgz+YBZIgGnSli22dyJ2SQAkpL6Aiud4t5bXp0=
X-Google-Smtp-Source: AGHT+IHHPBr9NiMrYgPGqpuLs7kZQV8wWHCZfDlZqK6ST2PH67P8g2Z4Ep+ZjOJ1VoBQ0Nvk8G9Dcg==
X-Received: by 2002:a17:902:f68f:b0:223:3253:2812 with SMTP id d9443c01a7336-22368fa557amr232106565ad.27.1741089362602;
        Tue, 04 Mar 2025 03:56:02 -0800 (PST)
Received: from dw-tp.ibmuc.com ([171.76.80.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223501d28desm94154565ad.16.2025.03.04.03.56.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 03:56:02 -0800 (PST)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linux-xfs@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>,
	"Darrick J . Wong" <djwong@kernel.org>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [PATCH v1 3/3] xfs_io: Add RWF_DONTCACHE support to preadv2
Date: Tue,  4 Mar 2025 17:25:37 +0530
Message-ID: <19402a5e05c2d1c55e794119facffaec3204a48d.1741087191.git.ritesh.list@gmail.com>
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

Add per-io RWF_DONTCACHE support flag to preadv2()
This enables xfs_io to perform buffered-io read which can drop the page
cache folios after reading.

	e.g. xfs_io -c "pread -U -V 1 0 16K" /mnt/f1

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 io/pread.c        | 12 ++++++++++--
 man/man8/xfs_io.8 |  8 +++++++-
 2 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/io/pread.c b/io/pread.c
index 782f2a36..64c28784 100644
--- a/io/pread.c
+++ b/io/pread.c
@@ -38,6 +38,9 @@ pread_help(void)
 " -Z N -- zeed the random number generator (used when reading randomly)\n"
 "         (heh, zorry, the -s/-S arguments were already in use in pwrite)\n"
 " -V N -- use vectored IO with N iovecs of blocksize each (preadv)\n"
+#ifdef HAVE_PWRITEV2
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
@@ -514,7 +522,7 @@ pread_init(void)
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


