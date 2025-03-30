Return-Path: <linux-fsdevel+bounces-45301-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95458A75AA6
	for <lists+linux-fsdevel@lfdr.de>; Sun, 30 Mar 2025 17:33:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D1FF165F16
	for <lists+linux-fsdevel@lfdr.de>; Sun, 30 Mar 2025 15:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E86A41D6DC8;
	Sun, 30 Mar 2025 15:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WTPvvIGL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E8C10785;
	Sun, 30 Mar 2025 15:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743348814; cv=none; b=ErSNG1tH/jNiN/Zv8UA13PbpnI22iembRK9GxW93+38n+0lBUfZUxpGPu1ISsGdPrU4tBrkVcZV+FSTN37OK+5ZgzxXKTZpxUjOF6j7x6PTbyEiiaphv/MaVHARy1VhsQEfT3Akxig6wCIfcje4dWDaSe1LGwXCtGmG2Bvb+A28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743348814; c=relaxed/simple;
	bh=9QlWzno58XyR1h/zLxeQ2QMHS9b7ewxFun4RrKzC+rU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZwRxDTsZ8rRhhrvOJEP8jyPjRcMrBnxRVlkw+SNr2VhQaBMaMrrxcrbep6V++ijtaGrBoPtGGAFT1MfXtvsERYzsXiD6esA0fEic8Euh+RKDkyj1PCQDspsVLD7p1W80fjB7xoR2Gz0iVXD1Smsw4nLRNtU+BU6dnMYyjsvH0+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WTPvvIGL; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5e61d91a087so5938923a12.0;
        Sun, 30 Mar 2025 08:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743348811; x=1743953611; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LJYTkW7Lvyl2uH8anCEoiKEqzHmNJog1UdReBZaulNU=;
        b=WTPvvIGLt63jNdXE+7eSuKMQFmGeuOPGhl3OSO48AxhsIMgmaYPLRgHsF5jsZD4wK5
         mgLie8Qko4OHrLT7dbMurvp0nDLLQrQ5xZh3AmHbmMKyzzv+gQzaL5IKI9sy/ZloRxpB
         DFunfRdWxYFD3tTzMjxaS1YQM4EYi0CtEyL6r3Oz2mqMhN2A4a1rGPY/DEr/MBd5/Kdm
         vmDPbsUfsocegEHz4uCNwvdAkoaCj8YSD0LnvDUpEOc0V1+nlc/gr+NNEV6SWwNfLaY/
         4phZNX12al1gljLQ7U6UFN0L5mBkYoYxBdk4+sqLejTbMMqSWbSiTfkfk/Mwb7WnjUIa
         6iNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743348811; x=1743953611;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LJYTkW7Lvyl2uH8anCEoiKEqzHmNJog1UdReBZaulNU=;
        b=LeoXUh0ajMk4Su72kKu3POO2QINnQ/vFoaucy+YT+an1jeEqEe0OZ3P32oDehR+pn/
         iuB8JUtAtOsKfeMuGjwAnTQX/v80W39PtsKjA5kLMvmnYzAU1soGcLBeXvI0gyliz167
         MDbynXzqDURkFuBGrSZbd4LGdO/meM6LHBXdWgkanMvIa8KrMkFQoMzh6s+EqQQStwb+
         V9eZyCJBu3oMa119geE1aca9g9g9Kg+vG1b1k3HYrQwmFLIxu+3FSG6WFgoi1olX74ng
         TRU0LZN4F/9rzboOic7RixRWI2vJPcuC4B3X36RBtCtyoRhfr9e0AF5wFcw+LV9imhvv
         QmgQ==
X-Forwarded-Encrypted: i=1; AJvYcCW0ua6w9eRYghmMq+6NuAxuRxs4g4tEcaDiuYNN0U5/8lQ4bs8XooPV4pP8oaJOFUd709Da9CjkPzkX@vger.kernel.org, AJvYcCX59E6FqGIz1rCPe0M/Y0I2wmZe3xUj+dMK2JgW/6Noc5IU3tKLr6TSfh7/WMEQ4Ldta/SOwkB2C0K8tvbB@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/ybLbyFyPBcgT2gB5mgVtvo2vMRfPcXyX7dEry52jD8sTLZSe
	E6HcSX7LdXetXYRYVagY5tXNdVdqVXIutst2Hahkas2An/93jle6
X-Gm-Gg: ASbGncsseaML3HWhJD0La7bYciQgeeRCsSmwD0+8YnMP8D/Livjfb1CwByyvJXdqCkY
	Mw7lCn/hyNQsIvw8FCzeRNll45SnIF+US9tQzmDj7QT61jwtm44KoSKnoSOppnU58hlFgTS0F46
	/y4mT0kinFWPHKICSUZl1PPVv4E2eEEil1FmbWbOQ9m8nAqZgREzuml0yRBlae6eKPdOUuSksZ2
	gvAeONJKekpQKCzkwS5peJ9ZYc3ftWIolbdUfWWAvHEeqZY3fx8nBdYGyW2oain8KB1J6bqN4/r
	tQKrH31O2GY59ptBSQHw8yZNcf6WyTVt6eLxcG5fxihTms4ZOz9bH3SRjJz3N/g/4Vf2KX5uOlN
	vVDpp/fkDY03pcltTFTWckD3SY/fkRIvILSI2A+ssHw==
