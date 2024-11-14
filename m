Return-Path: <linux-fsdevel+bounces-34802-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B3CC9C8DF8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2024 16:28:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E201D1F236D4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2024 15:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4B4216ABC6;
	Thu, 14 Nov 2024 15:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="MBXlZawU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4996E156653
	for <linux-fsdevel@vger.kernel.org>; Thu, 14 Nov 2024 15:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731598084; cv=none; b=Eun6VlSDVSiRR/ZgXKmBJ34dBEM4vOpBsdCgqG6/W01K1qw3of7ub9Hi4qOgZP7JOtCA5p7Cru4Podx/4XFfqKn+QBLrmjSqZOiOLEXL81USfnf/mKBVMlTdzd8n8Rddm5H0Cyz3Jxx0ujfk2h0A4+v8rpJ/2XEDxCceOQCeEdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731598084; c=relaxed/simple;
	bh=c2TEu+YFRzeJg1sAj7V27VWatQDU0ccey6dX2M3ChOg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A6zV5Uq7SOZx+Paq2aDvjNQqeuA4pmJtYX+ty+YIMKA7rIz787GcKjFi7w/KQG1M3IskscJjn4qFgStngJivQto3nNKCR+gZWTKt9CzOg8tMIZxgqk1rvXsK7R/8AyxNmJeU0MuyDjmKhsTrVoP56QZve7+EkXP652QyaciaP+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=MBXlZawU; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-2887326be3dso305651fac.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 14 Nov 2024 07:28:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1731598081; x=1732202881; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=upOcZ8Da+PhrMJT3+CvYdnGUaA0rMPuANSoknEoDO6c=;
        b=MBXlZawUht7HoB0xXgeeHRp7Rs9EY3Oq+hF6vMqv4y1S1QuOS9TlrX6DnNa4IkeLfj
         ZZIbiuRxdlrJp8hiztytOZDjj+PqUQgNRRhtpuNAk4s6iN2w4PdQWyCHchZfJA+nXdTR
         gvX4DuyuVJW2TqIp5B/XsoQEhPC7GD3LE8A7iZqraH8T5wwpu6Cc8E+/J2Ah/FsL8bkR
         0leP5oxs1zuKHptdaW9TS4h2N8sX7qxBcXSL/33puLU7xXbD40jJi7Jzzg9kF+Qb6Omc
         snOVzxsUyRdXmjy5KKUv1IZzC7GWhbCXsjhvEz3aAznOrPjzyutsj/NMHso9yCFnb4Rp
         QKeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731598081; x=1732202881;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=upOcZ8Da+PhrMJT3+CvYdnGUaA0rMPuANSoknEoDO6c=;
        b=r10aLETU98wXMpWBT1baj2VlCIjp6dTk8PCJzTcf3StpHAtUTmm3IBfVT9vcjuxl2Z
         V0U8nQ/K7G03vb5GRLxj1iSFbGMhUG8HjCBr7nODts9Z66UxkZYr5iWGQjfhBtBbONmY
         SX9DH3k5ZjlQPTQglDqxPCRTNZKP+rgrkRDM1QOTFkh87p6AATJmlBJwDjX8ow/GOV8S
         ZKnojMO+3CW4G0HalwMJZxHsg4CzFePCU8Gv+dl00XTMbEbMzvAZjXqnTBVgNKVWZMNu
         hLOu2XX+ljQu6YPdAOyOkAXB3GIOyoAJgd8q0QppeF9WO9gp8wwAViHAjd3p9qxAfz9H
         y2qQ==
X-Forwarded-Encrypted: i=1; AJvYcCWveZFo83m+aPGNrpvzFjq8t0JkcPkuKQUWJyesMPhA63vAxcEH0fY6nG5M0ZQ0e54VgDaDRozCgmgwXVHt@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3WgzATyizFk0wRvEO0FhA8MvX+m+RNq9lPcXJpu1JVhUEZpue
	xjBR9dSdEoNu/C35z2ucWI+1y9mpqJh6TpoRNuY7jDj5WsN7ZXMhB92T3TZb/b4=
X-Google-Smtp-Source: AGHT+IHBiSMdAqkwaY/EaNZLQHe509r0Wv/sQpfdA1eWS0kETb8TpyQost056gI2LIEpEMGhxGO0ag==
X-Received: by 2002:a05:6871:6306:b0:277:e1bc:7da7 with SMTP id 586e51a60fabf-295e8dc02c3mr7474161fac.22.1731598081287;
        Thu, 14 Nov 2024 07:28:01 -0800 (PST)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5eea026eb41sm368250eaf.39.2024.11.14.07.28.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 07:28:00 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Cc: hannes@cmpxchg.org,
	clm@meta.com,
	linux-kernel@vger.kernel.org,
	willy@infradead.org,
	kirill@shutemov.name,
	linux-btrfs@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	bfoster@redhat.com
Subject: [PATCHSET v5 0/17] Uncached buffered IO
Date: Thu, 14 Nov 2024 08:25:04 -0700
Message-ID: <20241114152743.2381672-2-axboe@kernel.dk>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

5 years ago I posted patches adding support for RWF_UNCACHED, as a way
to do buffered IO that isn't page cache persistent. The approach back
then was to have private pages for IO, and then get rid of them once IO
was done. But that then runs into all the issues that O_DIRECT has, in
terms of synchronizing with the page cache.

So here's a new approach to the same concent, but using the page cache
as synchronization. That makes RWF_UNCACHED less special, in that it's
just page cache IO, except it prunes the ranges once IO is completed.

