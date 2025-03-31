Return-Path: <linux-fsdevel+bounces-45345-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D800A7671E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Mar 2025 15:51:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80A5918896E5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Mar 2025 13:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B18DD212B0C;
	Mon, 31 Mar 2025 13:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mwi9S2xB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4F320296C;
	Mon, 31 Mar 2025 13:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743429069; cv=none; b=Z3lppXf0q/2H7A1STLD16z7u0n8vIPPuopbJIx1GTn20jjolJ6zKlzL7V9EYy9pziERea+O/bqChY/kRmT8C6uOTgMwIs8x9AhcJKRzBT+X4a5nxqHUfV49W6KtpvfUe6s3CRGVPxpa3U/RpcBC2j8GWFjcOGcopt9NgqcGA9VE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743429069; c=relaxed/simple;
	bh=BnW71g/O2iIPD9mLtGe2NqUN3g197mSbwd5GODoh8bU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tnuzkA+OgE/n5GxJQLUcL+yZOJT9WV0Xsrc+cXyiqsmaR3uaSl58iIHEKGZcQsYmlhjpdpzQKonOjZh6OKyr5lURVoG5nOwXs3jTkTGQJhnEyhgCMdVyfV/eY6rIxfCCTxW35AmNRBD1KgEfHG8JvB3sWTyP/CNjUu2IXbc6CkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mwi9S2xB; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43cf848528aso39930465e9.2;
        Mon, 31 Mar 2025 06:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743429065; x=1744033865; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UUsbXTu7wVabNUOFYsi0K7iHT7fOK1a4yaqllvxUXRA=;
        b=mwi9S2xBGh5OJs8/fUzIFuiMURETc8yVccIAoLE2fuVD1kSXtkbgS5g3TFUQTMR9Ux
         uK4Azjnh1GO/e34u+CZ1i7G8y0IMqgA6Pntg3QV+AwwYxI4wLZ/G6cpI6kGj72jQkS6G
         AuixQmGpDopC2BPMreYyWInTjmMM8W21ltTLCvVN0rls7BCJiFWyQBFFnvTbKgsVXHxf
         RiQCzbgcBE8GPe30nzsnw/TQlc7fg+cZknuxBnuDY+ZTZ2m0/A3LWtecsvIu1ErrMbkU
         jzKsARgR2gJGj9/2udrIBeqdA/yP8zpYtgmFpSGNSrEk1o1xPAnWT96mH7POuVmaTcDK
         qjGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743429065; x=1744033865;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UUsbXTu7wVabNUOFYsi0K7iHT7fOK1a4yaqllvxUXRA=;
        b=G3XWeI0Acn/fCjm31KhGx1dLm21d+EevAflY+T3P9I412lEm3Malazv83RTKHBlhJG
         UOFq5SPdfmqhZQuhR+XQRNh8OHKNLUFTglYZQh60CWGlLZJIuRzBBUI+eUDwAQYdOYmZ
         yNRHvNmhN4BSEXPeUq4lLR5WqJYS9KuAM5gCcpZSuo9DYvkq5X1u4uAXaceuLGutmaS5
         SLHW4d/3y/SIBq/nHkf6Ejy4c6jtFQuLZA6N9EDg07lqU0fqYFk0lgu0CS1giOK8zUch
         cJR4HQ7iB6MXUsW9UoF3lzyc1/VBFWsiUgRrdjMfriEWaATLYB3UBKQDNrAasgvstDDy
         yjAg==
X-Forwarded-Encrypted: i=1; AJvYcCVxBJnjnn2XngUqO+zQe9VEVauTmhDbg/jgLhWxdQ9QtjBkn2iwEvaw9tdfizRfyW1BfihHuIOSMzwpgLvK@vger.kernel.org, AJvYcCXv4hwHc8RWVyVTkytLVQjW1HvMSmzbTe2WVBMrAbVfn+3yumqTqG3nHOusn1QtJ21McNBZck9FdQUj@vger.kernel.org
X-Gm-Message-State: AOJu0YygOASXpDJlW9e+/g9V6wPcNxsktQ2yQoCw1Yvtcoz0EPrcMe8j
	BToYsE47CfD1qA8enWKjCt3Ilgx90TL32xoc65mfh4Mavjzf6BPa3PLmJEm7
