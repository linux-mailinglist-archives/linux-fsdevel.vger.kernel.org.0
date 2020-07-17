Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28FB4223083
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jul 2020 03:37:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726198AbgGQBg6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Jul 2020 21:36:58 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:57552 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgGQBg5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Jul 2020 21:36:57 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06H1X4li141878;
        Fri, 17 Jul 2020 01:36:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=uVmsOsNZYXiEuDVBocAnIVjFSzJfXAHGYQ3CQA6PWaM=;
 b=rUPlPOBIhTHtgdFFSkP8CIxJsXnM+pg422anFeRRjgw7GOFhgC0HM50JFsLezB39PeVq
 B99t2dHYZy2FYjTE/hWR7D8BxGz0CCLuW8Tn/25rjlXor/rQZile+yItMleTf02UCwbU
 2f9vIy+ypwASTo+/zDrlQqJyX6RCNMiC8U+Ysgp0FBunZISmdqgqWMP9ZpkdiJgxR7cn
 gGd9NwvhMtgR4wC2V1urujcsoiFFg2xTFS3cUNdjL3CLV3UkFJvyA5WcH/7nQMKTSsPy
 hMMV+92iZmgME/UUPYfga2qdyE8iDTGuh/M18LY88glqKfOz5dG6Bz55CiVedNvNmqIt mw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 3275cmmmcx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 17 Jul 2020 01:36:43 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06H1RjR5098484;
        Fri, 17 Jul 2020 01:36:43 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 327q0uj4t5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Jul 2020 01:36:43 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 06H1af6b014556;
        Fri, 17 Jul 2020 01:36:41 GMT
