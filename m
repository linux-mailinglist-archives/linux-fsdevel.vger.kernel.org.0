Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D57B119F02
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Dec 2019 00:02:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727308AbfLJXCQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Dec 2019 18:02:16 -0500
Received: from mx2.suse.de ([195.135.220.15]:49646 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726801AbfLJXCP (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Dec 2019 18:02:15 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 28758AD4F;
        Tue, 10 Dec 2019 23:02:14 +0000 (UTC)
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     linux-btrfs@vger.kernel.org
Cc:     hch@infradead.org, darrick.wong@oracle.com, fdmanana@kernel.org,
        nborisov@suse.com, dsterba@suse.cz, jthumshirn@suse.de,
        linux-fsdevel@vger.kernel.org,
        Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [PATCH 3/8] iomap: Remove lockdep_assert_held()
Date:   Tue, 10 Dec 2019 17:01:50 -0600
Message-Id: <20191210230155.22688-4-rgoldwyn@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191210230155.22688-1-rgoldwyn@suse.de>
References: <20191210230155.22688-1-rgoldwyn@suse.de>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Goldwyn Rodrigues <rgoldwyn@suse.com>

Filesystems such as btrfs can perform direct I/O without holding the
inode->i_rwsem in some of the cases like writing within i_size.
So, remove the check for lockdep_assert_held().

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 fs/iomap/direct-io.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 1a3bf3bd86fb..41c1e7c20a1f 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -415,8 +415,6 @@ iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 	struct blk_plug plug;
 	struct iomap_dio *dio;
 
-	lockdep_assert_held(&inode->i_rwsem);
-
 	if (!count)
 		return 0;
 
-- 
2.16.4

