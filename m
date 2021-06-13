Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A7E83A5A44
	for <lists+linux-fsdevel@lfdr.de>; Sun, 13 Jun 2021 22:04:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231863AbhFMUGk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 13 Jun 2021 16:06:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231788AbhFMUGj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 13 Jun 2021 16:06:39 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEA25C061574;
        Sun, 13 Jun 2021 13:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=5jdQRt7Z6/fU16jagmX4zMd3V2C9IXzmhJfviU+tOnQ=; b=hQ/qBOQmNo7mysrvLMExqqTH+J
        ME/ZUm3b9yftNm/SBF+rKA9X6l6xSER9K/SDj3slAaJ3Uu+4Q5ah/8TCY5TyP0/6QfW6pxC6WZXlU
        FbnDKUmpHncA6xtYMa9Zjcmj/c51Bjw+d5mNGJB9KgMTyEnqp6p2nj+VlZ5zOW6ICr3agJlsICCT7
        WLdmqufNVzTdXwlTVNfBBc58vB/K0Od+EafPW4WHo/oTAI+UsSoN6cJiI8zhdHcRfPA5SJ1Ck9PnN
        dJc6+xooSRrtySmcz4MH5criXvgTsvRXk9pfK4dcNxdIqm6IVtECaCPWtu3vWoJEMlVS8kk/zdFuO
        Wpyy1l4A==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lsWLC-004lqs-Vt; Sun, 13 Jun 2021 20:04:21 +0000
Date:   Sun, 13 Jun 2021 21:04:18 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     David Mozes <david.mozes@silk.us>
Cc:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: futex/call -to plist_for_each_entry_safe with head=NULL
Message-ID: <YMZkwsa4yQ/SsMW/@casper.infradead.org>
References: <AM6PR04MB563958D1E2CA011493F4BCC8F1329@AM6PR04MB5639.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AM6PR04MB563958D1E2CA011493F4BCC8F1329@AM6PR04MB5639.eurprd04.prod.outlook.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jun 13, 2021 at 12:24:52PM +0000, David Mozes wrote:
> Hi *,
> Under a very high load of io traffic, we got the below  BUG trace.
> We can see that:
> plist_for_each_entry_safe(this, next, &hb1->chain, list) {
>                 if (match_futex (&this->key, &key1))
>  
> were called with hb1 = NULL at futex_wake_up function.
> And there is no protection on the code regarding such a scenario.
>  
> The NULL can  be geting from:
> hb1 = hash_futex(&key1);
>  
> How can we protect against such a situation?

Can you reproduce it without loading proprietary modules?

Your analysis doesn't quite make sense:

        hb1 = hash_futex(&key1);
        hb2 = hash_futex(&key2);

retry_private:
        double_lock_hb(hb1, hb2);

If hb1 were NULL, then the oops would come earlier, in double_lock_hb().

> RIP: 0010:do_futex+0xdf/0xa90
>  
> 0xffffffff81138eff is in do_futex (kernel/futex.c:1748).
> 1743                                       put_futex_key(&key1);
> 1744                                       cond_resched();
> 1745                                       goto retry;
> 1746                       }
> 1747      
> 1748                       plist_for_each_entry_safe(this, next, &hb1->chain, list) {
> 1749                                       if (match_futex (&this->key, &key1)) {
> 1750                                                       if (this->pi_state || this->rt_waiter) {
> 1751                                                                       ret = -EINVAL;
> 1752                                                                       goto out_unlock;
> (gdb)
>  
>  
>  
> plist_for_each_entry_safe(this, next, &hb1->chain, list) {
>                 if (match_futex (&this->key, &key1)) {
>  
>  
>  
>  
> This happened in kernel  4.19.149 running on Azure vm
>  
>  
> Thx
> David
> Reply 
> Forward 
> MO
> 
