Return-Path: <linux-fsdevel+bounces-45297-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 53688A75A1F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 30 Mar 2025 14:52:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B71603AABCA
	for <lists+linux-fsdevel@lfdr.de>; Sun, 30 Mar 2025 12:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45AFA1CCEE2;
	Sun, 30 Mar 2025 12:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y5nVRws3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E42190674;
	Sun, 30 Mar 2025 12:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743339116; cv=none; b=KIbbaf8PlXuE+KOT3G9uSmLV1wZKdTjsun2vZ0bY/wfBEw92Qhwr1kI9wvsjgkwj29gESsR8A4ekZ+UKZCGy6/onJmgIE8l6TNu4rj4c4stUkGF3vXSdXSV9T0wXXwqEWOlpxNL3tVUCnHo67O9B69EHkyMQjOcYFITt/7DiVKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743339116; c=relaxed/simple;
	bh=AKDMR/yjMJyt8R/MmKbYh6ARHVWh1GKshMITE176oHU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=G9lJLMDK0eyQ6arA42rnr00WZdq99+vOt9miuU/jzm6NkP6/X1tOiRkral6rx2fc7r/nIdGuEYjrxq761z8E0zR39BiqAOUxsog2zXOSXn+Iy4q8jpYF/IJo+uR5W9ITQWIWS5EjZ0tnAQIWK1Fd3dWUzJ1FMGYgzCXJByXQNzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y5nVRws3; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ac2a089fbbdso653494066b.1;
        Sun, 30 Mar 2025 05:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743339113; x=1743943913; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LRvAfShjWzal4ZnqDGELfVNIjlwJr8NwBc+sugliI0w=;
        b=Y5nVRws39bcluJwHcdbifS3o/Fln5/B5VNvDDuWkKbdum7VPu7cmfYP5JA6tohjoyu
         NoXN2DNvOZ8XwzIz0FVWxNZtMKjZjy9lc0yyvc/fYwE2k1ukfFV2BCDJ82u7ShX812oC
         O1B7kfQ/sM7I4uuqQ1M5g+hQepOrPIy031guaZfy6noYDjkGTX412fFfRI4kz778XRAQ
         wLXFnegNq5tdg4/khHg6NQMmzb2eq94HkbVF7OXvhfU3TxPAKIC01vSZG7ZbLQoodDJ6
         2mie4R7ByGPDBWswFENKINbuo8BVlY7TbaGrAlBUcm1tRFehSP9PGp2UlGsT7kv9O2nQ
         si4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743339113; x=1743943913;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LRvAfShjWzal4ZnqDGELfVNIjlwJr8NwBc+sugliI0w=;
        b=kBO+zFU3y2cM5M8YUTDFhniAA/Hgfk4+rKMwHV9VYcwJULv/ekD7w1E9zaPbL7iJRM
         jLgCCzt46gT12lQnRgjhHk6Rr8L8BUC3GyCJ0ee+pHQcc5uboEi/vfPRV+UJYkQVdHLf
         wtVZ/7I3nYkDL/bxO4wNiqldAWrOJxh5CJmi3BilikhdLFiVekPAoE3yP2GhtL9QvfjR
         mUKNLlF10MyzMqLKbjtwgd/NcsshGunYVEnC+sEq2bV5DwehE5HsOe61wcUfavPLDcU/
         i2Bblnx9l1usnmUp5HkrSqmfDPPJdkRY+Ivz1lzMftVsclTX+rYYC4LZuxrksJqJHs4H
         +fuA==
X-Forwarded-Encrypted: i=1; AJvYcCVqBnTsBJpZS46mnQ9lbpO44aXl3aIuGyRDGLbfTR+oJLUztRcQDIxJaM4QKPx3V2aKZUxtDB/yF9RC@vger.kernel.org, AJvYcCX5KM6pQvgjWKEgiziRpr55QBgiYLOu9t/JEa1nrkQqy1VnsjwkN5UhSlnHBmIA4WqqWScBXJXd+JcAdwot@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/uwRwbl99g2JLyz6NTPJFxTHWmX6FBAJ4CqnYOETPadqY1rwx
	FPziqKeHcIzal5KowPQDoe+oQpiLJKP8nSzZqUSatbbF5JRCPODo
