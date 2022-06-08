Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0C7B543688
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jun 2022 17:13:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243955AbiFHPNB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Jun 2022 11:13:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242262AbiFHPLj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Jun 2022 11:11:39 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F46649AC05;
        Wed,  8 Jun 2022 08:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=rXRIRcK5aBVZ2wBOi68suVknWfPexbmGif0IEKfZsbs=; b=lsRn9gaO5tAEYD/OWJOs5+zBTI
        NCwTDYynMk1lnd9OTbJ4EfJRYdVl+3dODL7tzXJVPHXM+7SlQHXOVlUsUboFXhSdXz3aSmA3UKZ6F
        L5v7sh+GECC4njYbIAGlnHpfB8UwcWrwo0wyP4BhZlRei7kEvvdyW2VaiPkXgO55R9kKQgx/YjEqw
        tYFIlMpDyJj5vqIZK5lcNkMFc7QTZ02ItadvJCgbfwAGx5UGipfrdrSUQujOmia2pjwzdNOAWZ616
        V6c9pTOiEz7pLpSwn0iaK2fRQggU3GplOvlDyjFYnosAScOy2AdneQp1BzdO4NPq9SyDvONshsH4r
        X68Lp0aw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nyxCt-00CjFG-OC; Wed, 08 Jun 2022 15:02:51 +0000
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
Subject: [PATCH v2 01/19] secretmem: Remove isolate_page
Date:   Wed,  8 Jun 2022 16:02:31 +0100
Message-Id: <20220608150249.3033815-2-willy@infradead.org>
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

The isolate_page operation is never called for filesystems, only
for device drivers which call SetPageMovable.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/secretmem.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/mm/secretmem.c b/mm/secretmem.c
index 206ed6b40c1d..1c7f1775b56e 100644
--- a/mm/secretmem.c
+++ b/mm/secretmem.c
@@ -133,11 +133,6 @@ static const struct file_operations secretmem_fops = {
 	.mmap		= secretmem_mmap,
 };
 
-static bool secretmem_isolate_page(struct page *page, isolate_mode_t mode)
-{
-	return false;
-}
-
 static int secretmem_migratepage(struct address_space *mapping,
 				 struct page *newpage, struct page *page,
 				 enum migrate_mode mode)
@@ -155,7 +150,6 @@ const struct address_space_operations secretmem_aops = {
 	.dirty_folio	= noop_dirty_folio,
 	.free_folio	= secretmem_free_folio,
 	.migratepage	= secretmem_migratepage,
-	.isolate_page	= secretmem_isolate_page,
 };
 
 static int secretmem_setattr(struct user_namespace *mnt_userns,
-- 
2.35.1

