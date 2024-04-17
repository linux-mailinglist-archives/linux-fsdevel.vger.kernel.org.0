Return-Path: <linux-fsdevel+bounces-17159-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97E538A8876
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Apr 2024 18:09:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3E9FB23163
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Apr 2024 16:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61DF9148821;
	Wed, 17 Apr 2024 16:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xxu2qQ5U"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 762811411F7;
	Wed, 17 Apr 2024 16:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713370179; cv=none; b=poolMFrp+WOhuYJhF39mLBHSOQKkOmkbc2q5XzOS3awNfcavOPzHlvYxabDGYDlA9XzDkwZ/qD7vBOO+tC0vVmN8dMICpFR3tpNvd1WX1PCi1vQEBOhf6uTg2aMo8E7TR4eb35BS2qz3G0Mgr8raHIPuo9mjvM793/C3PQU3nA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713370179; c=relaxed/simple;
	bh=w3/SnSe5uK/nJpsn7vjld1sRMrv1akISSAPmLkSG3J4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=J/B5nDqQMuZEyPKBj35igYbwLISYbx6NMMkykTJLTpyP8EDumX74L2hDX8K3CWm+sc+bIyEQVhOzQJgfbAlmm7O8zvXkgMoafd6hR5afV1ka4RvEOVc7Iq3+oLDMdYvQNhxFT3TxjCWnANLpwk2f1sH8YDsTjWc4eKmGnjic7kE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xxu2qQ5U; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6ead4093f85so4894504b3a.3;
        Wed, 17 Apr 2024 09:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713370178; x=1713974978; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zpA6c5jeU6NWfuv45H8T/JHqLUyxgpH09COJKzBQsDY=;
        b=Xxu2qQ5UVdKvFKgW2e76POn2a/Yj0CHn1yiqR9Ne7JEX13TjXkrpKFmPZBO+MnPcBA
         MRLC3ZycOR6y2kP6bKIbpA90SeTNYZr3C1AYjk0ZsEdJ0Ed0YlgTg3vKKP1N2QvNR3WY
         CVLfdzt63PXKUZ81X2nqoO/tBVhI5F6g0C1O6M3Pf1PaiZYoHA6XryH/S4gJUKwUhexx
         t3D4WAeQEjehKyMuK8vzUMHi6pavCr4YdO9LSjXTF/m2ivNLQ14IFRGxCgThPrkvBIk3
         EWGGyQJKLfX7bo4rugbjcUUj7aI0iicC8OCc1Lt0sRkBmo68S6i337btJxwRpnR7rKLb
         E+Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713370178; x=1713974978;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zpA6c5jeU6NWfuv45H8T/JHqLUyxgpH09COJKzBQsDY=;
        b=EYwPMptqfwBYDXsRygqQ1h1V8seZEhAUbTfoG4ADJ83tH+N6tj7yXPNn1XQFjnAbzw
         hiI00iOb9Wc6EN+4gt93tivwXDqrQpiSmKLDHo4iH7GXA90YI2Y9pTU3Rm5pTZrSg10g
         gPdi/UEAekeh2gCsMFJKZ2wdcVfO4sz0SOdRK999HKSNq+ZslpX0RA31F1abnJ8u4zyp
         2oXkiPEhx+tzeJgwB501Kydi7ejYmGw+WPf59sSVeKT4aWzCtaECv5NN0tzq1Vgg2N60
         Tc/4UhUMnhSnu8rvePIZ7sx9H6/LBD3pEV+Mo1G50KO5TAtCVpP1miF/hGL0pK9Zhtym
         ePEw==
X-Forwarded-Encrypted: i=1; AJvYcCXSxmooV774vlNDg8VzIAlHlpu6LrXcS4f1RLZPuK14446pUCnMQMFzowKvo0F07eRSbl0/htrTwwlH7ItkrNQiLkVIh1KcMxerjV6GvJNL7VGSN34g2rWUZgZzViudAEhZ8UP5K/b/17T4PA==
X-Gm-Message-State: AOJu0YyK6vq6iIOVUMRAjT7j2GDvh8uJyRZpwrJ68EkK6aBnHuDikfMn
	FqN+MJNPUhavmQyGHeGBtllulcYysFVXkD6AC5ekC9iDXbftNFm4
X-Google-Smtp-Source: AGHT+IGNmib65LDOBKOQRrNTouAlXyuI/bpruHFp2PRNf9TheEZeVt7nbTrBBQsxbd1SqrXkYU8PaQ==
X-Received: by 2002:a05:6a20:8424:b0:1a7:78d2:a142 with SMTP id c36-20020a056a20842400b001a778d2a142mr66148pzd.38.1713370177453;
        Wed, 17 Apr 2024 09:09:37 -0700 (PDT)
