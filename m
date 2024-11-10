Return-Path: <linux-fsdevel+bounces-34145-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 271AD9C3320
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Nov 2024 16:29:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C2861F2140F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Nov 2024 15:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34B694D8D1;
	Sun, 10 Nov 2024 15:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="LRgv+DlM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9637BA923
	for <linux-fsdevel@vger.kernel.org>; Sun, 10 Nov 2024 15:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731252556; cv=none; b=Yo2fzJzoFFAnQiZvJFrKAxMEmTVng6Hz/ZryvBIyd47BfgNKHtnLctJu8TjkDEFcreb7ey/qn6Ny1Gtd5/qnCC7JOAqLRTsTKUMnaW963brvYzqSmvFmc73fU163uQVu+xUzXZq+MSDg3FDXTCrqdkZsIVI5RTdoqc4tK7ObHCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731252556; c=relaxed/simple;
	bh=xasOoGyWNMyA1udAHMrri3V4nHf1SziBTPuUIKCzX1M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sUbkR61XzBVAIrqp+5yGiRWL2lwgeNZrr7MHv4NoTnkIbjpnpy8HfMfF3t9tqg4+gtGe4lmKQTb1Lmc9esdudELlf/FJsl2kC9owoOhgyVcSsmKDHE06NCptHnQsigBinpk+XtsZRL5U70pTVIEE1XwzB7Ymoz0XRfnBPTbS96Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=LRgv+DlM; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2e2e87153a3so2696895a91.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 10 Nov 2024 07:29:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1731252553; x=1731857353; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WMc2BZOwmLfUUNk6EhelpeJQ4f3KdM89SU9iONc3Ots=;
        b=LRgv+DlMj/d/wpCjA3/Rfj/6xgvmvpY7cH06C3XRT3vN/FSFUGZuuxtwuLm7Kur0FL
         dtRpSU1IcL271ot1XFH3VPqbRKGCQ+XBqELFrz4FqzRgp4jYR+r+jPLHiWdzbM5usC0/
         0a/EHAdcB5RZ61Z3je0OI5CmhBs6qe0wgGELFS9Ng0dYAiB3Bk/N5x7sePZTEG7mR4fW
         kAT1SQidHJbScdswFZ9stxQl0blSr7imxnbTBnG9MtAbbhrwNyja87Veqrl0QdHTVS7g
         wAwG4v+P3uim/To5pyTnb31+TJw2gfGqUL3BELcU1xHtihWopQw7ULTj8Ky5h0oBKUat
         HzoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731252553; x=1731857353;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WMc2BZOwmLfUUNk6EhelpeJQ4f3KdM89SU9iONc3Ots=;
        b=fFLO/QNduil/nWVTnehYIKh3J99nFJCipmrWfntIXvnfapUHLpIa63lkRSVS2Rrnna
         7sjmkUbBomVzUfAL0fDoE0donSP/VsPfKDEe8FcmtUvBeaSg9QB+OL/jX7cI1lYEN7P5
         SmqvJ5C5xF4aJDNhRaQGmFjZKgfXDHpmRDmnKXzHEEty9Wvjv7apddxjYypYv23jLQ44
         efeuG8SNNWh2ZeMhCZ4CSzZe9whKPIWHgUPYC/D8GFuO3RozRnt1cvV3OwRGnZ/fVKnW
         FmJqPWuEgZZLUQkT+puuC3nitIdyRx7svPSqB/M191sNgjIVvb0KnsNbdqs34Qulox6C
         k3xw==
X-Forwarded-Encrypted: i=1; AJvYcCV8jcOT5tJe2pVBNLN+KrxqDzIEC+aW2o8j7YZneBwX6RtKprw0N/RU+T5AW5H0XBLDGscXvwmN5SehQLni@vger.kernel.org
X-Gm-Message-State: AOJu0YxzwfmQOsjeNpUv3tV/U1ka5hgEBtcfY+0zpCBFzOyZq5KIXJyr
	kopNAaCVZ0J9cqCEYIGVHJzwhyFFNBopV4F9xMjzFC0u1m+it9XoF2sV2F/jYuazuOIxvpJdIfY
	hqBs=
X-Google-Smtp-Source: AGHT+IETALI0TZNk7iFvxtwupHcZ8wUtsRKgb47lHuBSuGblNAkHhnyAIoKBozbdHkor69Q0lPYHHA==
X-Received: by 2002:a17:90b:2e42:b0:2e2:d175:5f8d with SMTP id 98e67ed59e1d1-2e9b1713587mr14936527a91.10.1731252552713;
        Sun, 10 Nov 2024 07:29:12 -0800 (PST)
