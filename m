Return-Path: <linux-fsdevel+bounces-59668-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39495B3C5A6
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Aug 2025 01:39:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 090375A2484
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Aug 2025 23:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A75D279DDC;
	Fri, 29 Aug 2025 23:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CF8rSeNm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F902273F9
	for <linux-fsdevel@vger.kernel.org>; Fri, 29 Aug 2025 23:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756510791; cv=none; b=N9rRcDawZjQloPWcIvIZvz3XFVqgsW2mtmZ55DbA6Y+ydhQenXjfmqYSSKUvwnWZH+Mw7rG8dG90dzlEvpek4qSns7P9VmbHmZWvw7243HYs8qDlAsyd/YRzVtJ/lskPEvqoVBODTd3MKovbggmIuOPCYX+Xne47ctxOMeM57SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756510791; c=relaxed/simple;
	bh=auPVkDgooeDbdYTKSFHT+35MZqv6DWUz+parcLt6O5U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TtN2/JQWmU23Rgwr3HU3eEQF2anp11lj7vM7+2R4QF8mx8hWJ5wX2vvCohkBHrhTbAnc7teSFQiXkpzPlMaDSxLqHXSiKOyfTuBuS75B8ekv6xRUf3Yi6l6h++ZcbrkuHGYs2LkJzgVK52AGbJ24edExCHKybEC6cb0DRtFcpQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CF8rSeNm; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b4cb3367d87so1090407a12.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 Aug 2025 16:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756510789; x=1757115589; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=skuR78/JXGbuWZ2DLQBIUKa7ZpL0m7wYt5dK8i/gXNQ=;
        b=CF8rSeNmgtvvY75OLjU1t80hzGNzhM4aXJLXJBjyE9ZKi/usOcGrOHrxoQaSppwPl8
         Po6MOtJh22Yd4iXVxunpVTfLJGjnTOLvWztK7x5hhkWB6IkmtXQdXiqFTrMPuDuFWFaf
         oyLXgT1hIvmYdun5Rio/BIjmul+4iAMSl7cXp9A5cXOTQTnWekvlw/stX6BeSRMh/vHI
         7zbYkiLwREmEhmkrI72t18X2t56pPJKCjzfVZ6kwdfhDrXbwImFyPGFBvBEWJ7M6RZ8F
         8UDQnocGLPLXVoWUcTObJqoz1EJpsCPEcHVVFL2r9n6+W5U+QRsYrGjkIwMl79kEHqFH
         bLqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756510789; x=1757115589;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=skuR78/JXGbuWZ2DLQBIUKa7ZpL0m7wYt5dK8i/gXNQ=;
        b=jv3YVqY5uKvRyfCnzlenTjxS2c8VptKjwr556HVZTFTwq6W8/VSQLca9R8StV5cuBN
         rppEqdxLcPTGTFWCQmE7P/96bCVmF2T/KeQjBShq0J9c7e4uUwVUa/wIdvbXyEP/H8Nj
         nDGTMKQd6FYkPYXqgiloqvn3rzAuWhpmxHENhT7CTLhbDdCEZFkKpFmu6APuswOI+qvz
         ckOYxdVKsSbFXMu6L8KgBnr9ceXxwLg/xXK/g1wEPUCPBhB4OP4Uubfd1MxQkqvcruJw
         y4U/whU07nG2gFJfXhrI12sSxT/THPgs3GE05BXFrBteOFNPxRsSXlR+z1vLh8zHpyGT
         W4ng==
X-Forwarded-Encrypted: i=1; AJvYcCVn7h2owLk1eWTg5JAzYuRngcSXiWy0QwuhE4DWuXjUdrLrdPRLjWrPlqHKfEIIEOkofpTLr5BzmFcRjOK/@vger.kernel.org
X-Gm-Message-State: AOJu0YyVLwaRG7IwCvrAn9kci0SnawJ+0RDDrh0Xs2OfK7PXgDnyEV3R
	SlvdLAgu6pmSgudjU+4T5Xtqys+Ijpv5HUexCCvtuDoNM0IZi/MKT9iT
X-Gm-Gg: ASbGncu+Uk+5HVLswL8xo22ukKR8f1vDENGozETd+idA8nyKTxT3f2EqjQ4GzjHzq7m
	pzIkPD5/zg+c+ruZIt0RzF655W+4pcnobOwiu26/eH5XeCTf9r7g6tOWLcnCX7qJkVEJwIUy1Z7
	15FWqVWN48E06QZyRwOmDB2nJGdOjIueRuwThe8J65FBBU/8xBCK07Spiy4iKnx7FcGmFcWoPfp
	f3Scj+wCoGNmmG2KjbnlqdzaMmO1QDOoPnK2ziUYcypcl1eZ84WGjc3HgCNAQhfBX1WKDWVsLF1
	4dfPu/XEDxLeg1n2dSj+ViEVZfJG1L2VzvYSCaLT2J9kCqzIxbYdyfA1fggdqyJMU8QvcZbfEOV
	FKB7F1J9fXKWPP78UN/gEB4YEuNE2
X-Google-Smtp-Source: AGHT+IFD9Zx2sEc+TuW+3xEDSTMhu6/LlCaX3YjcY58K8HmxLokZECokImRcYxjOE6qu1jm7xDf7Tg==
X-Received: by 2002:a17:903:46c6:b0:246:fbeb:b66c with SMTP id d9443c01a7336-249448df282mr4463175ad.19.1756510789186;
        Fri, 29 Aug 2025 16:39:49 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:1b::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24905da1884sm35944825ad.95.2025.08.29.16.39.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 16:39:48 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: linux-mm@kvack.org,
	brauner@kernel.org
