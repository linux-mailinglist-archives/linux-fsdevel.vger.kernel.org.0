Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 961043EC7B3
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Aug 2021 08:29:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233827AbhHOG3d (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 15 Aug 2021 02:29:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:43464 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231238AbhHOG3d (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 15 Aug 2021 02:29:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DCB186103D;
        Sun, 15 Aug 2021 06:29:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629008944;
        bh=5piigzE2Zjp/3ag1ZUnrg1kpYXWABsKOC0eZ9QCaI4E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aKPapCFfWjenDKFSlMvbWmQYnPJ/XNu6Uiegphet6c7gJhCdoOf6m9DaNXguSJCe+
         OH3aAix4Wow5To7SKmJ3d4g6hZtroLK6+CwurF9ZKkPocx22UfeGR0uoRJDlmgSav7
         W7XeeAOE7xWPxWsWqHedLR6s+7EW+zjZvMlbA5p+ge0wNZA+hf3d9mbvyCXEfJIK6L
         4Iag7dh7akrQvIrl3cveocgRAMyJkRo0/M6XPt5Q4TU3e2qJtGJmE+/544FiewWBRh
         BzpItjADi9qe8Sp6Bed6WoZ6UWGwrGunpGgyT2IsYBADugcxX7n42aGf5xOhX5cUmH
         Cob39GcxlZHzg==
Date:   Sun, 15 Aug 2021 09:28:57 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v14 050/138] mm/workingset: Convert workingset_activation
 to take a folio
Message-ID: <YRi0Ke2UX9eMqEKx@kernel.org>
References: <20210715033704.692967-1-willy@infradead.org>
 <20210715033704.692967-51-willy@infradead.org>
 <YPfuPTtlhGXBjhCL@kernel.org>
 <YRdBGCATQHPXrmTD@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YRdBGCATQHPXrmTD@casper.infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Aug 14, 2021 at 05:05:44AM +0100, Matthew Wilcox wrote:
> On Wed, Jul 21, 2021 at 12:51:57PM +0300, Mike Rapoport wrote:
> > >  /*
> > > - * page_memcg_rcu - locklessly get the memory cgroup associated with a page
> > > - * @page: a pointer to the page struct
> > > + * folio_memcg_rcu - Locklessly get the memory cgroup associated with a folio.
> > > + * @folio: Pointer to the folio.
> > >   *
> > > - * Returns a pointer to the memory cgroup associated with the page,
> > > - * or NULL. This function assumes that the page is known to have a
> > > + * Returns a pointer to the memory cgroup associated with the folio,
> > > + * or NULL. This function assumes that the folio is known to have a
> > >   * proper memory cgroup pointer. It's not safe to call this function
> > > - * against some type of pages, e.g. slab pages or ex-slab pages.
> > > + * against some type of folios, e.g. slab folios or ex-slab folios.
> > 
> > Maybe
> > 
> > - * Returns a pointer to the memory cgroup associated with the page,
> > - * or NULL. This function assumes that the page is known to have a
> > + * This function assumes that the folio is known to have a
> >   * proper memory cgroup pointer. It's not safe to call this function
> > - * against some type of pages, e.g. slab pages or ex-slab pages.
> > + * against some type of folios, e.g. slab folios or ex-slab folios.
> > + *
> > + * Return: a pointer to the memory cgroup associated with the folio,
> > + * or NULL.
> 
> I substantially included this change a few days ago and forgot to reply
> to this email; sorry.  It now reads:
> 
> /**
>  * folio_memcg_rcu - Locklessly get the memory cgroup associated with a folio.
>  * @folio: Pointer to the folio.
>  *
>  * This function assumes that the folio is known to have a
>  * proper memory cgroup pointer. It's not safe to call this function
>  * against some type of folios, e.g. slab folios or ex-slab folios.
>  *
>  * Return: A pointer to the memory cgroup associated with the folio,
>  * or NULL.
>  */

I like it.

-- 
Sincerely yours,
Mike.
