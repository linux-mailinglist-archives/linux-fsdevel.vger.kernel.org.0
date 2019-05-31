Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26DC53131D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 May 2019 18:54:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726967AbfEaQxy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 31 May 2019 12:53:54 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:51738 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbfEaQxy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 31 May 2019 12:53:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=EwwHRpwcuNoUVD2uOJfJisf1Ruiz96l2Tq7xkdtjsco=; b=er11kocxvUKsBah4spbwucg2T
        gmxEUmaH7MI+j1gwH5cpm2dHtkL47LA+NGOXt1j0glcDnqm2EMqgxfM5ynMP8pT6lBKivIIIf4l1/
        0PLb1QaiUM7lnqKih9OfjvumXD8F+lvCYms3/Bu6miiB7cJ4sLBK0ahPeLYo8VWC4UOQE04Rm67wK
        YARlict22WmnbqQ2Fj83Zjrj5TgggM5Fdghr5LvzELbTSElogzwoPyaaZu6YlH65lfXKVT7Fhg+Ih
        NLJx4Hytm9n4XDR87Ah6BfLTZyieb6N3AcgLwxpaLTEB9OJ7nOa7WqrGxbgNvPySNTLQg0VrZgdYL
        6s665T4ow==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hWkmt-0004Az-DM; Fri, 31 May 2019 16:53:51 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id DCB70201CF1CB; Fri, 31 May 2019 18:53:49 +0200 (CEST)
Date:   Fri, 31 May 2019 18:53:49 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Roman Penyaev <rpenyaev@suse.de>
Cc:     azat@libevent.org, akpm@linux-foundation.org,
        viro@zeniv.linux.org.uk, torvalds@linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 06/13] epoll: introduce helpers for adding/removing
 events to uring
Message-ID: <20190531165349.GF2606@hirez.programming.kicks-ass.net>
References: <20190516085810.31077-1-rpenyaev@suse.de>
 <20190516085810.31077-7-rpenyaev@suse.de>
 <20190531095607.GC17637@hirez.programming.kicks-ass.net>
 <274e29d102133f3be1f309c66cb0af36@suse.de>
 <20190531125322.GY2606@hirez.programming.kicks-ass.net>
 <ef6cb59e319f185619e531c0a39bd32a@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef6cb59e319f185619e531c0a39bd32a@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 31, 2019 at 04:28:36PM +0200, Roman Penyaev wrote:
> On 2019-05-31 14:53, Peter Zijlstra wrote:
> > On Fri, May 31, 2019 at 01:15:21PM +0200, Roman Penyaev wrote:
> > > On 2019-05-31 11:56, Peter Zijlstra wrote:
> > > > On Thu, May 16, 2019 at 10:58:03AM +0200, Roman Penyaev wrote:
> > 
> > > > > +		i = __atomic_fetch_add(&ep->user_header->tail, 1,
> > > > > +				       __ATOMIC_ACQUIRE);
> > > >
> > > > afaict __atomic_fetch_add() does not exist.
> > > 
> > > That is gcc extension.  I did not find any API just to increment
> > > the variable atomically without using/casting to atomic.  What
> > > is a proper way to achieve that?
> > 
> > That's C11 atomics, and those shall not be used in the kernel. For one
> > they're not available in the minimally required GCC version (4.6).
> > 
> > The proper and only way is to use atomic_t, but also you cannot share
> > atomic_t with userspace.
> 
> Yes, that what I tried to avoid choosing c11 extension.
> 
> > 
> > The normal way of doing something like this is to have a kernel private
> > atomic_t and copy the value out to userspace using smp_store_release().
> 
> Since this path is lockless unfortunately that won't work.  So seems
> the only way is to do one more cmpxchg (sigh) or give up and take a
> look (sad sigh).

Of course it works; most of the extant buffers already have a shadow
tail and do the update to userspace with a store-release.
