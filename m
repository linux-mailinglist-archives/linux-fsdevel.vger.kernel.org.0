Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC85C536501
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 May 2022 17:51:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353700AbiE0PvP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 May 2022 11:51:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353656AbiE0PvB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 May 2022 11:51:01 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6E60134E3D
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 May 2022 08:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=Zo8tq/TxfJl7q8EhTtWvLm5Ur9WjdGrs5spowtCnbu0=; b=qcPSaSoXqtBX3E6xq92irx5JaP
        bPnZQYfyuQpJH5dUaAHLxgHrBf7bEaAGoJV9OgCZ5RvsINeJ4mEPBcpwg3oZ6J/V6BVm5ucCdu4H3
        yEKBxmpWLfbtRDKBSXiqQ7SMRTiceSitmxvnIcNxm38GL4drrpyzmUa6VXVk6/kWnvr0QP41+GK+5
        RTfPO+owL4U7hwQ8lz6x0pTpcB80iAwpxSanR5Kt++mnQKMEyZmMLhCPx5Q4jLkaxMzzy0r+VlSCm
        c1WRE4pXThYYcb14d+EsOIYwAGVz1USFd8CXkYheq/ok3DwifdRlz4wCxsqFx1eTvQeZ4FC22MO+E
        DWv8pAKQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nucEa-002CWS-IY; Fri, 27 May 2022 15:50:40 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-mm@kvack.org
Subject: [PATCH 04/24] gfs: Check PageUptodate instead of PageError
Date:   Fri, 27 May 2022 16:50:16 +0100
Message-Id: <20220527155036.524743-5-willy@infradead.org>
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

This is the correct flag to test to know if the read completed
successfully.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/gfs2/lops.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/gfs2/lops.c b/fs/gfs2/lops.c
index 6ba51cbb94cf..9a9a35d68bd5 100644
--- a/fs/gfs2/lops.c
+++ b/fs/gfs2/lops.c
@@ -474,7 +474,7 @@ static void gfs2_jhead_process_page(struct gfs2_jdesc *jd, unsigned long index,
 	page = find_get_page(jd->jd_inode->i_mapping, index);
 	wait_on_page_locked(page);
 
-	if (PageError(page))
+	if (!PageUptodate(page))
 		*done = true;
 
 	if (!*done)
-- 
2.34.1

