Return-Path: <linux-fsdevel+bounces-26543-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F374995A559
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 21:35:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98B8FB212A6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 19:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B92116EB76;
	Wed, 21 Aug 2024 19:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="e0VLw21b"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0448C16E895
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Aug 2024 19:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724268905; cv=none; b=FVFsgCYSTlGP6TVxH+FbWeqFim2gJ57BN7pzSjcqe6U91AyQrSxC2YfOTsLXb9Rc1GWUG80gAbJrpbIMxoGlhmiSEujqqXcNaHTL8fLO/e+wcC60/I04uN59BB+9hP7vC/ooh6JJjl4U/SYnW+tpBbUuzVaJy2UE+5sSw1CVuLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724268905; c=relaxed/simple;
	bh=+72WDjYNX9cPos/rpB+PIes9e8ZvZUw2CQVojN66x+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QmEIs5CLSt1pVdujlwRsjAczE9SpXC+W5av/ftG5D3yYv6N/G67yDdqDF6Sg5XkjcJhUpRNE6JfT2QCSKbCGAQGtOBX33GDjMHOnoLr+zpCzF6l3EiaNwv8TgZEYaLCkijbNjMxaecX7sXCFWYqLaOF+p6w5mUX+Wcx/tdvB8hQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=e0VLw21b; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=fQdVfSID3gT3nuSyoQZQPR5fYrlvzaJmI49x80wY/MA=; b=e0VLw21bRtxV7nSkGEew6klC54
	ZXY7nNRDHGmEp829UcDk6x4yDMSM6R82URilzqOQU8K8NeU99Sk99g2dDJ6bKdJX/wPfW1H7oxcSl
	EG12iv+tE9dY0L80k8kS1nwhg47OvMG6kvi3WGrtZjb+IJ20nbCJAyMPdq6bpag07S2JSucuH+BmO
	8O3DZP0UfqVRlS60ATvu0NsFE8Ebf+A4H1/x7CUe/ynW7V4tPLwd+BC+/1nRKzZI2lxaI3JtLo7LI
	+w+xhfwd6PsHsMXtZcpLK0Rrf5cn1GP7+1lWea9dog7JFZqfxdNKNkn8bmQi2z3Wnx9YPD/70ug0A
	J3zoIu5A==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sgr6U-00000009cqY-2qff;
	Wed, 21 Aug 2024 19:34:46 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	x86@kernel.org
Subject: [PATCH 00/10] Simplify the page flags a little
Date: Wed, 21 Aug 2024 20:34:33 +0100
Message-ID: <20240821193445.2294269-1-willy@infradead.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the course of our folio conversions, we have made many page flags
only used on folios, so we can now remove the page-based accessors.
This should cut down compile time a little, and prevent new users from
cropping up.

There is more that could be done in this area, but it would produce
merge conflicts, so I'll sit on those patches until next merge window.
We now have line of sight to removing PG_private_2 and PG_private.

Matthew Wilcox (Oracle) (10):
  mm: Remove PageActive
  mm: Remove PageSwapBacked
  mm: Remove PageReadahead
  mm: Remove PageSwapCache
  mm: Remove PageUnevictable
  mm: Remove PageMlocked
  mm: Remove PageOwnerPriv1
  mm: Remove page_has_private()
  mm: Rename PG_mappedtodisk to PG_owner_2
  x86: Remove PG_uncached

 .../features/vm/PG_uncached/arch-support.txt  | 30 ------
 Documentation/mm/unevictable-lru.rst          |  4 +-
 arch/arm64/Kconfig                            |  3 +-
 arch/x86/Kconfig                              |  5 +-
 arch/x86/mm/pat/memtype.c                     |  8 +-
 fs/proc/page.c                                | 10 +-
 include/linux/kernel-page-flags.h             |  3 +-
 include/linux/mm_types.h                      |  2 +-
 include/linux/page-flags.h                    | 99 +++++++++----------
 include/trace/events/mmflags.h                | 25 +++--
 mm/Kconfig                                    |  9 +-
 mm/huge_memory.c                              | 20 ++--
 mm/ksm.c                                      | 19 ++--
 mm/migrate.c                                  |  3 +-
 mm/shmem.c                                    | 11 ++-
 tools/mm/page-types.c                         | 13 ++-
 16 files changed, 111 insertions(+), 153 deletions(-)
 delete mode 100644 Documentation/features/vm/PG_uncached/arch-support.txt

-- 
2.43.0


