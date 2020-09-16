Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25F5726BF0B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Sep 2020 10:21:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726584AbgIPIVH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Sep 2020 04:21:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:55966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726068AbgIPIVE (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Sep 2020 04:21:04 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D34482083B;
        Wed, 16 Sep 2020 08:21:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600244463;
        bh=XMAF0lXWlT/LoRLSXtsqS2PDI5e4yq6uNO4fBCqB5ws=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VNLxDLZsUojgixoQKk5tBg5dR+5FG2M6MV/NiX19ImVC7oG2DCXbIEdGNMIY67zwO
         aqOERpzyW29zpxY6mVSOrmfPxJcq6h7O2JQnnhC3qNJQdp/sQ1/ba9ZIFoS/tXj8q+
         0xGVBEky1taZ6rB+IfMnDcDdp8zsUfm63y6TGfMY=
Date:   Wed, 16 Sep 2020 09:20:58 +0100
From:   Will Deacon <will@kernel.org>
To:     peterz@infradead.org
Cc:     Oleg Nesterov <oleg@redhat.com>, Hou Tao <houtao1@huawei.com>,
        Ingo Molnar <mingo@redhat.com>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>
Subject: Re: [RFC PATCH] locking/percpu-rwsem: use this_cpu_{inc|dec}() for
 read_count
Message-ID: <20200916082057.GA27496@willie-the-truck>
References: <20200915140750.137881-1-houtao1@huawei.com>
 <20200915150610.GC2674@hirez.programming.kicks-ass.net>
 <20200915153113.GA6881@redhat.com>
 <20200915155150.GD2674@hirez.programming.kicks-ass.net>
 <20200915160344.GH35926@hirez.programming.kicks-ass.net>
 <20200915161123.GC26745@willie-the-truck>
 <20200915181112.GE2674@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200915181112.GE2674@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 15, 2020 at 08:11:12PM +0200, peterz@infradead.org wrote:
> On Tue, Sep 15, 2020 at 05:11:23PM +0100, Will Deacon wrote:
> > On Tue, Sep 15, 2020 at 06:03:44PM +0200, peterz@infradead.org wrote:
> > > On Tue, Sep 15, 2020 at 05:51:50PM +0200, peterz@infradead.org wrote:
> > > 
> > > > Anyway, I'll rewrite the Changelog and stuff it in locking/urgent.
> > > 
> > > How's this?
> > > 
> > > ---
> > > Subject: locking/percpu-rwsem: Use this_cpu_{inc,dec}() for read_count
> > > From: Hou Tao <houtao1@huawei.com>
> > > Date: Tue, 15 Sep 2020 22:07:50 +0800
> > > 
> > > From: Hou Tao <houtao1@huawei.com>
> > > 
> > > The __this_cpu*() accessors are (in general) IRQ-unsafe which, given
> > > that percpu-rwsem is a blocking primitive, should be just fine.
> > > 
> > > However, file_end_write() is used from IRQ context and will cause
> > > load-store issues.
> > 
> > ... on architectures where the per-cpu accessors are not atomic.
> 
> That's not entirely accurate, on x86 for example the per-cpu ops are not
> atomic, but they are not susceptible to this problem due to them being a
> single instruction from the point of interrupts -- either they wholly
> happen or they don't.

Hey, the implication is still correct though ;)

> So I'd reformulate it like: "... on architectures where the per-cpu
> accessors are not natively irq-safe" ?

But yeah, that's better. Thanks.

Will
