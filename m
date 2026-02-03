Return-Path: <linux-fsdevel+bounces-76226-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EMiqNpRLgmnNRwMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76226-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Feb 2026 20:25:08 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FBFADE243
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Feb 2026 20:25:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E7C7E30EF606
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Feb 2026 19:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 579CB364026;
	Tue,  3 Feb 2026 19:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1CV82F2g"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD73836405E
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Feb 2026 19:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770146642; cv=none; b=H3BNw+rEn0/wtjLej/6QbpyPfTrQoggpeQyZonX7tZ9MOvrkv9IKJb4yB4qrV4CV1FJz90cxITSilbeIKgz3pRLusnsOYQ6nq9CjIDiuQJ4z+clW/LRdDDnGz6tA0HuY63k7sPgYMBlc/+Rjak0EIKnbXfj0t7iUhTsHHQf6ebs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770146642; c=relaxed/simple;
	bh=xSXUV2Py7qWOXZ0kXPtRSXoGc7TMmvAZq4THKRHLYqg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hXi66MA43htV1ZfKEqFYaDJQerUw57ywLXXIwxrkR8+o8Z4nYVyl8g8FMJRlTeVtAnrjnNCUsLnF6n5HKgL12GHAYc10Vtmioh2mBa4BkQvZyAWstAJWWN5wyKcpM5fdtVYtbRW4vEJfeGe0r1/H/Eby1T+R/qlGF+0lvA+c3Q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jiaqiyan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1CV82F2g; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jiaqiyan.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2a8f8c81d02so32800815ad.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Feb 2026 11:24:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770146640; x=1770751440; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Aquur2bWSawAVy++fhfPAogrKIXUck0YPKC9WFv0tRU=;
        b=1CV82F2gf00mXb32dHCazM+iIEfRUf7IrK6WSwtcLVGQtb3kwfGE6CSS+OeMyzYBiI
         fURXn76wW9y98UMuTzRHtCtnP1DWgLcXzIl75MwQ/GuFHBaKaIRwEOAuKTdpikumhJzn
         56R2fvGvqQt6fIhEmS8+F5bnwTQpXARo5cYAMp9aVAC+9V1TtuIXLxQftMVryTFA4pML
         J7vqQoxQPxyT85WyRlUeveB4utSEyimy87FJOhH0yvwlkAn55wziUa0IOZsxMk1NdFCz
         sL426eBaJwitevEuXAaSxeyRWdPyIiyW+CIItkTfpNtYrNBt6wlkOd0CtLYxxiXHVOk0
         8oIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770146640; x=1770751440;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Aquur2bWSawAVy++fhfPAogrKIXUck0YPKC9WFv0tRU=;
        b=k+wkRUImQrReMsjRzVSLMEXz8Pm8zr3NpQXtLWFhSTQeydtu7nKHFAQmAQfv3WkDZD
         Wyji5I/+tNCxdWR6wl4MJaFTC8KDVMFI98nk5zzGT5a//lWkW04lfkF4bVNhGzZayZZL
         oJUE243b5+hcSxYbhNf3g7HiuqNZxgD2V33BCtBvF2Cos7lH+UfrJHHzztKIjeuDGaX6
         mUcZYpEGlFIexF5Bv3r60YMrfR5TSNvM89k/yPJ/TZtJLFaQlupyDg8FpF7edTGT0BNq
         80n4Qh0Z50poykXMJtJn3n8XWuSRagv29i1hc58L+ZmgzX/bTdALWzCz2zBzBud1fUzK
         QSyA==
X-Forwarded-Encrypted: i=1; AJvYcCXRVa6+tmkvQXS7tt15c3nDRIJrKA8yePTmkld/9UET0a3MWQJuhYBkqZtHY46wKg47FdlOO2v3QakdmoDT@vger.kernel.org
X-Gm-Message-State: AOJu0YzTqLF5uCvEStsv5clPk+WKilsPYfu5X78FoGyEUXRjcOObN6UD
	wWidq+Dtrt7MyKZrBT5cOdno6UPZstqq0o1NEWyUNUSQK56DsWPGicaSThzP7f4u9/RXDWSrAPK
	hvoSc+L/jfZrG3A==
X-Received: from pjvv12.prod.google.com ([2002:a17:90b:588c:b0:352:bd7e:99e7])
 (user=jiaqiyan job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:40ce:b0:2a7:c8db:488a with SMTP id d9443c01a7336-2a933b9d168mr3697935ad.7.1770146640258;
 Tue, 03 Feb 2026 11:24:00 -0800 (PST)
Date: Tue,  3 Feb 2026 19:23:52 +0000
In-Reply-To: <20260203192352.2674184-1-jiaqiyan@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260203192352.2674184-1-jiaqiyan@google.com>
X-Mailer: git-send-email 2.53.0.rc2.204.g2597b5adb4-goog
Message-ID: <20260203192352.2674184-4-jiaqiyan@google.com>
Subject: [PATCH v3 3/3] Documentation: add documentation for MFD_MF_KEEP_UE_MAPPED
From: Jiaqi Yan <jiaqiyan@google.com>
To: linmiaohe@huawei.com, william.roche@oracle.com, harry.yoo@oracle.com, 
	jane.chu@oracle.com
Cc: nao.horiguchi@gmail.com, tony.luck@intel.com, wangkefeng.wang@huawei.com, 
	willy@infradead.org, akpm@linux-foundation.org, osalvador@suse.de, 
	rientjes@google.com, duenwen@google.com, jthoughton@google.com, 
	jgg@nvidia.com, ankita@nvidia.com, peterx@redhat.com, 
	sidhartha.kumar@oracle.com, ziy@nvidia.com, david@redhat.com, 
	dave.hansen@linux.intel.com, muchun.song@linux.dev, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Jiaqi Yan <jiaqiyan@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-76226-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiaqiyan@google.com,linux-fsdevel@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,intel.com,huawei.com,infradead.org,linux-foundation.org,suse.de,google.com,nvidia.com,redhat.com,oracle.com,linux.intel.com,linux.dev,kvack.org,vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3FBFADE243
X-Rspamd-Action: no action

Document its motivation, userspace API, behaviors, and limitations.

Reviewed-by: Jane Chu <jane.chu@oracle.com>
Signed-off-by: Jiaqi Yan <jiaqiyan@google.com>
---
 Documentation/userspace-api/index.rst         |  1 +
 .../userspace-api/mfd_mfr_policy.rst          | 60 +++++++++++++++++++
 2 files changed, 61 insertions(+)
 create mode 100644 Documentation/userspace-api/mfd_mfr_policy.rst

diff --git a/Documentation/userspace-api/index.rst b/Documentation/userspace-api/index.rst
index 8a61ac4c1bf19..6d8d94028a6cd 100644
--- a/Documentation/userspace-api/index.rst
+++ b/Documentation/userspace-api/index.rst
@@ -68,6 +68,7 @@ Everything else
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
2.53.0.rc2.204.g2597b5adb4-goog


