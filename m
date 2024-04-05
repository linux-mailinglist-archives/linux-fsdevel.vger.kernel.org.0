Return-Path: <linux-fsdevel+bounces-16240-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FA5589A63C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Apr 2024 23:42:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A115E1F22B8C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Apr 2024 21:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9D32176FBF;
	Fri,  5 Apr 2024 21:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QuG+Qxfc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B777B17556C
	for <linux-fsdevel@vger.kernel.org>; Fri,  5 Apr 2024 21:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712353296; cv=none; b=W01CGgyptgKLaEkbbTtfKPq74iK9ZPDCCmiECAXv8w5lyIz6AQMCxbR5/3jMFHxwYraJNpGJ/mzQHMbn30alK/QaM978IrDGPy6ONGLF22QzhvZ+tyDcqpzpkYkmm1/1cArzKsLPScB/aldRcAYuK4cy8mnTEGcpPzUralYjN5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712353296; c=relaxed/simple;
	bh=eerKUwOAJdG4l07tn4UJJFXLatw+oUupMvi98+9SFSM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tLyAlk+cMs0yJAb1E0XB/1SgZ89VKmVZCuOVcSBfT0xNryn94bWSo5EljkVORH4earKCjdY2JKFzD71skAVerkS4k6fp/cyE8IjZmuYm9ys/RjXEjWZUg1VMvV8fD1oipeifPlBnTOTgCTUagNpmKqfFXHrFa5btBJ9Xn6jgTRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QuG+Qxfc; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-56bf76d4282so2639437a12.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 05 Apr 2024 14:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712353293; x=1712958093; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gfT1cU34Qatifm1LZ7TB36yHQ1WB+M5CqgNm/urbeDk=;
        b=QuG+Qxfci83vAdzMxx/+kBFIL+Cr2P3RV0bzClVXwzBc6s1+saBfAy9vreGy+ViMnO
         o5CO41z4t+M4pjNSREpJYQGLtsHi1+oMbAT91mMJ0ZHvFY1UIm/wXf6xArvrY/68W/Al
         UlpKCkCEpFWxNmmSEFZvtWosRCB1hSatZ/Kaqma6e36Ni7QRf4Mkbi8G3VRNGoiEgX/V
         NzrVAFK+8Yuz7F11T0ZxHK/gGQPCJSJXx4JJKUftUHp3F48kO8l3XD7rwZPEj9hufNQa
         GAshZdvJwROFId9ql6t6w3zH7423y9zcp8p7n4Gh+VLaOc7gau9P0XjM26K3e3a3zoUL
         Ddyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712353293; x=1712958093;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gfT1cU34Qatifm1LZ7TB36yHQ1WB+M5CqgNm/urbeDk=;
        b=HvzDg4wQU8FXxeZ0wYPPZuGlC5kQ4Eyj38nr3ABPvuqdMWVLl/GPb6OgrRFt9ThtX8
         Qe070leUJSM7frHaJwRTBOoyresaTOYR2Ql3Dc9HQ3pdSJJX0gc7tBFzbpYyqYoEfgQT
         oeYBVIWAtEYAytGO0xUvxNARGniL0ZyvBvNVY0FPOsCMM1BQUOGjAxbcLtM/We0Dpsil
         /god+3d+wKUTOJlf/M4rRHxWDqsgU9A8imF5ygbbIDy9LBQc3vITFdWkhRjilux3sjxk
         GMP7qKiGKDPY+0BUCcFgENW9vfrNwRWYbOD/dkj6HpvPp23BDauYMYUuJ0A9VqD5wOnL
         uKyw==
X-Forwarded-Encrypted: i=1; AJvYcCVFOGph3r/RFTeftw2vOEoMVsPzzWh9BfLvEEtGRmdBdVRgMKt7T7R/Arju31P+7MDrzhhb+9N+wG3kZypeui/8s0s6zf9Oy52C3eQsSA==
X-Gm-Message-State: AOJu0YwJN6giOMFcjy0IeJF9E2iAhVgxfue2CAcbO4J4/WWRbyQOJZmS
	WuTe2LW97JZOzo4tFHvI2MzkXiFKiTU4krN0j7s6FPAwkRONnOFP4YBOkbo82hYxeR9WUGt0cd+
	oZA==
X-Google-Smtp-Source: AGHT+IEAdLuUBypZI8eUpc+P8XMt48vwGgNa6irD0KxC4ZtesgZXcC4GYp2ABm0GpsyFPJv/hcaNj/eaHIw=
X-Received: from swim.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:1605])
 (user=gnoack job=sendgmr) by 2002:a05:6402:2696:b0:56c:2c3f:9c82 with SMTP id
 w22-20020a056402269600b0056c2c3f9c82mr8485edd.1.1712353293398; Fri, 05 Apr
 2024 14:41:33 -0700 (PDT)
Date: Fri,  5 Apr 2024 21:40:39 +0000
In-Reply-To: <20240405214040.101396-1-gnoack@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240405214040.101396-1-gnoack@google.com>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240405214040.101396-12-gnoack@google.com>
Subject: [PATCH v14 11/12] MAINTAINERS: Notify Landlock maintainers about
 changes to fs/ioctl.c
From: "=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>
To: linux-security-module@vger.kernel.org, 
	"=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>
Cc: Jeff Xu <jeffxu@google.com>, Arnd Bergmann <arnd@arndb.de>, 
	Jorge Lucangeli Obes <jorgelo@chromium.org>, Allen Webb <allenwebb@google.com>, 
	Dmitry Torokhov <dtor@google.com>, Paul Moore <paul@paul-moore.com>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Matt Bobrowski <repnop@google.com>, 
	linux-fsdevel@vger.kernel.org, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Landlock needs to track changes to do_vfs_ioctl() when new IOCTL
implementations are added to it.

Suggested-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
Signed-off-by: G=C3=BCnther Noack <gnoack@google.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index aa3b947fb080..c95dabf4ecc9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12222,6 +12222,7 @@ W:	https://landlock.io
 T:	git https://git.kernel.org/pub/scm/linux/kernel/git/mic/linux.git
 F:	Documentation/security/landlock.rst
 F:	Documentation/userspace-api/landlock.rst
+F:	fs/ioctl.c
 F:	include/uapi/linux/landlock.h
 F:	samples/landlock/
 F:	security/landlock/
--=20
2.44.0.478.gd926399ef9-goog


