Return-Path: <linux-fsdevel+bounces-56953-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15251B1D0A7
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Aug 2025 03:53:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0DB13B8F02
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Aug 2025 01:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F37C2797B5;
	Thu,  7 Aug 2025 01:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="Z77zGx4J"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4711A2741B3
	for <linux-fsdevel@vger.kernel.org>; Thu,  7 Aug 2025 01:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754531136; cv=none; b=MmiwVPNH1H7k0xKypk7nNzDLXFs1sTv4VFaI5/DhlrAfEMoLX2g08W0V6NYKINoQ2DH4dviklm5VYZt6SMgkbOw8rYgiud2ylTHA0p7GKTVqd18aKHGQ0I4if0pP+sepre40BoH4xgSzlsZ9fHvAy6WODBSvNLRGmawoe84Za1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754531136; c=relaxed/simple;
	bh=J79Sk6AEqFb6qwXHY80LiIIR0kdFlLi7khC7kbAVegc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nkus/9uAiQkJB0s90f8ntZ1ZRUB0OgNClYnBFpJy0BFcvWBeonHFCv4GIxrEqczd0bJr22tseEBAxuuVhdHDom+zMPU5/lWJAMdxH4SXseZwqlO53lkWAr4+w5WQYJiASnSxHw3Md6pCmbZ+Zc0ESKXka/ErzNoVc9+BEST7lTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=Z77zGx4J; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4b0a13bb0b7so5082511cf.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 06 Aug 2025 18:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1754531131; x=1755135931; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bxqnvx2r4Si9BOyfm56lPsflUxyGmt3u+0J7FV+KfwI=;
        b=Z77zGx4JrCFY/il7oa2goOH/IIDtyey4wbcpnoYFvBhJGXz9yPAzDq3ayqWlXQeS/x
         FjZRhY9lEmSAwHFPqMRZKBWVd2gXlpLRQ8L1nx6UWZw0tRlIiTj5HY0TKqPu3O/djT0Q
         nnf5jQFFxkT7VcSHa0vZMjNAwloKpo5822WBLbxnt0UKk+E8KpEqIPgQh8Hu/sXiHO4G
         nVUFT2+ScE43qABbC2f2hTV+IpZOMNULmwOOCDCQjrGrbH4rZ1VNAD6uInHcI7PWj6Cy
         Dy156M6UjHJhtQYhdSkggmP65Yb5OlslzI/OsngfSRoght3n//V/+cfqBEIuHKESv7na
         +FKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754531131; x=1755135931;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bxqnvx2r4Si9BOyfm56lPsflUxyGmt3u+0J7FV+KfwI=;
        b=PeVmsOZuLmFb1U1x39t5KAKLAy7HFNFs0OFpQORsH2c1nbR+NE6AMGyXj7d/918Fa2
         2lD5Ml6Xj8np6iWiNZhvUzCtnbrtWn3oGOChnvOEztQ1gv6fore9yuodzI9zCtfO9Pf/
         tMQvDzK3KpNN891HxKeSw7rjwGcSefHpXpObx2RFQmhjI2EdX/v40NIDlBCrh5CiLAJr
         7mYf3anNGX8oSQvNZ9ydbSfsYQDq26jvFgo/l5CRSLuEeOMhKGWwKo8p6ij2+OPPscmI
         FgDnUs8Bj/HJdjOFsGUD4hqKJu3jc8qnWFnnD3P6VLpf68NPWGnvZGn85+83tcYXMAsC
         AYfA==
X-Forwarded-Encrypted: i=1; AJvYcCWCbksqaVJBFUW9zSUJFDv9unLQ2K+ItYW8SVOIH7nrQJZAom28rWZ/mVoXGqyVQ1+Jh9EJg6U3AOR4y1wI@vger.kernel.org
X-Gm-Message-State: AOJu0YzdNH0fm8X6wRUPExH4gQqxr5yG9tNirBlQzjt6JW2T3zEPnxEo
	Uooc7s3KKN5m0KbG7OVEN+TLE4qAD4F61q/u7a+X/bttUaDESu0bMjVBOstq9wn78/M=
