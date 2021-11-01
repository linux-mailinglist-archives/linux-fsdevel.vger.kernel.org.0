Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BECAA44227A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Nov 2021 22:17:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231234AbhKAVTj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Nov 2021 17:19:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231312AbhKAVTY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Nov 2021 17:19:24 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 017D2C061764;
        Mon,  1 Nov 2021 14:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=Bx+F5BQFecP5/NIWNml8fMZvcj9H0D34Vhk0T/k/6XM=; b=RBGype5dL/KUTb42oGbk83TvcN
        v9X1Sn8Egxcei3h6+KPQRFLl7g9XJN367O57EQCQZSKsaCCww6zgPqyhwQZtj1vWCteybSrwgD25Q
        fsxpaLfy+zZYjbnrvD3u7DBrs6NglGeq6tllKQJRLCvYMjgoxN44sqC/Z3KnZxK+nyjspYboD7rJO
        UvZ2qJD7WACcIypeDdLbWl2dtdQGSkFZew3uLd4Z5Zt0w7bQNV/q405uxiJ8rEjMPw61eUtEWWBi5
        z6r2W5AjE+jawnJBTk48yrb9g8f0doyey7BUk1X/qcmm7/jYExH+bZAR/BQPUbdMj1imX8ylH1SSK
        U9EwOSSg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mhecd-004247-WF; Mon, 01 Nov 2021 21:14:00 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>
Subject: [PATCH 21/21] xfs: Support multi-page folios
Date:   Mon,  1 Nov 2021 20:39:29 +0000
Message-Id: <20211101203929.954622-22-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211101203929.954622-1-willy@infradead.org>
References: <20211101203929.954622-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Now that iomap has been converted, XFS is multi-page folio safe.
Indicate to the VFS that it can now create multi-page folios for XFS.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/xfs/xfs_icache.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/xfs/xfs_icache.c b/fs/xfs/xfs_icache.c
index f2210d927481..804507c82455 100644
--- a/fs/xfs/xfs_icache.c
+++ b/fs/xfs/xfs_icache.c
@@ -87,6 +87,7 @@ xfs_inode_alloc(
 	/* VFS doesn't initialise i_mode or i_state! */
 	VFS_I(ip)->i_mode = 0;
 	VFS_I(ip)->i_state = 0;
+	mapping_set_large_folios(VFS_I(ip)->i_mapping);
 
 	XFS_STATS_INC(mp, vn_active);
 	ASSERT(atomic_read(&ip->i_pincount) == 0);
@@ -336,6 +337,7 @@ xfs_reinit_inode(
 	inode->i_rdev = dev;
 	inode->i_uid = uid;
 	inode->i_gid = gid;
+	mapping_set_large_folios(inode->i_mapping);
 	return error;
 }
 
-- 
2.33.0

