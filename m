Return-Path: <linux-fsdevel+bounces-67479-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 47174C41ADD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 07 Nov 2025 22:06:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 880E54F0A05
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Nov 2025 21:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B408F32AAD6;
	Fri,  7 Nov 2025 21:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="bN97aslA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A1A1310627
	for <linux-fsdevel@vger.kernel.org>; Fri,  7 Nov 2025 21:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762549540; cv=none; b=ffDyHuYbMPujKfvThahqAA2WuQj/j8odD9AqlMwecR8Xqp2I2YaoZiGamnp3hRjyVWqCmj9fNRpH1aN54B8bqB53OHmEH7z/+haPfgGZobWn00J1a2tH66k5+oeQB9+AjBA4V70MF4LZwa4xxUZX1M4NKlk91+EP5HTDAhh0+no=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762549540; c=relaxed/simple;
	bh=frmW4uur/JiJP0+axQ4M0kbVoUhK8VyFB7s+YzrbZmA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jh2eoBuPCYa/ARu6tCnMlIGjhTntYOxO9laeiOyIdGU726V6Vy2DfpxBi0NhpJR8Zl4r1+Kj6tKmElkum4yufFy5Eii6MHbw6CkAtcu0SxJ6R09VqzBHqYPS731Tg7ImKD36PCtMP4M9XYVQ5RyUqGBX/Kvwo5+Wjzonb/maFvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=bN97aslA; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-786943affbaso9583247b3.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 07 Nov 2025 13:05:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1762549538; x=1763154338; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LAfmXKExFsP/wCpt9jvB5iXqu6nwsrz4tNI+tUSnwDI=;
        b=bN97aslAgDHF9EpIrRRoahib39FwTlRaylf7ZUHm3nMtLWNtDm0fHBnz+9skzMLgoE
         q/YLCa6wI4G8G9pFzO5+mPiBGlK6yZpsAm4gF5s/FGBdLOEYWGQytYNw4aNHN5/0CZus
         znKxXV4D/NC+3IlLnVBBTgIMnyyqiyVzmwd7hG8xPEgos8oo51nFd/yJdrroy35XcJmg
         TX3e/r+hAP2rLJWc78b+k5LWRuA6ZBC3uTuS+WGLEB8DHQlbpJxj3y0llXa7mR215Gbz
         PKWTow9F/zRCRED9CrUDQdcYpuLlEUVnpBrYB5esWwmM+DtrwLqRVysmKc9WG8IeZ3Vb
         QgoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762549538; x=1763154338;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LAfmXKExFsP/wCpt9jvB5iXqu6nwsrz4tNI+tUSnwDI=;
        b=BhKeM7h9hA/jWK/Kh511ThTV1BteePjOWAg59fwYonMNkg9wPt+3CdHwCA3N5A4wCd
         TV6AUDZk9NmFtKQA6BPnIaLgYnrV9hYwK/ceNWnmbO47g72JswN7DkponK4Zez9va0+N
         QNowYueCEkedtkI6lh1BwVR9YiyJFl6enNNA1WHC4uXzLMGueOKmQxxWmBbAQArf9i/6
         BLrM9RGxlrNVx5uCC2h0962o/1XCBx+r1IS4LXNCbPfpXXkkEjQaewnEbG1H5QlGNZqo
         UmNXbvKewmVafNmUzpR0l2IKlzr8xJd8CefUyeX9JM3/+QT2RsZnaA5x6HdODBvNbNIK
         SgzQ==
X-Forwarded-Encrypted: i=1; AJvYcCVGEzwPF8CT2jt2BbzB3rrSvt3pjWEO2XLeHDPBnxsPIBpUpODe6wj9ozYtQa2lQfYFHgVo1inUjSjHmDXX@vger.kernel.org
X-Gm-Message-State: AOJu0YyKcJ/Ko/5yGkLXqwOHrx2e99seJ+AiK0mBsBNI53My6kS4OomX
	iV+vPlbGAPpQDg5w5f7Wzy+aA9srDwNNZFIz31YN+3w9s8EOEPS5ce4zuxKvNo09bM4=
X-Gm-Gg: ASbGncup9PXpmzhWD7vAlTE2aEbb/ZoFQNti8CUDbDJoazOjvwNhXicmj4P6aCFBDVa
	huJrXv+vsQmKFkdAh8wf5o7ozVQacWwfRLJtBIjgOzWgoJeofoNnKuAOnr04irfEy/dhohXSeXN
	uTQhETaepZ5jrsAP05/PMgautFCuHAaV6a4aOFVEcqhzUKpAboyHYnfplit/rLUz+QRltRqQvpt
	YM57oOk2RF8YSUWL8D1LauF+22vXxCk3pW8twzKKtNv5IaZKoaL4AjXc+zC+sWwupT0GuPvfyyU
	wEL6WXhJRmQAZU3codp091d9QOHZ6F+YAxzxar2rJgszZ4dks/Y/PBHTQqLlTfDqydS/JxfCBo3
	Hf5TijMofp1I5wdmFxlCIv6ywDFWZQCMtEl9h30GZHWUiVL0b4FVa2HRGlY2e693AKeAi2+RWzt
	5FSP3MVjyrlkA4Ezjp6Mupp7vlLxeAu8vDGDlOvZQfQ3tUp5ytEwvwZ4Ftu1b1DIFxEGfwuQlZg
	Q==
X-Google-Smtp-Source: AGHT+IHP3QoDDPe69Dq6qZNTn006B72sZIHWCNrPLWZh2Sy97b00SWoXLarWg9cKIVLBa+/0WbjfEw==
X-Received: by 2002:a05:690c:a003:b0:785:e76e:59bf with SMTP id 00721157ae682-787d542919dmr6289787b3.50.1762549537853;
        Fri, 07 Nov 2025 13:05:37 -0800 (PST)
Received: from soleen.c.googlers.com.com (53.47.86.34.bc.googleusercontent.com. [34.86.47.53])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-787d68754d3sm990817b3.26.2025.11.07.13.05.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 13:05:37 -0800 (PST)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: pratyush@kernel.org,
	jasonmiu@google.com,
	graf@amazon.com,
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
	witu@nvidia.com,
	hughd@google.com,
	skhawaja@google.com,
	chrisl@kernel.org
Subject: [PATCH v5 03/22] reboot: call liveupdate_reboot() before kexec
Date: Fri,  7 Nov 2025 16:03:01 -0500
Message-ID: <20251107210526.257742-4-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
In-Reply-To: <20251107210526.257742-1-pasha.tatashin@soleen.com>
References: <20251107210526.257742-1-pasha.tatashin@soleen.com>
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
function triggers the final freeze event, allowing participating
FDs perform last-minute check or state saving within the blackout
window.

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
2.51.2.1041.gc1ab5b90ca-goog


