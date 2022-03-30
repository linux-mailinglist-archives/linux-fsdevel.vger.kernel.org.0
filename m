Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 325D84EC71B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Mar 2022 16:50:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347205AbiC3Ovi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Mar 2022 10:51:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347230AbiC3OvU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Mar 2022 10:51:20 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A0F3165BA
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Mar 2022 07:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=Du7er3T4fmYII2G6Qs67pjFE/luLJzuvuGaqRCGO83U=; b=UCsMtjonwAx8zEFxlkTjZPdpj0
        f8y+ZdL1swVnIKrdNx48pZ8JTsBJkJpaalpOk5kaB2NyLhY6QB/SzA2ZtlEe8JSs6fQLjazXFCR0n
        DBmMQVbqT6GYsBRInVROvGjgShLuaw92ytJODUQHKormcb/ZmypcKUp/6OYKP9UBcIDwL1a0rKaxQ
        RsvvVSGzKO2zDsyeXH19kL+2urwYDNJKZEpCtq4ak2im979twEmLiRc1WrPaEWlI/pFvlc2nh1KDI
        80o13S3zghdOlMsRjVozIyLictxLKCU7EArXwDqXg79JvsUw62i7Rtve3tkXbXURRVA+NHiE2vnGU
        PBSvU1SQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nZZdc-001KDX-NT; Wed, 30 Mar 2022 14:49:32 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 09/12] f2fs: Correct f2fs_dirty_data_folio() conversion
Date:   Wed, 30 Mar 2022 15:49:27 +0100
Message-Id: <20220330144930.315951-10-willy@infradead.org>
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

I got the return value wrong.  Very little checks the return value
from set_page_dirty(), so nobody noticed during testing.

Fixes: 4f5e34f71318 ("f2fs: Convert f2fs_set_data_page_dirty to f2fs_dirty_data_folio")
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/f2fs/data.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index c92920c8661d..8e0c2e773c8d 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -3571,7 +3571,7 @@ static bool f2fs_dirty_data_folio(struct address_space *mapping,
 		f2fs_update_dirty_folio(inode, folio);
 		return true;
 	}
-	return true;
+	return false;
 }
 
 
-- 
2.34.1

