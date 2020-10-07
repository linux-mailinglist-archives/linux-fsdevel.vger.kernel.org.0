Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDB22286154
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Oct 2020 16:36:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728629AbgJGOgL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Oct 2020 10:36:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:35091 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728535AbgJGOgL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Oct 2020 10:36:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602081370;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=il3YpmjtKhASkC/ZXwr1418et/cRzf+XfCkFjJHc+lU=;
        b=EzSiF392/9emQOiFtSmyXdKrryr+K/qakpwJkBNR/My/aCySqFZXfyxwlxo2YngZbn1IgN
        8hBbExhQxz/TRWoLUn49vwZUOW1n0iwMUpEgzyATThuMySRF30n5XUvLvyY74Wy6vI6+wY
        J/7eXcwpaPCuJ2YEEX/RjuR+DGsnLYI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-398-67SMbqtWOMKVh2DbQQ8LXw-1; Wed, 07 Oct 2020 10:36:06 -0400
X-MC-Unique: 67SMbqtWOMKVh2DbQQ8LXw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5322F84E246;
        Wed,  7 Oct 2020 14:35:10 +0000 (UTC)
Received: from bfoster.redhat.com (ovpn-112-249.rdu2.redhat.com [10.10.112.249])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C21F25D9DD;
        Wed,  7 Oct 2020 14:35:09 +0000 (UTC)
From:   Brian Foster <bfoster@redhat.com>
To:     linux-xfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: [PATCH] xfs: flush new eof page on truncate to avoid post-eof corruption
Date:   Wed,  7 Oct 2020 10:35:09 -0400
Message-Id: <20201007143509.669729-1-bfoster@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

It is possible to expose non-zeroed post-EOF data in XFS if the new
EOF page is dirty, backed by an unwritten block and the truncate
happens to race with writeback. iomap_truncate_page() will not zero
the post-EOF portion of the page if the underlying block is
unwritten. The subsequent call to truncate_setsize() will, but
doesn't dirty the page. Therefore, if writeback happens to complete
after iomap_truncate_page() (so it still sees the unwritten block)
but before truncate_setsize(), the cached page becomes inconsistent
with the on-disk block. A mapped read after the associated page is
reclaimed or invalidated exposes non-zero post-EOF data.

For example, consider the following sequence when run on a kernel
modified to explicitly flush the new EOF page within the race
window:

$ xfs_io -fc "falloc 0 4k" -c fsync /mnt/file
$ xfs_io -c "pwrite 0 4k" -c "truncate 1k" /mnt/file
  ...
$ xfs_io -c "mmap 0 4k" -c "mread -v 1k 8" /mnt/file
00000400:  00 00 00 00 00 00 00 00  ........
$ umount /mnt/; mount <dev> /mnt/
$ xfs_io -c "mmap 0 4k" -c "mread -v 1k 8" /mnt/file
00000400:  cd cd cd cd cd cd cd cd  ........

Update xfs_setattr_size() to explicitly flush the new EOF page prior
to the page truncate to ensure iomap has the latest state of the
underlying block.

Fixes: 68a9f5e7007c ("xfs: implement iomap based buffered write path")
Signed-off-by: Brian Foster <bfoster@redhat.com>
---

This patch is intentionally simplistic because I wanted to get some
thoughts on a proper fix and at the same time consider something easily
backportable. The iomap behavior seems rather odd to me in general,
particularly if we consider the same kind of behavior can occur on
file-extending writes. It's just not a user observable problem in that
case because a sub-page write of a current EOF page (backed by an
unwritten block) will zero fill the rest of the page at write time
(before the zero range essentially skips it due to the unwritten block).
It's not totally clear to me if that's an intentional design
characteristic of iomap or something we should address.

It _seems_ like the more appropriate fix is that iomap truncate page
should at least accommodate a dirty page over an unwritten block and
modify the page (or perhaps just unconditionally do a buffered write on
a non-aligned truncate, similar to what block_truncate_page() does). For
example, we could push the UNWRITTEN check from iomap_zero_range_actor()
down into iomap_zero(), actually check for an existing page there, and
then either zero it or skip out if none exists. Thoughts?

Brian

 fs/xfs/xfs_iops.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index 80a13c8561d8..3ef2e77b454e 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -911,6 +911,16 @@ xfs_setattr_size(
 		error = iomap_zero_range(inode, oldsize, newsize - oldsize,
 				&did_zeroing, &xfs_buffered_write_iomap_ops);
 	} else {
+		/*
+		 * iomap won't detect a dirty page over an unwritten block and
+		 * subsequently skips zeroing the newly post-eof portion of the
+		 * page. Flush the new EOF to convert the block before the
+		 * pagecache truncate.
+		 */
+		error = filemap_write_and_wait_range(inode->i_mapping, newsize,
+						     newsize);
+		if (error)
+			return error;
 		error = iomap_truncate_page(inode, newsize, &did_zeroing,
 				&xfs_buffered_write_iomap_ops);
 	}
-- 
2.25.4

