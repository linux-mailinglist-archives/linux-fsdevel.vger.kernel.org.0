Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C618030C1D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 May 2019 11:55:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726376AbfEaJzp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 31 May 2019 05:55:45 -0400
Received: from merlin.infradead.org ([205.233.59.134]:59388 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726002AbfEaJzp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 31 May 2019 05:55:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=/Zord7seNBzhUafSuIBHm4OaaB72C8b3aEKI2TGY3Eo=; b=uM3/WxEw3+ad8Ccx/yvYlEKAJ
        Wmxp/AdSi3D7DHwlH+F4+N+7bmDXPdgqMOIYDNaguwwptrDg9KgK+mafLIdWsgMWkhIOiqN1Wbu0W
        4KPgx+YplXDlqnxt8x9wQ7jZ/t3P4jjm8MqdgO8KLuPHVRplulI3zIWuhQ3LMeT/+r1tpJBy5B7xR
        RH4YJls32z89Yr3AIfYAHTOCLNwiTQMjLdTNWWfcgAxobGSIpYtBQ+SgSyBNcoiEO0Ti7Q29sNEmS
        IENs55mDWIOve/R3NKuArMl5TmZl3agdT6aS9IIBXjcua/eRB8G6J3+exZ3ThjdOMA80xyISoEjOh
        0wVr1VAMw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hWeG8-0003j6-LM; Fri, 31 May 2019 09:55:38 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7276B201D5AB1; Fri, 31 May 2019 11:55:35 +0200 (CEST)
Date:   Fri, 31 May 2019 11:55:35 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Roman Penyaev <rpenyaev@suse.de>
Cc:     azat@libevent.org, akpm@linux-foundation.org,
        viro@zeniv.linux.org.uk, torvalds@linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 00/13] epoll: support pollable epoll from userspace
Message-ID: <20190531095535.GA17637@hirez.programming.kicks-ass.net>
References: <20190516085810.31077-1-rpenyaev@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190516085810.31077-1-rpenyaev@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 16, 2019 at 10:57:57AM +0200, Roman Penyaev wrote:
> When new event comes for some epoll item kernel does the following:
> 
>  struct epoll_uitem *uitem;
> 
>  /* Each item has a bit (index in user items array), discussed later */
>  uitem = user_header->items[epi->bit];
> 
>  if (!atomic_fetch_or(uitem->ready_events, pollflags)) {
>      i = atomic_add(&ep->user_header->tail, 1);
> 
>      item_idx = &user_index[i & index_mask];
> 
>      /* Signal with a bit, user spins on index expecting value > 0 */
>      *item_idx = idx + 1;
> 
>     /*
>      * Want index update be flushed from CPU write buffer and
>      * immediately visible on userspace side to avoid long busy
>      * loops.
>      */

That is garbage; smp_wmb() does no such thing.

>      smp_wmb();
>  }
