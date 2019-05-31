Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C3F233130B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 May 2019 18:51:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726888AbfEaQvs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 31 May 2019 12:51:48 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48316 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbfEaQvs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 31 May 2019 12:51:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=/T9xgnaJCE7s+nUrgg1lTxdX7p0OidUTw5gqxDihpwY=; b=XtKyKozmG1M0+2PGSw6+aVLBF
        BiKnzafQF+sRmuWNWi7SXf8PmEyIPFheh9YcfrXTjWWxL1QtbeI3he9WWAdg/EPVPHhXXDZdrm13w
        w6kAan4hib8Jmh+9OmDjGU7qmjnwis61FmWsQSw8pZXguq/XpcHxAUPHRonM/uKPK4IAu/N8V2H2a
        Ce1IddQ1b1kYbtQIcFNPFKi5Ups2EJyUrop653NlN38b8zdG7ZqBskuY5EGN61kRD5ZVIc+YQG0rk
        L47xb8AkXTHNu+SjmBfolO+i6hsy/nIpOw8J/DaKk9xRC+TbY/3yLm1Q/zcrBiqC5XZY0k67H/Rks
        5W3A3xYXQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hWkkr-0003Y0-Kj; Fri, 31 May 2019 16:51:45 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 26575201CF1CB; Fri, 31 May 2019 18:51:44 +0200 (CEST)
Date:   Fri, 31 May 2019 18:51:44 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Roman Penyaev <rpenyaev@suse.de>
Cc:     azat@libevent.org, akpm@linux-foundation.org,
        viro@zeniv.linux.org.uk, torvalds@linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 06/13] epoll: introduce helpers for adding/removing
 events to uring
Message-ID: <20190531165144.GE2606@hirez.programming.kicks-ass.net>
References: <20190516085810.31077-1-rpenyaev@suse.de>
 <20190516085810.31077-7-rpenyaev@suse.de>
 <20190531095607.GC17637@hirez.programming.kicks-ass.net>
 <274e29d102133f3be1f309c66cb0af36@suse.de>
 <20190531125636.GZ2606@hirez.programming.kicks-ass.net>
 <98e74ceeefdffc9b50fb33e597d270f7@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <98e74ceeefdffc9b50fb33e597d270f7@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 31, 2019 at 04:21:30PM +0200, Roman Penyaev wrote:

> The ep_add_event_to_uring() is lockless, thus I can't increase tail after,
> I need to reserve the index slot, where to write to.  I can use shadow tail,
> which is not seen by userspace, but I have to guarantee that tail is updated
> with shadow tail *after* all callers of ep_add_event_to_uring() are left.
> That is possible, please see the code below, but it adds more complexity:
> 
> (code was tested on user side, thus has c11 atomics)
> 
> static inline void add_event__kernel(struct ring *ring, unsigned bit)
> {
>         unsigned i, cntr, commit_cntr, *item_idx, tail, old;
> 
>         i = __atomic_fetch_add(&ring->cntr, 1, __ATOMIC_ACQUIRE);
>         item_idx = &ring->user_itemsindex[i % ring->nr];
> 
>         /* Update data */
>         *item_idx = bit;
> 
>         commit_cntr = __atomic_add_fetch(&ring->commit_cntr, 1,
> __ATOMIC_RELEASE);
> 
>         tail = ring->user_header->tail;
>         rmb();
>         do {
>                 cntr = ring->cntr;
>                 if (cntr != commit_cntr)
>                         /* Someone else will advance tail */
>                         break;
> 
>                 old = tail;
> 
>         } while ((tail =
> __sync_val_compare_and_swap(&ring->user_header->tail, old, cntr)) != old);
> }

Yes, I'm well aware of that particular problem (see
kernel/events/ring_buffer.c:perf_output_put_handle for instance). But
like you show, it can be done. It also makes the thing wait-free, as
opposed to merely lockless.


