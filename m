Return-Path: <linux-fsdevel+bounces-34343-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 986309C4A2D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 00:56:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64003B2A23C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 23:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C08D81BD4EB;
	Mon, 11 Nov 2024 23:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="o0SGqj8W"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2101F1BC9FB
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 Nov 2024 23:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731368929; cv=none; b=WNSBKMJBylTjWA6yexnGS24fhFfAtqfNrD9sg7H2mOX9laiYGtyKf61ZNF7IiVrPdvV2Ifq2x0hS6oylQ+sgGdGGShWgubGM6+ZYtBsw1vD3FId1jtTnK4ITVs8+08iZtf4OCCSf81+XFzBli3LJXKqGGZxHzizgGWX9CNCrado=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731368929; c=relaxed/simple;
	bh=u6zv4laTdZIRcz/cff/UpCCD3gIWZPSpqigelGUNTIE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W+6YA5a7JWsc0H4HxwbRv9kFe+R5i54R8PECd2bCawZht/mSxrzwNK+q5/Y3inbS1arkQxAdOPEqcBSOrQ22f7dMIJ28mHBoMD5VCmfYwhemdqSYdbZ09Lx+sU20dmKx8eJQXsh9vh88YlZnf6Od6ngw3tRc7cPROSnyu+IcXoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=o0SGqj8W; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7242f559a9fso2198021b3a.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Nov 2024 15:48:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1731368926; x=1731973726; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YYLsiY4xLzV9Ev2HH0qyOPkbZaBIuVD6O14DicI00XQ=;
        b=o0SGqj8WK1Xg1DUt8awt99G/RLCuINezweNZARfxHrwnMVwwv2r/YhaYQyn9OiGdDU
         zLKJjguD14bOa93TJ9Ni2SA0o98OE2F9n8s31Kc49wTOQhkrNd2r+vdfPeYxJFxqPDe0
         Tz1nNiH8FlQMI9TmAUQ2wDThcRph5st2ybZ6V/Fc+FNZWP6QTPwNUWXVYRDA6syz1F01
         SRIS3/Qobl3o1SgvX3iigJcOkRtICYD9/AfIJ42kofx0WO7FPPp9FhLWRtJPh4jYqSCU
         iiamSZKTKlya31yLJ52kBfoSPa6jgTSF639TSOvvW2WWEUd9mFA1weDRg98hWXFYWEqt
         HU8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731368926; x=1731973726;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YYLsiY4xLzV9Ev2HH0qyOPkbZaBIuVD6O14DicI00XQ=;
        b=C32ZnRjIXcaQ3NvIl4fXr57xiCPyplBq/IbhAk/6P5r9Za2xoifND1eiGjzYhkKTvr
         5mYFygAErxhCMH2tkpHBRAAiRs01fNSw2YiK/dniVSKwVGsNtdD6QuVLA//tih4clWYy
         YSW0vaSF/55CIy1tRhQJggnnn5f1zV4BBlCAAjip9qYZORsV3vZA2OkQBF6zCDiv0TBd
         VvVWZPi5KGW3qMIJDHYk/+Gs2y9Z2pgp+Cy70Of+uA0KhWAcBxWR3JR+vky/Ij8ZHAcP
         cL15+cq99RWsiOujdzReBIh1D3LibadmUoHYcSBxhygFXs8bIZhGw3sJ/DAoWBOdTCXI
         r2ig==
X-Forwarded-Encrypted: i=1; AJvYcCX7KGtrE+K0yyn4Bn4IUTA3EsHdVxUpfScE2EwAF+EOo1mveV/WJD/IhVT3xwv9wMQyDO3tsVrgMF5FQB+h@vger.kernel.org
X-Gm-Message-State: AOJu0YxSZlwk8wT/UaaHJw5OFCemmLHSqceTeTDuliSxtefp4Oqe0WMp
	Q1UJCE1SVy41TedsqGg6ln57hxKE2Gjao7RZL0+i/zalvabbTMPAZsyVZJ6k1uw=
X-Google-Smtp-Source: AGHT+IEOnqlyg7Q+iX7fiQJ8AI28/+0i7NkDDQxzm0hQvMnhJKygejIvPH0gTjJTu2JTP1X7D+h51g==
X-Received: by 2002:a05:6a00:b4d:b0:71e:5150:61d6 with SMTP id d2e1a72fcca58-7241336888cmr19984342b3a.21.1731368926283;
        Mon, 11 Nov 2024 15:48:46 -0800 (PST)
Received: from localhost.localdomain ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724078a7ee9sm10046057b3a.64.2024.11.11.15.48.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 15:48:45 -0800 (PST)
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
	linux-xfs@vger.kernel.org
Subject: [PATCHSET v3 0/16] Uncached buffered IO
Date: Mon, 11 Nov 2024 16:37:27 -0700
Message-ID: <20241111234842.2024180-1-axboe@kernel.dk>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

(A bit of version confusion, but this follows v4 -> v2 -> v3, as v4 was
 a relic of the 5 year old version. Next will be v5 and we should be
 consistent again)

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
writes, and patches 12..16 adds ext4, xfs/iomap, and btrfs support.

I ran this through xfstests, and it found some of the issue listed as
fixed below. This posted version passes the whole generic suite of
xfstests. The xfstests patch is here:

https://lore.kernel.org/linux-mm/3da73668-a954-47b9-b66d-bb2e719f5590@kernel.dk/

And git tree for the patches is here:

https://git.kernel.dk/cgit/linux/log/?h=buffered-uncached.6


 fs/btrfs/bio.c                 |   4 +-
 fs/btrfs/bio.h                 |   2 +
 fs/btrfs/extent_io.c           |   8 ++-
 fs/btrfs/file.c                |  10 +++-
 fs/ext4/ext4.h                 |   1 +
 fs/ext4/file.c                 |   2 +-
 fs/ext4/inline.c               |   7 ++-
 fs/ext4/inode.c                |  18 +++++-
 fs/ext4/page-io.c              |  28 +++++----
 fs/iomap/buffered-io.c         |  15 ++++-
 fs/xfs/xfs_aops.c              |   7 ++-
 fs/xfs/xfs_file.c              |   4 +-
 include/linux/fs.h             |  10 +++-
 include/linux/iomap.h          |   4 +-
 include/linux/page-flags.h     |   5 ++
 include/linux/pagemap.h        |  34 +++++++++++
 include/trace/events/mmflags.h |   3 +-
 include/uapi/linux/fs.h        |   6 +-
 mm/filemap.c                   | 101 ++++++++++++++++++++++++++++-----
 mm/readahead.c                 |  22 +++++--
 mm/swap.c                      |   2 +
 mm/truncate.c                  |  33 ++++++-----
 22 files changed, 262 insertions(+), 64 deletions(-)

Since v2
- Add patch for btrfs to work on the write side, read side was already
  covered by the generic filemap changes. Now btrfs is FOP_UNCACHED
  enabled as well.
- Add folio_unmap_invalidate() helper, and use that from both the core
  code and the uncached handling.
- Add filemap_uncached_read() helper to encapsulate the uncached
  handling on the read side.
- Enable handling of invalidation of mapped folios
- Clear uncached in looked up folio, if FGP_UNCACHED isn't set. For this
  case, there are competing non-uncached page cache users and the folio
  should not get invalidated.
- Various little tweaks or comments.
- Ran fsstress with read/write uncached support, no issues seen
- Fixup a commit message
- Rebase on 6.12-rc7

-- 
Jens Axboe