Received: from localhost (/10.159.154.157)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 16 Jul 2020 18:36:41 -0700
Date:   Thu, 16 Jul 2020 18:36:39 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Eric Biggers <ebiggers@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH] fs/direct-io: avoid data race on ->s_dio_done_wq
Message-ID: <20200717013639.GN3151642@magnolia>
References: <20200713033330.205104-1-ebiggers@kernel.org>
 <20200715013008.GD2005@dread.disaster.area>
 <20200715023714.GA38091@sol.localdomain>
 <20200715080144.GF2005@dread.disaster.area>
 <20200715161342.GA1167@sol.localdomain>
 <20200716014656.GJ2005@dread.disaster.area>
 <20200716024717.GJ12769@casper.infradead.org>
 <20200716053332.GH1167@sol.localdomain>
 <20200716081616.GM5369@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200716081616.GM5369@dread.disaster.area>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9684 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=100 mlxscore=0 malwarescore=0 spamscore=0
 mlxlogscore=757 bulkscore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007170008
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9684 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=100 suspectscore=0 priorityscore=1501
 bulkscore=0 adultscore=0 lowpriorityscore=0 phishscore=0 spamscore=100
 impostorscore=0 malwarescore=0 mlxlogscore=-1000 clxscore=1015
 mlxscore=100 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007170008
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 16, 2020 at 06:16:16PM +1000, Dave Chinner wrote:
> On Wed, Jul 15, 2020 at 10:33:32PM -0700, Eric Biggers wrote:
> > On Thu, Jul 16, 2020 at 03:47:17AM +0100, Matthew Wilcox wrote:
> > > On Thu, Jul 16, 2020 at 11:46:56AM +1000, Dave Chinner wrote:
> > > > And why should we compromise performance on hundreds of millions of
> > > > modern systems to fix an extremely rare race on an extremely rare
> > > > platform that maybe only a hundred people world-wide might still
> > > > use?
> > > 
> > > I thought that wasn't the argument here.  It was that some future
> > > compiler might choose to do something absolutely awful that no current
> > > compiler does, and that rather than disable the stupid "optimisation",
> > > we'd be glad that we'd already stuffed the source code up so that it
> > > lay within some tortuous reading of the C spec.
> > > 
> > > The memory model is just too complicated.  Look at the recent exchange
> > > between myself & Dan Williams.  I spent literally _hours_ trying to
> > > figure out what rules to follow.
> > > 
> > > https://lore.kernel.org/linux-mm/CAPcyv4jgjoLqsV+aHGJwGXbCSwbTnWLmog5-rxD2i31vZ2rDNQ@mail.gmail.com/
> > > https://lore.kernel.org/linux-mm/CAPcyv4j2+7XiJ9BXQ4mj_XN0N+rCyxch5QkuZ6UsOBsOO1+2Vg@mail.gmail.com/
> > > 
> > > Neither Dan nor I are exactly "new" to Linux kernel development.  As Dave
> > > is saying here, having to understand the memory model is too high a bar.
> > > 
> > > Hell, I don't know if what we ended up with for v4 is actually correct.
> > > It lokos good to me, but *shrug*
> > > 
> > > https://lore.kernel.org/linux-mm/159009507306.847224.8502634072429766747.stgit@dwillia2-desk3.amr.corp.intel.com/
> > 
> > Looks like you still got it wrong :-(  It needs:
> > 
> > diff --git a/drivers/char/mem.c b/drivers/char/mem.c
> > index 934c92dcb9ab..9a95fbe86e15 100644
> > --- a/drivers/char/mem.c
> > +++ b/drivers/char/mem.c
> > @@ -1029,7 +1029,7 @@ static int devmem_init_inode(void)
> >         }
> > 
> >         /* publish /dev/mem initialized */
> > -       WRITE_ONCE(devmem_inode, inode);
> > +       smp_store_release(&devmem_inode, inode);
> > 
> >         return 0;
> >  }
> > 
> > It seems one source of confusion is that READ_ONCE() and WRITE_ONCE() don't
> > actually pair with each other, unless no memory barriers are needed at all.
> > 
> > Instead, READ_ONCE() pairs with a primitive that has "release" semantics, e.g.
> > smp_store_release() or cmpxchg_release(). But READ_ONCE() is only correct if
> > there's no control flow dependency; if there is, it needs to be upgraded to a
> > primitive with "acquire" semantics, e.g. smp_load_acquire().
> 
> You lost your audience at "control flow dependency". i.e. you're
> trying to explain memory ordering requirements by using terms that
> only people who deeply grok memory ordering understand.
> 
> I can't tell you what a control flow dependency is off the top
> of my head - I'd have to look up the documentation to remind myself
> what it means and why it might be important. Then I'll realise yet
> again that if I just use release+acquire message passing constructs,
> I just don't have to care about them. And so I promptly forget about
> them again.
> 
> My point is that the average programmer does not need to know what a
> control flow or data depedency is to use memory ordering semantics
> correctly. If you want to optimise your code down to the Nth degree
> then you *may* need to know that, but almost nobody in the kernel
> needs to optimise their code to that extent.
> 
> > The best approach might be to just say that the READ_ONCE() + "release" pairing
> > should be avoided, and we should stick to "acquire" + "release".  (And I think
> > Dave may be saying he'd prefer that for ->s_dio_done_wq?)
> 
> Pretty much.
> 
> We need to stop thinking of these synchronisation primitives as
> "memory ordering" or "memory barriers" or "atomic access" and
> instead think of them as tools to pass data safely between concurrent
> threads.
> 
> We need to give people a simple mental model and/or pattern for
> passing data safely between two racing threads, not hit them over
> the head with the LKMM documentation. People are much more likely to
> understand the ordering and *much* less likely to make mistakes
> given clear, simple examples to follow. And that will stick if you
> can relate those examples back to the locking constructs they
> already understand and have been using for years.
> 
> e.g. basic message passing. foo = 0 is the initial message state, y
> is the mail box flag, initially 0/locked:
> 
> 			locking:	ordered code:
> 
> write message:		foo = 1		foo = 1
> post message:		spin_unlock(y)	smp_store_release(y, 1)
> 
> check message box:	spin_lock(y)	if (smp_load_acquire(y) == 1)
> got message:		print(foo)		print(foo)
> 
> And in both cases we will always get "foo = 1" as the output of
> both sets of code. i.e. foo is the message, y is the object that
> guarantees delivery of the message.
> 
> This makes the code Willy linked to obvious. The message to be
> delivered is the inode and it's contents, and it is posted via
> the devmem_inode. Hence:
> 
> write message:		inode = alloc_anon_inode()
> post message:		smp_store_release(&devmem_inode, inode);
> 
> check message box:	inode = smp_load_acquire(&devmem_inode);
> got message?		if (!inode)
>     no				<fail>
>    yes			<message contents guaranteed to be seen>
> 
> To someone familiar with message passing patterns, this code almost
> doesn't need comments to explain it.

Yes.  This!!!

I want a nice one-pager in the recipes file telling me how to do
opportunistic pointer initialization initialization locklessly.  I want
the people who specialize in understanding memory models to verify that
yes, this samplecode is correct.

I want to concentrate my attention on the higher level things that I
specialize in, namely XFS, which means that I want to build XFS things
out of high quality lower level pieces that are built by people who are
experts at those lower level things so I don't have to make a huge
detour understanding another highly complex thing.  All that will do is
exercise my brain's paging algorithms.

The alternative is that I'll just use a spinlock/rwsem/mutex because
that's what I know, and they're easy to think about.  Right now I have
barely any idea what's really the difference between
READ_ONCE/smp_rmb/smp_load_acquire, and I'd rather frame the discussion
as "here's my higher level problem, how do I solve this?"

(end crazy maintainer rambling)

--D

> Using memory ordering code becomes much simpler when we think of it
> as a release+acquire pattern rather than "READ_ONCE/WRITE_ONCE plus
> (some set of) memory barriers" because it explicitly lays out the
> ordering requirements of the code on both sides of the pattern.
> Once a developer creates a mental association between the
> release+acquire message passing mechanism and critical section
> ordering defined by unlock->lock operations, ordering becomes much
> less challenging to think and reason about.
> 
> Part of the problem is that RO/WO are now such overloaded operators
> it's hard to understand all the things they do or discriminate
> between which function a specific piece of code is relying on.
> 
> IMO, top level kernel developers need to stop telling people "you
> need to understand the lkmm and/or memory_barriers.txt" like it's
> the only way to write safe concurrent code. The reality is that most
> devs don't need to understand it at all.  We'll make much more
> progress on fixing broken code and having new code being written
> correctly by teaching people simple patterns that are easy to
> explain, easy to learn, *hard to get wrong* and easy to review. And
> then they'll use them in places where they'd previously not care
> about data races because they have been taught "this is the way we
> should write concurrent code". They'll never learn that from being
> told to read the LKMM documentation....
> 
> So if you find yourself using the words "LKMM", "control flow",
> "data dependency", "compiler optimisation" or other intricate
> details or the memory model, then you've already lost your
> audience....
> 
> Cheers,
> 
> Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
