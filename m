Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0406368886B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Feb 2023 21:44:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232992AbjBBUol (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Feb 2023 15:44:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232111AbjBBUog (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Feb 2023 15:44:36 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C76919EEA;
        Thu,  2 Feb 2023 12:44:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=3DLfbYeltsUE3NkYQxzmRoc7Gye1xXr71K3DBJBtYI8=; b=My+pp2jnzUtx0mU74aDrHBAfVv
        47t6HILhQnY1KaWUmZhAh5Wqw/ZzWZ6ELcjVHzxBAaJVU/zPNhUYV+Oyu8b8NUlzlznAT7362AF5Q
        gSQhH0el02AH+zggm7MaQts0TQfCLVs/ET3zZFTx6kLY0UFy7JiwRH5IpJXhmrrpwqnp6dChipQdC
        PEYc0G6v9HjbUwlt4SWnW8UNsQnyNapLR7lOnkWFSFia65JmJyVQlKc6deSxOSY62WoNxa79NTi5h
        pyqzpXh91k9bcb2gbuVSWm4A6vmNmeqVjxhn6iRYRNaJwId/QFcOjPBC/JShhXajsyYYE1HBY8GMI
        sUEu9Ryw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pNgRa-00Di7L-PL; Thu, 02 Feb 2023 20:44:30 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-afs@lists.infradead.org, linux-btrfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-mm@kvack.org,
        Hugh Dickins <hughd@google.com>, linux-kernel@vger.kernel.org,
        fstests@vger.kernel.org
Subject: [PATCH 1/5] truncate: Zero bytes after 'oldsize' if we're expanding the file
Date:   Thu,  2 Feb 2023 20:44:23 +0000
Message-Id: <20230202204428.3267832-2-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230202204428.3267832-1-willy@infradead.org>
References: <20230202204428.3267832-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

POSIX requires that "If the file size is increased, the extended area
shall appear as if it were zero-filled".  It is possible to use mmap to
write past EOF and that data will become visible instead of zeroes.
This fixes the problem for the filesystems which simply call
truncate_setsize().  More complex filesystems will need their own
patches.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/truncate.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/mm/truncate.c b/mm/truncate.c
index 7b4ea4c4a46b..cebfc5415e9a 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -763,9 +763,12 @@ void truncate_setsize(struct inode *inode, loff_t newsize)
 	loff_t oldsize = inode->i_size;
 
 	i_size_write(inode, newsize);
-	if (newsize > oldsize)
+	if (newsize > oldsize) {
 		pagecache_isize_extended(inode, oldsize, newsize);
-	truncate_pagecache(inode, newsize);
+		truncate_pagecache(inode, oldsize);
+	} else {
+		truncate_pagecache(inode, newsize);
+	}
 }
 EXPORT_SYMBOL(truncate_setsize);
 
-- 
2.35.1

