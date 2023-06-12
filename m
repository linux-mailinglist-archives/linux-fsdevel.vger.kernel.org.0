Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53AEA72D180
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jun 2023 23:06:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234891AbjFLVGQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jun 2023 17:06:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233586AbjFLVFg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jun 2023 17:05:36 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3686E4492
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Jun 2023 14:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=vAFZSL3nTXFwL8IPdl3K3J/1oPVBjzs/oCIJOb/JvBA=; b=vwxY0AjGvku632qBf24IhNVh5p
        0n6X8XUWEZ8bjD+dtkLhshoYdiupkPYoBepWZrTXmPEeRdTg8PlJDMystMLMzv2lCqhkkgllLJBAS
        z+cN+nLu2BpfeSew2Q98WYQ24SssiqxcPFkBTTLGmmMI4P7k/YeNzegM0MMwPaGcNYr2jw3S+v4Kd
        yUYa0uCQQo1C/5efs7v7uEnTrJs2CkVddp8xsht3nlKV/HF7qa8e+UZZaYHaTUezBrSPY463EbfFW
        SFZj2+Xl8YsH/lZfI9gs7xwFbK6ONnPvwJwiyS9e87tR5lt5V5WYP8vS/R2fbD04escYc3Fdb2UUh
        UGiEpVig==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q8ofX-0033wm-Ah; Mon, 12 Jun 2023 21:01:43 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        cluster-devel@redhat.com, Hannes Reinecke <hare@suse.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Bob Peterson <rpeterso@redhat.com>
Subject: [PATCH v3 05/14] gfs2: Support ludicrously large folios in gfs2_trans_add_databufs()
Date:   Mon, 12 Jun 2023 22:01:32 +0100
Message-Id: <20230612210141.730128-6-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230612210141.730128-1-willy@infradead.org>
References: <20230612210141.730128-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We may someday support folios larger than 4GB, so use a size_t for
the byte count within a folio to prevent unpleasant truncations.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Tested-by: Bob Peterson <rpeterso@redhat.com>
Reviewed-by: Bob Peterson <rpeterso@redhat.com>
---
 fs/gfs2/aops.c | 6 +++---
 fs/gfs2/aops.h | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/gfs2/aops.c b/fs/gfs2/aops.c
index 3a2be1901e1e..1c407eba1e30 100644
--- a/fs/gfs2/aops.c
+++ b/fs/gfs2/aops.c
@@ -38,13 +38,13 @@
 
 
 void gfs2_trans_add_databufs(struct gfs2_inode *ip, struct folio *folio,
-			     unsigned int from, unsigned int len)
+			     size_t from, size_t len)
 {
 	struct buffer_head *head = folio_buffers(folio);
 	unsigned int bsize = head->b_size;
 	struct buffer_head *bh;
-	unsigned int to = from + len;
-	unsigned int start, end;
+	size_t to = from + len;
+	size_t start, end;
 
 	for (bh = head, start = 0; bh != head || !start;
 	     bh = bh->b_this_page, start = end) {
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

