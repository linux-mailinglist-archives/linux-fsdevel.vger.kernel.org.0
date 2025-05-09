Return-Path: <linux-fsdevel+bounces-48610-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 011AAAB1549
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 15:34:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2795189AA86
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 13:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EE08292082;
	Fri,  9 May 2025 13:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GkMK1cR3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 371082918CD
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 May 2025 13:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746797572; cv=none; b=UMOjj/D8hhDMqZtcILvyHt0N++x7C7CEfxWy0kDcqX/l93PXEKB/uZmUPKU1gp+WP5AfYYqbbf7evCypHSpwBfc+38f1ENmOOKQ8kUp5MUNwIa8J0xGUPYeRlKWIk4OC6b6fgdV6HwQz7EqlM4JEhRDr/qeUtDJ7MPyqqvmZdic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746797572; c=relaxed/simple;
	bh=M2p/iFIM1dSeJJmBLS4gaHuOO2s8t/N2d5PVZIcg4g0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cNJHviYZOYAv99kuk7JDFzGRPjVra4OmvPLER8qQyZNtoerwQHevk9SbEDCbNE1NRCTBAcbpvm6Fv2MI0bFkFvmCB4WBcPe8lBR5F3HNwnbWLb8BvRbWLJL2iEzcjXa5MnIw9OPvhbwBNP2w/uMyDjnso0AA1raKUzI+/HjMHSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GkMK1cR3; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3a0b7fbdde7so1881219f8f.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 09 May 2025 06:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746797568; x=1747402368; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dp0WDYkg2dbNSCyRG489xm1eYkKTu3Ck6uJAzHNiyV0=;
        b=GkMK1cR3dwKI8TbpWhqjUt7SQGj0D2Zr0t9EIqBmQx3MMv1GIB0r05+bgErVN2IorQ
         uEM+Z621BmIPZKNtFd383j6SifSWA1nsP6hYuk7p7870jZilL/3xRxj1Y5F67zH+5jO3
         cN95oXGOqpnDEg0o2pqSLP5F7BKWrc9SOPXvYBo2K0kROSCxHf3JhwUD9PX+nWJUMUj7
         czfeIGehLsvflMsUU6aHNFJmIDMEGobAIRVdB95I1JJHHPURynNbtBehMazPpvCC7M+X
         7uYZngefg75PS36vR4aoqpEzjjMtCoYRZ9BoJeUdxr4QvRqWguXbiA0s2JlU7W1Om9gE
         kewA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746797568; x=1747402368;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dp0WDYkg2dbNSCyRG489xm1eYkKTu3Ck6uJAzHNiyV0=;
        b=aL4K7y0recTAuSzCCmM/IxxSjAqbwp9KlKt3d80Ird2EsnLAmhX2P+1jlXMzwXQN2V
         KHmSenJknyq0ge7uIS8ykQGcizth1V+5cEoBSNqMxGVt/YAqTZo1AYjQww8RmzrTrHgX
         eEJy93dZfOkL2ANlv0VdJI2WQLmXY12dFB4tezF2bSFupuPd7TkmVD2Ky8nT0CZnnpWA
         DKIn3/mg03DsnhyBw+0EIvFUxRiKHpFZEBAbsTjaFk6pcuUwnP4i9RUA3xj5hwvHJ1gs
         G/b8uawrLrKzKJ/6KHHiyJ+VCrbMEU3AFBKE44lJSocgoMYKZy098sxcXM+XOfxItfqn
         Jt4A==
X-Forwarded-Encrypted: i=1; AJvYcCWAC88HCvL/ic15mzTQ1jB5Wrf7SGtKzITkL45N1tEvffedz0UZ2jiwZjTtYS8X1joFQVuUtYeKqkmiLxDX@vger.kernel.org
X-Gm-Message-State: AOJu0YxIaZamZRshvZrGm+y2q99BZ6Z01CRzd/iZMLx1mrSGvElOicjW
	Dl/RL32cvnGBwsvyJdLgpGlAo9nIrMNt5S3DCYcLJCGnu2W4snUQ
X-Gm-Gg: ASbGnctZ2s5DtRLRd13sNJn/eUihPbUW1AzKkoETwLSvd2gMaqs5ESjSQE7PTr/P+E6
	esVmJedkWc+TyFEJR0AohUOHMXutt4i8/2szbpzQfDa08S1kbro44yhLExqkLoUwk/WiPZIId1U
	YJXGHy4ZiVGm2uc10tQe8trGiaUBukVTCAujDcLjdDLXGCXwJuaSGnJ0HuPvJV/Td5FX7EoUkLX
	+y9ZYSjJNImvWj/xrkyaLhZUicPC6afkBgJj3xmxOMeZSm93q9kRrTQ0X1izgnkx0humys+/tsg
	E3QEG2us6kAUBYw7j5Dcoxwovd22gIVnYVOmbD90p21yxPIn0e62fhU48tt67aR5X4oMTIGob0Q
	PS0FmGKR8a7DUdIBkDP01DMuLEs47hdyN3pnJXsdQL4C9AdDm
