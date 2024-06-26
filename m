Return-Path: <linux-fsdevel+bounces-22538-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 094B9918E33
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jun 2024 20:22:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C4B11C2142C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jun 2024 18:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82ED5190681;
	Wed, 26 Jun 2024 18:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="MDujQ5cP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 484D9190486
	for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jun 2024 18:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719426129; cv=none; b=Su21B2YTvcetbg/isXPp3WHM25AB3AQe2BwznZQjUYHtNDNCLqbgO0L/COsN9/j074pBArkGQ8QWfvW361ySYhwnvoLV4lXAywpjqBaaQTrVGwmIYw8u5OydWbk1OtW+Xn+838dwj1+gONZSvi9UlW63g39Kbm99U2O7285oQJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719426129; c=relaxed/simple;
	bh=BFanlAoplhXB32nHdBmpMI6luiZgUHiBK8sibXwrz24=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P7EHGSFXRjtyv2EPYiShu1JQwu7jT1dYjEV/pqc3woki6PZoja26fubIzWPG4p9DO+dJrKIH6oTw9rHccU75StLM6C+1jR0ceqasalT4TWi2ffCUJFrA7E8J1NXo0A2htiDZ6Grf5chDCn2O03nXVlLy+BO0t5QxR/1TCM+KPAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=MDujQ5cP; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-79c0e7ec66dso169191485a.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jun 2024 11:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1719426125; x=1720030925; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c4P/yJAkaSXXR4DaG+3Op6nTns3gB2UojJv70Msaqo4=;
        b=MDujQ5cPqNlnwxIuv3TYerutRACodiqaCExBBOz6kvFZRvpfTHnJDiOaj6OOChGPsB
         3GD7fVPRpaGBBO2+LNzYNj1VsQVzvo3hNau/ftm/NX/UJQdT7Q0oLBJmjhE49Y2aHhYS
         p1YpPE+yopzn8B+AzfGiD+XIqAPj+I0pmAzYfOVNRQ8GQqv05z38o7LxFKVTMMBer6Rr
         1rgG1YDeKESKWZDKaU0vPwmUUR9alEM1AVLOU8WiIfSl264HqzEgsMnzCTrtdH0TJkJU
         dM+66LlUSA0+u38dY0/K2KGDt/12RbgrHbhks3pi6VMqdkrgfkauPf+1WeE6gTUOLJc3
         u/kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719426125; x=1720030925;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c4P/yJAkaSXXR4DaG+3Op6nTns3gB2UojJv70Msaqo4=;
        b=RD5FBI6rpVwKQTKZqVRZNSeditHVwPxowbEVapLXeVQJKMmJATJi+wSBVQNZdnicET
         zwjSNKQn3/Ecqrkg7MlKu8zeYxOaMoCZ+G8ic+s4jaHZ3LDA02dUJfkTBWVafV1OiCHE
         2EeAp535CaNnuSP+YBpHGOdbWobLJhJDCaO2MmaQb8zvLD7/ydS3o20X8YRy2yv7ofMH
         aGpWjImyU6Eex+GCiYmCAqerAV6v4WcMOIdXTPJfY4Ow6ShWSW32B5iVXMTBvXZOkFL6
         GZJPeQraoaT8A5jTQ/NRVw1RhrAIXHuLIRwfwEz+0csdClZ6uOMkWuZqIlnwoBgD/xsN
         sb1Q==
X-Forwarded-Encrypted: i=1; AJvYcCWET7ynaBUPi5F1zH8nu3osPjIWXUvT2lNG1VgF5A9x/sKCggELSa8jkzz7TQ+o6nJ6oIDr4TlY9exRq0RpOevGwNr9HpHJixQJ0zX1mw==
X-Gm-Message-State: AOJu0YxGDgeYcnSjuoRXxoH5DuUPxS2M3dfMOth4+fJ5zGC4OSN+pRtk
	KZaDtAYA+0e2YFsr4iJHJqK76BqRU5efS9Op/zmlqRxofxEqSU5772WkeEI8Hgc=
X-Google-Smtp-Source: AGHT+IEBkZwe5GqwMD1pqZ6QQ/P6BVyzzEPFQq5Ff4iwvzYwbhYTNgH8YVeGz2KtvI9f+v0VRP9lAg==
X-Received: by 2002:a05:620a:4484:b0:79a:2fcb:ed4f with SMTP id af79cd13be357-79be467534bmr1523319385a.13.1719426125207;
        Wed, 26 Jun 2024 11:22:05 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79be05e7410sm384774985a.95.2024.06.26.11.22.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 11:22:04 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: alx@kernel.org,
	linux-man@vger.kernel.org,
	brauner@kernel.org,
	linux-fsdevel@vger.kernel.org,
	mszeredi@redhat.com,
	kernel-team@fb.com
Subject: [PATCH v3 2/2] listmount.2: New page describing the listmount syscall
Date: Wed, 26 Jun 2024 14:21:40 -0400
Message-ID: <40b0cb88a97ac509e57ca46f9ad3f0756827c511.1719425922.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1719425922.git.josef@toxicpanda.com>
References: <cover.1719425922.git.josef@toxicpanda.com>
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


