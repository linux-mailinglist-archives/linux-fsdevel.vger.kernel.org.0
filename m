Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 270EAFE372
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2019 17:56:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727567AbfKOQ42 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Nov 2019 11:56:28 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:59240 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727548AbfKOQ42 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Nov 2019 11:56:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=gwnAyOMVRG47oFxwH+WqgZyQjm7UpIWCaLq5p/+zd70=; b=kVioyWr3Ua7n9Ld6+xtpetPfx
        mtKLdv5QsViSi+9aPEuNNNYB/l+MG29buC0M9dy3lo2JRI/8+v8/ajW9W0wK4qFk5Mhj55FhxXNw6
        5j1jlTD1P8rxlHQTsFHGvBvJTtz/Vq8SccxdVhOFpK/riNwxyboSJrApVfoEzjIsb6Z8h8quS/i0a
        +qWQfb06p+bhndhMR1h41Efc3uN5XWVFcSPAhrxOjdG7o9CQCF7zdZFIcECqq/nHPM8ZAW2ZIClO0
        2sUf14MR0BpYUajs/B1KYCiwAE0XlcSK+HO5IGJVs5L8Ne9B1i036lyHWXoxHAJOYeb6fyj4lca4y
        KSLxo4dxA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iVetX-00049l-DZ; Fri, 15 Nov 2019 16:56:27 +0000
Date:   Fri, 15 Nov 2019 08:56:27 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc:     linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        hch@infradead.org, darrick.wong@oracle.com,
        Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [PATCH 7/7] btrfs: Wait for extent bits to release page
Message-ID: <20191115165627.GE26016@infradead.org>
References: <20191115161700.12305-1-rgoldwyn@suse.de>
 <20191115161700.12305-8-rgoldwyn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191115161700.12305-8-rgoldwyn@suse.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 15, 2019 at 10:17:00AM -0600, Goldwyn Rodrigues wrote:
> From: Goldwyn Rodrigues <rgoldwyn@suse.com>
> 
> While trying to release a page, the extent containing the page may be locked
> which would stop the page from being released. Wait for the
> extent lock to be cleared, if blocking is allowed and then clear
> the bits.
> 
> This is avoid warnings coming iomap->dio_rw() ->
> invalidate_inode_pages2_range() -> invalidate_complete_page2() ->
> try_to_release_page() results in stale pagecache warning.

I can't really comment on the technical aspects of this patch as I don't
know btrfs well enough for that, but try_release_extent_state already
is written in a rather convoluted way, and the additions in this patch
don't make that any better.

I think we want something like the version below.  I can also send you
a patch with just the cleanup bits, so that you can add the actual
changes on top.

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index cceaf05aada2..4dc4b4c57d7c 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -4367,28 +4367,24 @@ static int try_release_extent_state(struct extent_io_tree *tree,
 {
 	u64 start = page_offset(page);
 	u64 end = start + PAGE_SIZE - 1;
-	int ret = 1;
 
 	if (test_range_bit(tree, start, end, EXTENT_LOCKED, 0, NULL)) {
-		ret = 0;
-	} else {
-		/*
-		 * at this point we can safely clear everything except the
-		 * locked bit and the nodatasum bit
-		 */
-		ret = __clear_extent_bit(tree, start, end,
-				 ~(EXTENT_LOCKED | EXTENT_NODATASUM),
-				 0, 0, NULL, mask, NULL);
-
-		/* if clear_extent_bit failed for enomem reasons,
-		 * we can't allow the release to continue.
-		 */
-		if (ret < 0)
-			ret = 0;
-		else
-			ret = 1;
+		if (!gfpflags_allow_blocking(mask))
+			return 0;
+		wait_extent_bit(tree, start, end, EXTENT_LOCKED);
 	}
-	return ret;
+
+	/*
+	 * At this point we can safely clear everything except the locked and
+	 * nodatasum bits.  But if clear_extent_bit failed because we are out
+	 * of memory, we can't allow the release to continue.
+	 */
+	if (__clear_extent_bit(tree, start, end,
+			~(EXTENT_LOCKED | EXTENT_NODATASUM), 0, 0, NULL,
+			mask, NULL) < 0)
+		return 0;
+
+	return 1;
 }
 
 /*
