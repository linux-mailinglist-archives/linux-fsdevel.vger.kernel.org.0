Return-Path: <linux-fsdevel+bounces-39597-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 80AB7A15F44
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Jan 2025 00:17:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83AFC1886F2A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Jan 2025 23:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06EFD1DEFDD;
	Sat, 18 Jan 2025 23:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r3kysIkb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E80851DED72
	for <linux-fsdevel@vger.kernel.org>; Sat, 18 Jan 2025 23:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737242188; cv=none; b=Pxn6TW1ofPS2flMRleilKRRUoTbvAtGlfoTiHtwA9AjezEkiDka7OuBjlXHv5rlD3YK8yxcIQ7uuusCLqj5oJ64zCZn/jaFWhfUNnvhWpJV4LL4KnjGaFuT5mySH54NQ2LwyeHPp8Urq9ryfBRoiAh0XjPkWH1hb1VnEzYI4nok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737242188; c=relaxed/simple;
	bh=CXfN+SP4KawYzi4RkPaH6RZpzSX5VKuvvpTE7/NzZac=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fQb8C1DlAbCEBovIyH6CAbfD7JvfbwAwTf1/0CM38WBqhxLdQ/DOULJD5OTIdVo15NDaqzrLZkbtIvqL3IXJ5R6nJ+vMrpqKmUF2QyrlBRk/5tKuw9oLCIGpnaAoZqpqDlpsPOvCKyhfMpa8S0Ga99A4cKKVbKI27w3rjILmFLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jiaqiyan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=r3kysIkb; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jiaqiyan.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2166a1a5cc4so58585335ad.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 18 Jan 2025 15:16:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737242186; x=1737846986; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=I9XQRTrIMw2nHi4Rykakj51VRt6E+kzcD+EW0K/CYuY=;
        b=r3kysIkbCQkB3FOGlJ5LJ086F/gXP1sR/OpumHeYH0lYm1iXP5ZAXqfgCzU9u8DyIa
         r1kIrKMSUc+NialxDYJmLhBb96DsddzTkqNkT28yd1z8sNO3A0NskyUxm8fFOwG3PvWL
         bz1AYvLZOXgpGBtQvP5UN7Qi9uxGTdirgN3wA5RDOGWueaSUvTAzFbExkXDWl7+EnMAf
         uJwg3TChMv46x4iPt+up86EUsys5XAJEMkxwYs62yx2jOs78zbW9BN9f5Lx3sd/RTPNa
         f1zRA2PC74v7zPl7N2DbJxuuBFbXFnGKb5FwrKcUrcYHUfZHt4HcfRzeAYXuIar+V+RZ
         Aj+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737242186; x=1737846986;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I9XQRTrIMw2nHi4Rykakj51VRt6E+kzcD+EW0K/CYuY=;
        b=ojBj4REHPABGo23fsrnoz/UClYSDPV3Gk5PcLxI2zHG+/i0Tyw+QtsB+Fra1BC527z
         5JOgfG3Y4dDmc9z2TD1r3N8zoY7wfX8Rn4GAvyKnH4LLT7nPnZxq54OSu8J9ExOpbyWf
         PAxYXqMgfaZxttrYUBDEETLJnD3vmB1iq4PDsCg5UV5R98jpEX4/ZO2tYKHoO+340RkF
         jhJjyDl7mJnlEEaRi+8ipPVyRMNyZdlgU27zEKn2PyRYFu1f+AbMZiJm7liwXjd17TWd
         Xi3wICEWz43Iqd5VeYxy3suqEGeLipoTkzsewFENwbUTq8C+Mng5teAu9K6XrEr3Lcxu
         qK7A==
X-Forwarded-Encrypted: i=1; AJvYcCWkZ1PNL7pVQxHoryaqfQSXtn298nkwz17oRZYVvvU+QFjakS726Z5Yxm6zGiWPL84SgEu7qp5uvvVV6Ms1@vger.kernel.org
X-Gm-Message-State: AOJu0YyZQ03jM5erJoejKaaoR0V5lfq4zP6Z6mr3Tc8IEllil5TWtqJG
	YbR7GXudfajVCUPB1GbATSPN96lgZ5ipeM7uW2O9d/eSDZsot60ZMd3Obh5tGfgfMuHhNMTacN+
	SSt9e7OnTjQ==
