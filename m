Return-Path: <linux-fsdevel+bounces-23426-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00C3F92C25F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2024 19:26:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 242841C22F03
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2024 17:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7428117B02E;
	Tue,  9 Jul 2024 17:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="U7ehqawY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8478F17B029
	for <linux-fsdevel@vger.kernel.org>; Tue,  9 Jul 2024 17:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720545988; cv=none; b=sQ7tWcq8bLNUDTdxnFmNcuEgCSjXyPByNtfzT/QvIugJD3yoZ43krr/4puarit5psKA6OKInM7gXhg+/i5GuTXgWDFLLNlrxZOO/9KodT7o6gnSS6ggafOElVYj+65sZgtqAt5uUuAAZVVETbe4cC0JHy5xHFmYV2EwuKKP4XR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720545988; c=relaxed/simple;
	bh=BFanlAoplhXB32nHdBmpMI6luiZgUHiBK8sibXwrz24=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kcCwsoYuOhqbpa9kdcpkvXPvURMT4YUvLrSt4XVAdcxCyL/Yz2eaB5jGr4K+U4KyV3wsZkI2Gm9A8CFXsvyTqI73jSGW7sx0K4bQkAhICs7HNxHl/m6GzxDXRr4jrMXU5yfETlSFpl9IMKnLWMc67p0J4UfAgRJDISUB752oAgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=U7ehqawY; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e02c4983bfaso5636234276.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 09 Jul 2024 10:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1720545986; x=1721150786; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c4P/yJAkaSXXR4DaG+3Op6nTns3gB2UojJv70Msaqo4=;
        b=U7ehqawY+Ik1Q8rSHxV0jtlApxTTkBkd8njDjgIfOdKp6beZms1W2mMnuRXbc1o1Fg
         F0pC64fPrteVBAPHb6eb3x1gdvBKo6T5Tr9TljRjmK+bzCc419LC1b1SMjcFCEc1YgNm
         aXKywPryUxf+7NHDN3JJ9Um+LPUJt5aKdbBylAEL6Ntfh+a6zqxaaeN0s4fmGc7C1b9o
         DYOdHJrSmpqwZovesUMaIkl4a5jeCVXU+QcrIK6KE3AdrPsP/p2d2ISJufpIOtKc6yLM
         NuLy+VavPYgUBqfD+H2YFxyunEXO+tqc+3Xmb42Se2v6fShNFLubdgetXXzQvGMvzuDq
         aHSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720545986; x=1721150786;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c4P/yJAkaSXXR4DaG+3Op6nTns3gB2UojJv70Msaqo4=;
        b=AfWgGNSV9VZItgqTYW5Bvk0CLSmfvSe65gwn8afs93cp8MLSOrgf69F8Z7mGR6Vp/W
         dSYVlcMKzLrGqlXxRA3WW5zzsoCPBl09KliX5xHHrGxIeSt5/W3+tM0LFgTkw5pFAsjU
         EoJYhPSdQkunKQUSiUc7RX/0H9eInco5VphHSd2FKXX33yMBDkRroqld+tzvbNXs2Jp9
         oXnfCdcDpxXomIqFPeLqgfylvdG65D8LQrn/VhVyo5JwSTI2S0JVIM7jagvJcSUn3dzJ
         UrLUa20yvmXq51f/2F7ZMdPTWeZ3HdR2IxMyKz8Nv/EDaJtX+FpxdpFtD59ItFgwQcEV
         VNEQ==
X-Forwarded-Encrypted: i=1; AJvYcCXXrlMGa8XcHUAgbRhPBZMx2TEVm33NaP3D3mtnQl07KqYfszR/99mq/UHtUTXJm9stae9ZO73xKF+sr84q7GtL4P0OzFzx7MiQbb5FIw==
X-Gm-Message-State: AOJu0YybnCB22jpvI6qkM/k7rio7DjXUGmHFBtz0df9T83zAfUvmDMiQ
	xlcoxMAF3FwUA7Mi1Kegq1YOHDVsFQU09qn8riozHOQNgSADFLLzo2D6NI7xVDI=
X-Google-Smtp-Source: AGHT+IGAxr2aUBPSV4enl6qtFr0ZiBojJKpAy9NqZ73ON4JcG0iG3KeUYGs0sTbyCtrAQYgREIfj7g==
X-Received: by 2002:a25:d80f:0:b0:e02:7d67:c5ce with SMTP id 3f1490d57ef6-e041b096637mr3610803276.22.1720545986544;
        Tue, 09 Jul 2024 10:26:26 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79f1908ae8csm115085985a.88.2024.07.09.10.26.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 10:26:26 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: alx@kernel.org,
	linux-man@vger.kernel.org,
	brauner@kernel.org,
	linux-fsdevel@vger.kernel.org,
	mszeredi@redhat.com,
	kernel-team@fb.com
