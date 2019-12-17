Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 168EE122EF0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2019 15:39:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728548AbfLQOjw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Dec 2019 09:39:52 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:40856 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728493AbfLQOjw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Dec 2019 09:39:52 -0500
Received: by mail-io1-f68.google.com with SMTP id x1so2131209iop.7
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Dec 2019 06:39:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0sZEnSkiYQNg6SRJmFflI3w/YPx9FXg9wqpG+aZiUIM=;
        b=ZFmHNFAdcG7mQJRZW+JQhhU6M5I9mUsiClpOEIcm4l+zxMdF3+8vNscaoLE6Ixz8cK
         Fwwh4HpRBW135LiR/ts9XPRvQCkGIqz3NYGkoG01rCaxt8Y6ZSkM3q3E4JDgVusCk0Nz
         wyD8BSgwt1xouzFrZsdMhlmtVl91gLdHXF+xnPxxhzLIiJS5UnLvf/gtpGwDhIeC1UJF
         f2buPPaMh2zmMyy3MfluQl7rimW4fGJZh09GFb7sD3QbvmC98i1/TD16veiObym089bw
         o8RqmSmla8kCTNssOdDZrKgbj/Lcv+D5RjWhOuj3/8n4kKqm/pxYb/KeWDHSRQrjMFCS
         0y5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0sZEnSkiYQNg6SRJmFflI3w/YPx9FXg9wqpG+aZiUIM=;
        b=IsSXpmfwZXkNuFiRHyv5HHub3P/CYUWGJQC9+igruN/cOvWsomFVI67SIfagngbEOe
         51VXcbcRX47pVvlsaVTnaPW7Mtz4qGhxKETob+OH27Pz3VuwqvdV/1+jrbAgJWF7LWV/
         N3ffPBBboWjxd0fFuep5RfNPEoVGHcZNVMmFnKKIbawuoqX0jDD+tcJtv7gGF/IdwKw2
         Qy8lqJ/zzTF3LLNNbp8XEaoxRaGNiUVwQ3GtChrcZ2vhsl8CMA6TBZe4V7IGtk5Bv0/1
         VdGhzVuLJm8/tWWCRkFI46SgIHpISMpM/pTfRBUdwNWJboUh6RPHNuEhBDm2oYzIY4G8
         aX/w==
X-Gm-Message-State: APjAAAWssTfsaxk63LEyCYtnT5BsDQfvt0NYKeUJAHZsajRgm/A7h3nS
        cZ5rrwV0LxzwxI3xf0NjaK4/Rg==
X-Google-Smtp-Source: APXvYqzDsH+MCOmq9YfOhpFDx//rJABZlfmdvz8nIgn21DdebL9/fB5mPQh0kVogMn7XFjwVW9bkYg==
X-Received: by 2002:a6b:731a:: with SMTP id e26mr3843894ioh.254.1576593591067;
        Tue, 17 Dec 2019 06:39:51 -0800 (PST)
Received: from x1.thefacebook.com ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id w21sm5285255ioc.34.2019.12.17.06.39.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 06:39:50 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org
Cc:     willy@infradead.org, clm@fb.com, torvalds@linux-foundation.org,
        david@fromorbit.com
Subject: [PATCHSET v5 0/6] Support for RWF_UNCACHED
Date:   Tue, 17 Dec 2019 07:39:42 -0700
Message-Id: <20191217143948.26380-1-axboe@kernel.dk>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Recently someone asked me how io_uring buffered IO compares to mmaped
IO in terms of performance. So I ran some tests with buffered IO, and
found the experience to be somewhat painful. The test case is pretty
basic, random reads over a dataset that's 10x the size of RAM.
Performance starts out fine, and then the page cache fills up and we
hit a throughput cliff. CPU usage of the IO threads go up, and we have
kswapd spending 100% of a core trying to keep up. Seeing that, I was
reminded of the many complaints I here about buffered IO, and the fact
that most of the folks complaining will ultimately bite the bullet and
move to O_DIRECT to just get the kernel out of the way.

But I don't think it needs to be like that. Switching to O_DIRECT isn't
always easily doable. The buffers have different life times, size and
alignment constraints, etc. On top of that, mixing buffered and O_DIRECT
can be painful.

Seems to me that we have an opportunity to provide something that sits
somewhere in between buffered and O_DIRECT, and this is where
RWF_UNCACHED enters the picture. If this flag is set on IO, we get the
following behavior:

- If the data is in cache, it remains in cache and the copy (in or out)
  is served to/from that. This is true for both reads and writes.

- For writes, if the data is NOT in cache, we add it while performing the
  IO. When the IO is done, we remove it again.

- For reads, if the data is NOT in the cache, we allocate a private page
  and use that for IO. When the IO is done, we free this page. The page
  never sees the page cache.

With this, I can do 100% smooth buffered reads or writes without pushing
the kernel to the state where kswapd is sweating bullets. In fact it
doesn't even register.

Comments appreciated! This should work on any standard file system,
using either the generic helpers or iomap. I have tested ext4 and xfs
for the right read/write behavior, but no further validation has been
done yet. This version contains the bigger prep patch of switching
iomap_apply() and actors to struct iomap_data, and I hope I didn't
mess that up too badly. I'll try and exercise it all, I've done XFS
mounts and reads+writes and it seems happy from that POV at least.

The core of the changes are actually really small, the majority of
the diff is just prep work to get there.

Patches are against current git, and can also be found here:

https://git.kernel.dk/cgit/linux-block/log/?h=buffered-uncached

 fs/ceph/file.c          |   2 +-
 fs/dax.c                |  25 +++--
 fs/ext4/file.c          |   2 +-
 fs/iomap/apply.c        |  61 ++++++++---
 fs/iomap/buffered-io.c  | 230 +++++++++++++++++++++++++---------------
 fs/iomap/direct-io.c    |  57 +++++-----
 fs/iomap/fiemap.c       |  48 +++++----
 fs/iomap/seek.c         |  64 ++++++-----
 fs/iomap/swapfile.c     |  27 ++---
 fs/iomap/trace.h        |   4 +-
 fs/nfs/file.c           |   2 +-
 fs/xfs/xfs_iomap.c      |   7 +-
 include/linux/fs.h      |   7 +-
 include/linux/iomap.h   |  20 +++-
 include/uapi/linux/fs.h |   5 +-
 mm/filemap.c            |  87 +++++++++++++--
 16 files changed, 439 insertions(+), 209 deletions(-)

Changes since v4:
- Add patch for disabling delalloc on buffered writes on xfs
- Fixup an XFS flags mishap
- Add iomap flag trace definitions
- Fixup silly add_to_page_cache() vs add_to_page_cache_lru() mistake

Changes since v3:
- Add iomap_actor_data to cut down on arguments
- Fix bad flag drop in iomap_write_begin()
- Remove unused IOMAP_WRITE_F_UNCACHED flag
- Don't use the page cache at all for reads

Changes since v2:
- Rework the write side according to Chinners suggestions. Much cleaner
  this way. It does mean that we invalidate the full write region if just
  ONE page (or more) had to be created, where before it was more granular.
  I don't think that's a concern, and on the plus side, we now no longer
  have to chunk invalidations into 15/16 pages at the time.
- Cleanups

Changes since v1:
- Switch to pagevecs for write_drop_cached_pages()
- Use page_offset() instead of manual shift
- Ensure we hold a reference on the page between calling ->write_end()
  and checking the mapping on the locked page
- Fix XFS multi-page streamed writes, we'd drop the UNCACHED flag after
  the first page

--
Jens Axboe


