Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C1B63B341C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Jun 2021 18:43:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232174AbhFXQqD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Jun 2021 12:46:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbhFXQqD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Jun 2021 12:46:03 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF896C061574;
        Thu, 24 Jun 2021 09:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3OGGZZCSfU1UZW7S8nvXVWevH6pEWWYEGVTlrHA4x9I=; b=N+1PYxjdBAAKCu81TZyucVa43H
        kTeXGRDZbd2aAC1eH8LVu7E1TdN0Lp9QyyhAi03rH3d8cAkqwyiA3BKd88zgSKnwJrZOM086o6cGf
        I9vLjUOtYRpWofxXD1+x7kjS3utZCOHjyyHAj2AMSHwOdJKMwNihHl5kojkplp5D13UG6dMApssXm
        Nv1ymtk7tQLevZDEIvw4GvHdc0CFILfTPyvWAqySd6Oy9FE6VobhgWzgKsZNC7ahDAg1VW4sHctUT
        ODwjQIW3XAoYBdL78jjmgpxx9YKZpzEEUp38h1pl/7pfXF0SaHdyby6u3KduoykL244QF/cy6bfRj
        einwniJg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lwSRO-00GmhX-Fk; Thu, 24 Jun 2021 16:43:05 +0000
Date:   Thu, 24 Jun 2021 17:42:58 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 14/46] mm/memcg: Add folio_charge_cgroup()
Message-ID: <YNS2EvYub46WdVaq@casper.infradead.org>
References: <20210622121551.3398730-1-willy@infradead.org>
 <20210622121551.3398730-15-willy@infradead.org>
 <YNLtmC9qd8Xxkxsc@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YNLtmC9qd8Xxkxsc@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 23, 2021 at 10:15:20AM +0200, Christoph Hellwig wrote:
> On Tue, Jun 22, 2021 at 01:15:19PM +0100, Matthew Wilcox (Oracle) wrote:
> > mem_cgroup_charge() already assumed it was being passed a non-tail
> > page (and looking at the callers, that's true; it's called for freshly
> > allocated pages).  The only real change here is that folio_nr_pages()
> > doesn't compile away like thp_nr_pages() does as folio support
> > is not conditional on transparent hugepage support.  Reimplement
> > mem_cgroup_charge() as a wrapper around folio_charge_cgroup().
> 
> Maybe rename __mem_cgroup_charge to __folio_charge_cgroup as well?

Oh, yeah, should have done that.  Thanks.
