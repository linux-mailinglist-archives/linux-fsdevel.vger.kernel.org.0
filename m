Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 526461D4EF8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 May 2020 15:19:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727939AbgEONSd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 May 2020 09:18:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726504AbgEONRC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 May 2020 09:17:02 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3B53C05BD14;
        Fri, 15 May 2020 06:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=kctqXUEbJSGFBp0C69mEnvf8pEF/klfm+B94fnKg93s=; b=d3TlqHTkAswFZfqcMcnOBrAtFy
        ydFcG62k4wBoE9MXlHZ2NzoIr8zn+7WFMkvyBsVxDZ9n0F/MGaVcbT5URv3sA6ulIlTxPhxx4ZAak
        gFhkiyoH9FD7bX2gbC2tHWw+Rlpb7eFcpiYhsSMpV3qk08Dv0eba2X4pFnaPdBEfQdtJYfZ01gjJs
        j16uubH7x6x0Jo0U1rYtpbM7SWw6XAaNoxWdjD94vdSpzvwjjzGXBpZeM2Vj90ilf43ThwX1yVrt4
        bwkbpJp9aIatFjbEGLb8/Jin+oh19QOh4dvbMH2jPPfzzi7rHb+XJNpX7f/igRlSbeJcQApR9tCwl
        D5o/JxKw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jZaCz-0005fw-Mb; Fri, 15 May 2020 13:17:01 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 18/36] iomap: Handle tail pages in iomap_page_mkwrite
Date:   Fri, 15 May 2020 06:16:38 -0700
Message-Id: <20200515131656.12890-19-willy@infradead.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200515131656.12890-1-willy@infradead.org>
References: <20200515131656.12890-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

iomap_page_mkwrite() can be called with a tail page.  If we are,
operate on the head page, since we're treating the entire thing as a
single unit and the whole page is dirtied at the same time.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/iomap/buffered-io.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 782757258a28..c9636d55a4be 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1060,7 +1060,7 @@ iomap_page_mkwrite_actor(struct inode *inode, loff_t pos, loff_t length,
 
 vm_fault_t iomap_page_mkwrite(struct vm_fault *vmf, const struct iomap_ops *ops)
 {
-	struct page *page = vmf->page;
+	struct page *page = compound_head(vmf->page);
 	struct inode *inode = file_inode(vmf->vma->vm_file);
 	unsigned long length;
 	loff_t offset;
-- 
2.26.2