X-Google-Smtp-Source: AGHT+IG5IijeJ2G4lFlSbYr1vhIZCCimFZzJGcyibs2brNXwUSb9ktr6h3dazrHHNJy841O8SINcpA==
X-Received: by 2002:a05:6402:5254:b0:5e4:92ca:34d0 with SMTP id 4fb4d7f45d1cf-5edfdaf9104mr5167195a12.20.1743348810263;
        Sun, 30 Mar 2025 08:33:30 -0700 (PDT)
Received: from amir-ThinkPad-T480.arnhem.chello.nl (92-109-99-123.cable.dynamic.v4.ziggo.nl. [92.109.99.123])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5edc17b2034sm4365575a12.51.2025.03.30.08.33.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Mar 2025 08:33:29 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Alejandro Colomar <alx.manpages@gmail.com>
Cc: Jan Kara <jack@suse.cz>,
	Josef Bacik <josef@toxicpanda.com>,
	Christian Brauner <brauner@kernel.org>,
	linux-man@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Richard Guy Briggs <rgb@redhat.com>
Subject: [PATCH] fanotify.7: Document extended response to permission events
Date: Sun, 30 Mar 2025 17:33:26 +0200
Message-Id: <20250330153326.1412509-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document FAN_DENY_ERRNO(), that was added in v6.13 and the
FAN_RESPONSE_INFO_AUDIT_RULE extended response info record
that was added in v6.3.

Cc: Richard Guy Briggs <rgb@redhat.com>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---

Alejandro,

I was working on man page updates to fanotify features that landed
in v6.14 and found a few bits from v6.3 that were out of date, so
I added them along with this change.

If you want me to split them out I can, but I did not see much point.

This change to the documentation of fanotify permission event response
is independent of the previous patches I posted to document the new
FAN_PRE_ACCESS event (also v6.14) and the fanotify_init(2) flag
FAN_REPORT_FD_ERROR (v6.13).

There is another fanotify feature in v6.14 (mount events).
I will try to catch up on documenting that one as well.

Thanks,
Amir.

 man/man7/fanotify.7 | 60 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 59 insertions(+), 1 deletion(-)

diff --git a/man/man7/fanotify.7 b/man/man7/fanotify.7
index 6f3a9496e..c7b53901a 100644
--- a/man/man7/fanotify.7
+++ b/man/man7/fanotify.7
@@ -820,7 +820,7 @@ This is the file descriptor from the structure
 .TP
 .I response
 This field indicates whether or not the permission is to be granted.
-Its value must be either
+Its value must contain either the flag
 .B FAN_ALLOW
 to allow the file operation or
 .B FAN_DENY
@@ -829,6 +829,24 @@ to deny the file operation.
 If access is denied, the requesting application call will receive an
 .B EPERM
 error.
+Since Linux 6.14,
+.\" commit b4b2ff4f61ded819bfa22e50fdec7693f51cbbee
+if a notification group is initialized with class
+.BR FAN_CLASS_PRE_CONTENT ,
+the following error values could be returned to the application
+by setting the
+.I response
+value using the
+.BR FAN_DENY_ERRNO(err)
+macro:
+.BR EPERM ,
+.BR EIO ,
+.BR EBUSY ,
+.BR ETXTBSY ,
+.BR EAGAIN ,
+.BR ENOSPC ,
+.BR EDQUOT .
+.P
 Additionally, if the notification group has been created with the
 .B FAN_ENABLE_AUDIT
 flag, then the
@@ -838,6 +856,46 @@ flag can be set in the
 field.
 In that case, the audit subsystem will log information about the access
 decision to the audit logs.
+Since Linux 6.3,
+.\" commit 70529a199574c15a40f46b14256633b02ba10ca2
+the
+.B FAN_INFO
+flag can be set in the
+.I response
+to indicate that extra variable length response record follows struct
+.IR fanotify_response .
+Extra response records start with a common header:
+.P
+.in +4n
+.EX
+struct fanotify_response_info_header {
+    __u8 type;
+    __u8 pad;
+    __u16 len;
+};
+.EE
+.in
+.P
+The value of
+.I type
+determines the format of the extra response record.
+In case the value of
+.I type
+is
+.BR FAN_RESPONSE_INFO_AUDIT_RULE ,
+the following response record is expected
+with extra details for the audit log:
+.P
+.in +4n
+.EX
+struct fanotify_response_info_audit_rule {
+    struct fanotify_response_info_header hdr;
+    __u32 rule_number;
+    __u32 subj_trust;
+    __u32 obj_trust;
+};
+.EE
+.in
 .\"
 .SS Monitoring filesystems for errors
 A single
-- 
2.34.1


