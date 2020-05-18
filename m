Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F8091D7BC8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 May 2020 16:48:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727036AbgEROs6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 May 2020 10:48:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726918AbgEROs6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 May 2020 10:48:58 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85419C061A0C
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 May 2020 07:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=WjlvcClrJOLEjQBoFKKarIloTgfteERhadKnF2UVyi8=; b=J3VW/m5I78aOuEywLzpWi5kFiP
        ZuZiVjr46MMegWhQbal4+saIWXtMmpgf4A5W3Gqwn61NNGz1nXycVTki3AqVk0VjdrZt5ZR1f9PFC
        QGYpXIwWhnK9doFhMNVtmLEtAx/YuV8erz11CdZdvE0FgPwyPDc/5sJ/bTh90qWzbiyEJXtWyTH47
        UEreCtJjIfARNV1Jm0POSCxDVenbEwBW3U2D+KcwLdaHztWKBUJQVU4sDWPlp1cC4p0oljX15cKGq
        Mv1vH48fqS/71XIu6TNbDh06AZidwYdczRfr2If18xP3pAY4h2JIeeAXtvT14V15ujYyM0yryoRYi
        LH4GQHIw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jah4X-0001Xn-Oa; Mon, 18 May 2020 14:48:53 +0000
Date:   Mon, 18 May 2020 07:48:53 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-fsdevel@vger.kernel.org,
        fuse-devel <fuse-devel@lists.sourceforge.net>,
        linux-mm <linux-mm@kvack.org>, miklos <mszeredi@redhat.com>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        =?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@collabora.com>
Subject: Re: [fuse-devel] fuse: trying to steal weird page
Message-ID: <20200518144853.GT16070@bombadil.infradead.org>
References: <87a72qtaqk.fsf@vostro.rath.org>
 <877dxut8q7.fsf@vostro.rath.org>
 <20200503032613.GE29705@bombadil.infradead.org>
 <87368hz9vm.fsf@vostro.rath.org>
 <20200503102742.GF29705@bombadil.infradead.org>
 <CAJfpegseoCE_mVGPR5Bt8S1WZ2bi2DnUb7QqgPm=okzx_wT31A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegseoCE_mVGPR5Bt8S1WZ2bi2DnUb7QqgPm=okzx_wT31A@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 18, 2020 at 02:45:02PM +0200, Miklos Szeredi wrote:
> On Sun, May 3, 2020 at 12:27 PM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Sun, May 03, 2020 at 09:43:41AM +0100, Nikolaus Rath wrote:
> > > Here's what I got:
> > >
> > > [  221.277260] page:ffffec4bbd639880 refcount:1 mapcount:0 mapping:0000000000000000 index:0xd9
> > > [  221.277265] flags: 0x17ffffc0000097(locked|waiters|referenced|uptodate|lru)
> > > [  221.277269] raw: 0017ffffc0000097 ffffec4bbd62f048 ffffec4bbd619308 0000000000000000
> > > [  221.277271] raw: 00000000000000d9 0000000000000000 00000001ffffffff ffff9aec11beb000
> > > [  221.277272] page dumped because: fuse: trying to steal weird page
> > > [  221.277273] page->mem_cgroup:ffff9aec11beb000
> >
> > Great!  Here's the condition:
> >
> >         if (page_mapcount(page) ||
> >             page->mapping != NULL ||
> >             page_count(page) != 1 ||
> >             (page->flags & PAGE_FLAGS_CHECK_AT_PREP &
> >              ~(1 << PG_locked |
> >                1 << PG_referenced |
> >                1 << PG_uptodate |
> >                1 << PG_lru |
> >                1 << PG_active |
> >                1 << PG_reclaim))) {
> >
> > mapcount is 0, mapping is NULL, refcount is 1, so that's all fine.
> > flags has 'waiters' set, which is not in the allowed list.  I don't
> > know the internals of FUSE, so I don't know why that is.
> >
> > Also, page_count() is unstable.  Unless there has been an RCU grace period
> > between when the page was freed and now, a speculative reference may exist
> > from the page cache.  So I would say this is a bad thing to check for.
> 
> page_cache_pipe_buf_steal() calls remove_mapping() which calls
> page_ref_unfreeze(page, 1).  That sets the refcount to 1, right?
> 
> What am I missing?

find_get_entry() calling page_cache_get_speculative().

In a previous allocation, this page belonged to the page cache.  Then it
was freed, but another thread is in the middle of a page cache lookup and
has already loaded the pointer.  It is now delayed by a few clock ticks.

Now the page is allocated to FUSE, which calls page_ref_unfreeze().
And then the refcount gets bumped to 2 by page_cache_get_speculative().
find_get_entry() calls xas_reload() and discovers this page is no longer
at that index, so it calls put_page(), but in that narrow window, FUSE
checks the refcount and finds it's not 1.

Monumentally unlikely, of course, so you've probably never seen it,
but multiply by the hundreds of millions of devices running Linux,
and somebody will hit it someday.