Cc: willy@infradead.org,
	jack@suse.cz,
	hch@infradead.org,
	djwong@kernel.org,
	jlayton@kernel.org,
	linux-fsdevel@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH v2 00/12] mm/iomap: add granular dirty and writeback accounting
Date: Fri, 29 Aug 2025 16:39:30 -0700
Message-ID: <20250829233942.3607248-1-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset adds granular dirty and writeback stats accounting for large
folios.

The dirty page balancing logic uses these stats to determine things like
whether the ratelimit has been exceeded, the frequency with which pages need
to be written back, if dirtying should be throttled, etc. Currently for large
folios, if any byte in the folio is dirtied or written back, all the bytes in
the folio are accounted as such.

In particular, there are four places where dirty and writeback stats get
incremented and decremented as pages get dirtied and written back:
a) folio dirtying (filemap_dirty_folio() -> ... -> folio_account_dirtied())
   - increments NR_FILE_DIRTY, NR_ZONE_WRITE_PENDING, WB_RECLAIMABLE,
     current->nr_dirtied

b) writing back a mapping (writeback_iter() -> ... ->
folio_clear_dirty_for_io())
   - decrements NR_FILE_DIRTY, NR_ZONE_WRITE_PENDING, WB_RECLAIMABLE

c) starting writeback on a folio (folio_start_writeback())
   - increments WB_WRITEBACK, NR_WRITEBACK, NR_ZONE_WRITE_PENDING

d) ending writeback on a folio (folio_end_writeback())
   - decrements WB_WRITEBACK, NR_WRITEBACK, NR_ZONE_WRITE_PENDING

Patches 1 to 9 adds support for the 4 cases above to take in the number of
pages to be accounted, instead of accounting for the entire folio.

Patch 12 adds the iomap changes that uses these new APIs. This relies on the
iomap folio state bitmap to track which pages are dirty (so that we avoid
any double-counting). As such we can only do granular accounting if the
block size >= PAGE_SIZE.

This patchset was run through xfstests using fuse passthrough hp (with an
out-of-tree kernel patch enabling fuse large folios).

This is on top of commit 4f702205 ("Merge branch 'vfs-6.18.rust' into
vfs.all") in Christian's vfs tree, and on top of the patchset that removes
BDI_CAP_WRITEBACK_ACCT [1].

Local benchmarks were run on xfs by doing the following:

seting up xfs (per the xfstests readme):
# xfs_io -f -c "falloc 0 10g" test.img
# xfs_io -f -c "falloc 0 10g" scratch.img
# mkfs.xfs test.img
# losetup /dev/loop0 ./test.img
# losetup /dev/loop1 ./scratch.img
# mkdir -p /mnt/test && mount /dev/loop0 /mnt/test

# sudo sysctl -w vm.dirty_bytes=$((3276 * 1024 * 1024)) # roughly 20% of 16GB
# sudo sysctl -w vm.dirty_background_bytes=$((1638*1024*1024)) # roughly 10% of 16GB

running this test program (ai-generated) [2] which essentially writes out 2 GB
of data 256 MB at a time and then spins up 15 threads to do 50-byte 50k
writes.

On my VM, I saw the writes take around 3 seconds (with some variability of
taking 0.3 seconds to 5 seconds sometimes) in the base version vs taking
a pretty consistent 0.14 seconds with this patchset. It'd be much appreciated
if someone could also run it on their local system to verify they see similar
numbers.

Thanks,
Joanne

[1] https://lore.kernel.org/linux-fsdevel/20250707234606.2300149-1-joannelkoong@gmail.com/
[2] https://pastebin.com/CbcwTXjq

Changelog
v1: https://lore.kernel.org/linux-fsdevel/20250801002131.255068-1-joannelkoong@gmail.com/
v1 -> v2:
* Add documentation specifying caller expectations for the
  filemap_dirty_folio_pages() -> __folio_mark_dirty() callpath (Jan)
* Add requested iomap bitmap iteration refactoring (Christoph)
* Fix long lines (Christoph)

Joanne Koong (12):
  mm: pass number of pages to __folio_start_writeback()
  mm: pass number of pages to __folio_end_writeback()
  mm: add folio_end_writeback_pages() helper
  mm: pass number of pages dirtied to __folio_mark_dirty()
  mm: add filemap_dirty_folio_pages() helper
  mm: add __folio_clear_dirty_for_io() helper
  mm: add no_stats_accounting bitfield to wbc
  mm: refactor clearing dirty stats into helper function
  mm: add clear_dirty_for_io_stats() helper
  iomap: refactor dirty bitmap iteration
  iomap: refactor uptodate bitmap iteration
  iomap: add granular dirty and writeback accounting

 fs/btrfs/subpage.c         |   2 +-
 fs/buffer.c                |   6 +-
 fs/ext4/page-io.c          |   2 +-
 fs/iomap/buffered-io.c     | 281 ++++++++++++++++++++++++++++++-------
 include/linux/page-flags.h |   4 +-
 include/linux/pagemap.h    |   4 +-
 include/linux/writeback.h  |  10 ++
 mm/filemap.c               |  12 +-
 mm/internal.h              |   2 +-
 mm/page-writeback.c        | 115 +++++++++++----
 10 files changed, 346 insertions(+), 92 deletions(-)

-- 
2.47.3


