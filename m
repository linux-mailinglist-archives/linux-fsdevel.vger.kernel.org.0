Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5561B22456F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jul 2020 22:55:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726626AbgGQUzL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Jul 2020 16:55:11 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:39394 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726399AbgGQUzK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Jul 2020 16:55:10 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06HKqYLk077318;
        Fri, 17 Jul 2020 20:54:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=mime-version :
 message-id : date : from : to : cc : subject : references : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=Ce8mBbGSeLNIbOTJ85IBFw/y0NRxNfTFyX4E650zagA=;
 b=oYu+s4oqM+9MXi+/fvD2qzVMKbfn/rbPH7USGrarXDeLEwsm8f7X/b6DwfJNSsVlOWYK
 1LLrmAEFqmCvxhg1GngMwzWv1+hfrnNKr5Jk+xjQUOQ7UBAMRo8bHBjZsEOnXWkNbxkB
 5DDcoC5ZPdFd4+4ua2U375uDA7IZWip5Pzkq5yTejJtIdAUfbfqzmFSKogSoX6jiEcqw
 audUCKU2a6mxS57kf73P5KmlknIL9XveUir5Z+tPrAhPi2DixhoWmxxoe25v2C75lcVi
 UBz2H7pKqduxZ8Q7+cnfynh+DvWRk2mZrI6Qdp3oLe9ZPbliEZJSN4+kswJkZP+qMzVT aQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 3274ursfrg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 17 Jul 2020 20:54:43 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06HKrlnR061412;
        Fri, 17 Jul 2020 20:54:42 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 32bjj9umqg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Jul 2020 20:54:42 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 06HKsXdM011945;
        Fri, 17 Jul 2020 20:54:39 GMT
Received: from localhost (/10.159.159.76) by default (Oracle Beehive Gateway
 v4.0) with ESMTP ; Fri, 17 Jul 2020 13:53:42 -0700
MIME-Version: 1.0
Message-ID: <20200717205340.GR7625@magnolia>
Date:   Fri, 17 Jul 2020 13:53:40 -0700 (PDT)
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        "Paul E . McKenney" <paulmck@kernel.org>,
        linux-fsdevel@vger.kernel.org, Akira Yokosawa <akiyks@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Dave Chinner <david@fromorbit.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Nicholas Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH] tools/memory-model: document the "one-time init" pattern
