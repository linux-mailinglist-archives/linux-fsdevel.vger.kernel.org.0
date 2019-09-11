Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5C9BB01ED
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Sep 2019 18:45:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729299AbfIKQpb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Sep 2019 12:45:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:34460 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728896AbfIKQpb (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Sep 2019 12:45:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2F975AF89;
        Wed, 11 Sep 2019 16:45:30 +0000 (UTC)
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-ext4@vger.kernel.org, linux-btrfs@vger.kernel.org,
        hch@infradead.org, andres@anarazel.de, david@fromorbit.com,
        riteshh@linux.ibm.com, linux-f2fs-devel@lists.sourceforge.net,
        Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [PATCH 3/3] f2fs: fix inode rwsem regression
Date:   Wed, 11 Sep 2019 11:45:17 -0500
Message-Id: <20190911164517.16130-4-rgoldwyn@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190911164517.16130-1-rgoldwyn@suse.de>
References: <20190911093926.pfkkx25mffzeuo32@alap3.anarazel.de>
 <20190911164517.16130-1-rgoldwyn@suse.de>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Goldwyn Rodrigues <rgoldwyn@suse.com>

This is similar to 942491c9e6d6 ("xfs: fix AIM7 regression")
Apparently our current rwsem code doesn't like doing the trylock, then
lock for real scheme.  So change our read/write methods to just do the
trylock for the RWF_NOWAIT case.

We don't need a check for IOCB_NOWAIT and !direct-IO because it
is checked in generic_write_checks().

Fixes: b91050a80cec ("f2fs: add nowait aio support")
Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 fs/f2fs/file.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 3e58a6f697dd..c6f3ef815c05 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -3134,16 +3134,12 @@ static ssize_t f2fs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 		goto out;
 	}
 
-	if ((iocb->ki_flags & IOCB_NOWAIT) && !(iocb->ki_flags & IOCB_DIRECT)) {
-		ret = -EINVAL;
-		goto out;
-	}
-
-	if (!inode_trylock(inode)) {
-		if (iocb->ki_flags & IOCB_NOWAIT) {
+	if (iocb->ki_flags & IOCB_NOWAIT) {
+		if (!inode_trylock(inode)) {
 			ret = -EAGAIN;
 			goto out;
 		}
+	} else {
 		inode_lock(inode);
 	}
 
-- 
2.16.4

