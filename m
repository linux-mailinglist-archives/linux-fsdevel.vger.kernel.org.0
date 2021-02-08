Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DC38314367
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Feb 2021 00:03:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231244AbhBHXC6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Feb 2021 18:02:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231243AbhBHXC5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Feb 2021 18:02:57 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05F11C061786
        for <linux-fsdevel@vger.kernel.org>; Mon,  8 Feb 2021 15:02:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ccjx+Lijh4w6XmegtzS4AwX0coPJ3byCzA/5A3ypCMs=; b=Eq5xQyZ3RnrfGEUXJgtN1U2NfM
        23ycIPPjgY2rsBKIyZbE7iMj1Zbo4Hdg0JX2NmrsJ9YV3pU8XR3PM6dP5g2hr5nVVJvPfAzlMPZqU
        QGSduesaxBf0pW0vOf5WeBzIIWFGnKD3LDaEOraFYO3uyweDaRjHYOBuTEeILhAHSWQ2Jo8AY0mIK
        w7LG++KtJ/Oq+eoxak22x40o7ZVEFBrveQprGt8MUhdwJeRkY9AJ/UmKnllxUD1OwyrGTlo+3weMu
        Ypum0CkZheHzhTKU1iQu8Vb2h5EYi36sjG+oBzyPBK3GrD7DFS0mG/1eM8d2T2g06dvRArgpAH+N0
        IeQSJsDg==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l9FXh-006ec2-Ck; Mon, 08 Feb 2021 23:02:06 +0000
Date:   Mon, 8 Feb 2021 23:02:05 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        hch@infradead.org, akpm@linux-foundation.org
Subject: Re: [PATCH 1/3] mm: provide filemap_range_needs_writeback() helper
Message-ID: <20210208230205.GV308988@casper.infradead.org>
References: <20210208221829.17247-1-axboe@kernel.dk>
 <20210208221829.17247-2-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210208221829.17247-2-axboe@kernel.dk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 08, 2021 at 03:18:27PM -0700, Jens Axboe wrote:
> +	rcu_read_lock();
> +	xas_for_each(&xas, head, max) {
> +		if (xas_retry(&xas, head))
> +			continue;
> +		if (xa_is_value(head))
> +			continue;
> +		page = find_subpage(head, xas.xa_index);
> +		if (PageDirty(page) || PageLocked(page) || PageWriteback(page))
> +			break;
> +		page = NULL;
> +	}
> +	rcu_read_unlock();

There's no need to find the sub-page for any of these three conditions --
the bit will be set on the head page.
