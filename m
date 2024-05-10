Return-Path: <linux-fsdevel+bounces-19271-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 106E58C23E1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 May 2024 13:50:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 337211C22F5B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 May 2024 11:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EB6416E898;
	Fri, 10 May 2024 11:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PdNLMsH7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B488770E7;
	Fri, 10 May 2024 11:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715341791; cv=none; b=bpFhVRTotpOxI+2RqeNxJH2W4BqzUhB5MvXT2V9zRZ7U79m8xI72dLSUn9yosOWlBi659T9PbHicIHThLJRsPVvTPUOJgp4DESlWnL3j6fv0kzwGylJBSw3AEeKtb0KnkPaF+5o1E7u0TXvLGigwBtaacjdTqIoS8ITkB0i02Qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715341791; c=relaxed/simple;
	bh=x9GlpFf7UQEMftHo2mHP+tg6SzwrY0YpvvD3FRhObls=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VRu1xhX9VmH0eJQR6lTlD7pZ/IU3w+FbQc/pds97ZUOM25Ank+wTpyoh9fIVmG+10f/VMvDvUE/eVPj6rM+GjUjjLROUTac93nx0VChHT2iNUGwAlHtKNJLvgAU2uajRR0hvAhw3Mq4bMleafwCrEWX468InCZ+e4WHhXl4hxNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PdNLMsH7; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1ee5235f5c9so16377005ad.2;
        Fri, 10 May 2024 04:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715341789; x=1715946589; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JEJ+bXS2uoPYXUBSHd6/sAtybdUy2Iom+XBD9eN3z9M=;
        b=PdNLMsH7XOvEjqMhZBpli8QG49jVhsYyyS+ya2MijrFBpLs/TFxlb64rAjltX2EShy
         TFkilM8ERqMNygjoxlK4Q2prdBBlLydFgmhRZ+VTTEOpfKQ/EFgeI7xuARRksAt2S+K5
         fJ8eiXqAfoNoyYKgilLzfGcCoXU5fKv7nPFzRBzD+aOz/QDfM9+uUcoe5OgfIVMn4eCj
         wL72+koc6ldr92U7ftK6qXSiTfn3vRXPCBsNlukAGIxQoPoz5NukReuW761+AzPXaxiW
         NqlODpPZj3Z0IA4E7SS4nP8vRWigivIhGy4tX/u9nyXi0YENwlAaj4Zok8pq0e1dSH4k
         A+xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715341789; x=1715946589;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JEJ+bXS2uoPYXUBSHd6/sAtybdUy2Iom+XBD9eN3z9M=;
        b=CedQYSkdoPi0xg5/bDThIucHMjkYApeC5fIfw+YjBvTORFp2t6ATOfxnYz38rmTJW2
         G0FFsf8OpJQBhnP52gVNBcqAgLWjSDHUewfeLYV6euUpKT4ZjGPqUhCkpXbEdsqjpiVD
         QgHCp2Gx1JrxEf7H20LfJQi3j4IpRRLBOn36Bw92hM5E75hbh1Cd1KH/P5iuQeBdVqW3
         y2ECmYgZW/E5vHfpYGjYNLdJq5opAtxQ+ne9h5E9AjoG4MoyF3DdKIqqC/JTtbmMUI4a
         qg6YYs8FQjPspT3+zo/c+XhJKM8Mv4KvdW/fTYXZBGG7O0qIHaFXCatwTUoAaYpO2oea
         Dnfw==
X-Forwarded-Encrypted: i=1; AJvYcCVmszOFmO6eY2AwSJZK2kONYf7WVwUwZQBex5ufF50KDg1mW17ZdtMFFVMCRYhPNfwrWJC0rCAv3Dyzmxwqqy1pu6q2cWbONKONociBgDHHUArtV+6OaTdPz4ZDs1+3HWwVIs5P6ePnyKVhFQ==
X-Gm-Message-State: AOJu0Yyk1cOzZlr9z1t5PdQcQvzNPh8YYB6jDOif9deSY5kOTNuilpvF
	b1XXltR+YnOjYvcOSCQ7rkde13PHbX4i7ng4jVVaBR8rIvbEXrIi
X-Google-Smtp-Source: AGHT+IEk0nQ6WTWqUQUjcvmxyBNrGBVqk/JdgpWP0HR3+Dxk00t5rJln8ChmuQQhselkib7wiz56DA==
X-Received: by 2002:a17:902:d58a:b0:1ec:a65a:e4ad with SMTP id d9443c01a7336-1ef44059ea7mr29149025ad.66.1715341789314;
        Fri, 10 May 2024 04:49:49 -0700 (PDT)
Received: from KASONG-MC4.tencent.com ([43.132.141.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0c134155sm30183825ad.231.2024.05.10.04.49.45
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 10 May 2024 04:49:48 -0700 (PDT)
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
Subject: [PATCH v5 00/12] mm/swap: clean up and optimize swap cache index
Date: Fri, 10 May 2024 19:47:35 +0800
Message-ID: <20240510114747.21548-1-ryncsn@gmail.com>
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
 fs/smb/client/file.c      |  2 +-
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
 23 files changed, 69 insertions(+), 100 deletions(-)

-- 
2.45.0


