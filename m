Return-Path: <linux-fsdevel+bounces-23425-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1A9D92C25E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2024 19:26:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6467C1F22240
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2024 17:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 612DF15B116;
	Tue,  9 Jul 2024 17:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="CshDa7jX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B481B86CC
	for <linux-fsdevel@vger.kernel.org>; Tue,  9 Jul 2024 17:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720545986; cv=none; b=Cez0X3oPHqj7k8yu6hQfbd6Ngs5xQ0BKa+IbtxObPPKhW48EkawoDrzfr1j9Rwpcb1Qv8UOPeNYNZ6Noz1Q7NhK7QlevXUrNfxik54PksUY4MntxE/uFsiW5I/43jOCg0oqtqOYyDlm0TrOI4dG94INcwUR3ZArT+j78DNwAfjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720545986; c=relaxed/simple;
	bh=WnrdkYE86HG7YKa964nJnc1AXZ/4ghHqq6l6KtqTOfM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Na27wYih1FVWkeKVG8jI6iS3GRDKmwvD/Ull4o0UvxcS3V9zZADmPK7he7U80uXY/cy5hRfWok6eAKzPKaqOfEsmocvXhQAhFqI6IDMy1+1iY8v7X/jpvb2obPkf46r6KV4WT/bHpptbWAXO2mw8lBoTcvkEkjucNrSpnBWooig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=CshDa7jX; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-4eb02c0c851so1780923e0c.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 09 Jul 2024 10:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1720545984; x=1721150784; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=04YCaOWbymkVGae5k9BCTJTPtgMms6ZHeDoE7LzQCeU=;
        b=CshDa7jXgxJLGE4qjeuwU3hubYiRIZST/Tp16JSpRQsU4ipS/bNoaGAGPPUxGYb6ox
         cWirZbq/gz74OhuVn2FVL0ZSEJ5WMwUTm/Bi/xizk6pbMxZ+vXlUxWqiaokAz++h77hG
         mwbgvm027kHdnWwiiRvdugKueIdnsK/tGV1uyN80M3I9dw7nSII9BQ2/wl7DMTzw3P1U
         oCBAhkktQqKPvDYkp0/CIQvl2TyUqnT9sa3Hn08G4suHpntXDwUBd/Qj9MXu8Zc/4b7F
         hFCMsRlhZqso4vaHk7TeP8C4lwPoMHg2uvqHNTZGAi1UO2jbJxcT6MtC2cNE/FRK8Fu3
         oMLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720545984; x=1721150784;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=04YCaOWbymkVGae5k9BCTJTPtgMms6ZHeDoE7LzQCeU=;
        b=G8oXEPYuOKPbVlRvU9VBQbv7Gx4fI5Mrf6LwSVEywtySAO1utjkR1nrH2lwB6D+ym1
         gpwfUs8OFnkeXFS8usPVGlIGPKUzIkUab7WM9oms3MmorMJ7KV8RjjBUTp4p2Zigl6ym
         kRbpXvoM4nfm7CTgKEeOWwFw0L7LbsAlEf4N+jwy6dpgKvZTFygThy0qTF2RVKMyTkDT
         bv+RLBcolDtZs4Y0BUJa/gbEigDS3LBpsJIYaeY6rf3TRD07ueLf6GCXZlb+RVS9z2ES
         cmW6zOLq2lyTPXAQfJFCDKfHqdkhwlCVdlKYjKiUPuxGcUM0cbGoQzUQEIXK4dGIdFA7
         eflQ==
X-Forwarded-Encrypted: i=1; AJvYcCVDqOlNsCUjDQakp57UZkgJ2KpoiaF8L64wGUt74mX4NH04YD7Fd0jac0SRTsHZjxmESJIVI2jDrzIW/f03qUBr3aXbn3jwtLUm3Pjpgw==
X-Gm-Message-State: AOJu0YxPpIt3CsiGPegJmz3Ml+rpFRJcyEEf1JGS++j6irhad4MnyB6D
	lyK6Fn19zfnQljuaz0f6U6H9SW0hZ7qBZ0QgPs14ao4MRcqU3eZXXkAR17dOdVE=
