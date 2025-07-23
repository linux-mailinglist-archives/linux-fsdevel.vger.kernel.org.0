Return-Path: <linux-fsdevel+bounces-55863-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B2A00B0F639
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 16:57:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48AA31892AAA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 14:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA51330115B;
	Wed, 23 Jul 2025 14:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="Xr8Kgw8v"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 277472FD877
	for <linux-fsdevel@vger.kernel.org>; Wed, 23 Jul 2025 14:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753282068; cv=none; b=J6qlNMu1uh+2veiFHpvyakAMtaPSr1dsvmPr4Y4TD/8he7vZTtR1khO3NANJQU4T53yoPmG5N7nOS0CPy8uSfu4LNSJvhSrS0imn7oxG2dSbWZfTDx1qT8cbOY1UFkHwR/yHXFvTEWkckbLleQ1ULyaorjftRbCEm4U57aLmGgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753282068; c=relaxed/simple;
	bh=3Bs7yjVCwVYzX1qp5XJYtcpXHYaHTnRk2TWgFXsiFjo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WdhBDYrgPPl64wfSYyMAzDr1Cz/7UUbhTP8O3FOBhlS37wmK3/1pRvYnqKOoWJfSZ2IfPjW28Pd+NKyooP+A7UakL8tCeETbtISORWZs5DdfPEipgjQr8HPc+qUWAnZlOLPLDBN5T6LNhlBNYnxfPMNZODDXXlhd/2tnrV38gBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=Xr8Kgw8v; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-719c4aa9b19so1167857b3.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Jul 2025 07:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1753282061; x=1753886861; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NC1ayEHkvN6ijinKURZBxrM3hNqjaSgPk5qZ/n3J1rM=;
        b=Xr8Kgw8v9TcOXLvuo1llO1is0AziDcvbvA8eksWYAJqUZT8B3+iENKGlanYrmVdsR3
         YpF17MmB4AHKedUkCiaPNvM0PnyiUPOcu+/tW9pVXjl6r80k7v3xggjGEVCOJDXzbUd4
         Gp+Il9h0COkLksqZGev64plplswaOQyXzednGDj8KuwfPKKVa5xVhCHojvo9GZ6yWpj2
         dRInPFwDwJB9jWPl+M88vVtO8Z52uoHkatW0dkq7vgm7HhKcON55CPaq/AIAi46jKCZQ
         QP5kR21Zown2uz0f0oPsBSr9WJy49zBFVQY/SsFmyKiIlPkf90tPBZhnN2i0kUlwHeiF
         FVKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753282061; x=1753886861;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NC1ayEHkvN6ijinKURZBxrM3hNqjaSgPk5qZ/n3J1rM=;
        b=bkfwREO3zjxkmi+DJ1gdkGiZUhT2Kqi/Tf15Crx7WKxgeZ8nJmyMlADnjinZS6/D8g
         Dt0rsJlhpt7D/w0qNieE1IUwJIAppiU04T0GD+ZP+EZc3qyrV6sU998/L1uiaP76ZYQA
         jWtAo75wf4zbvzt1VBDfWnvpQam5lYuZJFJuYavJRKmd8gMY97DmUX8VJPVEiIXjHf2n
         Jq85PBIm32o1twvt0+0WUWZ4hcXnSDR2jVq2HVUh2ytljbQ1t8JnKFNrye16OEy0BXPU
         Z8usBOJf27dQmEiGKm7CNoSK+BysMuW+2FuCRXf0LERmSJtYiKRG6bbAj3YByCg92kHr
         XDaw==
X-Forwarded-Encrypted: i=1; AJvYcCUWi6iQOJVLrY4XP74vF5QD4B4H4n7kQxTCE5o3QJRtbb6URHXWbqKmudE4mRK/OsE95IfqZ7o3txode47u@vger.kernel.org
X-Gm-Message-State: AOJu0Yzy/V2s8Bk3ipTuMak3+lagHLuuhr4XeRXMzcob+IsO1siX/4lw
	cH4yoWaJfgka2+3EyVsjtIo+4sfkcKecFE3TG67HCGaxVfCheA0PFpLnFO+0wc3YigI=