References: <20200717044427.68747-1-ebiggers@kernel.org>
In-Reply-To: <20200717044427.68747-1-ebiggers@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9685 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=100 malwarescore=0 suspectscore=0
 spamscore=100 adultscore=0 phishscore=0 mlxscore=100 mlxlogscore=-1000
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007170141
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9685 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=100 lowpriorityscore=0 impostorscore=0
 suspectscore=0 phishscore=0 spamscore=100 mlxlogscore=-1000 malwarescore=0
 mlxscore=100 priorityscore=1501 adultscore=0 bulkscore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007170141
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 16, 2020 at 09:44:27PM -0700, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> The "one-time init" pattern is implemented incorrectly in various places
> in the kernel.  And when people do try to implement it correctly, it is
> unclear what to use.  Try to give some proper guidance.
> 
> This is motivated by the discussion at
> https://lkml.kernel.org/linux-fsdevel/20200713033330.205104-1-ebiggers@kernel.org/T/#u
> regarding fixing the initialization of super_block::s_dio_done_wq.
> 
> Cc: Akira Yokosawa <akiyks@gmail.com>
> Cc: Alan Stern <stern@rowland.harvard.edu>
> Cc: Andrea Parri <parri.andrea@gmail.com>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: Daniel Lustig <dlustig@nvidia.com>
> Cc: Darrick J. Wong <darrick.wong@oracle.com>
> Cc: Dave Chinner <david@fromorbit.com>
> Cc: David Howells <dhowells@redhat.com>
> Cc: Jade Alglave <j.alglave@ucl.ac.uk>
> Cc: Luc Maranget <luc.maranget@inria.fr>
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Cc: Paul E. McKenney <paulmck@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Will Deacon <will@kernel.org>
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
>  tools/memory-model/Documentation/recipes.txt | 151 +++++++++++++++++++
>  1 file changed, 151 insertions(+)
> 
> diff --git a/tools/memory-model/Documentation/recipes.txt b/tools/memory-model/Documentation/recipes.txt
> index 7fe8d7aa3029..04beb06dbfc7 100644
> --- a/tools/memory-model/Documentation/recipes.txt
> +++ b/tools/memory-model/Documentation/recipes.txt
> @@ -519,6 +519,157 @@ CPU1 puts the waiting task to sleep and CPU0 fails to wake it up.
>  
>  Note that use of locking can greatly simplify this pattern.
>  
> +One-time init
> +-------------
> +
> +The "one-time init" pattern is when multiple tasks can race to
> +initialize the same data structure(s) on first use.
> +
> +In many cases, it's best to just avoid the need for this by simply
> +initializing the data ahead of time.
> +
> +But in cases where the data would often go unused, one-time init can be
> +appropriate to avoid wasting kernel resources.  It can also be
> +appropriate if the initialization has other prerequisites which preclude
> +it being done ahead of time.
> +
> +First, consider if your data has (a) global or static scope, (b) can be
> +initialized from atomic context, and (c) cannot fail to be initialized.
> +If all of those apply, just use DO_ONCE() from <linux/once.h>:
> +
> +	DO_ONCE(func);
> +
> +If that doesn't apply, you'll have to implement one-time init yourself.
> +
> +The simplest implementation just uses a mutex and an 'inited' flag.
> +This implementation should be used where feasible:
> +
> +	static bool foo_inited;
> +	static DEFINE_MUTEX(foo_init_mutex);
> +
> +	int init_foo_if_needed(void)
> +	{
> +		int err = 0;
> +
> +		mutex_lock(&foo_init_mutex);
> +		if (!foo_inited) {
> +			err = init_foo();
> +			if (err == 0)
> +				foo_inited = true;
> +		}
> +		mutex_unlock(&foo_init_mutex);
> +		return err;
> +	}
> +
> +The above example uses static variables, but this solution also works
> +for initializing something that is part of another data structure.  The
> +mutex may still be static.
> +
> +In where cases where taking the mutex in the "already initialized" case
> +presents scalability concerns, the implementation can be optimized to
> +check the 'inited' flag outside the mutex.  Unfortunately, this
> +optimization is often implemented incorrectly by using a plain load.
> +That violates the memory model and may result in unpredictable behavior.
> +
> +A correct implementation is:
> +
> +	static bool foo_inited;
> +	static DEFINE_MUTEX(foo_init_mutex);
> +
> +	int init_foo_if_needed(void)
> +	{
> +		int err = 0;
> +
> +		/* pairs with smp_store_release() below */
> +		if (smp_load_acquire(&foo_inited))
> +			return 0;
> +
> +		mutex_lock(&foo_init_mutex);
> +		if (!foo_inited) {
> +			err = init_foo();
> +			if (err == 0) /* pairs with smp_load_acquire() above */
> +				smp_store_release(&foo_inited, true);
> +		}
> +		mutex_unlock(&foo_init_mutex);
> +		return err;
> +	}
> +
> +If only a single data structure is being initialized, then the pointer
> +itself can take the place of the 'inited' flag:
> +
> +	static struct foo *foo;
> +	static DEFINE_MUTEX(foo_init_mutex);
> +
> +	int init_foo_if_needed(void)
> +	{
> +		int err = 0;
> +
> +		/* pairs with smp_store_release() below */
> +		if (smp_load_acquire(&foo))
> +			return 0;
> +
> +		mutex_lock(&foo_init_mutex);
> +		if (!foo) {
> +			struct foo *p = alloc_foo();
> +
> +			if (p) /* pairs with smp_load_acquire() above */
> +				smp_store_release(&foo, p);
> +			else
> +				err = -ENOMEM;
> +		}
> +		mutex_unlock(&foo_init_mutex);
> +		return err;
> +	}
> +
> +There are also cases in which the smp_load_acquire() can be replaced by
> +the more lightweight READ_ONCE().  (smp_store_release() is still
> +required.)  Specifically, if all initialized memory is transitively
> +reachable from the pointer itself, then there is no control dependency

I don't quite understand what "transitively reachable from the pointer
itself" means?  Does that describe the situation where all the objects
reachable through the object that the global struct foo pointer points
at are /only/ reachable via that global pointer?

Aside from that question, I very much like having this recipe in the
kernel documentation.  Thank you for putting this together!

--D

> +so the data dependency barrier provided by READ_ONCE() is sufficient.
> +
> +However, using the READ_ONCE() optimization is discouraged for
> +nontrivial data structures, as it can be difficult to determine if there
> +is a control dependency.  For complex data structures it may depend on
> +internal implementation details of other kernel subsystems.
> +
> +For the single-pointer case, a further optimized implementation
> +eliminates the mutex and instead uses compare-and-exchange:
> +
> +	static struct foo *foo;
> +
> +	int init_foo_if_needed(void)
> +	{
> +		struct foo *p;
> +
> +		/* pairs with successful cmpxchg_release() below */
> +		if (smp_load_acquire(&foo))
> +			return 0;
> +
> +		p = alloc_foo();
> +		if (!p)
> +			return -ENOMEM;
> +
> +		/* on success, pairs with smp_load_acquire() above and below */
> +		if (cmpxchg_release(&foo, NULL, p) != NULL) {
> +			free_foo(p);
> +			/* pairs with successful cmpxchg_release() above */
> +			smp_load_acquire(&foo);
> +		}
> +		return 0;
> +	}
> +
> +Note that when the cmpxchg_release() fails due to another task already
> +having done it, a second smp_load_acquire() is required, since we still
> +need to acquire the data that the other task released.  You may be
> +tempted to upgrade cmpxchg_release() to cmpxchg() with the goal of it
> +acting as both ACQUIRE and RELEASE, but that doesn't work here because
> +cmpxchg() only guarantees memory ordering if it succeeds.
> +
> +Because of the above subtlety, the version with the mutex instead of
> +cmpxchg_release() should be preferred, except potentially in cases where
> +it is difficult to provide anything other than a global mutex and where
> +the one-time data is part of a frequently allocated structure.  In that
> +case, a global mutex might present scalability concerns.
>  
>  Rules of thumb
>  ==============
> -- 
> 2.27.0
> 
