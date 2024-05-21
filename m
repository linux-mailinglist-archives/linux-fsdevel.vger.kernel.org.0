Return-Path: <linux-fsdevel+bounces-19920-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 097938CB324
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 May 2024 19:59:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D6311C2176D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 May 2024 17:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B92551487C1;
	Tue, 21 May 2024 17:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JkVGVoY6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A595522EF5;
	Tue, 21 May 2024 17:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716314343; cv=none; b=Va8hwXCFIMCuZnkU4M1YKre8u/sFHEbA4rUtjWZhqH//EK38vynIE7mkEbSle8A6Cp+LPI/CgT3c+7AUNUW7Ol8tfTr9nkifDzQYlu2E4fPZrIk/70B9uoTqgv0GUAbY4k5WkcMyGjjWdQ1GSIw2QYQU5a4rXCM3O6Ee3TKlUrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716314343; c=relaxed/simple;
	bh=E/LTP9Z6P0rD4Gsv84boqKsliteigMI9RQ6iIz3hFs0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TlCubVJgU4W+61DUze5FW81cdyfW+eEQSloHsmtE/t/PmsIquswSMpJUAEVMTCQuMaY8RAAFgce4+G/CpgOGJXrJLWfFVIBQF3EOmng1vSZkLj5TLtuHhYrMeRv9fjZioh9vlcu4QOAdYvn9L3ZIJa/XrChb136ogHkzMGBS1X0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JkVGVoY6; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1ec69e3dbcfso3507905ad.0;
        Tue, 21 May 2024 10:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716314341; x=1716919141; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RinISbwEJW1UkjXRq/8lwpL1dDqKAk8192kSmAu+1f8=;
        b=JkVGVoY6Ry6BYjUonilSclkFjnvQAnI1HxAIHiB6DbhWqTi6x4GZQM6UauCO5BW5YA
         5IaD9jdmHJ1YNk662NCBV9RUIggjhKqaA2wQAqKklptwMBGDi3TOgSfK2G3f3YtTYJ4/
         66kYidIJIjDoYP8DDfjih3b+fmNFwD9fm/CcVLqr0QWyQ1yguIMr8X/00lNhAGhGo+3F
         FLJwEXf2JuyAklj4+oM6HTkSfm+KlHqEiQPObjJSTpz5yYqnFuN06ad5Xf9S5+9fv9cG
         rXUyG7TL9RArOg14QHPasQld/S9y/l0YKnhbZHCpydg/uPr2YqeX/qkANMM57EaMbYVw
         sZzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716314341; x=1716919141;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RinISbwEJW1UkjXRq/8lwpL1dDqKAk8192kSmAu+1f8=;
        b=HLMYdfEeNKJtO3FowH4l2Lpi+qoBYjiPNS0q9HlHYN/b3KOKkdS7gVrSNXQP8+5Tul
         N8XqQoLiM2MBGDeMVmUtXDSMyqeLd856mnSn8UpIOaDRh35vuMg9QmuTekjM3MZpUxFR
         tiLFwOoIoAwtrbs7BSyqRLjHID48ZDAvHuUZfT/hA/ASq3AdKfVTRxeMovIBL9OAqy3K
         lmoAui0dJxXTw2aP86vHh/TPCQ2QKz6CQoz9bOHq2I556YnObc3L84kfcbziZi94ZYby
         82x4pj+Lg2jOg5s0LQY55cCpQLz7+TlE15LvUq0pDSabq4VnOpRMU1VVznV/Hpc1XFZ+
         NFLA==
X-Forwarded-Encrypted: i=1; AJvYcCWcUUH1xnikLY4cSTrmS6+MxfFDrzLJntNufsqeGsv6bgJ/csGWlRXHM47Pey9KYndXLbDUZ88gQbUhFdcnKA7wr/Fll96d0fpSheTPA/nG/teHlwsrEzWirPcxxgfXznqNGI35R++PFE11Pw==
X-Gm-Message-State: AOJu0Yw7uh+/LcfvS7pakzilnFil/pS6b0GWuJe8adLjhOLrdurKa7nR
	C+ovcC45TW8Yg/ouk2Ktgd6mr+djvUYOpTo6Fbs0NjIgWXgad5yNPuOhs7VxJLs=
X-Google-Smtp-Source: AGHT+IHDrvLWvdibZENp61Cxr0fCv/ILh0BWg974hKQ4HfS02Qj05+dAEbbzDzDLEBqsmocIboOsbA==
X-Received: by 2002:a17:903:244d:b0:1f3:a5b:9705 with SMTP id d9443c01a7336-1f30a5b9d66mr50029645ad.48.1716314340929;
        Tue, 21 May 2024 10:59:00 -0700 (PDT)
Received: from localhost.localdomain ([101.32.222.185])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f2fcdf87besm44646935ad.105.2024.05.21.10.58.57
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 21 May 2024 10:59:00 -0700 (PDT)
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
	David Hildenbrand <david@redhat.com>,
	Hugh Dickins <hughd@google.com>,
	Yosry Ahmed <yosryahmed@google.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kairui Song <kasong@tencent.com>
Subject: [PATCH v6 00/11] mm/swap: clean up and optimize swap cache index
Date: Wed, 22 May 2024 01:58:42 +0800
Message-ID: <20240521175854.96038-1-ryncsn@gmail.com>
X-Mailer: git-send-email 2.45.0
Reply-To: Kairui Song <kasong@tencent.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kairui Song <kasong@tencent.com>

Patch 1/11 is not needed if f2fs converted .readahead to use folio,
I included it for easier test and review.

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

Patch 1/11 - 10/11: Clean up usage of above helpers.
Patch 11/11: Apply the optmization.

V5: https://lore.kernel.org/linux-mm/20240510114747.21548-1-ryncsn@gmail.com/
Update from V5:
- Rebase to latest mainline.
- Drop cifs patch as is have already converted to use folio.
- Collect Review-by [Huang, Ying].

V4: https://lore.kernel.org/all/20240502084609.28376-1-ryncsn@gmail.com/
Update from V4:
- Collect Review-by and Acked-by.
- Fix a leftover error in commit message found by [David Hildenbrand].
- A few code clean up for better readability [Huang, Ying]

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

Kairui Song (11):
  f2fs: drop usage of page_index
  nilfs2: drop usage of page_index
  ceph: drop usage of page_index
  NFS: remove nfs_page_lengthg and usage of page_index
  afs: drop usage of folio_file_pos
  netfs: drop usage of folio_file_pos
  nfs: drop usage of folio_file_pos
  mm/swap: get the swap device offset directly
  mm: remove page_file_offset and folio_file_pos
  mm: drop page_index and simplify folio_index
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
 include/linux/mm.h        | 13 -------------
 include/linux/pagemap.h   | 25 ++++---------------------
 mm/huge_memory.c          |  2 +-
 mm/memcontrol.c           |  2 +-
 mm/mincore.c              |  2 +-
 mm/page_io.c              |  6 +++---
 mm/shmem.c                |  2 +-
 mm/swap.h                 | 24 ++++++++++++++++++++++++
 mm/swap_state.c           | 17 +++++++++--------
 mm/swapfile.c             | 11 +++++------
 22 files changed, 68 insertions(+), 99 deletions(-)

-- 
2.45.0