X-Gm-Gg: ASbGnctLd9Qzcpb8FinMJmaOCbrFoqpiBeqvhINGLXy+/qnd2iK8tTZCJMscA7yYrlu
	rhw3/abamJvpkB+YC9ngVmhuceIZl+ianj3BT6o8St1TLJBIahmtP+FaoIGv9iITBHN0jnc3+QM
	DCHopK8CxYCECHXKmMM8AHSBPIoW4hFzZi0FuSPqtuPPOJ8Rd7WHaZCkjX4misP/nFVREOeogQu
	8RDK3xYX7JBpF5bHN4PVnL+bXab/F+EwAIchdg77AJhHrZ7OVn2AaFWcMdnhbXENaOoaP2D7JrQ
	3kMdLYN+LfH6AMDz56h+0WAqm9Qh4dTLKmqwnNeMknn9DxLhwdu03Nzjfy8Fd+rehMeF3WyjUG7
	q/wT74lN0o1y+TRLI7kXjKKRAqZblg70HJ//TuHecf2QpJiV666i0zhw+VstodI73mthWnTw2iu
	aZHvgnUc0XxTs8DzIzuqKa3nSD
X-Google-Smtp-Source: AGHT+IHtTYkgbLD8Z9PD3xbOoYfvfKs4NkwGaH86Xh5bYMAIlsFdLVYPN6ZxosRwBh+RGdz+VhmZwQ==
X-Received: by 2002:a05:690c:9681:b0:718:4511:e173 with SMTP id 00721157ae682-719b4185000mr42897137b3.12.1753282061377;
        Wed, 23 Jul 2025 07:47:41 -0700 (PDT)
Received: from soleen.c.googlers.com.com (235.247.85.34.bc.googleusercontent.com. [34.85.247.235])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-719532c7e4fsm30482117b3.72.2025.07.23.07.47.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 07:47:40 -0700 (PDT)
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
Subject: [PATCH v2 23/32] docs: add luo documentation
Date: Wed, 23 Jul 2025 14:46:36 +0000
Message-ID: <20250723144649.1696299-24-pasha.tatashin@soleen.com>
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

Add the documentation files for the Live Update Orchestrator

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 Documentation/admin-guide/index.rst        |  1 +
 Documentation/admin-guide/liveupdate.rst   | 16 +++++++
 Documentation/core-api/index.rst           |  1 +
 Documentation/core-api/liveupdate.rst      | 50 ++++++++++++++++++++++
 Documentation/userspace-api/index.rst      |  1 +
 Documentation/userspace-api/liveupdate.rst | 25 +++++++++++
 6 files changed, 94 insertions(+)
 create mode 100644 Documentation/admin-guide/liveupdate.rst
 create mode 100644 Documentation/core-api/liveupdate.rst
 create mode 100644 Documentation/userspace-api/liveupdate.rst

diff --git a/Documentation/admin-guide/index.rst b/Documentation/admin-guide/index.rst
index 259d79fbeb94..3f59ccf32760 100644
--- a/Documentation/admin-guide/index.rst
+++ b/Documentation/admin-guide/index.rst
@@ -95,6 +95,7 @@ likely to be of interest on almost any system.
    cgroup-v2
    cgroup-v1/index
    cpu-load
+   liveupdate
    mm/index
    module-signing
    namespaces/index
