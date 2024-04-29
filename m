Return-Path: <linux-fsdevel+bounces-18165-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F9938B6195
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 21:06:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 676AC28117F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 19:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D320213AD11;
	Mon, 29 Apr 2024 19:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nynp0wHY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E18761E529;
	Mon, 29 Apr 2024 19:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714417609; cv=none; b=OInWpQFk1MhG+aNS6dquosucoIFlVg1ShSc7cbf/fmY60OPaDxhmWCy2Rw+1eroASUWUxJafhyDTqOjivVpZFX32MHZrZbT51ICg9EmEe7wnh9ykFzkRyeexpVPKN2YKybnlLt+w5itUYTXb0dmZzkIPV40NQPi9qS1eC28lqYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714417609; c=relaxed/simple;
	bh=FTA6y0sDgWHcTyfXOGHuOxkWFUXIR46mFGcx5V3uwz8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=noQVPp+pZ+rOJ8UVaIjTTO1g0JkqM+sVNNjJkmZYvLWatHwAN1pwk3J4oLEDvLh3amOG3NFapX+k0cEXTdlxlpAxfzj0/+ZnKo1VRF1B/I29cypSH6XdqJKWKYqo+PAScaQCCgKt3dotL2pMbjfD8QTj14xxcuX9W7Yu4ggEFvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nynp0wHY; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1e36b7e7dd2so39749345ad.1;
        Mon, 29 Apr 2024 12:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714417607; x=1715022407; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ja/heJXLrjQvSsIFYz+/qDLl0VJBPXaNzgR3hX76y+s=;
        b=Nynp0wHYpy1kQpvGlHllm89XNKCOZHsMP9Ts/aqJYg/mN0/x9PH998gf+HbOzfC5eo
         rSXBYSwPeMB/fSQvmK7iPR9jRnchVYkhmV62QfjGpOk+tVtj+BSaHbN4pM1aD9unfeoj
         wZvJwsIApVLV9qNGAPXdMjKbyD5luzARAMtI/sdl5APrKd7uO9WOmFdnOkALd7kq8ir5
         ySSb08pX7mPZ8Y9TXnxcwvcchvVHUEn88hsKvksEpORaKibxDyBiHvOC5IO8v6UocPuc
         AUEFgsTric0bjS6E9JI55oOswJxVgbaZLuLGJdNfwq0IZ669iW7l5i2LDjoJaER8KUyS
         40xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714417607; x=1715022407;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ja/heJXLrjQvSsIFYz+/qDLl0VJBPXaNzgR3hX76y+s=;
        b=MKr5hvCPXOPVTQppl3iCI4LJiwVtbfus5W+cs8zChpvRy4C6Sj60rFq1aOttErxTtw
         YjdSafe2ecbWEuZaoYGlH4VA8Wz46PAZ4qaoHRCqWHN91zZ2ZyAeBBIkZH7TzMMxYIKz
         F2t63BkQzLzEBbTZQQek63GMO2S3Ycen13x89imW8i6L8Df9JdaaNHdVRaptb0tOGqLp
         WC9tKcwVJzv037ld9oLNd1nEjX9iCvCcLfAFHBp4D1IldsZn32yovAteDMgd91brPwXi
         yzTF9t2icwiQYKvivYvn2QKmFpxp4Z9WOPvW7LYFCW3xWXJXboxxqgYm8tWkn0RRvzec
         nvyw==
X-Forwarded-Encrypted: i=1; AJvYcCX2KOxvowThOvV1Acl4lr61dMfy7zdDXjFIH0VEEfazELyH/zZyce9yh8ZD8jXSqsRk8rb2VKYOTA/4eEBEjQwO2aAZcP2bBVekFWMagqSAm5HoPVrRkNKCYtaHPzzF0vlMitQefnQOhE7PTA==
X-Gm-Message-State: AOJu0Ywv7okaUwDe9ap1eXz/NDiOhepQDliBTXF+8I28W9jkjjIfp0cU
	jJoiavX296A06oyuh9macpKKNb2l6ZaWj6oSSBzt5EEd/GAuunaH
X-Google-Smtp-Source: AGHT+IFMW80dbs/pY++dtNtvzHb1WYcUEESLpcAgRLqSeB/Ioaz6lpTvNIJkRCEMb2pG4WzbE3HdTw==
X-Received: by 2002:a17:903:983:b0:1ea:26bf:928 with SMTP id mb3-20020a170903098300b001ea26bf0928mr8877605plb.50.1714417607002;
        Mon, 29 Apr 2024 12:06:47 -0700 (PDT)
Received: from KASONG-MB2.tencent.com ([1.203.116.31])
        by smtp.gmail.com with ESMTPSA id y4-20020a170902864400b001e49428f313sm20619356plt.261.2024.04.29.12.06.43
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 29 Apr 2024 12:06:46 -0700 (PDT)
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
Subject: [PATCH v3 00/12] mm/swap: clean up and optimize swap cache index
Date: Tue, 30 Apr 2024 03:04:48 +0800
Message-ID: <20240429190500.30979-1-ryncsn@gmail.com>
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

This is based on latest mm-unstable. Patch 1/12 might not be needed if
f2fs converted .readahead to use folio, I included it for easier test
and review.

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

To keep the code clean and compatible, this series first cleaned up
usage of them.

First page_file_offset and folio_file_pos are historical helpes that can
be simply dropped after clean up. And page_index can be all converted to
folio_index or folio->index.

Then introduce two new helpers swap_cache_index and swap_dev_pos
for swap. Replace swp_offset with swap_cache_index when used to
retrieve folio from swap cache, and use swap_dev_pos when needed
to retrieve the device position of a swap entry. This way,
swap_cache_index can return the optimized value with no compatibility
issue.

Idealy, in the future, we may want to reduce SWAP_ADDRESS_SPACE_SHIFT
from 14 to 12: Default Xarray chunk offset is 6, so we have 3 level
trees instead of 2 level trees just for 2 extra bits. But swap cache
is based on address_space struct, with 4 times more metadata sparsely
distributed in memory it waste more cacheline, the performance gain
from this series is almost canceled according to my test. So first,
just have a cleaner seperation of offsets and smaller search space.

Patch 1/12 - 11/12: Clean up usage of above helpers.
Patch 11/12: Apply the optmization.

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
  mm/swap: get the swap file offset directly
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
 fs/nilfs2/bmap.c          |  3 +--
 fs/smb/client/file.c      |  2 +-
 include/linux/mm.h        | 13 -------------
 include/linux/pagemap.h   | 25 ++++---------------------
 mm/huge_memory.c          |  2 +-
 mm/memcontrol.c           |  2 +-
 mm/mincore.c              |  2 +-
 mm/page_io.c              |  6 +++---
 mm/shmem.c                |  2 +-
 mm/swap.h                 | 24 ++++++++++++++++++++++++
 mm/swap_state.c           | 12 ++++++------
 mm/swapfile.c             | 11 +++++------
 23 files changed, 65 insertions(+), 92 deletions(-)

-- 
2.44.0


