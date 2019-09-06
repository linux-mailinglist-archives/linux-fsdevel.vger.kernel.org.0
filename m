Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08A5FAC1A8
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Sep 2019 22:53:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391404AbfIFUxW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Sep 2019 16:53:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33268 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728590AbfIFUxV (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Sep 2019 16:53:21 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5D5BC8E2B72;
        Fri,  6 Sep 2019 20:53:21 +0000 (UTC)
Received: from max.com (ovpn-204-227.brq.redhat.com [10.40.204.227])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CF04C5DC1B;
        Fri,  6 Sep 2019 20:52:42 +0000 (UTC)
From:   Andreas Gruenbacher <agruenba@redhat.com>
To:     cluster-devel@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        Lukas Czerner <lczerner@redhat.com>
Subject: [Q] gfs2: mmap write vs. punch_hole consistency
Date:   Fri,  6 Sep 2019 22:52:41 +0200
Message-Id: <20190906205241.2292-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.69]); Fri, 06 Sep 2019 20:53:21 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

I've just fixed a mmap write vs. truncate consistency issue on gfs on
filesystems with a block size smaller that the page size [1].

It turns out that the same problem exists between mmap write and hole
punching, and since xfstests doesn't seem to cover that, I've written a
new test [2].  Ext4 and xfs both pass that test; they both apparently
mark the pages that have a hole punched in them as read-only so that
page_mkwrite is called before those pages can be written to again.

gfs2 fails that: for some reason, the partially block-mapped pages are
not marked read-only on gfs2, and so page_mkwrite is not called for the
partially block-mapped pages, and the hole is not filled in correctly.

The attached patch fixes the problem, but this really doesn't look right
as neither ext4 nor xfs require this kind of hack.  So what am I
overlooking, how does this work on ext4 and xfs?

Thanks,
Andreas

[1] gfs2: Improve mmap write vs. truncate consistency
https://www.redhat.com/archives/cluster-devel/2019-September/msg00009.html

[2] generic/567: test mmap write vs. hole punching
https://www.spinics.net/lists/fstests/msg12474.html

[PATCH] gfs2: Improve mmap write vs. punch_hole consistency

Fixes xfstest generic/567.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/bmap.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/gfs2/bmap.c b/fs/gfs2/bmap.c
index 9ef543dd38e2..e677e813be4c 100644
--- a/fs/gfs2/bmap.c
+++ b/fs/gfs2/bmap.c
@@ -2475,6 +2475,13 @@ int __gfs2_punch_hole(struct file *file, loff_t offset, loff_t length)
 			if (error)
 				goto out;
 		}
+		/*
+		 * If the first or last page partially lies in the hole, mark
+		 * the page read-only so that memory-mapped writes will trigger
+		 * page_mkwrite.
+		 */
+		pagecache_isize_extended(inode, offset, inode->i_size);
+		pagecache_isize_extended(inode, offset + length, inode->i_size);
 	}
 
 	if (gfs2_is_jdata(ip)) {
-- 
2.20.1

