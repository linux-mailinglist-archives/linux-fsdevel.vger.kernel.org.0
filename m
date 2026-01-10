Return-Path: <linux-fsdevel+bounces-73105-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C5E8D0CE3E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Jan 2026 04:57:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 019D7302D2D8
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Jan 2026 03:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60A0D263F5E;
	Sat, 10 Jan 2026 03:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="claGbCex";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="claGbCex"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82AF5269B1C
	for <linux-fsdevel@vger.kernel.org>; Sat, 10 Jan 2026 03:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768017404; cv=none; b=mOBwaRSEwFP2JHD3uiYOXpdfgTLPnpdWqNaZZkZIwZq28KqfxBg/SMUuf2/wSf5+uK1Sf0n6sCN+KwFx6uNYV/RVX/st8gCFgHlS/JSnkQip/ziIrAsvMnKNxI2HHLJtrfGyTd0wOAQaJr01O0uo3oaYzGMfWdwnYFxZy0tfmF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768017404; c=relaxed/simple;
	bh=IQvStG2PsdToqyLEFN2fOfYu6g8XgTDzu7e02DwzHnw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Or8+ev1n63/pTdHB4xlM1hm0hCbKi/48dUwGwFsFGi3rFmBLmfO4IUs4RAUo53yPQhW1cmAm8Mb91lfO9LxYG/JqAP89hngMJexrwzppOI64KF2FgZiZkmrGS2NrpddB6c6Ye19wvvBHGizmHrf8gcWPFqE4mwYwrNMRQ9H121Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=claGbCex; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=claGbCex; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id CAE9E5BCE4;
	Sat, 10 Jan 2026 03:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1768017400; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=BkKRg0H2aQvVi5KZeNt/pJBKRmCQD8wH3dhNnd5HYJ8=;
	b=claGbCex7LJ9d9+an3htNbiT6gXsmhHjYlZ5aBITBWUazgerz1O0sgnEBo4punTP4MGjnB
	Uz1/cJyXG0MWYE8WzR/AFFZiJsMGq3Jn9CGWJImFgCfFuiq42uw9sCY5MMfA+Tq98fHp1A
	zXVrGTPRaQrKRa/bcqDjlhu5jK7+zw4=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1768017400; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=BkKRg0H2aQvVi5KZeNt/pJBKRmCQD8wH3dhNnd5HYJ8=;
	b=claGbCex7LJ9d9+an3htNbiT6gXsmhHjYlZ5aBITBWUazgerz1O0sgnEBo4punTP4MGjnB
	Uz1/cJyXG0MWYE8WzR/AFFZiJsMGq3Jn9CGWJImFgCfFuiq42uw9sCY5MMfA+Tq98fHp1A
	zXVrGTPRaQrKRa/bcqDjlhu5jK7+zw4=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 534003EA63;
	Sat, 10 Jan 2026 03:56:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id f2fFBffNYWlqLgAAD6G6ig
	(envelope-from <wqu@suse.com>); Sat, 10 Jan 2026 03:56:39 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/3] btrfs: only use bdev's page cache for super block writeback
Date: Sat, 10 Jan 2026 14:26:18 +1030
Message-ID: <cover.1768017091.git.wqu@suse.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.993];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Level: 
X-Spam-Flag: NO

[CHANGELOG]
v3:
- Rebased to the latest for-next
  There is minor conflicts against the recent fix on
  read_cache_page_gfp().

- Still use the folio locked flag to track writeback
  There is a patch that reduced the size of btrfs_device to exactly 512
  bytes, adding new wait and atomic is not that worthy anymore

- Delete read_cache_page_gfp() function completely
  Btrfs is the last user of that function.

v2:
- Still use page cache for super block writes
  This is to ensure the user space won't see any half-backed super block
  caused by the race between bio writes and buffered read on the bdev.

  This is exposed by generic/492 which user space command blkid may
  fail to see the updated superblock.

  This also brings a slight imbalance, that our super block read is
  always uncached, but the superblock write is always cached.

RFC->v1:
- Make sb_write_pointer() use bdev_rw_virt()
  That is the missing location that still uses bdev's page cache, thanks
  Johannes for exposing this one.

- Replace btrfs_release_disk_super() with kfree()
  There is no need to keep that helper, and such replace will help us
  exposing locations which are still using the old page cache, like the
  above case.

- Only scratch the magic number of a super block in
  btrfs_scratch_superblock()
  To keep the behavior the same.

- Use GFP_NOFS when allocating memory
  This is also to keep the old behavior.

  Although I'd say btrfs_read_disk_super() call sites are safe, as they
  are either scanning a device, or at mount time, thus out of the write
  path and should be safe.

  The sb_write_pointer() one still needs the old GFP_NOFS flag as they
  can be called when writing the super block.

Btrfs has a long history using bdev's page cache for super block IOs.
It looks even weird in the older days that we manually setting different
page flags without going through the regular dirty -> lock -> writeback
-> clear writeback sequence.

Thankfully we're moving away from unnecessary bdev's page flag
modification, starting with commit bc00965dbff7 ("btrfs: count super
block write errors in device instead of tracking folio error state"),
we no longer relies on page cache to detect super block IO errors.

But we're still using the bdev's page cache for:

- Reading super blocks
  Reading a whole folio just to grab a 4KiB super block can be
  overkilled.
  And this is the easiest one to kill, just kmalloc() and bdev_rw_virt() will
  handle it well.

- Scratching super blocks
  We can use bdev_rw_virt() to write a super block with its magic
  zeroed.

  However we also need to invalidate the cache to ensure the user space
  won't see the out-of-date cached super block.

- Writing super blocks
  We're using the page cache of bdev, for a different purpose.
  We want to ensure the user space scanning tools like blkid seeing a
  consistent content.

  If we just go the bdev_rw_virt() path, the user space read can race
  with our bio write, resulting inconsistent contents.

  So here we still need to utilize the page cache of bdev, but with
  comments explaining why we need to.

However this brings one small change:

- Device scan is no longer cached
  For mount time it's totally fine, but every time a btrfs device is
  touched, we will submit a 4K sync read from the disk.
  The cost may not be that huge though.

Qu Wenruo (3):
  btrfs: use bdev_rw_virt() to read and scratch the disk super block
  btrfs: minor improvement on super block writeback
  mm/filemap: remove read_cache_page_gfp()

 fs/btrfs/disk-io.c      | 45 +++++++++++++++----------
 fs/btrfs/super.c        |  4 +--
 fs/btrfs/volumes.c      | 74 ++++++++++++++++-------------------------
 fs/btrfs/volumes.h      |  4 +--
 fs/btrfs/zoned.c        | 26 +++++++++------
 include/linux/pagemap.h |  2 --
 mm/filemap.c            | 23 -------------
 7 files changed, 74 insertions(+), 104 deletions(-)

-- 
2.52.0


