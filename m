Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71D9243ACB4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Oct 2021 09:10:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231981AbhJZHMr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Oct 2021 03:12:47 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:35894 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232774AbhJZHMl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Oct 2021 03:12:41 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id EEE3C1FCA3;
        Tue, 26 Oct 2021 07:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1635232213; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=abo5tucNIoMTysJZzSXI3u3r6is4Z+PDnULG9NIIR1E=;
        b=WBiLjW4mCjxpk1SzazwX8gSR15CUANeCGNaTANA4K+956fhef07akKRg1O2GSY80mMaVom
        OU6QNDBf20tVJpKkynojo3OxgqTJ3AdobvPUnrw7ILjgOmcqK67itw77DyNuvrYDECGH5B
        KPsHb1I13TWLuvxFm4FnnqxiQa1Hq1c=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id BF209A3B88;
        Tue, 26 Oct 2021 07:10:13 +0000 (UTC)
Date:   Tue, 26 Oct 2021 09:10:13 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     NeilBrown <neilb@suse.de>
Cc:     linux-mm@kvack.org, Dave Chinner <david@fromorbit.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH 3/4] mm/vmalloc: be more explicit about supported gfp
 flags.
Message-ID: <YXep1ctN1wPP+1a8@dhcp22.suse.cz>
References: <20211025150223.13621-1-mhocko@kernel.org>
 <20211025150223.13621-4-mhocko@kernel.org>
 <163520436674.16092.18372437960890952300@noble.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <163520436674.16092.18372437960890952300@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 26-10-21 10:26:06, Neil Brown wrote:
> On Tue, 26 Oct 2021, Michal Hocko wrote:
> > From: Michal Hocko <mhocko@suse.com>
> > 
> > The core of the vmalloc allocator __vmalloc_area_node doesn't say
> > anything about gfp mask argument. Not all gfp flags are supported
> > though. Be more explicit about constrains.
> > 
> > Signed-off-by: Michal Hocko <mhocko@suse.com>
> > ---
> >  mm/vmalloc.c | 12 ++++++++++--
> >  1 file changed, 10 insertions(+), 2 deletions(-)
> > 
> > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > index 602649919a9d..2199d821c981 100644
> > --- a/mm/vmalloc.c
> > +++ b/mm/vmalloc.c
> > @@ -2980,8 +2980,16 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
> >   * @caller:		  caller's return address
> >   *
> >   * Allocate enough pages to cover @size from the page level
> > - * allocator with @gfp_mask flags.  Map them into contiguous
> > - * kernel virtual space, using a pagetable protection of @prot.
> > + * allocator with @gfp_mask flags. Please note that the full set of gfp
> > + * flags are not supported. GFP_KERNEL would be a preferred allocation mode
> > + * but GFP_NOFS and GFP_NOIO are supported as well. Zone modifiers are not
> 
> In what sense is GFP_KERNEL "preferred"??
> The choice of GFP_NOFS, when necessary, isn't based on preference but
> on need.
> 
> I understand that you would prefer no one ever used GFP_NOFs ever - just
> use the scope API.  I even agree.  But this is not the place to make
> that case. 

Any suggestion for a better wording?

> > + * supported. From the reclaim modifiers__GFP_DIRECT_RECLAIM is required (aka
> > + * GFP_NOWAIT is not supported) and only __GFP_NOFAIL is supported (aka
> 
> I don't think "aka" is the right thing to use here.  It is short for
> "also known as" and there is nothing that is being known as something
> else.
> It would be appropriate to say (i.e. GFP_NOWAIT is not supported).
> "i.e." is short for the Latin "id est" which means "that is" and
> normally introduces an alternate description (whereas aka introduces an
> alternate name).

OK
 
> > + * __GFP_NORETRY and __GFP_RETRY_MAYFAIL are not supported).
> 
> Why do you think __GFP_NORETRY and __GFP_RETRY_MAYFAIL are not supported.

Because they cannot be passed to the page table allocator. In both cases
the allocation would fail when system is short on memory. GFP_KERNEL
used for ptes implicitly doesn't behave that way.

> 
> > + * __GFP_NOWARN can be used to suppress error messages about failures.
> 
> Surely "NOWARN" suppresses warning messages, not error messages ....

I am not sure I follow. NOWARN means "do not warn" independently on the
log level chosen for the message. Is an allocation failure an error
message? Is the "vmalloc error: size %lu, failed to map pages" an error
message?

Anyway I will go with "__GFP_NOWARN can be used to suppress failure messages"

Is that better?
-- 
Michal Hocko
SUSE Labs
