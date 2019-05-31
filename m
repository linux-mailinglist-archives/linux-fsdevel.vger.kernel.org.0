Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 81F5B30A67
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 May 2019 10:35:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726910AbfEaIfs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 31 May 2019 04:35:48 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:50224 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726240AbfEaIfs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 31 May 2019 04:35:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=NYSXgtyp6qFIdURiXa8bdXnjz75azFUheeU4NBYX14M=; b=IcV+NfVF6AYcyTf2poTfMuQeD
        XryTcYrTrHAMk4reMf3GJ1IXzhpOk5ITbYSlFEcvrlNo8ZFaIg2sZKFIOUqrbCNAmd0LHYC490hVh
        LAWqsrB2u9lfZTNJQZr3tUWVGIS1gt6ATDEdOBeU+cC330I+4/SLe9Yh/UmxRTvqLHBirg4fDOsLq
        AlIdc1zlzH9wXoiVlyQgW1Tx2p7tlGu4DUbRf/gy16GxsMAX/KPe2dqge5gIojO4f9IpUlNg8cdM9
        wwdQk8f4N3qOcxbmcIMMqG5+HZp9Wiw6rL3K9N8zlD/vehFQitIuSxWpXIBS1R9MS3PQ9I5aE/mDJ
        nhTrQLwWA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hWd0p-0003pt-W9; Fri, 31 May 2019 08:35:44 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4BECC201B8CFE; Fri, 31 May 2019 10:35:42 +0200 (CEST)
Date:   Fri, 31 May 2019 10:35:42 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andrea Parri <andrea.parri@amarulasolutions.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        David Howells <dhowells@redhat.com>, viro@zeniv.linux.org.uk,
        raven@themaw.net, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-block@vger.kernel.org,
        keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Will Deacon <will.deacon@arm.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 1/7] General notification queue with user mmap()'able
 ring buffer
Message-ID: <20190531083542.GL2623@hirez.programming.kicks-ass.net>
References: <20190528231218.GA28384@kroah.com>
 <20190528162603.GA24097@kroah.com>
 <155905930702.7587.7100265859075976147.stgit@warthog.procyon.org.uk>
 <155905931502.7587.11705449537368497489.stgit@warthog.procyon.org.uk>
 <4031.1559064620@warthog.procyon.org.uk>
 <31936.1559146000@warthog.procyon.org.uk>
 <20190529231112.GB3164@kroah.com>
 <20190530095039.GA5137@andrea>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190530095039.GA5137@andrea>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 30, 2019 at 11:50:39AM +0200, Andrea Parri wrote:
> > > Looking at the perf ring buffer, there appears to be a missing barrier in
> > > perf_aux_output_end():
> > > 
> > > 	rb->user_page->aux_head = rb->aux_head;
> > > 
> > > should be:
> > > 
> > > 	smp_store_release(&rb->user_page->aux_head, rb->aux_head);
> > > 
> > > It should also be using smp_load_acquire().  See
> > > Documentation/core-api/circular-buffers.rst
> > > 
> > > And a (partial) patch has been proposed: https://lkml.org/lkml/2018/5/10/249
> > 
> > So, if that's all that needs to be fixed, can you use the same
> > buffer/code if that patch is merged?
> 
> That's about one year old...: let me add the usual suspects in Cc:  ;-)
> since I'm not sure what the plan was (or if I'm missing something) ...

The AUX crud is 'special' and smp_store_release() doesn't really help in
many cases. Notable, AUX is typically used in combination with a
hardware writer. The driver is in charge of odering here, the generic
code doesn't know what the appropriate barrier (if any) is and would
have to resort to the most expensive/heavy one available.

Also see the comment right above this function:

 "It is the
  pmu driver's responsibility to observe ordering rules of the hardware,
  so that all the data is externally visible before this is called."


