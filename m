Return-Path: <linux-fsdevel+bounces-22526-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 81AEB918663
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jun 2024 17:57:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 033351F23017
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jun 2024 15:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9345F18EFC6;
	Wed, 26 Jun 2024 15:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="uDcwgNiD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9394418E764
	for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jun 2024 15:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719417414; cv=none; b=WUoUSESa/sGhTRyhq98beL8OFc9dTfQj2Kh/ghQaeMMOCZsvsZ7QKCORT1BvcdwOSF6tnLyG83+WYCgw1e6RM74DUEJvSMdRSKGx6hqmzqPYzzvsAfrg/ouXbo2F1dJE+y8UyFePUgNKdeF9XiSe7KftFVHbRVMOvCAyhcSefTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719417414; c=relaxed/simple;
	bh=3XoA61cFoxM5OLhqLOD52Qsss/aaBLjcVJv6CT+J+AY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xnt3H2YmGDvRCLSRn35jns0BhmwCsIdoXIessehhUU37kFEA5OwYngLV2wxbtMxVwPVMbNPLZ3kx8zDPftQmHzAJjsce8FuDSIn/47iIivCyZNxs/qsrFP7Ql5coJ9BJC1XMSxATeJqPOFym5L3XO4l/XnlN3oTE8B5BS77Etns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=uDcwgNiD; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-700a6853664so2764327a34.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jun 2024 08:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1719417411; x=1720022211; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NuBhifyOuojl5rt6eqeYUysEaHGsVdZOOKLoK5GsQb8=;
        b=uDcwgNiDhNOENa5RSxEIVQ8PdTySY/xbLE1n0FwzjBN1loPzdv/p4sCJ500j7Gr4lB
         ZBbv7YpiPw5FYs21ctJBW3dy9UI9iGKOwt72zhc/RXQKJmnLhITbZ7hAU2XehLiHEa9e
         0+2JU+WAbD2d22VmUU0D8ect2qGh4LHRgfp5njdfB66cBQQAmlAdVxwyWbD0d1/elgWV
         hWnvvoQ6MdYBB0WPyVcPRFOUOnhRmaE72y8C9kMZnldNB1Yz9b/IWmpkp6BlE/SrFahU
         kV0mGWMR2go/r0NpKglwG4kv86Ilj7cjXtwbrnVgzDILkA2JJ3fE8ZJx7MYJMHHGovGq
         i4UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719417411; x=1720022211;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NuBhifyOuojl5rt6eqeYUysEaHGsVdZOOKLoK5GsQb8=;
        b=nITl5Uzdo0q2y2opGNe7MdCyCNYGm4KkKIl7jloiOYhFn4ADAFSrzE9b3A6js7sapH
         NxYnpgGtiR3UG/wTq03YThQqiZJVq+X0tEGq79YH+rMmIvHg1NNzjDp0o3bDzg5eDVhr
         YlFoNE5ipGAjyIvQdPro4bUjLAmm4HG7FZ9akqbNHVEENbRVkh4vCiyoGIcw27ubpqgi
         7Bsgj5/MhhPIstuKXwob/qziedJNnp32pklqsTaZdBn92ZYkT0AMwMLwmVorBn8sayfD
         KBs6Q6F1CzigO0KosMKIy7HqTvasTRlpNp5dmwZ1VRR96hDqpdvV0G/vx9oMtBZMozRR
         wCNw==
X-Forwarded-Encrypted: i=1; AJvYcCXY023RaYqgHJGHtZbGkxCaMD1v5YVKJJGar5qedSLSiGSebeOo8Wgz1OHC8zxjHJSlmK7HzTl7OCCc/PzuRj61o/wKzG3yRZ7aPEYETQ==
X-Gm-Message-State: AOJu0YwcD+St8+Q1u5Jm4aNWTWb3cz4AzO4yw+qZQCt2W9T2+TscPXSw
	X43F6w6TYhzi1FWq6lT/HxhqJZWVchO0GoG6GAgTKJcIxFbpSRVO3wVq0Jxcuns=
X-Google-Smtp-Source: AGHT+IH11+Uo1B5qKCrHZsSwdNjrCCcDFAnd1qjobbdZ58GldpAS0T05fn3pcH2vBRGzLP+/fc+bpg==
X-Received: by 2002:a05:6830:1505:b0:700:b603:bc61 with SMTP id 46e09a7af769-700b603bcf7mr10512094a34.30.1719417409621;
        Wed, 26 Jun 2024 08:56:49 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79c0530c6e8sm153808185a.132.2024.06.26.08.56.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 08:56:49 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: alx@kernel.org,
	linux-man@vger.kernel.org,
	brauner@kernel.org,
	linux-fsdevel@vger.kernel.org,
	mszeredi@redhat.com,
	kernel-team@fb.com
