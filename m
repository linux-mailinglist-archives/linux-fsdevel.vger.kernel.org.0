Return-Path: <linux-fsdevel+bounces-76752-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qLGlBfJAimmKIwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76752-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Feb 2026 21:17:54 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5028D1145D6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Feb 2026 21:17:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 74DCC3024143
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Feb 2026 20:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06E0A331A6A;
	Mon,  9 Feb 2026 20:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZHOPSEhQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73718324B2B
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Feb 2026 20:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770668257; cv=none; b=XGULOJ95Ark2/loqETmuromTchfcse2K2+1u3iRb5rgkA4e7nmML/82o0wYdxIVIotVPAvLnLPzxY+k6HUhNuC87t3pWcHxgQycGeuGTdTR6ius7rU8la0ubuSWhVXBOvpXRBrvs3wAEZreKaTyZi5ltEJp4p3IWyBVs/fIwui8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770668257; c=relaxed/simple;
	bh=mO9KvaCxSxjaKQri3HOqdCrZdJkCwNtMjDtvvxJltKs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K5wZYV0ohLk8KBqc14SjbQs2z9UImjBkZuXIzQjcfCB2/+NkQZTAU4lz6pniZlMQJJHvlIfK42HXiy1PU+QYU+qBCbIcMOR8KAscAV/BFFZRiE3PxxifxB5OlpSpAfTIhi3Zs68JDxs0NPP7sQ1Gd+7UNKpO55F/9AOnJPzduaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZHOPSEhQ; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770668258; x=1802204258;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=mO9KvaCxSxjaKQri3HOqdCrZdJkCwNtMjDtvvxJltKs=;
  b=ZHOPSEhQV0b81ps9Yw7GCGA7G5mmXEIUT9QrQEjyZw6njIYdHAxQmNiP
   QNQD+pAy4zzFAGyjmNQ+GFjV/K3RvK1gZEcY4VmZOZpL7wWQ2/Eip4/RE
   1jvGYPL3h2HiZ4psZt+bxFQgBXz4zFn9UbccVZzuvh3mqMhABy0raNiJi
   lMnYWuUvWc1ULAu9/nSimfwzWh1+NnDg8j98P2JRLqBMilyh9Slm5+CcV
   wI7afu3rDwTUNurpm2qDPfS/fJRoF5zmYQMeFh5IJ8zS13OCInQWRE/I1
   NwyfTgiAANAb5BwIEUwLqIJKxGG6oAaVVOCwiMxS5/aYglLqUzPTeZNc+
   A==;
X-CSE-ConnectionGUID: 2JvEO8OnRBmxoBH6DRbVZw==
X-CSE-MsgGUID: 5bfqSwZQT++KvajGBsXYig==
X-IronPort-AV: E=McAfee;i="6800,10657,11696"; a="83231538"
X-IronPort-AV: E=Sophos;i="6.21,282,1763452800"; 
   d="scan'208";a="83231538"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2026 12:17:37 -0800
X-CSE-ConnectionGUID: DcmBMGoGTcOOSpT/zJuwiA==
X-CSE-MsgGUID: 9aPAnJ21Q3iYSJrPbkPMag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,282,1763452800"; 
   d="scan'208";a="249315748"
Received: from tassilo.jf.intel.com ([10.54.38.190])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2026 12:17:37 -0800
From: Andi Kleen <ak@linux.intel.com>
To: linux-mm@kvack.org
Cc: linux-fsdevel@vger.kernel.org,
	akpm@linux-foundation.org,
	willy@infradead.org,
	Andi Kleen <ak@linux.intel.com>
Subject: [PATCH] smaps: Report correct page sizes with THP
Date: Mon,  9 Feb 2026 12:17:31 -0800
Message-ID: <20260209201731.231667-1-ak@linux.intel.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76752-lists,linux-fsdevel=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ak@linux.intel.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,intel.com:dkim]
X-Rspamd-Queue-Id: 5028D1145D6
X-Rspamd-Action: no action

Recently I wasted quite some time debugging why THP didn't work, when it
was just smaps always reporting the base page size. It has separate
counts for (non m) THP, but using them is not always obvious. For
standard THP the page sizes can be actually derived from the existing
counts, so do just do that. I left KernelPageSize alone.
The mixed page size case is reported with a new MMUPageSize2 item.
This doesn't do anything about mTHP reporting, but even the basic
smaps is not aware of it so far.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
---
 Documentation/filesystems/proc.rst |  2 +-
 fs/proc/task_mmu.c                 | 14 +++++++++++++-
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
index 8256e857e2d7..7c776046d15a 100644
--- a/Documentation/filesystems/proc.rst
+++ b/Documentation/filesystems/proc.rst
@@ -483,7 +483,7 @@ entries; the page size used by the MMU when backing a VMA (in most cases,
 the same as KernelPageSize); the amount of the mapping that is currently
 resident in RAM (RSS); the process's proportional share of this mapping
 (PSS); and the number of clean and dirty shared and private pages in the
-mapping.
+mapping. If the mapping has multiple page size there might be a MMUPageSize2.
 
 The "proportional set size" (PSS) of a process is the count of pages it has
 in memory, where each page is divided by the number of processes sharing it.
diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 26188a4ad1ab..9123e59dcf4c 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -1377,7 +1377,19 @@ static int show_smap(struct seq_file *m, void *v)
 
 	SEQ_PUT_DEC("Size:           ", vma->vm_end - vma->vm_start);
 	SEQ_PUT_DEC(" kB\nKernelPageSize: ", vma_kernel_pagesize(vma));
-	SEQ_PUT_DEC(" kB\nMMUPageSize:    ", vma_mmu_pagesize(vma));
+
+	/* Only THP? */
+	if (mss.shmem_thp + mss.file_thp + mss.anonymous_thp == mss.resident &&
+	    mss.resident > 0) {
+		SEQ_PUT_DEC(" kB\nMMUPageSize:    ", HPAGE_PMD_SIZE);
+	} else {
+		unsigned ps = vma_mmu_pagesize(vma);
+		/* Will need adjustments when more THP page sizes are added. */
+		SEQ_PUT_DEC(" kB\nMMUPageSize:    ", ps);
+		if (mss.shmem_thp + mss.file_thp + mss.anonymous_thp > 0 &&
+		    ps != HPAGE_PMD_SIZE)
+			SEQ_PUT_DEC(" kB\nMMUPageSize2:   ", HPAGE_PMD_SIZE);
+	}
 	seq_puts(m, " kB\n");
 
 	__show_smap(m, &mss, false);
-- 
2.52.0


