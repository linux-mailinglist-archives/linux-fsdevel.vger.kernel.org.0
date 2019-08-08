Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D03985B8A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2019 09:28:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731178AbfHHH2O (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Aug 2019 03:28:14 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:55956 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730887AbfHHH2O (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Aug 2019 03:28:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=DKEna/7+DBlpAfStQG61tcPutdE/j8S3q0Xub5Jf2r4=; b=un30FUNrFKnGvbWxL+njNsq6w
        ++c+PapB3gmasvpSSJNS+t7qIC6VEKohHyFrdnrsPOdHe5wMvSmcn2TtO9b7amLOy/9tSxwIjRfef
        E0JMnsizL9DjhElzg5QPiYm5PFzKiyYmRKkcblFvHgQN6mxrZgeWHQpX9tJYL4Grkefnfez8PXmmj
        oR0MEo8Gj5RIYdKyL1/ygwECjZibsh8aAeEMKW48rh4xVD4QQ1oW4miqa4CvdVMdVGhN9k5y/dTa/
        uIJJeOoPNxrK92pSWJrFJslttBNoz83TgGFs9cKRTlFA6g1tknT6SmjO9aYXzSLmSJzrV8ppXkVfn
        5YtT/5Unw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hvcqF-00080i-Ug; Thu, 08 Aug 2019 07:28:07 +0000
Date:   Thu, 8 Aug 2019 00:28:07 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Christoph Hellwig <hch@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Julia Cartwright <julia@ni.com>, Jan Kara <jack@suse.cz>,
        Theodore Tso <tytso@mit.edu>,
        Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        Jan Kara <jack@suse.com>, Mark Fasheh <mark@fasheh.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Joel Becker <jlbec@evilplan.org>
Subject: Re: [patch V2 0/7] fs: Substitute bit-spinlocks for PREEMPT_RT and
 debugging
Message-ID: <20190808072807.GA25259@infradead.org>
References: <20190801010126.245731659@linutronix.de>
 <20190802075612.GA20962@infradead.org>
 <alpine.DEB.2.21.1908021107090.2285@nanos.tec.linutronix.de>
 <20190806061119.GA17492@infradead.org>
 <alpine.DEB.2.21.1908080858460.2882@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1908080858460.2882@nanos.tec.linutronix.de>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 08, 2019 at 09:02:47AM +0200, Thomas Gleixner wrote:
> > >   mm/slub.c:      bit_spin_lock(PG_locked, &page->flags);
> > 
> > One caller ouf of a gazillion that spins on the page lock instead of
> > sleepign on it like everyone else.  That should not have passed your
> > smell test to start with :)
> 
> I surely stared at it, but that cannot sleep. It's in the middle of a
> preempt and interrupt disabled region and used on architectures which do
> not support CMPXCHG_DOUBLE and ALIGNED_STRUCT_PAGE ...

I know.  But the problem here is that normally PG_locked is used together 
with wait_on_page_bit_*, but this one instances uses the bit spinlock
helpers.  This is the equivalent of calling spin_lock on a struct mutex
rather than having a mutex_lock_spin helper for this case.  Does SLUB
work on -rt at all?
