Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 584C84EC70E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Mar 2022 16:49:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347244AbiC3OvX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Mar 2022 10:51:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347227AbiC3OvU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Mar 2022 10:51:20 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25FBB1659D
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Mar 2022 07:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=FaFGVxtgK1E/sJvMYJGd0rZ7p4RxhEyFAijsERRfFQ4=; b=l6N/OYvsYis2xLpzDXE/wYpqa9
        53u40oFKP5o6ADOqVbHcTSsVUcVEzYPcohYRGEWRWjToRM4UvDzbm+6wdU3p9YmpnGbHQt1QmxnIA
        FxUfpvJijUHHJvH//XpTlbxPdmk42r4FDuLTJSljC1i9+phiP1JbJ5fJi7X2Kgn+lly+5iThedUX1
        UiMBGRc0MidqIHJ2VHkTkrvTvoU/r7riYwmegc9M3qDpqxWB4okO2545++jdTgMc+nv+QKwY3fFrD
        l/bZGG2R4a5icPrhdOzGBdL3MyRbSupDf/c5J885pdoy9VsbhZ7p/1bbxyxgGWAiVVXqfOVEzEjJg
        aCUikeaQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nZZdc-001KDM-Fc; Wed, 30 Mar 2022 14:49:32 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 07/12] filemap: Remove AOP_FLAG_CONT_EXPAND
Date:   Wed, 30 Mar 2022 15:49:25 +0100
Message-Id: <20220330144930.315951-8-willy@infradead.org>
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

This flag is no longer used, so remove it.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/buffer.c        | 3 +--
 include/linux/fs.h | 1 -
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index d67fbe063a3a..2b5561ae5d0b 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -2352,8 +2352,7 @@ int generic_cont_expand_simple(struct inode *inode, loff_t size)
 	if (err)
 		goto out;
 
-	err = pagecache_write_begin(NULL, mapping, size, 0,
-				    AOP_FLAG_CONT_EXPAND, &page, &fsdata);
+	err = pagecache_write_begin(NULL, mapping, size, 0, 0, &page, &fsdata);
 	if (err)
 		goto out;
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 468dc7ec821f..bbde95387a23 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -275,7 +275,6 @@ enum positive_aop_returns {
 	AOP_TRUNCATED_PAGE	= 0x80001,
 };
 
-#define AOP_FLAG_CONT_EXPAND		0x0001 /* called from cont_expand */
 #define AOP_FLAG_NOFS			0x0002 /* used by filesystem to direct
 						* helper code (eg buffer layer)
 						* to clear GFP_FS from alloc */
-- 
2.34.1

