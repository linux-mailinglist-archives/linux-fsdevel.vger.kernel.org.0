Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18D1F27D4EB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Sep 2020 19:50:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728671AbgI2RuF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Sep 2020 13:50:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:51482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727360AbgI2RuF (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Sep 2020 13:50:05 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A2A0C207F7;
        Tue, 29 Sep 2020 17:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601401804;
        bh=65sTlOSbonjl0DH/ctUrxYFUax2YTAYHEXsq14GJtLc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AH1uY8nfpEgmzJPAXmBxPhIkAd+/QM43Xm28QzzOnjnyHb1jYMUywcAWelZIVePg2
         dLaW8vpud883Y0v7RtIZHO4hdjepAwv0mdNbDTprcvfwDO4EfdRHnQD8Mf7cSxpk8Q
         t/dF1CytWo5HDgf8XPE8mP0Hil10jbc6o9r95KL4=
Date:   Tue, 29 Sep 2020 18:49:59 +0100
From:   Will Deacon <will@kernel.org>
To:     Hou Tao <houtao1@huawei.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>, peterz@infradead.org,
        Oleg Nesterov <oleg@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>
Subject: Re: [RFC PATCH] locking/percpu-rwsem: use this_cpu_{inc|dec}() for
 read_count
Message-ID: <20200929174958.GG14317@willie-the-truck>
References: <20200915140750.137881-1-houtao1@huawei.com>
 <20200915150610.GC2674@hirez.programming.kicks-ass.net>
 <20200915153113.GA6881@redhat.com>
 <20200915155150.GD2674@hirez.programming.kicks-ass.net>
 <20200915160344.GH35926@hirez.programming.kicks-ass.net>
 <b885ce8e-4b0b-8321-c2cc-ee8f42de52d4@huawei.com>
 <20200917084831.GA29295@willie-the-truck>
 <522e22a5-98e8-3a99-8f82-dc3789508638@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <522e22a5-98e8-3a99-8f82-dc3789508638@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 24, 2020 at 07:55:19PM +0800, Hou Tao wrote:
> The following is the newest performance data:
> 
> aarch64 host (4 sockets, 24 cores per sockets)
> 
> * v4.19.111
> 
> no writer, reader cn                                | 24        | 48        | 72        | 96
> rate of percpu_down_read/percpu_up_read per second  |
> default: use __this_cpu_inc|dec()                   | 166129572 | 166064100 | 165963448 | 165203565
> patched: use this_cpu_inc|dec()                     |  87727515 |  87698669 |  87675397 |  87337435
> modified: local_irq_save + __this_cpu_inc|dec()     |  15470357	|  15460642 |  15439423	|  15377199
> 
> * v4.19.111+ [1]
> 
> modified: use this_cpu_inc|dec() + LSE atomic       |   8224023 |   8079416 |	7883046 |   7820350
> 
> * 5.9-rc6
> 
> no writer, reader cn                                | 24        | 48        | 72        | 96
> rate of percpu_down_read/percpu_up_read per second  |
> reverted: use __this_cpu_inc|dec() + revert 91fc957c| 169664061 | 169481176 | 168493488 | 168844423
> reverted: use __this_cpu_inc|dec()                  |  78355071 |  78294285 |  78026030 |  77860492
> modified: use this_cpu_inc|dec() + no LSE atomic    |  64291101 |  64259867 |  64223206 |  63992316
> default: use this_cpu_inc|dec() + LSE atomic        |  16231421 |  16215618 |  16188581 |  15959290
> 
> It seems that enabling LSE atomic has a negative impact on performance under this test scenario.
> 
> And it is astonished to me that for my test scenario the performance of v5.9-rc6 is just one half of v4.19.
> The bisect finds the culprit is 91fc957c9b1d6 ("arm64/bpf: don't allocate BPF JIT programs in module memory").
> If reverting the patch brute-forcibly under 5.9-rc6 [2], the performance will be the same with
> v4.19.111 (169664061 vs 166129572). I have had the simplified test module [3] and .config attached [4],
> so could you please help to check what the problem is ?

I have no idea how that patch can be responsible for this :/ Have you
confirmed that the bisection is not bogus?

Ard, do you have any ideas?

Will
