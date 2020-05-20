Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5B4B1DB32D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 May 2020 14:28:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726560AbgETM2k (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 May 2020 08:28:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbgETM2k (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 May 2020 08:28:40 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2081AC061A0E;
        Wed, 20 May 2020 05:28:40 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jbNpT-0007eq-NN; Wed, 20 May 2020 14:28:11 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 1AC03100C99; Wed, 20 May 2020 14:28:11 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Peter Zijlstra <peterz@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Will Deacon <will@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/8] radix-tree: Use local_lock for protection
In-Reply-To: <20200520102110.GE317569@hirez.programming.kicks-ass.net>
References: <20200519201912.1564477-1-bigeasy@linutronix.de> <20200519201912.1564477-3-bigeasy@linutronix.de> <20200520102110.GE317569@hirez.programming.kicks-ass.net>
Date:   Wed, 20 May 2020 14:28:11 +0200
Message-ID: <874ksa6bac.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Peter Zijlstra <peterz@infradead.org> writes:
> On Tue, May 19, 2020 at 10:19:06PM +0200, Sebastian Andrzej Siewior wrote:
>> @@ -64,6 +64,7 @@ struct radix_tree_preload {
>>  	struct radix_tree_node *nodes;
>>  };
>>  static DEFINE_PER_CPU(struct radix_tree_preload, radix_tree_preloads) = { 0, };
>> +static DEFINE_LOCAL_LOCK(radix_tree_preloads_lock);
>>  
>>  static inline struct radix_tree_node *entry_to_node(void *ptr)
>>  {
>
> So I'm all with Andrew on the naming and pass-by-pointer thing, but
> also, the above is pretty crap. You want the local_lock to be in the
> structure you're actually protecting, and there really isn't anything
> stopping you from doing that.
>
> The below builds just fine and is ever so much more sensible.

Right you are. It's pretty obvious now that you hit me over the head
with it.

Note to self: Remove the brown paperbag _before_ touching code.
