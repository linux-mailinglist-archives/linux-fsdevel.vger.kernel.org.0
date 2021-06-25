Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1B003B4450
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Jun 2021 15:21:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231465AbhFYNYE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Jun 2021 09:24:04 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:52366 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbhFYNYE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Jun 2021 09:24:04 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 8DF0721CAF;
        Fri, 25 Jun 2021 13:21:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1624627302; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0CIXN1np/PjZuRJcqW1fcN9Sw5pwXTA4UECMoSVMprk=;
        b=EoZOuhcDdhuwLzS+Ic4LSJc0dfvm9UZFGcZ5/KY9Zms3XDtZbXW1FxCGiHZ08bJqc3rO95
        XOR85yoCs5uuJ5vozeHKR8WDqcUBPKLnMbZ+COhNs9/O0cMiFEu/jKrLzsJ2LtN1/5Y3uU
        2p2Gq8zgsNODVMLxa0CEyfLgvZ2ukus=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 5A285A3C3A;
        Fri, 25 Jun 2021 13:21:42 +0000 (UTC)
Date:   Fri, 25 Jun 2021 15:21:41 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 15/46] mm/memcg: Add folio_uncharge_cgroup()
Message-ID: <YNXYZTAx0JrTPfL2@dhcp22.suse.cz>
References: <20210622121551.3398730-1-willy@infradead.org>
 <20210622121551.3398730-16-willy@infradead.org>
 <YNWTCG3s910H3to2@dhcp22.suse.cz>
 <YNW8PLZvX/Od+Ldn@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YNW8PLZvX/Od+Ldn@casper.infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 25-06-21 12:21:32, Matthew Wilcox wrote:
> On Fri, Jun 25, 2021 at 10:25:44AM +0200, Michal Hocko wrote:
> > On Tue 22-06-21 13:15:20, Matthew Wilcox wrote:
> > > Reimplement mem_cgroup_uncharge() as a wrapper around
> > > folio_uncharge_cgroup().
> > > 
> > > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> > 
> > Similar to the previous patch. Is there any reason why we cannot simply
> > stick with mem_cgroup_{un}charge and only change the parameter to folio?
> 
> There are a dozen callers of mem_cgroup_charge() and most of them
> aren't quite ready to convert to folios at this point in the patch
> series.  So either we need a new name for the variant that takes a
> folio, or we need to play fun games with _Generic to allow
> mem_cgroup_charge() to take either a folio or a page, or we convert
> all callers to open-code their call to page_folio, like this:
> 
> -	if (mem_cgroup_charge(vmf->cow_page, vma->vm_mm, GFP_KERNEL)) {
> +	if (mem_cgroup_charge(page_folio(vmf->cow_page), vma->vm_mm,
> +			GFP_KERNEL)) {
> 
> I've generally gone with creating compat functions to minimise the
> merge conflicts when people are adding new callers or changing code near
> existing ones.  But if you don't like the new name, we have options.

Well, I will not insist because I can see how the conversion is PITA in
general.
mem_cgroup_charge should be something to be added very often so if you
do not mind I would go with your above example of direct usage of
page_folio() rather than wrappers.

Thanks!
-- 
Michal Hocko
SUSE Labs
