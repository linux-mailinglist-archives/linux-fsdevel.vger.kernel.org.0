Return-Path: <linux-fsdevel+bounces-79579-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kDnbN1WPqmm/TgEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79579-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Mar 2026 09:24:53 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 61CC621D07B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Mar 2026 09:24:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A31B13079679
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Mar 2026 08:19:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAA97372ED1;
	Fri,  6 Mar 2026 08:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hHVNtRYW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C033B2A0;
	Fri,  6 Mar 2026 08:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772785168; cv=none; b=m76uQk9wJ/QRBOuojbDUURldOzTVKI3VmizOyWhLfliGTIPDcOdjJmz0p7/jBGsMz1m9wS2NH8scgtsJziRMZ/B2WqrkdIgXkXs4BqCe1RUbubGOWuMMI/hUGdjKVxg2YVZDybMCvn2axuP0h5EgjuGRUGz5ugLsvyBZd2Q418s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772785168; c=relaxed/simple;
	bh=kMVOZgHqgskvS2CBGSkoHJyRYRfBjXLs2IdWaLMUf6Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Fty9oN9kWn0wHYBYmPi25qoHKFnPsXv1Cg23bv1TXuvBrQX0ose3ao59tYEpNXXku6JBQs4r7Vc+Zgm4IX+inERqsPA+SDd3KFPv07MAvcv6Ll7ap7ymGlAY6WubDxxft0RNCxJC4q2mgseZDvv6e1PVF8tsvfhNDhgFETiR9UE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hHVNtRYW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5247BC4CEF7;
	Fri,  6 Mar 2026 08:19:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772785167;
	bh=kMVOZgHqgskvS2CBGSkoHJyRYRfBjXLs2IdWaLMUf6Y=;
	h=From:To:Cc:Subject:Date:From;
	b=hHVNtRYWV1oR9UnWiXdQaPaj+2AlH0+JXBxnCseutgpZQQw6APuxnIlJXVnLmkij8
	 JdtHoRsDExTjVPf85DdHCvhAS81OtKDsWZHUJ2EFFxJBurMB7Oo1n/XkIRLijGXD9d
	 ZlS28EmLCVwiW7xQo2DkeYNjsFBnxEuG/1qYMoJWZukSkAwtz1zZw7spDYym0fhYjd
	 HvmscLDnnbYzXznX1tydTfBF+5G81l5k5dD+Dru5yO0MpR49lRRg9PqaeA7ajZ3/Sq
	 7TuzaB6ySbOeum4ZQgSvh1Bqxz62xmI8jz5dOf/nrdmF+Fhnqx95hXMh8g8pXxHv7Y
	 IoLZ7QL7yOQnQ==
From: "David Hildenbrand (Arm)" <david@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-mm@kvack.org,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	Zi Yan <ziy@nvidia.com>,
	Lance Yang <lance.yang@linux.dev>,
	Vlastimil Babka <vbabka@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Nico Pache <npache@redhat.com>,
	Dev Jain <dev.jain@arm.com>,
	Barry Song <baohua@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Usama Arif <usamaarif642@gmail.com>,
	Andi Kleen <ak@linux.intel.com>
Subject: [PATCH v2] docs: filesystems: clarify KernelPageSize vs. MMUPageSize in smaps
Date: Fri,  6 Mar 2026 09:19:16 +0100
Message-ID: <20260306081916.38872-1-david@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 61CC621D07B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kvack.org,kernel.org,nvidia.com,linux.dev,linux-foundation.org,oracle.com,linux.alibaba.com,redhat.com,arm.com,lwn.net,linuxfoundation.org,gmail.com,linux.intel.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-79579-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
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

Also drop the duplicate "KernelPageSize" and "MMUPageSize" entries in
the example.

Link: https://lore.kernel.org/all/20260225232708.87833-1-ak@linux.intel.com/
Reviewed-by: Zi Yan <ziy@nvidia.com>
Reviewed-by: Lance Yang <lance.yang@linux.dev>
Acked-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
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

