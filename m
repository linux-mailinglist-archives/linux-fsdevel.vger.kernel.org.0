Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFEB16F5B73
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 May 2023 17:45:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbjECPpe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 May 2023 11:45:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjECPpd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 May 2023 11:45:33 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2914B6E90
        for <linux-fsdevel@vger.kernel.org>; Wed,  3 May 2023 08:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=mW2o8wpFm6hEhehNQ6WUd3/Nj2LMMuEXwLrM7NwDB5M=; b=C9SjrXz1cB9MDUDnQ41YbovOs5
        v8v4FUwee2O6ZViz0eQyjwHA82AEW5YE3Mmg+0TwERHnCVsKP69+d5p3JRim/3HaNbt2qGkG91IbE
        lSnLRHl8WzF3aPqNtoTEczH/yRjodoC2HeyUevNSwyyc63yckZE8gZ4prbAab4XSZoyujzqeaHZMY
        disYO1OfRL0D6zSrYIzA8M1UbG39acrPiqVBHPObuW78QhnfXSH3GpFrG42I3N9TZffJSYCXMjbM7
        35KsQYTR70bWFutlPJYm7R6nsikVSXE6eCuq3r0Nt1mSaGbFPAXJMLqbe3Zx7ABnAIw84nyd5R+vp
        ooayhfMg==;
Received: from [2001:4bb8:181:617f:7279:c4cd:ae56:e444] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1puEfa-0050jt-2R;
        Wed, 03 May 2023 15:45:31 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     akpm@linux-foundation.org
Cc:     jack@suse.cz, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        dhowells@redhat.com, marc.dionne@auristor.com,
        linux-afs@lists.infradead.org
Subject: [PATCH 2/2] afs: fix the afs_dir_get_folio return value
Date:   Wed,  3 May 2023 17:45:26 +0200
Message-Id: <20230503154526.1223095-2-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230503154526.1223095-1-hch@lst.de>
References: <20230503154526.1223095-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Keep returning NULL on failure instead of letting an ERR_PTR escape to
callers that don't expect it.

Fixes: 66dabbb65d67 ("mm: return an ERR_PTR from __filemap_get_folio")
Reported-by: Jan Kara <jack@suse.cz>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/afs/dir_edit.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/afs/dir_edit.c b/fs/afs/dir_edit.c
index f0eddccbdd9541..e2fa577b66fe0a 100644
--- a/fs/afs/dir_edit.c
+++ b/fs/afs/dir_edit.c
@@ -115,11 +115,12 @@ static struct folio *afs_dir_get_folio(struct afs_vnode *vnode, pgoff_t index)
 	folio = __filemap_get_folio(mapping, index,
 				    FGP_LOCK | FGP_ACCESSED | FGP_CREAT,
 				    mapping->gfp_mask);
-	if (IS_ERR(folio))
+	if (IS_ERR(folio)) {
 		clear_bit(AFS_VNODE_DIR_VALID, &vnode->flags);
-	else if (folio && !folio_test_private(folio))
+		return NULL;
+	}
+	if (!folio_test_private(folio))
 		folio_attach_private(folio, (void *)1);
-
 	return folio;
 }
 
-- 
2.39.2

