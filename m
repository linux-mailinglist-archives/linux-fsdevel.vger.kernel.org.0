Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0ED5911839F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2019 10:33:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbfLJJdr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Dec 2019 04:33:47 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:44404 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726915AbfLJJdr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Dec 2019 04:33:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=sMO1cch7CJcc30d1l4BAfw/KGbhW737PQA2xFFlz1to=; b=Naur3HODwCXzNFmODUCUV8ISF
        /S1jRqpZu30XpYFoOz9DDcvllTj7H0nOUCV/njXaCdP0umq3wN+fJl+suPpcXyE9BAMXiKsoNZmJv
        qFr7emLfd+oApAiqTIn3PddjbDxQb+NT8RkhEqjjTbU51YIFu65fMQ+ss21qQ8zYlqqBfn3AWANaD
        wjz/1dcyVNSgS1jCROJkqWCBU2+E8THo4mlw+29AGlULG+p/wef1a9hLuMC+emNL8FC0OdsZP68PK
        iclDBT0bZ7I4b9NFh+8Kr8Rp8fj67T3umhCTbsoHU/B7TT2GrlOethQkmZRbR2MZDcisznN0ALOa7
        wajhM4w5g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iebtk-0004v9-N4; Tue, 10 Dec 2019 09:33:40 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 24D77300596;
        Tue, 10 Dec 2019 10:32:19 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7FDAB2010F142; Tue, 10 Dec 2019 10:33:38 +0100 (CET)
Date:   Tue, 10 Dec 2019 10:33:38 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc:     Dave Chinner <david@fromorbit.com>, Phil Auld <pauld@redhat.com>,
        Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jeff Moyer <jmoyer@redhat.com>,
        Dave Chinner <dchinner@redhat.com>,
        Eric Sandeen <sandeen@redhat.com>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Ingo Molnar <mingo@redhat.com>, Tejun Heo <tj@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH v2] sched/core: Preempt current task in favour of bound
 kthread
Message-ID: <20191210093338.GF2871@hirez.programming.kicks-ass.net>
References: <20191115234005.GO4614@dread.disaster.area>
 <20191118092121.GV4131@hirez.programming.kicks-ass.net>
 <20191118204054.GV4614@dread.disaster.area>
 <20191120191636.GI4097@hirez.programming.kicks-ass.net>
 <20191120220313.GC18056@pauld.bos.csb>
 <20191121132937.GW4114@hirez.programming.kicks-ass.net>
 <20191209165122.GA27229@linux.vnet.ibm.com>
 <20191209231743.GA19256@dread.disaster.area>
 <20191210054330.GF27253@linux.vnet.ibm.com>
 <20191210092601.GK2844@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191210092601.GK2844@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 10, 2019 at 10:26:01AM +0100, Peter Zijlstra wrote:

> > @@ -6716,7 +6737,7 @@ static void check_preempt_wakeup(struct rq *rq, struct task_struct *p, int wake_
> >  	find_matching_se(&se, &pse);
> >  	update_curr(cfs_rq_of(se));
> >  	BUG_ON(!pse);
> > -	if (wakeup_preempt_entity(se, pse) == 1) {
> > +	if (wakeup_preempt_entity(se, pse) == 1 || kthread_wakeup_preempt(rq, p, wake_flags)) {
> >  		/*
> >  		 * Bias pick_next to pick the sched entity that is
> >  		 * triggering this preemption.
> 
> How about something like:
> 
	if (wakeup_preempt_entity(se, pse) >= !(wake_flags & WF_KTHREAD))

That's a slightly less convoluted expression for the same value :-)	
