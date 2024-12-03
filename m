Return-Path: <linux-fsdevel+bounces-36354-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 395479E2451
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Dec 2024 16:48:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B21F9B250CB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Dec 2024 15:34:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 537601FAC5A;
	Tue,  3 Dec 2024 15:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="XjZvTI8G"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 557371F4276
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Dec 2024 15:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733239969; cv=none; b=nTC5QhJ0pwp1zcFAJMC/MmLksoDzEOu4idUpWx9c2xHyBSVnyc52aONtTq1OuABxjW1/8wn3nvYMDfQ4vVbLMG95fAQw73jK/eHO/ZCPe+7l0e9oLUumZTcouJB3MZ6ucy6rRbtJY0X6nH9tGZKEbmO6QWfUGTUG2KccGRvyD/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733239969; c=relaxed/simple;
	bh=dFq/XRxDt+HIqEZR9dMuNHZcnO5Ib5UvsEhxod461O0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=i+u3o85CsfN3IKG1mKdSA5rQ/puIeXzHAqjV3CVjW+HHSXk7YnMuD0npylkpfDxdcU7Q1TB0E4ktHf2FDB+kDJrZjmx53gY1qc5i5gzx3fFtIxrfUc4GgIY+ZBRHNGwea0eWmn7wJkoWOQ9lNjknK0H30PmyCmZoywr35jZ/6es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=XjZvTI8G; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3ea68fc1a7cso2700627b6e.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Dec 2024 07:32:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1733239965; x=1733844765; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2HZHG8qEfkcKm6/83F+woZUDdj6/tbhXxaseTSsadHk=;
        b=XjZvTI8GxOqVyDqoXdxNIWjm69EFYNkEaIE4DTZMTvBt1hgpav2ZPUSffndY1nBYZr
         4ZwR9ai0Mc95j+lG5/UI9PU4okbqpUmxagQurvpcTOdqDMnw9laOPh1xCtE7f++zc0D9
         RdzBbnc8BiNY0mvM4T0ggNUAAFKTv5Vc6vKKe73ercRZoZID2U1Rz1myRCdc68n4A1yL
         giNiNTyNI3uk5x/cmMqMASgSEDiGcbqy3jvS7RuCVTEvvhlV0ei+8Ky0+q2Aq2Kv+PlN
         gjUt6YGKNlyPQn44xYEMtHetd26zrzK2f3j/XY6EirYEoj5Zzcv4bt5ZvvzPiW9OHwdT
         vcxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733239965; x=1733844765;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2HZHG8qEfkcKm6/83F+woZUDdj6/tbhXxaseTSsadHk=;
        b=YOawkRyM4CMBCXqqGhsjJ6FuMmsvYNyNJmdJjaQmfy1KojckWOrClnh5VlHfsmTNZx
         Vmqzn/7fiol/BwIBVDYC9Tz+uWiAiTUX2MatQ2ZBmx60nDsL/3QuLGgkrP3KIa5XqGWU
         qobe/WDYgdTYpS08t+2Za3dBdDQZFztW+0DxI58bPjn5yIi/GyuDfNSymL4spZqZxZwf
         R+BiGwgiP4QdlosyUgqex0K09Rmvx9MNByrNjj4Cw8AIzrffB6Z9Xsp22gY0cbtX617A
         XloQFwr2PNEUAcL4KXLbq768C+hero5W8vP/GWlgbd2nsjYBVRLQBbB+9FK2ErEU1C3J
         WeXQ==
X-Forwarded-Encrypted: i=1; AJvYcCV8L7cuiGzoU1zjfHcQtwA8eVNlq2WAK1MK/vQVidrNuZ6yu5NPAONelJVf5bF0n3xCrcZ79+Tg0uloP5nT@vger.kernel.org
X-Gm-Message-State: AOJu0YzBVNdv2XHwPoPnlo04yqfGqLj1c8zexgK/KvLzEAv98yYpIXMW
	jRtdzyRDd/AirBDZT5zIuqlertdLZW0y6NLNur1IcPTHYheFN+fErSz1S/O1Vs59ZvaWEnnczJt
	l
X-Gm-Gg: ASbGncvCvD+5lzKX48R3eXFAoafvJGOp5wP2Jlams236KR7x9ddMhEfafzHowRpOo75
	RJqIetDudxaXWCGP+9wfB8Dp9GXMHRo9148uuGbQ1PTZO9eqj+zPrWW/xhGUFOXoaElUwr/B4QP
	TAKBE61rIQRQNhmtUntdBRC6VBLvfMale7niWvgnGvh1UBS4LDEJ2xv0CXXDFSmi5OcltSk5m2Y
	jHYcSVw/YOptclxbPCP4symiEonnoA+ek97HgyRd8ay+Iq4SX7aOQvB2VE=
X-Google-Smtp-Source: AGHT+IF3bKaCVeTwKmpj/Uuop61+2KuNOAf8A7q4MCbfYKhXZErIYLFEKdETPqvJNmapDAl+Xet+UQ==
X-Received: by 2002:a05:6808:3092:b0:3ea:6149:d6ef with SMTP id 5614622812f47-3eae4edae8bmr2905608b6e.1.1733239965326;
        Tue, 03 Dec 2024 07:32:45 -0800 (PST)
Received: from localhost.localdomain ([130.250.255.163])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3ea86036cbbsm2891878b6e.8.2024.12.03.07.32.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 07:32:44 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Cc: hannes@cmpxchg.org,
	clm@meta.com,
	linux-kernel@vger.kernel.org,
	willy@infradead.org,
	kirill@shutemov.name,
	bfoster@redhat.com
Subject: [PATCHSET v6 0/12] Uncached buffered IO
Date: Tue,  3 Dec 2024 08:31:36 -0700
Message-ID: <20241203153232.92224-2-axboe@kernel.dk>
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
RWF_UNCACHED reads, patch 11 adds support for filemap RWF_UNCACHED
writes. In the below mentioned branch, there are then patches to
adopt uncached reads and writes for ext4, xfs, and btrfs.

Passes full xfstests and fsx overnight runs, no issues observed. That
includes the vm running the testing also using RWF_UNCACHED on the host.
I'll post fsstress and fsx patches for RWF_UNCACHED separately. As far
as I'm concerned, no further work needs doing here.

And git tree for the patches is here:

https://git.kernel.dk/cgit/linux/log/?h=buffered-uncached.8

 include/linux/fs.h             |  21 +++++-
 include/linux/page-flags.h     |   5 ++
 include/linux/pagemap.h        |  14 ++++
 include/trace/events/mmflags.h |   3 +-
 include/uapi/linux/fs.h        |   6 +-
 mm/filemap.c                   | 114 +++++++++++++++++++++++++++++----
 mm/readahead.c                 |  22 +++++--
 mm/swap.c                      |   2 +
 mm/truncate.c                  |  35 ++++++----
 9 files changed, 187 insertions(+), 35 deletions(-)

Since v5
- Skip invalidation in filemap_uncached_read() if the folio is dirty
  as well, retaining the uncached setting for later cleaning to do
  the actual invalidation.
- Use the same trylock approach in read invalidation as the writeback
  invalidation does.
- Swap order of patches 10 and 11 to fix a bisection issue.
- Split core mm changes and fs series patches. Once the generic side
  has been approved, I'll send out the fs series separately.
- Rebase on 6.13-rc1

-- 
Jens Axboe


