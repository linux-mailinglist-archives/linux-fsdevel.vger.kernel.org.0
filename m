Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC9C0224792
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Jul 2020 02:45:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728206AbgGRApG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Jul 2020 20:45:06 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:52328 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727040AbgGRApF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Jul 2020 20:45:05 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06I0cAaU143282;
        Sat, 18 Jul 2020 00:44:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=uEVaW1DiBeMddzOXVL0R9YHp0HsTabSpMxwlAF2Zg/0=;
 b=dHpUHXNsLFof9L8izRykLcviU3Cc07Znykdhgl0kwO4DCdDYaAQJNV/j9upq2CuWquTm
 HAYCPj+6wNhKHrLVhzXl9Z4vOI1eG2DJLTkHCV4qfbZDO5+F6P7yypR/hvHiuPsxwmdv
 7GDUbZ+MKY8NdMI6MHhZP4P5JevlUgISgVnZUeeUvMv2dcWZyCFNYml8IkUZQxwhKmNy
 YYGnyfq65VBrv3zbvgxYCw9a4iNj6mybhkdmUXaENhBIXIJJpIK/KVbWoC7iPm+7J3f1
 W5/BsPWlJINByfcfbd8/71Z7GL+EDXh0S+q9r6YPhL1htq3lm+7gObVWja4xlbTdQhnB vg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 32bpkar0t7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 18 Jul 2020 00:44:38 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06I0bmv7033794;
        Sat, 18 Jul 2020 00:44:38 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 32bp8x14ta-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 18 Jul 2020 00:44:37 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 06I0iT6E002365;
        Sat, 18 Jul 2020 00:44:32 GMT
Received: from localhost (/10.159.159.76)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 17 Jul 2020 17:44:29 -0700
Date:   Fri, 17 Jul 2020 17:44:27 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Eric Biggers <ebiggers@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org,
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
Message-ID: <20200718004427.GT3151642@magnolia>
References: <20200717044427.68747-1-ebiggers@kernel.org>
 <20200717174750.GQ12769@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200717174750.GQ12769@casper.infradead.org>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9685 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=100 suspectscore=0 bulkscore=0
 mlxlogscore=479 mlxscore=0 malwarescore=0 adultscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007180001
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9685 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=100 suspectscore=0 bulkscore=0
 mlxlogscore=496 mlxscore=0 malwarescore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 adultscore=0 priorityscore=1501 impostorscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007180001
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 17, 2020 at 06:47:50PM +0100, Matthew Wilcox wrote:
> On Thu, Jul 16, 2020 at 09:44:27PM -0700, Eric Biggers wrote:
> > +If that doesn't apply, you'll have to implement one-time init yourself.
> > +
> > +The simplest implementation just uses a mutex and an 'inited' flag.
> > +This implementation should be used where feasible:
> 
> I think some syntactic sugar should make it feasible for normal people
> to implement the most efficient version of this just like they use locks.
> 
> > +For the single-pointer case, a further optimized implementation
> > +eliminates the mutex and instead uses compare-and-exchange:
> > +
> > +	static struct foo *foo;
> > +
> > +	int init_foo_if_needed(void)
> > +	{
> > +		struct foo *p;
> > +
> > +		/* pairs with successful cmpxchg_release() below */
> > +		if (smp_load_acquire(&foo))
> > +			return 0;
> > +
> > +		p = alloc_foo();
> > +		if (!p)
> > +			return -ENOMEM;
> > +
> > +		/* on success, pairs with smp_load_acquire() above and below */
> > +		if (cmpxchg_release(&foo, NULL, p) != NULL) {
> 
> Why do we have cmpxchg_release() anyway?  Under what circumstances is
> cmpxchg() useful _without_ having release semantics?
> 
> > +			free_foo(p);
> > +			/* pairs with successful cmpxchg_release() above */
> > +			smp_load_acquire(&foo);
> > +		}
> > +		return 0;
> > +	}
> 
> How about something like this ...
> 
> once.h:
> 
> static struct init_once_pointer {
> 	void *p;
> };
> 
> static inline void *once_get(struct init_once_pointer *oncep)
> { ... }
> 
> static inline bool once_store(struct init_once_pointer *oncep, void *p)
> { ... }
> 
> --- foo.c ---
> 
> struct foo *get_foo(gfp_t gfp)
> {
> 	static struct init_once_pointer my_foo;
> 	struct foo *foop;
> 
> 	foop = once_get(&my_foo);
> 	if (foop)
> 		return foop;
> 
> 	foop = alloc_foo(gfp);
> 	if (!once_store(&my_foo, foop)) {
> 		free_foo(foop);
> 		foop = once_get(&my_foo);
> 	}
> 
> 	return foop;
> }
> 
> Any kernel programmer should be able to handle that pattern.  And no mutex!

That would be even better.

--D
