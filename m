Return-Path: <linux-fsdevel+bounces-51000-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10C35AD1A7E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 11:27:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 09D8A7A1723
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 09:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01C0C24EF8B;
	Mon,  9 Jun 2025 09:27:43 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4A441714B4;
	Mon,  9 Jun 2025 09:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749461262; cv=none; b=irXfs7Dssa8GSojAdTc26Qdcg+vFCjghQ7XqwhtxKngqz6yoFPMTkLyoz0Onp3cmHoWSdRemRonhOVQWcGgdfI1LpSlqMwwQLfQhfUEQJthLKQfN+ONm3LGUKBSS1a3hfzzHVm2f/g3L135Kc4wUDaFuIrXAhXM1pw4zaAnUPjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749461262; c=relaxed/simple;
	bh=FbCqGODVvu4r/5l7d0r8uXlvg1v7OGT+a8bpdFZJvi0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TfILPfSOAog7TG5wYjstPDXbwdDow8ZOw6EvJD1GNOqQzjlyQ8+DTnzEi2ui3CShrKvxEBPMBg6WOBRTmnRJPyTN5V4lBPpFfcZCtSk+mpm9C/ugBiYpvAtxUgEKQNsPzjZsmmZadmOyi6DZjlwbwJTyxznVMlhInnNNoXgaSIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ACCF1150C;
	Mon,  9 Jun 2025 02:27:20 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 490FA3F59E;
	Mon,  9 Jun 2025 02:27:37 -0700 (PDT)
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
Subject: [PATCH v5 0/5] Readahead tweaks for larger folios
Date: Mon,  9 Jun 2025 10:27:22 +0100
Message-ID: <20250609092729.274960-1-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi All,

This series adds some tweaks to readahead so that it does a better job of
ramping up folio sizes as readahead extends further into the file. And it
additionally special-cases executable mappings to allow the arch to request a
preferred folio size for text.

Originally the series focussed on the latter part only (large folios for text).
See [3]. But after discussion with Matthew Wilcox, v4 switched to additionally
fix some of the unintended behaviours in how a folio size is selected in general
before special-casing for text. As a result patches 1-4 make folio size
selection behave more sanely, then patch 5 introduces large folios for text.
Patch 5 depends on patch 1, but does not depend on patches 2-4.

---

I've run a number of benchmarks and observed no regressions. mm selftests also
shows no regressions vs mm-unstable. Selected benchmark results are presented in
the commit log for the final patch.

Most patches have R-b/A-b now so would be good to get into linux-next for some
soak testing when possible.

Applies on top of today's mm-unstable (a32230de8810).

Changes since v4 [4]
====================

- Added R-b/A-b (thanks all!)
- Patch 1:
  - Removed ra->size fallback check in page_cache_ra_order() (Pankaj)
- Patch 2:
  - Modify ra end alignment to handle non-power-of-2 optimal ra sizes (Jan)
- Patch 4:
  - Only reset order to 0 if fallback is due to not supporting large folios
    (Jan)
- Patch 5:
  - Ignore VM_RAND_READ for VM_EXEC mappings in favour of following the new
    VM_EXEC code path since code is always random (Will)

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
[4] https://lore.kernel.org/linux-mm/20250430145920.3748738-1-ryan.roberts@arm.com/

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
 include/linux/pgtable.h          | 11 ++++++
 mm/filemap.c                     | 62 ++++++++++++++++++++++++--------
 mm/internal.h                    |  3 +-
 mm/readahead.c                   | 36 ++++++++++---------
 6 files changed, 89 insertions(+), 35 deletions(-)

--
2.43.0


