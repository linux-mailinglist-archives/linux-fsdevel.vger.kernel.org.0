Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE66881049
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Aug 2019 04:32:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbfHECcJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 4 Aug 2019 22:32:09 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40102 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726767AbfHECcJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 4 Aug 2019 22:32:09 -0400
Received: by mail-pg1-f196.google.com with SMTP id w10so38876167pgj.7;
        Sun, 04 Aug 2019 19:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UZHhZu7UO1jH1fQJkZzMyLRgsNTiTLatRpcoqCnRJ18=;
        b=CKraWwqkZg3c2qd7Q6WpNuUpw+dh0cgfSan9Gc4M6oztcD2jYks4Hb4bo13E6rJErQ
         DuEnbjTFVBizjVe4SAifSMkHIVfWrYlU2SpY1yqvnSK9ALH06GWdibnMn+oDJEwWttwM
         8XEzY1NThUu/6KjyO2+/vNzjE1iJ93hyj7kKNrgI+4bFKwBxpqxmIcLvBXB2s/AREGLZ
         2yLtMRwvlAputd3raT0mu/uXk6A2qPMy/pwibQjdm/jNFkKe52tcH02yIHG/cbtBomqb
         /JwAbGqvZ/xlURNEF75r57r9uENgKlgqGcwtmrtgsfQt3aWi0bzleotTEDpQekp9eKkx
         mTAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UZHhZu7UO1jH1fQJkZzMyLRgsNTiTLatRpcoqCnRJ18=;
        b=LLNCMKyKrN2i72BUd7ccYD4rfZl3QQtzkBhoyLarwqoCvI4JADVKDwxBV+yMpv6tm1
         14I+TvbuGWptJo0Ga/af2Sa3lM09yVEcGxErDgvGuw0RJTjfr3ThKeELN86jppMFgeEH
         qUBUqTk5qMSWfF0/htvZkCAXK5mM01SbJPjUxgii6Ol0lnOXVfDzAS756yffkwQDuAEn
         YZ2G49YrIBur6Dy3J5Fe8R1QrvNdsVzPYrWezGCUBTG9fuz19b7KLuC/gP0BvbxENaIU
         IGWsYv3hf7ttZ5XiOgNjKMIfJTyimik4KdiFmQE3ZcmNP0wfL+9GBXAwGCJtEFYPHkfm
         bCig==
X-Gm-Message-State: APjAAAXEKryko+Cr2zQmtaNjCfXGCsOlGn0DnthhvkjZJymG/D8INRRS
        rYimTDzotLgFWCxnxylR0RM=
X-Google-Smtp-Source: APXvYqyLrqI7gGqCgmIwbmF9a0CEz3uJYMrD1LI9rhekWLAO8LK0W3mWt00RvgrLzC1hsNBPyLQDdg==
X-Received: by 2002:aa7:86cc:: with SMTP id h12mr63989613pfo.2.1564972328962;
        Sun, 04 Aug 2019 19:32:08 -0700 (PDT)
Received: from blueforge.nvidia.com (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id y128sm102095363pgy.41.2019.08.04.19.32.07
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 04 Aug 2019 19:32:08 -0700 (PDT)
From:   john.hubbard@gmail.com
X-Google-Original-From: jhubbard@nvidia.com
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Ira Weiny <ira.weiny@intel.com>, Jan Kara <jack@suse.cz>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Jerome Glisse <jglisse@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: [PATCH] fs/io_uring.c: convert put_page() to put_user_page*()
Date:   Sun,  4 Aug 2019 19:32:06 -0700
Message-Id: <20190805023206.8831-1-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: John Hubbard <jhubbard@nvidia.com>

For pages that were retained via get_user_pages*(), release those pages
via the new put_user_page*() routines, instead of via put_page() or
release_pages().

This is part a tree-wide conversion, as described in commit fc1d8e7cca2d
("mm: introduce put_user_page*(), placeholder versions").

Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-block@vger.kernel.org
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 fs/io_uring.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index d542f1cf4428..8a1de5ab9c6d 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -2815,7 +2815,7 @@ static int io_sqe_buffer_unregister(struct io_ring_ctx *ctx)
 		struct io_mapped_ubuf *imu = &ctx->user_bufs[i];
 
 		for (j = 0; j < imu->nr_bvecs; j++)
-			put_page(imu->bvec[j].bv_page);
+			put_user_page(imu->bvec[j].bv_page);
 
 		if (ctx->account_mem)
 			io_unaccount_mem(ctx->user, imu->nr_bvecs);
@@ -2959,10 +2959,8 @@ static int io_sqe_buffer_register(struct io_ring_ctx *ctx, void __user *arg,
 			 * if we did partial map, or found file backed vmas,
 			 * release any pages we did get
 			 */
-			if (pret > 0) {
-				for (j = 0; j < pret; j++)
-					put_page(pages[j]);
-			}
+			if (pret > 0)
+				put_user_pages(pages, pret);
 			if (ctx->account_mem)
 				io_unaccount_mem(ctx->user, nr_pages);
 			kvfree(imu->bvec);
-- 
2.22.0