diff --git a/Documentation/admin-guide/liveupdate.rst b/Documentation/admin-guide/liveupdate.rst
new file mode 100644
index 000000000000..ff05cc1dd784
--- /dev/null
+++ b/Documentation/admin-guide/liveupdate.rst
@@ -0,0 +1,16 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=================
+Live Update sysfs
+=================
+:Author: Pasha Tatashin <pasha.tatashin@soleen.com>
+
+LUO sysfs interface
+===================
+.. kernel-doc:: kernel/liveupdate/luo_sysfs.c
+   :doc: LUO sysfs interface
+
+See Also
+========
+
+- :doc:`Live Update Orchestrator </core-api/liveupdate>`
diff --git a/Documentation/core-api/index.rst b/Documentation/core-api/index.rst
index 7a4ca18ca6e2..a79d806f2c8e 100644
--- a/Documentation/core-api/index.rst
+++ b/Documentation/core-api/index.rst
@@ -136,6 +136,7 @@ Documents that don't fit elsewhere or which have yet to be categorized.
    :maxdepth: 1
 
    librs
+   liveupdate
    netlink
 
 .. only:: subproject and html
diff --git a/Documentation/core-api/liveupdate.rst b/Documentation/core-api/liveupdate.rst
new file mode 100644
index 000000000000..41c4b76cd3ec
--- /dev/null
+++ b/Documentation/core-api/liveupdate.rst
@@ -0,0 +1,50 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+========================
+Live Update Orchestrator
+========================
+:Author: Pasha Tatashin <pasha.tatashin@soleen.com>
+
+.. kernel-doc:: kernel/liveupdate/luo_core.c
+   :doc: Live Update Orchestrator (LUO)
+
+LUO Subsystems Participation
+============================
+.. kernel-doc:: kernel/liveupdate/luo_subsystems.c
+   :doc: LUO Subsystems support
+
+LUO Preserving File Descriptors
+===============================
+.. kernel-doc:: kernel/liveupdate/luo_files.c
+   :doc: LUO file descriptors
+
+Public API
+==========
+.. kernel-doc:: include/linux/liveupdate.h
+
+.. kernel-doc:: kernel/liveupdate/luo_core.c
+   :export:
+
+.. kernel-doc:: kernel/liveupdate/luo_subsystems.c
+   :export:
+
+.. kernel-doc:: kernel/liveupdate/luo_files.c
+   :export:
+
+Internal API
+============
+.. kernel-doc:: kernel/liveupdate/luo_core.c
+   :internal:
+
+.. kernel-doc:: kernel/liveupdate/luo_subsystems.c
+   :internal:
+
+.. kernel-doc:: kernel/liveupdate/luo_files.c
+   :internal:
+
+See Also
+========
+
+- :doc:`Live Update uAPI </userspace-api/liveupdate>`
+- :doc:`Live Update SysFS </admin-guide/liveupdate>`
+- :doc:`/core-api/kho/concepts`
diff --git a/Documentation/userspace-api/index.rst b/Documentation/userspace-api/index.rst
index b8c73be4fb11..ee8326932cb0 100644
--- a/Documentation/userspace-api/index.rst
+++ b/Documentation/userspace-api/index.rst
@@ -62,6 +62,7 @@ Everything else
 
    ELF
    netlink/index
+   liveupdate
    sysfs-platform_profile
    vduse
    futex2
diff --git a/Documentation/userspace-api/liveupdate.rst b/Documentation/userspace-api/liveupdate.rst
new file mode 100644
index 000000000000..70b5017c0e3c
--- /dev/null
+++ b/Documentation/userspace-api/liveupdate.rst
@@ -0,0 +1,25 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+================
+Live Update uAPI
+================
+:Author: Pasha Tatashin <pasha.tatashin@soleen.com>
+
+ioctl interface
+===============
+.. kernel-doc:: kernel/liveupdate/luo_ioctl.c
+   :doc: LUO ioctl Interface
+
+ioctl uAPI
+===========
+.. kernel-doc:: include/uapi/linux/liveupdate.h
+
+LUO selftests ioctl
+===================
+.. kernel-doc:: kernel/liveupdate/luo_selftests.c
+   :doc: LUO Selftests
+
+See Also
+========
+
+- :doc:`Live Update Orchestrator </core-api/liveupdate>`
-- 
2.50.0.727.gbf7dc18ff4-goog


