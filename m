Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1410F4EC720
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Mar 2022 16:50:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347207AbiC3Ovn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Mar 2022 10:51:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347235AbiC3OvU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Mar 2022 10:51:20 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A28B7167F1
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Mar 2022 07:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=dy+A1x8FZhbeSxRhvSp5MeYNQLFk4r/anbYtjFrallI=; b=GTOIp56NHMJBnqwJ3qzG37jCXz
        aQrCi0orXrJqtCmaIkCNGYEFqbsqFVn42WfFsW8VaHWfTAFu3+HDHu8OItJjLzLicoaOxyO2Vvsih
        X3b2UF48MSB/rP+RXw8qynyO2s82e743M529QsWAPjK1X9p9dFTo2xShUF3R9f+hE79Jln0r+2AaP
        2WXCRvDrUfDuwgZLgynHqeeQwyFlmqj+WiGk2u47COA9GVOc8+W/tEpPuBC8vDDinzFl0e6B+F/nS
        tMr7ClhWmuAOXznG4VUsbfYvlahhLRFcQrqEub6CSOO7ep6leomddwr4iyMKc+H8QYZihCMUEyhUQ
        Rz1enKvA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nZZdd-001KDm-0z; Wed, 30 Mar 2022 14:49:33 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 12/12] btrfs: Remove a use of PAGE_SIZE in btrfs_invalidate_folio()
Date:   Wed, 30 Mar 2022 15:49:30 +0100
Message-Id: <20220330144930.315951-13-willy@infradead.org>
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

While btrfs doesn't use large folios yet, this should have been changed
as part of the conversion from invalidatepage to invalidate_folio.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/btrfs/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index aa0a60ee26cb..6bfc4343c98d 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -8296,7 +8296,7 @@ static void btrfs_invalidate_folio(struct folio *folio, size_t offset,
 	 * cover the full folio, like invalidating the last folio, we're
 	 * still safe to wait for ordered extent to finish.
 	 */
-	if (!(offset == 0 && length == PAGE_SIZE)) {
+	if (!(offset == 0 && length == folio_size(folio))) {
 		btrfs_releasepage(&folio->page, GFP_NOFS);
 		return;
 	}
-- 
2.34.1

