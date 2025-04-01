Return-Path: <linux-fsdevel+bounces-45476-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BE1AA782E4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Apr 2025 21:46:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D328816E365
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Apr 2025 19:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D53FC20B7EA;
	Tue,  1 Apr 2025 19:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cjJx4T+u"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A3311C8610;
	Tue,  1 Apr 2025 19:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743536796; cv=none; b=n808B8cwXoMfrz4tpir2hF8RurbY+HCGoydJJ3hUAQzMNfG1u89M3yQJ7qT2nm9gOap6jC6PqI33HWGzm+Z5vPGGBCc/6UOwYlrcbb3OfzJaLjQV7bCppBLLQ0GeEJAnJopb3Uj0kXvTiXT2n+8LyViWnEcrePEnCOhfJrlBLos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743536796; c=relaxed/simple;
	bh=5yUYXQwWcttSqzsPgExp7IA+mKz+cWZikDaudiDjZUc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lsyhuUBPy22iz6pip6uh5F5EVF3Sl5Ze0Fpq+24fCY+wmY5G05Z55VwVXfRkv0v7E5LJ96H7Q7xLYBW1JPYxF8PQF/kti08JLN9wK1k9pR73OV2I1/b/Hn0qsc8hiFc4AuOrlILGvubrBcTsu3XNd6FRExJtsmpn7wrU+K2ppvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cjJx4T+u; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ac3eb3fdd2eso1090944966b.0;
        Tue, 01 Apr 2025 12:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743536793; x=1744141593; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+GkoHMT0bQu2/4Un24c4lILoy5xv01SLUiZEvfrk9k4=;
        b=cjJx4T+uRAuG0WKVP5ap3q5EJV9/5STHTMobMfeEzPlaIqkMGtsqgxdJRWVHnvXBc5
         mjqef9Tiu7zg40XuXajuSsxLRNCpWSTeajTy+IbUQEWffwFgfDqzxXHJbLUwc0VEc+Wn
         u5gk6CDbAhOLP88jBpGtC3dbKoA3MFf+q7CwC3l3GyRY3uo+/zlHRbslLEJtcIKizaGj
         c9TwzCTbm08Aak3Dbj84hYJakSnrdaHu5x8Rrx/3d74vdry7FnFpdH4oMTacggVE2K1j
         W4QbQItxoV0KbOVcU0cJGqayW1Qv+eBz+XdqwXgKdM39tMCxOGF7RrYneXR1L85rFayH
         9hNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743536793; x=1744141593;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+GkoHMT0bQu2/4Un24c4lILoy5xv01SLUiZEvfrk9k4=;
        b=I0sM+FzlyaUugY2W27+QEZfmFcdDVb9Izg3oJeHmFSiVs6LL1EXRmVxNz0GV+QqjIP
         ezOUPtBSe8fYKrZLhxUA3HNRRB6jCwT1+uLif52vBWGr5ee8ik6veGOIxsx5aC1zk7Bz
         wItWVVEPyob0y4uoefT6ljo52K198mQvULPhv2qtOiXxmxz/qK6gmiDL6D6PzdJf6jcD
         WdLz8lN0z4d5fRYXyWh1FOlr0dioKnS5jT6SCkOfEbxRZf75h1kqUWUT0FBDtX75jcC/
         XXtUaOiPFjhYtVvkdD23eEKVrwB2NPcW2BMG+MoY0qHh/RL/zGCkuU66wVzFgOWdzVvq
         9LvQ==
X-Forwarded-Encrypted: i=1; AJvYcCVHbmUox6uOBP7z5xmyPEOfD6PzlBQuJauN4ewwmn4eKUWty7hV421+v82zQEXpODr/8eUxWzVmTS7RokTK@vger.kernel.org, AJvYcCWNG+W51vWQrzmzU3N8MFR6/p4htwMYfpGPYq0W0+EGmVw7ETsNyzieQmeymAQ0c7s4QtaJWWFU2Acm@vger.kernel.org
X-Gm-Message-State: AOJu0YzuOC725v75gtHb1bI9iKlBOp9Q1lTFfz7b1Pjx3FaZlMxTmaZz
	hep4Eogq6+ebUusOZ6EnKF6tCZfXnhHOX0TEyQvEDZWZmQ9pqc81