X-Google-Smtp-Source: AGHT+IG5no83aDeoogR/RR0tXEwFeRXDqBBRAFafDajt3mxYqR22qVqSPCWWEYbH/j522784dzFC3w==
X-Received: by 2002:a05:6000:420a:b0:3a0:b72a:b27 with SMTP id ffacd0b85a97d-3a1f64accb1mr2758504f8f.56.1746797568203;
        Fri, 09 May 2025 06:32:48 -0700 (PDT)
Received: from amir-ThinkPad-T480.arnhem.chello.nl (92-109-99-123.cable.dynamic.v4.ziggo.nl. [92.109.99.123])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f57ddfd6sm3232899f8f.4.2025.05.09.06.32.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 06:32:47 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	John Hubbard <jhubbard@nvidia.com>,
	Miklos Szeredi <miklos@szeredi.hu>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 5/8] selftests/fs/mount-notify: build with tools include dir
Date: Fri,  9 May 2025 15:32:37 +0200
Message-Id: <20250509133240.529330-6-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250509133240.529330-1-amir73il@gmail.com>
References: <20250509133240.529330-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Copy the fanotify uapi header files to the tools include dir
and define __kernel_fsid_t to decouple dependency with headers_install
and then remove the redundant re-definitions of fanotify macros.

Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 tools/include/uapi/linux/fanotify.h           | 274 ++++++++++++++++++
 .../filesystems/mount-notify/Makefile         |   3 +-
 .../mount-notify/mount-notify_test.c          |  25 +-
 3 files changed, 282 insertions(+), 20 deletions(-)
 create mode 100644 tools/include/uapi/linux/fanotify.h

