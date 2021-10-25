Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA2BA439969
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Oct 2021 16:56:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233591AbhJYO6y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Oct 2021 10:58:54 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:52886 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230268AbhJYO6y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Oct 2021 10:58:54 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id D4790218B0;
        Mon, 25 Oct 2021 14:56:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1635173790; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OtqiJHq8zuWsjUAFlcfMCqR4fr77OchepUlZR3e94fI=;
        b=FN3DSXPzbzFZ1eiR+q19iiK1WqL+9W76nWnCKbE6Hvy3HDswx3rxfnRvM0rUOvzxxXhjxy
        /V8l8UsXuSr9ov5xT+zTwWT5SZ8a8OMyixDCTP3+pATodSk7lVG+2IvA6xTqAu1+iSeCht
        G9t9RANQ3TdzT0GPUkBZ7Vepwqq6H0o=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id A2EB1A3B8A;
        Mon, 25 Oct 2021 14:56:30 +0000 (UTC)
Date:   Mon, 25 Oct 2021 16:56:28 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     NeilBrown <neilb@suse.de>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Dave Chinner <david@fromorbit.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>
Subject: Re: [RFC 2/3] mm/vmalloc: add support for __GFP_NOFAIL
Message-ID: <YXbFnMA4WUSLFp7q@dhcp22.suse.cz>
References: <YXAtYGLv/k+j6etV@dhcp22.suse.cz>
 <CA+KHdyVdrfLPNJESEYzxfF+bksFpKGCd8vH=NqdwfPOLV9ZO8Q@mail.gmail.com>
 <20211020192430.GA1861@pc638.lan>
 <163481121586.17149.4002493290882319236@noble.neil.brown.name>
 <YXFAkFx8PCCJC0Iy@dhcp22.suse.cz>
 <20211021104038.GA1932@pc638.lan>
 <163485654850.17149.3604437537345538737@noble.neil.brown.name>
 <20211025094841.GA1945@pc638.lan>
 <YXaTBrhEqTZhTJYX@dhcp22.suse.cz>
 <CA+KHdyWeQ77uWg5GxJGYiNeG_2ZuKu62-i=L7kqhw__g--XGYg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+KHdyWeQ77uWg5GxJGYiNeG_2ZuKu62-i=L7kqhw__g--XGYg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 25-10-21 16:30:23, Uladzislau Rezki wrote:
> >
> > I would really prefer if this was not the main point of arguing here.
> > Unless you feel strongly about msleep I would go with schedule_timeout
> > here because this is a more widely used interface in the mm code and
> > also because I feel like that relying on the rounding behavior is just
> > subtle. Here is what I have staged now.
> >
> I have a preference but do not have a strong opinion here. You can go
> either way you want.
> 
> >
> > Are there any other concerns you see with this or other patches in the
> > series?
> >
> it is better if you could send a new vX version because it is hard to
> combine every "folded"

Yeah, I plan to soon. I just wanted to sort out most things before
spaming with a new version.

> into one solid commit. One comment below:
> 
> > ---
> > commit c1a7e40e6b56fed5b9e716de7055b77ea29d89d0
> > Author: Michal Hocko <mhocko@suse.com>
> > Date:   Wed Oct 20 10:12:45 2021 +0200
> >
> >     fold me "mm/vmalloc: add support for __GFP_NOFAIL"
> >
> >     Add a short sleep before retrying. 1 jiffy is a completely random
> >     timeout. Ideally the retry would wait for an explicit event - e.g.
> >     a change to the vmalloc space change if the failure was caused by
> >     the space fragmentation or depletion. But there are multiple different
> >     reasons to retry and this could become much more complex. Keep the retry
> >     simple for now and just sleep to prevent from hogging CPUs.
> >
> > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > index 0fb5413d9239..a866db0c9c31 100644
> > --- a/mm/vmalloc.c
> > +++ b/mm/vmalloc.c
> > @@ -2944,6 +2944,7 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
> >         do {
> >                 ret = vmap_pages_range(addr, addr + size, prot, area->pages,
> >                         page_shift);
> > +               schedule_timeout_uninterruptible(1);
> >
> We do not want to schedule_timeout_uninterruptible(1); every time.
> Only when an error is detected.

Because I was obviously in a brainless mode when doing that one. Thanks
for pointing this out!
-- 
Michal Hocko
SUSE Labs
