Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74C0D3EC023
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Aug 2021 06:06:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbhHNEGk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 14 Aug 2021 00:06:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbhHNEGk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 14 Aug 2021 00:06:40 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A73CC061756;
        Fri, 13 Aug 2021 21:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=OzjG0eOWjSaTVzdwrlhA4xUXM2AfVf8c6T5tJbSz1go=; b=GMiVEV1pzyYY/voBVEbEdW1p52
        Adwfq2c++/p1q6s7sYbZIB4lPhSO6EsiSYSVWWPKqWfGyfrQp5smbanCUzny8pnpGkA3QDiekO/pW
        3NReojatqkPbUVwSQCM3ZsWP25Bhn0l5SprZRHWP5B+fnvD2iAredMtPzWEsP4RYda4/WM1oaNDvl
        aVD6eISnjsEaYsMaVxUUCCjTVqTnw/yvPq0cYw6TCSZHENEB3rlP1M1Q80nJVWCQNlsvqKqnxOrvy
        s7y6aQJglqgqgGVO2GYxukH1CQ7NzOYmIbyh/MgwxMCntHb/A63Nj+ozRwYlrajhauphJJfjTLjw0
        qPKNw+8Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mEkvY-00GMni-8p; Sat, 14 Aug 2021 04:05:53 +0000
Date:   Sat, 14 Aug 2021 05:05:44 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v14 050/138] mm/workingset: Convert workingset_activation
 to take a folio
Message-ID: <YRdBGCATQHPXrmTD@casper.infradead.org>
References: <20210715033704.692967-1-willy@infradead.org>
 <20210715033704.692967-51-willy@infradead.org>
 <YPfuPTtlhGXBjhCL@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YPfuPTtlhGXBjhCL@kernel.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 21, 2021 at 12:51:57PM +0300, Mike Rapoport wrote:
> >  /*
> > - * page_memcg_rcu - locklessly get the memory cgroup associated with a page
> > - * @page: a pointer to the page struct
> > + * folio_memcg_rcu - Locklessly get the memory cgroup associated with a folio.
> > + * @folio: Pointer to the folio.
> >   *
> > - * Returns a pointer to the memory cgroup associated with the page,
> > - * or NULL. This function assumes that the page is known to have a
> > + * Returns a pointer to the memory cgroup associated with the folio,
> > + * or NULL. This function assumes that the folio is known to have a
> >   * proper memory cgroup pointer. It's not safe to call this function
> > - * against some type of pages, e.g. slab pages or ex-slab pages.
> > + * against some type of folios, e.g. slab folios or ex-slab folios.
> 
> Maybe
> 
> - * Returns a pointer to the memory cgroup associated with the page,
> - * or NULL. This function assumes that the page is known to have a
> + * This function assumes that the folio is known to have a
>   * proper memory cgroup pointer. It's not safe to call this function
> - * against some type of pages, e.g. slab pages or ex-slab pages.
> + * against some type of folios, e.g. slab folios or ex-slab folios.
> + *
> + * Return: a pointer to the memory cgroup associated with the folio,
> + * or NULL.

I substantially included this change a few days ago and forgot to reply
to this email; sorry.  It now reads:

/**
 * folio_memcg_rcu - Locklessly get the memory cgroup associated with a folio.
 * @folio: Pointer to the folio.
 *
 * This function assumes that the folio is known to have a
 * proper memory cgroup pointer. It's not safe to call this function
 * against some type of folios, e.g. slab folios or ex-slab folios.
 *
 * Return: A pointer to the memory cgroup associated with the folio,
 * or NULL.
 */

