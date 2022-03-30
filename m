Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 113EF4EC714
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Mar 2022 16:49:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347286AbiC3Ovj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Mar 2022 10:51:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347229AbiC3OvU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Mar 2022 10:51:20 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 434E9165AF
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Mar 2022 07:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=PofzwREszAZozqZtvCz84uhAROu+c7m8UV9ODgYJS/w=; b=OJHukzsvPvOhcUtFkEdv97aAwO
        SsFdb4WBpLXfm5YxxjyrxYMIQ/bQUGeOlMHtjsN02hEmg9aINorASid0s3LrHbwSQPeLGL7vbrEqr
        xTPhr8YZHAGqno7gX7wZqsgvvbMqHlNo4rhHc0Sdc2DCm2r8PkS9i9Gx0rBCIGD+yL7tmWmY2dKdH
        ClomG+FiRVtpm/evw92N19NTWvKoUOw8gMMnsMeVT6lOn4VsMqAm3w5p1qt4S78iE/RGPmKfZKjwe
        xyjUbapV2bgKKf4TZZC4AAHCB44nyv5NY4yz4PWFoaBLl4zrbej56GeSPI++LhbUuVhOLooujZ19R
        DXXaSqHQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nZZdc-001KDO-Hn; Wed, 30 Mar 2022 14:49:32 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 08/12] ext4: Correct ext4_journalled_dirty_folio() conversion
Date:   Wed, 30 Mar 2022 15:49:26 +0100
Message-Id: <20220330144930.315951-9-willy@infradead.org>
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

This should use the new folio_buffers() instead of page_has_buffers().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/ext4/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 1ce13f69fbec..13740f2d0e61 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3589,7 +3589,7 @@ const struct iomap_ops ext4_iomap_report_ops = {
 static bool ext4_journalled_dirty_folio(struct address_space *mapping,
 		struct folio *folio)
 {
-	WARN_ON_ONCE(!page_has_buffers(&folio->page));
+	WARN_ON_ONCE(!folio_buffers(folio));
 	folio_set_checked(folio);
 	return filemap_dirty_folio(mapping, folio);
 }
-- 
2.34.1

