Return-Path: <linux-fsdevel+bounces-46147-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FD81A83607
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Apr 2025 03:51:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9B71465790
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Apr 2025 01:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EA171D86F7;
	Thu, 10 Apr 2025 01:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BEiQySXq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE1870800;
	Thu, 10 Apr 2025 01:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744249792; cv=none; b=Ih+Xsrb5l38kOJQIc8CHOZ+kJ2ZIv82hlFVU4z0/ZdlJrz91u4PoYleTmqkWD1qINJXL1oRpEQLYi8BH+oyE23a1WCatNLIPTEguR157ykSU49BJX5EwBptQ6m7TAIQFdmOOn7zTKitOryjDZ+SMdOo+LeokxSMQUbuJL5TTL6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744249792; c=relaxed/simple;
	bh=gw/NjgWGVSFxab3pAtL6yGS+ccJXroE2E8QVY6YYcos=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TIbwSpY+wEUkvrElGTxDnDgOkRLcMjtq/2Z2QRwJnJAsyOIhYsHiSbX/WTqm69eihAVtZPSfgX6+KOCclX+Al2uPu35g0XgvcNEcxEUO2u/6qSr3uCBVZsNfFEb0JCLzfOoBi+T3hrCWGwzs9p4ukXZ0O5hcbcgpAMWTpq4tUPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=BEiQySXq; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=gU4nDpIOjE/XR68cUwv2i9fTg/9lnNMroLjPUVzoIeM=; b=BEiQySXqoICUoSgnimnicVM34v
	G/9L/jlt7ClGdnWdjQywPjgPn9xqcGZNhYD/gjEUPnDKJ3EWA3G0NrG0wIE1fbciULTGo3m5INWPb
	hSzepYVfLVe6Xji0iODjmGEaYx9t/3aWZzU6c4+k3BJhTMHOsKEpZIk4MUBMt5Y993DeZvp6xa/6G
	VeYnv8slJhT9bEJa2ndSwJp9hOOygH6exj6zE7oFijhMSMhUBgz5BqlbTnWvH5DifiVNkGxV2ADUj
	zgqnDXpB8tEGjWcB9GFIaviGeIArGZtvLng5svJKbrgP3uU3STjImRi1VRGyiNFiAHe818MzXDcYt
	Fug5RhCg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2h35-00000008yv0-37Or;
	Thu, 10 Apr 2025 01:49:47 +0000
From: Luis Chamberlain <mcgrof@kernel.org>
To: brauner@kernel.org,
	jack@suse.cz,
	tytso@mit.edu,
	adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org,
	riel@surriel.com
Cc: dave@stgolabs.net,
	willy@infradead.org,
	hannes@cmpxchg.org,
	oliver.sang@intel.com,
	david@redhat.com,
	axboe@kernel.dk,
	hare@suse.de,
	david@fromorbit.com,
	djwong@kernel.org,
	ritesh.list@gmail.com,
	linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-mm@kvack.org,
	gost.dev@samsung.com,
	p.raghav@samsung.com,
	da.gomez@samsung.com,
	mcgrof@kernel.org
Subject: [PATCH v2 0/8] mm: enhance migration work around on noref buffer-heads
Date: Wed,  9 Apr 2025 18:49:37 -0700
Message-ID: <20250410014945.2140781-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>

We have an eye-sore of a spin lock held during page migration which
was added for a ext4 jbd corruption fix for which we have no clear
public corruption data. We want to remove the spin lock on mm/migrate
so to help buffer-head filesystems embrace large folios, since we
can cond_resched() on large folios on folio_mc_copy(). We've managed
to reproduce a corruption by just removing the spinlock and stressing
ext4 with generic/750, a corruption happens after 3 hours many times.
However, while developing an alternative fix based on feedback [0], we've
come the conclusion ext4 on vanilla Linux is still affected. We still have
a lingering jbd2 corruption issue.

The underlying race is in jbd2’s use of buffer_migrate_folio_norefs() without
holding doing proper synchronization, making it unsafe during folio migration.
ext4 uses jbd2 as its journaling backend. The corruption surfaces in ext4's
metadata operations, like ext4_ext_insert_extent(), when journal metadata fails
to be marked dirty due to the migration race. This leads to ENOSPC, journal
aborts, read-only fallback, and long-term filesystem corruption seen in replay
logs and "error count since last fsck".

This simply skips folio migration on jbd2 metadata buffers to avoid races during
journal writes that can lead to filesystem corruption, but also paves the way
to enable jbd2 to eventually overcome this limitation and enable folio
migration, while also implementing some of the suggested enhancements on
__find_get_block_slow(). The suggested trylock idea is implemented, thereby
potentially reducing i_private_lock contention and leveraging folio_trylock()
when allowed.

The first patch is intended to go through Linus' tree, if agreeable, and then
the rest can be evaluated for fs-next. Although I did not intend to upstream
the debugfs interface, at this point I'm convinced the statistics are extremely
useful while enhacing this path, and should also prove useful in enhacing and
eventually enabling folio migration on jbd2 metadata buffers.

If you want this in tree form, see 20250409-bh-meta-migrate-optimal [1].

[0] https://lore.kernel.org/all/20250330064732.3781046-3-mcgrof@kernel.org/T/#mf2fb79c9ab0d20fab65c65142b7f53680e68d8fa
[1] https://web.git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/log/?h=20250409-bh-meta-migrate-optimal

Changes on v2:

 - replace heuristic with buffer_meta() check as we're convinced the issue
   with corruption stil exist and jbd2 metadata buffers still needs work
   to enable folio migration
 - implements community feedback and performance suggestions on code
   paving the way to eventually enable jbd2 metadata buffers to leverage
   folio migration
 - adds debugfs interface

Davidlohr Bueso (6):
  fs/buffer: try to use folio lock for pagecache lookups
  fs/buffer: introduce __find_get_block_nonatomic()
  fs/ocfs2: use sleeping version of __find_get_block()
  fs/jbd2: use sleeping version of __find_get_block()
  fs/ext4: use sleeping version of __find_get_block()
  mm/migrate: enable noref migration for jbd2

Luis Chamberlain (2):
  migrate: fix skipping metadata buffer heads on migration
  mm: add migration buffer-head debugfs interface

 fs/buffer.c                 |  76 ++++++++++----
 fs/ext4/ialloc.c            |   3 +-
 fs/ext4/inode.c             |   2 +
 fs/ext4/mballoc.c           |   3 +-
 fs/jbd2/revoke.c            |  15 +--
 fs/ocfs2/journal.c          |   2 +-
 include/linux/buffer_head.h |   9 ++
 mm/migrate.c                | 192 ++++++++++++++++++++++++++++++++++--
 8 files changed, 266 insertions(+), 36 deletions(-)

-- 
2.47.2