Why do this, you may ask? The tldr is that device speeds are only
getting faster, while reclaim is not. Doing normal buffered IO can be
very unpredictable, and suck up a lot of resources on the reclaim side.
This leads people to use O_DIRECT as a work-around, which has its own
set of restrictions in terms of size, offset, and length of IO. It's
also inherently synchronous, and now you need async IO as well. While
the latter isn't necessarily a big problem as we have good options
available there, it also should not be a requirement when all you want
to do is read or write some data without caching.

Even on desktop type systems, a normal NVMe device can fill the entire
page cache in seconds. On the big system I used for testing, there's a
lot more RAM, but also a lot more devices. As can be seen in some of the
results in the following patches, you can still fill RAM in seconds even
when there's 1TB of it. Hence this problem isn't solely a "big
hyperscaler system" issue, it's common across the board.

Common for both reads and writes with RWF_UNCACHED is that they use the
page cache for IO. Reads work just like a normal buffered read would,
with the only exception being that the touched ranges will get pruned
after data has been copied. For writes, the ranges will get writeback
kicked off before the syscall returns, and then writeback completion
will prune the range. Hence writes aren't synchronous, and it's easy to
pipeline writes using RWF_UNCACHED. Folios that aren't instantiated by
RWF_UNCACHED IO are left untouched. This means you that uncached IO
will take advantage of the page cache for uptodate data, but not leave
anything it instantiated/created in cache.

File systems need to support this. The patches add support for the
generic filemap helpers, and for iomap. Then ext4 and XFS are marked as
supporting it. The last patch adds support for btrfs as well, lightly
tested. The read side is already done by filemap, only the write side
needs a bit of help. The amount of code here is really trivial, and the
only reason the fs opt-in is necessary is to have an RWF_UNCACHED IO
return -EOPNOTSUPP just in case the fs doesn't use either the generic
paths or iomap. Adding "support" to other file systems should be
trivial, most of the time just a one-liner adding FOP_UNCACHED to the
fop_flags in the file_operations struct.

Performance results are in patch 8 for reads and patch 10 for writes,
with the tldr being that I see about a 65% improvement in performance
for both, with fully predictable IO times. CPU reduction is substantial
as well, with no kswapd activity at all for reclaim when using uncached
IO.

Using it from applications is trivial - just set RWF_UNCACHED for the
read or write, using pwritev2(2) or preadv2(2). For io_uring, same
thing, just set RWF_UNCACHED in sqe->rw_flags for a buffered read/write
operation. And that's it.

Patches 1..7 are just prep patches, and should have no functional
changes at all. Patch 8 adds support for the filemap path for
RWF_UNCACHED reads, patch 10 adds support for filemap RWF_UNCACHED
writes, and patches 13..17 adds ext4, xfs/iomap, and btrfs support.

Passes full xfstests and fsx overnight runs, no issues observed. That
includes the vm running the testing also using RWF_UNCACHED on the host.
I'll post fsstress and fsx patches for RWF_UNCACHED separately. As far
as I'm concerned, no further work needs doing here. Once we're into
the 6.13 merge window, I'll split up this series and aim to get it
landed that way. There are really 4 parts to this - generic mm bits,
ext4 bits, xfs bits, and btrfs bits.

And git tree for the patches is here:

https://git.kernel.dk/cgit/linux/log/?h=buffered-uncached.7

 fs/btrfs/bio.c                 |   4 +-
 fs/btrfs/bio.h                 |   2 +
 fs/btrfs/extent_io.c           |   8 ++-
 fs/btrfs/file.c                |   9 ++-
 fs/ext4/ext4.h                 |   1 +
 fs/ext4/file.c                 |   2 +-
 fs/ext4/inline.c               |   7 +-
 fs/ext4/inode.c                |  18 +++++-
 fs/ext4/page-io.c              |  28 ++++----
 fs/iomap/buffered-io.c         |  15 ++++-
 fs/xfs/xfs_aops.c              |   7 +-
 fs/xfs/xfs_file.c              |   3 +-
 include/linux/fs.h             |  21 +++++-
 include/linux/iomap.h          |   8 ++-
 include/linux/page-flags.h     |   5 ++
 include/linux/pagemap.h        |  14 ++++
 include/trace/events/mmflags.h |   3 +-
 include/uapi/linux/fs.h        |   6 +-
 mm/filemap.c                   | 114 +++++++++++++++++++++++++++++----
 mm/readahead.c                 |  22 +++++--
 mm/swap.c                      |   2 +
 mm/truncate.c                  |  35 ++++++----
 22 files changed, 271 insertions(+), 63 deletions(-)

Since v3
- Use foliop_is_uncached() in ext4 rather than do manual compares with
  foliop_uncached.
- Add filemap_fdatawrite_range_kick() helper and use that in
  generic_write_sync() to kick off uncached writeback, rather than need
  every fs adding a call to generic_uncached_write().
- Drop generic_uncached_write() helper, not needed anymore.
- Skip folio_unmap_invalidate() if the folio is dirty.
- Move IOMAP_F_UNCACHED to the internal iomap flags section, and add
  comment from Darrick to it as well.
- Only kick uncached writeback in generic_write_sync() if
  iocb_is_dsync() isn't true.
- Disable RWF_UNCACHED on dax mappings. They require more extensive
  invalidation, and as it isn't a likely use case, just disable it
  for now.
- Update a few commit messages

-- 
Jens Axboe


