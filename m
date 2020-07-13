Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A0D421D511
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jul 2020 13:36:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729631AbgGMLgS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Jul 2020 07:36:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726586AbgGMLgR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Jul 2020 07:36:17 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 633B4C061755;
        Mon, 13 Jul 2020 04:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=e4mWSockMrHYbs1YPCBcxolKsfl3ywIczR6j7zoK7Fk=; b=Rrp2MoFaYyCYIte0PtkIcZ1FTZ
        MoSi4TD90kRTacj3VNqgEthpf25v6++DqVWCTLUCCUIJy2C2ZOLLLWsDjP+qLQn65OabUpDFB7Y9a
        w9dcH/7q9GE1V/blLC6eFCrYlsa5PaY5DZOPyBTTsUqVw+ck61Lmz3W3MeqQHHaBwu8PBde+s10EL
        BWS/EL8F/urrTrF/D2Rt6/2kkoOu4S7mhOtRV+wt3GdoWoP2caHZ0D4r1aB+0zBlSJprDCbtpMAxW
        bdbLccfPsJ1/yAvJqX45ca/K+gESVha4EHgJ8ZvEvxN2l0FZ6z+3rBQi9hSMHnm1WFHJl8n5F2F1L
        N47wrrSA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1juwkb-0003hh-Cg; Mon, 13 Jul 2020 11:36:01 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 865D0300F7A;
        Mon, 13 Jul 2020 13:36:00 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6D38F20D28B50; Mon, 13 Jul 2020 13:36:00 +0200 (CEST)
Date:   Mon, 13 Jul 2020 13:36:00 +0200
From:   peterz@infradead.org
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Doug Anderson <dianders@chromium.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Quentin Perret <qperret@google.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v6 1/2] sched/uclamp: Add a new sysctl to control RT
 default boost value
Message-ID: <20200713113600.GA43129@hirez.programming.kicks-ass.net>
References: <20200706142839.26629-1-qais.yousef@arm.com>
 <20200706142839.26629-2-qais.yousef@arm.com>
 <20200713112125.GG10769@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200713112125.GG10769@hirez.programming.kicks-ass.net>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 13, 2020 at 01:21:25PM +0200, Peter Zijlstra wrote:
> +	 * copy_process()			sysctl_uclamp
> +	 *					  uclamp_min_rt = X;
> +	 *   write_lock(&tasklist_lock)		  read_lock(&tasklist_lock)
> +	 *   // link thread			  smp_mb__after_spinlock()
> +	 *   write_unlock(&tasklist_lock)	  read_unlock(&tasklist_lock);
> +	 *   sched_post_fork()			  for_each_process_thread()
> +	 *     __uclamp_sync_rt()		    __uclamp_sync_rt()
> +	 *
> +	 * Ensures that either sched_post_fork() will observe the new
> +	 * uclamp_min_rt or for_each_process_thread() will observe the new
> +	 * task.
> +	 */

more specifically this has the cases:


A)

	   copy_process()			sysctl_uclamp
						  uclamp_min_rt = X;
	     write_lock(&tasklist_lock)
	     // link thread
	     write_unlock(&tasklist_lock)
	     sched_post_fork()			  read_lock(&tasklist_lock)
	       __uclamp_sync_rt()		  smp_mb__after_spinlock()
                                                  read_unlock(&tasklist_lock);
                                                  for_each_process_thread()
                                                    __uclamp_sync_rt()


Where write_unlock()'s RELEASE matches read_lock() ACQUIRE and
guarantees for_each_process_thread() must observe the new thread.


B)


	   copy_process()			sysctl_uclamp
						  uclamp_min_rt = X;
						  read_lock(&tasklist_lock)
						  smp_mb__after_spinlock()
						  read_unlock(&tasklist_lock);
	     write_lock(&tasklist_lock)		  for_each_process_thread()
	     // link thread			    __uclamp_sync_rt()
             write_unlock(&tasklist_lock)
             sched_post_fork()
               __uclamp_sync_rt()

Where read_unlock()'s RELEASE matches write_lock()'s ACQUIRE and
sched_post_fork() must observe the uclamp_min_t STORE.

The smp_mb__after_spinlock() might be superfluous, but like said, brain
isn't working.
