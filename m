Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2496C1BDE23
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Apr 2020 15:38:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727831AbgD2Nh0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Apr 2020 09:37:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727107AbgD2NhB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Apr 2020 09:37:01 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3351CC0A3BF3;
        Wed, 29 Apr 2020 06:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=u23sNGTDG+u9Lk1Zo8Xu9MDzG9uzpPr1XYeNiQGb77w=; b=FaHrizP5bJ1yL18yZzX0LCOIA3
        XK13cukEJ31kTpTmirnJYRGSp68Xby0cYl078yXwVgJ7io9a0Ti5eLgH8ouYy4m8DMiIzY2BhwTMA
        nVr6uQCYesz/ZtJJGEiHt/0oT7bm7Hh+F96qfzcOlMTty+TjgEiwkKv0IMsr9M+Bnr11CoKQyH6L8
        UWKFsa0oirt+eDJNHYFiFhR6RdI2jg2OPGvXbBglkPLiHTfyotM5AEHLX6bsevxmxXfIGbqE9ABLG
        uvM6of5ihPj7kdUFt1qXmBtRVuxbuc+Kfea2Z8kejnQWKq/C6zSzxQZ+x3vRp8eEdGF0Q2AjGHQuf
        u+ICdD/g==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jTmtY-0005ww-1P; Wed, 29 Apr 2020 13:37:00 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     William Kucharski <william.kucharski@oracle.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v3 25/25] mm: Align THP mappings for non-DAX
Date:   Wed, 29 Apr 2020 06:36:57 -0700
Message-Id: <20200429133657.22632-26-willy@infradead.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200429133657.22632-1-willy@infradead.org>
References: <20200429133657.22632-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: William Kucharski <william.kucharski@oracle.com>

When we have the opportunity to use transparent huge pages to map a
file, we want to follow the same rules as DAX.

Signed-off-by: William Kucharski <william.kucharski@oracle.com>
[Inline __thp_get_unmapped_area() into thp_get_unmapped_area()]
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/huge_memory.c | 40 +++++++++++++---------------------------
 1 file changed, 13 insertions(+), 27 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 7a5e2b470bc7..ebaf649aa28d 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -535,30 +535,30 @@ bool is_transparent_hugepage(struct page *page)
 }
 EXPORT_SYMBOL_GPL(is_transparent_hugepage);
 
-static unsigned long __thp_get_unmapped_area(struct file *filp,
-		unsigned long addr, unsigned long len,
-		loff_t off, unsigned long flags, unsigned long size)
+unsigned long thp_get_unmapped_area(struct file *filp, unsigned long addr,
+		unsigned long len, unsigned long pgoff, unsigned long flags)
 {
+	loff_t off = (loff_t)pgoff << PAGE_SHIFT;
 	loff_t off_end = off + len;
-	loff_t off_align = round_up(off, size);
+	loff_t off_align = round_up(off, PMD_SIZE);
 	unsigned long len_pad, ret;
 
-	if (off_end <= off_align || (off_end - off_align) < size)
-		return 0;
+	if (off_end <= off_align || (off_end - off_align) < PMD_SIZE)
+		goto regular;
 
-	len_pad = len + size;
+	len_pad = len + PMD_SIZE;
 	if (len_pad < len || (off + len_pad) < off)
-		return 0;
+		goto regular;
 
 	ret = current->mm->get_unmapped_area(filp, addr, len_pad,
 					      off >> PAGE_SHIFT, flags);
 
 	/*
-	 * The failure might be due to length padding. The caller will retry
-	 * without the padding.
+	 * The failure might be due to length padding.  Retry without
+	 * the padding.
 	 */
 	if (IS_ERR_VALUE(ret))
-		return 0;
+		goto regular;
 
 	/*
 	 * Do not try to align to THP boundary if allocation at the address
@@ -567,23 +567,9 @@ static unsigned long __thp_get_unmapped_area(struct file *filp,
 	if (ret == addr)
 		return addr;
 
-	ret += (off - ret) & (size - 1);
+	ret += (off - ret) & (PMD_SIZE - 1);
 	return ret;
-}
-
-unsigned long thp_get_unmapped_area(struct file *filp, unsigned long addr,
-		unsigned long len, unsigned long pgoff, unsigned long flags)
-{
-	unsigned long ret;
-	loff_t off = (loff_t)pgoff << PAGE_SHIFT;
-
-	if (!IS_DAX(filp->f_mapping->host) || !IS_ENABLED(CONFIG_FS_DAX_PMD))
-		goto out;
-
-	ret = __thp_get_unmapped_area(filp, addr, len, off, flags, PMD_SIZE);
-	if (ret)
-		return ret;
-out:
+regular:
 	return current->mm->get_unmapped_area(filp, addr, len, pgoff, flags);
 }
 EXPORT_SYMBOL_GPL(thp_get_unmapped_area);
-- 
2.26.2

