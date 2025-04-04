Return-Path: <linux-fsdevel+bounces-45728-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 397C3A7B876
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Apr 2025 09:56:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 221D13B92BE
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Apr 2025 07:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 669B4191F95;
	Fri,  4 Apr 2025 07:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lHHcwtfF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 032A6847B;
	Fri,  4 Apr 2025 07:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743753391; cv=none; b=pkr0JVEkySMuFT2IWO1Awj7XR5cjBr881LC0tPSnyLfYrEJb2q1Pv9rV94ATJ+/PhwlPNOi5NxsJ0P4gp0r9JitVH4ctK+3xLkWZpOhBBEpv8Jw2vS8DgRKZOfRAp7w7SN2nl3MOLRI+zQ52LGF78t9xxUVMV0NrUq3sDKWWsNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743753391; c=relaxed/simple;
	bh=c/n+cnmhHP3YJKlkmjR1tOaJt3b1gUXId62hRvDEXVo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ocyB9UEd8Ly3bpS+DBwaPuqDwB6+Y58SP7OsO2oxuy0bE7/pi5kfjAc1BUgFqxCcgKD/PSKKnNjNWwSSd9auwBxWM3dTsM1IvBfAIbcwfdMAcJAsXcRNSpD0xpTfyWYrZQ6P7jbNV0bVKDs+Fp1lB0prqnFQN8iG7/BnQt6E9xY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lHHcwtfF; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ac345bd8e13so289245266b.0;
        Fri, 04 Apr 2025 00:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743753388; x=1744358188; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=shEVoU4LXJ3p+JxoQT4w3fDTTqTSziXHQPOi8L5KAEc=;
        b=lHHcwtfF6XYYxdfoetVfGtmCM2wQ+6CosywXrUMfHAvGi0tNL9ubxdmmL64peBFy8Z
         y7ALrK6wUNqSvl6W98Uy4ipERvkZrRCimzHJvlFbEWlK7VNFZqg5NfV/iRBqQclLsiKe
         dO2CUBDolSEz77QI3UkK45LOyfkKW3ImnFr+W1YLzMFVKsxUp16/OzwIK0qZ2QqDycle
         Cl7nMlbqR0x3AXek4f5QaKIJ5w+jI8OeSfyH8xhS/KW2v07sd2wgRq3nAVTU9ffB13Su
         PTZIsT+5Y6aD/swjfo8MZE4xXLPxgtZBzrHd6+O9QV2CJmHDNNRM3JgaYDJC7WY5FSES
         W+Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743753388; x=1744358188;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=shEVoU4LXJ3p+JxoQT4w3fDTTqTSziXHQPOi8L5KAEc=;
        b=U1xg04+vClYdOlDlnLPaL6bUlKWQ9nvtcOfjsdA1ZDeqsgGTkjZjn+NQvdOByrKip0
         fMcM+k14VCNYAefupRYUJPr2p/NjmJLvzme0nWo0k47K61TuOvJfmuOl/M2cg1vqfqqE
         T52wdvIoyJY5unsb9kJegXLqtnYm7rFh/hRt+r1GcVwZiKMhBr1E2S9NSLk055Bdtg3d
         yfqAC7j5QpUJq8nioHFyf3dDcz3glYcj4NVt9cd5I2flXBl0r1VwCPxjjhxpMnpxsA3d
         Q2q6R+/EuwfSM3WKLwa7gZd1NH9uCIbpGcC7/qEs4AhkEF3kF3KPhoHXtDEbPLpJ0gbM
         0ysw==
X-Forwarded-Encrypted: i=1; AJvYcCUPZILRsYSKfNFR10XNSTHa9t4LYZutFA3adwTq+sKK90fFcxWeqmmQdjBfLEcDnwLKT24YxyiagCpCjt3u@vger.kernel.org, AJvYcCVEmRo74WMjiWGcsR+HBoHVSB97FwRAkuKwzIBCeYFMG4CrtFoCbFBe6Vt1he+ACY70bRJbrG7+fU+E@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/AQa1BvzTirRyT7I/339hfmm1qv2Kea7jdSjRc0slGO6tvH4D
	x3iFmmB90Yr7L9QoVWNMJkTUBye8UwQZkploaWdqvZHiy9yORW6NM0WaHJIJ
