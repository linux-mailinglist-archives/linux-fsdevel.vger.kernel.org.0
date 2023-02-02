Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EA3B688878
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Feb 2023 21:45:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233057AbjBBUov (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Feb 2023 15:44:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232841AbjBBUof (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Feb 2023 15:44:35 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6DAC76AB;
        Thu,  2 Feb 2023 12:44:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=74nszHLks+AFGqdfRGx6vNnWqXDqZ9xHI0qBKa9QcdI=; b=Bh63M/0nqGUZZvEkwrwA6JtjLg
        6o8uQmpPAbwbDBcLTYskUV04rtjVxAbkRI8ywM/Cpg4QgkiduK6adIw3ab64Pf5IMVgLHdPjVDTBl
        aFg3fWxnpxmnDgfKBu03xsCHOnK4kcN7ZNcdNL6rFyRosOEDWxJ2OH3HyqGJPOB9okC+kK4RFv5JW
        x710OIFndtSvYOt8aghfbiSUMaoLwhFO3gM1DyXoahA8R0FHcoR780FR7VUl6VjqZywykxzxsTZsT
        z7NGee99rYn2z4rassj8Q+UR5edf87SIIhF/tDMjeQicVliVbhgeiEiraaTJYPSgPnMq8cG0Ud4/t
        ULWEZsfQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pNgRb-00Di7d-Ga; Thu, 02 Feb 2023 20:44:31 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-afs@lists.infradead.org, linux-btrfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-mm@kvack.org,
        Hugh Dickins <hughd@google.com>, linux-kernel@vger.kernel.org,
        fstests@vger.kernel.org
Subject: [PATCH 4/5] afs: Zero bytes after 'oldsize' if we're expanding the file
Date:   Thu,  2 Feb 2023 20:44:26 +0000
Message-Id: <20230202204428.3267832-5-willy@infradead.org>
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
 fs/afs/inode.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/afs/inode.c b/fs/afs/inode.c
index 6d3a3dbe4928..92e2ba7625de 100644
--- a/fs/afs/inode.c
+++ b/fs/afs/inode.c
@@ -854,6 +854,8 @@ static void afs_setattr_edit_file(struct afs_operation *op)
 
 		if (size < i_size)
 			truncate_pagecache(inode, size);
+		else
+			truncate_pagecache(inode, i_size);
 		if (size != i_size)
 			fscache_resize_cookie(afs_vnode_cache(vp->vnode),
 					      vp->scb.status.size);
-- 
2.35.1

