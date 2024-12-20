Return-Path: <linux-fsdevel+bounces-37952-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EC0B9F95C4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Dec 2024 16:50:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EAC91883750
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Dec 2024 15:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEF31218EAC;
	Fri, 20 Dec 2024 15:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="AzlcV/Z0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0389218AB7
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Dec 2024 15:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734709718; cv=none; b=rsR32r+eZt9k7KJChLYLhJ0eLyFflhdaqv8BHv2ztXSurk9YF5xjymhnZrrhv/8HMEXIBMZpqPBmen1ZG2Uw0TiNNG/5wEjIECybujHprYyJMSruBdNz4JJFpU3udJXKvSnJZYjpo74eAao17kD5UWOiamquUsKjMQWiXXC1S+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734709718; c=relaxed/simple;
	bh=1kau4qpLRMdWWDb/ayeDem4DeN1FTIj+jCu34FZ8NQU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ItwMC1+XIDEV107fa3ZdIAet8ZWykxpU32xqro4swvB/+vMXI5oskRmKUYEzwEjXzCOPvGHNoemNJvTtRZMJeNcts/SDnhuz3gifyPw+3FIzZYjrwKpVhmwl3HSvHCFX7LsN7XhdHQGyRRE+KNxkiRc3RVkg7ADYGyzRqth0Ozk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=AzlcV/Z0; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3a9628d20f0so13589155ab.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Dec 2024 07:48:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1734709715; x=1735314515; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5QLZfGQipkCBNguiWf4R+vP6AoBCDa/bCOHZx7IfU6M=;
        b=AzlcV/Z0MNicx/HWToTg8dAJ9LaiQ5b7CmakhZ3pKu4xkzg4hWidq0oGxBm4WGKTJw
         7HNzevcRqXGV0U9w/vwUKpJQpadb/aQ19wTav9stsMWMEM/UjxJtUCezULWKgKWeDDvR
         wwWaR7JwAI/1jLHTCMyeh5/mMqqQTfzR9LeJeei4/thUhqiywGoHQe3GeWTMNbgX/Sjk
         kZhcn0JpnGDj3OK8D6U1n0O8xgLJ3N78p5tGv9SQkEa7pDQGSIIefkk8o0jAWyBqJT+f
         SWvyLooKnMshh2fQ7Sr7a/YnouKDenr7jS3OlTjjMimGPCPKmG/STOR7wA0m70XtGEMw
         DN1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734709715; x=1735314515;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5QLZfGQipkCBNguiWf4R+vP6AoBCDa/bCOHZx7IfU6M=;
        b=qMhotmWZJyBZ2KU+1LGyTBqyN4FC1fO2fAblIphGxh6zHfqZqPq2rquPUgBIzxRL2I
         etfq8YMkcKPuy9OW+Sqg0F2n8TS6T65lb0Nv/ixzZj4SCuSzfftdUMvqLc1Z2GVFH/t6
         NUEcAXof3M2Ksj21oGa5maJfxlUKUGRemr5SADK+ZhEgWRQEJVvbo4VnPDDtwOkFMcgp
         ZuCXma+cCpcUt0TwP9J5oi1w9x2yjJgtDvFDGXvYvvixnE+SKX+byuH/gz3/jeLJvCxg
         35OJfV7siCES5Q1D38t6XJZtMxTauVIULODswtB7xSYIOfmPkGdlOY0SDnTDViFDQKp1
         wZSA==
X-Forwarded-Encrypted: i=1; AJvYcCUEr3WmyI+1yT6l/0BSAW4UkjrOM9WzMmfmkwiVBAWCu592TWX4C2MOjARywq33JmWOdpKpw5NWws/vvAT9@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3myrs2yLTpDpMJZt5UZ5dlItgVkWcqgQP0ffMHXKVCfOUOX21
	OlfnmS6cZHD92xCYJewEdkHd2kdKfASWC4Ts3suK7XLgxG9fZp96bv3jqc9HWfs=
X-Gm-Gg: ASbGncspRidk9B8KVWmJLGUQeuPQ8ARXJv67JYD/81oOlbJfnIm9M5RHL7HOkJtoqsa
	2s8iryoB43nG1FePvNkyuofikWGGFCfiXIW7e4HG5ACFkSZ2qaKh1QAjFYE7QTk2ja3NWneduXi
	wyKi1YxUsFesimwI1gOY3CRGQcXZ1VfcskLD29uFlP/MVCc+cf5vgTjl6mhZMSIYA5uP5yObrFQ
	8v09gBHBWewlm8lXFWxup8LMvyoVRmbKFSYEGAWqMQQ9hyjC29z+Xj9pIzW
X-Google-Smtp-Source: AGHT+IFEaCG9dI5jmaOPYYr5r7MTJolx0zr+xkp1PBAQcFRP+7qgC9EarkW8EUqWjETP8fYqrkS6Wg==
X-Received: by 2002:a05:6e02:19cc:b0:3a7:6e97:9877 with SMTP id e9e14a558f8ab-3c2d5a27dd7mr35198935ab.24.1734709714725;
        Fri, 20 Dec 2024 07:48:34 -0800 (PST)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4e68bf66ed9sm837821173.45.2024.12.20.07.48.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2024 07:48:34 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Cc: hannes@cmpxchg.org,
	clm@meta.com,
	linux-kernel@vger.kernel.org,
	willy@infradead.org,
	kirill@shutemov.name,
	bfoster@redhat.com
