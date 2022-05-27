Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F35EA5364FB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 May 2022 17:51:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353685AbiE0PvM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 May 2022 11:51:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348364AbiE0Pu4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 May 2022 11:50:56 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A62D4134E2C
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 May 2022 08:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=c2PSGU+T+5Ia0BRl8u+GB44oYmq/DVLwd9sUaj+DKts=; b=Dtw+Y2W54adVVz09SgjOgFLZbE
        mHr9LwsCSZX8Rv4Hgp3W4bRTC7UEMlY/zEwB4EmXZpUeCjrnmofa3ZsXC+oRQhpkRQnqxz6W/YvhC
        fNHFp43Y/erGNEmOIbs35QRm+bHocoGboYyxWwq6FAnIq9PNmBing0Xw1m7mWx5OLWuWnZ56FuwFF
        4tkdXa01YWebNMyzsQfpV4Rnkmn0Cn42tpopfJLOs3lxyCXm1qROnXbBE6wxqX/yQF7sjnQF0jeW2
        aLj/yCwdh/PDEFjTOEpmdgdlN6XZMfwbfnu+RoTwxr/2F2WImuCUpt7xdTMZOl99gcalmjtVKFJtj
        5MAC+wGw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nucEb-002CWg-2I; Fri, 27 May 2022 15:50:41 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-mm@kvack.org
Subject: [PATCH 11/24] ntfs3: Remove check for PageError
Date:   Fri, 27 May 2022 16:50:23 +0100
Message-Id: <20220527155036.524743-12-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220527155036.524743-1-willy@infradead.org>
References: <20220527155036.524743-1-willy@infradead.org>
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

If read_mapping_page() encounters an error, it returns an errno, not a
page with PageError set, so this is dead code.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/ntfs3/ntfs_fs.h | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/fs/ntfs3/ntfs_fs.h b/fs/ntfs3/ntfs_fs.h
index 8de129a6419b..f28726c4e845 100644
--- a/fs/ntfs3/ntfs_fs.h
+++ b/fs/ntfs3/ntfs_fs.h
@@ -896,13 +896,8 @@ static inline struct page *ntfs_map_page(struct address_space *mapping,
 {
 	struct page *page = read_mapping_page(mapping, index, NULL);
 
-	if (!IS_ERR(page)) {
+	if (!IS_ERR(page))
 		kmap(page);
-		if (!PageError(page))
-			return page;
-		ntfs_unmap_page(page);
-		return ERR_PTR(-EIO);
-	}
 	return page;
 }
 
-- 
2.34.1

