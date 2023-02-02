Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA471688872
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Feb 2023 21:44:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232902AbjBBUog (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Feb 2023 15:44:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbjBBUof (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Feb 2023 15:44:35 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C73128A43;
        Thu,  2 Feb 2023 12:44:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=EKEz4nt5nAILCQ0WhorvddY3Ohu5ukrqmYNOFRKi6c4=; b=GX1QllwrfhDN5IKVNAciO3qEvo
        z1zvwuCrdT1EFPb+2uaPsl1XDsVWPvzn1FMeJ0+uKpjTftB94HKpr9d9x2074LhVEQcw+hsfCA4Ah
        s0I0YoFtRcRZl1R//0GffZdIIGKtEY0+gAXCMMK0Mm9Ix40T/P2zrT8FUsuOIUPpX32dwL6SOxTnF
        gk//hnp9hqX5Yqrk1rLBCmuZ4pue3Y9IMSfFWn25PJEwgpTvGYpLCzE5iewZvsAyqxTGcrgxzqePp
        RKnecjNgS+kjWIwJOXmaxQBJ1Iao/OKNm8LAHXcXxtyy6p30R/c2HxpHN4V3gsFGa6jwPx5TOr/eO
        tKTST7YQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pNgRb-00Di7j-LB; Thu, 02 Feb 2023 20:44:31 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-afs@lists.infradead.org, linux-btrfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-mm@kvack.org,
        Hugh Dickins <hughd@google.com>, linux-kernel@vger.kernel.org,
        fstests@vger.kernel.org
Subject: [PATCH 5/5] btrfs: Zero bytes after 'oldsize' if we're expanding the file
Date:   Thu,  2 Feb 2023 20:44:27 +0000
Message-Id: <20230202204428.3267832-6-willy@infradead.org>
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

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/btrfs/inode.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 98a800b8bd43..b61ec4bb9cf0 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -5234,6 +5234,7 @@ static int btrfs_setsize(struct inode *inode, struct iattr *attr)
 		i_size_write(inode, newsize);
 		btrfs_inode_safe_disk_i_size_write(BTRFS_I(inode), 0);
 		pagecache_isize_extended(inode, oldsize, newsize);
+		truncate_pagecache(inode, oldsize);
 		ret = btrfs_update_inode(trans, root, BTRFS_I(inode));
 		btrfs_drew_write_unlock(&root->snapshot_lock);
 		btrfs_end_transaction(trans);
-- 
2.35.1