Subject: [PATCHSET v8 0/12] Uncached buffered IO
Date: Fri, 20 Dec 2024 08:47:38 -0700
Message-ID: <20241220154831.1086649-1-axboe@kernel.dk>
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
as synchronization. Due to excessive bike shedding on the naming, this
is now named RWF_DONTCACHE, and is less special in that it's just page
cache IO, except it prunes the ranges once IO is completed.

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

Common for both reads and writes with RWF_DONTCACHE is that they use the
page cache for IO. Reads work just like a normal buffered read would,
with the only exception being that the touched ranges will get pruned
after data has been copied. For writes, the ranges will get writeback
kicked off before the syscall returns, and then writeback completion
will prune the range. Hence writes aren't synchronous, and it's easy to
pipeline writes using RWF_DONTCACHE. Folios that aren't instantiated by
RWF_DONTCACHE IO are left untouched. This means you that uncached IO
will take advantage of the page cache for uptodate data, but not leave
anything it instantiated/created in cache.

File systems need to support this. This patchset adds support for the
generic read path, which covers file systems like ext4. Patches exist to
add support for iomap/XFS and btrfs as well, which sit on top of this
series. If RWF_DONTCACHE IO is attempted on a file system that doesn't
support it, -EOPNOTSUPP is returned. Hence the user can rely on it
either working as designed, or flagging and error if that's not the
case. The intent here is to give the application a sensible fallback
path - eg, it may fall back to O_DIRECT if appropriate, or just live
with the fact that uncached IO isn't available and do normal buffered
IO.

Adding "support" to other file systems should be trivial, most of the
time just a one-liner adding FOP_DONTCACHE to the fop_flags in the
file_operations struct, if the file system is using either iomap or
the generic filemap helpers for reading and writing.

Performance results are in patch 8 for reads, and you can find the write
side results in the XFS patch adding support for DONTCACHE writes for
XFS:

https://git.kernel.dk/cgit/linux/commit/?h=buffered-uncached-fs.10&id=257e92de795fdff7d7e256501e024fac6da6a7f4

with the tldr being that I see about a 65% improvement in performance
for both, with fully predictable IO times. CPU reduction is substantial
as well, with no kswapd activity at all for reclaim when using
uncached IO.

Using it from applications is trivial - just set RWF_DONTCACHE for the
read or write, using pwritev2(2) or preadv2(2). For io_uring, same
thing, just set RWF_DONTCACHE in sqe->rw_flags for a buffered read/write
operation. And that's it.

Patches 1..7 are just prep patches, and should have no functional
changes at all. Patch 8 adds support for the filemap path for
RWF_DONTCACHE reads, and patches 9..12 are just prep patches for
supporting the write side of uncached writes. In the below mentioned
branch, there are then patches to adopt uncached reads and writes for
xfs, btrfs, and ext4. The latter currently relies on bit of a hack for
passing whether this is an uncached write or not through
->write_begin(), which can hopefully go away once ext4 adopts iomap for
buffered writes. I say this is a hack as it's not the prettiest way to
do it, however it is fully solid and will work just fine.

Passes full xfstests and fsx overnight runs, no issues observed. That
includes the vm running the testing also using RWF_DONTCACHE on the
host. I'll post fsstress and fsx patches for RWF_DONTCACHE separately.
As far as I'm concerned, no further work needs doing here.

And git tree for the patches is here:

https://git.kernel.dk/cgit/linux/log/?h=buffered-uncached.10

with the file system patches on top adding support for xfs/btrfs/ext4
here:

https://git.kernel.dk/cgit/linux/log/?h=buffered-uncached-fs.10

 include/linux/fs.h             |  21 ++++++-
 include/linux/page-flags.h     |   5 ++
 include/linux/pagemap.h        |   3 +
 include/trace/events/mmflags.h |   3 +-
 include/uapi/linux/fs.h        |   6 +-
 mm/filemap.c                   | 102 ++++++++++++++++++++++++++++-----
 mm/internal.h                  |   2 +
 mm/readahead.c                 |  22 +++++--
 mm/swap.c                      |   2 +
 mm/truncate.c                  |  53 +++++++++--------
 10 files changed, 173 insertions(+), 46 deletions(-)

Since v7
- Rename filemap_uncached_read() to filemap_end_dropbehind_read()
- Rename folio_end_dropbehind() to folio_end_dropbehind_write()
- Make the "mm: add FGP_DONTCACHE folio creation flag" patch part of
  the base patches series, to avoid dependencies with btrfs/xfs/iomap
- Remove now dead IOMAP_F_DONTCACHE define and setting on xfs/iomap
- Re-instate mistakenly deleted VM_BUG_ON_FOLIO() in
  invalidate_inode_pages2_range()
- Add reviewed-by's
- Add separate fs patch branch that sits on top of the core branch
- Rebase on current -git master

-- 
Jens Axboe


