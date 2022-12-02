Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FBA4640491
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Dec 2022 11:27:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233344AbiLBK1P (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Dec 2022 05:27:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233384AbiLBK1G (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Dec 2022 05:27:06 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71FCDCA783;
        Fri,  2 Dec 2022 02:27:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=Y5m0F6Pyvv6Ear4bOX/of/SNS6Ys875CaEmxQ7Nl5xY=; b=Dq2jBfetFtoC66mXgk3+Xi4fJB
        OTRUGmBgVVpn1WO6TuOtU0AvCG7tltCOVBprltqtRo0PhfqAR8CZlF+NoEYBsEW2Tfi23xSxmP4wd
        ZsjsuwuUAXvUD13OJKFPZDIiCzUociRfJ0XicdWQbJmVrYMpYudWbWBMrDTBmv8TSc+s2xzAHENgd
        Wr5Blr873CIIAO+BgZ/IU+xMnGLdir5vOnE2G64KSxlCvzT2SAvcP9MNleg60o6xMcFVr50vr+xOZ
        vsJs5T3nX0hj1/xsaid0ChvYBqR62W97UI9prrX8QkRtZMVWGPJvqqiD1fbD3ClunUd23iQtM9z8S
        mZnZMvXw==;
Received: from [2001:4bb8:192:26e7:bcd3:7e81:e7de:56fd] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p13Fy-00FQzp-DD; Fri, 02 Dec 2022 10:26:59 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Namjae Jeon <linkinjeon@kernel.org>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        Jan Kara <jack@suse.com>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
        Dave Kleikamp <shaggy@kernel.org>,
        Bob Copeland <me@bobcopeland.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        jfs-discussion@lists.sourceforge.net,
        linux-karma-devel@lists.sourceforge.net, linux-mm@kvack.org,
        Johannes Weiner <hannes@cmpxchg.org>
Subject: [PATCH 4/7] hfsplus: remove ->writepage
Date:   Fri,  2 Dec 2022 11:26:41 +0100
Message-Id: <20221202102644.770505-5-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221202102644.770505-1-hch@lst.de>
References: <20221202102644.770505-1-hch@lst.de>
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

->writepage is a very inefficient method to write back data, and only
used through write_cache_pages or a a fallback when no ->migrate_folio
method is present.

Set ->migrate_folio to the generic buffer_head based helper, and stop
wiring up ->writepage for hfsplus_aops.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
---
 fs/hfsplus/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/hfsplus/inode.c b/fs/hfsplus/inode.c
index aeab83ed1c9c6e..d6572ad2407a7c 100644
--- a/fs/hfsplus/inode.c
+++ b/fs/hfsplus/inode.c
@@ -170,12 +170,12 @@ const struct address_space_operations hfsplus_aops = {
 	.dirty_folio	= block_dirty_folio,
 	.invalidate_folio = block_invalidate_folio,
 	.read_folio	= hfsplus_read_folio,
-	.writepage	= hfsplus_writepage,
 	.write_begin	= hfsplus_write_begin,
 	.write_end	= generic_write_end,
 	.bmap		= hfsplus_bmap,
 	.direct_IO	= hfsplus_direct_IO,
 	.writepages	= hfsplus_writepages,
+	.migrate_folio	= buffer_migrate_folio,
 };
 
 const struct dentry_operations hfsplus_dentry_operations = {
-- 
2.30.2

