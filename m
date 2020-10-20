Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFA3F293E9E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Oct 2020 16:26:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408064AbgJTO0z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Oct 2020 10:26:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408059AbgJTO0z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Oct 2020 10:26:55 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEC58C061755;
        Tue, 20 Oct 2020 07:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:To:From:Date:Sender:Reply-To:Cc:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2aLHtQDOdruUdSroCRCDtJfw/xvi97M7ZJVS89XU29o=; b=GEOh84wvtk8kt+7ZHCJ2SLd14k
        MDKN+W1Uo2yzQZd9iDWQyL7Q7YVdMvSrA3NOhaH6KCF5O+156BHFhWhJY7ZLUpywcPl6eUlKG/3Og
        F7aR6V7ihql/EpGK/i95/VJOhDTCv6B3wydBUHh0OWo8YvlUNYpuF3ziUDHT1CgyqDqBdnnvDJa6e
        SjVx42l2yGQe8xhw+nz/+5+TcBeKtCVmwT+9yduHxq//U6bMX3MKCKTvpI87EMY+fpkcr60wVbrmS
        ynJmRxIs32A2X0n05MFplEuag6/nGUza83h/g+WvUUndHSS/hGuB6Ff/VEWtxOIUxTo+S2z0pTMZW
        MZeC2v7A==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kUsbF-00084P-86; Tue, 20 Oct 2020 14:26:53 +0000
Date:   Tue, 20 Oct 2020 15:26:53 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org
Subject: Re: Splitting a THP beyond EOF
Message-ID: <20201020142653.GB20115@casper.infradead.org>
References: <20201020014357.GW20115@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201020014357.GW20115@casper.infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 20, 2020 at 02:43:57AM +0100, Matthew Wilcox wrote:
> I think the easiest way to fix this is to decline to allocate readahead
> pages beyond EOF.  That is, if we have a file which is, say, 61 pages
> long, read the last 5 pages into an order-2 THP and an order-0 THP
> instead of allocating an order-3 THP and zeroing the last three pages.

Oh yeah, really easy.

+++ b/mm/readahead.c
@@ -481,6 +481,11 @@ void page_cache_ra_order(struct readahead_control *ractl,
                        if (order == 1)
                                order = 0;
                }
+               /* Don't allocate pages past EOF */
+               while (index + (1UL << order) - 1 > limit) {
+                       if (--order == 1)
+                               order = 0;
+               }
                err = ra_alloc_page(ractl, index, mark, order, gfp);
                if (err)
                        break;

I've added that to an earlier patch and I've pushed out commit
cd3fa4bc6516 as the head of
http://git.infradead.org/users/willy/pagecache.git/shortlog
