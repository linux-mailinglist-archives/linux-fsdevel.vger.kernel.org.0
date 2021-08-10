Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 015473E82A0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Aug 2021 20:16:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235885AbhHJSRC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Aug 2021 14:17:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238075AbhHJSOj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Aug 2021 14:14:39 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33420C0313B2;
        Tue, 10 Aug 2021 10:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ZKuxRwEJi6UdCiGa5FH7hMsus6mtsxEd3RxdDhTPJbI=; b=f9X6S0jkP3ygdDdCGylA9+HbRb
        kQBxrJmSN1t1o5T4qjzsiFzUqBPVYbYzikHjkJhqlP3oMovCy6/DlA2nilmjCJgVREPrXlxUVRPf6
        ou+BhWtn/OPmrfSq7HYCqIOFNgyAZ6ElRLTfSmQCqGOgMHE8GklMwPptaTyD/aBhbdneoF8tcmMcg
        NIr2vNmSVrRE1MEWdnmhvTTpHW5AlBHOEwbnQnkcdxqI9Rxd+V3XpFNCXl1op0/JlI+1G9OnPNBOM
        41B7uo8kyvcqcnG+HTD7M/Fuqu50fWPvbnhc17wGt76g8k/T27HZNjHFj2k5TGVOgFYQnVPFOguUt
        upocO09g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mDVmt-00CQ4n-Cd; Tue, 10 Aug 2021 17:44:28 +0000
Date:   Tue, 10 Aug 2021 18:43:39 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, Yu Zhao <yuzhao@google.com>,
        Christoph Hellwig <hch@lst.de>,
        David Howells <dhowells@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH v14 011/138] mm/lru: Add folio LRU functions
Message-ID: <YRK6y5s8T3qd38G1@casper.infradead.org>
References: <20210715033704.692967-1-willy@infradead.org>
 <20210715033704.692967-12-willy@infradead.org>
 <91fb7d5b-9f5f-855e-2c87-dab105d5c977@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <91fb7d5b-9f5f-855e-2c87-dab105d5c977@suse.cz>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 10, 2021 at 06:01:16PM +0200, Vlastimil Babka wrote:
> Actually looking at the git version, which has also this:
> 
>  static __always_inline void update_lru_size(struct lruvec *lruvec,
>                                 enum lru_list lru, enum zone_type zid,
> -                               int nr_pages)
> +                               long nr_pages)
>  {
> 
> Why now and here? Some of the functions called from update_lru_size()
> still take int so this looks arbitrary?

I'm still a little freaked out about the lack of warning for:

void f(long n);
void g(unsigned int n) { f(-n); }

so I've decided that the count of pages in a folio is always of type
long.  The actual number is positive, and currently it's between 1 and
1024 (inclusive on both bounds), so it's always going to be
representable in an int.  Narrowing it doesn't cause a bug, so we don't
need to change nr_pages anywhere, but it does no harm to make functions
take a long instead of an int (it may even cause slightly better code
generation, based on the sample of functions I've looked at).

Maybe changing update_lru_size() in this patch is wrong.  I can drop it
if you like.
