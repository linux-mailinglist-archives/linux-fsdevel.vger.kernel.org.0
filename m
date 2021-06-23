Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DD363B1591
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jun 2021 10:16:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbhFWIS5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Jun 2021 04:18:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbhFWIS4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Jun 2021 04:18:56 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9A93C061574;
        Wed, 23 Jun 2021 01:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=gwJnjrGmOmRKMLmPbTtw+ZCguV53V/yBf3LdRKLnkl0=; b=QZXGSh/c42ufkxCsKAh9tQjtbg
        NrfUt1DFfE+2Vb9ZD/Yqa/dRTRNfnA1fna/nzULooC2Ns4kdwdRseOWO0Z5wqR0GQHo/jajtiBgvK
        aPbcM2fJrTQFiqIuP+wj2wqIhsFCCNGC90dLJPA99Z2UhPYF5+G2WldxyScyoJUZzyOH3drFjr1ey
        L6WutGVIkdLjXKZUdg6SuO1RMQpu9kXUVzyISaqIEyE5CttLwxhTQQxiMlPKV23ZVEKkpVnrebcXj
        wIURqRJmp+pSHnufmeOp9aEbJZaP4ObUMqz4NmnGKX1DZYhEt06m6KJCMAhBIy92rKtNOyishRdiF
        9n+2yQ6w==;
Received: from [2001:4bb8:188:3e21:6594:49:139:2b3f] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lvy2b-00FCMr-HS; Wed, 23 Jun 2021 08:15:40 +0000
Date:   Wed, 23 Jun 2021 10:15:20 +0200
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 14/46] mm/memcg: Add folio_charge_cgroup()
Message-ID: <YNLtmC9qd8Xxkxsc@infradead.org>
References: <20210622121551.3398730-1-willy@infradead.org>
 <20210622121551.3398730-15-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210622121551.3398730-15-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 22, 2021 at 01:15:19PM +0100, Matthew Wilcox (Oracle) wrote:
> mem_cgroup_charge() already assumed it was being passed a non-tail
> page (and looking at the callers, that's true; it's called for freshly
> allocated pages).  The only real change here is that folio_nr_pages()
> doesn't compile away like thp_nr_pages() does as folio support
> is not conditional on transparent hugepage support.  Reimplement
> mem_cgroup_charge() as a wrapper around folio_charge_cgroup().

Maybe rename __mem_cgroup_charge to __folio_charge_cgroup as well?
