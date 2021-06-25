Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F30493B3E89
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Jun 2021 10:22:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbhFYIY6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Jun 2021 04:24:58 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:34780 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230161AbhFYIY5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Jun 2021 04:24:57 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 19BC81FE51;
        Fri, 25 Jun 2021 08:22:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1624609356; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6j5UUPbp80KQx259gxzigIUBiH85y3fXeRQnL4FGxyE=;
        b=Dhb7Y63OC8TVHDN7zGu1RHvcDlY1wqTUjtMi8EnhruCN+0m4q7o42N+LdUp1ZWXsjq1Y7w
        Il4CNaYxInOmgguS1uks/h2y2oYV+0CyQdxss6zn3BgSREeHdWZu3n9hZXYZUxaIES+NGI
        floF6i3vzn4Jh/C0pra19/nANjk3MkQ=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id E0190A3BF0;
        Fri, 25 Jun 2021 08:22:35 +0000 (UTC)
Date:   Fri, 25 Jun 2021 10:22:35 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Christoph Hellwig <hch@infradead.org>, akpm@linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 14/46] mm/memcg: Add folio_charge_cgroup()
Message-ID: <YNWSS/FvuyCpRxej@dhcp22.suse.cz>
References: <20210622121551.3398730-1-willy@infradead.org>
 <20210622121551.3398730-15-willy@infradead.org>
 <YNLtmC9qd8Xxkxsc@infradead.org>
 <YNS2EvYub46WdVaq@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YNS2EvYub46WdVaq@casper.infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 24-06-21 17:42:58, Matthew Wilcox wrote:
> On Wed, Jun 23, 2021 at 10:15:20AM +0200, Christoph Hellwig wrote:
> > On Tue, Jun 22, 2021 at 01:15:19PM +0100, Matthew Wilcox (Oracle) wrote:
> > > mem_cgroup_charge() already assumed it was being passed a non-tail
> > > page (and looking at the callers, that's true; it's called for freshly
> > > allocated pages).  The only real change here is that folio_nr_pages()
> > > doesn't compile away like thp_nr_pages() does as folio support
> > > is not conditional on transparent hugepage support.  Reimplement
> > > mem_cgroup_charge() as a wrapper around folio_charge_cgroup().
> > 
> > Maybe rename __mem_cgroup_charge to __folio_charge_cgroup as well?
> 
> Oh, yeah, should have done that.  Thanks.

I would stick with __mem_cgroup_charge here. Not that I would insist but the
folio nature is quite obvious from the parameter already.

Btw. memcg_check_events doesn't really need the page argument. A nid
should be sufficient and your earlier patch is already touching the
softlimit code so maybe it would be worth changing this page -> folio ->
page back and forth.

-- 
Michal Hocko
SUSE Labs
