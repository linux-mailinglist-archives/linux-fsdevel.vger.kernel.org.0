Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69E152BA04F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Nov 2020 03:25:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbgKTCYm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Nov 2020 21:24:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53549 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726199AbgKTCYm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Nov 2020 21:24:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605839081;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VQ9D3r+1A447JsLtjnYIsDZTTCNO7eTqqaIEx3Zq9b8=;
        b=BJ8jYlmcj7KHfYV4Fb3BEcE9DJ2JQ3olwxJDp35xBtmUe33hfgdZRBEnC8Wfc2UvSgA2Os
        rn9GCgEWDQjVqU0XntvX5CRXfn2tv/jBB8ihAFxXC4xH/isxjV6sOeZfx95uFVvbzp+GR2
        LMh5PPzGtMGymkP714hKhcjijU9ntWE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-153-gmrJeu0QPQOmWuK204KoTg-1; Thu, 19 Nov 2020 21:24:39 -0500
X-MC-Unique: gmrJeu0QPQOmWuK204KoTg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 70B8B8143F3;
        Fri, 20 Nov 2020 02:24:37 +0000 (UTC)
Received: from T590 (ovpn-13-9.pek2.redhat.com [10.72.13.9])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CB82760854;
        Fri, 20 Nov 2020 02:24:30 +0000 (UTC)
Date:   Fri, 20 Nov 2020 10:24:26 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Pavel Begunkov <asml.silence@gmail.com>,
        linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] iov_iter: optimise iov_iter_npages for bvec
Message-ID: <20201120022426.GC333150@T590>
References: <cover.1605827965.git.asml.silence@gmail.com>
 <ab04202d0f8c1424da47251085657c436d762785.1605827965.git.asml.silence@gmail.com>
 <20201120012017.GJ29991@casper.infradead.org>
 <35d5db17-f6f6-ec32-944e-5ecddcbcb0f1@gmail.com>
 <20201120014904.GK29991@casper.infradead.org>
 <3dc0b17d-b907-d829-bfec-eab96a6f4c30@gmail.com>
 <20201120020610.GL29991@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201120020610.GL29991@casper.infradead.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 20, 2020 at 02:06:10AM +0000, Matthew Wilcox wrote:
> On Fri, Nov 20, 2020 at 01:56:22AM +0000, Pavel Begunkov wrote:
> > On 20/11/2020 01:49, Matthew Wilcox wrote:
> > > On Fri, Nov 20, 2020 at 01:39:05AM +0000, Pavel Begunkov wrote:
> > >> On 20/11/2020 01:20, Matthew Wilcox wrote:
> > >>> On Thu, Nov 19, 2020 at 11:24:38PM +0000, Pavel Begunkov wrote:
> > >>>> The block layer spends quite a while in iov_iter_npages(), but for the
> > >>>> bvec case the number of pages is already known and stored in
> > >>>> iter->nr_segs, so it can be returned immediately as an optimisation
> > >>>
> > >>> Er ... no, it doesn't.  nr_segs is the number of bvecs.  Each bvec can
> > >>> store up to 4GB of contiguous physical memory.
> > >>
> > >> Ah, really, missed min() with PAGE_SIZE in bvec_iter_len(), then it's a
> > >> stupid statement. Thanks!
> > >>
> > >> Are there many users of that? All these iterators are a huge burden,
> > >> just to count one 4KB page in bvec it takes 2% of CPU time for me.
> > > 
> > > __bio_try_merge_page() will create multipage BIOs, and that's
> > > called from a number of places including
> > > bio_try_merge_hw_seg(), bio_add_page(), and __bio_iov_iter_get_pages()
> > 
> > I get it that there are a lot of places, more interesting how often
> > it's actually triggered and if that's performance critical for anybody.
> > Not like I'm going to change it, just out of curiosity, but bvec.h
> > can be nicely optimised without it.
> 
> Typically when you're allocating pages for the page cache, they'll get
> allocated in order and then you'll read or write them in order, so yes,
> it ends up triggering quite a lot.  There was once a bug in the page
> allocator which caused them to get allocated in reverse order and it
> was a noticable performance hit (this was 15-20 years ago).

hugepage use cases can benefit much from this way too.


Thanks,
Ming

