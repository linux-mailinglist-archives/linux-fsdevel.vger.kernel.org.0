Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EA19288B47
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Oct 2020 16:32:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389037AbgJIOcU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Oct 2020 10:32:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388849AbgJIObL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Oct 2020 10:31:11 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02937C0613D2;
        Fri,  9 Oct 2020 07:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=8Z59nl1ynYz7T8ZQQZFooEYzqOOLn6C4o6AlvTemzR0=; b=e53+Uy/zWo55QNMz59Vn6a9Qfc
        3KNiqJ/4fxfkgBjsQQ4r2mpc73+bcP9cg17+hspZn9ShexhM2dovyqmcBMu5GaB8hA2To0wbbvBMJ
        /nlk4qgT+2ebDto7HC57yP5fJnXuCZUAXxxzEE4vVEPafRXpzNr/tQHoWRdIL4c4xof573b+opNyD
        hSsx/CG+200mJ/A6A9gJfZS+yIIsP9SVUfQbvdMxgqzXAy1DNre7fetC5eIsQUsYE4Vb2r9NUVgeu
        KUwbxXsDpGEnc6dlpYDLdcVdnQa9DE6RbCg8tEQLI01IkTcUFhfy4/FZVquDvGlMZ35Qj3kd8hE+6
        d1ybNPjg==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kQtQK-0005vJ-Ib; Fri, 09 Oct 2020 14:31:09 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, v9fs-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, linux-afs@lists.infradead.org,
        ceph-devel@vger.kernel.org, linux-cifs@vger.kernel.org,
        ecryptfs@vger.kernel.org, linux-um@lists.infradead.org,
        linux-mtd@lists.infradead.org, Richard Weinberger <richard@nod.at>,
        linux-xfs@vger.kernel.org
Subject: [PATCH v2 09/16] fuse: Tell the VFS that readpage was synchronous
Date:   Fri,  9 Oct 2020 15:30:57 +0100
Message-Id: <20201009143104.22673-10-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201009143104.22673-1-willy@infradead.org>
References: <20201009143104.22673-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The fuse readpage implementation was already synchronous, so use
AOP_UPDATED_PAGE to avoid cycling the page lock.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/fuse/file.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 6611ef3269a8..7aa5626bc582 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -850,6 +850,8 @@ static int fuse_readpage(struct file *file, struct page *page)
 
 	err = fuse_do_readpage(file, page);
 	fuse_invalidate_atime(inode);
+	if (!err)
+		return AOP_UPDATED_PAGE;
  out:
 	unlock_page(page);
 	return err;
-- 
2.28.0

