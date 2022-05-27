Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2AF85364E9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 May 2022 17:50:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345868AbiE0Pup (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 May 2022 11:50:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238323AbiE0Puo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 May 2022 11:50:44 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B188F134E11
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 May 2022 08:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=ZlD1f57qhy3ShckNt2ffGbjpwicKrzxeuKEcj2HaQLE=; b=J7MR+u6/CPeU1QJ0awNd2gCTAB
        AnARRGIoWkbN6QR3J2/xC7547fBeLMrTXQnDjTsUuZJ3FoF/pUx64CyHQ8b5ydP+Xqv/4II8sLx3+
        UjwMCWgnjJeVZjS1qeHVgcjOV+IQn0/6CekxY1w6DdvgK8C05LBEyaU+MsaPy13s827NUme5mx850
        PSntvqp8bh6ydbalKBDkUjvnbqKpXhTRLcgy5sVs60DIcQsbHqygLyKi5Mv97EnWmGNQhVvQmnQg8
        Ip71oOQPUv5eHF5vSCHpAAjugNvTw16AxuZzKjwrkpRujX0OX1XEPu3luDMAl6rVFBp42CwuqaCkk
        2Jp5ybVg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nucEa-002CWO-Cb; Fri, 27 May 2022 15:50:40 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-mm@kvack.org
Subject: [PATCH 02/24] afs: Remove check of PageError
Date:   Fri, 27 May 2022 16:50:14 +0100
Message-Id: <20220527155036.524743-3-willy@infradead.org>
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
 fs/afs/mntpt.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/fs/afs/mntpt.c b/fs/afs/mntpt.c
index bbb2c210d139..97f50e9fd9eb 100644
--- a/fs/afs/mntpt.c
+++ b/fs/afs/mntpt.c
@@ -132,12 +132,6 @@ static int afs_mntpt_set_params(struct fs_context *fc, struct dentry *mntpt)
 		if (IS_ERR(page))
 			return PTR_ERR(page);
 
-		if (PageError(page)) {
-			ret = afs_bad(AFS_FS_I(d_inode(mntpt)), afs_file_error_mntpt);
-			put_page(page);
-			return ret;
-		}
-
 		buf = kmap(page);
 		ret = -EINVAL;
 		if (buf[size - 1] == '.')
-- 
2.34.1

