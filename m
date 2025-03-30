Return-Path: <linux-fsdevel+bounces-45293-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 074B3A759C5
	for <lists+linux-fsdevel@lfdr.de>; Sun, 30 Mar 2025 13:17:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4EDE57A47EF
	for <lists+linux-fsdevel@lfdr.de>; Sun, 30 Mar 2025 11:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F26D81C4A2D;
	Sun, 30 Mar 2025 11:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="goiExD4+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B22584A05;
	Sun, 30 Mar 2025 11:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743333412; cv=none; b=TC6bf8rfnGjzLsoIhQ+bO8eYSAEOwfJS0M1dLADSzjSnYFvw3pnYy6MLyEkbPqgatruE1+6i0T0tr/zNXMfnT30CUBLO8jE/Rqh5I2WoiHGFupxKYYsrOxAhq57tfOvCAqvYc6Pnea7t5HgUMyHQj2x16HKN6FpNh4qnAOTGcos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743333412; c=relaxed/simple;
	bh=1kOwCR5E85BD2rqeLFbvUCWNEaTfRWM8YWNYqRzWeVE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IPJKj3daxLpXMHadjD13/5Fm7SmMeIrqRWl2XZiJRoSmyi8JoOZkpjn3HloGVwKDVzIU8wKaE+19eeMSvMFw5BRLoFjCsvHvxg6JeyWOxldNZ/0K4xUm3RiwDgBta2OE4t7HXY+M8O4JNg74dAt4YdO+wxAz621cYdutWsArFXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=goiExD4+; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5e5e0caa151so6862685a12.0;
        Sun, 30 Mar 2025 04:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743333409; x=1743938209; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VgZH5L9lFrqomJIPiJeUyW+pbC1ukrLQGaub52yc6ZQ=;
        b=goiExD4+l1jseSwKMqGMjul2+KIKE2E+DpF3gHkJEV4TJhUxvoSipMWvHmdGrvCFhP
         LjklaPMdww7C9O4dL61aMbrCVQwq4ob1I6k/eeYaHsdbVmeg6GXCB823Qf++ZDmB5lRB
         SGFIe5YAPe9zmC8VPLrmDrwO3HMEQXMzC7ygHTv1QOU2w6w+wRwPKxKzJkiq10M7grtb
         EQ2vbjQA2zdoNJeRx4rFfdBGPsVzl1As2o/eEhmnckIx0UaaPFnxh9RTtA6D5/34N14B
         9x0TnG46a0lTp/CCJY5evP0FXJI84HLcKRWCn+GhBxndlAulWYd9ZdRh/6YnY2s8HKN0
         vPHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743333409; x=1743938209;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VgZH5L9lFrqomJIPiJeUyW+pbC1ukrLQGaub52yc6ZQ=;
        b=XA5qmyiM7IvCW2P31QTkWNANYvBW6YBd81Hhyejmgq7Vy3GwI3Po+OEX2NjcEr5z1K
         3D6jhOVkSS18OnzxHKsUBNZDY9+XQ3EQuh5/6gTcDrd5nfXHWV5KbFbF/njhEIeauY41
         p+V5fZlONFW4BYqNUpxIU6e+9/1OQs9+KrMoV7ZEvqMpmKAkr/TJEUq/Os03ClsWf18j
         Z2ZY+BTG5LCjhXAnXLsl8Gr5/l2dwwJx8RKeVqPEue17wPHQrJTzd83O3A/AIYijJDwq
         WgSOG92tTe9LC7twJRm7z2rbR5xFr3ugHhXTavf/BYt6z1gSwETXM8SGvJ+vODzybHjz
         /7Yw==
X-Forwarded-Encrypted: i=1; AJvYcCVA1QlytoKrQbUfL1v4P/9QF2InShXXWXxdmS+tDB21httJl6UPGfAuoNtesGpRrCV8wabAIFSyAWAhy1Zd@vger.kernel.org, AJvYcCWHJw0QIb9Jt+4rrZ0XftxRhbD+PKOdpQGi3sWGDMC0lfVXuxTcRPA0qfiwzi2ykvkSEYSLb5yH0VAc@vger.kernel.org
X-Gm-Message-State: AOJu0YxT9U7odmJUaB5QuJAM0gcVEA09MC3n5sDGar8b+rUKjnDaQOyc
	xEMdXjfxEPiE/3i+k0naHUAkHKcld/VePrx2/5JpJnpVhieh5wOH
