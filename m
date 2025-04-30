Return-Path: <linux-fsdevel+bounces-47729-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71D60AA4F60
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Apr 2025 17:01:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE86A9A593D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Apr 2025 15:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C56041A841A;
	Wed, 30 Apr 2025 14:59:39 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8167E1A5B84;
	Wed, 30 Apr 2025 14:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746025179; cv=none; b=nntuW32uX2GAiTKkW+5soOeUcYJ8GChQotIK436HMdOnzXpryeKUy6hmUbLjiE9Nh6L3c2W67NFqBEi3kQGrBDcla3XCTAVTspRPdeeJg7H1U9p2Prh2++OiBUGcLvtkLvlrVrIFxvUFkMN5cyfTjX23jX3XbWQCr+onhuz92Js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746025179; c=relaxed/simple;
	bh=RhAzlCJbPtUUpaoj2kdnNovqzYuOnqKFmxO+EPw/OLA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nhELvvDwrbHDsgkOsjaNkA942A3KG0jf8oT1/b/kbfuW6HDMbfQTiWWj7a/SVmna22ZU1fKA8IlO5U1y0SYOb97U1Zk8xmHJ4z28lO4EV0lmpycQPFM0gqW6oSgCzEExq1bCZxNIZREIThmfm5t44z15ZFxdnJ3cGPS9ms0Ewl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 66C201007;
	Wed, 30 Apr 2025 07:59:24 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B37EC3F5A1;
	Wed, 30 Apr 2025 07:59:29 -0700 (PDT)
From: Ryan Roberts <ryan.roberts@arm.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	David Hildenbrand <david@redhat.com>,
	Dave Chinner <david@fromorbit.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Kalesh Singh <kaleshsingh@google.com>,
	Zi Yan <ziy@nvidia.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v4 0/5] Readahead tweaks for larger folios
Date: Wed, 30 Apr 2025 15:59:13 +0100
Message-ID: <20250430145920.3748738-1-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi All,

This RFC series adds some tweaks to readahead so that it does a better job of
ramping up folio sizes as readahead extends further into the file. And it
additionally special-cases executable mappings to allow the arch to request a
preferred folio size for text.

Previous versions of the series focussed on the latter part only (large folios
for text). See [3]. But after discussion with Matthew Wilcox last week, we
decided that we should really be fixing some of the unintended behaviours in how
a folio size is selected in general before special-casing for text. As a result
patches 1-4 make folio size selection behave more sanely, then patch 5
introduces large folios for text. Patch 5 depends on patch 1, but does not
depend on patches 2-4.

---

I'm leaving this marked as RFC for now as I intend to do more testing, and
haven't yet updated the benchmark results in patch 5 (although I expect them to
be similar).

Applies on top of Monday's mm-unstable (b18dec6a6ad3) and passes all mm
kselftests.

Changes since v3 [3]
====================

 - Added patchs 1-4 to do better job of ramping up folio order
 - In patch 5:
   - Confine readahead blocks to vma boundaries (per Kalesh)
   - Rename arch_exec_folio_order() to exec_folio_order() (per Matthew)
   - exec_folio_order() now returns unsigned int and defaults to order-0
     (per Matthew)
   - readahead size is honoured (including when disabled)

Changes since v2 [2]
====================

 - Rename arch_wants_exec_folio_order() to arch_exec_folio_order() (per Andrew)
 - Fixed some typos (per Andrew)

Changes since v1 [1]
====================

 - Remove "void" from arch_wants_exec_folio_order() macro args list

[1] https://lore.kernel.org/linux-mm/20240111154106.3692206-1-ryan.roberts@arm.com/
[2] https://lore.kernel.org/all/20240215154059.2863126-1-ryan.roberts@arm.com/
[3] https://lore.kernel.org/linux-mm/20250327160700.1147155-1-ryan.roberts@arm.com/

Thanks,
Ryan

Ryan Roberts (5):
  mm/readahead: Honour new_order in page_cache_ra_order()
  mm/readahead: Terminate async readahead on natural boundary
  mm/readahead: Make space in struct file_ra_state
  mm/readahead: Store folio order in struct file_ra_state
  mm/filemap: Allow arch to request folio size for exec memory

 arch/arm64/include/asm/pgtable.h |  8 +++++
 include/linux/fs.h               |  4 ++-
 include/linux/pgtable.h          | 11 +++++++
 mm/filemap.c                     | 55 ++++++++++++++++++++++++--------
 mm/internal.h                    |  3 +-
 mm/readahead.c                   | 27 +++++++++-------
 6 files changed, 81 insertions(+), 27 deletions(-)

--
2.43.0