X-Google-Smtp-Source: AGHT+IFmTd7q5nyyhhZZjlK9LQm13EhPSwCsiOU7h03GHONVj20hpFxNqqVIR0JqUXJRgy+TuOAVrw==
X-Received: by 2002:a05:6122:4695:b0:4ef:5744:46a with SMTP id 71dfb90a1353d-4f33f178c42mr3926410e0c.1.1720545984008;
        Tue, 09 Jul 2024 10:26:24 -0700 (PDT)
Received: from localhost ([76.182.20.124])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-447f9b26badsm12373541cf.17.2024.07.09.10.26.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 10:26:23 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: alx@kernel.org,
	linux-man@vger.kernel.org,
	brauner@kernel.org,
	linux-fsdevel@vger.kernel.org,
	mszeredi@redhat.com,
	kernel-team@fb.com
Subject: [PATCH v5 1/2] statmount.2: New page describing the statmount syscall
Date: Tue,  9 Jul 2024 13:25:42 -0400
Message-ID: <009928cf579a38577f8d6cc644c115556f9a3576.1720545710.git.josef@toxicpanda.com>
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

Add some documentation on the new statmount syscall.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 man/man2/statmount.2 | 280 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 280 insertions(+)
 create mode 100644 man/man2/statmount.2

diff --git a/man/man2/statmount.2 b/man/man2/statmount.2
new file mode 100644
index 000000000..c437ea685
--- /dev/null
+++ b/man/man2/statmount.2
@@ -0,0 +1,280 @@
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
+.BR "#include <linux/mount.h>" "  /* Definition of STATMOUNT_* constants */"
+.B #include <unistd.h>
+.P
+.BI "int syscall(SYS_statmount, struct mnt_id_req * " req ,
+.BI "            struct statmount * " smbuf ", size_t " bufsize ,
+.BI "            unsigned long " flags );
+.P
+.B #include <linux/mount.h>
+.P
+.B struct mnt_id_req {
+.BR "    __u32 size;" "    /* sizeof(struct mnt_id_req) */"
+.BR "    __u64 mnt_id;" "  /* The mnt_id being queried */"
+.BR "    __u64 param;" "   /* An ORed combination of the STATMOUNT_ constants */"
+.B };
+.P
+.B struct statmount {
+.B "    __u32 size;"
+.B "    __u64 mask;"
+.B "    __u32 sb_dev_major;"
+.B "    __u32 sb_dev_minor;"
+.B "    __u64 sb_magic;"
+.B "    __u32 sb_flags;"
+.B "    __u32 fs_type;"
+.B "    __u64 mnt_id;"
+.B "    __u64 mnt_parent_id;"
+.B "    __u32 mnt_id_old;"
+.B "    __u32 mnt_parent_id_old;"
+.B "    __u64 mnt_attr;"
+.B "    __u64 mnt_propagation;"
+.B "    __u64 mnt_peer_group;"
+.B "    __u64 mnt_master;"
+.B "    __u64 propagate_from;"
+.B "    __u32 mnt_root;"
+.B "    __u32 mnt_point;"
+.B "    char  str[];"
+.B };
+.fi
+.P
+.IR Note :
+glibc provides no wrapper for
+.BR statmount (),
+necessitating the use of
+.BR syscall (2).
+.SH DESCRIPTION
+To access a mount's status,
+the caller must have CAP_SYS_ADMIN in the user namespace.
+.P
+This function returns information about a mount,
+storing it in the buffer pointed to by
+.IR smbuf .
+The returned buffer is a
+.I struct statmount
+which is of size
+.I bufsize
+with the fields filled in as described below.
+.P
+(Note that reserved space and padding is omitted.)
+.SS The mnt_id_req structure
+.I req.size
+is used by the kernel to determine which
+.I struct\~mnt_id_req
+is being passed in;
+it should always be set to
+.IR sizeof(struct\~mnt_id_req) .
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
+is used to tell the kernel which fields the caller is interested in.
+It is an ORed combination of the following constants
+.P
+.in +4n
+.TS
+lB l.
+STATMOUNT_SB_BASIC	/* Want/got sb_* */
+STATMOUNT_MNT_BASIC	/* Want/got mnt_* */
+STATMOUNT_PROPAGATE_FROM	/* Want/got propagate_from */
+STATMOUNT_MNT_ROOT	/* Want/got mnt_root  */
+STATMOUNT_MNT_POINT	/* Want/got mnt_point */
+STATMOUNT_FS_TYPE	/* Want/got fs_type */
+.TE
+.in
+.P
+In general,
+the kernel does
+.I not
+reject values in
+.I req.param
+other than the above.
+(For an exception,
+see
+.B EINVAL
+in errors.)
+Instead,
+it simply informs the caller which values are supported
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
+as one or more bits may,
+in the future,
+be used to specify an extension to the buffer.
+.SS The returned information
+The status information for the target mount is returned in the
+.I statmount
+structure pointed to by
+.IR smbuf .
+.P
+The fields in the
+.I statmount
+structure are:
+.TP
+.I smbuf.size
+The size of the returned
+.I smbuf
+structure,
+including any of the strings fields that were filled.
+.TP
+.I smbuf.mask
+The ORed combination of
+.BI STATMOUNT_ *
+flags indicating which fields were filled in and thus valid.
+The kernel may return fields that weren't requested,
+and may fail to return fields that were requested,
+depending on what the backing file system and kernel supports.
+In either case,
+.I req.param
+will not be equal to
+.IR mask .
+.TP
+.I smbuf.sb_dev_major
+.TQ
+.I smbuf.sb_dev_minor
+The device that is mounted at this mount point.
+.TP
+.I smbuf.sb_magic
+The file system specific super block magic.
+.TP
+.I smbuf.sb_flags
+The flags that are set on the super block,
+an ORed combination of
+.BR SB_RDONLY ,
+.BR SB_SYNCHRONOUS ,
+.BR SB_DIRSYNC ,
+.BR SB_LAZYTIME .
+.TP
+.I smbuf.fs_type
+The offset to the location in the
+.I smbuf.str
+buffer that contains the string representation of the mounted file system.
+It is a null-terminated string.
+.TP
+.I smbuf.mnt_id
+The unique mount ID of the mount.
+.TP
+.I smbuf.mnt_parent_id
+The unique mount ID of the parent mount point of this mount.
+If this is the root mount point then
+.IR smbuf.mnt_id\~==\~smbuf.parent_mount_id .
+.TP
+.I smbuf.mnt_id_old
+This corresponds to the mount ID that is exported by
+.IR /proc/ pid /mountinfo .
+.TP
+.I smbuf.mnt_parent_id_old
+This corresponds to the parent mount ID that is exported by
+.IR /proc/ pid /mountinfo .
+.TP
+.I smbuf.mnt_attr
+The
+.BI MOUNT_ATTR_ *
+flags set on this mount point.
+.TP
+.I smbuf.mnt_propagation
+The mount propagation flags,
+which can be one of
+.BR MS_SHARED ,
+.BR MS_SLAVE ,
+.BR MS_PRIVATE ,
+.BR MS_UNBINDABLE .
+.TP
+.I smbuf.mnt_peer_group
+The ID of the shared peer group.
+.TP
+.I smbuf.mnt_master
+The mount point receives its propagation from this mount ID.
+.TP
+.I smbuf.propagate_from
+The ID from the namespace we propagated from.
+.TP
+.I smbuf.mnt_root
+The offset to the location in the
+.I smbuf.str
+buffer that contains the string representation of the mount
+relative to the root of the file system.
+It is a NULL terminated string.
+.TP
+.I smbuf.mnt_point
+The offset to the location in the
+.I smbuf.str
+buffer that contains the string representation of the mount
+relative to the current root (ie if you are in a
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
+.I smbuf
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
+is too large.
+.TP
+.B EOVERFLOW
+The size of
+.I smbuf
+is too small to contain either the
+.IR smbuf.fs_type ,
+.IR smbuf.mnt_root ,
+or
+.IR smbuf.mnt_point .
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


