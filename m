Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC00B1DA7AB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 May 2020 04:05:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728176AbgETCF0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 May 2020 22:05:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726379AbgETCF0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 May 2020 22:05:26 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10EC3C061A0E;
        Tue, 19 May 2020 19:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Lz/fgGTegv3Vw8bKhUOxZNBgmTWewtj8bcybw8IaH6Y=; b=Ht9zTnd8qZSO8pVr+tEfSmR7ng
        87al1q64oL/b+1Fm1HtRX15bBmhD/rPl/xZI9GlNYJZbhIqTfZhujWsh7CgimT/ZhhctMxkV4LJte
        w3KzxbTjh8j2sgd6qy8hkvnndnc+S/jeSuutx5KESxbaiP1FgX0UUKE60TzG/jUdVTrAl3RQ9FKa1
        3tN/iB+D+HGOpBuyTR369QYk4CLqGkQXSnQhOwhakuWf2+SxFK7Hl0gIdJ7RNbQZ2oigBUkOtzj5E
        ZcBJJh0BbNItr2Gd0BkRMQbUS9vCWFGPTAq62O6IW8+kW5zZFcKrm3o4QieUCg2C8rlCVO+V6Lkxq
        hkQPChaQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jbE6e-0004S2-5O; Wed, 20 May 2020 02:05:16 +0000
Date:   Tue, 19 May 2020 19:05:16 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/8] radix-tree: Use local_lock for protection
Message-ID: <20200520020516.GB16070@bombadil.infradead.org>
References: <20200519201912.1564477-1-bigeasy@linutronix.de>
 <20200519201912.1564477-3-bigeasy@linutronix.de>
 <20200519204545.GA16070@bombadil.infradead.org>
 <20200519165453.0a795ca1@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200519165453.0a795ca1@gandalf.local.home>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 19, 2020 at 04:54:53PM -0400, Steven Rostedt wrote:
> On Tue, 19 May 2020 13:45:45 -0700
> Matthew Wilcox <willy@infradead.org> wrote:
> 
> > On Tue, May 19, 2020 at 10:19:06PM +0200, Sebastian Andrzej Siewior wrote:
> > > The radix-tree and idr preload mechanisms use preempt_disable() to protect
> > > the complete operation between xxx_preload() and xxx_preload_end().
> > > 
> > > As the code inside the preempt disabled section acquires regular spinlocks,
> > > which are converted to 'sleeping' spinlocks on a PREEMPT_RT kernel and
> > > eventually calls into a memory allocator, this conflicts with the RT
> > > semantics.
> > > 
> > > Convert it to a local_lock which allows RT kernels to substitute them with
> > > a real per CPU lock. On non RT kernels this maps to preempt_disable() as
> > > before, but provides also lockdep coverage of the critical region.
> > > No functional change.  
> > 
> > I don't seem to have a locallock.h in my tree.  Where can I find more
> > information about it?
> 
> PATCH 1 ;-)

... this is why we have the convention to cc everybody on all the patches.

>  https://lore.kernel.org/r/20200519201912.1564477-1-bigeasy@linutronix.de
> 
> With lore and b4, it should now be easy to get full patch series.

Thats asking too much of the random people cc'd on random patches.
What is b4 anyway?
