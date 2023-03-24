Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B7696C8467
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Mar 2023 19:04:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231668AbjCXSD6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Mar 2023 14:03:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232268AbjCXSC1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Mar 2023 14:02:27 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51C2DEC52;
        Fri, 24 Mar 2023 11:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=B6M8HuoWV6vZq+HMi8zcrk8fjpiDsrISnaLF7YRAHOY=; b=KvL9qXX6w7RiaracFLnGlfezyO
        YFGcVYwxZUeQJee0ZL/tcTMh2Lj6U1hftWLJjgkyQIJd5ORdxDgjB10rp0C7EocV8mcDZuU0Pe9A1
        q6lGqGWsB3/oXYcx9B+T2w+AkG6dIR6e5Onh6CssNaC06+mn3WTnIg+feeXKtCOPH5iaFayJ0VnYd
        yjMPasR7ugNpnGqWRu4rJ1epLGXRaNp4smI810C68/IFBf2P6PzPuXh5rgmjv1LKw+M6y9xYlSFr6
        LFGTSBPjnruH/7bzoRVRPQUUPK9/a/CfPsoTPi6mOIpSV1GBVgJc0InZfu7JMUpTHWh837YDjW+hT
        cxo9Da7g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pfljO-0057c3-Ki; Fri, 24 Mar 2023 18:01:38 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 28/29] ext4: Convert pagecache_read() to use a folio
Date:   Fri, 24 Mar 2023 18:01:28 +0000
Message-Id: <20230324180129.1220691-29-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230324180129.1220691-1-willy@infradead.org>
References: <20230324180129.1220691-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use the folio API and support folios of arbitrary sizes.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/ext4/verity.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/fs/ext4/verity.c b/fs/ext4/verity.c
index e4da1704438e..afe847c967a4 100644
--- a/fs/ext4/verity.c
+++ b/fs/ext4/verity.c
@@ -42,18 +42,16 @@ static int pagecache_read(struct inode *inode, void *buf, size_t count,
 			  loff_t pos)
 {
 	while (count) {
-		size_t n = min_t(size_t, count,
-				 PAGE_SIZE - offset_in_page(pos));
-		struct page *page;
+		struct folio *folio;
+		size_t n;
 
-		page = read_mapping_page(inode->i_mapping, pos >> PAGE_SHIFT,
+		folio = read_mapping_folio(inode->i_mapping, pos >> PAGE_SHIFT,
 					 NULL);
-		if (IS_ERR(page))
-			return PTR_ERR(page);
-
-		memcpy_from_page(buf, page, offset_in_page(pos), n);
+		if (IS_ERR(folio))
+			return PTR_ERR(folio);
 
-		put_page(page);
+		n = memcpy_from_file_folio(buf, folio, pos, count);
+		folio_put(folio);
 
 		buf += n;
 		pos += n;
-- 
2.39.2

