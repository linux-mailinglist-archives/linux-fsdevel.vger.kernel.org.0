Return-Path: <linux-fsdevel+bounces-70927-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A57BCA9F64
	for <lists+linux-fsdevel@lfdr.de>; Sat, 06 Dec 2025 04:10:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0F68B31C0E31
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Dec 2025 03:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59E87299A8A;
	Sat,  6 Dec 2025 03:09:18 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C538729AAFA;
	Sat,  6 Dec 2025 03:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764990557; cv=none; b=eUgl0qHsN82vr1HbovcImbyvxptCzL0bXE9fge9py3C1PMlphOK1oAakXmYWAcYbMiclhbQVnozHF7FuZXfaXVAdk3orH/yenMJID6TpzzqnxsJhm63xFwK5HIoDqLTmOrydxIjdRRMgRpohs570H0EfwCdhIXtTeHuQFwIJp8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764990557; c=relaxed/simple;
	bh=iRolAIdku1N7fcwxmaqWbLxeHtA1Jil8DbkAh4Wkl8c=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=mzXrSjEUTrFuXCSh4UFZwH+Y+cv3/Svq2PZoi3IpEvYCx1jQByJgrMojG6GWyNL/rrjgSUPS9/seH7HKa3FzaLAQDgu5vatxCcsnWcDQvBH1eEQLYMaWTA6h7VE8VsWONnzGEEZn9kdWxFeDIyK6UXpZtAFj8b0F9vvo7e1vC1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=pankajraghav.com; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4dNY9s6173z9ttb;
	Sat,  6 Dec 2025 04:09:05 +0100 (CET)
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of kernel@pankajraghav.com designates 2001:67c:2050:b231:465::1 as permitted sender) smtp.mailfrom=kernel@pankajraghav.com
From: Pankaj Raghav <p.raghav@samsung.com>
To: Suren Baghdasaryan <surenb@google.com>,
	Mike Rapoport <rppt@kernel.org>,
	David Hildenbrand <david@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Michal Hocko <mhocko@suse.com>,
	Lance Yang <lance.yang@linux.dev>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Dev Jain <dev.jain@arm.com>,
	Barry Song <baohua@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Nico Pache <npache@redhat.com>,
	Zi Yan <ziy@nvidia.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	mcgrof@kernel.org,
	gost.dev@samsung.com,
	kernel@pankajraghav.com,
	tytso@mit.edu,
	Pankaj Raghav <p.raghav@samsung.com>
Subject: [RFC v2 0/3] Decoupling large folios dependency on THP
Date: Sat,  6 Dec 2025 04:08:55 +0100
Message-ID: <20251206030858.1418814-1-p.raghav@samsung.com>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4dNY9s6173z9ttb

File-backed Large folios were initially implemented with dependencies on Transparent
Huge Pages (THP) infrastructure. As large folio adoption expanded across
the kernel, CONFIG_TRANSPARENT_HUGEPAGE has become an overloaded
configuration option, sometimes used as a proxy for large folio support
[1][2][3].

This series is a part of the LPC talk[4], and I am sending the RFC
series to start the discussion.

There are multiple solutions to solve this problem and this is one of
them with minimal changes. I plan on discussing possible other solutions
at the talk.

Based on my investigation, the only feature large folios depend on is
the THP splitting infrastructure. Either during truncation or memory
pressure when the large folio has to be split, then THP's splitting
infrastructure is used to split them into min order folio chunks.

In this approach, we restrict the maximum order of the large folio to
minimum order to ensure we never use the splitting infrastructure when
THP is disabled.

I disabled THP, and ran xfstests on XFS with 16k, 32k and 64k blocksizes
and the changes seems to survive the test without any issues.

Looking forward to some productive discussion.

P.S: Thanks to Zi, David and willy for all the ideas they provided to
solve this problem.

[1] https://lore.kernel.org/linux-mm/731d8b44-1a45-40bc-a274-8f39a7ae0f7f@lucifer.local/
[2] https://lore.kernel.org/all/aGfNKGBz9lhuK1AF@casper.infradead.org/
[3] https://lore.kernel.org/linux-ext4/20251110043226.GD2988753@mit.edu/
[4] https://lpc.events/event/19/contributions/2139/

Pankaj Raghav (3):
  filemap: set max order to be min order if THP is disabled
  huge_memory: skip warning if min order and folio order are same in
    split
  blkdev: remove CONFIG_TRANSPARENT_HUGEPAGES dependency for LBS devices

 include/linux/blkdev.h  |  5 -----
 include/linux/huge_mm.h | 40 ++++++++--------------------------------
 include/linux/pagemap.h | 17 ++++++-----------
 mm/memory.c             | 41 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 55 insertions(+), 48 deletions(-)


base-commit: e4c4d9892021888be6d874ec1be307e80382f431
-- 
2.50.1