X-Gm-Gg: ASbGncs23AEcYm1RFU1AQG9/sMywonq+JEYa4o51i1/fyOKVwxyqA56wJgvdCkhm0hr
	x/6v3nr5rULaKKtFRZcLMWW9Ei5PR8zHtlBnijed0aatsKHDO4cp/gdPDeKwXgJHAvs6x9xiTF+
	3Z7x2zvdPAUQxpBDNUNUp97I2zE6IoJ4x7gaCNuWT4u3JklPNE+ioABe5ZmB+rboJ+jxNyts6hO
	SO4pm4xm3CASXa3dA119QPY2KGZRafpeDLJsQltGO964M5TcyJIaECd0oyNsF6vLOMyBKf/+eTh
	c0lu3k7IN0xvNajttc/sVZ4+5Uq222aF+bvXeVGDkYxz0v9NL71edPwrpx/fX+xNKF/uBEI0Usc
	k3ay0dlgbvwouOFMNuKnZVn6hz2iCsRwgyaoR9q21Jw==
X-Google-Smtp-Source: AGHT+IEu0YAiBACf54MhP5LOf8yZ0Ao7INwCILQdd0TrRsatYGC2AwiroLHPEVOggkzj3T2TipTiSw==
X-Received: by 2002:a17:907:2d27:b0:ac7:3918:7530 with SMTP id a640c23a62f3a-ac7d19f4b7dmr193785866b.61.1743753387810;
        Fri, 04 Apr 2025 00:56:27 -0700 (PDT)
