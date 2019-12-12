Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2709211D68C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2019 20:01:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730592AbfLLTBi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Dec 2019 14:01:38 -0500
Received: from mail-il1-f195.google.com ([209.85.166.195]:33095 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730552AbfLLTBh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Dec 2019 14:01:37 -0500
Received: by mail-il1-f195.google.com with SMTP id r81so2974718ilk.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Dec 2019 11:01:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ovDmnr/9RvR8ZZRh+R6sbKcDY51akdjZYbAek3W/T9E=;
        b=0J8yS6LU+VJC3DmeIONOJvogXk+0an4zAyd6Jx56rTBrkgeUChz9ZnqthoObvi8EwG
         QQX+s9eHJEaLMtYtG6Q8cCKAIHCn3voNuwx3MJq3VQq3FYjih3mtVxcF3ZHVUkMB1TMO
         PCucj93LwVI7ax+mw+nxP2T68Izlu54R738G5abYBJGo2/Fd81T55PgQTCirXCHMh6jh
         ro+RwJhdQxkltBI/Az1zolVEa4hNTDSwvuZlI8FkE+/D2S1zwOimo6v8LySQAETyqjRF
         sIcmaNkiPQBjCBQKbvEDqsR7/UO0H3P5ddbFzOoCrwFjd8i7FwTxINyFc+V3URV/7AmN
         Hy8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ovDmnr/9RvR8ZZRh+R6sbKcDY51akdjZYbAek3W/T9E=;
        b=j/PlIGpNpUUscU/rmZfWxT/ohfILnFwlR+SHwEbd0OhgPLs1V2D9wBD4PcZaAkU59M
         dzuBWvCOWv14wB2cUwhilzGlxM3xxjuo+7LO7EOY5l/ngqh0jT1EYrP6eWldHcOYOOrK
         LS2YBneh+YdYt+nIxxHlqbFHPnti2vc1foHQnMwZa879eETOFEa9V1pfsEC6UGh05DMO
         VL4mE4l7jCBMstYyeSFFfE4EeRPkJ+fXJveAYN5JfuUO+3z3ezVSxOL8PnC3PMDpyoiG
         87L+vhjz8WOqe4z/+TfjXRWDm45Ff6QiCYc6ifXff3R4uN03phFBIyl1xazP/SNeZ77S
         ZYAA==
X-Gm-Message-State: APjAAAVkDlmmaBqrZxMhIDrJkZb4goCfZLa7dSLa6Y4kltVr5QX2KaPG
        UcpQEiFXLCaog1d26nuQKGwktg==
X-Google-Smtp-Source: APXvYqx7OzUuqUuKPK7adK91kwP6pyHsQWbI4lIk01qvzfE1sY1oclszKDcqlWV9JFKXZnSvUKGCAQ==
X-Received: by 2002:a92:5bdd:: with SMTP id c90mr10293064ilg.78.1576177296868;
        Thu, 12 Dec 2019 11:01:36 -0800 (PST)
Received: from x1.thefacebook.com ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id i22sm1957745ill.40.2019.12.12.11.01.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2019 11:01:35 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org
Cc:     willy@infradead.org, clm@fb.com, torvalds@linux-foundation.org,
        david@fromorbit.com
Subject: [PATCHSET v4 0/5] Support for RWF_UNCACHED
Date:   Thu, 12 Dec 2019 12:01:28 -0700
Message-Id: <20191212190133.18473-1-axboe@kernel.dk>
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
 fs/iomap/apply.c        |  50 ++++++---
 fs/iomap/buffered-io.c  | 225 +++++++++++++++++++++++++---------------
 fs/iomap/direct-io.c    |  57 +++++-----
 fs/iomap/fiemap.c       |  48 +++++----
 fs/iomap/seek.c         |  64 +++++++-----
 fs/iomap/swapfile.c     |  27 ++---
 fs/nfs/file.c           |   2 +-
 include/linux/fs.h      |   7 +-
 include/linux/iomap.h   |  20 +++-
 include/uapi/linux/fs.h |   5 +-
 mm/filemap.c            |  89 +++++++++++++---
 14 files changed, 416 insertions(+), 207 deletions(-)

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


