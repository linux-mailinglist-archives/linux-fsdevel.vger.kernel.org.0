Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60E9A29093F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Oct 2020 18:05:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410586AbgJPQFC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Oct 2020 12:05:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2410449AbgJPQE4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Oct 2020 12:04:56 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39863C0613DC
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Oct 2020 09:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=RIb1gQ+A64FbhPeJkfhHPdkd0Jjt6Z+sspMIve+fcDU=; b=AiN8O30nX1Xh94dtQLONe6ZbPo
        EfL5BK99q8txR6km8OOf0FAUJaPZNALukDb1OsBhAbGCPKtvSCFbE2O8X2iZcdWepXLAGJGeTqs9b
        rnHZ2y8XFjHk4ldssT7Dindm6f8kCforWbww/iJKSQ+jYo8FY4U1Y0edmInRqBRAl1n82/vBWLrD3
        Elxb5/ogPNTKM5bIbYPr0IbxVTvmWqiuUqej6n0Z2LopNSa/6mudZNaEJj7HePZ1cHvDvJlz/I2/h
        sk8sZZoCSGAwDOEqiHgBFYfS/Wav2fl4DO478/rlJWDjnqQChnTnzUlt+RRFkauVkOnOw7r6JKcLw
        Jsj1vOLw==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kTSDq-0004u3-4N; Fri, 16 Oct 2020 16:04:50 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, Richard Weinberger <richard@nod.at>
Subject: [PATCH v3 15/18] jffs2: Tell the VFS that readpage was synchronous
Date:   Fri, 16 Oct 2020 17:04:40 +0100
Message-Id: <20201016160443.18685-16-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201016160443.18685-1-willy@infradead.org>
References: <20201016160443.18685-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The jffs2 readpage implementation was already synchronous, so use
AOP_UPDATED_PAGE to avoid cycling the page lock.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Acked-by: Richard Weinberger <richard@nod.at>
---
 fs/jffs2/file.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/jffs2/file.c b/fs/jffs2/file.c
index f8fb89b10227..959a74027041 100644
--- a/fs/jffs2/file.c
+++ b/fs/jffs2/file.c
@@ -116,15 +116,17 @@ int jffs2_do_readpage_unlock(void *data, struct page *pg)
 	return ret;
 }
 
-
 static int jffs2_readpage (struct file *filp, struct page *pg)
 {
 	struct jffs2_inode_info *f = JFFS2_INODE_INFO(pg->mapping->host);
 	int ret;
 
 	mutex_lock(&f->sem);
-	ret = jffs2_do_readpage_unlock(pg->mapping->host, pg);
+	ret = jffs2_do_readpage_nolock(pg->mapping->host, pg);
 	mutex_unlock(&f->sem);
+	if (!ret)
+		return AOP_UPDATED_PAGE;
+	unlock_page(pg);
 	return ret;
 }
 
-- 
2.28.0

