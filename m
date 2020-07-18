Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F38B224BD7
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Jul 2020 16:36:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727120AbgGROfE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 Jul 2020 10:35:04 -0400
Received: from netrider.rowland.org ([192.131.102.5]:40007 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726798AbgGROfD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 Jul 2020 10:35:03 -0400
Received: (qmail 1180388 invoked by uid 1000); 18 Jul 2020 10:35:02 -0400
Date:   Sat, 18 Jul 2020 10:35:02 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org,
        "Paul E . McKenney" <paulmck@kernel.org>,
        linux-fsdevel@vger.kernel.org, Akira Yokosawa <akiyks@gmail.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Dave Chinner <david@fromorbit.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Nicholas Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH] tools/memory-model: document the "one-time init" pattern
Message-ID: <20200718143502.GC1179836@rowland.harvard.edu>
References: <20200717044427.68747-1-ebiggers@kernel.org>
 <20200717174750.GQ12769@casper.infradead.org>
 <20200718013839.GD2183@sol.localdomain>
 <20200718021304.GS12769@casper.infradead.org>
 <20200718052818.GF2183@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200718052818.GF2183@sol.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 17, 2020 at 10:28:18PM -0700, Eric Biggers wrote:
> /**
>  * INIT_ONCE() - do one-time initialization
>  * @done: pointer to a 'bool' flag that tracks whether initialization has been
>  *	  done yet or not.  Must be false by default.
>  * @mutex: pointer to a mutex to use to synchronize executions of @init_func
>  * @init_func: the one-time initialization function
>  * @...: additional arguments to pass to @init_func (optional)
>  *
>  * This is a more general version of DO_ONCE_BLOCKING() which supports
>  * non-static data by allowing the user to specify their own 'done' flag and
>  * mutex.
>  *
>  * Return: 0 on success (done or already done), or a negative errno value
>  *	   returned by @init_func.

It might be worth pointing out explicitly that init_func can be called 
multiple times, if it returns an error.

>  */
> #define INIT_ONCE(done, mutex, init_func, ...)				\
> ({									\
>  	int err = 0;							\
> 									\
> 	if (!smp_load_acquire(done)) {					\
> 		mutex_lock(mutex);					\
> 		if (!*(done)) {						\
> 			err = init_func(__VA_ARGS__);			\
> 			if (!err)					\
> 				smp_store_release((done), true);	\
> 		}							\
> 		mutex_unlock(mutex);					\
> 	}								\
>  	err;								\
> })

If this macro is invoked in multiple places for the same object (which 
is not unlikely), there is a distinct risk that people will supply 
different mutexes or done variables for the invocations.

IMO a better approach would be to have a macro which, given a variable 
name v, generates an actual init_once_v() function.  Then code wanting 
to use v would call init_once_v() first, with no danger of inconsistent 
usage.  You can fill in the details...

Alan Stern
