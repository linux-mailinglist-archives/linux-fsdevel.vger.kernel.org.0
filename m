Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50F7F168192
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2020 16:29:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729175AbgBUP2t (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Feb 2020 10:28:49 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:37552 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729072AbgBUP2p (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Feb 2020 10:28:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=teQadSX0wyV4ftQ41M/03hMOBJ7nffcslPnRS4n1cL0=; b=FO11uySWYfI+CHf4sRD/ycCuie
        nHo0JseQxPLSNhugXNfrjWpNpFYClG0EJ6ZhsJjnA4J8gErKszWCl2gM2wO95J1dA7ORGjeTOGc1r
        ACXPYJgq/Z/oTLUEJHHzz7Xdsva/ZoWzEWoZzpXzjqmFOpHtcqXLVo1H7eqSwhMds4sMo58AJLwd3
        DQxRWRpw/60TICg7PHg/Yvr/nKsTJozL7slseewvBlRg2iJclSKEdCwigvnRCsG6s3/W0LVfgx8Gx
        I7ZnmxVYGvd9qPsMMO2IjpDbUYh/g62/J/7dywfdJbrXUmeZ4kb5O7zWAqdEeFzLy6xXDrQmkLmQd
        n1fjTRkQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j5AE7-0001jI-81; Fri, 21 Feb 2020 15:28:27 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D4B5D306151;
        Fri, 21 Feb 2020 16:26:30 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 29990209DB0F7; Fri, 21 Feb 2020 16:28:24 +0100 (CET)
Date:   Fri, 21 Feb 2020 16:28:24 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     =?utf-8?B?546L6LSH?= <yun.wang@linux.alibaba.com>
Cc:     Mel Gorman <mgorman@suse.de>, Ingo Molnar <mingo@redhat.com>,
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
Message-ID: <20200221152824.GH18400@hirez.programming.kicks-ass.net>
References: <fe56d99d-82e0-498c-ae44-f7cde83b5206@linux.alibaba.com>
 <cde13472-46c0-7e17-175f-4b2ba4d8148a@linux.alibaba.com>
 <20200214151048.GL14914@hirez.programming.kicks-ass.net>
 <20200217115810.GA3420@suse.de>
 <881deb50-163e-442a-41ec-b375cc445e4d@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <881deb50-163e-442a-41ec-b375cc445e4d@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 17, 2020 at 09:23:52PM +0800, 王贇 wrote:
> FYI, by monitoring locality, we found that the kvm vcpu thread is not
> covered by NUMA Balancing, whatever how many maximum period passed, the
> counters are not increasing, or very slowly, although inside guest we are
> copying memory.
> 
> Later we found such task rarely exit to user space to trigger task
> work callbacks, and NUMA Balancing scan depends on that, which help us
> realize the importance to enable NUMA Balancing inside guest, with the
> correct NUMA topo, a big performance risk I'll say :-P

That's a bug in KVM, see:

  https://lkml.kernel.org/r/20190801143657.785902257@linutronix.de
  https://lkml.kernel.org/r/20190801143657.887648487@linutronix.de

ISTR there being newer versions of that patch-set, but I can't seem to
find them in a hurry.
