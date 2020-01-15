Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 15C1913BA46
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2020 08:20:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726075AbgAOHUE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Jan 2020 02:20:04 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:52372 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725962AbgAOHUE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Jan 2020 02:20:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=mVdbeLHfuUfyQteu6gezc7j2auurEgDMNjVAHuYZ1cU=; b=SGcS0CrPzgi0h1x4I6/wpojEo
        PPCv8anDBT2yl/zGWcE9VxnF40muIy4yyX4zlUcfVmjzy0Doc/ue6rjLbzoXYLmFkLismJr4jmXug
        4lFgTR2hyp6R53e5FTWfAFl7GYao5hbDDOqPcZB9ZX8RH1EfSjFe6qXkoBPYdi5ul5/E1Gy63+hoo
        nDISVOtAKa1e6yd+kup6miqdW+b0BXQ8lxEMZ2/ncr1zHTTIJygfdoyCAdc5rf4IX9ZWVENbx+xen
        ojlV+Xur6UjkNT1dwHhKQ9+YKbeRAsR6kJo0l9cPzWV4n8hzzRkysCvMFiQwBTyQpRJnjqwkqmYA1
        y9crFL/lA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ircyC-0001Jf-9C; Wed, 15 Jan 2020 07:20:04 +0000
Date:   Tue, 14 Jan 2020 23:20:04 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, Jeff Layton <jlayton@kernel.org>,
        Christoph Hellwig <hch@infradead.org>, Chris Mason <clm@fb.com>
Subject: Re: [PATCH v2 9/9] mm: Unify all add_to_page_cache variants
Message-ID: <20200115072004.GB3460@infradead.org>
References: <20200115023843.31325-1-willy@infradead.org>
 <20200115023843.31325-10-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200115023843.31325-10-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 14, 2020 at 06:38:43PM -0800, Matthew Wilcox wrote:
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> 
> We already have various bits of add_to_page_cache() executed conditionally
> on !PageHuge(page); add the add_to_page_cache_lru() pieces as some
> more code which isn't executed for huge pages.  This lets us remove
> the old add_to_page_cache() and rename __add_to_page_cache_locked() to
> add_to_page_cache().  Include a compatibility define so we don't have
> to change all 20+ callers of add_to_page_cache_lru().

I'd rather change them.  20ish isn't that much after all, and not
keeping pointless aliases around keeps the code easier to read.