X-Gm-Gg: ASbGncvJ/dzN/RM+S4sqBTjK854zD7JxOsgRhIrRYdu15IXf2HW1n2TRxvn1WUQUyrH
	CoFF1AzOGaQWyUY/9mIWmfD8ikr8fr0wzOVbD9JXuFvwGDPAb+9W9heDwXFP6ekX9sqS8Z3ThOE
	818i5MS2OmXUWlsiknVVeybGU0PkI9MRZI+rBD52K4dVOHY9LLgM4N7QSdgqNtvMJVpbMxh+KYW
	Ha4FoOrSEqJlKFgqShyQScjPJnDpa5rMrYRX3DC/Rp6oGdLWv0zsZAL/O8Nj7WzRtG4PxuNH7mh
	/IXtKBVoFdLYHHAIaOa7kPmawr89pLWTiaiRgaWtZQTvREr8g5X+rh2An0ZQg8v1U5hsQD7nCan
	iniBZkwz3QznE/RvFFTwBJg7W6ED/KwxYLNcYMGZu7CK2zNtp77Ra
X-Google-Smtp-Source: AGHT+IGivUlxzzJUMtME07akTHr07rTihcVBISXoVPzpiqgiFQ2GBVaXLBoUFLBUVpy6KXFUfApbeg==
X-Received: by 2002:a17:906:478f:b0:ac3:8537:9042 with SMTP id a640c23a62f3a-ac736a0dfd2mr485700766b.30.1743339112768;
        Sun, 30 Mar 2025 05:51:52 -0700 (PDT)
Received: from amir-ThinkPad-T480.arnhem.chello.nl (92-109-99-123.cable.dynamic.v4.ziggo.nl. [92.109.99.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac7196ee610sm479238666b.172.2025.03.30.05.51.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Mar 2025 05:51:52 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Alejandro Colomar <alx.manpages@gmail.com>
Cc: Jan Kara <jack@suse.cz>,
	linux-man@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Krishna Vivek Vitta <kvitta@microsoft.com>
Subject: [PATCH] fanotify: Document FAN_REPORT_FD_ERROR
Date: Sun, 30 Mar 2025 14:51:46 +0200
Message-Id: <20250330125146.1408717-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This flag from v6.13 allows reporting detailed errors on failure to
open a file descriptor for an event.

This API was backported to LTS kernels v6.12.4 and v6.6.66.

Cc: Krishna Vivek Vitta <kvitta@microsoft.com>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 man/man2/fanotify_init.2 | 29 +++++++++++++++++++++++++++++
 man/man7/fanotify.7      | 12 ++++++++++++
 2 files changed, 41 insertions(+)

diff --git a/man/man2/fanotify_init.2 b/man/man2/fanotify_init.2
index fa4ae9125..23fbe126f 100644
--- a/man/man2/fanotify_init.2
+++ b/man/man2/fanotify_init.2
@@ -364,6 +364,35 @@ so this restriction may eventually be lifted.
 For more details on information records,
 see
 .BR fanotify (7).
+.TP
+.BR FAN_REPORT_FD_ERROR " (since Linux 6.13 and 6.12.4 and 6.6.66)"
+.\" commit 522249f05c5551aec9ec0ba9b6438f1ec19c138d
+Events for fanotify groups initialized with this flag may contain
+an error code that explains the reason for failure to open a file descriptor.
+The
+.I fd
+memeber of struct
+.I fanotify_event_metadata
+normally contains
+an open file descriptor associated with the object of the event
+or FAN_NOFD in case a file descriptor could not be opened.
+For a group initialized with this flag, instead of FAN_NOFD,
+the
+.I fd
+memeber of struct
+.I fanotify_event_metadata
+will contain
+a negative error value.
+When the group is also initialized with flag
+.BR FAN_REPORT_PIDFD ,
+in case a process file descriptor could not be opened,
+the
+.I pidfd
+memeber of struct
+.I fanotify_event_info_pidfd
+will also contain a negative error value.
+For more details, see
+.BR fanotify (7).
 .P
 The
 .I event_f_flags
diff --git a/man/man7/fanotify.7 b/man/man7/fanotify.7
index a5ddf1df0..7844f52f6 100644
--- a/man/man7/fanotify.7
+++ b/man/man7/fanotify.7
@@ -335,6 +335,12 @@ file status flag is set on the open file description.
 This flag suppresses fanotify event generation.
 Hence, when the receiver of the fanotify event accesses the notified file or
 directory using this file descriptor, no additional events will be created.
+.IP
+When an fanotify group is initialized using
+.BR FAN_REPORT_FD_ERROR ,
+this field will contain a negative error value in case a file descriptor
+could not be opened and
+in case of a queue overflow, the value will be -EBADF.
 .TP
 .I pid
 If flag
@@ -679,6 +685,12 @@ Once the event listener has dealt with an event
 and the pidfd is no longer required,
 the pidfd should be closed via
 .BR close (2).
+.IP
+When an fanotify group is initialized using
+.BR FAN_REPORT_FD_ERROR ,
+this field will contain a negative error value
+in case a pidfd creation failure and
+in case of a terminated process, the value will be -ESRCH.
 .P
 The fields of the
 .I fanotify_event_info_error
-- 
2.34.1


