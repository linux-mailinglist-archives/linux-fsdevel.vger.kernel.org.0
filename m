Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 118A734CFB2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Mar 2021 14:07:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231424AbhC2MGi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Mar 2021 08:06:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231134AbhC2MGV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Mar 2021 08:06:21 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84573C061574;
        Mon, 29 Mar 2021 05:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=jPqmoCTVjpdR+TC/HOWruAFwqDXN0CS1n2BuyezFyoE=; b=pox+54wjS6cfy8s+m5nEx/JQK/
        PVSxEknRetnIJIKU6ewOc6S9KDRXXsz2gEMkUQCeFoJvtGb1+3oppNz6a2o2CpIvEk27hUHVs03AY
        1rGoLvEYqpV9RwdwHCMXO/SyA3LggcqdOQ1wyTa++ysesZhbGpn8WteTv/I3JgxGvzlfk+IiMY/pO
        qEnLcpxpQN+9LqW9OurAmtvP9H/RRZWrjHzmNEoTwgtp+BIvPv9V49la1PHeagEaJny43hGF7r2Ia
        cYhMe8z83tdl9GFmn++OoIWZGNAaJgJqRUoR/qWD1SyqoNmGPJuD1zuxR5a7Pi8OH7FnTYEeDWSoB
        3GT7xicw==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lQqeC-001Wp8-8D; Mon, 29 Mar 2021 12:05:40 +0000
Date:   Mon, 29 Mar 2021 13:05:32 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Luis Henriques <lhenriques@suse.de>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm <linux-mm@kvack.org>
Subject: Re: fuse: kernel BUG at mm/truncate.c:763!
Message-ID: <20210329120532.GB351017@casper.infradead.org>
References: <20210312131123.GZ3479805@casper.infradead.org>
 <YE8tQc66C6MW7EqY@suse.de>
 <20210315110659.GT2577561@casper.infradead.org>
 <YFMct4z1gEa8tXkh@suse.de>
 <CAJfpeguX7NrdTH4JLbCtkQ1u7TFvUh+8s7RmwB_wmuPHJsQyiA@mail.gmail.com>
 <20210318110302.nxddmrhmgmlw4adq@black.fi.intel.com>
 <YFM5mEZ8dZBhZWLI@suse.de>
 <20210318115543.GM3420@casper.infradead.org>
 <YFRoqYYqATd6R9GF@suse.de>
 <YGGXhomAy9SF3VwN@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YGGXhomAy9SF3VwN@suse.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 29, 2021 at 10:01:58AM +0100, Luis Henriques wrote:
> On Fri, Mar 19, 2021 at 09:02:33AM +0000, Luis Henriques wrote:
> > On Thu, Mar 18, 2021 at 11:55:43AM +0000, Matthew Wilcox wrote:
> > > On Thu, Mar 18, 2021 at 11:29:28AM +0000, Luis Henriques wrote:
> > > > On Thu, Mar 18, 2021 at 02:03:02PM +0300, Kirill A. Shutemov wrote:
> > > > > On Thu, Mar 18, 2021 at 11:59:59AM +0100, Miklos Szeredi wrote:
> > > > > > > [16247.536348] page:00000000dfe36ab1 refcount:673 mapcount:0 mapping:00000000f982a7f8 index:0x1400 pfn:0x4c65e00
> > > > > > > [16247.536359] head:00000000dfe36ab1 order:9 compound_mapcount:0 compound_pincount:0
> > > > > > 
> > > > > > This is a compound page alright.   Have no idea how it got into fuse's
> > > > > > pagecache.
> > > > > 
> > > > > 
> > > > > Luis, do you have CONFIG_READ_ONLY_THP_FOR_FS enabled?
> > > > 
> > > > Yes, it looks like Tumbleweed kernels have that config option enabled by
> > > > default.  And it this feature was introduced in 5.4 (the bug doesn't seem
> > > > to be reproducible in 5.3).
> > > 
> > > Can you try adding this patch?
> > > 
> > > https://git.infradead.org/users/willy/pagecache.git/commitdiff/369a4fcd78369b7a026bdef465af9669bde98ef4
> > 
> > Good news, looks like this patch fixes the issue[1].  Thanks a lot
> > everyone.  Is this already queued somewhere for 5.12?  Also, it would be
> > nice to have it Cc'ed for stable kernels >= 5.4.
> 
> Ping.  Are you planning to push this for 5.12, or is that queued for the
> 5.13 merged window?  Or "none of the above"? :)

Sorry, dropped the ball on this one.  This patch is good for that point
in the patch series, but I'm not sure it works against upstream in all
cases.  I need to spend some time evaluating it.  Thanks for the reminder.
