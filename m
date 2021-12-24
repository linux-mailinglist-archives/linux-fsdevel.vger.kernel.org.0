Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1246F47EBFC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Dec 2021 07:13:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351490AbhLXGNw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Dec 2021 01:13:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351418AbhLXGNw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Dec 2021 01:13:52 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32E61C061401
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Dec 2021 22:13:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=OSbaZTqKO+62u9cusxHxQ6TwpDTKYkm0NWnnBX3ZHrw=; b=klzHngZXFcBOZ3RsrZeHiBva9X
        Yp2bB9r7BMkxpc3G78yUuw5QmBMfMa0zsJk8g5cWFPwXr2JhNuGwhNgXUVCaHP4gkiqNDl2BTGVt5
        i228WQm7xXmA4607M1jUhVEigpvW3X8O4FCWMaJDZGRbAKGjVnbQfzFuvmBpI6iGkp88XVQBRh9aV
        n4DXT7D3VPVNwA+J2iSUY3yrV5RxDZnpym/JKJJ6rpzyuXoNcklupi4MhLu7v7A9S0KAKrabZLYEz
        emZFysRgQlDq0+CtjixwQmzY2ttqwQFsv+nuC/EN+i0dHm0DNVDdA3uYqadkdWm+390jVPG6UN7cA
        /ErlOOIw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n0dpu-00Dmid-Pl; Fri, 24 Dec 2021 06:13:50 +0000
Date:   Thu, 23 Dec 2021 22:13:50 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 05/48] pagevec: Add folio_batch
Message-ID: <YcVlHqtUQpBKl9nG@infradead.org>
References: <20211208042256.1923824-1-willy@infradead.org>
 <20211208042256.1923824-6-willy@infradead.org>
 <YcQdI9lvCfBY8odQ@infradead.org>
 <YcSFQBrz9vgroel9@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YcSFQBrz9vgroel9@casper.infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 23, 2021 at 02:18:40PM +0000, Matthew Wilcox wrote:
> > I think these casts need documentation, both here and at the
> > struct folio_batch and struct pagevec definitions.
> > 
> > Alternatively I wonder if a union in stuct pagevec so that it can store
> > folios or pages might be the better option.
> 
> I tried that way first, but then the caller & callee need to agree
> whether they're storing folios or pages in the pagevec.  And that's kind
> of why we have types.
> 
> pagevec_remove_exceptionals() goes away by the end of this series.
> pagevec_release() will take longer to remove.  What documentation
> do you want to see?

Mostly comments at the pagevec and folio_batch definitions that they
need to match because of these two functions, and then maybe a
backreference from the casts to the definitions.
