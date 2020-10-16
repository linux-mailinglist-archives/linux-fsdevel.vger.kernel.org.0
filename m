Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A14E290937
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Oct 2020 18:04:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410582AbgJPQE6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Oct 2020 12:04:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2410451AbgJPQE4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Oct 2020 12:04:56 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4499C0613D9
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Oct 2020 09:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=8Z59nl1ynYz7T8ZQQZFooEYzqOOLn6C4o6AlvTemzR0=; b=VKzvsqrAbJg0tQ9ROwsB31xWNf
        qgxaR8fKiaD1Wkm330KV7rVJway6sxpGg9dVl+3mcRIU5minylJtmi4maTxqaRPSujiVUMdTrAJ4l
        GfP9KVWBMVU+mbH2hZeCeI1XY7jSV0BxCQewFEY9Yce6fLX/Oi+UtM/P9qED3nv3n+34rMWn0dye2
        SF1bqMapNAJf1XSzZ0iz9Qe0huNcFIk8MDeT7QlspqB+WOxSuO58c8CvcfZr5zfnw+kfg97ku9thn
        k8i4ct4Uscjp2Cp8hlpz4V3s0OxnweF+G48RAC2ipPEgFWrs5izVEhlZHgi1SLtsmmjAOYAESHvC5
        e775gLhA==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kTSDo-0004tj-MX; Fri, 16 Oct 2020 16:04:48 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, Miklos Szeredi <miklos@szeredi.hu>
Subject: [PATCH v3 13/18] fuse: Tell the VFS that readpage was synchronous
Date:   Fri, 16 Oct 2020 17:04:38 +0100
Message-Id: <20201016160443.18685-14-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201016160443.18685-1-willy@infradead.org>
References: <20201016160443.18685-1-willy@infradead.org>
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

