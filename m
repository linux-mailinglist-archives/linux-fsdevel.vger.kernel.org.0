Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2739447E7AC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Dec 2021 19:36:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349849AbhLWSg1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Dec 2021 13:36:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240342AbhLWSg0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Dec 2021 13:36:26 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58D20C061401
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Dec 2021 10:36:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=F53Sr3hxlzVnq8IAZPudB03T7dblSjwWxj479CJVwP4=; b=bXA4mL9pQKJ+X8NPTXyC7qziYC
        fzT8yINMfwf+NywJMg7SDn3lLBKNStYYnfwHlJdZrjxLcd26uIEEYwP/vbsY8ziqJt2jxIR/zb7nm
        QLg+vGKFUpMfP2DTca7uyN3Qyd7fZeDp8b89mUA0rMRRkH4toNTSSfbxhtEOcTwHbFkLuyVM9vm4e
        AZhF3b9zFXbeJ8ejjZj95FnW5sRjSR0ZTIBPnNm2Iz0P67geapmTJaVUTLIg3drhqIAHfBq7ROFmf
        Q7PG1w1v9nQbdGQrlUBzdJL5m7q0X6r9Yc/QN6c3eY3WWESyg0/DaLYfX39fbw1xrH21707USte8x
        j4h4G3NQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n0Swy-004Usa-Br; Thu, 23 Dec 2021 18:36:24 +0000
Date:   Thu, 23 Dec 2021 18:36:24 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     Mel Gorman <mgorman@techsingularity.net>
Subject: Re: [PATCH 25/48] filemap: Add read_cache_folio and
 read_mapping_folio
Message-ID: <YcTBqAkrFxGeR+Y2@casper.infradead.org>
References: <20211208042256.1923824-1-willy@infradead.org>
 <20211208042256.1923824-26-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211208042256.1923824-26-willy@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 08, 2021 at 04:22:33AM +0000, Matthew Wilcox (Oracle) wrote:
> @@ -3503,23 +3491,23 @@ static struct page *do_read_cache_page(struct address_space *mapping,
>  	 * avoid spurious serialisations and wakeups when multiple processes
>  	 * wait on the same page for IO to complete.
>  	 */
> -	wait_on_page_locked(page);
> -	if (PageUptodate(page))
> +	folio_wait_locked(folio);
> +	if (folio_test_uptodate(folio))
>  		goto out;
>  
>  	/* Distinguish between all the cases under the safety of the lock */
> -	lock_page(page);
> +	folio_lock(folio);
>  
>  	/* Case c or d, restart the operation */
> -	if (!page->mapping) {
> -		unlock_page(page);
> -		put_page(page);
> +	if (!folio->mapping) {
> +		folio_unlock(folio);
> +		folio_put(folio);
>  		goto repeat;
>  	}

Re-reviewing this patch after Christoph's feedback, I believe it is
wrong to sleep with the refcount elevated, waiting for someone else to
unlock the page.  Doing that prevents anyone from splitting the folio,
which can be annoying.

So I'm thinking about adding this patch (as a follow-on).  It brings
the code closer to the read_iter path, which is always a good thing.
The comment was going to be made untrue by this patch, and I tried
rewriting it, but concluded ultimately that it was more distracting than
informative.

diff --git a/mm/filemap.c b/mm/filemap.c
index 6f541d931a4c..33077c264d79 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3451,45 +3451,12 @@ static struct folio *do_read_cache_folio(struct address_space *mapping,
 	if (folio_test_uptodate(folio))
 		goto out;
 
-	/*
-	 * Page is not up to date and may be locked due to one of the following
-	 * case a: Page is being filled and the page lock is held
-	 * case b: Read/write error clearing the page uptodate status
-	 * case c: Truncation in progress (page locked)
-	 * case d: Reclaim in progress
-	 *
-	 * Case a, the page will be up to date when the page is unlocked.
-	 *    There is no need to serialise on the page lock here as the page
-	 *    is pinned so the lock gives no additional protection. Even if the
-	 *    page is truncated, the data is still valid if PageUptodate as
-	 *    it's a race vs truncate race.
-	 * Case b, the page will not be up to date
-	 * Case c, the page may be truncated but in itself, the data may still
-	 *    be valid after IO completes as it's a read vs truncate race. The
-	 *    operation must restart if the page is not uptodate on unlock but
-	 *    otherwise serialising on page lock to stabilise the mapping gives
-	 *    no additional guarantees to the caller as the page lock is
-	 *    released before return.
-	 * Case d, similar to truncation. If reclaim holds the page lock, it
-	 *    will be a race with remove_mapping that determines if the mapping
-	 *    is valid on unlock but otherwise the data is valid and there is
-	 *    no need to serialise with page lock.
-	 *
-	 * As the page lock gives no additional guarantee, we optimistically
-	 * wait on the page to be unlocked and check if it's up to date and
-	 * use the page if it is. Otherwise, the page lock is required to
-	 * distinguish between the different cases. The motivation is that we
-	 * avoid spurious serialisations and wakeups when multiple processes
-	 * wait on the same page for IO to complete.
-	 */
-	folio_wait_locked(folio);
-	if (folio_test_uptodate(folio))
-		goto out;
-
-	/* Distinguish between all the cases under the safety of the lock */
-	folio_lock(folio);
+	if (!folio_trylock(folio)) {
+		folio_put_wait_locked(folio, TASK_UNINTERRUPTIBLE);
+		goto repeat;
+	}
 
-	/* Case c or d, restart the operation */
+	/* Folio was truncated from mapping */
 	if (!folio->mapping) {
 		folio_unlock(folio);
 		folio_put(folio);
