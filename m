Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39AB554364E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jun 2022 17:12:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243420AbiFHPMB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Jun 2022 11:12:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243230AbiFHPLJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Jun 2022 11:11:09 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB1223FBBE5;
        Wed,  8 Jun 2022 08:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=z93Cnt+g7bn8Rks2qPHkqYOXC3V0vuJ4otfYMlwXMI0=; b=A8DhNIxJJ669f/qkcLeDGf72ZN
        VH8LAA48msbBnAVr0E+7FelEvxIN6WeTVVsY3+XbJ3JFz8o4YxHui00x1Y70h4ocWwm1rEhwBIjKN
        KqmXwNooNqQHQTU0PGaJX9VSpy4TIudFD2m7wXi5brVUZ9sATYKFon0A8unvko2wdijgsEP55z5gw
        LICUf+6yA08O9mkZ2CoaqXjq3c6UpqxZ4JALyMMrvUsNOS/irI5NCXGs3fXnIssRB78QjoY8+rsu6
        2JldLt7koSxVP03aOcqMPx4vsCCm76xYnTTjxDObf8Wn4Fx8tpZC1OJvSXomcGoxR7FYaLBgr8kSN
        KwIQrhwQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nyxCv-00CjFm-8u; Wed, 08 Jun 2022 15:02:53 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-aio@kvack.org, linux-btrfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        cluster-devel@redhat.com, linux-mm@kvack.org,
        linux-xfs@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-ntfs-dev@lists.sourceforge.net, ocfs2-devel@oss.oracle.com,
        linux-mtd@lists.infradead.org,
        virtualization@lists.linux-foundation.org
Subject: [PATCH v2 17/19] secretmem: Convert to migrate_folio
Date:   Wed,  8 Jun 2022 16:02:47 +0100
Message-Id: <20220608150249.3033815-18-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220608150249.3033815-1-willy@infradead.org>
References: <20220608150249.3033815-1-willy@infradead.org>
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

This is little more than changing the types over; there's no real work
being done in this function.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/secretmem.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/mm/secretmem.c b/mm/secretmem.c
index 1c7f1775b56e..658a7486efa9 100644
--- a/mm/secretmem.c
+++ b/mm/secretmem.c
@@ -133,9 +133,8 @@ static const struct file_operations secretmem_fops = {
 	.mmap		= secretmem_mmap,
 };
 
-static int secretmem_migratepage(struct address_space *mapping,
-				 struct page *newpage, struct page *page,
-				 enum migrate_mode mode)
+static int secretmem_migrate_folio(struct address_space *mapping,
+		struct folio *dst, struct folio *src, enum migrate_mode mode)
 {
 	return -EBUSY;
 }
@@ -149,7 +148,7 @@ static void secretmem_free_folio(struct folio *folio)
 const struct address_space_operations secretmem_aops = {
 	.dirty_folio	= noop_dirty_folio,
 	.free_folio	= secretmem_free_folio,
-	.migratepage	= secretmem_migratepage,
+	.migrate_folio	= secretmem_migrate_folio,
 };
 
 static int secretmem_setattr(struct user_namespace *mnt_userns,
-- 
2.35.1

