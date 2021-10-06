Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FCC642415F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Oct 2021 17:30:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232065AbhJFPcK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Oct 2021 11:32:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231944AbhJFPcK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Oct 2021 11:32:10 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15CFCC061746
        for <linux-fsdevel@vger.kernel.org>; Wed,  6 Oct 2021 08:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=HVJLkxV8KXTKQ/73bUbSbkDvZ1xhZ4iTaPTxuxYbi3k=; b=aYLZWTTBDxcHDI3FWx07sgiLY9
        IuENJawX4udoSekO9rglP046BDSYIU1MxrgSNuSEO/YEJXA3+0K5OW/4yqZYnS9l1Vwz82JfaeZQO
        kgVXWU9NVQVvzfPDVmRnGkkb77PuoyhZEFQPQw1AvwT4FD+43uYROeA5mBWTV/r/dckfp4xei5LuV
        OdVddo8ZdcJk2ZZt6EVXRNB5sIaZlrW3LMLi4KzF59zDPd1WRQb+Wfn16W+ha31kMZM1PwbiVhS/B
        qX1mJ4GFR0TrtOPUys9mwwiqUdnHR6CNKegYWOIHO/HiYNdpaQy8eHoz8FaYo9/Qbr+u6gB3PnJim
        bV8Jp+OA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mY8qq-0011bF-KD; Wed, 06 Oct 2021 15:29:15 +0000
Date:   Wed, 6 Oct 2021 16:29:00 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-mm@kvack.org, Kent Overstreet <kent.overstreet@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [RFC] pgflags_t
Message-ID: <YV3AvB2GeC0wK7k9@casper.infradead.org>
References: <YV25hsgfJ2qAYiRJ@casper.infradead.org>
 <89efcd40-9b56-00d4-1e29-9ad337b35426@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <89efcd40-9b56-00d4-1e29-9ad337b35426@redhat.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 06, 2021 at 05:16:51PM +0200, David Hildenbrand wrote:
> On 06.10.21 16:58, Matthew Wilcox wrote:
> > David expressed some unease about the lack of typesafety in patches
> > 1 & 2 of the page->slab conversion [1], and I'll admit to not being
> 
> I yet have to reply to your mail (-EBUSY), I'd even enjoy doing all
> pgflags_t access via the struct page, for example, using simpler "reserved"
> placeholders for such fields in "struct slab" that we really want to move
> out of struct slab later. When accessing flags, we'd cast to "struct page"
> and do the access.

There are several bits that slab/slob/slub use in page->flags currently.
The obvious one is the node ID (whether stored directly or indirected
via section), but also PG_pfmemalloc (aka PG_active), PG_slob_free (aka
PG_private), PG_lock, PG_slab and PG_head,  We might be able to change
that too, but for the moment, how about we not explore that path in the
interest of getting something merged that won't preclude exploring that
path sometime in the future?

> ... but whatever approach we use on that fron, this patch is a step into the
> right direction IMHO.

Thank you!

