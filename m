Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 492EB2212B0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jul 2020 18:43:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728051AbgGOQl0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Jul 2020 12:41:26 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:60472 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727037AbgGOQlZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Jul 2020 12:41:25 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06FGRBCA114614;
        Wed, 15 Jul 2020 16:41:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=F2LkoM+UWtBMNs81QAgimajX13qffszW2vrur3LEJAs=;
 b=mzpb91InlBToye1VyhhDpXuE6dalx8a1Ki6BYrf/xOZ+9ec0NAC7EqH5gmlSsV8ht5al
 0IBwe0SmOAqg47AKlUxBmcmOMZWdVJ30IiaoHLrEL8Xc03alFTWX2VF/XDI2Jhg6j2Vz
 qvOv1SlRPe3PX796G0V1f8BnFX0VLGTH6VRZF3kPTLZO8UIuiBtJnlgvkS5FP64VWB8Y
 goJZNI0HHCq59zAA+w1BzL5sC4abA1PNFRTP0d+kPMXpzWLXqFxH9cV6NQ+lKoqo7nsY
 s+LYbQrZMBIsK/Ju/3k5pHMxOna2ZamfKeXGQ9ObIvwA9BzBtDRz9Dp8Qfo6qlgnmpnu qg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 3275cmcgpb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 15 Jul 2020 16:41:22 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06FGMggF044797;
        Wed, 15 Jul 2020 16:41:21 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 327qc1a91y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Jul 2020 16:41:21 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 06FGfK10006935;
        Wed, 15 Jul 2020 16:41:20 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 15 Jul 2020 09:41:20 -0700
