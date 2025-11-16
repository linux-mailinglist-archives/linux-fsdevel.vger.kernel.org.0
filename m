Return-Path: <linux-fsdevel+bounces-68596-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D3BACC60E9A
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Nov 2025 02:34:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E3D30359199
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Nov 2025 01:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78AAB225413;
	Sun, 16 Nov 2025 01:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1f/Sx9XJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 527C521D3CC
	for <linux-fsdevel@vger.kernel.org>; Sun, 16 Nov 2025 01:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763256753; cv=none; b=NNBOc9a+H94deRVn2IOg4sXh/+TfvtOSghy0ehM2YgIx9l1FR1Sfuj1JO97GqBdW4X6f8cb5WZhbe7lpzGsmXydranMrQHHwzVGK/roV3YryzH4eK7Zvlimb0qwk8PNu9k5utuZDCzfFICuuSW8+E9Jj6mgoKQ3+Po4/nHDkc6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763256753; c=relaxed/simple;
	bh=RFR9SyXEMPiUvb3afTg8l1rtUQb38RAKr+DLQv+RpTk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eRRDYUSajch2MaKek/eIIV8vOpetIOJcj07jxv+RyHDfQB3qTf2KzkK922OWljhl9kAQvrxsHLJMlBqLS8cI81NUsIZ76qObLXcwWXfbvjZXQnZ3zBratzEvCYuFOMzrn/uDv5q3VzaM+qZ7uGAtx57tZ+GdKeM1Ya9T6nVHzuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jiaqiyan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1f/Sx9XJ; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jiaqiyan.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3436e9e3569so7515792a91.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 15 Nov 2025 17:32:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763256752; x=1763861552; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=os6SZTaeXY813tjI0MktjS9EkkNR7SCiBq4bw5IkwZI=;
        b=1f/Sx9XJ2v2iBvGRAzOR8lGaKatzxLq5qjKEJJ5DRP4iiQDb2yNQxD/8upVBU86Xvj
         8DlDO9RqFYMPlJED5Uj3MsZS6PkmYgkXPLjWMbrfDRumYQpPlWtaq99Prdu2Ho9B8uMB
         APvBmAxoxvfpIZLzKC5cC1CylHp/UU9tBs5gcG72TWGDtkP1gweRo/GTUDc67mf8gRnb
         KRSQA+7fUaPGgNeB+uLGMs1HmTFjjVz99NKe3SbEjLfZoi1hnHPUODpEg9zWKVX31zuG
         mLMbiDK83wADMWwJ62/qzfYoljVz/Lh6xfR2GItaTeuP0Ztp8Lb/vmGfGN8rRuYGRXL4
         w56Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763256752; x=1763861552;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=os6SZTaeXY813tjI0MktjS9EkkNR7SCiBq4bw5IkwZI=;
        b=ESvMthqYjnAkYqf2xSgS+MNDYBKAvZR9a9nsZ2NCMJye/LOxX/W4w3MuELrm3htpkl
         a9gCKYS8hWpsNkWP1ZR4jMnYVPvNtVhzAzTDnYbjfPZT1fBLa/JZ0qKqvIkFzxEfxt+P
         ldgQeztVjYSS4ujcl5qh6E+rUnQoKEunY+XFHAR3R7dxP2dbCdyEo/Yw1aiFsaFqMVw8
         d2VV2l3w2ucS/6YUIMS6mX3jz6ucX8QTQJuMWfwwUbnsMfFBEe3CAi+iAkc/r5q4Z4RK
         1RsRsq/1Ig9ReRo7tZTwYTvWfHAkwdJYCIN9M3IWljpdxXIhcXil+TTlShB2z8/vkKHS
         s+JA==
X-Forwarded-Encrypted: i=1; AJvYcCXxrFeBr3dVrsYbBv+J/3fX5CRCTnEEUWsVkoc2NLSPGlx1kmPXYBrrsk/lom1O/rY0CMhtgWxkEaW3dwzj@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9/566yLK36noJelsiimx33VLTHF/SXYJjgxZHR42EGmNPyKDg
	yZ/cjWPBONIXgdZCWFLi0LeW5W2YyTyVoGxu0p5Kmv5xDLfQFnF9VprEhy5ChHizttIhKViyaPV
	bFGf5WqpnBbB68Q==
