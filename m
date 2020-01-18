Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3CA8141A15
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Jan 2020 23:41:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727056AbgARWlQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 Jan 2020 17:41:16 -0500
Received: from [198.137.202.133] ([198.137.202.133]:36394 "EHLO
        bombadil.infradead.org" rhost-flags-FAIL-FAIL-OK-OK)
        by vger.kernel.org with ESMTP id S1727008AbgARWlP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 Jan 2020 17:41:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=vyYDHKvf8gCiisBHbQ1RzC91plzB3US9sNYD80kKiaU=; b=i3JtNAjSE6Cmh9ec2614Kqpaz
        pDvpbDSOyBvB5PYbf5RdTTHw3IkY3UyZpv7p/iS4hp7Y9znPQfJD+m39U6zVkL2DauuWgBMqi5L6k
        jvo3y72b8rppMJdJ9NaEy2r18bFFClCbtPYjg0xMA5nzaIgtIVvgdNLXmKIc1jPPF82YEO5Ii+1fL
        FhaMWUP32RjrC/UzIS+KZorvqO8WST7q8Kq+EYPnVo+qmSfEk4WccgUg1LwSLoXPiz5WFq72ByCpC
        lGnF3ASEkbw8TAr/Ofw/A25tEeIt+ePR+ef3xIYFoGgSnA9SMJOOGREbOVuP2NsjmBYp+dgSBicrR
        dCE+PeD2g==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iswlg-0001Y2-1d; Sat, 18 Jan 2020 22:40:36 +0000
Date:   Sat, 18 Jan 2020 14:40:35 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Christoph Hellwig <hch@lst.de>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Waiman Long <longman@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-ext4@vger.kernel.org, cluster-devel@redhat.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: RFC: hold i_rwsem until aio completes
Message-ID: <20200118224035.GA26801@bombadil.infradead.org>
References: <20200114161225.309792-1-hch@lst.de>
 <20200114192700.GC22037@ziepe.ca>
 <20200115065614.GC21219@lst.de>
 <20200115132428.GA25201@ziepe.ca>
 <20200115143347.GL2827@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200115143347.GL2827@hirez.programming.kicks-ass.net>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 15, 2020 at 03:33:47PM +0100, Peter Zijlstra wrote:
> On Wed, Jan 15, 2020 at 09:24:28AM -0400, Jason Gunthorpe wrote:
> 
> > I was interested because you are talking about allowing the read/write side
> > of a rw sem to be held across a return to user space/etc, which is the
> > same basic problem.
> 
> No it is not; allowing the lock to be held across userspace doesn't
> change the owner. This is a crucial difference, PI depends on there
> being a distinct owner. That said, allowing the lock to be held across
> userspace still breaks PI in that it completely wrecks the ability to
> analyze the critical section.

Thinking about this from a PI point of view, the problem is not that we
returned to userspace still holding the lock, it's that boosting this
process's priority will not help release the lock faster because this
process no longer owns the lock.

If we had a lock owner handoff API (ie I can donate my lock to another
owner), that would solve this problem.  We'd want to have special owners
to denote "RCU" "bottom halves" or "irq" so we know what we can do about
PI.  I don't think we need a "I have stolen this lock from somebody else"
API, but maybe I'm wrong there.
