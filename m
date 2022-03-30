Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB20B4EC71A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Mar 2022 16:50:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347197AbiC3Ovm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Mar 2022 10:51:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347213AbiC3OvU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Mar 2022 10:51:20 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BBED167EB
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Mar 2022 07:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=HcrmNzkk2/XPBDWqWwwo1O5YC5HQWNgwfieizv8VXjE=; b=lXNaQai6XCnY/gNvlqEGzzfNKh
        JINFsb7UHuT1tMC6MmbdKxdB1m3FfZCFGvk9ZWoS69/Anb2o50NtUq8wx4D6ik8u3jAVlP7FJEzCa
        oUxZpNwfk36r5NWvooKsisQUDjSbhzkbJ/aYYHJH/rHDOL+xBtKSyE6xJiyFGiFzn/F5faX8ASFhJ
        pOrgS7h9SLVD1AUHqquyICej85f1Y8J/P8MxVDadVtpPog970N/iYJodyI6z+mErqljUwxcioo8tS
        1inyVZaRNNwBxPllTqOCM/FVTfINaigkSu/P2P7qZvfaD0iogJgnzE2MIrE/bHvbazbfX7kdaOBJk
        m4VD2+IQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nZZdc-001KDh-Un; Wed, 30 Mar 2022 14:49:32 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 11/12] ntfs: Correct mark_ntfs_record_dirty() folio conversion
Date:   Wed, 30 Mar 2022 15:49:29 +0100
Message-Id: <20220330144930.315951-12-willy@infradead.org>
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

We've already done the work of block_dirty_folio() here, leaving
only the work that needs to be done by filemap_dirty_folio().
This was a misconversion where I misread __set_page_dirty_nobuffers()
as __set_page_dirty_buffers().

Fixes: e621900ad28b ("fs: Convert __set_page_dirty_buffers to block_dirty_folio")
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/ntfs/aops.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ntfs/aops.c b/fs/ntfs/aops.c
index d154dcfe06af..90e3dad8ee45 100644
--- a/fs/ntfs/aops.c
+++ b/fs/ntfs/aops.c
@@ -1746,7 +1746,7 @@ void mark_ntfs_record_dirty(struct page *page, const unsigned int ofs) {
 		set_buffer_dirty(bh);
 	} while ((bh = bh->b_this_page) != head);
 	spin_unlock(&mapping->private_lock);
-	block_dirty_folio(mapping, page_folio(page));
+	filemap_dirty_folio(mapping, page_folio(page));
 	if (unlikely(buffers_to_free)) {
 		do {
 			bh = buffers_to_free->b_this_page;
-- 
2.34.1

