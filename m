Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF1DF3EBF56
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Aug 2021 03:30:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236223AbhHNBbL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Aug 2021 21:31:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236128AbhHNBbK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Aug 2021 21:31:10 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F318C061756;
        Fri, 13 Aug 2021 18:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=DlSiQx83vgdiLHCuuw2OL8L/ZHJP2UPE/zBYzlozq/s=; b=Udps3o26/7YSjW58cgj+sExubl
        P2jsk0yy7OuvRUPQWCfx7QCTikWBZRb7EgF9dYXKbnSpv3Ah1xHKu4gewliPQllPOgqpFD7MUUNNU
        e9KAP5GUA84pzzhcmJASpbH+b54m136lpu1OfF5aFqRNzS/YHxqPhINktc+zxm2szUa6vQiVu2b3U
        kLRICt/2VS5yt+Czs3YG0UAif//eVfDyFfuTsv82xMYtC0FPeeuZDTireBKYSOUHaXTkyaS79ccgW
        zQMcwowtNIUIqoPqVtd7X4uSZ9xcHKiiTumRbCLaLP7jD3sCMZq2Poeo3DiAeuavbbGpRqa3W/C16
        n5hKO50A==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mEiUt-00GGmO-9w; Sat, 14 Aug 2021 01:30:15 +0000
Date:   Sat, 14 Aug 2021 02:30:03 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Subject: Re: [PATCH v14 040/138] mm/memcg: Convert mem_cgroup_charge() to
 take a folio
Message-ID: <YRccm0lwTkzlxqCX@casper.infradead.org>
References: <20210715033704.692967-1-willy@infradead.org>
 <20210715033704.692967-41-willy@infradead.org>
 <40a868bf-61dc-1832-4799-ff85018ebcec@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40a868bf-61dc-1832-4799-ff85018ebcec@suse.cz>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 11, 2021 at 12:54:05PM +0200, Vlastimil Babka wrote:
> > -static int __mem_cgroup_charge(struct page *page, struct mem_cgroup *memcg,
> > +static int __mem_cgroup_charge(struct folio *folio, struct mem_cgroup *memcg,
> >  			       gfp_t gfp)
> 
> The git/next version also renames this function to charge_memcg(), why? The new
> name doesn't look that internal as the old one. I don't have a strong opinion
> but CCing memcg maintainers who might.

Ah, this is Suren's fault :-)

https://lore.kernel.org/linux-mm/20210710003626.3549282-2-surenb@google.com/

Renaming it here makes the merge resolution cleaner.