diff --git a/tools/include/uapi/linux/fanotify.h b/tools/include/uapi/linux/fanotify.h
new file mode 100644
index 000000000000..e710967c7c26
--- /dev/null
+++ b/tools/include/uapi/linux/fanotify.h
@@ -0,0 +1,274 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef _UAPI_LINUX_FANOTIFY_H
+#define _UAPI_LINUX_FANOTIFY_H
+
+#include <linux/types.h>
+
+/* the following events that user-space can register for */
+#define FAN_ACCESS		0x00000001	/* File was accessed */
+#define FAN_MODIFY		0x00000002	/* File was modified */
+#define FAN_ATTRIB		0x00000004	/* Metadata changed */
+#define FAN_CLOSE_WRITE		0x00000008	/* Writable file closed */
+#define FAN_CLOSE_NOWRITE	0x00000010	/* Unwritable file closed */
+#define FAN_OPEN		0x00000020	/* File was opened */
+#define FAN_MOVED_FROM		0x00000040	/* File was moved from X */
+#define FAN_MOVED_TO		0x00000080	/* File was moved to Y */
+#define FAN_CREATE		0x00000100	/* Subfile was created */
+#define FAN_DELETE		0x00000200	/* Subfile was deleted */
+#define FAN_DELETE_SELF		0x00000400	/* Self was deleted */
+#define FAN_MOVE_SELF		0x00000800	/* Self was moved */
+#define FAN_OPEN_EXEC		0x00001000	/* File was opened for exec */
+
+#define FAN_Q_OVERFLOW		0x00004000	/* Event queued overflowed */
+#define FAN_FS_ERROR		0x00008000	/* Filesystem error */
+
+#define FAN_OPEN_PERM		0x00010000	/* File open in perm check */
+#define FAN_ACCESS_PERM		0x00020000	/* File accessed in perm check */
+#define FAN_OPEN_EXEC_PERM	0x00040000	/* File open/exec in perm check */
+/* #define FAN_DIR_MODIFY	0x00080000 */	/* Deprecated (reserved) */
+
+#define FAN_PRE_ACCESS		0x00100000	/* Pre-content access hook */
+#define FAN_MNT_ATTACH		0x01000000	/* Mount was attached */
+#define FAN_MNT_DETACH		0x02000000	/* Mount was detached */
+
+#define FAN_EVENT_ON_CHILD	0x08000000	/* Interested in child events */
+
+#define FAN_RENAME		0x10000000	/* File was renamed */
+
+#define FAN_ONDIR		0x40000000	/* Event occurred against dir */
+
+/* helper events */
+#define FAN_CLOSE		(FAN_CLOSE_WRITE | FAN_CLOSE_NOWRITE) /* close */
+#define FAN_MOVE		(FAN_MOVED_FROM | FAN_MOVED_TO) /* moves */
+
+/* flags used for fanotify_init() */
+#define FAN_CLOEXEC		0x00000001
+#define FAN_NONBLOCK		0x00000002
+
+/* These are NOT bitwise flags.  Both bits are used together.  */
+#define FAN_CLASS_NOTIF		0x00000000
+#define FAN_CLASS_CONTENT	0x00000004
+#define FAN_CLASS_PRE_CONTENT	0x00000008
+
+/* Deprecated - do not use this in programs and do not add new flags here! */
+#define FAN_ALL_CLASS_BITS	(FAN_CLASS_NOTIF | FAN_CLASS_CONTENT | \
+				 FAN_CLASS_PRE_CONTENT)
+
+#define FAN_UNLIMITED_QUEUE	0x00000010
+#define FAN_UNLIMITED_MARKS	0x00000020
+#define FAN_ENABLE_AUDIT	0x00000040
+
+/* Flags to determine fanotify event format */
+#define FAN_REPORT_PIDFD	0x00000080	/* Report pidfd for event->pid */
+#define FAN_REPORT_TID		0x00000100	/* event->pid is thread id */
+#define FAN_REPORT_FID		0x00000200	/* Report unique file id */
+#define FAN_REPORT_DIR_FID	0x00000400	/* Report unique directory id */
+#define FAN_REPORT_NAME		0x00000800	/* Report events with name */
+#define FAN_REPORT_TARGET_FID	0x00001000	/* Report dirent target id  */
+#define FAN_REPORT_FD_ERROR	0x00002000	/* event->fd can report error */
+#define FAN_REPORT_MNT		0x00004000	/* Report mount events */
+
+/* Convenience macro - FAN_REPORT_NAME requires FAN_REPORT_DIR_FID */
+#define FAN_REPORT_DFID_NAME	(FAN_REPORT_DIR_FID | FAN_REPORT_NAME)
+/* Convenience macro - FAN_REPORT_TARGET_FID requires all other FID flags */
+#define FAN_REPORT_DFID_NAME_TARGET (FAN_REPORT_DFID_NAME | \
+				     FAN_REPORT_FID | FAN_REPORT_TARGET_FID)
+
+/* Deprecated - do not use this in programs and do not add new flags here! */
+#define FAN_ALL_INIT_FLAGS	(FAN_CLOEXEC | FAN_NONBLOCK | \
+				 FAN_ALL_CLASS_BITS | FAN_UNLIMITED_QUEUE |\
+				 FAN_UNLIMITED_MARKS)
+
+/* flags used for fanotify_modify_mark() */
+#define FAN_MARK_ADD		0x00000001
+#define FAN_MARK_REMOVE		0x00000002
+#define FAN_MARK_DONT_FOLLOW	0x00000004
+#define FAN_MARK_ONLYDIR	0x00000008
+/* FAN_MARK_MOUNT is		0x00000010 */
+#define FAN_MARK_IGNORED_MASK	0x00000020
+#define FAN_MARK_IGNORED_SURV_MODIFY	0x00000040
+#define FAN_MARK_FLUSH		0x00000080
+/* FAN_MARK_FILESYSTEM is	0x00000100 */
+#define FAN_MARK_EVICTABLE	0x00000200
+/* This bit is mutually exclusive with FAN_MARK_IGNORED_MASK bit */
+#define FAN_MARK_IGNORE		0x00000400
+
+/* These are NOT bitwise flags.  Both bits can be used togther.  */
+#define FAN_MARK_INODE		0x00000000
+#define FAN_MARK_MOUNT		0x00000010
+#define FAN_MARK_FILESYSTEM	0x00000100
+#define FAN_MARK_MNTNS		0x00000110
+
+/*
+ * Convenience macro - FAN_MARK_IGNORE requires FAN_MARK_IGNORED_SURV_MODIFY
+ * for non-inode mark types.
+ */
+#define FAN_MARK_IGNORE_SURV	(FAN_MARK_IGNORE | FAN_MARK_IGNORED_SURV_MODIFY)
+
+/* Deprecated - do not use this in programs and do not add new flags here! */
+#define FAN_ALL_MARK_FLAGS	(FAN_MARK_ADD |\
+				 FAN_MARK_REMOVE |\
+				 FAN_MARK_DONT_FOLLOW |\
+				 FAN_MARK_ONLYDIR |\
+				 FAN_MARK_MOUNT |\
+				 FAN_MARK_IGNORED_MASK |\
+				 FAN_MARK_IGNORED_SURV_MODIFY |\
+				 FAN_MARK_FLUSH)
+
+/* Deprecated - do not use this in programs and do not add new flags here! */
+#define FAN_ALL_EVENTS (FAN_ACCESS |\
+			FAN_MODIFY |\
+			FAN_CLOSE |\
+			FAN_OPEN)
+
+/*
+ * All events which require a permission response from userspace
+ */
+/* Deprecated - do not use this in programs and do not add new flags here! */
+#define FAN_ALL_PERM_EVENTS (FAN_OPEN_PERM |\
+			     FAN_ACCESS_PERM)
+
+/* Deprecated - do not use this in programs and do not add new flags here! */
+#define FAN_ALL_OUTGOING_EVENTS	(FAN_ALL_EVENTS |\
+				 FAN_ALL_PERM_EVENTS |\
+				 FAN_Q_OVERFLOW)
+
+#define FANOTIFY_METADATA_VERSION	3
+
+struct fanotify_event_metadata {
+	__u32 event_len;
+	__u8 vers;
+	__u8 reserved;
+	__u16 metadata_len;
+	__aligned_u64 mask;
+	__s32 fd;
+	__s32 pid;
+};
+
+#define FAN_EVENT_INFO_TYPE_FID		1
+#define FAN_EVENT_INFO_TYPE_DFID_NAME	2
+#define FAN_EVENT_INFO_TYPE_DFID	3
+#define FAN_EVENT_INFO_TYPE_PIDFD	4
+#define FAN_EVENT_INFO_TYPE_ERROR	5
+#define FAN_EVENT_INFO_TYPE_RANGE	6
+#define FAN_EVENT_INFO_TYPE_MNT		7
+
+/* Special info types for FAN_RENAME */
+#define FAN_EVENT_INFO_TYPE_OLD_DFID_NAME	10
+/* Reserved for FAN_EVENT_INFO_TYPE_OLD_DFID	11 */
+#define FAN_EVENT_INFO_TYPE_NEW_DFID_NAME	12
+/* Reserved for FAN_EVENT_INFO_TYPE_NEW_DFID	13 */
+
+/* Variable length info record following event metadata */
+struct fanotify_event_info_header {
+	__u8 info_type;
+	__u8 pad;
+	__u16 len;
+};
+
+/*
+ * Unique file identifier info record.
+ * This structure is used for records of types FAN_EVENT_INFO_TYPE_FID,
+ * FAN_EVENT_INFO_TYPE_DFID and FAN_EVENT_INFO_TYPE_DFID_NAME.
+ * For FAN_EVENT_INFO_TYPE_DFID_NAME there is additionally a null terminated
+ * name immediately after the file handle.
+ */
+struct fanotify_event_info_fid {
+	struct fanotify_event_info_header hdr;
+	__kernel_fsid_t fsid;
+	/*
+	 * Following is an opaque struct file_handle that can be passed as
+	 * an argument to open_by_handle_at(2).
+	 */
+	unsigned char handle[];
+};
+
+/*
+ * This structure is used for info records of type FAN_EVENT_INFO_TYPE_PIDFD.
+ * It holds a pidfd for the pid that was responsible for generating an event.
+ */
+struct fanotify_event_info_pidfd {
+	struct fanotify_event_info_header hdr;
+	__s32 pidfd;
+};
+
+struct fanotify_event_info_error {
+	struct fanotify_event_info_header hdr;
+	__s32 error;
+	__u32 error_count;
+};
+
+struct fanotify_event_info_range {
+	struct fanotify_event_info_header hdr;
+	__u32 pad;
+	__u64 offset;
+	__u64 count;
+};
+
+struct fanotify_event_info_mnt {
+	struct fanotify_event_info_header hdr;
+	__u64 mnt_id;
+};
+
+/*
+ * User space may need to record additional information about its decision.
+ * The extra information type records what kind of information is included.
+ * The default is none. We also define an extra information buffer whose
+ * size is determined by the extra information type.
+ *
+ * If the information type is Audit Rule, then the information following
+ * is the rule number that triggered the user space decision that
+ * requires auditing.
+ */
+
+#define FAN_RESPONSE_INFO_NONE		0
+#define FAN_RESPONSE_INFO_AUDIT_RULE	1
+
+struct fanotify_response {
+	__s32 fd;
+	__u32 response;
+};
+
+struct fanotify_response_info_header {
+	__u8 type;
+	__u8 pad;
+	__u16 len;
+};
+
+struct fanotify_response_info_audit_rule {
+	struct fanotify_response_info_header hdr;
+	__u32 rule_number;
+	__u32 subj_trust;
+	__u32 obj_trust;
+};
+
+/* Legit userspace responses to a _PERM event */
+#define FAN_ALLOW	0x01
+#define FAN_DENY	0x02
+/* errno other than EPERM can specified in upper byte of deny response */
+#define FAN_ERRNO_BITS	8
+#define FAN_ERRNO_SHIFT (32 - FAN_ERRNO_BITS)
+#define FAN_ERRNO_MASK	((1 << FAN_ERRNO_BITS) - 1)
+#define FAN_DENY_ERRNO(err) \
+	(FAN_DENY | ((((__u32)(err)) & FAN_ERRNO_MASK) << FAN_ERRNO_SHIFT))
+
+#define FAN_AUDIT	0x10	/* Bitmask to create audit record for result */
+#define FAN_INFO	0x20	/* Bitmask to indicate additional information */
+
+/* No fd set in event */
+#define FAN_NOFD	-1
+#define FAN_NOPIDFD	FAN_NOFD
+#define FAN_EPIDFD	-2
+
+/* Helper functions to deal with fanotify_event_metadata buffers */
+#define FAN_EVENT_METADATA_LEN (sizeof(struct fanotify_event_metadata))
+
+#define FAN_EVENT_NEXT(meta, len) ((len) -= (meta)->event_len, \
+				   (struct fanotify_event_metadata*)(((char *)(meta)) + \
+				   (meta)->event_len))
+
+#define FAN_EVENT_OK(meta, len)	((long)(len) >= (long)FAN_EVENT_METADATA_LEN && \
+				(long)(meta)->event_len >= (long)FAN_EVENT_METADATA_LEN && \
+				(long)(meta)->event_len <= (long)(len))
+
+#endif /* _UAPI_LINUX_FANOTIFY_H */
diff --git a/tools/testing/selftests/filesystems/mount-notify/Makefile b/tools/testing/selftests/filesystems/mount-notify/Makefile
index 10be0227b5ae..41ebfe558a0a 100644
--- a/tools/testing/selftests/filesystems/mount-notify/Makefile
+++ b/tools/testing/selftests/filesystems/mount-notify/Makefile
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
 
