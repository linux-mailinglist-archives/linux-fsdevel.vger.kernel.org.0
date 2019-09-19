Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CCD6AB7F85
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Sep 2019 19:01:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389412AbfISRBw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Sep 2019 13:01:52 -0400
Received: from verein.lst.de ([213.95.11.211]:42775 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731729AbfISRBw (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Sep 2019 13:01:52 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 80CD768B20; Thu, 19 Sep 2019 19:01:48 +0200 (CEST)
Date:   Thu, 19 Sep 2019 19:01:48 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Eric Sandeen <sandeen@sandeen.net>,
        Christoph Hellwig <hch@lst.de>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Bob Peterson <rpeterso@redhat.com>,
        cluster-devel <cluster-devel@redhat.com>
Subject: Re: [GIT PULL] iomap: new code for 5.4
Message-ID: <20190919170148.GA8908@lst.de>
References: <20190917152140.GU2229799@magnolia> <CAHk-=wj9Zjb=NENJ6SViNiYiYi4LFX9WYqskZh4E_OzjijK1VA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wj9Zjb=NENJ6SViNiYiYi4LFX9WYqskZh4E_OzjijK1VA@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 18, 2019 at 06:31:29PM -0700, Linus Torvalds wrote:
> It seems to have come from "list_empty()", but the difference is that
> it actually makes sense to check for emptiness of a list outside
> whatever lock that protects the list. It can be one of those very
> useful optimizations where you don't even bother taking the lock if
> you can optimistically check that the list is empty.
> 
> But the same is _not_ true of an operation like "list_pop()". By
> definition, the list you pop something off has to be stable, so the
> READ_ONCE() makes no sense here.

Indeed.

> Anyway, if that was the only issue, I wouldn't care. But looking
> closer, the whole thing is just completely wrong.
> 
> All the users seem to do some version of this:
> 
>         struct list_head tmp;
> 
>         list_replace_init(&ioend->io_list, &tmp);
>         iomap_finish_ioend(ioend, error);
>         while ((ioend = list_pop_entry(&tmp, struct iomap_ioend, io_list)))
>                 iomap_finish_ioend(ioend, error);
> 
> which is completely wrong and pointless.
> 
> Why would anybody use that odd "list_pop()" thing in a loop, when what
> it really seems to just want is that bog-standard
> "list_for_each_entry_safe()"
> 
>         struct list_head tmp;
>         struct iomap_ioend *next;
> 
>         list_replace_init(&ioend->io_list, &tmp);
>         iomap_finish_ioend(ioend, error);
>         list_for_each_entry_safe(struct iomap_ioend, next, &tmp, io_list)
>                 iomap_finish_ioend(ioend, error);
> 
> which is not only the common pattern, it's more efficient and doesn't
> pointlessly re-write the list for each entry, it just walks it (and
> the "_safe()" part is because it looks up the next entry early, so
> that the entry that it's walking can be deleted).

That might be true for the current two cases that operate on a temporary
local list, but in general we have lots of cases where we operate on
lists that are not just local and where have to delete all the entries.

Sure, we could somehow let them dangle and then just do a INIT_LIST_HEAD
on the list later, but that is just asking for trouble down the road
when people actually use list_empty in the functions called in the loop.