Received: from localhost.localdomain ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e99a5f935dsm9940973a91.35.2024.11.10.07.29.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Nov 2024 07:29:11 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Cc: hannes@cmpxchg.org,
	clm@meta.com,
	linux-kernel@vger.kernel.org,
	willy@infradead.org
Subject: [PATCHSET v2 0/15] Uncached buffered IO
Date: Sun, 10 Nov 2024 08:27:52 -0700
Message-ID: <20241110152906.1747545-1-axboe@kernel.dk>
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
pipeline writes using RWF_UNCACHED.

File systems need to support this. The patches add support for the
generic filemap helpers, and for iomap. Then ext4 and XFS are marked as
supporting it. The amount of code here is really trivial, and the only
reason the fs opt-in is necessary is to have an RWF_UNCACHED IO return
-EOPNOTSUPP just in case the fs doesn't use either the generic paths or
iomap. Adding "support" to other file systems should be trivial, most of
the time just a one-liner adding FOP_UNCACHED to the fop_flags in the
file_operations struct.

Performance results are in patch 7 for reads and patch 10 for writes,
with the tldr being that I see about a 65% improvement in performance
for both, with fully predictable IO times. CPU reduction is substantial
as well, with no kswapd activity at all for reclaim when using uncached
IO.

Using it from applications is trivial - just set RWF_UNCACHED for the
read or write, using pwritev2(2) or preadv2(2). For io_uring, same
thing, just set RWF_UNCACHED in sqe->rw_flags for a buffered read/write
operation. And that's it.

The goal with this patchset was to make it less special than before. I
think if you look at the diffstat you'll agree that this is the case.

Patches 1..6 are just prep patches, and should have no functional
changes at all. Patch 7 adds support for the filemap path for
RWF_UNCACHED reads, patch 10 adds support for filemap RWF_UNCACHED
writes, and patches 12..15 adds ext4 and xfs/iomap support iomap.

Git tree available here:

https://git.kernel.dk/cgit/linux/log/?h=buffered-uncached.5

 fs/ext4/ext4.h                 |  1 +
 fs/ext4/file.c                 |  2 +-
 fs/ext4/inline.c               |  7 ++-
 fs/ext4/inode.c                | 18 ++++++-
 fs/ext4/page-io.c              | 28 ++++++-----
 fs/iomap/buffered-io.c         | 15 +++++-
 fs/xfs/xfs_aops.c              |  7 ++-
 fs/xfs/xfs_file.c              |  4 +-
 include/linux/fs.h             | 10 +++-
 include/linux/iomap.h          |  4 +-
 include/linux/page-flags.h     |  5 ++
 include/linux/pagemap.h        | 34 +++++++++++++
 include/trace/events/mmflags.h |  3 +-
 include/uapi/linux/fs.h        |  6 ++-
 mm/filemap.c                   | 90 ++++++++++++++++++++++++++++------
 mm/readahead.c                 | 22 +++++++--
 mm/swap.c                      |  2 +
 mm/truncate.c                  |  9 ++--
 18 files changed, 218 insertions(+), 49 deletions(-)

Since v1
- Move iocb->ki_flags checking into filemap_create_folio()
- Use __folio_set_uncached() when marking a folio as uncached right
  after creation
- Shuffle patches around to not have a bisection issue
- Combine some patches
- Add FGP_UNCACHED folio get flag. If set, newly created folios will
  get marked as uncached.
- Add foliop_uncached to be able to pass whether this is an uncached
  folio creation or not into ->write_begin(). Fixes the issue of
  uncached writes pruning existing ranges. Not the prettiest, but the
  prospect of changing ->write_begin() is daunting. I did go that
  route but it's a lot of churn. Have the patch and the scars.
- Ensure that both ext4 and xfs punt to their workqueue handling
  writeback completion for uncached writebacks, as we need workqueue
  context to prune ranges.
- Add generic_uncached_write() helper to make it easy for file systems
  to prune the ranges.
- Add folio_end_uncached() writeback completion helper, and also check
  in_task() in there. Can trigger if the fs needs hints on punting to
  a safe context for this completion, but normal writeback races with
  us and starts writeback on a range that includes uncached folios.
- Rebase on current master

-- 
Jens Axboe


