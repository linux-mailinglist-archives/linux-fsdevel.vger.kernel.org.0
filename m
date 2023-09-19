Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53C1A7A58B8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Sep 2023 06:52:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231556AbjISEv7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Sep 2023 00:51:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231560AbjISEvs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Sep 2023 00:51:48 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D916B131;
        Mon, 18 Sep 2023 21:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=oqmyw7VJeqHD8iPpgh4YPr5AogAt6MQN9sHGZpQ6Xjk=; b=E4YYIjUp3IuVjZH5MCxn9/nKpu
        Hh21HO1FgQ5l0yFuR8lBrzTKjwN77QtvHgH7HsY6/hwMfJWDY0UAh02WnRXPPElykkpAlqZmBWeIV
        eNkuj2Gp/o8PjVKAYe0nJcDm29dA61si/jGvCAX6vVu9nX7clOZR5ZJasF8aWG3RXxcK70KOAmQiS
        V/o8WI5+8jOwXUceYUQVhHOFWdoUK9g3uIL+Auum/J8H+YJYEL2+b0lOqxTCaKY/nooLebuqCi4G5
        4dUpHT0k3B87XotVNZH1TIicqqawgo16ESNqdHcj6iQv7Mn5fdND8PoDTTmUqSP6m1861PlUDEO9e
        yKKdIwGg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qiSi4-00FFlO-3N; Tue, 19 Sep 2023 04:51:40 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, gfs2@lists.linux.dev,
        linux-nilfs@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net,
        ntfs3@lists.linux.dev, ocfs2-devel@lists.linux.dev,
        reiserfs-devel@vger.kernel.org, linux-ext4@vger.kernel.org,
        Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH 15/26] nilfs2: Convert nilfs_lookup_dirty_data_buffers to use folio_create_empty_buffers
Date:   Tue, 19 Sep 2023 05:51:24 +0100
Message-Id: <20230919045135.3635437-16-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230919045135.3635437-1-willy@infradead.org>
References: <20230919045135.3635437-1-willy@infradead.org>
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

This function was already using a folio, so this update to the new API
removes a single folio->page->folio conversion.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/nilfs2/segment.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/nilfs2/segment.c b/fs/nilfs2/segment.c
index 7ec16879756e..94388fe83cf8 100644
--- a/fs/nilfs2/segment.c
+++ b/fs/nilfs2/segment.c
@@ -731,10 +731,9 @@ static size_t nilfs_lookup_dirty_data_buffers(struct inode *inode,
 			continue;
 		}
 		head = folio_buffers(folio);
-		if (!head) {
-			create_empty_buffers(&folio->page, i_blocksize(inode), 0);
-			head = folio_buffers(folio);
-		}
+		if (!head)
+			head = folio_create_empty_buffers(folio,
+					i_blocksize(inode), 0);
 		folio_unlock(folio);
 
 		bh = head;
-- 
2.40.1

