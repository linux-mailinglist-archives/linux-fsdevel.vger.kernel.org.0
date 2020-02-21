Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A922816822C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2020 16:47:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728198AbgBUPr2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Feb 2020 10:47:28 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:43784 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727312AbgBUPr2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Feb 2020 10:47:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=8Rh9xF8Ip+2XcAggrOCPjsFTFtbK8F8PUpCWjSbTVZU=; b=GLzUnTFNRf5WlpOSGlBaxxK1ZC
        IpoU1NE44kNrImK1uh9Sef+I0YAdgnqwG1Pkhh7KtJ70ldksZ923AfJu7Uq9wzl0RzXmMxUna3bxY
        FOINcJWjHZV56i8v5AqYZx1o4FhLnFILkOxt/jIjvPTg++KVb3LQKGWrIaCg34EMdUegjJe4Ao8h2
        6Yw618dxo9zCnjgA8G8znMLAP2JDiMaZDGeQUQbe32RmYzbdo7kelLvdyKPjMTQV/QfJPi5u4HARf
        E0X6deyikcdxVDGDGvg0Aaf2ppErTkox1UMU1QjthyaXNKn3O5NKgKPdv9KfySiS7Vlfv1xCIyjjo
        wCTf5cfA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j5AWF-0001Zj-0o; Fri, 21 Feb 2020 15:47:11 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D0EB1300478;
        Fri, 21 Feb 2020 16:45:13 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0B17B209DB0F7; Fri, 21 Feb 2020 16:47:07 +0100 (CET)
Date:   Fri, 21 Feb 2020 16:47:07 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mel Gorman <mgorman@suse.de>
Cc:     ?????? <yun.wang@linux.alibaba.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Michal Koutn? <mkoutny@suse.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH RESEND v8 1/2] sched/numa: introduce per-cgroup NUMA
 locality info
Message-ID: <20200221154706.GI18400@hirez.programming.kicks-ass.net>
References: <fe56d99d-82e0-498c-ae44-f7cde83b5206@linux.alibaba.com>
 <cde13472-46c0-7e17-175f-4b2ba4d8148a@linux.alibaba.com>
 <20200214151048.GL14914@hirez.programming.kicks-ass.net>
 <20200217115810.GA3420@suse.de>
 <881deb50-163e-442a-41ec-b375cc445e4d@linux.alibaba.com>
 <20200217141616.GB3420@suse.de>
 <114519ab-4e9e-996a-67b8-4f5fcecba72a@linux.alibaba.com>
 <20200221142010.GT3420@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200221142010.GT3420@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 21, 2020 at 02:20:10PM +0000, Mel Gorman wrote:
> I fully acknowledge that this may have value for sysadmins and may be a
> good enough reason to merge it for environments that typically build and
> configure their own kernels. I doubt that general distributions would
> enable it but that's a guess.

OTOH, many sysadmins seem to 'rely' on BPF scripts and other such fancy
things these days.

 ( of course, we have the open question on what happens when we break
   one of those BPF 'important' scripts ... )

My main reservation with this patch is that it exposes, to userspace, an
ABI that is very hard to interpret and subject to implementation
details.

So while it can be disabled; people who have it enabled might suddenly
complain when we change the meaning/interpretation/whatever of these
magic numbers.

Michael; you seem to have ignored the tracepoint / BPF angle earlier in
this discussion; that is not something that could/would work for you?
