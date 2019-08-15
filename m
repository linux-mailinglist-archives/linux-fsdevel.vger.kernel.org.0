Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75D598EB3C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Aug 2019 14:13:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731668AbfHOMNC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Aug 2019 08:13:02 -0400
Received: from mao.bsc.es ([84.88.52.34]:34795 "EHLO opsmail01.bsc.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726098AbfHOMNB (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Aug 2019 08:13:01 -0400
X-Greylist: delayed 564 seconds by postgrey-1.27 at vger.kernel.org; Thu, 15 Aug 2019 08:13:00 EDT
Received: from localhost (localhost [127.0.0.1])
        by opsmail01.bsc.es (Postfix) with ESMTP id 3A5232EC2E8;
        Thu, 15 Aug 2019 14:03:35 +0200 (CEST)
Received: from opsmail01.bsc.es ([127.0.0.1])
 by localhost (opswc01.bsc.es [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 13495-10; Thu, 15 Aug 2019 14:03:34 +0200 (CEST)
Received: from opswc01.bsc.es (localhost [127.0.0.1])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by opsmail01.bsc.es (Postfix) with ESMTPS id A541A169D9C;
        Thu, 15 Aug 2019 14:03:34 +0200 (CEST)
Received: (from filter@localhost)
        by opswc01.bsc.es (8.13.6/8.13.6/Submit) id x7FC3YpC026248;
        Thu, 15 Aug 2019 14:03:34 +0200
Received: from rocks (unknown [10.100.11.7])
        (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by opsmail01.bsc.es (Postfix) with ESMTPSA id EB0A615DA32;
        Thu, 15 Aug 2019 14:03:28 +0200 (CEST)
Date:   Thu, 15 Aug 2019 14:03:22 +0200
From:   Aleix Roca Nonell <aleix.rocanonell@bsc.es>
To:     Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, aleix.rocanonell@bsc.es
Subject: [PATCH] io_uring: fix manual setup of iov_iter for fixed buffers
Message-ID: <20190815120322.GA19630@rocks>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Copyrighted-Material: Please visit http://www.bsc.es/disclaimer
X-Virus-Scanned: amavisd-new at bsc.es
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Commit bd11b3a391e3 ("io_uring: don't use iov_iter_advance() for fixed
buffers") introduced an optimization to avoid using the slow
iov_iter_advance by manually populating the iov_iter iterator in some
cases.

However, the computation of the iterator count field was erroneous: The
first bvec was always accounted for an extent of page size even if the
bvec length was smaller.

In consequence, some I/O operations on fixed buffers were unable to
operate on the full extent of the buffer, consistently skipping some
bytes at the end of it.

Fixes: bd11b3a391e3 ("io_uring: don't use iov_iter_advance() for fixed buffers")
Cc: stable@vger.kernel.org
Signed-off-by: Aleix Roca Nonell <aleix.rocanonell@bsc.es>
---
 fs/io_uring.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index d542f1cf4428..aa25b5bbd4ae 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -1097,10 +1097,8 @@ static int io_import_fixed(struct io_ring_ctx *ctx, int rw,
 
 			iter->bvec = bvec + seg_skip;
 			iter->nr_segs -= seg_skip;
-			iter->count -= (seg_skip << PAGE_SHIFT);
+			iter->count -= bvec->bv_len + offset;
 			iter->iov_offset = offset & ~PAGE_MASK;
-			if (iter->iov_offset)
-				iter->count -= iter->iov_offset;
 		}
 	}
 
-- 
2.12.0


http://bsc.es/disclaimer
