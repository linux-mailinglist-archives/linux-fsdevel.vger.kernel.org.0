Return-Path: <linux-fsdevel+bounces-18478-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B8038B96B5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 May 2024 10:47:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7084AB2361B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 May 2024 08:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92C3D47796;
	Thu,  2 May 2024 08:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HMWhgLtf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7478746525;
	Thu,  2 May 2024 08:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714639634; cv=none; b=Tily5w4F1YuO9CAObAqyqF2x0+OlqLQiXdXiHa9Gy+NvGBG9K9vx0HJ0XAP5Defk5m1wI7XuLFMqSBgLErTcgBO4VD/feH8u88lpEGa9W1/YBT5bw0kTZKHpaMEW94jdOT37stlgwGefF8C5vBW1gSq70L1vw+qLHzTWyy0Ae5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714639634; c=relaxed/simple;
	bh=3sTPmgx4W7AZzexyTr50l/UxbwoEOpqp0xCvF5vUHHQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X+070f/lCgFu4Y+wUJ2eG01svrXmFOOwoId5dnV7ceo037EZPkKaA5rrVk6l7QtbBYSyFEJAS6tgwbXEzKlLKvBIHoOuTdF+Pdq/eKJpw5DCFw5GpyW4fcSRiI42y1BewyB+wue/Eb+NbGKY9ffVYyblFrZheKLfWbb/AZBjq0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HMWhgLtf; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2b2769f017aso2132831a91.3;
        Thu, 02 May 2024 01:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714639632; x=1715244432; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LWdLBLyeR7BpcKeZJgQvc8OrnwHoHMLWxQxGBtyncTQ=;
        b=HMWhgLtfPKSZ65hnNbhVXmWz660W3riWlc+eQY9xnIVVqm6kbcdk7U3RhOGe6b3QkV
         P18hSIXJyDYApUeQB+SqVzalr61kxWOpc0prVhZKDbt8qwHHr9lCRQpfBEoh/ADY5S2J
         kE1t5SI8AKYmC5D4OERsBMUydIoO1QPcbqSCVNWAhwDNqFqtY+ZAdnZQMUCFd4ZwvdTV
         XqnR52YbAjH41NAP6Kx9Gf+Z9bqtgAcoZM8BeyeJj8GuvHATSvXfXxICgjnltku+WREv
         +Pg4wfZq6PeQI33/oJIVsqVuFs9gv1DSzNHhTZ2YtNSQLayDQ5Tgo7vkaxgaHIF9jaLy
         mekg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714639632; x=1715244432;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LWdLBLyeR7BpcKeZJgQvc8OrnwHoHMLWxQxGBtyncTQ=;
        b=I5306+BrS7wTg8pHORKAWD9WhnTA2ymX9hzXKr3ejAcfW1QzcWXmM+mFfx4RU2rjZB
         jaIEl9WhaqQOMC7IOba7Q20GkHXhOyhjPwrg4J6Ri2ZrvY6iJRVsZZ3BWiRCO+q8Y8wZ
         iSA78vAhSZQsQD80aNAqSo0yiWb+M7wlNtbxCVLuqUXqxLsbuRsYk4eLRzhFbQIvWQ9i
         5Lnr5fq4dQKsqjQ+tbGZuMsksc98HZHkXRqtjvfkxstm2ubHvg/u4RFb8HL2DgG7M0Dd
         byMFPRMGJvzy+GsNyjYpPRlhURlWRP7+S+NqsaOaPQ/R/odNsPTGmNwlGr16vl/ljk/Q
         7kRw==
X-Forwarded-Encrypted: i=1; AJvYcCV+9BQrlcvo6Ev/HGD41zu2XXV2DADzpPrMv+VWPB1UcTZA5ekzSfFizliL2H3vD9mAyRtFQ1zXwEbcgbw/ReUH6aWvTXgXiibOAMCvWdbaAi5fOGRL2ucVf+PQmJbBTGLUGrT/m7n1K6C2MQ==
X-Gm-Message-State: AOJu0Ywul0aasrjtkxtQONOMc/dBvXEDkjvEvLri5pY6yxF4HZfpKlAt
	vxUdwaRonc3Zw9Ya7ppENVZH9/mIQwagK2v/t6snGVbtBDfYJqs6
X-Google-Smtp-Source: AGHT+IFtKsJRH6OiF0P/uD6YlY9pfpdm1JsnbPhf33Xaudz0kvodsgb5+b42uaKLuWeonDir1lsm1Q==
X-Received: by 2002:a17:90a:7143:b0:2b1:dd0e:e20 with SMTP id g3-20020a17090a714300b002b1dd0e0e20mr5360765pjs.38.1714639631511;
        Thu, 02 May 2024 01:47:11 -0700 (PDT)
Received: from KASONG-MB2.tencent.com ([1.203.116.31])
        by smtp.gmail.com with ESMTPSA id q6-20020a17090a938600b002b273cbbdf1sm686805pjo.49.2024.05.02.01.47.07
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 02 May 2024 01:47:11 -0700 (PDT)
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
Subject: [PATCH v4 00/12] mm/swap: clean up and optimize swap cache index
Date: Thu,  2 May 2024 16:45:57 +0800
Message-ID: <20240502084609.28376-1-ryncsn@gmail.com>
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