Date:   Wed, 15 Jul 2020 09:41:18 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Dave Chinner <david@fromorbit.com>, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [PATCH] fs/direct-io: avoid data race on ->s_dio_done_wq
Message-ID: <20200715164118.GB848607@magnolia>
References: <20200713033330.205104-1-ebiggers@kernel.org>
 <20200715013008.GD2005@dread.disaster.area>
 <20200715023714.GA38091@sol.localdomain>
 <20200715080144.GF2005@dread.disaster.area>
 <20200715161342.GA1167@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200715161342.GA1167@sol.localdomain>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9683 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 mlxscore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007150129
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9683 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 priorityscore=1501
 bulkscore=0 adultscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 impostorscore=0 malwarescore=0 mlxlogscore=999 clxscore=1015 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007150129
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 15, 2020 at 09:13:42AM -0700, Eric Biggers wrote:
> On Wed, Jul 15, 2020 at 06:01:44PM +1000, Dave Chinner wrote:
> > > > >  /* direct-io.c: */
> > > > > -int sb_init_dio_done_wq(struct super_block *sb);
> > > > > +int __sb_init_dio_done_wq(struct super_block *sb);
> > > > > +static inline int sb_init_dio_done_wq(struct super_block *sb)
> > > > > +{
> > > > > +	/* pairs with cmpxchg() in __sb_init_dio_done_wq() */
> > > > > +	if (likely(READ_ONCE(sb->s_dio_done_wq)))
> > > > > +		return 0;
> > > > > +	return __sb_init_dio_done_wq(sb);
> > > > > +}
> > > > 
> > > > Ummm, why don't you just add this check in sb_init_dio_done_wq(). I
> > > > don't see any need for adding another level of function call
> > > > abstraction in the source code?
> > > 
> > > This keeps the fast path doing no function calls and one fewer branch, as it was
> > > before.  People care a lot about minimizing direct I/O overhead, so it seems
> > > desirable to keep this simple optimization.  Would you rather it be removed?
> > 
> > No.
> > 
> > What I'm trying to say is that I'd prefer fast path checks don't get
> > hidden away in a static inline function wrappers that require the
> > reader to go look up code in a different file to understand that
> > code in yet another different file is conditionally executed.
> > 
> > Going from obvious, easy to read fast path code to spreading the
> > fast path logic over functions in 3 different files is not an
> > improvement in the code - it is how we turn good code into an
> > unmaintainable mess...
> 
> The alternative would be to duplicate the READ_ONCE() at all 3 call sites --
> including the explanatory comment.  That seems strictly worse.
> 
> And the code before was broken, so I disagree it was "obvious" or "good".
> 
> > 
> > > > Also, you need to explain the reason for the READ_ONCE() existing
> > > > rather than just saying "it pairs with <some other operation>".
> > > > Knowing what operation it pairs with doesn't explain why the pairing
> > > > is necessary in the first place, and that leads to nobody reading
> > > > the code being able to understand what this is protecting against.
> > > > 
> > > 
> > > How about this?
> > > 
> > > 	/*
> > > 	 * Nothing to do if ->s_dio_done_wq is already set.  But since another
> > > 	 * process may set it concurrently, we need to use READ_ONCE() rather
> > > 	 * than a plain read to avoid a data race (undefined behavior) and to
> > > 	 * ensure we observe the pointed-to struct to be fully initialized.
> > > 	 */
> > > 	if (likely(READ_ONCE(sb->s_dio_done_wq)))
> > > 		return 0;
> > 
> > You still need to document what it pairs with, as "data race" doesn't
> > describe the actual dependency we are synchronising against is.
> > 
> > AFAICT from your description, the data race is not on
> > sb->s_dio_done_wq itself, but on seeing the contents of the
> > structure being pointed to incorrectly. i.e. we need to ensure that
> > writes done before the cmpxchg are ordered correctly against
> > reads done after the pointer can be seen here.
> > 
> 
> No, the data race is on ->s_dio_done_wq itself.  How about this:
> 
>         /*
>          * Nothing to do if ->s_dio_done_wq is already set.  The READ_ONCE()
>          * here pairs with the cmpxchg() in __sb_init_dio_done_wq().  Since the
>          * cmpxchg() may set ->s_dio_done_wq concurrently, a plain load would be
>          * a data race (undefined behavior), so READ_ONCE() is needed.
>          * READ_ONCE() also includes any needed read data dependency barrier to
>          * ensure that the pointed-to struct is seen to be fully initialized.
>          */
> 
> FWIW, long-term we really need to get developers to understand these sorts of
> issues, so that the code is written correctly in the first place and we don't
> need to annotate common patterns like one-time-init with a long essay and have a
> long discussion.  Recently KCSAN was merged upstream
> (https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/dev-tools/kcsan.rst)
> and the memory model documentation was improved
> (https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/memory-model/Documentation/explanation.txt?h=v5.8-rc5#n1922),
> so hopefully that will raise awareness...

I tried to understand that, but TBH this whole topic area seems very
complex and difficult to understand.  I more or less understand what
READ_ONCE and WRITE_ONCE do wrt restricting compiler optimizations, but
I wouldn't say that I understand all that machinery.

Granted, my winning strategy so far is to write a simple version with
big dumb locks and let the rest of you argue over slick optimizations.
:P

<shrug> If using READ_ONCE and cmpxchg for pointer initialization (or I
guess smp_store_release and smp_load_acquire?) are a commonly used
paradigm, then maybe that should get its own section in
tools/memory-model/Documentation/recipes.txt and then any code that uses
it can point readers at that?

--D

> > If so, can't we just treat this as a normal
> > store-release/load-acquire ordering pattern and hence use more
> > relaxed memory barriers instead of have to patch up what we have now
> > to specifically make ancient platforms that nobody actually uses
> > with weird and unusual memory models work correctly?
> 
> READ_ONCE() is already as relaxed as it can get, as it includes a read data
> dependency barrier only (which is no-op on everything other than Alpha).
> 
> If anything it should be upgraded to smp_load_acquire(), which handles control
> dependencies too.  I didn't see anything obvious in the workqueue code that
> would need that (i.e. accesses to some global structure that isn't transitively
> reachable via the workqueue_struct itself).  But we could use it to be safe if
> we're okay with any performance implications of the additional memory barrier it
> would add.
> 
> - Eric
