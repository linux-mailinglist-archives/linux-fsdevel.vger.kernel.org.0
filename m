Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16A6326F9E9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Sep 2020 12:08:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726118AbgIRKH5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Sep 2020 06:07:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbgIRKH5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Sep 2020 06:07:57 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D505BC06174A;
        Fri, 18 Sep 2020 03:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=XzBING0RVqy6DwPzZA42LOJqO0/ETIdbqaGA73DICbI=; b=X9ro1ToOCaMy9lcez/FyZ/GeQj
        7C5CXExsAMS9EyWiJI/LtZWHB8JySVqVmOLavXLW6GkOvCysxjs8majl+BwhYYLXHME3wSy+EuYoY
        LrdP8bEJo87NWTn0c4EE72DWUzV9CM1apG/+BXf/vC47qI1OXwLrhApf3T4ASVFBamx1EWXr6wGS/
        7ZI3xEub9TyyVIMvFMvgE+YvEn2IQGfdQjybGlSTUBRpUH6SZygLdLff1ScT/8udawuTaTqn0JMLZ
        AZBn1qvPb0GPeyc+TYwdhjBA0oXAW2npNHgbPMewtBFkXxs3CPK9RziUlEvkXgx6yUccuxcuoWphi
        6KaMNZNw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kJDIu-0006iZ-0E; Fri, 18 Sep 2020 10:07:44 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9CB41307697;
        Fri, 18 Sep 2020 12:07:43 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8B7AB203EB182; Fri, 18 Sep 2020 12:07:43 +0200 (CEST)
Date:   Fri, 18 Sep 2020 12:07:43 +0200
From:   peterz@infradead.org
To:     Jan Kara <jack@suse.cz>
Cc:     Oleg Nesterov <oleg@redhat.com>, Boaz Harrosh <boaz@plexistor.com>,
        Hou Tao <houtao1@huawei.com>, Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will@kernel.org>, Dennis Zhou <dennis@kernel.org>,
        Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH] locking/percpu-rwsem: use this_cpu_{inc|dec}() for
 read_count
Message-ID: <20200918100743.GK35926@hirez.programming.kicks-ass.net>
References: <20200915150610.GC2674@hirez.programming.kicks-ass.net>
 <20200915153113.GA6881@redhat.com>
 <20200915155150.GD2674@hirez.programming.kicks-ass.net>
 <20200915160344.GH35926@hirez.programming.kicks-ass.net>
 <b885ce8e-4b0b-8321-c2cc-ee8f42de52d4@huawei.com>
 <ddd5d732-06da-f8f2-ba4a-686c58297e47@plexistor.com>
 <20200917120132.GA5602@redhat.com>
 <20200918090702.GB18920@quack2.suse.cz>
 <20200918100112.GN1362448@hirez.programming.kicks-ass.net>
 <20200918100432.GJ35926@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200918100432.GJ35926@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 18, 2020 at 12:04:32PM +0200, peterz@infradead.org wrote:
> On Fri, Sep 18, 2020 at 12:01:12PM +0200, peterz@infradead.org wrote:
> > @@ -198,7 +198,9 @@ EXPORT_SYMBOL_GPL(__percpu_down_read);
> >   */
> >  static bool readers_active_check(struct percpu_rw_semaphore *sem)
> >  {
> > -	if (per_cpu_sum(*sem->read_count) != 0)
> > +	u64 sum = per_cpu_sum(*(u64 *)sem->read_count);
> > +
> > +	if (sum + (sum >> 32))
> 
> That obviously wants to be:
> 
> 	if ((u32)(sum + (sum >> 32)))
> 
> >  		return false;
> >  
> >  	/*

I suppose an alternative way of writing that would be something like:

	union {
		u64 sum;
		struct {
			u32 a, b;
		};
	} var;

	var.sum = per_cpu_sum(*(u64 *)sem->read_count);

	if (var.a + var.b)
		return false;

which is more verbose, but perhaps easier to read.
