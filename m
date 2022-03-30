Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA75E4EC71D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Mar 2022 16:50:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242510AbiC3Ovo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Mar 2022 10:51:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347232AbiC3OvU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Mar 2022 10:51:20 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A3D1167C8
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Mar 2022 07:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=sdNJLVXnmCIm9+m7W/zY9OYhQf+hylixBqF7bG9HL7o=; b=bxRlPu/ZNDqa84cFN4b8sQ4wF5
        3cwFqSj5HvA+XjRMSi0T8+oPdjy+hP5hq9JuADy16/Hc0uGb5O+/WTnhBOK5DuOXheiEsq1WBVV0h
        vdCuq55Gt8WJfns+PT60DwdIJBnL64q3TY9Xtt2G1FSymvI9AkOUN3fPDNa7P5xNJdYGwpoalVdWx
        0tStneGc8bWfUOBOimG/dPWBplEPX0qzeRw6TmHkOoS0Lk+eC+SPbJ81bmfzr7wcnhJbKWXO2GLnS
        W2jMxE8j6k7xMwul8taeItospKaw0VTvVXrJ5xdCChrMq0arqYE4hP4hiNGB2JVmYyKl9y+y28QJs
        I8nAudAg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nZZdc-001KDc-RH; Wed, 30 Mar 2022 14:49:32 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 10/12] f2fs: Get the superblock from the mapping instead of the page
Date:   Wed, 30 Mar 2022 15:49:28 +0100
Message-Id: <20220330144930.315951-11-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220330144930.315951-1-willy@infradead.org>
References: <20220330144930.315951-1-willy@infradead.org>
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

It's slightly more efficient to go directly from the mapping to the
superblock than to go from the page.  Now that these routines have
the mapping passed to them, there's no reason not to use it.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/f2fs/checkpoint.c | 2 +-
 fs/f2fs/node.c       | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index a8fc4fa511a8..f5366feea82d 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -456,7 +456,7 @@ static bool f2fs_dirty_meta_folio(struct address_space *mapping,
 		folio_mark_uptodate(folio);
 	if (!folio_test_dirty(folio)) {
 		filemap_dirty_folio(mapping, folio);
-		inc_page_count(F2FS_P_SB(&folio->page), F2FS_DIRTY_META);
+		inc_page_count(F2FS_M_SB(mapping), F2FS_DIRTY_META);
 		set_page_private_reference(&folio->page);
 		return true;
 	}
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 0b6e741e94a0..c45d341dcf6e 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -2146,11 +2146,11 @@ static bool f2fs_dirty_node_folio(struct address_space *mapping,
 		folio_mark_uptodate(folio);
 #ifdef CONFIG_F2FS_CHECK_FS
 	if (IS_INODE(&folio->page))
-		f2fs_inode_chksum_set(F2FS_P_SB(&folio->page), &folio->page);
+		f2fs_inode_chksum_set(F2FS_M_SB(mapping), &folio->page);
 #endif
 	if (!folio_test_dirty(folio)) {
 		filemap_dirty_folio(mapping, folio);
-		inc_page_count(F2FS_P_SB(&folio->page), F2FS_DIRTY_NODES);
+		inc_page_count(F2FS_M_SB(mapping), F2FS_DIRTY_NODES);
 		set_page_private_reference(&folio->page);
 		return true;
 	}
-- 
2.34.1