v1 -> v2:
* Some rewording and clarifications
* Drop duplicate entries in the example

---
 Documentation/filesystems/proc.rst | 40 +++++++++++++++++++++---------
 1 file changed, 28 insertions(+), 12 deletions(-)

diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
index b0c0d1b45b99..e2d22a424dcd 100644
--- a/Documentation/filesystems/proc.rst
+++ b/Documentation/filesystems/proc.rst
@@ -464,26 +464,37 @@ Memory Area, or VMA) there is a series of lines such as the following::
     KSM:                   0 kB
     LazyFree:              0 kB
     AnonHugePages:         0 kB
+    FilePmdMapped:         0 kB
     ShmemPmdMapped:        0 kB
     Shared_Hugetlb:        0 kB
     Private_Hugetlb:       0 kB
     Swap:                  0 kB
     SwapPss:               0 kB
-    KernelPageSize:        4 kB
-    MMUPageSize:           4 kB
     Locked:                0 kB
     THPeligible:           0
     VmFlags: rd ex mr mw me dw
 
 The first of these lines shows the same information as is displayed for
 the mapping in /proc/PID/maps.  Following lines show the size of the
-mapping (size); the size of each page allocated when backing a VMA
-(KernelPageSize), which is usually the same as the size in the page table
-entries; the page size used by the MMU when backing a VMA (in most cases,
-the same as KernelPageSize); the amount of the mapping that is currently
-resident in RAM (RSS); the process's proportional share of this mapping
-(PSS); and the number of clean and dirty shared and private pages in the
-mapping.
+mapping (size); the smallest possible page size allocated when backing a
+VMA (KernelPageSize), which is the granularity in which VMA modifications
+can be performed; the smallest possible page size that could be used by the
+MMU (MMUPageSize) when backing a VMA; the amount of the mapping that is
+currently resident in RAM (RSS); the process's proportional share of this
+mapping (PSS); and the number of clean and dirty shared and private pages
+in the mapping.
+
+"KernelPageSize" always corresponds to "MMUPageSize", except when a larger
+kernel page size is emulated on a system with a smaller page size used by the
+MMU, which is the case for some PPC64 setups with hugetlb.  Furthermore,
+"KernelPageSize" and "MMUPageSize" always correspond to the smallest
+possible granularity (fallback) that can be encountered in a VMA throughout
+its lifetime.  These values are not affected by Transparent Huge Pages
+being in effect, or any usage of larger MMU page sizes (either through
+architectural huge-page mappings or other explicit/implicit coalescing of
+virtual ranges performed by the MMU).  "AnonHugePages", "ShmemPmdMapped" and
+"FilePmdMapped" provide insight into the usage of PMD-level architectural
+huge-page mappings.
 
 The "proportional set size" (PSS) of a process is the count of pages it has
 in memory, where each page is divided by the number of processes sharing it.
@@ -528,10 +539,15 @@ pressure if the memory is clean. Please note that the printed value might
 be lower than the real value due to optimizations used in the current
 implementation. If this is not desirable please file a bug report.
 
-"AnonHugePages" shows the amount of memory backed by transparent hugepage.
+"AnonHugePages", "ShmemPmdMapped" and "FilePmdMapped" show the amount of
+memory backed by Transparent Huge Pages that are currently mapped by
+architectural huge-page mappings at the PMD level. "AnonHugePages"
+corresponds to memory that does not belong to a file, "ShmemPmdMapped" to
+shared memory (shmem/tmpfs) and "FilePmdMapped" to file-backed memory
+(excluding shmem/tmpfs).
 
-"ShmemPmdMapped" shows the amount of shared (shmem/tmpfs) memory backed by
-huge pages.
+There are no dedicated entries for Transparent Huge Pages (or similar concepts)
+that are not mapped by architectural huge-page mappings at the PMD level.
 
 "Shared_Hugetlb" and "Private_Hugetlb" show the amounts of memory backed by
 hugetlbfs page which is *not* counted in "RSS" or "PSS" field for historical
-- 
2.43.0


