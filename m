Return-Path: <linux-fsdevel+bounces-53015-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 161C4AE926B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jun 2025 01:27:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E9151C43CF7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 23:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4478E2D97AB;
	Wed, 25 Jun 2025 23:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="B1eRO5Hg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D0E2FCFC0
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Jun 2025 23:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750893557; cv=none; b=Q5ebwNGjSey3M7y9EDMvlOnBOcdPUlPZ4/Yc+WpU/LcN/w8VJU2Syw6pVVDTuIH6Ebrdt47GFN99QlY1AhmTSmKXRNrFBRdnV5w3Fr/UDwBn59NOhPURLEAyqifCtnCelMW1Ucp77371ib0LJE7oTbn15KTR1SF4QadKRun3M9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750893557; c=relaxed/simple;
	bh=MeL5rpabCOQ9W64WCDzEoX0aCqKWSq3A09PvP5YRATc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gwstJGo5nic0vra750GDP4jcnBGnEWXGiPDiR283B/rV6Yv/Vty9hCeTjHOrjJJT4+G4THfNtA1QcYL9ruIQszZ6n+mWstYHx1SM66NArNmmVJqWtWl4MppHlP6BKlTI5c1J861hYxLAVSw+xhZiW73bwXlWH5OmPbUvVbQt5ZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=B1eRO5Hg; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e7db5c13088so439796276.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Jun 2025 16:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1750893554; x=1751498354; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+FWnE5Bow2uoaZcwISvBgq/4l5cKqkAoia4t69mDLc0=;
        b=B1eRO5HgatGq4rstuHwQb5lRLPCJUJPeYDwYtXoaXEQ6M2ydVeMdgP5sfHosPCqzX+
         826BuhtF/jpBSjO5u3Cd+iCrP6EZuAeF4wz4RAtfsPcJZDSHrbN0ug8kX514GEaI6IfH
         1HTxR5Xakww2tpQn/usIrCPwX1y8c0DJzwCGf5kSvD93mJ3XzDwh+LBjP0HOw48/JdUY
         xOnYtcV+oCc+PEIUc7ZjHB1O/cr6DZCTCT+v6avxVYgKQPF3P1fHAREVroltDj+JPWcR
         Rrz2ol7e7zdDcJGEEJe1LKpcg/jZUsxt8owjNaN31J2PanxwMS43usRsTmUcBQFkLv3h
         i3gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750893554; x=1751498354;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+FWnE5Bow2uoaZcwISvBgq/4l5cKqkAoia4t69mDLc0=;
        b=YqfEFWM0hjNOo96Hm2jJBXjJxK3Uu9DnfWZ3NCrXuyHPnfPT0680phF0Dhe3VbdU2A
         MCXA5xbllqdLXRk7G0Fy6ZvHkvcn+znjepqFvQLNkeHDktYVjLxzeTw/4nsQl+gxWZth
         pG5bJhA7TDLIUsVM5Pxds5zH+bJCyxAehMYrrqGYy8WuZ/eoCTJ7+mfH4HI7Ms9BC1FY
         pCEdO07htko7aOsCF0bBervNAhpkOzhWPojySA6I+kd+98NDVN5k5+7yUtdn1yKsgFmp
         E9BIVPcQKnS0JdCqVpXZYErQ22IswFzcohTarpwjLZbNYv+EExUUGzMjKF8eFdPotGV2
         lnYQ==
X-Forwarded-Encrypted: i=1; AJvYcCVYN0c+/tRYeMuxH0PiWPsLp8H8ajkFIgWVJa7YEDXnQOjjLXtuqqABdGc/aJPab1jOBsQ7+qxYCpuyOhim@vger.kernel.org
X-Gm-Message-State: AOJu0YyrqEPH07leOche0NJJQWQILJThg9wiQCrGlCUqcEKLS0WJqA8Z
	6PAGZqiBdv3Sbv1fTI7eMq4NNRLUnhZP69pOudDuIbHi0uVSXze+wPmkkV3p+SXEMzI=
X-Gm-Gg: ASbGncsIA1L9HpGGbR/LzdmGMuRMn6dtnfJMaf4oUrDKKit2WqD+TARXGPBxI00axET
	q7Pd2y42zDKx3wRdvOMHZifZhbZ8fu+v3exkDL6bpTRhEcl1/lg5CBn8n+Yq8Hjv8y4LNgvDD66
	p9/DfVJw/332OR9XgwXscJUi1awN58xXjKuXobPJnWUa1v0OYkoIKjfTsUvaKcuP3m9CIslfJzH
	iQGogMuDcbNKlz9GZPB9gW4iWAqHCk+8VR5Brxi+ZDFolBudOL31Om4njtlfwIwm72wM52IAwsZ
	uRoH89EAvMYBrWJaH2hofysDZOY30MBhVE+DGvfJPjEVVdbUMf5SOePFhMX8+b5esR61j0/P7iq
	l6zj1UEU5RQUZvObdAEoKrxq3FPjTSkQtsRn/WbW8t07UWr6vkrHD
X-Google-Smtp-Source: AGHT+IEYYs2N6RASXojR+QxIpPej80Rm+js0xnYmL5jy1Q+a192E7kIXIViEBMDkie7fGIqIBRd0Pg==
X-Received: by 2002:a05:6902:138b:b0:e81:8305:b8d9 with SMTP id 3f1490d57ef6-e879c092ef1mr2020971276.1.1750893554316;
        Wed, 25 Jun 2025 16:19:14 -0700 (PDT)
Received: from soleen.c.googlers.com.com (64.167.245.35.bc.googleusercontent.com. [35.245.167.64])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e842ac5c538sm3942684276.33.2025.06.25.16.19.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 16:19:13 -0700 (PDT)
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
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v1 18/32] reboot: call liveupdate_reboot() before kexec
Date: Wed, 25 Jun 2025 23:18:05 +0000
Message-ID: <20250625231838.1897085-19-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
In-Reply-To: <20250625231838.1897085-1-pasha.tatashin@soleen.com>
References: <20250625231838.1897085-1-pasha.tatashin@soleen.com>
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