-CFLAGS += -Wall -O2 -g $(KHDR_INCLUDES)
+CFLAGS += -Wall -O2 -g $(KHDR_INCLUDES) $(TOOLS_INCLUDES)
+
 TEST_GEN_PROGS := mount-notify_test
 
 include ../../lib.mk
diff --git a/tools/testing/selftests/filesystems/mount-notify/mount-notify_test.c b/tools/testing/selftests/filesystems/mount-notify/mount-notify_test.c
index 59a71f22fb11..4f0f325379b5 100644
--- a/tools/testing/selftests/filesystems/mount-notify/mount-notify_test.c
+++ b/tools/testing/selftests/filesystems/mount-notify/mount-notify_test.c
@@ -8,33 +8,20 @@
 #include <string.h>
 #include <sys/stat.h>
 #include <sys/mount.h>
-#include <linux/fanotify.h>
 #include <unistd.h>
-#include <sys/fanotify.h>
 #include <sys/syscall.h>
 
 #include "../../kselftest_harness.h"
 #include "../statmount/statmount.h"
 
-#ifndef FAN_MNT_ATTACH
-struct fanotify_event_info_mnt {
-	struct fanotify_event_info_header hdr;
-	__u64 mnt_id;
-};
-#define FAN_MNT_ATTACH 0x01000000 /* Mount was attached */
-#endif
-
-#ifndef FAN_MNT_DETACH
-#define FAN_MNT_DETACH 0x02000000 /* Mount was detached */
+// Needed for linux/fanotify.h
+#ifndef __kernel_fsid_t
+typedef struct {
+	int	val[2];
+} __kernel_fsid_t;
 #endif
 
-#ifndef FAN_REPORT_MNT
-#define FAN_REPORT_MNT 0x00004000 /* Report mount events */
-#endif
-
-#ifndef FAN_MARK_MNTNS
-#define FAN_MARK_MNTNS 0x00000110
-#endif
+#include <sys/fanotify.h>
 
 static uint64_t get_mnt_id(struct __test_metadata *const _metadata,
 			   const char *path)
-- 
2.34.1


