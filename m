Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 658B6288B1A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Oct 2020 16:32:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388940AbgJIObu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Oct 2020 10:31:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388855AbgJIObM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Oct 2020 10:31:12 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8935CC0613D8;
        Fri,  9 Oct 2020 07:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=RIb1gQ+A64FbhPeJkfhHPdkd0Jjt6Z+sspMIve+fcDU=; b=VsE23OLOrUsnE7PhGHwfx4AvQD
        ZxkA8063qfbOb72uym0CvuEdjOdRn7oO/of7SRBBhcxjg9XTVL1ic5NG9xyRTX+fd2YtHU6noe+tR
        uEp06xjPiOqssHfOpiCZbZjqG05aMT4oOo9biqN01offaQ9iApy0o0e4MMkooCZAHQAeyjeBIDN8e
        KJorn95GK3/JkF8UaucM0gBtV/Vb6J3DVeBdt7Q6Dy7Pz7UU0qxP6J4lpYi/+bz+kDQ9hjZSAe76U
        jlZ6/O0bb9U/qtqCLSWlYuFcsp/+4PYyUSBphJDs2Y1Tzrf2WkgaY0Ow7NhEPSzbvdY53XI8klRju
        ymkLE0qQ==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kQtQL-0005vk-SX; Fri, 09 Oct 2020 14:31:09 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, v9fs-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, linux-afs@lists.infradead.org,
        ceph-devel@vger.kernel.org, linux-cifs@vger.kernel.org,
        ecryptfs@vger.kernel.org, linux-um@lists.infradead.org,
        linux-mtd@lists.infradead.org, Richard Weinberger <richard@nod.at>,
        linux-xfs@vger.kernel.org
Subject: [PATCH v2 11/16] jffs2: Tell the VFS that readpage was synchronous
Date:   Fri,  9 Oct 2020 15:30:59 +0100
Message-Id: <20201009143104.22673-12-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201009143104.22673-1-willy@infradead.org>
References: <20201009143104.22673-1-willy@infradead.org>
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

