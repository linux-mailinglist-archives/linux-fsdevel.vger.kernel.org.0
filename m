Return-Path: <linux-fsdevel+bounces-22877-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 916E991E0F4
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jul 2024 15:38:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CDC4283BDA
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jul 2024 13:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7601815ECF5;
	Mon,  1 Jul 2024 13:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="QLfX1fv3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 760C815E5CB
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Jul 2024 13:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719841105; cv=none; b=s5cmfdLKm3QSyah1jpvuRZybVu7QaqsRZV1nZVt1UQULaRHYIptig+egr7dSRFiJ/W7WgS9l+Vx+uhqnfmLsW1R6lP5yaGgOzR7AE29UhVPdI38qaFuB0PBiU3yR4gVPXpnjxKdZ4C9o1et0hHiKlMnxg2mzWXWcVaXEkimcxGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719841105; c=relaxed/simple;
	bh=BFanlAoplhXB32nHdBmpMI6luiZgUHiBK8sibXwrz24=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nUhYSa2ZYu0pEAyqaZBugpCR59upiLWF9IyeBFhTkTLKwUbjZuNVceAYqOoPLsnwzd1h1upihKg3Flv2m9XMTNZrGcOU14MlG5XpBp1r56tzHCS7xh3WcYuyHY0ibGS1gE2Aa1KYjLWB1ZIrwI/EDbhRxhq6CdXDUCSfk4jhxkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=QLfX1fv3; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-446428931a0so13749711cf.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 Jul 2024 06:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1719841103; x=1720445903; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c4P/yJAkaSXXR4DaG+3Op6nTns3gB2UojJv70Msaqo4=;
        b=QLfX1fv3xVavTYcvomEZN4TIAtIh5J7Rt08Cuv+CUYWW+kgzd8CPd5ttkmFrXqfCR9
         Caj/0KoxrIpMd8q+LFB2XxHVWoiciwF7o27nVS4Y87jRiJ/bg9xq89CvpNJ2QYe4sjG5
         NGwShMv4SgrQzC1E9sHIBkjm7A+GYyBcW5WqUaY1r6YWeJX8eRSRNbNjaCKXHWvyhTQv
         Wa63xZfcSbAhZMFA8MBNkDRhwOW1jJhnSw54eidGt8g2pcNTKj2f55vURUt0GY5beexE
         GEFHHikJ4Mx9FE7xbwZwXY4ZeHCiW9m1UISwtBIxP/NckKcY70E8OI6+8ZfVurJ8Fykr
         iHTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719841103; x=1720445903;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c4P/yJAkaSXXR4DaG+3Op6nTns3gB2UojJv70Msaqo4=;
        b=c8wgXHUpocTQHx7Gf/ikVexhSuiHUgmRisuzxLkYUso4gp3i0jbwY5o6pjftDsHl5b
         O6sFzTXbPrVrcJga5pEotXkYzSs5s9Rwevv1rkc0F6qbAhN584qXHF2+c4+RcpUfMMrI
         C+uDZfWyYwG0aqXl1TibD/fnhHCq3bWN6wkuqoVyV1kuPl/xnA9bE4WeQhk2ILU4cs08
         s++9RMWSacDmFA2c/NtgK8RegK8erKjk5DCRdF9SjXV2EfRcE1IpIOFfcKW+/EHFyrAH
         lyIkUChG504K9sMrcIoDu063hKWUUND+WsVPFrE0bvhzgeXjaeKn61rD3THjeEPTbrxG
         m+7Q==
X-Forwarded-Encrypted: i=1; AJvYcCX9nK2nu+YDahzwj9B+hX21Wg5oPinKzw2p5JLIfbw2w2NwKRTwo132GtcGEVj0WoL4yqr7p+ZaL+CqrmzsrlBNig4rJx2sgTbDM9DsRQ==
X-Gm-Message-State: AOJu0Yx3PJGmDLX7e4X9mqtbNmEmOMGPlN3wTXDQ6CneB3YIvcRoHCs+
	ju6H7yifFRrDLSk9xbgNf9XCJiSipb5hGoYhteKEcX+U7FVZEBdOjaNAyYm4LU8=
X-Google-Smtp-Source: AGHT+IFp2eHJVaMHHJ/1hqixa/EbB/20l1IrMRxZuH2IWPlIoOLg1ieJLGwTB/0BuAkmy/PHQnWNqA==
X-Received: by 2002:a05:622a:589:b0:440:657c:7e60 with SMTP id d75a77b69052e-44662e4c07fmr59260711cf.21.1719841103432;
        Mon, 01 Jul 2024 06:38:23 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-446513d3d3dsm31293691cf.5.2024.07.01.06.38.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 06:38:23 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: alx@kernel.org,
	linux-man@vger.kernel.org,
	brauner@kernel.org,
	linux-fsdevel@vger.kernel.org,
	mszeredi@redhat.com,
	kernel-team@fb.com
Subject: [PATCH v4 2/2] listmount.2: New page describing the listmount syscall
Date: Mon,  1 Jul 2024 09:37:54 -0400
Message-ID: <4e503bc4298e648ada65d1276bd494133c7d99c5.1719840964.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1719840964.git.josef@toxicpanda.com>
References: <cover.1719840964.git.josef@toxicpanda.com>
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


