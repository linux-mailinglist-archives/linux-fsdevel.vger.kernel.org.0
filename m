Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6981A1C3167
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 May 2020 05:10:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727774AbgEDDKl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 3 May 2020 23:10:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726768AbgEDDKl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 3 May 2020 23:10:41 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4166BC061A0E;
        Sun,  3 May 2020 20:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=XXJ2nLBUwta0Na249+bQSZuRqkr1ECfsOkPvLduFZV0=; b=g1BP8fSKFiDU9E9Y5b2D0PjBQ9
        FiTM+ywvRARjPcGKha2iPGb2jDEvx4LVKONbuyki4+x71gAasA27cT0q7u8QoYcB0MwlN7ERRAJjr
        WKLnPLVnRh/Vvm8n2lv8RnuZh4WkFYGYhZWt3YjYZtfWynEsbpCZN6eCn6dRZngWoeKtGfdtJ+EQq
        SOqybcna34WTXu2+HnuBtfRdxEUnJteMRxhaUazWMbKkOkkV0aX4akfdTLlkJF3tVZprTnXy+OUKw
        8LXH5a3Mb5pTkOQv29D2dUwD64tkrWPqnWEtXX81TQDDdXOhEefvUS1+BM0OuXD8ViENU2E8FosH7
        tmjJOBBw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jVRV6-0000DP-89; Mon, 04 May 2020 03:10:36 +0000
Date:   Sun, 3 May 2020 20:10:36 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 18/25] mm: Allow large pages to be added to the page
 cache
Message-ID: <20200504031036.GB16070@bombadil.infradead.org>
References: <20200429133657.22632-1-willy@infradead.org>
 <20200429133657.22632-19-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200429133657.22632-19-willy@infradead.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 29, 2020 at 06:36:50AM -0700, Matthew Wilcox wrote:
> @@ -886,7 +906,7 @@ static int __add_to_page_cache_locked(struct page *page,
>  	/* Leave page->index set: truncation relies upon it */
>  	if (!huge)
>  		mem_cgroup_cancel_charge(page, memcg, false);
> -	put_page(page);
> +	page_ref_sub(page, nr);
>  	return xas_error(&xas);
>  }
>  ALLOW_ERROR_INJECTION(__add_to_page_cache_locked, ERRNO);

This is wrong.  page_ref_sub() will not call __put_page() if the refcount
gets to zero.  What do people prefer?

-	put_page(page);

(a)
+	put_thp(page);

(b)
+	put_page_nr(page, nr);

(c)
+	if (page_ref_sub_return(page, nr) == 0)
+		__put_page(page);
