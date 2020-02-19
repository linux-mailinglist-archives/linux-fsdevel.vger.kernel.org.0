Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E779164B7E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2020 18:06:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbgBSRGo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Feb 2020 12:06:44 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:37054 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbgBSRGn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Feb 2020 12:06:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6hWL64aU7/cD1s4UTpPss89s1pka8CcWGCJ5BHjUC9M=; b=YD6KASfCXNzBE2g7U8C3OPAIMa
        RN+ihaDs+TqA1PVmJY/G+571Br5Ulv0XQc9EhsoYwQWJIGDt5eVY3v+7OW0ZDPPydpAvd+XANKK7o
        Yieli5fHS4G8IkuA6ZGWdtYi3uF69BcBtjkIg1txQfTuEC38FUNQpMva7d6LZIwTpJqOi2eTnjQ26
        vNRvjsTCftaqhGEu3hEvctNIgYhTUrWaBzOu7hsE+5KmGRNAeS2s5R2DU2EMQh/fz/4XG6YC8Yfkl
        lb7zA1cZfGKpjcKVeyriFSjz0Jf9srJLBGVWu7kMAFznlMRG+bjJHweFWDFekIpMDNj5yFPnAlDOG
        rO8cGwug==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j4So6-00016p-If; Wed, 19 Feb 2020 17:06:42 +0000
Date:   Wed, 19 Feb 2020 09:06:42 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        ocfs2-devel@oss.oracle.com, linux-xfs@vger.kernel.org
Subject: Re: [PATCH v6 17/19] iomap: Restructure iomap_readpages_actor
Message-ID: <20200219170642.GS24185@bombadil.infradead.org>
References: <20200217184613.19668-1-willy@infradead.org>
 <20200217184613.19668-31-willy@infradead.org>
 <20200219032900.GE10776@dread.disaster.area>
 <20200219060415.GO24185@bombadil.infradead.org>
 <20200219064005.GL10776@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200219064005.GL10776@dread.disaster.area>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 19, 2020 at 05:40:05PM +1100, Dave Chinner wrote:
> Ok, that's what the ctx.cur_page_in_bio check is used to detect i.e.
> if we've got a page that the readahead cursor points at, and we
> haven't actually added it to a bio, then we can leave it to the
> read_pages() to unlock and clean up. If it's in a bio, then IO
> completion will unlock it and so we only have to drop the submission
> reference and move the readahead cursor forwards so read_pages()
> doesn't try to unlock this page. i.e:
> 
> 	/* clean up partial page submission failures */
> 	if (ctx.cur_page && ctx.cur_page_in_bio) {
> 		put_page(ctx.cur_page);
> 		readahead_next(rac);
> 	}
> 
> looks to me like it will handle the case of "ret == 0" in the actor
> function just fine.

Here's what I ended up with:

@@ -400,15 +400,9 @@ iomap_readpages_actor(struct inode *inode, loff_t pos, loff_t length,
                void *data, struct iomap *iomap, struct iomap *srcmap)
 {
        struct iomap_readpage_ctx *ctx = data;
-       loff_t done, ret;
-
-       for (done = 0; done < length; done += ret) {
-               if (ctx->cur_page && offset_in_page(pos + done) == 0) {
-                       if (!ctx->cur_page_in_bio)
-                               unlock_page(ctx->cur_page);
-                       put_page(ctx->cur_page);
-                       ctx->cur_page = NULL;
-               }
+       loff_t ret, done = 0;
+
+       while (done < length) {
                if (!ctx->cur_page) {
                        ctx->cur_page = iomap_next_page(inode, ctx->pages,
                                        pos, length, &done);
@@ -418,6 +412,20 @@ iomap_readpages_actor(struct inode *inode, loff_t pos, loff_t length,
                }
                ret = iomap_readpage_actor(inode, pos + done, length - done,
                                ctx, iomap, srcmap);
+               done += ret;
+
+               /* Keep working on a partial page */
+               if (ret && offset_in_page(pos + done))
+                       continue;
+
+               if (!ctx->cur_page_in_bio)
+                       unlock_page(ctx->cur_page);
+               put_page(ctx->cur_page);
+               ctx->cur_page = NULL;
+
+               /* Don't loop forever if we made no progress */
+               if (WARN_ON(!ret))
+                       break;
        }
 
        return done;
@@ -451,11 +459,7 @@ iomap_readpages(struct address_space *mapping, struct list_head *pages,
 done:
        if (ctx.bio)
                submit_bio(ctx.bio);
-       if (ctx.cur_page) {
-               if (!ctx.cur_page_in_bio)
-                       unlock_page(ctx.cur_page);
-               put_page(ctx.cur_page);
-       }
+       BUG_ON(ctx.cur_page);
 
        /*
         * Check that we didn't lose a page due to the arcance calling

so we'll WARN if we get a ret == 0 (matching ->readpage), and we'll
BUG if we ever see a page being leaked out of readpages_actor, which
is a thing that should never happen and we definitely want to be noisy
about if it does.
