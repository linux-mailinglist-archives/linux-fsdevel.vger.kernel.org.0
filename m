Return-Path: <linux-fsdevel+bounces-17309-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 729408AB305
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Apr 2024 18:12:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E6B5286293
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Apr 2024 16:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD21E1350D8;
	Fri, 19 Apr 2024 16:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4LK2No8l"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C213513174E
	for <linux-fsdevel@vger.kernel.org>; Fri, 19 Apr 2024 16:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713543121; cv=none; b=Vq6BhA8so0qqja7f/RdYUrmp3rvmIpIBb17PwoiJtfb5DpPxnaf7cJknizeVhLjhs8XaITpys0KwOSdMlsi+El5d17/2IDysqfZOIaDgI8S/MBuHzLjsPpF8Z0vRGXZ4k4HWcbNpIHfnO4f2U6dmtFKGffNqbL3MYjkIcJG639c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713543121; c=relaxed/simple;
	bh=8Sbz6xPy4d51xqBFXjUr7rr4WXtoUD0T6JNeQh6Hv+s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jRKXLMzV1Ck3TWZLG8JhQVwCPt7GNei3Zkt6/qBcS+28lcf4BI1KfaY4JjqhuDOYdrksisnfZbtwFuX8ntiE6SezPJ6WexMpu5ZThvw62Ro4hBuVpnZrnCec6P1x0NDDPCbfSbpUAyRAq+ueg4StPz4U2cu3cpeXWZUmqDJAJVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4LK2No8l; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-5684c1abc7fso1039549a12.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 Apr 2024 09:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713543118; x=1714147918; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uYJ1G6THEcze8HV6qNPokLaKgVvE2KbB4dc/k79IC8Q=;
        b=4LK2No8loMrTom6nTOt5Upwto8B+/3gWA4nfb6XfjTaj1MMf3bg7wUsZ0SrSRpGGea
         i/mXaNJkzbxSuiWPh5VIK5l76pVasaY0kHba8GfTK+CtB8Qak/0xoA8cdG7BdrlTLYLB
         kr8edCqt+MLM+YT07m+z0POlwYNXF4L8ofnfXZy4u0wGBGFbaZhTGHAtjPAC8ngZTQev
         lhVRDIn4VDRFDZJVHsqo0mDaJYnnUVuVZzgjbgma9R/BSlg2Ejkf9OQVtDHKEGFbve+j
         FeCnO4Yk328RqRLDIwAtBf2ysBICS948Cafi9LVmemwfEniLBAhHgtwEbbS7eTRhb/Yz
         4PkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713543118; x=1714147918;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uYJ1G6THEcze8HV6qNPokLaKgVvE2KbB4dc/k79IC8Q=;
        b=Mv/dBAsg8RvCxhAlIP8K3rOnaCZnpoD+UN/G3aC7eoz8wwfCH+LfNSO32YFTSi8D6g
         mi07HU05URcBgTlgoyiYeUP90QqPeLs0sm1kJ8kVWoJsW9LnrpIC6GpbMOgHYl4m/Hkq
         4EHz2gGyJ/8SABE22LVIi5/VvvI6vW2XBbdXO/E5oQ2O8TwKSJfn28A2xH+sxpiLpqxD
         wAVVb6PylAGMaSfUlVjf9KtrlwUYqXt/Soat8/fRsjQyFd1T5qtWVmsnex3/kD75C3jO
         fVx+2WgLnxXYLjQ/3W4z9/u5OrXqGNcW+XMXrAs7wLV/KkL7ZmLH18DBT6LDlfOeVslu
         Zq0w==
X-Forwarded-Encrypted: i=1; AJvYcCU9vjxu7NAl8ggh5ES1U36P8w83biTQIaWYwtsxQ1nh76owQ2xIpNrNdbYVFWf6kBYnjP2Jzx5IUGshG6e6cUFYwSmJK+S8vAiIH/1CFA==
X-Gm-Message-State: AOJu0YycTEI3YUDnF9AWBKX0bMMbxEYN3q36xvkPT2y8qyH1kS/t4sln
	eLpfyslTN12kS94xfMIFsPZR8YJcQu6MNUE3vbSFmxQORXLm033S/Ih0KSDOnYiWlZ44iLaGgui
	0+g==
X-Google-Smtp-Source: AGHT+IHuqJ6fDnXePgWibwQg8qrPjCoaQNWEKwLlyy2KbeP1gomSkjsl8Zno26ZWu1ih/CLcKUSmw/5lUOY=
X-Received: from swim.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:1605])
 (user=gnoack job=sendgmr) by 2002:a05:6402:5408:b0:56e:480f:c98c with SMTP id
 ev8-20020a056402540800b0056e480fc98cmr3192edb.5.1713543117257; Fri, 19 Apr
 2024 09:11:57 -0700 (PDT)
Date: Fri, 19 Apr 2024 16:11:22 +0000
In-Reply-To: <20240419161122.2023765-1-gnoack@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240419161122.2023765-1-gnoack@google.com>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240419161122.2023765-12-gnoack@google.com>
Subject: [PATCH v15 11/11] fs/ioctl: Add a comment to keep the logic in sync
 with LSM policies
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

Landlock's IOCTL support needs to partially replicate the list of
IOCTLs from do_vfs_ioctl().  The list of commands implemented in
do_vfs_ioctl() should be kept in sync with Landlock's IOCTL policies.

Suggested-by: Paul Moore <paul@paul-moore.com>
Suggested-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
Signed-off-by: G=C3=BCnther Noack <gnoack@google.com>
---
 fs/ioctl.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/ioctl.c b/fs/ioctl.c
index fb0628e680c4..64776891120c 100644
--- a/fs/ioctl.c
+++ b/fs/ioctl.c
@@ -796,6 +796,9 @@ static int ioctl_get_fs_sysfs_path(struct file *file, v=
oid __user *argp)
  *
  * When you add any new common ioctls to the switches above and below,
  * please ensure they have compatible arguments in compat mode.
+ *
+ * The LSM mailing list should also be notified of any command additions o=
r
+ * changes, as specific LSMs may be affected.
  */
 static int do_vfs_ioctl(struct file *filp, unsigned int fd,
 			unsigned int cmd, unsigned long arg)
--=20
2.44.0.769.g3c40516874-goog


