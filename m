Return-Path: <linux-fsdevel+bounces-76747-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EAV6OVQ2immhIQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76747-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Feb 2026 20:32:36 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B0311141FC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Feb 2026 20:32:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2020A301C941
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Feb 2026 19:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 607B83A6403;
	Mon,  9 Feb 2026 19:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aiV0zTQ1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 688ED38759B
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Feb 2026 19:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770665554; cv=none; b=nOiqvYJaJrWVM9Y377m9dxQHHuZxNs/dD9Yo37WQU+ipYbnz8QKHrijx2w7/D6lPyz4V03ilBI/SAPzIV7uZFX2SPPZJ8FGeiIozXaogaaDCeNCtusd0GDiASQTf4+YwWVoLwSVlCGpoD4VqcNdfPwfaF8IcpW+YUhCSYCGiYIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770665554; c=relaxed/simple;
	bh=mO9KvaCxSxjaKQri3HOqdCrZdJkCwNtMjDtvvxJltKs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bny8dl4HyXTVptBMhGnea965H8D5dD73yl4n/b3JwfGKUPMhc84ryRSIRe7VEvsmlychP1HzO89Qe3HWOv9Sx2azY4PXP8ETRGXxXA9LmAlSOefWF+YP3W9p9Ohi3Mms9LwI2Mqi0Q6n9TVIzXhQ7AOLTpdI6oUp6ZO7PyFaeoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aiV0zTQ1; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770665554; x=1802201554;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=mO9KvaCxSxjaKQri3HOqdCrZdJkCwNtMjDtvvxJltKs=;
  b=aiV0zTQ1JYE0wdo0jhTCPW+6rh1TPL5qXHv9c/9k+iM8pDM0glpYNmOf
   dzk+w6nZi92/U7ufVHm8YyqPkqXn9dn+chJPGj/mShrG7uJ+6Bizq0iNo
   9sHiZLs7POqF0QidObTzkhhNlcjGxc5bTVP+/RiO+15gIHazx3SVKsyEs
   2Rxq+S13fTfOS9FPMwKEiLFAwDwXWZS57osg7ZQCmJ7tA8irBgcvQ9F5p
   XFXdM7LNWzybBCS9eiXSWEzmm48NlNApJ5rl8ROlFKdXE0WkM95XPW4/4
   ksep/1nisd8jqPHVrgdywrj5dLZaBbiV3b3l4HxWTt4maOSc/LY15+p4t
   Q==;
X-CSE-ConnectionGUID: WQ2fL4rKTM++FSnQnCodug==
X-CSE-MsgGUID: cKSA+NizR+uCMPwN+8WiJQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11696"; a="70802119"
X-IronPort-AV: E=Sophos;i="6.21,282,1763452800"; 
   d="scan'208";a="70802119"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2026 11:32:33 -0800
X-CSE-ConnectionGUID: 1ygWWuVbRbmxaaSteuvK0Q==
X-CSE-MsgGUID: Acs6ICtBTHueukP3Nu72Zw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,282,1763452800"; 
   d="scan'208";a="234625411"
Received: from tassilo.jf.intel.com ([10.54.38.190])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2026 11:32:32 -0800
From: Andi Kleen <ak@linux.intel.com>
To: linux-mm@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	akpm@linux-foundation.org,
	Andi Kleen <ak@linux.intel.com>
Subject: [PATCH] smaps: Report correct page sizes with THP
Date: Mon,  9 Feb 2026 11:32:23 -0800
Message-ID: <20260209193223.230797-1-ak@linux.intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-76747-lists,linux-fsdevel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ak@linux.intel.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCVD_COUNT_FIVE(0.00)[5];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.intel.com:mid,intel.com:email,intel.com:dkim]
X-Rspamd-Queue-Id: 5B0311141FC
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


