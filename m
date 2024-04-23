Return-Path: <linux-fsdevel+bounces-17527-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 734B48AF4DF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Apr 2024 19:04:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3059E287BEB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Apr 2024 17:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A466313DDA3;
	Tue, 23 Apr 2024 17:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N4yTDI5/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DFF713D635;
	Tue, 23 Apr 2024 17:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713891833; cv=none; b=UcTpHlnERdV2fJlaLUthdI/JbvGJTMW7R90wsIoXLo0+W0ik4fAVAYQYJ/g+mNIURAfQvM3RHIsAKzOvIMcSHbwPepsW4KbIxAidRReq2lm39PJUcckfrE1xJWXvsOJMMUHvgTK1h6Zo/3CYAuNvlIgkix3Q+z+MX81OB6maZSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713891833; c=relaxed/simple;
	bh=MlaQWLl7duyXfxYen2igLXYiF4SjPRIXLKzR79MAJjI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=slrLQWfkE51i8EXRqx3jdrLpqCvE4RtXMqA/hCtBXgJNhNbjhl8HtzxiVoXU72dDwIT3MnTn1ghleSeDHIpX9uJlkggnnBvIhsHaw0fNmnzkwB8Kxkax21JlnztJVUAiq4gNLo6lyrLf7yZZCxRw4is6MHQvVo5/nXJ+JZ3QPgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N4yTDI5/; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2a87bd53dc3so4797410a91.2;
        Tue, 23 Apr 2024 10:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713891831; x=1714496631; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZQvlEY7MT0+SgdPdpEHB8TaD1H3HfXPQY1TqoLowYww=;
        b=N4yTDI5/nXssi/UH8gV/Vy+RySAQIhIJwhdpEazeMG5DWf9g1ZnLPjVvFzbysLxNvB
         7dr6jFYtiP3esAZ+o4Ix81IZmS8/I3HADGyCIXJ//JIs0sqyV6XcH/+Zc+sfsC13ej/J
         JR+GLeOTKDA45nnFZ8SPoISeAwLfL1enph30XAjbI5skuCKDkS7xEBfo/pI6vzrVlrTD
         u1XLNnCUA+7Mc3I6bmjKgm979/GLW5PE5uCUIwfEYjigm3NTtZL8ByceU8ii9ykxNxLQ
         I95AAtobmalQFpsG0OPA4zqFvMMGx0w+1w1vMBIA2I2XfFhzZFkIcaYvfBy6TBxql9so
         TtHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713891831; x=1714496631;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZQvlEY7MT0+SgdPdpEHB8TaD1H3HfXPQY1TqoLowYww=;
        b=W4SVztzCPzrItE/BTmzGWktsvmkSxk2o24aQsmqoEl/7XcTT+P9hnGwrfVUBe9dxdu
         JUBYIbH+PEJvIYp5ROv00GAPBc6r2m28rNCH2VVynw37xtaD5CulPGTDKEnqb0HZLbVi
         KMrDpm3KgNONiJutOg3gqMcs8pVC7V42Y+rN3WJaFa0m2tpe5sl+GRqRT+m3qjZ5pSqw
         GOkaNEnOgl0AVBSjl/PkVc6b7Z0rq37Ly1CMrbx75z5JRFsj5tNLSjLtRTzEHJnuuqOO
         78nUGqvcBxgSDDYmnV8ApJDZwtXc9/+XN6PH+nWqwYvS9wYaTgmJG9PXFLrstGIQfgeo
         uKuw==
X-Forwarded-Encrypted: i=1; AJvYcCVix38LnamlSGExoZ396EcMwNhgvEN8CWUVTenutO2gT87MccIfGe0yPKkb8TtfJPuAGeIxoqZhqNFThrz3p6ti1wyqYXc0Aq4FWOS9G2Km/RHr07SWZodU3RN8E/OTiTMYW1BTarB8RecERA==
X-Gm-Message-State: AOJu0YyLNshCE0Prd0tMvv+ZFJ2VqCrlHsUuhljcRD13f6CbrwErEutV
	sE00JkkEWIyAJSA7XSkQpnOauamAK4/BtefywMnMFeqndfMrBMCi
X-Google-Smtp-Source: AGHT+IHxLzzi7qfZC4OU3sFngJ45YhHz1ewqpnb9m+rSrCflIEH50ZdrdabDX/V8A+ZyXPuKO434FA==
X-Received: by 2002:a17:90b:3844:b0:2a2:71c7:7e26 with SMTP id nl4-20020a17090b384400b002a271c77e26mr3964431pjb.28.1713891830659;
        Tue, 23 Apr 2024 10:03:50 -0700 (PDT)
Received: from KASONG-MB2.tencent.com ([1.203.116.31])
        by smtp.gmail.com with ESMTPSA id s19-20020a17090a881300b002a5d684a6a7sm9641148pjn.10.2024.04.23.10.03.46
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 23 Apr 2024 10:03:50 -0700 (PDT)
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
Subject: [PATCH v2 0/8] mm/swap: optimize swap cache search space
Date: Wed, 24 Apr 2024 01:03:31 +0800
Message-ID: <20240423170339.54131-1-ryncsn@gmail.com>
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

To keep the code clean and compatible, this series first cleaned up
usage of page_index and page_file_offset, then convert folio_index
and folio_file_pos to be compatible with separate offsets.
Current users won't be effected. And introduce two new helper
swap_cache_index and swap_dev_pos for swap internal usage.
Replace swp_offset with swap_cache_index when used to retrieve
folio from swap cache, and use swap_dev_pos when needed to retrieve
the device position of a swap entry.

Idealy, in the future, we may want to reduce SWAP_ADDRESS_SPACE_SHIFT
from 14 to 12: Default Xarray chunk offset is 6, so we have 3 level
trees instead of 2 level trees just for 2 extra bits. But swap cache
is based on address_space struct, with 4 times more metadata sparsely
distributed in memory it waste more cacheline, the performance gain
from this series is almost canceled according to my test. So first,
just have a cleaner seperation of offsets and smaller search space.

Patch 1/8 - 6/8: Clean up usage of page_index and page_file_offset
Patch 7/8: Convert folio_index and folio_dev_pos to be compatible with
  separate offset.
Patch 8/8: Introduce swap_cache_index and use it when doing lookup in
  swap cache.

V1: https://lore.kernel.org/all/20240417160842.76665-1-ryncsn@gmail.com/
Update from V1:
- Convert more users to use folio directly when possible [Matthew Wilcox]
- Rename swap_file_pos to swap_dev_pos [Huang, Ying]
- Update comments and commit message.
- Adjust headers and add dummy function to fix build error.

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
 mm/swap.h               | 24 ++++++++++++++++++++++++
 mm/swap_state.c         | 12 ++++++------
 mm/swapfile.c           | 17 +++++++++++------
 16 files changed, 63 insertions(+), 69 deletions(-)

-- 
2.44.0


