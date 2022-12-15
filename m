Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E82664E36D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Dec 2022 22:44:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbiLOVoP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Dec 2022 16:44:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbiLOVoE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Dec 2022 16:44:04 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 221755C765
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Dec 2022 13:44:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=MLGJwhDountcuCLbbenFUGHbgCYIGmLfecx3jnzH9ks=; b=pFFJ1gesuLLg195NtZTf+MZmmg
        XC25p6TNocwllfifXKh4jhgNaf/PAy0Kzym/aoho6VhDUDE9TBoduDweQ+vbsHtvwCENJjLoE5ng9
        MQUkZ/E1BUtdcfzU9vFiJqJZPHrE7F8EqoOpqoQZ0b32F4mPCiyJsVPAaM8amnSj6Odkd+oD7ZpIQ
        5AwJEn5XMxVkgrCIRToBUiWm8+zSnyzLsrf5P8RejtgvCCAYyrJEdrY7X/Bgki0cpfBXYjWSrisyC
        CYgoMxVVymFOuTJFXiN4hyMN6BRkdlblDJuiclwc3X2bCvfZSE5sE8lsQ4KIz4FVBZmbNqjunezXf
        pbF3y9Ng==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p5w1O-00EmLq-WE; Thu, 15 Dec 2022 21:44:07 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 08/12] gfs2: Replace obvious uses of b_page with b_folio
Date:   Thu, 15 Dec 2022 21:43:58 +0000
Message-Id: <20221215214402.3522366-9-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221215214402.3522366-1-willy@infradead.org>
References: <20221215214402.3522366-1-willy@infradead.org>
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

These places just use b_page to get to the buffer's address_space.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/gfs2/glops.c   | 2 +-
 fs/gfs2/log.c     | 2 +-
 fs/gfs2/meta_io.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/gfs2/glops.c b/fs/gfs2/glops.c
index d78b61ecc1cd..081422644ec5 100644
--- a/fs/gfs2/glops.c
+++ b/fs/gfs2/glops.c
@@ -39,7 +39,7 @@ static void gfs2_ail_error(struct gfs2_glock *gl, const struct buffer_head *bh)
 	       "AIL buffer %p: blocknr %llu state 0x%08lx mapping %p page "
 	       "state 0x%lx\n",
 	       bh, (unsigned long long)bh->b_blocknr, bh->b_state,
-	       bh->b_page->mapping, bh->b_page->flags);
+	       bh->b_folio->mapping, bh->b_folio->flags);
 	fs_err(sdp, "AIL glock %u:%llu mapping %p\n",
 	       gl->gl_name.ln_type, gl->gl_name.ln_number,
 	       gfs2_glock2aspace(gl));
diff --git a/fs/gfs2/log.c b/fs/gfs2/log.c
index 723639376ae2..1fcc829f02ab 100644
--- a/fs/gfs2/log.c
+++ b/fs/gfs2/log.c
@@ -127,7 +127,7 @@ __acquires(&sdp->sd_ail_lock)
 			continue;
 		gl = bd->bd_gl;
 		list_move(&bd->bd_ail_st_list, &tr->tr_ail1_list);
-		mapping = bh->b_page->mapping;
+		mapping = bh->b_folio->mapping;
 		if (!mapping)
 			continue;
 		spin_unlock(&sdp->sd_ail_lock);
diff --git a/fs/gfs2/meta_io.c b/fs/gfs2/meta_io.c
index 3c41b864ee5b..924361fa510b 100644
--- a/fs/gfs2/meta_io.c
+++ b/fs/gfs2/meta_io.c
@@ -334,7 +334,7 @@ int gfs2_meta_wait(struct gfs2_sbd *sdp, struct buffer_head *bh)
 
 void gfs2_remove_from_journal(struct buffer_head *bh, int meta)
 {
-	struct address_space *mapping = bh->b_page->mapping;
+	struct address_space *mapping = bh->b_folio->mapping;
 	struct gfs2_sbd *sdp = gfs2_mapping2sbd(mapping);
 	struct gfs2_bufdata *bd = bh->b_private;
 	struct gfs2_trans *tr = current->journal_info;
-- 
2.35.1

