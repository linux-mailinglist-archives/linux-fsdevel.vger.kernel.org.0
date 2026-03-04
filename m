Return-Path: <linux-fsdevel+bounces-79426-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EPUkF+BXqGkYtgAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79426-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Mar 2026 17:03:44 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E9C9F203A16
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Mar 2026 17:03:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 04D4A30910EC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Mar 2026 15:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7491435AC0B;
	Wed,  4 Mar 2026 15:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JpXrKQDJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F12B6350299;
	Wed,  4 Mar 2026 15:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772639807; cv=none; b=J7s0XozQVGDQCCON5tRaHcChDJ7SgRNApcdIWxDrWpRmii95Bchf87M66iNp/BEpB5fF6M+ecH8ncp5hzz5JpIj2Punvu7QZlKc04GsNOpDxWiw7wD8ST9ij7+qNpH0RgaExpI9Cnn9XDRz1ysBt6WepUMS3i6NAgo2oZY/GTnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772639807; c=relaxed/simple;
	bh=SJm4GuSnbYszVKyxT4amRwFe33V6qzxh/kVyiR1igu4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ANL1ypVNb+tBew4yJKa/CbLZP2+5T/TuvGes6Rt4rhy0WGLrS/cGpPZ/AYcvorqLC5ofugzr+d2c4k7uOqT1YOR1eoZNi/n2xHrKedL3D/Ho3C8Hwc5fAcewPyt7mJAbSY/LkZ23ndxKal351ehEDr+H4yoHm0kz19T0kJh3yrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JpXrKQDJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB04FC19423;
	Wed,  4 Mar 2026 15:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772639806;
	bh=SJm4GuSnbYszVKyxT4amRwFe33V6qzxh/kVyiR1igu4=;
	h=From:To:Cc:Subject:Date:From;
	b=JpXrKQDJgkQZ5nG7H5rajo8ti08hDhRDHS0Tcbebrb7Ko8lnA2n0pO/doWPie//Zs
	 VcywXdRhl7TM3rlw2Uho0gplR/QjKPWxoX3a+HNIUQaF5gy9Np8lKkCIFqoHvyA1Yr
	 4LV6yCaWvW644thqATm0sSN/0t4QIFk1Tqg7OVgTX7/FgvWw4DjnXO+Qf1n1KjpxQw
	 LnQobDBjB9gI2SdhbtLpH4wqu+/plM2RyykoBGYN9yo873BZ2TyQOJUsJwWu1/fxSb
	 FCqZhXnj4y9xe2plxkG9qT2ZmKdgH8ZDAR61yYmTP6CKnLwkP6+lLGfKfin5Zd3c4g
	 sz+yU7Y3T+OPw==
From: "David Hildenbrand (Arm)" <david@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-mm@kvack.org,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Nico Pache <npache@redhat.com>,
	Dev Jain <dev.jain@arm.com>,
	Barry Song <baohua@kernel.org>,
	Lance Yang <lance.yang@linux.dev>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Usama Arif <usamaarif642@gmail.com>,
	Andi Kleen <ak@linux.intel.com>
Subject: [PATCH v1] docs: filesystems: clarify KernelPageSize vs. MMUPageSize in smaps
Date: Wed,  4 Mar 2026 16:56:36 +0100
Message-ID: <20260304155636.77433-1-david@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E9C9F203A16
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kvack.org,kernel.org,linux-foundation.org,oracle.com,nvidia.com,linux.alibaba.com,redhat.com,arm.com,linux.dev,lwn.net,linuxfoundation.org,gmail.com,linux.intel.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-79426-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[david@kernel.org,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

There was recently some confusion around THPs and the interaction with
KernelPageSize / MMUPageSize. Historically, these entries always
correspond to the smallest size we could encounter, not any current
usage of transparent huge pages or larger sizes used by the MMU.

Ever since we added THP support many, many years ago, these entries
would keep reporting the smallest (fallback) granularity in a VMA.

For this reason, they default to PAGE_SIZE for all VMAs except for
VMAs where we have the guarantee that the system and the MMU will
always use larger page sizes. hugetlb, for example, exposes a custom
vm_ops->pagesize callback to handle that. Similarly, dax/device
exposes a custom vm_ops->pagesize callback and provides similar
guarantees.

Let's clarify the historical meaning of KernelPageSize / MMUPageSize,
and point at "AnonHugePages", "ShmemPmdMapped" and "FilePmdMapped"
regarding PMD entries.

While at it, document "FilePmdMapped", clarify what the "AnonHugePages"
and "ShmemPmdMapped" entries really mean, and make it clear that there
are no other entries for other THP/folio sizes or mappings.

Link: https://lore.kernel.org/all/20260225232708.87833-1-ak@linux.intel.com/
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Zi Yan <ziy@nvidia.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Liam R. Howlett <Liam.Howlett@oracle.com>
Cc: Nico Pache <npache@redhat.com>
Cc: Ryan Roberts <ryan.roberts@arm.com
Cc: Dev Jain <dev.jain@arm.com>
Cc: Barry Song <baohua@kernel.org>
Cc: Lance Yang <lance.yang@linux.dev>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Shuah Khan <skhan@linuxfoundation.org>
Cc: Usama Arif <usamaarif642@gmail.com>
Cc: Andi Kleen <ak@linux.intel.com>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 Documentation/filesystems/proc.rst | 37 ++++++++++++++++++++++--------
 1 file changed, 27 insertions(+), 10 deletions(-)

diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
index b0c0d1b45b99..0f67e47528fc 100644
--- a/Documentation/filesystems/proc.rst
+++ b/Documentation/filesystems/proc.rst
@@ -464,6 +464,7 @@ Memory Area, or VMA) there is a series of lines such as the following::
     KSM:                   0 kB
     LazyFree:              0 kB
     AnonHugePages:         0 kB
