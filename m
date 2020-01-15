Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C0D5B13C628
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2020 15:35:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729040AbgAOOd6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Jan 2020 09:33:58 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:41876 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726248AbgAOOd6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Jan 2020 09:33:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ocli91BL+s6cyrAhg7WkojTpfADiap1nxPT4SxAedzw=; b=tjJPtw9yH/qzdfnHd/0Tg4XM1
        N9ZXDuLEoPijn7fFyz59nCDWohkV/2dOvJPpDU2It+cHWikpgvom4e+7YXHwBqQc4oreE0txkzog2
        u4bejyWBAGiUhyDSKG7+7Al1NNJsZOFrKx5UGxrj+3+dDvqucqU8+FhJ3USoyzBXXSAisoZmm2cfm
        afIPFnROkNQz4LDeaWq0KbPlBaRljjAQDwDaX8voRwgRmcEb3rsccJ59uqAxpHC3EVmBAKZMy2DQS
        22DWjrnw26k46n22bIWnsoloZtuqV/66JWl9HMpXEAGfQBSyH1z0WePlruqGDLBo5fwTUb4SK+rC4
        G0f5/Lh8g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1irjjy-0001bu-Cy; Wed, 15 Jan 2020 14:33:50 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0596130257C;
        Wed, 15 Jan 2020 15:32:11 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 599A720B2867B; Wed, 15 Jan 2020 15:33:47 +0100 (CET)
Date:   Wed, 15 Jan 2020 15:33:47 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Christoph Hellwig <hch@lst.de>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Waiman Long <longman@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-ext4@vger.kernel.org, cluster-devel@redhat.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: RFC: hold i_rwsem until aio completes
Message-ID: <20200115143347.GL2827@hirez.programming.kicks-ass.net>
References: <20200114161225.309792-1-hch@lst.de>
 <20200114192700.GC22037@ziepe.ca>
 <20200115065614.GC21219@lst.de>
 <20200115132428.GA25201@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200115132428.GA25201@ziepe.ca>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 15, 2020 at 09:24:28AM -0400, Jason Gunthorpe wrote:

> I was interested because you are talking about allowing the read/write side
> of a rw sem to be held across a return to user space/etc, which is the
> same basic problem.

No it is not; allowing the lock to be held across userspace doesn't
change the owner. This is a crucial difference, PI depends on there
being a distinct owner. That said, allowing the lock to be held across
userspace still breaks PI in that it completely wrecks the ability to
analyze the critical section.
