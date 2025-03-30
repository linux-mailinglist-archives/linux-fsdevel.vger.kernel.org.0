Return-Path: <linux-fsdevel+bounces-45298-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A4D12A75A21
	for <lists+linux-fsdevel@lfdr.de>; Sun, 30 Mar 2025 14:55:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CE62188697D
	for <lists+linux-fsdevel@lfdr.de>; Sun, 30 Mar 2025 12:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A29DE1C9DC6;
	Sun, 30 Mar 2025 12:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lmViGHoC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D2FB360;
	Sun, 30 Mar 2025 12:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743339343; cv=none; b=k3LU/sYRqqGch/3Pby7jPv2hoAtnPrKKuC0MgzRdCZn0ToI1WHfP6jV3Cyb7wD6ceMOCz/gpZw09T2iyDwI//uNV+h4HZoWIcY04j4EeYLpZs25NZcvGjXyYeyAiRBAYk6yMan7s3jK7ZIyA/ROIHbB1hBYXT0VbVrlkSOxKU14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743339343; c=relaxed/simple;
	bh=9UXW7ShMsO190URd9Fsfxi+PYtmMSyW9f5gI0uVcj1E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MNhWkLgx9My0BVTXQ5mFcBSYyfGcyHLAUqN/CnyAlUqCEpZcACu8Wq46MtQnVfueeQ4c/RjYijD7cahI9e6fmbVBlbT688cSjJm2rxHBltl866Zi1qzLROw4rCQp4OSxmSZEedlR0CrL2yyCr5lw27YgVS75LfSDvD8bxBw733k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lmViGHoC; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5e5cded3e2eso5790177a12.0;
        Sun, 30 Mar 2025 05:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743339339; x=1743944139; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4cOcSDYXjoJiYgs05+GDsxBSALPe3P4ZYyzidSbKN+s=;
        b=lmViGHoCz+nMI4A1RrXBl8ByOMpBS68hCdq1+0kUlgBxud8KoQYYYQPopf8SJ9fgQf
         lCMUu/OtPm0A/vwOoZDlFn3rYncHAclg9IGhF/8SDQ3NKkz023G6+/rwsrHRwfmOWfFu
         aLOnK4GGQq14os8w5+3hYZR2FWZX5ihRxJ3zpdT40kCbYMyDFPQi6ewjK5PSCMCPOuyN
         CBJpFVVKbFVyKvnj5pGS5HyJ19A5Kw60VnYrhYsNLy5blQkxP4ADuuQBP1a6qjeZ8Mnr
         NRePAaLkUyi9GPlfY2xKW+JEsZdoRvHdHnURh8wtRgTUlexkCCYv9U5ZiWb2du6Mb02a
         kO7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743339340; x=1743944140;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4cOcSDYXjoJiYgs05+GDsxBSALPe3P4ZYyzidSbKN+s=;
        b=gnxl+NmEVZEZaNXksonIYEkZHcYxgDTFKgqekES0k2hYNqU4vQeph2BGgracq0g39a
         GZ8WNJ6KLGwGz37BelxNmr7e6IVo3hccFkZFrpfiAW5rBbXTTZa5umdNRjuwnk7slAtK
         uXP3pN4elVM2J3F/yUm2d0of/ztmb/c5eFCfNBJvDQPOdAdwd5+5yb1rSIxU38areGJZ
         bsyVaLeQudjTO9ArR6qJZo8Aty9PBS71OzQuTXvdJcyGawznuBGXczUnYXLl3u3dEqXB
         Moyunjze06Y3udUSPPtQ3tfVHW214/ua6OKcEvJu43hFwmbv+Bs8pFjkQxTmZiFsSZ1f
         se+Q==
X-Forwarded-Encrypted: i=1; AJvYcCWLaXgRPZg8/TfZNvwQ3QK7kLjx3GR9sXLyFmeX5piUcLwaEXtNvAnh+hkqi1feMUTri520JRMyCfiO93No@vger.kernel.org, AJvYcCXJe7QKsvg2i3rLZeJQUV19byIGkyxCK5sKFvH79lL/SzDoXrqE8gwQRUPZgOn6mydFZStC8DXdGkKm@vger.kernel.org
X-Gm-Message-State: AOJu0YzriSAbMA0Olk17z7WJImeVfyZKM4WJF2EfOJiNwL+zT2oEZfSD
	aEbRETV34CTbR8E/q7O/iohF3+z90U3/N+pFrm1+ZbGb5EZntOd2
X-Gm-Gg: ASbGncsdN59Oo1S9UT5DSBn56OaDSyQ9LLy0+SuHptagULJcAFX3Eutk1R2U2AKd7rT
	3bMhBoTfI4bxGZGIyvkNjfZEUv4ve/TV1ejky4pQf65TmyUytDWwjVgfRwAhI4wAb1mN6kyZ8SX
	e45m+LM+ob1ya877ND4MLxtl9GIIhYiAslQ3Jsr/u0O9Ancwf6UAcoEB2Badw+mLfVJ9Lf/MeqD
	PDohwCVOd6npS2sL6rXVgBYu051Fo/ua+MToHTxbJALi/vPF3rENynROF7csBy8ErpcTveo+vJq
	c2u4QwSCJoyfH4MhGx2EwjllpstQAZZP3wMcWEJ+VneNAoEh4cY8zuH6BF+hECmwE1D/oZaAwOp
	zPbUnZ3pEo6oySyEfcm2FLK/V3Ye5HQdE87E92HdJ0Q==
