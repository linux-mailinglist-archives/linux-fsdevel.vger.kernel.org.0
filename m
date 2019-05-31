Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F83C30C24
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 May 2019 11:56:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbfEaJ4N (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 31 May 2019 05:56:13 -0400
Received: from merlin.infradead.org ([205.233.59.134]:59418 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726002AbfEaJ4N (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 31 May 2019 05:56:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=newM6axnRsLPzVidNzZIs9UXkF30YKMRSAFuj0fIORw=; b=LGsWfVxndsoPcaqAe86E0fcjm
        ACd9wShqg+zN82Gj4OjPnSa1T9+a1I0dGBEIxVp1ACCo+eRXDyZu1wc5PyZoHull9NBCNoMMhSzqE
        Ltp/mVblBHO9eA6MF+5WeRoGTf0JGdxOF9/N3hwK8006xqQWZCiVd6h8jU9j6iTP/fNQ9uCMGQwJG
        R/G7lYCFuHLfWAJj9q7bgmhoVvG7Gcd6mWO2n2toyEqVMTtBr5oqsuQAl8h/o+RKf545ZXH6YiUuX
        YY+ZZ4ADIcugpA3QCuJcKPsQx8OiV9WSKM/hFeDkdV8DgISAzi86B1Y/ytfaEyoqDE5nFiKicdH4x
        KpAt9uuXQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hWeGf-0003jo-5Y; Fri, 31 May 2019 09:56:09 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id EAE96201D5AB1; Fri, 31 May 2019 11:56:07 +0200 (CEST)
Date:   Fri, 31 May 2019 11:56:07 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Roman Penyaev <rpenyaev@suse.de>
Cc:     azat@libevent.org, akpm@linux-foundation.org,
        viro@zeniv.linux.org.uk, torvalds@linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 06/13] epoll: introduce helpers for adding/removing
 events to uring
Message-ID: <20190531095607.GC17637@hirez.programming.kicks-ass.net>
References: <20190516085810.31077-1-rpenyaev@suse.de>
 <20190516085810.31077-7-rpenyaev@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190516085810.31077-7-rpenyaev@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 16, 2019 at 10:58:03AM +0200, Roman Penyaev wrote:
> +static inline bool ep_add_event_to_uring(struct epitem *epi, __poll_t pollflags)
> +{
> +	struct eventpoll *ep = epi->ep;
> +	struct epoll_uitem *uitem;
> +	bool added = false;
> +
> +	if (WARN_ON(!pollflags))
> +		return false;
> +
> +	uitem = &ep->user_header->items[epi->bit];
> +	/*
> +	 * Can be represented as:
> +	 *
> +	 *    was_ready = uitem->ready_events;
> +	 *    uitem->ready_events &= ~EPOLLREMOVED;
> +	 *    uitem->ready_events |= pollflags;
> +	 *    if (!was_ready) {
> +	 *         // create index entry
> +	 *    }
> +	 *
> +	 * See the big comment inside ep_remove_user_item(), why it is
> +	 * important to mask EPOLLREMOVED.
> +	 */
> +	if (!atomic_or_with_mask(&uitem->ready_events,
> +				 pollflags, EPOLLREMOVED)) {
> +		unsigned int i, *item_idx, index_mask;
> +
> +		/*
> +		 * Item was not ready before, thus we have to insert
> +		 * new index to the ring.
> +		 */
> +
> +		index_mask = ep_max_index_nr(ep) - 1;
> +		i = __atomic_fetch_add(&ep->user_header->tail, 1,
> +				       __ATOMIC_ACQUIRE);

afaict __atomic_fetch_add() does not exist.

> +		item_idx = &ep->user_index[i & index_mask];
> +
> +		/* Signal with a bit, which is > 0 */
> +		*item_idx = epi->bit + 1;

Did you just increment the user visible tail pointer before you filled
the data? That is, can the concurrent userspace observe the increment
before you put credible data in its place?

> +
> +		/*
> +		 * Want index update be flushed from CPU write buffer and
> +		 * immediately visible on userspace side to avoid long busy
> +		 * loops.
> +		 */
> +		smp_wmb();

That's still complete nonsense.

> +
> +		added = true;
> +	}
> +
> +	return added;
> +}