X-Google-Smtp-Source: AGHT+IFF1NojknbOkMkJx3nkb9BpNu1qDh2+jUJDNFtUK5ivMNc7tNHbVDIZXIiwRMoOI2BvT/E7mg7MjaIhSg==
X-Received: from pjpq7.prod.google.com ([2002:a17:90a:a007:b0:332:7fae:e138])
 (user=jiaqiyan job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:3a46:b0:32b:9506:1780 with SMTP id 98e67ed59e1d1-343fa0d72aemr8132252a91.9.1763256751712;
 Sat, 15 Nov 2025 17:32:31 -0800 (PST)
Date: Sun, 16 Nov 2025 01:32:23 +0000
In-Reply-To: <20251116013223.1557158-1-jiaqiyan@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251116013223.1557158-1-jiaqiyan@google.com>
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
Message-ID: <20251116013223.1557158-4-jiaqiyan@google.com>
Subject: [PATCH v2 3/3] Documentation: add documentation for MFD_MF_KEEP_UE_MAPPED
From: Jiaqi Yan <jiaqiyan@google.com>
To: nao.horiguchi@gmail.com, linmiaohe@huawei.com, william.roche@oracle.com, 
	harry.yoo@oracle.com
Cc: tony.luck@intel.com, wangkefeng.wang@huawei.com, willy@infradead.org, 
	jane.chu@oracle.com, akpm@linux-foundation.org, osalvador@suse.de, 
	rientjes@google.com, duenwen@google.com, jthoughton@google.com, 
	jgg@nvidia.com, ankita@nvidia.com, peterx@redhat.com, 
	sidhartha.kumar@oracle.com, ziy@nvidia.com, david@redhat.com, 
	dave.hansen@linux.intel.com, muchun.song@linux.dev, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Jiaqi Yan <jiaqiyan@google.com>
Content-Type: text/plain; charset="UTF-8"

Document its motivation, userspace API, behaviors, and limitations.

Signed-off-by: Jiaqi Yan <jiaqiyan@google.com>
---
 Documentation/userspace-api/index.rst         |  1 +
 .../userspace-api/mfd_mfr_policy.rst          | 60 +++++++++++++++++++
 2 files changed, 61 insertions(+)
 create mode 100644 Documentation/userspace-api/mfd_mfr_policy.rst

diff --git a/Documentation/userspace-api/index.rst b/Documentation/userspace-api/index.rst
index b8c73be4fb112..d8c6977d9e67a 100644
--- a/Documentation/userspace-api/index.rst
+++ b/Documentation/userspace-api/index.rst
@@ -67,6 +67,7 @@ Everything else
    futex2
    perf_ring_buffer
    ntsync
+   mfd_mfr_policy
 
 .. only::  subproject and html
 
diff --git a/Documentation/userspace-api/mfd_mfr_policy.rst b/Documentation/userspace-api/mfd_mfr_policy.rst
new file mode 100644
index 0000000000000..c5a25df39791a
--- /dev/null
+++ b/Documentation/userspace-api/mfd_mfr_policy.rst
@@ -0,0 +1,60 @@
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
+accessible is benifical to the owning process for a couple of reasons:
+
+- The memory pages affected by UE have a large smallest granularity, for
+  example 1G hugepage, but the actual corrupted amount of the page is only
+  several cachlines. Losing the entire hugepage of data is unacceptable to
+  the application.
+
+- In addition to keeping the data accessible, the application still wants
+  to access with a large page size for the fastest virtual-to-physical
+  translations.
+
+Memory failure recovery for 1G or larger HugeTLB is a good example. With
+memfd userspace process can control whether the kernel hard offlines its
+hugepages that backs the in-RAM file created by memfd.
+
+
+User API
+========
+
+``int memfd_create(const char *name, unsigned int flags)``
+
+``MFD_MF_KEEP_UE_MAPPED``
+
+	When ``MFD_MF_KEEP_UE_MAPPED`` bit is set in ``flags``, MF recovery
+	in the kernel does not hard offline memory due to UE until the
+	returned ``memfd`` is released. IOW, the HWPoison-ed memory remains
+	accessible via the returned ``memfd`` or the memory mapping created
+	with the returned ``memfd``. Note the affected memory will be
+	immediately isolated and prevented from future use once the memfd
+	is closed. By default ``MFD_MF_KEEP_UE_MAPPED`` is not set, and
+	kernel hard offlines memory having UEs.
+
+Notes about the behavior and limitations
+
+- Even if the page affected by UE is kept, a portion of the (huge)page is
+  already lost due to hardware corruption, and the size of the portion
+  is the smallest page size that kernel uses to manages memory on the
+  architecture, i.e. PAGESIZE. Accessing a virtual address within any of
+  these parts results in a SIGBUS; accessing virtual address outside these
+  parts are good until it is corrupted by new memory error.
+
+- ``MFD_MF_KEEP_UE_MAPPED`` currently only works for HugeTLB, so
+  ``MFD_HUGETLB`` must also be set when setting ``MFD_MF_KEEP_UE_MAPPED``.
+  Otherwise ``memfd_create`` returns EINVAL.
-- 
2.52.0.rc1.455.g30608eb744-goog


