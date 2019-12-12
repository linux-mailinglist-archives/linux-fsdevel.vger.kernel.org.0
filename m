Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 95B4311D28A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2019 17:42:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729875AbfLLQmD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Dec 2019 11:42:03 -0500
Received: from mail-il1-f195.google.com ([209.85.166.195]:37340 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729771AbfLLQmC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Dec 2019 11:42:02 -0500
Received: by mail-il1-f195.google.com with SMTP id t9so2586556iln.4
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Dec 2019 08:42:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tQte4jDul4g65wI8UJx68nKw3XTglcWIscEV80J7fR4=;
        b=cFHPHHfnN4m+3qLZDhhT/EZDavRb5bFmg4ZXwDzdExwIGTTRa6cCj3PVIGIXM1YXp+
         iVuoH0Uo4HZ0njZ1NeMHdGTG17ypZG5p5FyyOKYy6iFFpYAVc84QOrmq5hhEsqxGAKMo
         EKZZVycpg/H29gsC8SfFqxIulsJPBrMIFrhL37h7MM0FoXtX3sTToYPe7lVcbefaLzuw
         jSMsNS5zenmfviYt+GHyjNMttUcN7RKka9gly7Yjd633pGRm31x2qlIhU2dz9bvb45Ji
         L8XqM7h04WAxPio5SWhF2IPEhqANCA4JnK1rYbygVVkGOYAFA8Acwtd2qeUdjy4hSQjO
         LDnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tQte4jDul4g65wI8UJx68nKw3XTglcWIscEV80J7fR4=;
        b=EOuKlLp/1pNOUeJeta9GWvKS1F+19iXnCGeYp2ZE06uSZdN1rX2TZbBwk3TeDoZaDZ
         kPiKCzMFH0iNspfRC1X1yfBlLkInz/QkbI1f07asdWFERUl/fDqlHbDma0e/8zijGahb
         USkU6m16CEPttDW2WS1XKlX2nIqL0SS5dypDMNQ/omaMGzgf/bGZuJziMq/SgcY1gF+R
         Bh1Rb5RaA8gx5GldC5RdSvngyYgoZEte4SdLgMYx/jtrPTRn8TiBsZZD8B9JALTRFsPm
         niPo8KcXi5Y+6XrJVmvhQ2RJ10qDz5Kn/eClw7lDYFJVldcS9N1dKbyG1+x0RR2lC6Jy
         zNIA==
X-Gm-Message-State: APjAAAW2PwyNeDqT0maVeTmO+GEWB3roNdHIqPpZkqiKJVEtA5vqD/9K
        eVwlMioRT5zPaTjbVXLbG2iPaw==
X-Google-Smtp-Source: APXvYqym98otwzTKxFwCRtU5q3N7gd+9oQtP+S11FGu9nYR6xGwaNTW5xg2Zi0lf9ZyCHs590PBW1A==
X-Received: by 2002:a92:d806:: with SMTP id y6mr9033593ilm.234.1576168921571;
        Thu, 12 Dec 2019 08:42:01 -0800 (PST)
Received: from x1.thefacebook.com ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id n3sm1855970ilm.74.2019.12.12.08.42.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2019 08:42:00 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org
Cc:     willy@infradead.org, clm@fb.com, torvalds@linux-foundation.org,
        david@fromorbit.com
Subject: [PATCHSET v4 0/5] Support for RWF_UNCACHED
Date:   Thu, 12 Dec 2019 09:41:38 -0700
Message-Id: <20191212164142.22202-1-axboe@kernel.dk>
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
  is served to/from that.

- If the data is NOT in cache, we add it while performing the IO. When
  the IO is done, we remove it again.

With this, I can do 100% smooth buffered reads or writes without pushing
the kernel to the state where kswapd is sweating bullets. In fact it
doesn't even register.

Comments appreciated! This should work on any standard file system,
using either the generic helpers or iomap. I have tested ext4 and xfs
for the right read/write behavior, but no further validation has been
done yet. Patches are against current git, and can also be found here:

https://git.kernel.dk/cgit/linux-block/log/?h=buffered-uncached

 fs/ceph/file.c          |  2 +-
 fs/dax.c                |  2 +-
 fs/ext4/file.c          |  2 +-
 fs/iomap/apply.c        | 26 ++++++++++-
 fs/iomap/buffered-io.c  | 54 ++++++++++++++++-------
 fs/iomap/direct-io.c    |  3 +-
 fs/iomap/fiemap.c       |  5 ++-
 fs/iomap/seek.c         |  6 ++-
 fs/iomap/swapfile.c     |  2 +-
 fs/nfs/file.c           |  2 +-
 include/linux/fs.h      |  7 ++-
 include/linux/iomap.h   | 10 ++++-
 include/uapi/linux/fs.h |  5 ++-
 mm/filemap.c            | 95 ++++++++++++++++++++++++++++++++++++-----
 14 files changed, 181 insertions(+), 40 deletions(-)

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