Received: from amir-ThinkPad-T480.arnhem.chello.nl (92-109-99-123.cable.dynamic.v4.ziggo.nl. [92.109.99.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac7c013ebc8sm211328766b.101.2025.04.04.00.56.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Apr 2025 00:56:27 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Alejandro Colomar <alx@kernel.org>
Cc: Miklos Szeredi <mszeredi@redhat.com>,
	Jan Kara <jack@suse.cz>,
	Christian Brauner <brauner@kernel.org>,
	linux-man@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v3] fanotify: Document mount namespace events
Date: Fri,  4 Apr 2025 09:56:24 +0200
Message-Id: <20250404075624.1700284-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Used to subscribe for notifications for when mounts
are attached/detached from a mount namespace.

Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Miklos Szeredi <mszeredi@redhat.com>
Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---

Changes since v2:
- Added more RVB
- Formatting review fixes

 man/man2/fanotify_init.2 | 20 ++++++++++++++++++
 man/man2/fanotify_mark.2 | 37 ++++++++++++++++++++++++++++++++-
 man/man7/fanotify.7      | 45 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 101 insertions(+), 1 deletion(-)

diff --git a/man/man2/fanotify_init.2 b/man/man2/fanotify_init.2
index b90e91707..93887b875 100644
--- a/man/man2/fanotify_init.2
+++ b/man/man2/fanotify_init.2
@@ -331,6 +331,26 @@ that the directory entry is referring to.
 This is a synonym for
 .RB ( FAN_REPORT_DFID_NAME | FAN_REPORT_FID | FAN_REPORT_TARGET_FID ).
 .TP
+.BR FAN_REPORT_MNT " (since Linux 6.14)"
+.\" commit 0f46d81f2bce970b1c562aa3c944a271bbec2729
+This value allows the receipt of events which contain additional information
+about the underlying mount correlated to an event.
+An additional record of type
+.B FAN_EVENT_INFO_TYPE_MNT
+encapsulates the information about the mount and is included alongside the
+generic event metadata structure.
+The use of
+.BR FAN_CLASS_CONTENT ,
+.BR FAN_CLASS_PRE_CONTENT,
+or any of the
+.B FAN_REPORT_DFID_NAME_TARGET
+flags along with this flag is not permitted
+and will result in the error
+.BR EINVAL .
+See
+.BR fanotify (7)
+for additional details.
+.TP
 .BR FAN_REPORT_PIDFD " (since Linux 5.15 and 5.10.220)"
 .\" commit af579beb666aefb17e9a335c12c788c92932baf1
 Events for fanotify groups initialized with this flag will contain
diff --git a/man/man2/fanotify_mark.2 b/man/man2/fanotify_mark.2
index a6d80ad68..2c9d6e9b9 100644
--- a/man/man2/fanotify_mark.2
+++ b/man/man2/fanotify_mark.2
@@ -67,7 +67,8 @@ contains
 all marks for filesystems are removed from the group.
 Otherwise, all marks for directories and files are removed.
 No flag other than, and at most one of, the flags
-.B FAN_MARK_MOUNT
+.BR FAN_MARK_MNTNS ,
+.BR FAN_MARK_MOUNT ,
 or
 .B FAN_MARK_FILESYSTEM
 can be used in conjunction with
@@ -99,6 +100,20 @@ If the filesystem object to be marked is not a directory, the error
 .B ENOTDIR
 shall be raised.
 .TP
+.BR FAN_MARK_MNTNS " (since Linux 6.14)"
+.\" commit 0f46d81f2bce970b1c562aa3c944a271bbec2729
+Mark the mount namespace specified by
+.IR pathname .
+If the
+.I pathname
+is not a path that represents a mount namespace (e.g.
+.IR /proc/ pid /ns/mnt ),
+the call fails with the error
+.BR EINVAL .
+An fanotify group that was initialized with flag
+.B FAN_REPORT_MNT
+is required.
+.TP
 .B FAN_MARK_MOUNT
 Mark the mount specified by
 .IR path .
@@ -395,6 +410,26 @@ Create an event when a marked file or directory itself has been moved.
 An fanotify group that identifies filesystem objects by file handles
 is required.
 .TP
+.B FAN_MNT_ATTACH
+.TQ
+.BR FAN_MNT_DETACH " (both since Linux 6.14)"
+.\" commit 0f46d81f2bce970b1c562aa3c944a271bbec2729
+Create an event when a mount was attached to or detached from a marked mount namespace, respectively.
+An attempt to set this flag on an inode, mount, or filesystem mark
+will result in the error
+.BR EINVAL .
+An fanotify group that was initialized with flag
+.B FAN_REPORT_MNT
+and the mark flag
+.B FAN_MARK_MNTNS
+are required.
+An additional information record of type
+.B FAN_EVENT_INFO_TYPE_MNT
+is returned with the event.
+See
+.BR fanotify (7)
+for additional details.
+.TP
 .BR FAN_FS_ERROR " (since Linux 5.16, 5.15.154, and 5.10.220)"
 .\" commit 9709bd548f11a092d124698118013f66e1740f9b
 Create an event when a filesystem error
diff --git a/man/man7/fanotify.7 b/man/man7/fanotify.7
index 68e930930..de0ea8e55 100644
--- a/man/man7/fanotify.7
+++ b/man/man7/fanotify.7
@@ -228,6 +228,23 @@ struct fanotify_event_info_pidfd {
 .EE
 .in
 .P
+In cases where an fanotify group is initialized with
+.BR FAN_REPORT_MNT ,
+event listeners should expect to receive the below
+information record object alongside the generic
+.I fanotify_event_metadata
+structure within the read buffer.
+This structure is defined as follows:
+.P
+.in +4n
+.EX
+struct fanotify_event_info_mnt {
+    struct fanotify_event_info_header hdr;
+    __u64 mnt_id;
+};
+.EE
+.in
+.P
 In case of a
 .B FAN_FS_ERROR
 event,
@@ -442,6 +459,12 @@ A file or directory that was opened read-only
 .RB ( O_RDONLY )
 was closed.
 .TP
+.BR FAN_MNT_ATTACH
+A mount was attached to mount namespace.
+.TP
+.BR FAN_MNT_DETACH
+A mount was detached from mount namespace.
+.TP
 .B FAN_FS_ERROR
 A filesystem error was detected.
 .TP
@@ -540,6 +563,8 @@ The value of this field can be set to one of the following.
 .B FAN_EVENT_INFO_TYPE_ERROR
 .TQ
 .B FAN_EVENT_INFO_TYPE_RANGE
+.TQ
+.B FAN_EVENT_INFO_TYPE_MNT
 .RE
 .IP
 The value set for this field
@@ -725,6 +750,26 @@ in case of a terminated process, the value will be
 .BR \-ESRCH .
 .P
 The fields of the
+.I fanotify_event_info_mnt
+structure are as follows:
+.TP
+.I .hdr
+This is a structure of type
+.IR fanotify_event_info_header .
+The
+.I .info_type
+field is set to
+.BR FAN_EVENT_INFO_TYPE_MNT .
+.TP
+.I .mnt_id
+Identifies the mount associated with the event.
+It is a 64-bit unique mount id as the one returned by
+.BR statx (2)
+with the
+.B STATX_MNT_ID_UNIQUE
+flag.
+.P
+The fields of the
 .I fanotify_event_info_error
 structure are as follows:
 .TP
-- 
2.34.1


