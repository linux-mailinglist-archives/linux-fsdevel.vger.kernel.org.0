Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D2143A9B59
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jun 2021 14:59:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233060AbhFPNCC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Jun 2021 09:02:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232223AbhFPNCC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Jun 2021 09:02:02 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C2BDC061574
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Jun 2021 05:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=lfw8lfM2l/lO7umZudZ/kXGnym6w3wF3tdbQEYLNpwk=; b=n895TNXj+56c5Pk24vk4tssjCu
        PGTMZF0DGD5t7R6Utt5q7ENiOfs1tEL5g2nYzgUxcz1s2fxRWytioURKNf9vyYNcbDnUrgRdwBOGa
        atQjRdgXb589Q+oTg/h2ZMoLm9Mvzrlzq9tqKxK6o7STsz/QpZsMKFWM3057LJ7NdBD+Xl3gHYjTt
        h/9o4U/vw46oLQTTpMHSGPGeN2zaPgQi0tYAPE+S99Ve24rrNrjeLGPqjzRcFGQkehwJlrmQz6ntL
        6177vOJD7FouENM36+TPcFmgS8glsWiffBRAz4Le0HuT9WJp6Up1hmNiED/G9uOcn66FiUYoBGlZf
        bDmMQfQg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ltV8l-0083GF-Cf; Wed, 16 Jun 2021 12:59:38 +0000
Date:   Wed, 16 Jun 2021 13:59:31 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-mm <linux-mm@kvack.org>, linux-fsdevel@vger.kernel.org,
        Thomas Lindroth <thomas.lindroth@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: Possible bogus "fuse: trying to steal weird page" warning
 related to PG_workingset.
Message-ID: <YMn1s19wMQdGDQuQ@casper.infradead.org>
References: <016b2fe2-0d52-95c9-c519-40b14480587a@gmail.com>
 <CAJfpeguzkDQ5VL3m19jrepf1YjFeJ2=q99TurTX6DRpAKz+Omg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpeguzkDQ5VL3m19jrepf1YjFeJ2=q99TurTX6DRpAKz+Omg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 16, 2021 at 02:31:32PM +0200, Miklos Szeredi wrote:
> On Mon, 14 Jun 2021 at 11:56, Thomas Lindroth <thomas.lindroth@gmail.com> wrote:
> >
> > Hi. I recently upgraded to kernel series 5.10 from 4.19 and I now get warnings like
> > this in dmesg:
> >
> > page:00000000e966ec4e refcount:1 mapcount:0 mapping:0000000000000000 index:0xd3414 pfn:0x14914a
> > flags: 0x8000000000000077(locked|referenced|uptodate|lru|active|workingset)
> > raw: 8000000000000077 ffffdc7f4d312b48 ffffdc7f452452c8 0000000000000000
> > raw: 00000000000d3414 0000000000000000 00000001ffffffff ffff8fd080123000
> > page dumped because: fuse: trying to steal weird page
> >
> > The warning in fuse_check_page() doesn't check for PG_workingset which seems to be what
> > trips the warning. I'm not entirely sure this is a bogus warning but there used to be
> > similar bogus warnings caused by a missing PG_waiters check. The PG_workingset
> > page flag was introduced in 4.20 which explains why I get the warning now.
> >
> > I only get the new warning if I do writes to a fuse fs (mergerfs) and at the same
> > time put the system under memory pressure by running many qemu VMs.
> 
> AFAICT fuse is trying to steal a pagecache page from a pipe buffer
> created by splice(2).    The page looks okay, but I have no idea what
> PG_workingset means in this context.
> 
> Matthew, can you please help?

PG_workingset was introduced by Johannes:

    mm: workingset: tell cache transitions from workingset thrashing

    Refaults happen during transitions between workingsets as well as in-place
    thrashing.  Knowing the difference between the two has a range of
    applications, including measuring the impact of memory shortage on the
    system performance, as well as the ability to smarter balance pressure
    between the filesystem cache and the swap-backed workingset.

    During workingset transitions, inactive cache refaults and pushes out
    established active cache.  When that active cache isn't stale, however,
    and also ends up refaulting, that's bonafide thrashing.

    Introduce a new page flag that tells on eviction whether the page has been
    active or not in its lifetime.  This bit is then stored in the shadow
    entry, to classify refaults as transitioning or thrashing.

so I think it's fine for you to ignore when stealing a page.
