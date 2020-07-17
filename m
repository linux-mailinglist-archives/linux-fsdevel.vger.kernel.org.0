Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3A67224599
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jul 2020 23:06:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbgGQVGF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Jul 2020 17:06:05 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:47368 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726399AbgGQVGF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Jul 2020 17:06:05 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06HL2NZS085868;
        Fri, 17 Jul 2020 21:05:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=f1RfLG9rSTeLiGLq95U2E9ilsHk1yVv7O8p3UH8YgSA=;
 b=LGojB183+7b5/wM3AQ/dmpbv8OPRsfv5S17Uu1/UXRwD6eRsEG2/zc9g4g7FDkl1rrEj
 pw67rVkXq8TNqIPqIF8DUDpaLDbWZnXAbCOjmuuyBD4uO6UmGp+1vIJnNL2yHKpX1bPZ
 l1aeCbmEeTAaDvDX9oXWUbOCggKoBpog6f+8Rh4BwjN4XZAbBBKc3ZLvUUIa/m94ZyoP
 AvwLsVc4SU5ZY3AvDHVvue9zfTUTzTGmIAGO+45BA3GIkC/JitG4hTUllko8OHjDfcAb
 Gs6PYZT+K3IjhfEWxIMr3yx6pEK0vX0Ku2uWHFJ6ROHd4IYCB8f5DtP8LeNlMT1G8qkF Ow== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 3274ursh64-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 17 Jul 2020 21:05:42 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06HL3qCo002912;
        Fri, 17 Jul 2020 21:05:42 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 32bj7gunus-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Jul 2020 21:05:41 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 06HL5dnd030869;
        Fri, 17 Jul 2020 21:05:39 GMT
Received: from localhost (/10.159.159.76)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 17 Jul 2020 14:05:39 -0700
Date:   Fri, 17 Jul 2020 14:05:36 -0700
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
Message-ID: <20200717210536.GQ3151642@magnolia>
References: <20200717044427.68747-1-ebiggers@kernel.org>
 <20200717174750.GQ12769@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200717174750.GQ12769@casper.infradead.org>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9685 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=100 malwarescore=0 phishscore=0
 adultscore=0 suspectscore=0 mlxscore=0 bulkscore=0 mlxlogscore=479
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007170142
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9685 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=100 lowpriorityscore=0 impostorscore=0
 suspectscore=0 phishscore=0 spamscore=0 mlxlogscore=496 malwarescore=0
 mlxscore=0 priorityscore=1501 adultscore=0 bulkscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007170142
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

I like it... :)

--D