X-Gm-Gg: ASbGncs7RNQnHFKRS074N64CdIdbShmcrvRyCGhZhTOf9VFvz7zrbGbtelX503Q27VG
	jrHy1+kj6mKx4uB9xrqPWbvDhsJ+xwBb9Njv6zEmPuGOeQpEM64JHEc/T8w/oGYqrSisgoPW1A4
	Kxx88KB7QOgpMJDKRyMJH0550YsTJqpLJK3hRaTB5Ub3cRZ6N84Q9cV1jaILS3df+1PD0FmjZFm
	mosYUpPw3LQlZzfFIuUidu3a2/L/I9Ff5EmoxAEUIp7m5vVwUQKfMnjiwv34y9D1WX21TCzWAP+
	hs38rnrIDFb+QV7BnYt0p+OXvpi84mZBTJK69D1PrZ9LGyIo32/eX6IegH/5XWpp1FzO96rAf93
	1AOnSpufYI9ucGCUvDqp5T1w7AkkPDpFI0NWHuUrY6/nwcA3FhEe3j+uz0OZ35203J+LUv7xK4H
	HuRCe6phdvQgkS
X-Google-Smtp-Source: AGHT+IE25uuFedh62vClwjbUoKXlfnK11WcIRsY3uExXHXg77BXrLNoq560jJFcvmuXwL7CnS28NTA==
X-Received: by 2002:a05:622a:1a13:b0:4ab:76bd:ec51 with SMTP id d75a77b69052e-4b0912f603cmr60022211cf.3.1754531131249;
        Wed, 06 Aug 2025 18:45:31 -0700 (PDT)
Received: from soleen.c.googlers.com.com (235.247.85.34.bc.googleusercontent.com. [34.85.247.235])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7077cde5a01sm92969046d6.70.2025.08.06.18.45.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 18:45:30 -0700 (PDT)
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
Subject: [PATCH v3 30/30] docs: add documentation for memfd preservation via LUO
Date: Thu,  7 Aug 2025 01:44:36 +0000
Message-ID: <20250807014442.3829950-31-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.50.1.565.gc32cd1483b-goog
In-Reply-To: <20250807014442.3829950-1-pasha.tatashin@soleen.com>
References: <20250807014442.3829950-1-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pratyush Yadav <ptyadav@amazon.de>

Add the documentation under the "Preserving file descriptors" section of
LUO's documentation. The doc describes the properties preserved,
behaviour of the file under different LUO states, serialization format,
and current limitations.

Signed-off-by: Pratyush Yadav <ptyadav@amazon.de>
Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 Documentation/core-api/liveupdate.rst   |   7 ++
 Documentation/mm/index.rst              |   1 +
 Documentation/mm/memfd_preservation.rst | 138 ++++++++++++++++++++++++
 MAINTAINERS                             |   1 +
 4 files changed, 147 insertions(+)
 create mode 100644 Documentation/mm/memfd_preservation.rst

diff --git a/Documentation/core-api/liveupdate.rst b/Documentation/core-api/liveupdate.rst
index 41c4b76cd3ec..232d5f623992 100644
--- a/Documentation/core-api/liveupdate.rst
+++ b/Documentation/core-api/liveupdate.rst
@@ -18,6 +18,13 @@ LUO Preserving File Descriptors
 .. kernel-doc:: kernel/liveupdate/luo_files.c
    :doc: LUO file descriptors
 
+The following types of file descriptors can be preserved
+
+.. toctree::
+   :maxdepth: 1
+
+   ../mm/memfd_preservation
+
 Public API
 ==========
 .. kernel-doc:: include/linux/liveupdate.h
diff --git a/Documentation/mm/index.rst b/Documentation/mm/index.rst
index fb45acba16ac..c504156149a0 100644
--- a/Documentation/mm/index.rst
+++ b/Documentation/mm/index.rst
@@ -47,6 +47,7 @@ documentation, or deleted if it has served its purpose.
    hugetlbfs_reserv
    ksm
    memory-model
+   memfd_preservation
    mmu_notifier
    multigen_lru
    numa