X-Gm-Gg: ASbGnct+4HWvMY2B6WC58ZdCdFwGwh3hJgld6AWv91wyN6WR0RyAmBzedVH97m0ogHO
	8+FrIk4LHkYZD4grcHivILAq5g6gWec7DazZnqKydYLNycKptGSqkRv0DGM+5Yr0ffvgO65GTEK
	3hI801cXsBRrmPuJHOgZChXqHKeWicIP+g1nhNZOzHo/QkSUxcSFvFzrVAhowAb8rJIC6HiVhBn
	Nj/jeo805WihM+E9KMcef6JON2x2UOyfYO/UTmIU0ql2UO3UC2uMqLSdlg70n2HesIVoHd1I/U0
	KeCX9Np/g2qGQQxaYvNH9zlSj0AKcI1bYqsNG5zxNCziyOsAsdTuUYtFfrLmWXSjJLQp9gk+PHV
	7hXmr/zdgZULZ9s9bVXsNbOfaTtGRwyRGt/f4rxaUIy2XxvfgtT81
X-Google-Smtp-Source: AGHT+IEZzyuCWNWcIeptuLmQ2COLd7K7aUt3m1VMOJLXK4Gl8VGwAglHn5XEDieKeHs38ZH7xPTNoA==
X-Received: by 2002:a17:906:dc92:b0:ac6:e33e:9ef8 with SMTP id a640c23a62f3a-ac782af7cb8mr367441366b.2.1743536792225;
        Tue, 01 Apr 2025 12:46:32 -0700 (PDT)
Received: from amir-ThinkPad-T480.arnhem.chello.nl (92-109-99-123.cable.dynamic.v4.ziggo.nl. [92.109.99.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac71922bac7sm808329066b.21.2025.04.01.12.46.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Apr 2025 12:46:31 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Alejandro Colomar <alx@kernel.org>
Cc: Miklos Szeredi <mszeredi@redhat.com>,
	Jan Kara <jack@suse.cz>,
	Christian Brauner <brauner@kernel.org>,
	linux-man@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2] fanotify: Document mount namespace events
Date: Tue,  1 Apr 2025 21:46:29 +0200
Message-Id: <20250401194629.1535477-1-amir73il@gmail.com>
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
Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---

Changes since v1:
- Add RVB
- Add reference to statx() unique mnt_id (Jan)
- Fix description of MARK_MNTNS path (Miklos)

 man/man2/fanotify_init.2 | 20 ++++++++++++++++++
 man/man2/fanotify_mark.2 | 35 +++++++++++++++++++++++++++++++-
 man/man7/fanotify.7      | 44 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 98 insertions(+), 1 deletion(-)

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
index da569279b..dab7e1a32 100644
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
+.BR /proc/ pid /ns/mnt ),
+the call fails with the error
+.BR EINVAL .
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
index 77dcb8aa5..a2f766839 100644
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
@@ -540,6 +563,7 @@ The value of this field can be set to one of the following:
 .BR FAN_EVENT_INFO_TYPE_FID ,
 .BR FAN_EVENT_INFO_TYPE_DFID ,
 .BR FAN_EVENT_INFO_TYPE_DFID_NAME ,
+.BR FAN_EVENT_INFO_TYPE_MNT ,
 .BR FAN_EVENT_INFO_TYPE_ERROR ,
 .BR FAN_EVENT_INFO_TYPE_RANGE ,
 or
@@ -727,6 +751,26 @@ in case of a terminated process, the value will be
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
+It is a 64bit unique mount id as the one returned by
+.BR statx (2)
+with the
+.BR STATX_MNT_ID_UNIQUE
+flag.
+.P
+The fields of the
 .I fanotify_event_info_error
 structure are as follows:
 .TP
-- 
2.34.1


