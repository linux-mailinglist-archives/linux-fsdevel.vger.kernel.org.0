Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1BEB1179239
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Mar 2020 15:23:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729487AbgCDOW7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Mar 2020 09:22:59 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:41146 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726748AbgCDOW7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Mar 2020 09:22:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=AnbrYHfpg3ftWazDwotORReAOaIVQFxlC0lPYzO9Yq8=; b=IIcJhveN6A4+vTmO7IuKo+YtEO
        Y2gwjm6u8Yu2uWohjfQUqTGadI6U92dDBfsVWpS2yJAtT/L/IevjKw8lDK0j5siO++lIwZu67R+0t
        RiaBM9PScHuj+6VbI7+ih1UPTh4iJqVjvGRCdQfZoZQtYfGoLYja12Aoe/qe8wGOgNeIq9sHTTK48
        quQWCNVpBeRWBU6N1HPxQNAtjbXhEGBFCg7mkg/Onertb2gYdklEXkQ7J0lwkWyTfW3IMypKk5bH8
        UtxmAEoHagsFl1vOMBGHuJq66oreUNJZMB2ji7xEkjwvawyiHH4mRwFzBUkZYZepWHjQoVr1k7kfT
        xj5dy3VA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j9UvL-0004Na-Cr; Wed, 04 Mar 2020 14:22:59 +0000
Date:   Wed, 4 Mar 2020 06:22:59 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-xfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: [PATCH] iomap: Fix writepage tracepoint pgoff
Message-ID: <20200304142259.GF29971@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Matthew Wilcox (Oracle) <willy@infradead.org>

page_offset() confusingly returns the number of bytes from the
beginning of the file and not the pgoff, which the tracepoint claims
to be returning.  We're already returning the number of bytes from the
beginning of the file in the 'offset' parameter, so correct the pgoff
to be what was apparently intended.

Fixes: 0b1b213fcf3a ("xfs: event tracing support")
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

diff --git a/fs/iomap/trace.h b/fs/iomap/trace.h
index d6ba705f938a..ebc89ec5e6c7 100644
--- a/fs/iomap/trace.h
+++ b/fs/iomap/trace.h
@@ -56,7 +56,7 @@ DECLARE_EVENT_CLASS(iomap_page_class,
 	TP_fast_assign(
 		__entry->dev = inode->i_sb->s_dev;
 		__entry->ino = inode->i_ino;
-		__entry->pgoff = page_offset(page);
+		__entry->pgoff = page->index;
 		__entry->size = i_size_read(inode);
 		__entry->offset = off;
 		__entry->length = len;