Subject: [PATCH v5 2/2] listmount.2: New page describing the listmount syscall
Date: Tue,  9 Jul 2024 13:25:43 -0400
Message-ID: <9e16975fb6cb9baf11e485368cfcbbbd5fb87207.1720545710.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1720545710.git.josef@toxicpanda.com>
References: <cover.1720545710.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add some documentation for the new listmount syscall.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 man/man2/listmount.2 | 111 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 111 insertions(+)
 create mode 100644 man/man2/listmount.2

diff --git a/man/man2/listmount.2 b/man/man2/listmount.2
new file mode 100644
index 000000000..a86f59a6d
--- /dev/null
+++ b/man/man2/listmount.2
@@ -0,0 +1,111 @@
+.\" Copyright (c) 2024 Josef Bacik <josef@toxicpanda.com>
+.\"
+.\" SPDX-License-Identifier: Linux-man-pages-copyleft
+.\"
+.TH listmount 2 (date) "Linux man-pages (unreleased)"
+.SH NAME
+listmount \- get a list of mount ID's
+.SH LIBRARY
+Standard C library
+.RI ( libc ", " \-lc )
+.SH SYNOPSIS
+.nf
+.BR "#include <linux/mount.h>" "  /* Definition of struct mnt_id_req constants */"
+.B #include <unistd.h>
+.P
+.BI "int syscall(SYS_listmount, struct mnt_id_req * " req ,
+.BI "            u64 * " mnt_ids ", size_t " nr_mnt_ids ,
+.BI "            unsigned long " flags );
+.P
+.B #include <linux/mount.h>
+.P
+.B struct mnt_id_req {
+.BR "    __u32 size;" "    /* sizeof(struct mnt_id_req) */"
+.BR "    __u64 mnt_id;" "  /* The parent mnt_id being searched */"
+.BR "    __u64 param;" "   /* The next mnt_id we want to find */"
+.B };
+.fi
+.P
+.IR Note :
+glibc provides no wrapper for
+.BR listmount (),
+necessitating the use of
+.BR syscall (2).
+.SH DESCRIPTION
+To access the mounts in your namespace,
+you must have CAP_SYS_ADMIN in the user namespace.
+.P
+This function returns a list of mount IDs under the
+.BR req.mnt_id .
+This is meant to be used in conjuction with
+.BR statmount (2)
+in order to provide a way to iterate and discover mounted file systems.
+.SS The mnt_id_req structure
+.I req.size
+is used by the kernel to determine which struct
+.I mnt_id_req
+is being passed in,
+it should always be set to sizeof(struct mnt_id req).
+.P
+.I req.mnt_id
+is the parent mnt_id that we will list from,
+which can either be
+.B LSMT_ROOT
+which means the root mount of the current mount namespace,
+or a mount ID obtained from either
+.BR statx (2)
+using
+.B STATX_MNT_ID_UNIQUE
+or from
+.BR listmount (2) .
+.P
+.I req.param
+is used to tell the kernel what mount ID to start the list from.
+This is useful if multiple calls to
+.BR listmount (2)
+are required.
+This can be set to the last mount ID returned + 1 in order to
+resume from a previous spot in the list.
+.SH RETURN VALUE
+On success, the number of entries filled into
+.I mnt_ids
+is returned, 0 if there are no more mounts left.
+On error, \-1 is returned, and
+.I errno
+is set to indicate the error.
+.SH ERRORS
+.TP
+.B EPERM
+Permission is denied for accessing this mount.
+.TP
+.B EFAULT
+.I req
+or
+.I mnt_ids
+is NULL or points to a location outside the process's
+accessible address space.
+.TP
+.B EINVAL
+Invalid flag specified in
+.IR flags .
+.TP
+.B EINVAL
+.I req
+is of insufficient size to be utilized.
+.B E2BIG
+.I req
+is too large,
+the limit is the architectures page size.
+.TP
+.B ENOENT
+The specified
+.I req.mnt_id
+doesn't exist.
+.TP
+.B ENOMEM
+Out of memory (i.e., kernel memory).
+.SH STANDARDS
+Linux.
+.SH SEE ALSO
+.BR statmount (2),
+.BR statx (2)
-- 
2.43.0