X-Google-Smtp-Source: AGHT+IHwlluQDU7UlSnmrszHFZEXxstYcEx2i2R/0XKRZHVd/xM9gn1WzTOyJfb2igjnZAJi3m+IL+n+5tTv9g==
X-Received: from plhj17.prod.google.com ([2002:a17:903:251:b0:216:2234:bf3e])
 (user=jiaqiyan job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:f70a:b0:215:a7e4:8475 with SMTP id d9443c01a7336-21c35557a0bmr135957655ad.24.1737242186201;
 Sat, 18 Jan 2025 15:16:26 -0800 (PST)
Date: Sat, 18 Jan 2025 23:15:49 +0000
In-Reply-To: <20250118231549.1652825-1-jiaqiyan@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250118231549.1652825-1-jiaqiyan@google.com>
X-Mailer: git-send-email 2.48.0.rc2.279.g1de40edade-goog
Message-ID: <20250118231549.1652825-4-jiaqiyan@google.com>
Subject: [RFC PATCH v1 3/3] Documentation: add userspace MF recovery policy
 via memfd
From: Jiaqi Yan <jiaqiyan@google.com>
To: nao.horiguchi@gmail.com, linmiaohe@huawei.com
Cc: tony.luck@intel.com, wangkefeng.wang@huawei.com, willy@infradead.org, 
	jane.chu@oracle.com, akpm@linux-foundation.org, osalvador@suse.de, 
	rientjes@google.com, duenwen@google.com, jthoughton@google.com, 
	jgg@nvidia.com, ankita@nvidia.com, peterx@redhat.com, 
	sidhartha.kumar@oracle.com, david@redhat.com, dave.hansen@linux.intel.com, 
	muchun.song@linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Jiaqi Yan <jiaqiyan@google.com>
Content-Type: text/plain; charset="UTF-8"

Document its motivation and userspace API.

Signed-off-by: Jiaqi Yan <jiaqiyan@google.com>
---
 Documentation/userspace-api/index.rst         |  1 +
 .../userspace-api/mfd_mfr_policy.rst          | 55 +++++++++++++++++++
 2 files changed, 56 insertions(+)
 create mode 100644 Documentation/userspace-api/mfd_mfr_policy.rst

diff --git a/Documentation/userspace-api/index.rst b/Documentation/userspace-api/index.rst
index 274cc7546efc2..0f9783b8807ea 100644
--- a/Documentation/userspace-api/index.rst
+++ b/Documentation/userspace-api/index.rst
@@ -63,6 +63,7 @@ Everything else
    vduse
    futex2
    perf_ring_buffer
+   mfd_mfr_policy
 
 .. only::  subproject and html
 
diff --git a/Documentation/userspace-api/mfd_mfr_policy.rst b/Documentation/userspace-api/mfd_mfr_policy.rst
new file mode 100644
index 0000000000000..d4557693c2c40
--- /dev/null
+++ b/Documentation/userspace-api/mfd_mfr_policy.rst
@@ -0,0 +1,55 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+==================================================
+Userspace Memory Failure Recovery Policy via memfd
+==================================================
+
+:Author:
+    Jiaqi Yan <jiaqiyan@google.com>
+
+
+Motivation
+==========
+
+When a userspace process is able to recover from memory failures (MF)
+caused by uncorrected memory error (UE) in the DIMM, especially when it is
+able to avoid consuming known UEs, keeping the memory page mapped and
+accessible may be benifical to the owning process for a couple of reasons:
+- The memory pages affected by UE have a large smallest granularity, for
+  example 1G hugepage, but the actual corrupted amount of the page is only
+  several cachlines. Losing the entire hugepage of data is unacceptable to
+  the application.
+- In addition to keeping the data accessible, the application still wants
+  to access with as large page size for the fastest virtual-to-physical
+  translations.
+
+Memory failure recovery for 1G or larger HugeTLB is a good example. With
+memfd userspace process can control whether the kernel hard offlines its
+memory (huge)pages that backs the in-RAM file created by memfd.
+
+
+User API
+========
+
+``int memfd_create(const char *name, unsigned int flags)``
+
+``MFD_MF_KEEP_UE_MAPPED``
+	When ``MFD_MF_KEEP_UE_MAPPED`` bit is set in ``flags``, MF recovery
+	in the kernel does not hard offline memory due to UE until the
+	returned ``memfd`` is released. IOW, the HWPoison-ed memory emains
+	accessible via the returned ``memfd`` or the memory mapping created
+	with the returned ``memfd``. Note the affected memory will be
+	immediately protected and isolated from future use (by both kernel
+	and userspace) once the owning process is gone. By default
+	``MFD_MF_KEEP_UE_MAPPED`` is not set, and kernel hard offlines
+	memory having UEs.
+
+Notes about the behavior and limitations
+- Even if the page affected by UE is kept, a portion of the (huge)page is
+  already lost due to hardware corruption, and the size of the portion
+  is the smallest page size that kernel uses to manages memory on the
+  architecture, i.e. PAGESIZE. Accessing a virtual address within any of
+  these parts results in a SIGBUS; accessing virtual address outside these
+  parts are good until it is corrupted by new memory error.
+- ``MFD_MF_KEEP_UE_MAPPED`` currently only works for HugeTLB, so
+  ``MFD_HUGETLB`` must also be set when setting ``MFD_MF_KEEP_UE_MAPPED``.
-- 
2.48.0.rc2.279.g1de40edade-goog


