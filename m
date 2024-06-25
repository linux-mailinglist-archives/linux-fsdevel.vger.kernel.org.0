Return-Path: <linux-fsdevel+bounces-22435-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E8D7E9170C0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 20:57:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17EF81C233EE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 18:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3772617C7C8;
	Tue, 25 Jun 2024 18:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="c0BA4pVc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC7E17BB2E
	for <linux-fsdevel@vger.kernel.org>; Tue, 25 Jun 2024 18:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719341817; cv=none; b=mgdqVMS/GWnMrSvRicfK8iWIpWgIEY3YD9mTdh4DlTGs3RX77Wyewg9jVPB8oYbr8AfaJ15odueZ+CuJ/Sxk23xy2Br/v00z1NJMLlwvD9IGEN790Ab/TxeOfQj/rMjTE8BocNVcHcBPvxSCEKU6gW6fCRNeMeQ1hVb2XqUvvww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719341817; c=relaxed/simple;
	bh=dZPRy9RJldPnzZDsjDXKJfnzD18VM/UJeT5fOs38FqU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WurFwHUXCPWfi0F7oMvoyaVorgCGS2T5DYOQf//k4XBEooA3qHmqob9OmiWKRXHuZvc7+mO9eQty8guzMdCLbwYrMsDPeOoYsxLQNvVq9y94VVfUN8Wy4W9XhG3eQlIEljxhx7VM/6pkxHFz5h8d8XObuZVCzOwoh6HvDOwdsFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=c0BA4pVc; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-79c076c0d83so54452485a.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Jun 2024 11:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1719341815; x=1719946615; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3NXW6nnv/i+alulXxPSqC7wQA1lycPr4EG0b46GZWV0=;
        b=c0BA4pVcj42mGsCI3LO+0ubmKpny7Nq+fxtXFlOfMIwwYMSDHmv9vKx/lxp35cpHFZ
         ibE2APARYWPVssFCmbUnsF6MbAx/GK9H3QiYnYloysmGS4VkzeT22ZgLiaVozhjVychD
         VN8pnxNUnE8Z4AhHdcqbSQar1SmFSCfx19LMHHvFpwWy3hbVgIDqI0dSZJQ91ro9AZp+
         B1Sq6yf/ruUmd2QaAvz/lHUddqAKFTLyRvO+S9EqvTEiiw9kMaBxeZsIa6rkAOdYSzoS
         SSGuy4NWRwAfcNb7/CBJF/ubk3tdyJ9TQIm7glKA3QN9Y5rUId8xBP0mbGIs6ojMJQ6a
         /5aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719341815; x=1719946615;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3NXW6nnv/i+alulXxPSqC7wQA1lycPr4EG0b46GZWV0=;
        b=aTA93aQaSZ+Kh1YqeSnqDbeDd3tU6qM7miAGHtkGv7sXaDJMFJt8+qD/8zvMsYSxAt
         stRPnn2EVL+BDEvxW35jOltW4WOYHBLTzOzQBvwg2nqqubenVUaMr26Ce55RmIgjBCWa
         3vqKYTzny5mqOLJG7+FswjKkUn0BDsV2RURhprSMfGUfRR6Mg9b6ntOfX6HUAMDpMLFF
         wWhaH0ucUuj7QkPgqZ6iAav2t1IIzOQERQ45FS1n0yjYvLjH2ANjikbk91i5KObmTvsp
         kJIT/0AFqlGLYfCkmAayfXTSxLwfLlDz9V/rOwbSo6Qx6DHqY+EzQX7NedWAnddtUI8P
         paEA==
X-Forwarded-Encrypted: i=1; AJvYcCVJR2CHjJmf7RTBVNBK07C1sdMvz7eG+2cHwxHQZzoCTvJQ+StTUMNYK3nX2kuDUyJeEUVqODdH1ulo/vUvr2ZQWn7Au5iE1Gj7vI8Pdw==
X-Gm-Message-State: AOJu0YzHuCouXrTVhjNZDQHqnerCdUiSxJP3luK6DqukG6EvCFPTpEuw
	suBjOy9OaXM7ILaOX8LefOLq/gxeBi264LjHlAzmA2vgBdcxmM4eQc7YUJZE4Z8=
