Return-Path: <linux-fsdevel+bounces-55857-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D1A65B0F5FE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 16:52:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F2147ADA10
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 14:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5D962FE31D;
	Wed, 23 Jul 2025 14:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="Yyy7zBhk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B2D2FBFFF
	for <linux-fsdevel@vger.kernel.org>; Wed, 23 Jul 2025 14:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753282056; cv=none; b=nPFltWWsQ5i8owuLUZG4fqjbyEva/Cz+A1ad2coER1ws0Bp4QSZhUxyUOtW5QnNmsjJeajVNla/USL5EkUflQ2DhrfDfAD5aJFAGSESY27YQshKp94hKKmLgh4vB+FLG2NcjeRkldlX9OLGQMhKHeb1KBw7PqoNMi44JzkmtR6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753282056; c=relaxed/simple;
	bh=MeL5rpabCOQ9W64WCDzEoX0aCqKWSq3A09PvP5YRATc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sRZLUdAF7tYUy32/xHYgFgRWyFZp6vqW1iJZ8yrm7yCw8xZS9SE8knvT4h2a8bHKs+wkymrZ7ONCmzm1uPj1BujE2bOgAP0P7iWJziFb1aPnH8PGZvPX6aPdjRINDWWStj9HloKj73VgkDuDVmKVYrW9ihDSUszwE2Z/sx3tQMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=Yyy7zBhk; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-718389fb988so65763297b3.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Jul 2025 07:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1753282051; x=1753886851; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+FWnE5Bow2uoaZcwISvBgq/4l5cKqkAoia4t69mDLc0=;
        b=Yyy7zBhkzE9t6E8ma3qmVy6Xxm+sC68V/EvMLhqxTwRVXtMOh14j3t1ZR3jFnbZhVL
         gCkDWN9JRIpqI0pgC4qc/1p1lbggJ45t6IGJjc4xPt4zCxPSiAf+WEr71IZGBO3tpMt9
         eEX17hJV+76mpL8wSoMwgWYa/2ogjO5ld5LF5aJ1V+YRv3HP68kBDUx4NY237tGtBCOR
         PTOYqBRUi/RVpW0msVaUOV57yLYuQc/88nP1HQY0dao5tosixpnQXVvdFwRIwv8AiwE+
         DGy6dn5kCoPB5xFMr4f1quxO+OyymmeG7L1abtzK0tX74IoFqMDmbW7ibeukt4TASkub
         2HMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753282051; x=1753886851;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+FWnE5Bow2uoaZcwISvBgq/4l5cKqkAoia4t69mDLc0=;
        b=O/16B/e5uqH5uqzdedzQ2gqsACsRWhHZUU2J2GROmgWpJZcmcvxnMMXBfhWQ3Ll5jc
         i9OaJveucooQGm0CfhN7k8fwdk3VzeeZ+1YuzsoVWGWtuXP44nryzi4c7v+oMp/EA/eq
         KUL4BskxNGzZPcWtMuq0jbGMAhi3X7ATx1LuFJgqd3DYp+cc/zo/UluF3bcFlLW1gTvo
         nXmXAiv4VT3zI7Fq6MKL7T9sgLOHNznz3uWnbPGtTqzCgt/PW+RleM7acROpj2LKeuf9
         B5aLOUXGlfkE7V9YGPfd7Hn3pc4YCXNgwVlD93WpDzlZRHoMoXY9SI2zjU9412UyMBhX
         kptQ==
X-Forwarded-Encrypted: i=1; AJvYcCXkiT7q3WlZey2YxpUE2ex40siD0/t+iG/ayHlhC2Y2Y1zGBhjM8c4vI3bbpT83n4zIPt/hTrNRYP24z0ao@vger.kernel.org
X-Gm-Message-State: AOJu0Yymgpw5/f1CPQdw5U8k+M+PabK85Ejlt+gPNl8XtrPAim1uSqF0
	1UUl4x1I2Pm8K8gplZAdPIME+ffJSxqRMttW3TQUUeDtnPYbmN855cUyXEMPNoWpycg=
X-Gm-Gg: ASbGncunf2aF1BjK2UesrIdVSAlP5Ni+m9ctbJCrf+ib7NjPw5TUF+JoYVPH7xXjgYe
	/9A++aR2Pvu4v4GbPbufUaXxxr5iublVP9wsvJFCpgZUhn1E4KUbrL+5UtAVh97YFy95xN62Orc
	Vj92AdmTPS3mG9Vq2nQsaGlQd1/8u1Gm5T3hCK5px+EYc98b/0eM/6ZbwRpSiLjaViWb6Rnkx4W
	wejFySSnO418SJP6yJupLXbap1ytskN+uGszS/8HcxiO+bZzBK7Zf3Ba8Gjw5U2y/vA3xW2JZQx
	htEIPoSgQJTtJiPbOIfpHL45x0EJhW/mXB/VCdTWHT8Dyc+GCxbw1+Y32bJH3lHEomxWpNOkZNk
	bSnrhBOUi42iGhiriXse+LhRtlSoZyVnG/ae1oZIhGFLDGZkluoH84AreP1Uj1J/0TEObvwyNpw
	7oB/nn9tdCaOBfoA==