Subject: [PATCH v2 1/2] statmount.2: New page describing the statmount syscall
Date: Wed, 26 Jun 2024 11:56:07 -0400
Message-ID: <686262069ed5d89f088713c893cd767621f52fcd.1719417184.git.josef@toxicpanda.com>
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

Add some documentation on the new statmount syscall.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 man/man2/statmount.2 | 289 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 289 insertions(+)
 create mode 100644 man/man2/statmount.2

diff --git a/man/man2/statmount.2 b/man/man2/statmount.2
new file mode 100644
index 000000000..9eefebde7
--- /dev/null
+++ b/man/man2/statmount.2
@@ -0,0 +1,289 @@
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
+.BI "            struct statmount * " statmountbuf ", size_t " bufsize ,
+.BI "            unsigned long " flags " );
+.P
+.B #include <linux/mount.h>
+.P
+.EX
+.B struct mnt_id_req {
+.BR "    __u32 size;" "    /* sizeof(struct mnt_id_req) */"
+.BR "    __u64 mnt_id;" "  /* The mnt_id being queried */"
+.BR "    __u64 param;" "   /* An ORed combination of the STATMOUNT_ constants */"
+.B };
+.EE
+.P
+.EX
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
+.EE
+.fi
+.P
+.IR Note :
+glibc provides no wrapper for
+.BR statmount (),
+necessitating the use of
+.BR syscall (2).
+.SH DESCRIPTION
+To access a mount's status,
+you must have CAP_SYS_ADMIN in the user namespace.
+.P
+This function returns information about a mount,
+storing it in the buffer pointed to by
+.IR statmountbuf .
+The returned buffer is a
+.I struct statmount
+with the fields filled in as described below.
+.P
+(Note that reserved space and padding is omitted.)
+.SS The mnt_id_req structure
+.I req.size
+is used by the kernel to determine which struct
+.I mnt_id_req
+is being passed in,
+it should always be set to sizeof(struct mnt_id req).
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
+Note that,
+in general,
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
+.IR statmountbuf .
+Included in this is
+.I size
+which indicates the size of the
+.I statmountbuf
+that was filled in,
+including any strings.
+.I mask
+which indicates what information in the structure has been filled in.
+.P
+It should be noted that the kernel may return fields that weren't requested
+and may fail to return fields that were requested,
+depending on what the backing file system and kernel supports.
+In either case,
+.I req.param
+will not be equal to
+.IR mask .
+.P
+Apart from
+.I mask
+(which is described above),
+the fields in the
+.I statmount
+structure are:
+.TP
+.I size
+The size of the returned
+.I statmountbuf
+structure.
+.TP
+.I sb_dev_major
+.TQ
+.I sb_dev_minor
+The device that is mounted at this mount point.
+.TP
+.I sb_magic
+The file system specific super block magic.
+.TP
+.I sb_flags
+The flags that are set on the super block,
+an ORed combination of
+.BR SB_RDONLY ,
+.BR SB_SYNCHRONOUS ,
+.BR SB_DIRSYNC ,
+.BR SB_LAZYTIME .
+.TP
+.I fs_type
+The offset to the location in the
+.I statmount.str
+buffer that contains the string representation of the mounted file system. It is
+a null-terminated string.
+.TP
+.I mnt_id
+The unique mount ID of the mount.
+.TP
+.I mnt_parent_id
+The unique mount ID of the parent mount point of this mount.
+If this is the root mount point then
+.IR mnt_id\~==\~parent_mount_id .
+.TP
+.I mnt_id_old
+This corresponds to the mount ID that is exported by
+.IR /proc/ pid /mountinfo .
+.TP
+.I mnt_parent_id_old
+This corresponds to the parent mount ID that is exported by
+.IR /proc/ pid /mountinfo .
+.TP
+.I mnt_attr
+The
+.B MOUNT_ATTR_
+flags set on this mount point.
+.TP
+.I mnt_propagation
+The mount propagation flags,
+which can be one of
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
+of the file system.
+It is a NULL terminated string.
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
+is too large,
+the limit is the architectures page size.
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