X-Google-Smtp-Source: AGHT+IEq0wcrtmy1hYscKVH2VpvexGWGBLLtfWiegJbPQ61RXGYZ2viI2Y9gaI1Rg7ZwD4yGLiCndA==
X-Received: by 2002:a05:620a:1a18:b0:795:493f:9f3c with SMTP id af79cd13be357-79be6efbb80mr1058050385a.39.1719341814973;
        Tue, 25 Jun 2024 11:56:54 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79bce936027sm432916485a.115.2024.06.25.11.56.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 11:56:54 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: alx@kernel.org,
	linux-man@vger.kernel.org,
	brauner@kernel.org,
	linux-fsdevel@vger.kernel.org,
	mszeredi@redhat.com,
	kernel-team@fb.com
Subject: [PATCH 2/3] statmount.2: New page describing the statmount syscall
Date: Tue, 25 Jun 2024 14:56:05 -0400
Message-ID: <bc242af625a117272e3b7d15a2c55501fea3f7e0.1719341580.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1719341580.git.josef@toxicpanda.com>
References: <cover.1719341580.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add some documentation on the new statmount syscall.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 man/man2/statmount.2 | 274 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 274 insertions(+)
 create mode 100644 man/man2/statmount.2

diff --git a/man/man2/statmount.2 b/man/man2/statmount.2
new file mode 100644
index 000000000..6d9f505f9
--- /dev/null
+++ b/man/man2/statmount.2
@@ -0,0 +1,274 @@
+'\" t
+.\" Copyright (c) 2024 Josef Bacik <josef@toxicpanda.com>
+.\"
+.\" SPDX-License-Identifier: Linux-man-pages-copyleft
+.\"
+.TH statmount 2 (date) "Linux man-pages (unreleased)"
+.SH NAME
+statmount \- get a mount status
+.SH LIBRARY
+Standard C library
+.RI ( libc ", " \-lc )
+.SH SYNOPSIS
+.nf
+.BR "#include <linux/mount.h>" "     /* Definition of STATMOUNT_* constants */"
+.B #include <unistd.h>
+.P
+.BI "int syscall(SYS_statmount, struct mnt_id_req * " req ,
+.BI "            struct statmount * " statmountbuf ", size_t " bufsize ,
+.BI "            unsigned long " flags " );
+.P
+.EX
+.B struct mnt_id_req {
+.BR "    __u32 size;" "    /* sizeof(struct mnt_id_req) */"
+.BR "    __u64 mnt_id;" "  /* The mnt_id being queried */"
+.BR "    __u64 param;" "   /* An ORed combination of the STATMOUNT_ constants */"
+.B };
+.EE
+.fi
+.P
+.IR Note :
+glibc provides no wrapper for
+.BR statmount (),
+necessitating the use of
+.BR syscall (2).
+.SH DESCRIPTION
+To access a mount's status, you must have CAP_SYS_ADMIN in the user namespace.
+.P
+This function returns information about a mount, storing it in the buffer
+pointed to by
+.IR buf .
+The returned buffer is a structure of the following type:
+.P
+.in +4n
+.EX
+struct statmount {
+    __u32 size;
+    __u64 mask;
+    __u32 sb_dev_major;
+    __u32 sb_dev_minor;
+    __u64 sb_magic;
+    __u32 sb_flags;
+    __u32 fs_type;
+    __u64 mnt_id;
+    __u64 mnt_parent_id;
+    __u32 mnt_id_old;
+    __u32 mnt_parent_id_old;
+    __u64 mnt_attr;
+    __u64 mnt_propagation;
+    __u64 mnt_peer_group;
+    __u64 mnt_master;
+    __u64 propagate_from;
+    __u32 mnt_root;
+    __u32 mnt_point;
+    char str[];
+};
+.EE
+.in
+.P
+(Note that reserved space and padding is omitted.)
+.SS The mnt_id_req structure
+.I req.size
+is used by the kernel to determine which struct
+.I mnt_id_req
+is being passed in, it should always be set to sizeof(struct mnt_id req).
+.P
+.I req.mnt_id
+can be obtained from either
+.BR statx (2)
+using
+.B STATX_MNT_ID_UNIQUE
+or from
+.BR listmount (2)
+and is used as the identifier to query the status of the desired mount point.
+.P
+.I req.param
+is used to tell the kernel which fields the caller is interested in.  It is an
+ORed combination of the following constants
+.P
+.in +4n
+.TS
+lBl.
+STATMOUNT_SB_BASIC	/* Want/got sb_... */
+STATMOUNT_MNT_BASIC	/* Want/got mnt_... */
+STATMOUNT_PROPAGATE_FROM	/* Want/got propagate_from */
+STATMOUNT_MNT_ROOT	/* Want/got mnt_root  */
+STATMOUNT_MNT_POINT	/* Want/got mnt_point */
+STATMOUNT_FS_TYPE	/* Want/got fs_type */
+.TE
+.in
+.P
+Note that, in general, the kernel does
+.I not
+reject values in
+.I req.param
+other than the above.
+(For an exception, see
+.B EINVAL
+in errors.)
+Instead, it simply informs the caller which values are supported
+by this kernel and filesystem via the
+.I statmount.mask
+field.
+Therefore,
+.I "do not"
+simply set
+.I req.param
+to
+.B UINT_MAX
+(all bits set),
+as one or more bits may, in the future, be used to specify an
+extension to the buffer.
+.SS
+The returned information
+The status information for the target mount is returned in the
+.I statmount
+structure pointed to by
+.IR statmountbuf .
+Included in this is
+.I size
+which indicates the size of the
+.I statmountbuf
+that was filled in, including any strings.
+.I mask
+which indicates what information in the structure has been filled in.
+.P
+It should be noted that the kernel may return fileds that weren't requested and
+may fail to return fields that were requested, depending on what the backing
+file system and kernel supports.
+In either case,
+.I req.param
+will not be equal to
+.IR mask .
+.P
+Apart from
+.I mask
+(which is described above), the fields in the
+.I statmount
+structure are:
+.TP
+.I size
+The size of the returned
+.I statmountbuf
+structure.
+.TP
+.IR sb_dev_major " and " sb_dev_minor
+The device that is mounted at this mount point.
+.TP
+.I sb_magic
+The file system specific super block magic.
+.TP
+.I sb_flags
+The flags that are set on the super block, an ORed combination of
+.BR SB_RDONLY ,
+.BR SB_SYNCHRONOUS ,
+.BR SB_DIRSYNC ,
+.BR SB_LAZYTIME .
+.TP
+.I fs_type
+The offset to the location in the
+.I statmount.str
+buffer that contains the string representation of the mounted file system. It is
+a NULL terminated string.
+.TP
+.I mnt_id
+The unique mount ID of the mount.
+.TP
+.I mnt_parent_id
+The unique mount ID of the parent mount point of this mount.  If this is the
+root mount point then
+.B mnt_id
+==
+.BR parent_mount_id .
+.TP
+.I mnt_id_old
+This corresponds to the mount ID that is exported by /proc/$PID/mountinfo.
+.TP
+.I mnt_parent_id_old
+This corresponds to the parent mount ID that is exported by
+/proc/$PID/mountinfo.
+.TP
+.I mnt_attr
+The
+.B MOUNT_ATTR_
+flags set on this mount point.
+.TP
+.I mnt_propagation
+The mount propagation flags, which can be one of
+.BR MS_SHARED ,
+.BR MS_SLAVE ,
+.BR MS_PRIVATE ,
+.BR MS_UNBINDABLE .
+.TP
+.I mnt_peer_group
+The ID of the shared peer group.
+.TP
+.I mnt_master
+The mount point receives its propagation from this mount ID.
+.TP
+.I propagate_from
+The ID from the namespace we propagated from.
+.TP
+.I mnt_root
+The offset to the location in the
+.I statmount.str
+buffer that contains the string representation of the mount relative to the root
+of the file system. It is a NULL terminated string.
+.TP
+.I mnt_point
+The offset to the location in the
+.I statmount.str
+buffer that contains the string representation of the mount relative to the
+current root (ie if you are in a
+.BR chroot ).
+It is a NULL terminated string.
+.SH RETURN VALUE
+On success, zero is returned.
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
+.I statmountbuf
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
+is too large, the limit is the architectures page size.
+.TP
+.B EOVERFLOW
+The size of
+.I statmountbuf
+is too small to contain either the
+.IR statmountbuf.fs_type ,
+.IR statmountbuf.mnt_root ,
+or
+.IR statmountbuf.mnt_point .
+Allocate a larger buffer and retry the call.
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
+.BR listmount (2),
+.BR statx (2)
-- 
2.43.0


