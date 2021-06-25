Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1EA03B429B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Jun 2021 13:35:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbhFYLhs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Jun 2021 07:37:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbhFYLhr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Jun 2021 07:37:47 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D5A8C061574;
        Fri, 25 Jun 2021 04:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=nInXZSuW2VLfsBmz2fvP4M1dxeak9S+ryROuH8Jszc4=; b=Y0XxGn8e4SplEkW7jopbVQALv5
        1t+SwOsekhUmI/ryMnx0OphVPVg6076gaBBUSwUJwzZnwZB2ezzy8IS57OMOSMxejtwLD231MKtVs
        Oke91rzIc51yQ2QKC4V4tc0QGbUECmpttnfNjucrotZQGwf5wjcxfQpGcudBoMTxee2vIqDj+o06A
        fvklr4nPbhc1FNg172LrcWqNHWQ/HeMZrSg1r8OUVgxYhhK1VhGHRmrYYzLGBPol6o/5YlwhQn3lt
        SPzQyFr4tWoq4/F8WBAH9njdgnOdgym9WEtjovPZBqIrRNJ3a4FIMdzD+Qee3Q9nFojgalEHY8lt5
        PhK+5Odg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lwk6q-0002AW-0u; Fri, 25 Jun 2021 11:35:04 +0000
Date:   Fri, 25 Jun 2021 12:34:55 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Christoph Hellwig <hch@infradead.org>, akpm@linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 14/46] mm/memcg: Add folio_charge_cgroup()
Message-ID: <YNW/Xxv74VlxTm6M@casper.infradead.org>
References: <20210622121551.3398730-1-willy@infradead.org>
 <20210622121551.3398730-15-willy@infradead.org>
 <YNLtmC9qd8Xxkxsc@infradead.org>
 <YNS2EvYub46WdVaq@casper.infradead.org>
 <YNWSS/FvuyCpRxej@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YNWSS/FvuyCpRxej@dhcp22.suse.cz>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 25, 2021 at 10:22:35AM +0200, Michal Hocko wrote:
> On Thu 24-06-21 17:42:58, Matthew Wilcox wrote:
> > On Wed, Jun 23, 2021 at 10:15:20AM +0200, Christoph Hellwig wrote:
> > > On Tue, Jun 22, 2021 at 01:15:19PM +0100, Matthew Wilcox (Oracle) wrote:
> > > > mem_cgroup_charge() already assumed it was being passed a non-tail
> > > > page (and looking at the callers, that's true; it's called for freshly
> > > > allocated pages).  The only real change here is that folio_nr_pages()
> > > > doesn't compile away like thp_nr_pages() does as folio support
> > > > is not conditional on transparent hugepage support.  Reimplement
> > > > mem_cgroup_charge() as a wrapper around folio_charge_cgroup().
> > > 
> > > Maybe rename __mem_cgroup_charge to __folio_charge_cgroup as well?
> > 
> > Oh, yeah, should have done that.  Thanks.
> 
> I would stick with __mem_cgroup_charge here. Not that I would insist but the
> folio nature is quite obvious from the parameter already.
> 
> Btw. memcg_check_events doesn't really need the page argument. A nid
> should be sufficient and your earlier patch is already touching the
> softlimit code so maybe it would be worth changing this page -> folio ->
> page back and forth.

I'm not a huge fan of that 'dummy_page' component of uncharge_gather,
so replacing that with nid makes sense.  I'll juggle these patches a bit
and work that in.  Thanks!
