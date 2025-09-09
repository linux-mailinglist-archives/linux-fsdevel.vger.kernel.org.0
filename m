Return-Path: <linux-fsdevel+bounces-60712-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1739B503A8
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Sep 2025 19:01:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE5CA4E4E80
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Sep 2025 17:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67CE5362988;
	Tue,  9 Sep 2025 16:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VJU6HNCA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A2D0362982;
	Tue,  9 Sep 2025 16:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757437074; cv=none; b=IgAI8L9PkFn9ibhqfFEL0aGRXrhajoJ9g4J5q0Ywbl5LdEbVQ/ysKMOmqkXjOeftq+SjPq8DopJ11Ol2LKEfvZGPl5hXzF91ga+IfqPxeNDyN8ul8xWF3l4Y5my7nbLyVhAxusXn37xd0MUPrvGmwPwqEZQAul1k27IENUbcBdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757437074; c=relaxed/simple;
	bh=kJOoCHsdPAISSR4HcFlHZ0fIcM/ZbT9tK9WAAjen35Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GeA44AMt+yGWBnwIVYd3FJGL9bNgWkMFGMzYZpP4bOakYHFCwyDiX5eArqIg6syhn/qEucq3aycf2zsAYMq09dYQtrobwtRtr4H1L5K1YplpW0hWhMOC5GFCEghu5bkw9eL+ZPCSdZm5Rt5QVxAtH9GZ/7SJLc1RaAvGCdxwuV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VJU6HNCA; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-772301f8ae2so4732532b3a.0;
        Tue, 09 Sep 2025 09:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757437073; x=1758041873; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tcYrZ6OBHDvhQxq+aUNrUDX0E+CGMcdoNU7ZBepwhNQ=;
        b=VJU6HNCAsZwYpVz49LDZLjPE++N+jbUE6sAyHYnhb2YfVOwzUVDQBGoaEdj82+INDW
         +hHxUL+q6C0onN+eks7pVAStJPex+PMG+JiKJLRmz4+OUxJrQH++rW/G+jphNGP3iAbN
         SgeXzy7Ii0H2e8/dFsx3fHzrvzaJk04NWGCB4e6SaZNLoumi7Pf9eQBx6/oHXZoGE8js
         OCfB33ndCSwFgFn1e79a6q7kdswazdy+qzdRrMdNZu2784P4yIPrJwAqZDAsj6O0xqt9
         9JOqrJpkDMJtbZAR11K9U6sHWlLTAmU4S9/2PmnFyK2wIgG6wjoJjY+Riqy0B3WmbLL/
         Agrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757437073; x=1758041873;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tcYrZ6OBHDvhQxq+aUNrUDX0E+CGMcdoNU7ZBepwhNQ=;
        b=by27UzCS391PeWDqMF44ouPZZKI7AMkufMSmQlPf3tmFx9miU4cTSNGi8SOsFClw3G
         TiPsYXLQvwkL3Amw15esOR2B/M7Rct4rpkw2FR1w4xnH7MB5Ausqb3e5v8qw6UqStMoc
         2jhR2gaD94lwHP0EHNObaGEiu7R+ij/Limk2cQ1V+BqVl9RPiUNAQx8wUvFX2eiubbo1
         9UrRnyJMG3JUMlDivWHsKYLJ2I+62+WHODElk8yREo/oLKd4AWV+BaLyAnJUVOh4Eu7Y
         0cXbUY12l+rK+GWdRNKspyrispp1LWnWwGpxALl0OTu8aW6ddXNbrPycfuNZ0XDBsd0c
         rwYg==
X-Forwarded-Encrypted: i=1; AJvYcCXZtcre2r/nUVrzPI59kBuOPvxz2Fdq4+kaajCIfL+WAyEY+DbwlnNpzfPOLAE/v76Nzn6OfaWTL+paZjn4@vger.kernel.org
X-Gm-Message-State: AOJu0YxPkZlM2p70yPn4WNX9a8n/IOwyv7h7wSyB1gnKg1lvDHRhRGBf
	7g6GcMUfVRJb0llVEOWqfzv4xmccdhcOvdD5jXNnBaYHrwljV0FboD0f
X-Gm-Gg: ASbGncuzZV8qtqh1egN1IM2ykwEUVXi/gBcn1iR8RcZHnqWPOKHboWgAbRNlSjkQJjS
	zfKpisC3LwsAizyotOkYZrnFgpC0UI86cx/p/qopQYQsFEqrrD8Y5tsoEkwKJwjxjyc0Lw+YilT
	j8fK2aWSVODg/rUtYKeycjbcrz9NppS+V9E52ijuz/S6ErNWuYINx+EpGrYMrTugZIctv/s6eXD
	s40R8VF7O4lrSZxTghOpDyqVyA7zLpHiaU4l6Zt4d8gpB/RyqdZbbDakFDgcPUwd5+kobT16wMV
	PTxmlOhWBIzBPw6RG1eS/roskcH3PpbMXAeK6pOQrDDhRWAlln39gep5G3ptphiF6GD2JgoAvO1
	4l/EgWruXxvrEgZCiw7j1TKT/8fnG07lEBMJoQdJgWCI=
X-Google-Smtp-Source: AGHT+IHnhV/he9U+zS3Hc5dbTMwJzzuVpoO3Ld5KHd9kRLPX6iy5U3g7A3+m8O6Xmjz5yMK64Z/ATA==
X-Received: by 2002:a05:6a20:3d07:b0:243:a17b:6414 with SMTP id adf61e73a8af0-25340a1bf8bmr17603538637.26.1757437072363;
        Tue, 09 Sep 2025 09:57:52 -0700 (PDT)
Received: from archlinux ([205.254.163.103])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-774662f5185sm2615932b3a.95.2025.09.09.09.57.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 09:57:52 -0700 (PDT)
From: Suchit Karunakaran <suchitkarunakaran@gmail.com>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	Suchit Karunakaran <suchitkarunakaran@gmail.com>
Subject: [PATCH RESEND] fs/namespace: describe @pinned parameter in do_lock_mount()
Date: Tue,  9 Sep 2025 22:27:44 +0530
Message-ID: <20250909165744.8111-1-suchitkarunakaran@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a description for the @pinned parameter in do_lock_mount() to suppress
a compiler warning. No functional changes

Signed-off-by: Suchit Karunakaran <suchitkarunakaran@gmail.com>
---
 fs/namespace.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/namespace.c b/fs/namespace.c
index 0a5fec7065d7..52394a2ebaf3 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2738,6 +2738,9 @@ static int attach_recursive_mnt(struct mount *source_mnt,
 /**
  * do_lock_mount - lock mount and mountpoint
  * @path:    target path
+ * @pinned:  holds a reference to the mountpoint pinned during the
+ *           mount operation to prevent it from being unmounted or
+ *           moved concurrently
  * @beneath: whether the intention is to mount beneath @path
  *
  * Follow the mount stack on @path until the top mount @mnt is found. If
-- 
2.50.1


