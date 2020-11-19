Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DE132B94A5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Nov 2020 15:35:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727809AbgKSObj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Nov 2020 09:31:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727776AbgKSObi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Nov 2020 09:31:38 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9021BC0613CF;
        Thu, 19 Nov 2020 06:31:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=NcB7TowBxg+8RrEpyWQ1COMK3vqA38tzVoK0JuKHuhw=; b=Ne8XzPtP6OXLBba7HW60H3cy+F
        0xERT5uDiMwViwRqBocQJVRQpIbv0Krm93tMQyuuF+eMd76gBDlTAIynHEkU8bPjfTlyWeFDr/N7M
        gonuYnCW/KW3Dj60bShSgIm/8JbWfGuH1NU+zFphu7cambRMtVcKzfqfrl5UsqApFd7bBvIYqW8ED
        YJM5aefJyOkyv3A0j13zTJSTtnytQksLsdsgTYQj5ztlHTkMrrThLFVQGhsx4KiTtR/PtT0rLV48E
        ocbZxOma6TX/UQJbpgemRilMvVsy3HOvC7y4qqbf1Yxj9lD39GRsUrOjM6wC6vo937mc4ckpINDPZ
        mHYrl5QA==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kfkyB-0007xo-NZ; Thu, 19 Nov 2020 14:31:31 +0000
Date:   Thu, 19 Nov 2020 14:31:31 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc:     David Laight <David.Laight@aculab.com>,
        Arnd Bergmann <arnd@kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Soheil Hassas Yeganeh <soheil.kdev@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Shuo Chen <shuochen@google.com>,
        linux-man <linux-man@vger.kernel.org>,
        Willem de Bruijn <willemb@google.com>
Subject: Re: [PATCH v3 1/2] epoll: add nsec timeout support with epoll_pwait2
Message-ID: <20201119143131.GG29991@casper.infradead.org>
References: <20201118144617.986860-1-willemdebruijn.kernel@gmail.com>
 <20201118144617.986860-2-willemdebruijn.kernel@gmail.com>
 <20201118150041.GF29991@casper.infradead.org>
 <CA+FuTSdxNBvNMy341EHeiKOWZ19H++aw-tfr6Fx1mFmbg-z4zQ@mail.gmail.com>
 <CAK8P3a0t02o77+8QNZwXF2k1pY3Xrm5bydv8Vx1TW060P7BKqA@mail.gmail.com>
 <893e8ed21e544d048bff7933013332a0@AcuMS.aculab.com>
 <CAF=yD-+arBFuZCU3UDx0XKmUGaEz8P1EaDLPK0YFCz82MdwBcg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAF=yD-+arBFuZCU3UDx0XKmUGaEz8P1EaDLPK0YFCz82MdwBcg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Nov 19, 2020 at 09:19:35AM -0500, Willem de Bruijn wrote:
> But for epoll, this is inefficient: in ep_set_mstimeout it calls
> ktime_get_ts64 to convert timeout to an offset from current time, only
> to pass it to select_estimate_accuracy to then perform another
> ktime_get_ts64 and subtract this to get back to (approx.) the original
> timeout.
> 
> How about a separate patch that adds epoll_estimate_accuracy with
> the same rules (wrt rt_task, current->timer_slack, nice and upper bound)
> but taking an s64 timeout.
> 
> One variation, since it is approximate, I suppose we could even replace
> division by a right shift?
> 
> After that, using s64 everywhere is indeed much simpler. And with that
> I will revise the new epoll_pwait2 interface to take a long long
> instead of struct timespec.

I think the userspace interface should take a struct timespec
for consistency with ppoll and pselect.  And epoll should use
poll_select_set_timeout() to convert the relative timeout to an absolute
endtime.  Make epoll more consistent with select/poll, not less ...
