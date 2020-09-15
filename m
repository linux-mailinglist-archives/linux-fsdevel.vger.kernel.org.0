Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD95326B186
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Sep 2020 00:31:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727562AbgIOWbq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Sep 2020 18:31:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:59530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727503AbgIOQRT (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Sep 2020 12:17:19 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D468E21D24;
        Tue, 15 Sep 2020 16:11:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600186288;
        bh=OqNo4S1pwXf0y+OZFi5cbHnZ01UaP3lAlNY279lhRwE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1SbAjFtsROiRCnu7dWyqN1sIRZoFtHLH0MUJUYOlqDz9sybYMVk7vMa97tuhN/eXb
         2X+dts4/sCSWx68z5lSHzmqQDfHvyzZxYUgNpCa4RxG/Ut4m70Zks3irGDXZRCVYTp
         oAQBm5qwIMsvFOtlPHV50y+STKCjMdNmVH4jbBoc=
Date:   Tue, 15 Sep 2020 17:11:23 +0100
From:   Will Deacon <will@kernel.org>
To:     peterz@infradead.org
Cc:     Oleg Nesterov <oleg@redhat.com>, Hou Tao <houtao1@huawei.com>,
        Ingo Molnar <mingo@redhat.com>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>
Subject: Re: [RFC PATCH] locking/percpu-rwsem: use this_cpu_{inc|dec}() for
 read_count
Message-ID: <20200915161123.GC26745@willie-the-truck>
References: <20200915140750.137881-1-houtao1@huawei.com>
 <20200915150610.GC2674@hirez.programming.kicks-ass.net>
 <20200915153113.GA6881@redhat.com>
 <20200915155150.GD2674@hirez.programming.kicks-ass.net>
 <20200915160344.GH35926@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200915160344.GH35926@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 15, 2020 at 06:03:44PM +0200, peterz@infradead.org wrote:
> On Tue, Sep 15, 2020 at 05:51:50PM +0200, peterz@infradead.org wrote:
> 
> > Anyway, I'll rewrite the Changelog and stuff it in locking/urgent.
> 
> How's this?
> 
> ---
> Subject: locking/percpu-rwsem: Use this_cpu_{inc,dec}() for read_count
> From: Hou Tao <houtao1@huawei.com>
> Date: Tue, 15 Sep 2020 22:07:50 +0800
> 
> From: Hou Tao <houtao1@huawei.com>
> 
> The __this_cpu*() accessors are (in general) IRQ-unsafe which, given
> that percpu-rwsem is a blocking primitive, should be just fine.
> 
> However, file_end_write() is used from IRQ context and will cause
> load-store issues.

... on architectures where the per-cpu accessors are not atomic.

> 
> Fixing it by using the IRQ-safe this_cpu_*() for operations on

Fixing => Fix ?

> read_count. This will generate more expensive code on a number of
> platforms, which might cause a performance regression for some of the
> other percpu-rwsem users.
> 
> If any such is reported, we can consider alternative solutions.
> 
> Fixes: 70fe2f48152e ("aio: fix freeze protection of aio writes")
> Signed-off-by: Hou Tao <houtao1@huawei.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Link: https://lkml.kernel.org/r/20200915140750.137881-1-houtao1@huawei.com
> ---
>  include/linux/percpu-rwsem.h  |    8 ++++----
>  kernel/locking/percpu-rwsem.c |    4 ++--
>  2 files changed, 6 insertions(+), 6 deletions(-)

For the patch:

Acked-by: Will Deacon <will@kernel.org>

Will
