Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F97243B498
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Oct 2021 16:43:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235936AbhJZOqQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Oct 2021 10:46:16 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:37952 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236928AbhJZOqN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Oct 2021 10:46:13 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 5529A1FCA3;
        Tue, 26 Oct 2021 14:43:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1635259428; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4ePQT19X3SmPjH11bt5aB3Nm5hoxOx1Fk0Lqohn1Wk8=;
        b=PAi/DyGKz1Mz5H4MHeeXD6ynrnsFc7G/5X2HKstjEcdLp7rpHF3nvMFruGh09Lgvw9OCqH
        yyE93pclYHHJPiTwHjPe1Mltuzw3nDYYu2R6+IfYCXUql9d2ga5dHGsEZF1JJWAxYASvvf
        3UvMvc/CrR7r3Tmju3MhwaGBzU7sc7A=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 2819EA3BA0;
        Tue, 26 Oct 2021 14:43:48 +0000 (UTC)
Date:   Tue, 26 Oct 2021 16:43:47 +0200
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
Message-ID: <YXgUI33cfWYYrjXw@dhcp22.suse.cz>
References: <20211020192430.GA1861@pc638.lan>
 <163481121586.17149.4002493290882319236@noble.neil.brown.name>
 <YXFAkFx8PCCJC0Iy@dhcp22.suse.cz>
 <20211021104038.GA1932@pc638.lan>
 <163485654850.17149.3604437537345538737@noble.neil.brown.name>
 <20211025094841.GA1945@pc638.lan>
 <163520582122.16092.9250045450947778926@noble.neil.brown.name>
 <YXeraV5idipgWDB+@dhcp22.suse.cz>
 <163524388152.8576.15706993879941541847@noble.neil.brown.name>
 <CA+KHdyWev2RwoO1o9OrAkaE2VdC7iSXnJdBR+qzarqYOse3cXA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+KHdyWev2RwoO1o9OrAkaE2VdC7iSXnJdBR+qzarqYOse3cXA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 26-10-21 16:25:07, Uladzislau Rezki wrote:
> On Tue, Oct 26, 2021 at 12:24 PM NeilBrown <neilb@suse.de> wrote:
> >
> > On Tue, 26 Oct 2021, Michal Hocko wrote:
> > > On Tue 26-10-21 10:50:21, Neil Brown wrote:
> > > > On Mon, 25 Oct 2021, Uladzislau Rezki wrote:
> > > > > On Fri, Oct 22, 2021 at 09:49:08AM +1100, NeilBrown wrote:
> > > > > > However I'm not 100% certain, and the behaviour might change in the
> > > > > > future.  So having one place (the definition of memalloc_retry_wait())
> > > > > > where we can change the sleeping behaviour if the alloc_page behavour
> > > > > > changes, would be ideal.  Maybe memalloc_retry_wait() could take a
> > > > > > gfpflags arg.
> > > > > >
> > > > > At sleeping is required for __get_vm_area_node() because in case of lack
> > > > > of vmap space it will end up in tight loop without sleeping what is
> > > > > really bad.
> > > > >
> > > > So vmalloc() has two failure modes.  alloc_page() failure and
> > > > __alloc_vmap_area() failure.  The caller cannot tell which...
> > > >
> > > > Actually, they can.  If we pass __GFP_NOFAIL to vmalloc(), and it fails,
> > > > then it must have been __alloc_vmap_area() which failed.
> > > > What do we do in that case?
> > > > Can we add a waitq which gets a wakeup when __purge_vmap_area_lazy()
> > > > finishes?
> > > > If we use the spinlock from that waitq in place of free_vmap_area_lock,
> > > > then the wakeup would be nearly free if no-one was waiting, and worth
> > > > while if someone was waiting.
> > >
> > > Is this really required to be part of the initial support?
> >
> > No.... I was just thinking out-loud.
> >
> alloc_vmap_area() has an retry path, basically if it fails the code
> will try to "purge"
> areas and repeat it one more time. So we do not need to purge outside some where
> else.

I think that Neil was not concerned about the need for purging something
but rather a waiting event the retry loop could hook into. So that the
sleep wouldn't have to be a random timeout but something that is
actually actionable - like somebody freeing an area.
-- 
Michal Hocko
SUSE Labs
