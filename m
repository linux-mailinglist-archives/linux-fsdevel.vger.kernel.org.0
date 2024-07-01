Return-Path: <linux-fsdevel+bounces-22876-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F8B891E0F3
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jul 2024 15:38:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9578283770
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jul 2024 13:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63B1415ECED;
	Mon,  1 Jul 2024 13:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="Or3Akieb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6304815E5D2
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Jul 2024 13:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719841105; cv=none; b=faU6sw6iy1BKBjnSz66d6pVXLC0cemJXEQJJxmKWCrBVdwCHhI/RWb45XnlDi03dPVhZnWtXyYVSLChu84ohjqalkYNokd+8S9BXZ10fWcPK9hEoqaJSUs2hRzszW3up8dieRFjnyZ+4fRmIB/L3YhN0fTzrUzOhbVl1jWaumyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719841105; c=relaxed/simple;
	bh=9u41DsETHhhVkQBCKDIrMIBZrILGgPnSxvoMF7y/Sjw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BDF1cwNPNRQL7veTircBsDf0nutiWy/hGcvvr6m9GaMVOF8lWyisPzuc62NroRPaHJ+AeYHX2TD2CHuDrtPhvjnj23USLq8/YpeJJYNaTjgjIn2stPFjnQ2+lxI5ITtSyXOmPmiYHEwWDDgMjAVhlUsf94GdPtWUYuQtzbJamhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=Or3Akieb; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-79c0b73b109so209070385a.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 Jul 2024 06:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1719841102; x=1720445902; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s7qsvijbrnO3zL83FQP+aBjucAcxsNHK492EhFqpET4=;
        b=Or3AkiebznvizfZ1LjhzpqsoD75s/R7OkfCckYEzWfJxZKu9Tt2mHe1hoPFH5Z/eg0
         byt6iforHmSJMHfb7DxDG9YgtrWjfLyJ2Pk/7fUvB0w90ao29hN1YEWZU7AG91UBGoYk
         divzuJeQfxiJ0/8omLQoBpGSLMzrPgYzsZVRwNfTo/muIEjtIi8mHiPjkFzhhQvPR+wE
         xXYs6XGcycAPPN46YcPm11yFjuYrSs4TdCOpMzIh6NJ5fVPqy7ET0ccVDsTcteSmLZ5K
         PuGnMbQ04/baRjUPCMJMuhktePIC5zJM8N80o017Jny6XdXYPnEg0GISssZmTTpm6Vc9
         nF2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719841102; x=1720445902;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s7qsvijbrnO3zL83FQP+aBjucAcxsNHK492EhFqpET4=;
        b=lsUPdY4oiKRdn5wuzx3HGStF1R0+MUI8wv3ltD+yKbMpySpOrBzp6tQiU0ywNGORP5
         kV+OMZbrdNKu/dWJwd4lt9Q7W431weFeW6V4EdBWEEOnuG0twUvQn80FttW0rGspojT1
         e9jGZNEOhTDrip48l6mO8roj/YkQ6vfLi/HPmLWnEZYg1xVKjIFtLtYaX5kMS4tuMGX6
         5zY8OgdTdku+QbyxOUC153Y6kdQ6J4SFUxVJAdnmxpgpTQjjpxxXzao2lsW78NL7vH02
         ZKZw+YzmTJ3q63HmIhX0UQW8mvMpGdcpacSLz+tie+iVeEFUgCsvuy4IZdvjKl2Vit4l
         A2OA==
X-Forwarded-Encrypted: i=1; AJvYcCU9dv+0zQ+WqyY3kiKr6XV1a8y5VUBHt7Csj8ogjeBdHFRZ3vwFYqsyOL7XhpF29Gwsj393lx7DwuWHUxGWxfpIgj8ncmJp8KL/pTTXGw==
X-Gm-Message-State: AOJu0YxCYvPXO3S8fUY3IiQ0XiySt0+n06vzXVbATdrUA+JhkND5oLH5
	B1d1n6ZJG+UmSKj0vduhCUJSrRz6dQMItJOCHg5eFUFMRsF24P9QUe1SWKy4kok=
X-Google-Smtp-Source: AGHT+IE3KPabTZqp4SPUI9thkWPbbnWrp8qm09W9yPZVi+SpFR0USJQT/rK0S7m2y1RN8wkd3colGw==
X-Received: by 2002:a05:620a:13f7:b0:79d:6169:7ab9 with SMTP id af79cd13be357-79d7babf63dmr756617385a.68.1719841102263;
        Mon, 01 Jul 2024 06:38:22 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79d69308aaasm348426785a.112.2024.07.01.06.38.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 06:38:21 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: alx@kernel.org,
	linux-man@vger.kernel.org,
	brauner@kernel.org,
	linux-fsdevel@vger.kernel.org,
	mszeredi@redhat.com,
	kernel-team@fb.com
Subject: [PATCH v4 1/2] statmount.2: New page describing the statmount syscall
Date: Mon,  1 Jul 2024 09:37:53 -0400
Message-ID: <85889ca0f88e79e79bc8bfeb58395c04affe3424.1719840964.git.josef@toxicpanda.com>
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

Add some documentation on the new statmount syscall.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 man/man2/statmount.2 | 288 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 288 insertions(+)
 create mode 100644 man/man2/statmount.2

diff --git a/man/man2/statmount.2 b/man/man2/statmount.2
new file mode 100644
index 000000000..3e13107f5
--- /dev/null
+++ b/man/man2/statmount.2
@@ -0,0 +1,288 @@
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
+you must have CAP_SYS_ADMIN in the user namespace.
+.P
+This function returns information about a mount,
+storing it in the buffer pointed to by
+.IR smbuf .
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
+lBl.
+STATMOUNT_SB_BASIC	/* Want/got sb_* */
+STATMOUNT_MNT_BASIC	/* Want/got mnt_* */
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
+.IR smbuf .
+Included in this is
+.I size
+which indicates the size of the
+.I smbuf
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
+The fields in the
+.I statmount
+structure are:
+.TP
+.I smbuf.size
+The size of the returned
+.I smbuf
+structure.
+.TP
+.I smbuf.mask
+The ORed combination of
+.B STATMOUNT_
+flags indicating which fields were filled in and thus valid.
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
+buffer that contains the string representation of the mounted file system. It is
+a null-terminated string.
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
+buffer that contains the string representation of the mount relative to the root
+of the file system.
+It is a NULL terminated string.
+.TP
+.I smbuf.mnt_point
+The offset to the location in the
+.I smbuf.str
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
+is too large,
+the limit is the architectures page size.
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