This is based on latest mm-unstable. Patch 1/12 is not needed if
f2fs converted .readahead to use folio, I included it for easier test
and review.

Currently we use one swap_address_space for every 64M chunk to reduce lock
contention, this is like having a set of smaller files inside a
swap device. But when doing swap cache look up or insert, we are
still using the offset of the whole large swap device. This is OK for
correctness, as the offset (key) is unique.

But Xarray is specially optimized for small indexes, it creates the
redix tree levels lazily to be just enough to fit the largest key
stored in one Xarray. So we are wasting tree nodes unnecessarily.

For 64M chunk it should only take at most 3 level to contain everything.
But if we are using the offset from the whole swap device, the offset (key)
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

To keep the code clean and compatible, this series first cleaned up
usage of them.

page_file_offset and folio_file_pos are historical helpes that can
be simply dropped after clean up. And page_index can be all converted to
folio_index or folio->index.

Then introduce two new helpers swap_cache_index and swap_dev_pos
for swap. Replace swp_offset with swap_cache_index when used to
retrieve folio from swap cache, and use swap_dev_pos when needed
to retrieve the device position of a swap entry. This way,
swap_cache_index can return the optimized value with no compatibility
issue.

The result is better performance and reduced LOC.

Idealy, in the future, we may want to reduce SWAP_ADDRESS_SPACE_SHIFT
from 14 to 12: Default Xarray chunk offset is 6, so we have 3 level
trees instead of 2 level trees just for 2 extra bits. But swap cache
is based on address_space struct, with 4 times more metadata sparsely
distributed in memory it waste more cacheline, the performance gain
from this series is almost canceled according to my test. So first,
just have a cleaner seperation of offsets and smaller search space.

Patch 1/12 - 11/12: Clean up usage of above helpers.
Patch 12/12: Apply the optmization.

V3: https://lore.kernel.org/all/20240429190500.30979-1-ryncsn@gmail.com/
Update from V3:
- Help remove a redundant loop in nilfs2 [Matthew Wilcox]
- Update commit message, use the term swap device instead of swap file
  to avoid confusion [Huang, Ying]
- Add more details in commit message about folio_file_pos usage in NFS.
- Fix a shadow leak in clear_shadow_from_swap_cache.

V2: https://lore.kernel.org/linux-mm/20240423170339.54131-1-ryncsn@gmail.com/
Update from V2:
- Clean up usage of page_file_offset and folio_file_pos [Matthew Wilcox]
  https://lore.kernel.org/linux-mm/ZiiFHTwgu8FGio1k@casper.infradead.org/
- Use folio in nilfs_bmap_data_get_key [Ryusuke Konishi]

V1: https://lore.kernel.org/all/20240417160842.76665-1-ryncsn@gmail.com/
Update from V1:
- Convert more users to use folio directly when possible [Matthew Wilcox]
- Rename swap_file_pos to swap_dev_pos [Huang, Ying]
- Update comments and commit message.
- Adjust headers and add dummy function to fix build error.

This series is part of effort to reduce swap cache overhead, and ultimately
remove SWP_SYNCHRONOUS_IO and unify swap cache usage as proposed before:
https://lore.kernel.org/lkml/20240326185032.72159-1-ryncsn@gmail.com/

Kairui Song (12):
  f2fs: drop usage of page_index
  nilfs2: drop usage of page_index
  ceph: drop usage of page_index
  NFS: remove nfs_page_lengthg and usage of page_index
  cifs: drop usage of page_file_offset
  afs: drop usage of folio_file_pos
  netfs: drop usage of folio_file_pos
  nfs: drop usage of folio_file_pos
  mm/swap: get the swap device offset directly
  mm: remove page_file_offset and folio_file_pos
  mm: drop page_index and convert folio_index to use folio
  mm/swap: reduce swap cache search space

 fs/afs/dir.c              |  6 +++---
 fs/afs/dir_edit.c         |  4 ++--
 fs/ceph/dir.c             |  2 +-
 fs/ceph/inode.c           |  2 +-
 fs/f2fs/data.c            |  2 +-
 fs/netfs/buffered_read.c  |  4 ++--
 fs/netfs/buffered_write.c |  2 +-
 fs/nfs/file.c             |  2 +-
 fs/nfs/internal.h         | 19 -------------------
 fs/nfs/nfstrace.h         |  4 ++--
 fs/nfs/write.c            |  6 +++---
 fs/nilfs2/bmap.c          | 10 ++--------
 fs/smb/client/file.c      |  2 +-
 include/linux/mm.h        | 13 -------------
 include/linux/pagemap.h   | 25 ++++---------------------
 mm/huge_memory.c          |  2 +-
 mm/memcontrol.c           |  2 +-
 mm/mincore.c              |  2 +-
 mm/page_io.c              |  6 +++---
 mm/shmem.c                |  2 +-
 mm/swap.h                 | 24 ++++++++++++++++++++++++
 mm/swap_state.c           | 19 ++++++++++---------
 mm/swapfile.c             | 11 +++++------
 23 files changed, 70 insertions(+), 101 deletions(-)

-- 
2.44.0


