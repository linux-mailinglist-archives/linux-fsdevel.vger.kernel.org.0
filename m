Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8FA533B2E5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Mar 2021 13:38:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229559AbhCOMiW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Mar 2021 08:38:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:59380 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229517AbhCOMiJ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Mar 2021 08:38:09 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1615811887; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XPnypXrbJLycl28+ioA4f/vlwlVrs0XZ/ArvhjkGQLc=;
        b=K2HF+o3G7JPGb63WHJ1uPcoRrC0cY+zrFRfxLV3TAeXY2mryk0YHjb3fPD83Jos9RoKD9L
        QuUwltsDfIrHw6sPeTggt+V1y6uK80KM9Ilulzf7QsiFliGldTiFpilZPK/+/hDF/mkSEj
        xft6Bg6EgpdSjRktdS8amj/1Cv8UVqw=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 7EBAEAC17;
        Mon, 15 Mar 2021 12:38:07 +0000 (UTC)
Date:   Mon, 15 Mar 2021 13:38:04 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v4 00/25] Page folios
Message-ID: <YE9VLGl50hLIJHci@dhcp22.suse.cz>
References: <20210305041901.2396498-1-willy@infradead.org>
 <20210313123658.ad2dcf79a113a8619c19c33b@linux-foundation.org>
 <alpine.LSU.2.11.2103131842590.14125@eggly.anvils>
 <20210315115501.7rmzaan2hxsqowgq@box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210315115501.7rmzaan2hxsqowgq@box>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 15-03-21 14:55:01, Kirill A. Shutemov wrote:
> On Sat, Mar 13, 2021 at 07:09:01PM -0800, Hugh Dickins wrote:
> > On Sat, 13 Mar 2021, Andrew Morton wrote:
> > > On Fri,  5 Mar 2021 04:18:36 +0000 "Matthew Wilcox (Oracle)" <willy@infradead.org> wrote:
> > > 
> > > > Our type system does not currently distinguish between tail pages and
> > > > head or single pages.  This is a problem because we call compound_head()
> > > > multiple times (and the compiler cannot optimise it out), bloating the
> > > > kernel.  It also makes programming hard as it is often unclear whether
> > > > a function operates on an individual page, or an entire compound page.
> > > > 
> > > > This patch series introduces the struct folio, which is a type that
> > > > represents an entire compound page.  This initial set reduces the kernel
> > > > size by approximately 6kB, although its real purpose is adding
> > > > infrastructure to enable further use of the folio.
> > > 
> > > Geeze it's a lot of noise.  More things to remember and we'll forever
> > > have a mismash of `page' and `folio' and code everywhere converting
> > > from one to the other.  Ongoing addition of folio
> > > accessors/manipulators to overlay the existing page
> > > accessors/manipulators, etc.
> > > 
> > > It's unclear to me that it's all really worth it.  What feedback have
> > > you seen from others?
> > 
> > My own feeling and feedback have been much like yours.
> > 
> > I don't get very excited by type safety at this level; and although
> > I protested back when all those compound_head()s got tucked into the
> > *PageFlag() functions, the text size increase was not very much, and
> > I never noticed any adverse performance reports.
> > 
> > To me, it's distraction, churn and friction, ongoing for years; but
> > that's just me, and I'm resigned to the possibility that it will go in.
> > Matthew is not alone in wanting to pursue it: let others speak.
> 
> I'm with Matthew on this. I would really want to drop the number of places
> where we call compoud_head(). I hope we can get rid of the page flag
> policy hack I made.

I tend to agree here as well. The level compoud_head has spread out
silently is just too large. There are people coming up with all sorts of
optimizations to workaround that, and they are quite right that this is
somehing worth doing, but last attempts I have seen were very focused on
specific page flags handling which is imho worse wrt maintainability
than a higher level and type safe abstraction. I find it quite nice that
this doesn't really have to be a flag day conversion but it can be done
incrementally.

I didn't get review the series yet and I cannot really promise anything
but from what I understand the conversion should be pretty
straightforward, albeit noisy.

One thing that was really strange to me when seeing the concept for the
first time was the choice of naming (no I do not want to start any
bikeshedding) because it hasn't really resonated with the udnerlying
concept. Maybe just me as a non native speaker... page_head would have
been so much more straightforward but not something I really care about.
-- 
Michal Hocko
SUSE Labs