X-Gm-Gg: ASbGncseVGi6BCYMYo8Ounm22CSMLeu2Zv+49P/jFU/25RcXoeNYHijU6LWWq8l4ule
	uYiW4mLXp+4r9oFdpodud9PiK1oXzLMycqLDYd0OGAgvp1GIv5D8D72uKSQKQZeRgJcnd//Np1y
	X0mRxrJpjfbhBrIbDKVA9FmgsadOB3HQvRB2/Wh5G065H47iYsVKzF7B1EP/DrURpuR6RMXbDIt
	3uhsHK7C9SDsh+TQ6ZmdWCdzsu6TN3LnczjxS74HyzjyW6xaMrc1GsqoII14iiNowxB/tk4ukyF
	jAR4cs2u/FhEhDKjrPGvnKVL4aG12vL2aDa3Vysnd2rCH3A0uxq167jbh1HJodIRwqulnIIXVO8
	JvWrxXao2MN8Z713bibjrgS880uAZsDI8QJCMRXWvYA==
X-Google-Smtp-Source: AGHT+IFZ9Bq+WdkHnKM1l3YwdpwU+U1iG1R9tz7Ih7ctraO+lCAJs5LRIJLkuDC71lF3vvwtRor+GA==
X-Received: by 2002:a05:6402:13d1:b0:5e5:dbcd:185e with SMTP id 4fb4d7f45d1cf-5edfce76db3mr4755592a12.13.1743333408499;
        Sun, 30 Mar 2025 04:16:48 -0700 (PDT)
Received: from amir-ThinkPad-T480.arnhem.chello.nl (92-109-99-123.cable.dynamic.v4.ziggo.nl. [92.109.99.123])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5edc17b2abesm4136014a12.60.2025.03.30.04.16.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Mar 2025 04:16:47 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Alejandro Colomar <alx.manpages@gmail.com>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@poochiereds.net>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	linux-man@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH] name_to_handle_at.2: Document the AT_HANDLE_CONNECTABLE flag
Date: Sun, 30 Mar 2025 13:16:43 +0200
Message-Id: <20250330111643.1405265-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A flag since v6.13 to indicate that the requested file_handle is
intended to be used for open_by_handle_at(2) to obtain an open file
with a known path.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 man/man2/open_by_handle_at.2 | 31 ++++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/man/man2/open_by_handle_at.2 b/man/man2/open_by_handle_at.2
index 6b9758d42..ce3a2cec8 100644
--- a/man/man2/open_by_handle_at.2
+++ b/man/man2/open_by_handle_at.2
@@ -127,6 +127,7 @@ The
 .I flags
 argument is a bit mask constructed by ORing together zero or more of
 .BR AT_HANDLE_FID ,
+.BR AT_HANDLE_CONNECTABLE,
 .BR AT_EMPTY_PATH ,
 and
 .BR AT_SYMLINK_FOLLOW ,
@@ -147,6 +148,29 @@ with the returned
 .I file_handle
 may fail.
 .P
+When
+.I flags
+contain the
+.BR AT_HANDLE_CONNECTABLE " (since Linux 6.13)"
+.\" commit a20853ab8296d4a8754482cb5e9adde8ab426a25
+flag, the caller indicates that the returned
+.I file_handle
+is needed to open a file with known path later,
+so it should be expected that a subsequent call to
+.BR open_by_handle_at ()
+with the returned
+.I file_handle
+may fail if the file was moved,
+but otherwise,
+the path of the opened file is expected to be visible
+from the
+.IR /proc/ pid /fd/*
+magic link.
+This flag can not be used in combination with the flags
+.BR AT_HANDLE_FID ,
+and
+.BR AT_EMPTY_PATH .
+.P
 Together, the
 .I pathname
 and
@@ -311,7 +335,7 @@ points outside your accessible address space.
 .TP
 .B EINVAL
 .I flags
-includes an invalid bit value.
+includes an invalid bit value or an invalid bit combination.
 .TP
 .B EINVAL
 .I handle\->handle_bytes
@@ -398,6 +422,11 @@ was acquired using the
 .B AT_HANDLE_FID
 flag and the filesystem does not support
 .BR open_by_handle_at ().
+This error can also occur if the
+.I handle
+was acquired using the
+.B AT_HANDLE_CONNECTABLE
+flag and the file was moved to a different parent.
 .SH VERSIONS
 FreeBSD has a broadly similar pair of system calls in the form of
 .BR getfh ()
-- 
2.34.1


