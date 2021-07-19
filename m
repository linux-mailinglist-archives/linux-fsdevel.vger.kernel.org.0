Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9F9E3CEC6E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jul 2021 22:18:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354941AbhGSRcS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Jul 2021 13:32:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:37694 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1354056AbhGSR3I (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Jul 2021 13:29:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AB14260E0B;
        Mon, 19 Jul 2021 18:09:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626718187;
        bh=yVXc+cF5aNLGJu/ecX4zzfh62LImbAYUaw260EzaV3Y=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=XZJkEkKnhS+5nXGAZvEEfXMBQcgYGahAcH1PAtx7POsBGoeqUfy0NWB4Bs1JNm0mY
         HRJyC0hFYaqdeBhImc70CBpl6bVS/8rqvwwz1WT285nHfBvDRxaYp7wb+STri2F3eA
         Tn3e/+LivQ2CfpvljvTw7WL+9gsTaQIEXy/yIY8wiiaR5cP7GaWRoysCWkzUj6eB5I
         i5YqSoN4hZ9kploamo17sg8IoveOunCE6Z2hhuNqrj0omnnHXNGR8ERDbe4CU3qxZy
         abGkB0QZzvIcxfF85RZKiGmQ00dyFt+Aer1/cnzZ8I45HIuPl5pqWt0gAks+krJROW
         vhTa9zMyXGqrw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 74B745C2BE5; Mon, 19 Jul 2021 11:09:47 -0700 (PDT)
Date:   Mon, 19 Jul 2021 11:09:47 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Hou Tao <houtao1@huawei.com>, Christoph Hellwig <hch@lst.de>,
        Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        yukuai3@huawei.com, will@kernel.org
Subject: Re: [PATCH] block: ensure the memory order between bi_private and
 bi_status
Message-ID: <20210719180947.GZ4397@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210701113537.582120-1-houtao1@huawei.com>
 <20210715070148.GA8088@lst.de>
 <20210715081348.GG2725@worktop.programming.kicks-ass.net>
 <36a122ea-d18a-9317-aadd-b6b69a6f0283@huawei.com>
 <20210716101929.GD4717@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210716101929.GD4717@worktop.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 16, 2021 at 12:19:29PM +0200, Peter Zijlstra wrote:
> On Fri, Jul 16, 2021 at 05:02:33PM +0800, Hou Tao wrote:
> 
> > > Cachelines don't guarantee anything, you can get partial forwards.
> > 
> > Could you please point me to any reference ? I can not google
> > 
> > any memory order things by using "partial forwards".
> 
> I'm not sure I have references, but there are CPUs that can do, for
> example, store forwarding at a granularity below cachelines (ie at
> register size).
> 
> In such a case a CPU might observe the stored value before it is
> committed to memory.

There have been examples of systems with multiple hardware threads
per core, but where the hardware threads share a store buffer.
In this case, the other threads in the core might see a store before
it is committed to a cache line.

As you might imagine, the hardware implementation of memory barriers
in such a system is tricky.  But not impossible.

							Thanx, Paul
