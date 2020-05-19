Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 229171DA310
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 May 2020 22:45:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726455AbgESUpx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 May 2020 16:45:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726064AbgESUpx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 May 2020 16:45:53 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BA7CC08C5C0;
        Tue, 19 May 2020 13:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=77K5NPu52Vg9lQmOBjp5ZLm4Q2SrSXrgX6ESTIlCYCM=; b=WlVctIWoU550mhHkvBOJ6k80nz
        TkxbLtxz2hPJ3GJJGjOuDTGGdR3bk2QoXCVldmRZDRU3lzyhlkICShCxBvX2l4n5A0NkMaucQMoDd
        rK2Z7kq8K/XANz8HCyFtozZNBjXFE3Eg1BV7OKaMVSU4FL2nMDjwl4fkyscX6AXu3ANbAZatNf69J
        mX8hoj2w+zTsBz0zQSgDFl+GCPY7PVdINTXl+xgd/0Mgrsg3kgGHSxAmU5dE+pY9X9WUPngI1GMNe
        Pe1otsKRsRb+QkRvu6VMyQ0q+6LtpG4RgZRpYzlB+YHNpnBn0z/CvyR/n5TtDcIs+GUUqMvvMRp3R
        mQggcnBQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jb97R-0004tv-QH; Tue, 19 May 2020 20:45:45 +0000
Date:   Tue, 19 May 2020 13:45:45 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/8] radix-tree: Use local_lock for protection
Message-ID: <20200519204545.GA16070@bombadil.infradead.org>
References: <20200519201912.1564477-1-bigeasy@linutronix.de>
 <20200519201912.1564477-3-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200519201912.1564477-3-bigeasy@linutronix.de>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 19, 2020 at 10:19:06PM +0200, Sebastian Andrzej Siewior wrote:
> The radix-tree and idr preload mechanisms use preempt_disable() to protect
> the complete operation between xxx_preload() and xxx_preload_end().
> 
> As the code inside the preempt disabled section acquires regular spinlocks,
> which are converted to 'sleeping' spinlocks on a PREEMPT_RT kernel and
> eventually calls into a memory allocator, this conflicts with the RT
> semantics.
> 
> Convert it to a local_lock which allows RT kernels to substitute them with
> a real per CPU lock. On non RT kernels this maps to preempt_disable() as
> before, but provides also lockdep coverage of the critical region.
> No functional change.

I don't seem to have a locallock.h in my tree.  Where can I find more
information about it?

> +++ b/lib/radix-tree.c
> @@ -20,6 +20,7 @@
>  #include <linux/kernel.h>
>  #include <linux/kmemleak.h>
>  #include <linux/percpu.h>
> +#include <linux/locallock.h>
>  #include <linux/preempt.h>		/* in_interrupt() */
>  #include <linux/radix-tree.h>
>  #include <linux/rcupdate.h>
