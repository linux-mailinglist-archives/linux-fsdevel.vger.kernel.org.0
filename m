Return-Path: <linux-fsdevel+bounces-22527-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A8C7B918665
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jun 2024 17:57:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33D241F22D16
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jun 2024 15:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 174DFEEDD;
	Wed, 26 Jun 2024 15:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="NkVG6Tr6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 180C618EFC0
	for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jun 2024 15:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719417414; cv=none; b=QbHX1/4vxHqtuxp3+QbmqHRaCWqI44+uGNVQOT/B9+3LnSP5V8eqZZk1DWWMfamvPITV+U6N392NfQjxAdwzcOJjpCmbaxQUzZDEBXQrGKv0wJcRkFDI3biiS9CPs7++b+uDcIewHOLmVrSlB7yDLTGW8FuLJNHIggffFPTWFUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719417414; c=relaxed/simple;
	bh=A+yHe0ceQT8ZgEDbc5qYM4e9GtmAta2qO4IpV3DPLps=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GMRBJk/zQjf199zXOMR0Y32sDwLXxvRb2vpvwoxSGSWwHTMUK6+Zk8CvbUVHE6yrtBQyyWrjqOAQnGwF+DPiKwM4OkrT94dk3pDD2MTWZlUVj/qdytk43HGbD8kilP1Y+t+mF3jCldmCcMIllqyHzRgWBsVgJPCA8Lz3H6BdvwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=NkVG6Tr6; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-79c06c08149so102298785a.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jun 2024 08:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1719417412; x=1720022212; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=10WXgcGJ8V7XA6aqCXiHxcPSg/sBDgQ5k80z5AUhucU=;
        b=NkVG6Tr6MjUZZ8id+RnGX9vYacVtwwWT/OuksXaOpH3B6tknyxK6HkzAP53eAk9tpF
         BcA3ZlfRchfDFu92idUV9R8QwOorl7IdiOy66kss1VVI7YMLkLCrAATxNW/3KbvfZWBW
         Qvfz1kgZ+pRVa2E0ov7XsZxBPdAivTioN4m7l8leS1FYjLM040D6RjSdWdRrY2FdU1bA
         RifDsEYfaDt4LpN4OthiJfrDUkZALLayjhiQ8fUmBmTUgncz7TMxixK1/h+HcO2qfq17
         88cKJOwdy4l1IpRmB6JRnTFykKYoHmXuHm9jA9zueyGclA1PR7qxSQqBlJ0mZ8+L0/n+
         Q/cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719417412; x=1720022212;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=10WXgcGJ8V7XA6aqCXiHxcPSg/sBDgQ5k80z5AUhucU=;
        b=vJAx73wV0WyisPVu21+koBrmUhm6vGkMhgPzSOh+p1qbGyXC6bCB0H5ej/Vx/F/rBZ
         bJJVZnSelzI9PBS7qs511ma2CH9Fi3WETVD29R43tPw/lzkUmGkn1YWc+/uvwu8F6fwz
         hAlsRlQx/usVHVNeMKiiYpn+yoM+CA7kI+7KqlzMDEHk79BwOCpq7CwTx+PvI6CSeC0G
         nIyJOXaHXZvdWuNa/+LRGM5bZp4FFi14ICuPtwG3yozzjumcxMjX1SU28sel6zorEJy3
         oJUa8Q5+kKRUK+YdM3iJ1NzTSBTkRDB+TxreKnNxUplWgYsxufkYoe3Pz6iRtlFNTV5Z
         oEgQ==
X-Forwarded-Encrypted: i=1; AJvYcCV/AA7y8QBfUWb3dDDKrx54OHdmUfL+pRfYS915Y2TqQrXBaPNa8JDUK4gwIeWemwtemyGiCEeuQjiQHKvMPsVyvu8mXqboU1gtmuzVKA==
X-Gm-Message-State: AOJu0YzGdAMl5/z2DIE9dStCyqlz/OjaNVfvXwmZvDzZP1OmfwDkhvkX
	0ywIPttfkOAkBHegbNS/dVpdySlZdmi/u8zmyni1xqBnU0u4OHctuJrSJhFAZYtdwazH5JlZ7wo
	N
X-Google-Smtp-Source: AGHT+IHChebJBTl3JTXJ9gtlPz1P7nas/qckMxRBEzsORxOm2x2GIZaGeDtCJhf/VIRcG/UJhGfCyw==
X-Received: by 2002:a0c:cb08:0:b0:6b4:fbec:952f with SMTP id 6a1803df08f44-6b53bcd3e9bmr117767176d6.25.1719417411922;
        Wed, 26 Jun 2024 08:56:51 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b51ef32f9csm55814036d6.91.2024.06.26.08.56.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 08:56:51 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: alx@kernel.org,
	linux-man@vger.kernel.org,
	brauner@kernel.org,
	linux-fsdevel@vger.kernel.org,
	mszeredi@redhat.com,
	kernel-team@fb.com
Subject: [PATCH v2 2/2] listmount.2: New page describing the listmount syscall
Date: Wed, 26 Jun 2024 11:56:08 -0400
Message-ID: <fd4fc27f121664feeabb891990c19d173603b01e.1719417184.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1719417184.git.josef@toxicpanda.com>
References: <cover.1719417184.git.josef@toxicpanda.com>
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
 man/man2/listmount.2 | 114 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 114 insertions(+)
 create mode 100644 man/man2/listmount.2

diff --git a/man/man2/listmount.2 b/man/man2/listmount.2
new file mode 100644
index 000000000..4e046ef39
--- /dev/null
+++ b/man/man2/listmount.2
@@ -0,0 +1,114 @@
+'\" t
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
+.BI "            unsigned long " flags " );
+.P
+.B #include <linux/mount.h>
+.P
+.EX
+.B struct mnt_id_req {
+.BR "    __u32 size;" "    /* sizeof(struct mnt_id_req) */"
+.BR "    __u64 mnt_id;" "  /* The parent mnt_id being searched */"
+.BR "    __u64 param;" "   /* The next mnt_id we want to find */"
+.B };
+.EE
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