X-Google-Smtp-Source: AGHT+IGX++L/KCwmJFyrICeXtikgTDn799wFbUOajeo/7PWIA6vkGd+8tGbGGluqMAuwl0zi10I1Sw==
X-Received: by 2002:a05:6402:d0b:b0:5de:dfd0:9d22 with SMTP id 4fb4d7f45d1cf-5edfd705782mr4767721a12.22.1743339339200;
        Sun, 30 Mar 2025 05:55:39 -0700 (PDT)
Received: from amir-ThinkPad-T480.arnhem.chello.nl (92-109-99-123.cable.dynamic.v4.ziggo.nl. [92.109.99.123])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5edc16d5077sm4261749a12.32.2025.03.30.05.55.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Mar 2025 05:55:38 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Alejandro Colomar <alx.manpages@gmail.com>
Cc: Jan Kara <jack@suse.cz>,
	Josef Bacik <josef@toxicpanda.com>,
	Christian Brauner <brauner@kernel.org>,
	linux-man@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH] fanotify: Document FAN_PRE_ACCESS event
Date: Sun, 30 Mar 2025 14:55:36 +0200
Message-Id: <20250330125536.1408939-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The new FAN_PRE_ACCESS events are created before access to a file range,
to provides an opportunity for the event listener to modify the content
of the object before the user can accesss it.

Those events are available for group in class FAN_CLASS_PRE_CONTENT
They are reported with FAN_EVENT_INFO_TYPE_RANGE info record.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 man/man2/fanotify_init.2 |  4 ++--
 man/man2/fanotify_mark.2 | 14 +++++++++++++
 man/man7/fanotify.7      | 43 ++++++++++++++++++++++++++++++++++++++--
 3 files changed, 57 insertions(+), 4 deletions(-)

diff --git a/man/man2/fanotify_init.2 b/man/man2/fanotify_init.2
index 23fbe126f..b1ef8018c 100644
--- a/man/man2/fanotify_init.2
+++ b/man/man2/fanotify_init.2
@@ -57,8 +57,8 @@ Only one of the following notification classes may be specified in
 .B FAN_CLASS_PRE_CONTENT
 This value allows the receipt of events notifying that a file has been
 accessed and events for permission decisions if a file may be accessed.
-It is intended for event listeners that need to access files before they
-contain their final data.
+It is intended for event listeners that may need to write data to files
+before their final data can be accessed.
 This notification class might be used by hierarchical storage managers,
 for example.
 Use of this flag requires the
diff --git a/man/man2/fanotify_mark.2 b/man/man2/fanotify_mark.2
index 47cafb21c..edbcdc592 100644
--- a/man/man2/fanotify_mark.2
+++ b/man/man2/fanotify_mark.2
@@ -445,6 +445,20 @@ or
 .B FAN_CLASS_CONTENT
 is required.
 .TP
+.BR FAN_PRE_ACCESS " (since Linux 6.14)"
+.\" commit 4f8afa33817a6420398d1c177c6e220a05081f51
+Create an event before read or write access to a file range,
+that provides an opportunity for the event listener
+to modify the content of the file
+before access to the content
+in the specified range.
+An additional information record of type
+.B FAN_EVENT_INFO_TYPE_RANGE
+is returned for each event in the read buffer.
+An fanotify file descriptor created with
+.B FAN_CLASS_PRE_CONTENT
+is required.
+.TP
 .B FAN_ONDIR
 Create events for directories\[em]for example, when
 .BR opendir (3),
diff --git a/man/man7/fanotify.7 b/man/man7/fanotify.7
index 7844f52f6..6f3a9496e 100644
--- a/man/man7/fanotify.7
+++ b/man/man7/fanotify.7
@@ -247,6 +247,26 @@ struct fanotify_event_info_error {
 .EE
 .in
 .P
+In case of
+.B FAN_PRE_ACCESS
+events,
+an additional information record describing the access range
+is returned alongside the generic
+.I fanotify_event_metadata
+structure within the read buffer.
+This structure is defined as follows:
+.P
+.in +4n
+.EX
+struct fanotify_event_info_range {
+    struct fanotify_event_info_header hdr;
+    __u32 pad;
+    __u64 offset;
+    __u64 count;
+};
+.EE
+.in
+.P
 All information records contain a nested structure of type
 .IR fanotify_event_info_header .
 This structure holds meta-information about the information record
@@ -509,8 +529,9 @@ The value of this field can be set to one of the following:
 .BR FAN_EVENT_INFO_TYPE_FID ,
 .BR FAN_EVENT_INFO_TYPE_DFID ,
 .BR FAN_EVENT_INFO_TYPE_DFID_NAME ,
-or
-.BR FAN_EVENT_INFO_TYPE_PIDFD .
+.BR FAN_EVENT_INFO_TYPE_PIDFD ,
+.BR FAN_EVENT_INFO_TYPE_ERROR ,
+.BR FAN_EVENT_INFO_TYPE_RANGE .
 The value set for this field
 is dependent on the flags that have been supplied to
 .BR fanotify_init (2).
@@ -711,6 +732,24 @@ Identifies the type of error that occurred.
 This is a counter of the number of errors suppressed
 since the last error was read.
 .P
+The fields of the
+.I fanotify_event_info_range
+structure are as follows:
+.TP
+.I hdr
+This is a structure of type
+.IR fanotify_event_info_header .
+The
+.I info_type
+field is set to
+.BR FAN_EVENT_INFO_TYPE_RANGE .
+.TP
+.I count
+The number of bytes being read or written to the file.
+.TP
+.I offset
+The offset from which bytes are read or written to the file.
+.P
 The following macros are provided to iterate over a buffer containing
 fanotify event metadata returned by a
 .BR read (2)
-- 
2.34.1


