Return-Path: <linux-fsdevel+bounces-62970-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 187E7BA7B41
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Sep 2025 03:08:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D68927ADD24
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Sep 2025 01:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE84B255E53;
	Mon, 29 Sep 2025 01:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="Ue76cvBa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13FED1FDE31
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Sep 2025 01:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759107878; cv=none; b=ftHLX5cL2VUOzO0B71IlBInEphZzQ5fhC8S4T06HkrGrMuG9hx8HoshZAfAOcopcQkma1fhMwBw49mIDmegrxfMEA1vTszBWzxxJNpsoX0FDhOWZMFYQbTxpm2QXgxxQ16KSJMcmQzySX7PiyONCVyGwWIBGTBJXIar7RPnieEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759107878; c=relaxed/simple;
	bh=hPTwkZ9Zs7OGfgoBOmsXzZchI4dTFATs/A5A5sAPQhI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TIbdUTb8uLgPwLYmSlUJ4Q0HbWUkiXmYOZb3alqMh4XX924Kgz+KMEk0sMuVXXclUV4h1F4Wl5xmMdK1lt1xvgDkU8cUXnoeIZH8m+8EM16sHrPR335nmVs+9e6g4B0E9I7YpRPdWLyPyZbJInplC/PnzEtsesRnU0tLTKoTzJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=Ue76cvBa; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4dce9229787so33646611cf.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 28 Sep 2025 18:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1759107875; x=1759712675; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4673JtxFCCWFxWem0KySHim/AVBmSFNvOtZj4TDhxZ0=;
        b=Ue76cvBagnFBBmoFEthA+UebVXS0ul8p2//sjtmZ8tFttzpGA+evB4A+Z/cY5sYf9p
         sJJzKP55lHXMdDXLl13ztZsxflDiYoR6WXm6ase7jabD2wP/o1TWCFTteH0Kv8X50cDk
         Lg6Q0R3NGLTO3f9ckZMcsBulv8HP46ZpWvqpPgdIF9OnZkG2fOzQiQ0ITU+r17tqhwp9
         1pMufNlR4jSjQZ+SpIkRTgeUeNGHksX8ZP5iSTuZwHQTENtaJ0gjvxPGh9JZu3RuFojf
         vgB8Nxpi2Qb3scndsQ0Wf27O8xvB8yeomNF7ZjSJLgr9e5anJIsUwejCiuta5kMfeLBs
         NViw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759107875; x=1759712675;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4673JtxFCCWFxWem0KySHim/AVBmSFNvOtZj4TDhxZ0=;
        b=Ciz1t8wlhgXRzODgzW7limJ6bjfhMDSLEjTeCJ+SsbDp0xGkO8SRScPhdxkiQK68/Z
         D+wiguTkMP0wIXUHicGM5GkmsoUXA2EoklOxOmLxMcZU3AA6t3DT0Yl7gaVdhm21Zjue
         lX1iihaCe/gmEdWeWf8n54bIM8PEilDbBKgoc/5nGRyQHCXqJJ1nb+dyPmzzR782OIqp
         CJxuT31dZg9tWb2EznQm2eRGse+YD1gGo1thLslWgsXev/h4Vj9p92hjks+pxhjQigZy
         +MAwbYJ4D64NHFisJTlcHAh1X7HeCuDRegXvEaFHXVJNa2o08k9X6CYzYfq1q41VVJ4I
         iITw==
X-Forwarded-Encrypted: i=1; AJvYcCV4kkUUqmM454+R44sxJAyb+C7+SchiZfen/93mDrR46QPIq6gcdPbsoV3Kd59DMjCnvnnEMrZHHkIYlVB2@vger.kernel.org
X-Gm-Message-State: AOJu0YwVecXtHb878vgBH9kifYMD/pJYMXaezciwRDQuq6BoAG6CubZ2
	+rZ73tI8eUO59MR/XLEbngcRhImJB6p3gA9N1wjnA+iwFLf+3YdbUo8iZnRWuOQVDzk=
X-Gm-Gg: ASbGncvw2q9ydiYyni/k+ByBfadVGHJI1AnAmyiOdlJ8pXxXkZm/yG7LKDm9ycCIUZV
	qf04sT8rf++EeqEWBWdo8Cb54rB1zAcawZTKHWjEzUJRk7sHcecwxIy2LAMz8P6s5JHBAzwiW3C
	BQ3rvR2LL4+NSAKlw4XvBvXOBZKhQOaJaUtueEzFhD45hlvNjtZt8pp7KJqKY+Bvd7J6zPMAsHP
	StQAWKZq5q02Zr3vHmYJNJ/751CgNpZ+Kn6OCS9uXSHOCB+DQTskP63BKiBhlKW7/lY0IeT/i/2
	dSX6zptPo7i6Inb7kzrfuu8KStoaMeo2QrVU/S7+ycogJXurjfdCFiWHKDoIFplGEW7KTUKe+o7
	Juwlt1jvkZt5iJ2Qlx5pSxzKLFsHFtJFqrFAONHkfQv+1nzBRXMKORtX9WUvIq7VRmhKRkA9/l7
	QPLM+W5r4U14HmSDl/jQ==
X-Google-Smtp-Source: AGHT+IGDD1FThqyz2U7zZsapceDkvp6OYAFPiCrTNFDU7CmxN/gojkNSulBOcc5jk5r12Vod1QdZCA==
X-Received: by 2002:a05:622a:5c8:b0:4e0:b5ef:2ba3 with SMTP id d75a77b69052e-4e0b5ef2f60mr33122951cf.37.1759107874548;
        Sun, 28 Sep 2025 18:04:34 -0700 (PDT)
Received: from soleen.c.googlers.com.com (53.47.86.34.bc.googleusercontent.com. [34.86.47.53])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4db0c0fbe63sm64561521cf.23.2025.09.28.18.04.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Sep 2025 18:04:33 -0700 (PDT)
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
	witu@nvidia.com,
	hughd@google.com,
	skhawaja@google.com,
	chrisl@kernel.org,
	steven.sistare@oracle.com
Subject: [PATCH v4 15/30] reboot: call liveupdate_reboot() before kexec
Date: Mon, 29 Sep 2025 01:03:06 +0000
Message-ID: <20250929010321.3462457-16-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.51.0.536.g15c5d4f767-goog
In-Reply-To: <20250929010321.3462457-1-pasha.tatashin@soleen.com>
References: <20250929010321.3462457-1-pasha.tatashin@soleen.com>
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
2.51.0.536.g15c5d4f767-goog


