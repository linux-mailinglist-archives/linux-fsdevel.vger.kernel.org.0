Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3022026A855
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Sep 2020 17:07:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727254AbgIOPG5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Sep 2020 11:06:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727104AbgIOPGw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Sep 2020 11:06:52 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 377F7C061788;
        Tue, 15 Sep 2020 08:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=FlgVyuFGB64eIIcoPW84zIw7iDWXEV4cUSLn1lc3f0w=; b=v1qw0gBhOHIgF99ipVZK2g5laF
        bcoNJabkxU0K3HLLkB3b4uHFynM6wnDUyYDwbbOiySFM67wkAm4Ni6dBeZYfDyfVmpeWwA6DisXUp
        S1J8ExYnCMofyc6wuQ0w3zDerVwkUeuDCYfTVL5HDU3jIZ9sqZ35I1hghTrM5FRLnaNj557Ilo3N0
        KPm3YkLPBD/v+G6oN+yn9pu1JRk0BZqcduJCSeQHcq7/cb3UJDkF84gJGIeMynjlGcjkV/n/DmM5m
        YsGqNjypFFXlJlKvgie8tNzz89uSbpm5Bqnjc0aY8mxs8mdWdv/S3P4WydWo9CH/K15Zu3+922hdp
        dCfCv5dg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kICX6-0008RR-0S; Tue, 15 Sep 2020 15:06:12 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2F896301E02;
        Tue, 15 Sep 2020 17:06:11 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 07EA6299BA21D; Tue, 15 Sep 2020 17:06:11 +0200 (CEST)
Date:   Tue, 15 Sep 2020 17:06:10 +0200
From:   peterz@infradead.org
To:     Hou Tao <houtao1@huawei.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Oleg Nesterov <oleg@redhat.com>,
        Will Deacon <will@kernel.org>, Dennis Zhou <dennis@kernel.org>,
        Tejun Heo <tj@kernel.org>, "Christoph Lameter" <cl@linux.com>,
        <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
Subject: Re: [RFC PATCH] locking/percpu-rwsem: use this_cpu_{inc|dec}() for
 read_count
Message-ID: <20200915150610.GC2674@hirez.programming.kicks-ass.net>
References: <20200915140750.137881-1-houtao1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200915140750.137881-1-houtao1@huawei.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 15, 2020 at 10:07:50PM +0800, Hou Tao wrote:
> Under aarch64, __this_cpu_inc() is neither IRQ-safe nor atomic, so
> when percpu_up_read() is invoked under IRQ-context (e.g. aio completion),
> and it interrupts the process on the same CPU which is invoking
> percpu_down_read(), the decreasement on read_count may lost and
> the final value of read_count on the CPU will be unexpected
> as shown below:

> Fixing it by using the IRQ-safe helper this_cpu_inc|dec() for
> operations on read_count.
> 
> Another plausible fix is to state that percpu-rwsem can NOT be
> used under IRQ context and convert all users which may
> use it under IRQ context.

*groan*...

So yeah, fs/super totally abuses percpu_rwsem, and yes, using it from
IRQ context is totally out of spec. That said, we've (grudgingly)
accomodated them before.

This seems to be a fairly long standing issue, and certainly not unique
to ARM64 either (Power, and anyone else using asm-gemeric/percpu.h,
should be similarly affected I think). The issue seems to stem from
Oleg's original rewrite:

  a1fd3e24d8a4 ("percpu_rw_semaphore: reimplement to not block the readers unnecessarily")

and is certainly an understandable mistake.

I'm torn on what to do, using this_cpu over __this_cpu is going to
adversely affect code-gen (and possibly performance) for all the
percpu-rwsem users that are not quite so 'creative'.

