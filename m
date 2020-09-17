Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16C9426D713
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Sep 2020 10:48:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbgIQIsl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Sep 2020 04:48:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:41632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726593AbgIQIsh (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Sep 2020 04:48:37 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0F85E206A1;
        Thu, 17 Sep 2020 08:48:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600332516;
        bh=yi+ytAgx6za/19uH7XwF6woib4Fz9kTbekZjb7IPr4w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZUZI0GKwdBeRxsYmtgk3CU2wo8gn25Nzi6q4xzvhuzEfHX5IIxJTrvnSI/YfwkJcK
         TxhnlM8C/8cAUAILAy0z4Vc/fdfzRxThnS0smPwfpRQ5VrK+OPBW1hDNnhbUPgyXmV
         4vDNFiRFVns1MBqYnoretp4PK/SiOsyxXrSUU1kA=
Date:   Thu, 17 Sep 2020 09:48:31 +0100
From:   Will Deacon <will@kernel.org>
To:     Hou Tao <houtao1@huawei.com>
Cc:     peterz@infradead.org, Oleg Nesterov <oleg@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>
Subject: Re: [RFC PATCH] locking/percpu-rwsem: use this_cpu_{inc|dec}() for
 read_count
Message-ID: <20200917084831.GA29295@willie-the-truck>
References: <20200915140750.137881-1-houtao1@huawei.com>
 <20200915150610.GC2674@hirez.programming.kicks-ass.net>
 <20200915153113.GA6881@redhat.com>
 <20200915155150.GD2674@hirez.programming.kicks-ass.net>
 <20200915160344.GH35926@hirez.programming.kicks-ass.net>
 <b885ce8e-4b0b-8321-c2cc-ee8f42de52d4@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b885ce8e-4b0b-8321-c2cc-ee8f42de52d4@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 16, 2020 at 08:32:20PM +0800, Hou Tao wrote:
> > Subject: locking/percpu-rwsem: Use this_cpu_{inc,dec}() for read_count
> > From: Hou Tao <houtao1@huawei.com>
> > Date: Tue, 15 Sep 2020 22:07:50 +0800
> > 
> > From: Hou Tao <houtao1@huawei.com>
> > 
> > The __this_cpu*() accessors are (in general) IRQ-unsafe which, given
> > that percpu-rwsem is a blocking primitive, should be just fine.
> > 
> > However, file_end_write() is used from IRQ context and will cause
> > load-store issues.
> > 
> > Fixing it by using the IRQ-safe this_cpu_*() for operations on
> > read_count. This will generate more expensive code on a number of
> > platforms, which might cause a performance regression for some of the
> > other percpu-rwsem users.
> > 
> > If any such is reported, we can consider alternative solutions.
> > 
> I have simply test the performance impact on both x86 and aarch64.
> 
> There is no degradation under x86 (2 sockets, 18 core per sockets, 2 threads per core)
> 
> v5.8.9
> no writer, reader cn                               | 18        | 36        | 72
> the rate of down_read/up_read per second           | 231423957 | 230737381 | 109943028
> the rate of down_read/up_read per second (patched) | 232864799 | 233555210 | 109768011
> 
> However the performance degradation is huge under aarch64 (4 sockets, 24 core per sockets): nearly 60% lost.
> 
> v4.19.111
> no writer, reader cn                               | 24        | 48        | 72        | 96
> the rate of down_read/up_read per second           | 166129572 | 166064100 | 165963448 | 165203565
> the rate of down_read/up_read per second (patched) |  63863506 |  63842132 |  63757267 |  63514920
> 
> I will test the aarch64 host by using v5.8 tomorrow.

Thanks. We did improve the preempt_count() munging a bit since 4.19 (I
think), so maybe 5.8 will be a bit better. Please report back!

Will