Received: from KASONG-MB2.tencent.com ([115.171.40.106])
        by smtp.gmail.com with ESMTPSA id h189-20020a6383c6000000b005f75cf4db92sm5708366pge.82.2024.04.17.09.09.33
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 17 Apr 2024 09:09:37 -0700 (PDT)
From: Kairui Song <ryncsn@gmail.com>
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	"Huang, Ying" <ying.huang@intel.com>,
	Matthew Wilcox <willy@infradead.org>,
	Chris Li <chrisl@kernel.org>,
	Barry Song <v-songbaohua@oppo.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Neil Brown <neilb@suse.de>,
	Minchan Kim <minchan@kernel.org>,
	Hugh Dickins <hughd@google.com>,
	David Hildenbrand <david@redhat.com>,
	Yosry Ahmed <yosryahmed@google.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kairui Song <kasong@tencent.com>
Subject: [PATCH 0/8] mm/swap: optimize swap cache search space
Date: Thu, 18 Apr 2024 00:08:34 +0800
Message-ID: <20240417160842.76665-1-ryncsn@gmail.com>
X-Mailer: git-send-email 2.44.0
Reply-To: Kairui Song <kasong@tencent.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kairui Song <kasong@tencent.com>

Currently we use one swap_address_space for every 64M chunk to reduce lock
contention, this is like having a set of smaller swap files inside one
big swap file. But when doing swap cache look up or insert, we are
still using the offset of the whole large swap file. This is OK for
correctness, as the offset (key) is unique.

But Xarray is specially optimized for small indexes, it creates the
redix tree levels lazily to be just enough to fit the largest key
stored in one Xarray. So we are wasting tree nodes unnecessarily.

For 64M chunk it should only take at most 3 level to contain everything.
But we are using the offset from the whole swap file, so the offset (key)
value will be way beyond 64M, and so will the tree level.

Optimize this by reduce the swap cache search space into 64M scope.

Test with `time memhog 128G` inside a 8G memcg using 128G swap (ramdisk
with SWP_SYNCHRONOUS_IO dropped, tested 3 times, results are stable. The
test result is similar but the improvement is smaller if SWP_SYNCHRONOUS_IO
is enabled, as swap out path can never skip swap cache):

Before:
6.07user 250.74system 4:17.26elapsed 99%CPU (0avgtext+0avgdata 8373376maxresident)k
0inputs+0outputs (55major+33555018minor)pagefaults 0swaps

After (+1.8% faster):
6.08user 246.09system 4:12.58elapsed 99%CPU (0avgtext+0avgdata 8373248maxresident)k
0inputs+0outputs (54major+33555027minor)pagefaults 0swaps

Similar result with MySQL and sysbench using swap:
Before:
94055.61 qps

After (+0.8% faster):
94834.91 qps

There is alse a very slight drop of radix tree node slab usage:
Before: 303952K
After:  302224K

For this series:

There are multiple places that expect mixed type of pages (page cache or
swap cache), eg. migration, huge memory split; There are four helpers
for that:

- page_index
- page_file_offset
- folio_index
- folio_file_pos

So this series first cleaned up usage of page_index and
page_file_offset, then convert folio_index and folio_file_pos to be
compatible with separate offsets. And introduce a new helper
swap_cache_index for swap internal usage, replace swp_offset with
swap_cache_index when used to retrieve folio from swap cache.

And idealy, we may want to reduce SWAP_ADDRESS_SPACE_SHIFT from 14 to
12: Default Xarray chunk offset is 6, so we have 3 level trees instead
of 2 level trees just for 2 extra bits. But swap cache is based on
address_space struct, with 4 times more metadata sparsely distributed
in memory it waste more cacheline, the performance gain from this
series is almost canceled. So firstly, just have a cleaner seperation
of offsets.

Patch 1/8 - 6/8: Clean up usage of page_index and page_file_offset
Patch 7/8: Convert folio_index and folio_file_pos to be compatible with
  separate offset.
Patch 8/8: Introduce swap_cache_index and use it when doing lookup in
  swap cache.

This series is part of effort to reduce swap cache overhead, and ultimately
remove SWP_SYNCHRONOUS_IO and unify swap cache usage as proposed before:
https://lore.kernel.org/lkml/20240326185032.72159-1-ryncsn@gmail.com/

Kairui Song (8):
  NFS: remove nfs_page_lengthg and usage of page_index
  nilfs2: drop usage of page_index
  f2fs: drop usage of page_index
  ceph: drop usage of page_index
  cifs: drop usage of page_file_offset
  mm/swap: get the swap file offset directly
  mm: drop page_index/page_file_offset and convert swap helpers to use
    folio
  mm/swap: reduce swap cache search space

 fs/ceph/dir.c           |  2 +-
 fs/ceph/inode.c         |  2 +-
 fs/f2fs/data.c          |  5 ++---
 fs/nfs/internal.h       | 19 -------------------
 fs/nilfs2/bmap.c        |  3 +--
 fs/smb/client/file.c    |  2 +-
 include/linux/mm.h      | 13 -------------
 include/linux/pagemap.h | 19 +++++++++----------
 mm/huge_memory.c        |  2 +-
 mm/memcontrol.c         |  2 +-
 mm/mincore.c            |  2 +-
 mm/page_io.c            |  6 +++---
 mm/shmem.c              |  2 +-
 mm/swap.h               | 12 ++++++++++++
 mm/swap_state.c         | 12 ++++++------
 mm/swapfile.c           | 17 +++++++++++------
 16 files changed, 51 insertions(+), 69 deletions(-)

-- 
2.44.0


