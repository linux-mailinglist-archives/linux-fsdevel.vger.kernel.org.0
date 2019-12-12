Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B63611D0AF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2019 16:15:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729190AbfLLPPb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Dec 2019 10:15:31 -0500
Received: from merlin.infradead.org ([205.233.59.134]:40624 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728654AbfLLPPb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Dec 2019 10:15:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=fqIAUYObIqhJeHpHjDLZJpvGSDr/AnjM2VLcw/JukHs=; b=o41nx2FahlOPNHfP7Q0L1ZpCw
        WuIg0y8CiVgeOACrHgtzNu9jKnfWi55H3b3Qvd+T2Ckldvb7rZxsOeqkBiXhnq4gVfeeRpcQkntU/
        LiBZpxsxl9jZdVx5bzEQvr1b5oet6Z+3/wrBzyzXOvN0f8eUOnBTiH+Lukt2WZyVCwo79apL7Ues3
        /CqS8NOVf+I+PqUxBYweYwB7AFrP/sfhP6VSf4JoIA8p3Ri3JjmVYCCrKYXJUz8BZD2FMvsqEHzAf
        fM5V8ZZAGOMjMn0PDWFOfIssp06hi/aD2oDU+F5fHL9UUVkzjfYbBm0MgL7TFUmUmOCVyDqO5dCFs
        l48pgnpLQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ifQBU-0002pM-Jb; Thu, 12 Dec 2019 15:15:20 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A8BF5300F29;
        Thu, 12 Dec 2019 16:13:58 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 10DD22B195AE5; Thu, 12 Dec 2019 16:15:19 +0100 (CET)
Date:   Thu, 12 Dec 2019 16:15:19 +0100
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
Subject: Re: [PATCH v4] sched/core: Preempt current task in favour of bound
 kthread
Message-ID: <20191212151519.GA2827@hirez.programming.kicks-ass.net>
References: <20191120220313.GC18056@pauld.bos.csb>
 <20191121132937.GW4114@hirez.programming.kicks-ass.net>
 <20191209165122.GA27229@linux.vnet.ibm.com>
 <20191209231743.GA19256@dread.disaster.area>
 <20191210054330.GF27253@linux.vnet.ibm.com>
 <20191210172307.GD9139@linux.vnet.ibm.com>
 <20191211173829.GB21797@linux.vnet.ibm.com>
 <20191211224617.GE19256@dread.disaster.area>
 <20191212101031.GV2827@hirez.programming.kicks-ass.net>
 <20191212150737.GC21797@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191212150737.GC21797@linux.vnet.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 12, 2019 at 08:37:37PM +0530, Srikar Dronamraju wrote:
> * Peter Zijlstra <peterz@infradead.org> [2019-12-12 11:10:31]:
> 
> > 
> > +static struct sched_entity *
> > +__pick_next_entity(struct cfs_rq *cfs_rq, struct sched_entity *curr);
> 
> I think we already have __pick_next_entity in kernel/sched/fair.c

D'oh... yeah, I just wrote stuff, it never actually got near a compiler.