diff --git a/Documentation/mm/memfd_preservation.rst b/Documentation/mm/memfd_preservation.rst
new file mode 100644
index 000000000000..416cd1dafc97
--- /dev/null
+++ b/Documentation/mm/memfd_preservation.rst
@@ -0,0 +1,138 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+==========================
+Memfd Preservation via LUO
+==========================
+
+Overview
+========
+
+Memory file descriptors (memfd) can be preserved over a kexec using the Live
+Update Orchestrator (LUO) file preservation. This allows userspace to transfer
+its memory contents to the next kernel after a kexec.
+
+The preservation is not intended to be transparent. Only select properties of
+the file are preserved. All others are reset to default. The preserved
+properties are described below.
+
+.. note::
+   The LUO API is not stabilized yet, so the preserved properties of a memfd are
+   also not stable and are subject to backwards incompatible changes.
+
+.. note::
+   Currently a memfd backed by Hugetlb is not supported. Memfds created
+   with ``MFD_HUGETLB`` will be rejected.
+
+Preserved Properties
+====================
+
+The following properties of the memfd are preserved across kexec:
+
+File Contents
+  All data stored in the file is preserved.
+
+File Size
+  The size of the file is preserved. Holes in the file are filled by allocating
+  pages for them during preservation.
+
+File Position
+  The current file position is preserved, allowing applications to continue
+  reading/writing from their last position.
+
+File Status Flags
+  memfds are always opened with ``O_RDWR`` and ``O_LARGEFILE``. This property is
+  maintained.
+
+Non-Preserved Properties
+========================
+
+All properties which are not preserved must be assumed to be reset to default.
+This section describes some of those properties which may be more of note.
+
+``FD_CLOEXEC`` flag
+  A memfd can be created with the ``MFD_CLOEXEC`` flag that sets the
+  ``FD_CLOEXEC`` on the file. This flag is not preserved and must be set again
+  after restore via ``fcntl()``.
+
+Seals
+  File seals are not preserved. The file is unsealed on restore and if needed,
+  must be sealed again via ``fcntl()``.
+
+Behavior with LUO states
+========================
+
+This section described the behavior of the memfd in the different LUO states.
+
+Normal Phase
+  During the normal phase, the memfd can be marked for preservation using the
+  ``LIVEUPDATE_IOCTL_FD_PRESERVE`` ioctl. The memfd acts as a regular memfd
+  during this phase with no additional restrictions.
+
+Prepared Phase
+  After LUO enters ``LIVEUPDATE_STATE_PREPARED``, the memfd is serialized and
+  prepared for the next kernel. During this phase, the below things happen:
+
+  - All the folios are pinned. If some folios reside in ``ZONE_MIGRATE``, they
+    are migrated out. This ensures none of the preserved folios land in KHO
+    scratch area.
+  - Pages in swap are swapped in. Currently, there is no way to pass pages in
+    swap over KHO, so all swapped out pages are swapped back in and pinned.
+  - The memfd goes into "frozen mapping" mode. The file can no longer grow or
+    shrink, or punch holes. This ensures the serialized mappings stay in sync.
+    The file can still be read from or written to or mmap-ed.
+
+Freeze Phase
+  Updates the current file position in the serialized data to capture any
+  changes that occurred between prepare and freeze phases. After this, the FD is
+  not allowed to be accessed.
+
+Restoration Phase
+  After being restored, the memfd is functional as normal with the properties
+  listed above restored.
+
+Cancellation
+  If the liveupdate is canceled after going into prepared phase, the memfd
+  functions like in normal phase.
+
+Serialization format
+====================
+
+The state is serialized in an FDT with the following structure::
+
+  /dts-v1/;
+
+  / {
+      compatible = "memfd-v1";
+      pos = <current_file_position>;
+      size = <file_size_in_bytes>;
+      folios = <array_of_preserved_folio_descriptors>;
+  };
+
+Each folio descriptor contains:
+
+- PFN + flags (8 bytes)
+
+  - Physical frame number (PFN) of the preserved folio (bits 63:12).
+  - Folio flags (bits 11:0):
+
+    - ``PRESERVED_FLAG_DIRTY`` (bit 0)
+    - ``PRESERVED_FLAG_UPTODATE`` (bit 1)
+
+- Folio index within the file (8 bytes).
+
+Limitations
+===========
+
+The current implementation has the following limitations:
+
+Size
+  Currently the size of the file is limited by the size of the FDT. The FDT can
+  be at of most ``MAX_PAGE_ORDER`` order. By default this is 4 MiB with 4K
+  pages. Each page in the file is tracked using 16 bytes. This limits the
+  maximum size of the file to 1 GiB.
+
+See Also
+========
+
+- :doc:`Live Update Orchestrator </admin-guide/liveupdate>`
+- :doc:`/core-api/kho/concepts`
diff --git a/MAINTAINERS b/MAINTAINERS
index 7421d21672f3..50482363c9d4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14215,6 +14215,7 @@ S:	Maintained
 F:	Documentation/ABI/testing/sysfs-kernel-liveupdate
 F:	Documentation/admin-guide/liveupdate.rst
 F:	Documentation/core-api/liveupdate.rst
+F:	Documentation/mm/memfd_preservation.rst
 F:	Documentation/userspace-api/liveupdate.rst
 F:	include/linux/liveupdate.h
 F:	include/uapi/linux/liveupdate.h
-- 
2.50.1.565.gc32cd1483b-goog


