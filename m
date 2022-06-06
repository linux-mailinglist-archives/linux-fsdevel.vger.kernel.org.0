Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08BDA53F096
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jun 2022 22:49:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234622AbiFFUrp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Jun 2022 16:47:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233561AbiFFUrU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Jun 2022 16:47:20 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00A2928D;
        Mon,  6 Jun 2022 13:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=NFScYX57GEbw0yH/d1QXpe8YFpfaQsvuaQCT3ii6ess=; b=mDp4J3wn+JfgTBMvZgEUqjDjOc
        MdvHmectsbLkZvfTk8nG6ytXS1+4dBHiC4pMAhcy3dH+w+BngrUwTH364Opf+ULDH9RffR6xS8W1s
        NvNCsPvgWsTpdK5si++BB7gskVwFgeJKaRz9oSkBMT/tvUH1htLz8dXlAm4tajf1oQVpZT/iQpp3Z
        3qvjBqAGoN/HgsaNXSczCYJXunICX2cMGKbV8nqWYAZ1dFtuqgFYtfMpTC7xMxk50hUBGd3mZWqxV
        6hlTudv8DYvIDVhKEtAVCLpJUOSZgQOHlnJd6eZoWquUE4SD1aKFk5s64qg6Qy5XVFt9b2QyPeQP8
        VdadEfOg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nyJWy-00B19s-0v; Mon, 06 Jun 2022 20:40:56 +0000
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
Subject: [PATCH 18/20] zsmalloc: Convert to migrate_folio
Date:   Mon,  6 Jun 2022 21:40:48 +0100
Message-Id: <20220606204050.2625949-19-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220606204050.2625949-1-willy@infradead.org>
References: <20220606204050.2625949-1-willy@infradead.org>
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

zsmalloc doesn't really use folios, but it needs to be called like this
in order to migrate an individual page.  Convert from a folio back to
a page until we decide how to handle migration better for zsmalloc.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/zsmalloc.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 5d5fc04385b8..8ed79121195a 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -1865,9 +1865,11 @@ static bool zs_page_isolate(struct page *page, isolate_mode_t mode)
 	return true;
 }
 
-static int zs_page_migrate(struct address_space *mapping, struct page *newpage,
-		struct page *page, enum migrate_mode mode)
+static int zs_migrate_folio(struct address_space *mapping,
+		struct folio *dst, struct folio *src, enum migrate_mode mode)
 {
+	struct page *newpage = &dst->page;
+	struct page *page = &src->page;
 	struct zs_pool *pool;
 	struct size_class *class;
 	struct zspage *zspage;
@@ -1966,7 +1968,7 @@ static void zs_page_putback(struct page *page)
 
 static const struct address_space_operations zsmalloc_aops = {
 	.isolate_page = zs_page_isolate,
-	.migratepage = zs_page_migrate,
+	.migrate_folio = zs_migrate_folio,
 	.putback_page = zs_page_putback,
 };
 
-- 
2.35.1