X-Google-Smtp-Source: AGHT+IHLyQqcsnOqnRO6HNMaeplbRrfZNdB8+kP2xWX2qbNG9/moHQNfSe1QScqIpYGuy7dJX/Q6FQ==
X-Received: by 2002:a05:690c:d1b:b0:719:61b8:ffd7 with SMTP id 00721157ae682-719b422f811mr42827367b3.16.1753282051271;
        Wed, 23 Jul 2025 07:47:31 -0700 (PDT)
Received: from soleen.c.googlers.com.com (235.247.85.34.bc.googleusercontent.com. [34.85.247.235])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-719532c7e4fsm30482117b3.72.2025.07.23.07.47.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 07:47:30 -0700 (PDT)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: pratyush@kernel.org,
	jasonmiu@google.com,
	graf@amazon.com,
	changyuanl@google.com,
	pasha.tatashin@soleen.com,
	rppt@kernel.org,
	dmatlack@google.com,
	rientjes@google.com,
	corbet@lwn.net,
	rdunlap@infradead.org,
	ilpo.jarvinen@linux.intel.com,
	kanie@linux.alibaba.com,
	ojeda@kernel.org,
	aliceryhl@google.com,
	masahiroy@kernel.org,
	akpm@linux-foundation.org,
	tj@kernel.org,
	yoann.congal@smile.fr,
	mmaurer@google.com,
	roman.gushchin@linux.dev,
	chenridong@huawei.com,
	axboe@kernel.dk,
	mark.rutland@arm.com,
	jannh@google.com,
	vincent.guittot@linaro.org,
	hannes@cmpxchg.org,
	dan.j.williams@intel.com,
	david@redhat.com,
	joel.granados@kernel.org,
	rostedt@goodmis.org,
	anna.schumaker@oracle.com,
	song@kernel.org,
	zhangguopeng@kylinos.cn,
	linux@weissschuh.net,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-mm@kvack.org,
	gregkh@linuxfoundation.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	rafael@kernel.org,
	dakr@kernel.org,
	bartosz.golaszewski@linaro.org,
	cw00.choi@samsung.com,
	myungjoo.ham@samsung.com,
	yesanishhere@gmail.com,
	Jonathan.Cameron@huawei.com,
	quic_zijuhu@quicinc.com,
	aleksander.lobakin@intel.com,
	ira.weiny@intel.com,
	andriy.shevchenko@linux.intel.com,
	leon@kernel.org,
	lukas@wunner.de,
	bhelgaas@google.com,
	wagi@kernel.org,
	djeffery@redhat.com,
	stuart.w.hayes@gmail.com,
	ptyadav@amazon.de,
	lennart@poettering.net,
	brauner@kernel.org,
	linux-api@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	saeedm@nvidia.com,
	ajayachandra@nvidia.com,
	jgg@nvidia.com,
	parav@nvidia.com,
	leonro@nvidia.com,
	witu@nvidia.com
Subject: [PATCH v2 18/32] reboot: call liveupdate_reboot() before kexec
Date: Wed, 23 Jul 2025 14:46:31 +0000
Message-ID: <20250723144649.1696299-19-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
In-Reply-To: <20250723144649.1696299-1-pasha.tatashin@soleen.com>
References: <20250723144649.1696299-1-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Modify the reboot() syscall handler in kernel/reboot.c to call
liveupdate_reboot() when processing the LINUX_REBOOT_CMD_KEXEC
command.

This ensures that the Live Update Orchestrator is notified just
before the kernel executes the kexec jump. The liveupdate_reboot()
function triggers the final LIVEUPDATE_FREEZE event, allowing
participating subsystems to perform last-minute state saving within
the blackout window, and transitions the LUO state machine to FROZEN.

The call is placed immediately before kernel_kexec() to ensure LUO
finalization happens at the latest possible moment before the kernel
transition.

If liveupdate_reboot() returns an error (indicating a failure during
LUO finalization), the kexec operation is aborted to prevent proceeding
with an inconsistent state.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 kernel/reboot.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/reboot.c b/kernel/reboot.c
index ec087827c85c..bdeb04a773db 100644
--- a/kernel/reboot.c
+++ b/kernel/reboot.c
@@ -13,6 +13,7 @@
 #include <linux/kexec.h>
 #include <linux/kmod.h>
 #include <linux/kmsg_dump.h>
+#include <linux/liveupdate.h>
 #include <linux/reboot.h>
 #include <linux/suspend.h>
 #include <linux/syscalls.h>
@@ -797,6 +798,9 @@ SYSCALL_DEFINE4(reboot, int, magic1, int, magic2, unsigned int, cmd,
 
 #ifdef CONFIG_KEXEC_CORE
 	case LINUX_REBOOT_CMD_KEXEC:
+		ret = liveupdate_reboot();
+		if (ret)
+			break;
 		ret = kernel_kexec();
 		break;
 #endif
-- 
2.50.0.727.gbf7dc18ff4-goog


