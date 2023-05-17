Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBFA4705E00
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 May 2023 05:24:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231954AbjEQDYu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 May 2023 23:24:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231691AbjEQDYs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 May 2023 23:24:48 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 431EE213E
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 May 2023 20:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=a1XCbp+iWkGqywLnM4z2nNwatMKh9R6EW0sUZgVreBU=; b=YafLASkY0sZSHHzRTHD9SiJkqO
        EGM1ibUuHNrELQ55wgd95nBxNWcgGVjZsPYmSYZ4T8YgW9ohwULhP8zFwhGZMp0C75AvWzkR82TOe
        qhF86Eo3Rn3I1r2B+g7nZTqkT7m61nXi/nIeUaoHBnWCeeX3uWamWisLpsKHkR0KHBx8CEQmBeeHu
        kfQ3XlVOXUdIs6wZlDlFJzMN1F3uKfQpbMPxUQCVvxkYZZ5HgkqwoCAkrTb9T2vRZbzZBT+Ehcu6M
        37wORMUHzmM7PKVx6R/bEZ2ABvQgOXBJImj11yLxiRm4Dv/vqqvQ1SaJJq10LVjQEJSwPI8Kn3DyO
        uBk2izMA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pz7mO-004lNC-1P; Wed, 17 May 2023 03:24:44 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        cluster-devel@redhat.com, Hannes Reinecke <hare@suse.com>,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 5/6] gfs2: Support ludicrously large folios in gfs2_trans_add_databufs()
Date:   Wed, 17 May 2023 04:24:41 +0100
Message-Id: <20230517032442.1135379-6-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230517032442.1135379-1-willy@infradead.org>
References: <20230517032442.1135379-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We may someday support folios larger than 4GB, so use a size_t for
the byte count within a folio to prevent unpleasant truncations.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/gfs2/aops.c | 2 +-
 fs/gfs2/aops.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/gfs2/aops.c b/fs/gfs2/aops.c
index e97462a5302e..8da4397aafc6 100644
--- a/fs/gfs2/aops.c
+++ b/fs/gfs2/aops.c
@@ -38,7 +38,7 @@
 
 
 void gfs2_trans_add_databufs(struct gfs2_inode *ip, struct folio *folio,
-			     unsigned int from, unsigned int len)
+			     size_t from, size_t len)
 {
 	struct buffer_head *head = folio_buffers(folio);
 	unsigned int bsize = head->b_size;
diff --git a/fs/gfs2/aops.h b/fs/gfs2/aops.h
index 09db1914425e..f08322ef41cf 100644
--- a/fs/gfs2/aops.h
+++ b/fs/gfs2/aops.h
@@ -10,6 +10,6 @@
 
 extern void adjust_fs_space(struct inode *inode);
 extern void gfs2_trans_add_databufs(struct gfs2_inode *ip, struct folio *folio,
-				    unsigned int from, unsigned int len);
+				    size_t from, size_t len);
 
 #endif /* __AOPS_DOT_H__ */
-- 
2.39.2

