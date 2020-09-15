Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0185D26AB93
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Sep 2020 20:12:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727968AbgIOSME (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Sep 2020 14:12:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727666AbgIOSL1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Sep 2020 14:11:27 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6EC3C06178A;
        Tue, 15 Sep 2020 11:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Skf+RnDeQwakungqw7FkIqPZOV4lMwNMB+kvGSAk4Fo=; b=JTQVrkMe6r+LRHsSnRnH1uq06d
        qrmUghk3Eb8xpQcwJBTi3Xbo6QjVFHKi7OhAB5WAr5nQAZ9dghtH0p3YFKyEldcO5Vg794DBCOvNJ
        X1ljG+EOZ6V4NtA3BjAldhyx+r5uZ809aDHz1QDqRPdyuNaXItiD+wk2zbUu1BI5YkL1fXQwabItP
        oRGrHS9XIQYek8AI1VMMN5oZ+phGZ3wzwKzqn57AwYAtxejKV/FVXOQtyasR20Ih1XfrOn+UerAO4
        SgLwOzvpU/oTtE4+R4k12VmCUe2q0DXYXOv1WcixKSUq+J2oZH/RT7tlutib7YhxXvkIx9VBrh+tM
        2sGe7Pjw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kIFQB-0003uk-MM; Tue, 15 Sep 2020 18:11:15 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 408683050F0;
        Tue, 15 Sep 2020 20:11:12 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id DEEC82BB9C564; Tue, 15 Sep 2020 20:11:12 +0200 (CEST)
Date:   Tue, 15 Sep 2020 20:11:12 +0200
From:   peterz@infradead.org
To:     Will Deacon <will@kernel.org>
Cc:     Oleg Nesterov <oleg@redhat.com>, Hou Tao <houtao1@huawei.com>,
        Ingo Molnar <mingo@redhat.com>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>
Subject: Re: [RFC PATCH] locking/percpu-rwsem: use this_cpu_{inc|dec}() for
 read_count
Message-ID: <20200915181112.GE2674@hirez.programming.kicks-ass.net>
References: <20200915140750.137881-1-houtao1@huawei.com>
 <20200915150610.GC2674@hirez.programming.kicks-ass.net>
 <20200915153113.GA6881@redhat.com>
 <20200915155150.GD2674@hirez.programming.kicks-ass.net>
 <20200915160344.GH35926@hirez.programming.kicks-ass.net>
 <20200915161123.GC26745@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200915161123.GC26745@willie-the-truck>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 15, 2020 at 05:11:23PM +0100, Will Deacon wrote:
> On Tue, Sep 15, 2020 at 06:03:44PM +0200, peterz@infradead.org wrote:
> > On Tue, Sep 15, 2020 at 05:51:50PM +0200, peterz@infradead.org wrote:
> > 
> > > Anyway, I'll rewrite the Changelog and stuff it in locking/urgent.
> > 
> > How's this?
> > 
> > ---
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
> 
> ... on architectures where the per-cpu accessors are not atomic.

That's not entirely accurate, on x86 for example the per-cpu ops are not
atomic, but they are not susceptible to this problem due to them being a
single instruction from the point of interrupts -- either they wholly
happen or they don't.

So I'd reformulate it like: "... on architectures where the per-cpu
accessors are not natively irq-safe" ?



