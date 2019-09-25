Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21B3DBD9F5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Sep 2019 10:36:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442793AbfIYIgH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Sep 2019 04:36:07 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47878 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437903AbfIYIgH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Sep 2019 04:36:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=qY25nh7ft7xVLg9CJpkhKTMkEGk7+Lk26TG1nt2SkhY=; b=VoBkfX9U18C/zs886+AEon/jz
        P8rwaJyJUSaktSTe86iBPd0eBgthTknvrTbwTpUBOuWHhmEZqmAITl1A0E7pa7U5ttEI5mrWcs9o4
        p4+fDC/V3M2a7wy9dKkPgP+TnuzpeTYzt/qzNSUXjyw6yW/81muGQ5GjgXgcZhJl5NxibaKkmzPui
        Gzbv1UPwm2+G48V6a/5upaH/pv1sR3cER+i16a7znZ9Xqj2BQPIf7FboFrBLfcaS1vBBQvX0pQf7E
        jXk2p5sUusUWVcfBJ91JEh92ht0Wz8O9LH/eQ6ciz2xzpX9IXOUs7BnDAB5+pXhClmFrsi0CMhyhv
        QqT4AlKXw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iD2mF-0006SO-Rx; Wed, 25 Sep 2019 08:36:00 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 18B5D305E1F;
        Wed, 25 Sep 2019 10:35:11 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D7818203E4FB5; Wed, 25 Sep 2019 10:35:57 +0200 (CEST)
Date:   Wed, 25 Sep 2019 10:35:57 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Waiman Long <longman@redhat.com>, Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, Davidlohr Bueso <dave@stgolabs.net>
Subject: Re: [PATCH 0/5] hugetlbfs: Disable PMD sharing for large systems
Message-ID: <20190925083557.GA4553@hirez.programming.kicks-ass.net>
References: <20190911150537.19527-1-longman@redhat.com>
 <20190913015043.GF27547@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190913015043.GF27547@dread.disaster.area>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 13, 2019 at 11:50:43AM +1000, Dave Chinner wrote:
> On Wed, Sep 11, 2019 at 04:05:32PM +0100, Waiman Long wrote:
> > A customer with large SMP systems (up to 16 sockets) with application
> > that uses large amount of static hugepages (~500-1500GB) are experiencing
> > random multisecond delays. These delays was caused by the long time it
> > took to scan the VMA interval tree with mmap_sem held.
> > 
> > To fix this problem while perserving existing behavior as much as
> > possible, we need to allow timeout in down_write() and disabling PMD
> > sharing when it is taking too long to do so. Since a transaction can
> > involving touching multiple huge pages, timing out for each of the huge
> > page interactions does not completely solve the problem. So a threshold
> > is set to completely disable PMD sharing if too many timeouts happen.
> > 
> > The first 4 patches of this 5-patch series adds a new
> > down_write_timedlock() API which accepts a timeout argument and return
> > true is locking is successful or false otherwise. It works more or less
> > than a down_write_trylock() but the calling thread may sleep.
> 
> Just on general principle, this is a non-starter. If a lock is being
> held too long, then whatever the lock is protecting needs fixing.
> Adding timeouts to locks and sysctls to tune them is not a viable
> solution to address latencies caused by algorithm scalability
> issues.

I'm very much agreeing here. Lock functions with timeouts are a sign of
horrific design.