X-Gm-Gg: ASbGncudaZ9eAhSRo2ITKDGlzmfJP8/1VK31COR7dvL2DPAt/U1aO7ueLvEafFWhToN
	hDFQIzkoaXnjKZfu2UFHFZD90IeAZyjknetgy5Xoyo/ZTllEmlMlqrew0IGJi0TNGSIhasvx/iT
	bvbrCQFNMseIAahLO3I86DUkQbzA4ifUuqDYHrbkWGJnbABD3wbbBPKi0fJejO+S/E/clsm1dI7
	zDSzL9ni932uuYl6TRdKC/LW5KhkAyWiNtQcjNRe7pZBpPc0ZKmVTQwyRxBO6bR8i/WN7sce1HA
	/7TLTMzTnO4lT0At/VkT1+VwOcv1gEQ/EcP5xGeDPaoOAoxo+qVKlqJkUSeoCfgT/QhK3UsaUmb
	Khlh2ecT2lqDOCOxrsyFfx6AqaiABu06RJ1Y6h9b6uw==
X-Google-Smtp-Source: AGHT+IGP8/OyZnqewks6Kb3FAfCj3wws/TIslD8Aq9liJbpvGmt7cLcMoNtdvaKqC2ag2u/cxkjU+Q==
X-Received: by 2002:a5d:5982:0:b0:39a:c80b:8288 with SMTP id ffacd0b85a97d-39c120f7a32mr5836666f8f.33.1743429065406;
        Mon, 31 Mar 2025 06:51:05 -0700 (PDT)
Received: from amir-ThinkPad-T480.arnhem.chello.nl (92-109-99-123.cable.dynamic.v4.ziggo.nl. [92.109.99.123])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d8fbc1716sm121247545e9.15.2025.03.31.06.51.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Mar 2025 06:51:04 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Alejandro Colomar <alx@kernel.org>
Cc: Miklos Szeredi <mszeredi@redhat.com>,
	Jan Kara <jack@suse.cz>,
	Christian Brauner <brauner@kernel.org>,
	linux-man@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH] fanotify: Document mount namespace events
Date: Mon, 31 Mar 2025 15:51:01 +0200
Message-Id: <20250331135101.1436770-1-amir73il@gmail.com>
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

Cc: Jan Kara <jack@suse.cz>
Cc: Miklos Szeredi <mszeredi@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---

Alejandro,

This feature was also added (by Miklos) in v6.14.

The man page patch can be merged independently of the
FAN_PRE_ACCESS patch.

However, this patch depends on the FAN_FS_ERROR cleanup patch
that I just posted, because of the reordering of event entries.

Thanks,
Amir.

 man/man2/fanotify_init.2 | 20 ++++++++++++++++++++
 man/man2/fanotify_mark.2 | 35 ++++++++++++++++++++++++++++++++++-
 man/man7/fanotify.7      | 39 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 93 insertions(+), 1 deletion(-)

diff --git a/man/man2/fanotify_init.2 b/man/man2/fanotify_init.2
index 699b6f054..26289c496 100644
--- a/man/man2/fanotify_init.2
+++ b/man/man2/fanotify_init.2
@@ -330,6 +330,26 @@ that the directory entry is referring to.
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
index da569279b..b843c1f9a 100644
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
+Mark the mount namespace of the path specified by
+.IR pathname .
+If
+.I pathname
+is not itself a mount point,
+the mount namespace of the mount containing
+.I pathname
+will be marked.
+An fanotify group that is initialized with flag
+.B FAN_REPORT_MNT
+is required.
+.TP
 .B FAN_MARK_MOUNT
 Mark the mount specified by
 .IR pathname .
@@ -395,6 +410,24 @@ Create an event when a marked file or directory itself has been moved.
 An fanotify group that identifies filesystem objects by file handles
 is required.
 .TP
+.BR FAN_MNT_ATTACH ", " FAN_MNT_DETACH " (since Linux 6.14)"
+.\" commit 0f46d81f2bce970b1c562aa3c944a271bbec2729
+Create an event when a mount was attached to or detached from a marked mount namespace.
+An attempt to set this flag on an inode, mount or filesystem mark
+will result in the error
+.BR EINVAL .
+An fanotify group that is initialized with flag
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
index 77dcb8aa5..98705c3c7 100644
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
+A mount was detached to mount namespace.
+.TP
 .B FAN_FS_ERROR
 A filesystem error was detected.
 .TP
@@ -540,6 +563,7 @@ The value of this field can be set to one of the following:
 .BR FAN_EVENT_INFO_TYPE_FID ,
 .BR FAN_EVENT_INFO_TYPE_DFID ,
 .BR FAN_EVENT_INFO_TYPE_DFID_NAME ,
+.BR FAN_EVENT_INFO_TYPE_MNT ,
 .BR FAN_EVENT_INFO_TYPE_ERROR ,
 .BR FAN_EVENT_INFO_TYPE_RANGE ,
 or
@@ -727,6 +751,21 @@ in case of a terminated process, the value will be
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
+.P
+The fields of the
 .I fanotify_event_info_error
 structure are as follows:
 .TP
-- 
2.34.1