+    FilePmdMapped:         0 kB
     ShmemPmdMapped:        0 kB
     Shared_Hugetlb:        0 kB
     Private_Hugetlb:       0 kB
@@ -477,13 +478,25 @@ Memory Area, or VMA) there is a series of lines such as the following::
 
 The first of these lines shows the same information as is displayed for
 the mapping in /proc/PID/maps.  Following lines show the size of the
-mapping (size); the size of each page allocated when backing a VMA
-(KernelPageSize), which is usually the same as the size in the page table
-entries; the page size used by the MMU when backing a VMA (in most cases,
-the same as KernelPageSize); the amount of the mapping that is currently
-resident in RAM (RSS); the process's proportional share of this mapping
-(PSS); and the number of clean and dirty shared and private pages in the
-mapping.
+mapping (size); the smallest possible page size allocated when
+backing a VMA (KernelPageSize), which is the granularity in which VMA
+modifications can be performed; the smallest possible page size that could
+be used by the MMU (MMUPageSize) when backing a VMA; the amount of the
+mapping that is currently resident in RAM (RSS); the process's proportional
+share of this mapping (PSS); and the number of clean and dirty shared and
+private pages in the mapping.
+
+Historically, the "KernelPageSize" always corresponds to the "MMUPageSize",
+except when a larger kernel page size is emulated on a system with a smaller
+page size used by the MMU, which was the case for PPC64 in the past.
+Further, "KernelPageSize" and "MMUPageSize" always correspond to the
+smallest possible granularity (fallback) that could be encountered in a
+VMA throughout its lifetime.  These values are not affected by any current
+transparent grouping of pages by Linux (Transparent Huge Pages) or any
+current usage of larger MMU page sizes (either through architectural
+huge-page mappings or other transparent groupings done by the MMU).
+"AnonHugePages", "ShmemPmdMapped" and "FilePmdMapped" provide insight into
+the usage of some architectural huge-page mappings.
 
 The "proportional set size" (PSS) of a process is the count of pages it has
 in memory, where each page is divided by the number of processes sharing it.
@@ -528,10 +541,14 @@ pressure if the memory is clean. Please note that the printed value might
 be lower than the real value due to optimizations used in the current
 implementation. If this is not desirable please file a bug report.
 
-"AnonHugePages" shows the amount of memory backed by transparent hugepage.
+"AnonHugePages", "ShmemPmdMapped" and "FilePmdMapped" show the amount of
+memory backed by transparent hugepages that are currently mapped through
+architectural huge-page mappings (PMD). "AnonHugePages" corresponds to memory
+that does not belong to a file, "ShmemPmdMapped" to shared memory (shmem/tmpfs)
+and "FilePmdMapped" to file-backed memory (excluding shmem/tmpfs).
 
-"ShmemPmdMapped" shows the amount of shared (shmem/tmpfs) memory backed by
-huge pages.
+There are no dedicated entries for transparent huge pages (or similar concepts)
+that are not mapped through architectural huge-page mappings (PMD).
 
 "Shared_Hugetlb" and "Private_Hugetlb" show the amounts of memory backed by
 hugetlbfs page which is *not* counted in "RSS" or "PSS" field for historical
-- 
2.43.0


