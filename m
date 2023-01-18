Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22172671927
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jan 2023 11:40:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230222AbjARKke (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Jan 2023 05:40:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230214AbjARKkJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Jan 2023 05:40:09 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C460C4E87;
        Wed, 18 Jan 2023 01:44:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=4WwjtPTvg3dbfLBE9vX5iRJAtphGCEZEkdJLVGyAJuo=; b=U8yFVdeBOBI3AACbEFkiQ4355D
        kLv+LRYHlKEtA4P6BWETKJS4fAVkK8iUpRlBVj9bR3Z5JxNdzQrN7aBF2SXwp2ePM5gNif1cFI7cL
        DyUfxGZQ28zOPddZXEXlOfBeZcxkQhHcv1emVkZOzOmdX02aeXOEB1DkUHEQ2/7g4XZ+Fmx9l3UHI
        YMGHla2dEMTRRR/zKlZBZvvUFGurgIdckmw7tTsDDGQdh7vK99tqsGnmvLAIuksqS+qEGzkmWqgtR
        +53as9e9nNgosns1KccGTJVaRfjXJygIT64MdzQBaIAoGVFyt2ILegAxzv+cBLG4sjOlhTtqe7jpE
        HXxflEVw==;
Received: from 213-147-167-250.nat.highway.webapn.at ([213.147.167.250] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pI4zI-000A8d-6U; Wed, 18 Jan 2023 09:44:09 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Hugh Dickins <hughd@google.com>
Cc:     linux-afs@lists.infradead.org, linux-btrfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, cluster-devel@redhat.com,
        linux-mm@kvack.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-nilfs@vger.kernel.org
Subject: [PATCH 7/9] gfs2: handle a NULL folio in gfs2_jhead_process_page
Date:   Wed, 18 Jan 2023 10:43:27 +0100
Message-Id: <20230118094329.9553-8-hch@lst.de>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230118094329.9553-1-hch@lst.de>
References: <20230118094329.9553-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

filemap_get_folio can return NULL, so exit early for that case.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/gfs2/lops.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/gfs2/lops.c b/fs/gfs2/lops.c
index 1902413d5d123e..51d4b610127cdb 100644
--- a/fs/gfs2/lops.c
+++ b/fs/gfs2/lops.c
@@ -472,6 +472,8 @@ static void gfs2_jhead_process_page(struct gfs2_jdesc *jd, unsigned long index,
 	struct folio *folio;
 
 	folio = filemap_get_folio(jd->jd_inode->i_mapping, index);
+	if (!folio)
+		return;
 
 	folio_wait_locked(folio);
 	if (folio_test_error(folio))
-- 
2.39.0

