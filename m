Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B32FF159FB4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2020 04:58:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727912AbgBLD6Q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Feb 2020 22:58:16 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:46666 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726755AbgBLD6Q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Feb 2020 22:58:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=83fhIJoXHGyKFWR0u7GybPdUeA+T811CmfH2NEzMBKs=; b=qQb1eqz1vnxMwy5irhYz9tECh5
        H1c/xd8lbLfnFVuL0y5zQoQEGaW1KcYvkjvwtZR7TnE2Mod+7IFSEjbpmcWTUQ2ZWGCtU789JNBVv
        BckOqsWP9F/S2Q/E3otdfd8pp5Ng2vxwkHxXpcTr84EDxSrfskHK/Rj3BqlWMWYFVwUGn+qUuiHuo
        Zvw3CIG10BrMfVVTdjMbRr7O4XNYQAPDTl3EQW6dnXmF+erO8yFnsRAQZ164bdr5DaWuqqAA+tMin
        nY8MULH8b3gpX49NSgYLQQW065vTn0UZYKzeJvlNAnAr3OmdfnOvYCxo2pQ4182h6SfshHGPk/BkG
        zJ59Pprg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j1jAC-0007pr-BC; Wed, 12 Feb 2020 03:58:12 +0000
Date:   Tue, 11 Feb 2020 19:58:12 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Rik van Riel <riel@surriel.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Yafang Shao <laoar.shao@gmail.com>,
        Michal Hocko <mhocko@suse.com>, Roman Gushchin <guro@fb.com>,
        Al Viro <viro@zeniv.linux.org.uk>, kernel-team@fb.com
Subject: Re: [PATCH] vfs: keep inodes with page cache off the inode shrinker
 LRU
Message-ID: <20200212035812.GB7778@bombadil.infradead.org>
References: <20200211175507.178100-1-hannes@cmpxchg.org>
 <29b6e848ff4ad69b55201751c9880921266ec7f4.camel@surriel.com>
 <20200211193101.GA178975@cmpxchg.org>
 <20200211154438.14ef129db412574c5576facf@linux-foundation.org>
 <CAHk-=wiGbz3oRvAVFtN-whW-d2F-STKsP1MZT4m_VeycAr1_VQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiGbz3oRvAVFtN-whW-d2F-STKsP1MZT4m_VeycAr1_VQ@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 11, 2020 at 04:28:39PM -0800, Linus Torvalds wrote:
> On Tue, Feb 11, 2020 at 3:44 PM Andrew Morton <akpm@linux-foundation.org> wrote:
> > Testing this will be a challenge, but the issue was real - a 7GB
> > highmem machine isn't crazy and I expect the inode has become larger
> > since those days.
> 
> Hmm. I would say that in the intening years a 7GB highmem machine has
> indeed become crazy.
> 
> It used to be something we kind of supported.
> 
> But we really should consider HIGHMEM to be something that is on the
> deprecation list. In this day and age, there is no excuse for running
> a 32-bit kernel with lots of physical memory.
> 
> And if you really want to do that, and have some legacy hardware with
> a legacy use case, maybe you should be using a legacy kernel.
> 
> I'd personally be perfectly happy to start removing HIGHMEM support again.

Do we have a use case where people want to run modern 32-bit guest kernels
with more than 896MB of memory to support some horrendous legacy app?
Or is our 32-bit compat story good enough that nobody actually does this?
(Contrariwise, maybe those people are also fine with running a ten year
old kernel because a `uname -r` starting with '3' breaks said app)
