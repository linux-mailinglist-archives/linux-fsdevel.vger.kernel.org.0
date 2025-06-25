Return-Path: <linux-fsdevel+bounces-53020-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1718CAE9282
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jun 2025 01:28:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDEAA18970F5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 23:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29E4C2E1C41;
	Wed, 25 Jun 2025 23:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="zw3yTgFD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4240B2D97AA
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Jun 2025 23:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750893566; cv=none; b=ZM5zTkK/x5kcrJ/Bs+EPXvx054CcI0cB8QnBTszGJ1PhyAcrslPIxksHAWOPbuaKpcucLoO+fpoegUzdtGg2ys4RJy+gzleMzwBzOuxIFOh+VrE/cj8WVH6sVqZT6tQZOOv833yK9T3nH6k3+Cs+xftZv4T0csSLkkL9KsZrHA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750893566; c=relaxed/simple;
	bh=3Bs7yjVCwVYzX1qp5XJYtcpXHYaHTnRk2TWgFXsiFjo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ac2tsals+beddP+oXVFFQvWL7Hpp/xyNJdnwB1SWVi6RCkUsWiMLn8xHXBtB8T1I9KEQLviiaztRFtzPKQtoST0/TE9Kqp5iOZpnYnHgf3AZKeNEa0kWCaTfPwtnD0DXjs2B9qIZs6NidSRWcJsmAnIXQnuMlhfsf0oI2Nk3KfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=zw3yTgFD; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e740a09eae0so340211276.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Jun 2025 16:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1750893563; x=1751498363; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NC1ayEHkvN6ijinKURZBxrM3hNqjaSgPk5qZ/n3J1rM=;
        b=zw3yTgFDvVJTqB0CEMS6xo5qxldQbFl/tSMptiy1NkIiEtElya3EdUzXOOr7oaqOjy
         u9AyLhppc/fHCGFkRsYceqz+3zuxSylHWa4dzkbnmFJvvF/rnUsHbx/pYRBxp8WLLkVh
         LY+B+0E8wSK59Qaz8cFiP5zzS3GcasQ4zVqy1d7/8VQnErKzFcTUV3P73YFFx0xpS6LZ
         BXfA1bg35SD3zsvfJbFrET2epw5RtkHWtknrkXTvywYwBrzrMZm9o+pNDKKg6CNs6Ehy
         4YSwZLvj3L7Ft+bBVN9KPZJVIXYKVZQsS5M58vJFYyWJNhtmBLNNkLkyxIuqandS9I/5
         Wizw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750893563; x=1751498363;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NC1ayEHkvN6ijinKURZBxrM3hNqjaSgPk5qZ/n3J1rM=;
        b=WoH9MsOekZbIrMSYlEy6qzHqA/pfasWMZE8YH7ZAPN4Z8y+eHpKwoK+yG+zPiQJTuX
         MuCxb2uqkaEo6MMJtH406ZbL/pepFpeGaYAVyUxSsEDYAKDZ46DssNHolvB6Tw4CKimm
         xaSih0mjRVeur4egOjqKRAMsLpf40n3A8x+yxI98mLlI0igJ/lkd4uCLRdSk5M+r7LNW
         ZKuiE8xoExkfycgY6V6YTgEMNhdpaaPp9HtxN6/RASuX2AHX7QqXn+AGS4xif8yohZ8p
         bqcrCBiOUL48U0MQJUFtpgKgl5Ez4zcxc3aFfUCznyWxrh9nMwqhXNfgC002RYdOSrPr
         0Pvw==
X-Forwarded-Encrypted: i=1; AJvYcCWAItT7+ctHYEa27x72TffAN5yiWWNbl5sxB67vD41bwjSTgWLzeuq0wx3e/DfjD+zMGwGqag0XcZOpc5WY@vger.kernel.org
X-Gm-Message-State: AOJu0YwMxERmBz6nCr5bvZb7hsZWFqVzc2DDOz+QpEdEEqkxmWIYB9kK
	AJ6x7IZNpB/cGEbR1MJoUXuSxlohh8GXCyiEjQj6IEg9itYQLB0NaCe81OiMa16iLW0=
X-Gm-Gg: ASbGncvZ9sAOG4x58bW9h8x3oBLh2AhtGFQmjTcS0ahtrdcqy4pBD4MK2LQzUZlpnVD
	hyiERiKbYOpL145r0SdqJ7DLt+TKeMIdY1FlA1BxWhjtxoSKEQGtrVfMWREpPAi/IV+sqREBIHB
	CaGg28aY4cSZGd8KeEZ93WUHxRnzwICRzf5kLn7Bexod8TVMfrXwztLg+g1hNwmmWnmNlXfUIc1
	e2PCcz/PtGigyoHifN9SRy2w/5ulsEowcoUkRxrd8WU1UQe1m8SeMS463J8/0XnTMS/aFYaTO2O
	Keoy+scWS9kDxEIMHnwO1B3iqNmfPfntMMgitsyPih0lXMNh+c64Tvo4yrJwNBpQq7Lp+WLXQUv
	dHZzsm5fzRUDzQ6yOSarLk0BnCp6f3vKimOgpZyHKygKKwEGtx1hq
X-Google-Smtp-Source: AGHT+IFnAI1qCvNBz4mB5Q4FSGHdp5ZaV6ywIeny7tCD+W481rJiP0KC7KdFe65zVWMeF3cIUgLqHw==
X-Received: by 2002:a05:6902:1205:b0:e84:4341:4101 with SMTP id 3f1490d57ef6-e86016d1768mr7606110276.10.1750893563223;
        Wed, 25 Jun 2025 16:19:23 -0700 (PDT)
Received: from soleen.c.googlers.com.com (64.167.245.35.bc.googleusercontent.com. [35.245.167.64])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e842ac5c538sm3942684276.33.2025.06.25.16.19.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 16:19:22 -0700 (PDT)
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
Subject: [PATCH v1 23/32] docs: add luo documentation
Date: Wed, 25 Jun 2025 23:18:10 +0000
Message-ID: <20250625231838.1897085-24-pasha.tatashin@soleen.com>
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


