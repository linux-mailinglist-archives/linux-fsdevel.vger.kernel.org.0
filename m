Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0492826B24B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Sep 2020 00:45:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726876AbgIOPx6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Sep 2020 11:53:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727428AbgIOPxm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Sep 2020 11:53:42 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AAA6C06174A;
        Tue, 15 Sep 2020 08:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=CVAqHaHH33AZ+oBegMlU0v54kTGf0Fk88db9aLUGWW8=; b=MD6yoZC5JuFe13k0gswTa+6VHc
        g4JTWT6rT+8BAoHMIwKX++SkP98aCnLln4FDdwZpuelKE6Mb75hag72Jv5qUIe6TU2v3XRnbz9JQZ
        CriqRQt6lzqrj6q6AVplZ8AmGuIn7zrecAU/xn/ExmwUDdtbeaHSuTXbGEujWok75m78moty6Jlmj
        IAOVWmMX5Pf/BoY+H/XZnj39rsMuxreF+uItJMApilsxH070/Mgt/GkgMgtNtauLAD79gzusZndl3
        WJceNNOMVa5z/bB5EEYVcnx/6BY36K1IGK7uK0GeYkmC93Qa2JyT8n123mOIBWrybwbc5yKQFGwNQ
        0RWfhsHg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kIDFK-0006B8-RR; Tue, 15 Sep 2020 15:51:55 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D7B9E3006D0;
        Tue, 15 Sep 2020 17:51:50 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B9CAB203EB17D; Tue, 15 Sep 2020 17:51:50 +0200 (CEST)
Date:   Tue, 15 Sep 2020 17:51:50 +0200
From:   peterz@infradead.org
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Hou Tao <houtao1@huawei.com>, Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will@kernel.org>, Dennis Zhou <dennis@kernel.org>,
        Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH] locking/percpu-rwsem: use this_cpu_{inc|dec}() for
 read_count
Message-ID: <20200915155150.GD2674@hirez.programming.kicks-ass.net>
References: <20200915140750.137881-1-houtao1@huawei.com>
 <20200915150610.GC2674@hirez.programming.kicks-ass.net>
 <20200915153113.GA6881@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200915153113.GA6881@redhat.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 15, 2020 at 05:31:14PM +0200, Oleg Nesterov wrote:

> > So yeah, fs/super totally abuses percpu_rwsem, and yes, using it from
> > IRQ context is totally out of spec. That said, we've (grudgingly)
> > accomodated them before.
> 
> Yes, I didn't expect percpu_up_ can be called from IRQ :/

Yeah, me neither. That's well out of spec for a blocking primitive in
general.

> > This seems to be a fairly long standing issue, and certainly not unique
> > to ARM64 either (Power, and anyone else using asm-gemeric/percpu.h,
> > should be similarly affected I think). The issue seems to stem from
> > Oleg's original rewrite:
> >
> >   a1fd3e24d8a4 ("percpu_rw_semaphore: reimplement to not block the readers unnecessarily")
> 
> Not really... I think it was 70fe2f48152e ("aio: fix freeze protection of aio writes").

Ah, that came later? Fair enough, I'll change the Fixes line.

> And iiuc io_uring does the same.

Indeed, I just went through a bunch of the file_end_write() callers.

> > and is certainly an understandable mistake.
> >
> > I'm torn on what to do, using this_cpu over __this_cpu is going to
> > adversely affect code-gen (and possibly performance) for all the
> > percpu-rwsem users that are not quite so 'creative'.
> 
> Yes, but what else can we do?

Well, I just talked about it with Will, there's a bunch of things we
could do, but they're all quite ugly.

My leading alternative was adding: percpu_down_read_irqsafe() /
percpu_up_read_irqsafe(), which use local_irq_save() instead of
preempt_disable().

But blergh.. Will also argued that by going with this patch, we'll get
an affected workload when someone reports a performance regression,
which I suppose is a bonus.

Anyway, I'll rewrite the Changelog and stuff it in locking/urgent.
