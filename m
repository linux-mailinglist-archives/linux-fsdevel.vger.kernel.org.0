Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 975EB2FF058
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Jan 2021 17:32:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733272AbhAUQbA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Jan 2021 11:31:00 -0500
Received: from smtp180.sjtu.edu.cn ([202.120.2.180]:53972 "EHLO
        smtp180.sjtu.edu.cn" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730948AbhAUQau (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Jan 2021 11:30:50 -0500
Received: from mta04.sjtu.edu.cn (mta04.sjtu.edu.cn [202.121.179.8])
        by smtp180.sjtu.edu.cn (Postfix) with ESMTPS id 8BE881008CBFA;
        Fri, 22 Jan 2021 00:30:04 +0800 (CST)
Received: from localhost (localhost [127.0.0.1])
        by mta04.sjtu.edu.cn (Postfix) with ESMTP id 69AC9180695CD;
        Fri, 22 Jan 2021 00:30:04 +0800 (CST)
X-Virus-Scanned: amavisd-new at mta04.sjtu.edu.cn
Received: from mta04.sjtu.edu.cn ([127.0.0.1])
        by localhost (mta04.sjtu.edu.cn [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id qhxFy0bwXTQo; Fri, 22 Jan 2021 00:30:04 +0800 (CST)
Received: from mstore107.sjtu.edu.cn (unknown [10.118.0.107])
        by mta04.sjtu.edu.cn (Postfix) with ESMTP id 21E19180695CC;
        Fri, 22 Jan 2021 00:30:04 +0800 (CST)
Date:   Fri, 22 Jan 2021 00:30:00 +0800 (CST)
From:   Zhongwei Cai <sunrise_l@sjtu.edu.cn>
To:     Jan Kara <jack@suse.cz>, Dave Chinner <david@fromorbit.com>
Cc:     Mikulas Patocka <mpatocka@redhat.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Matthew Wilcox <willy@infradead.org>,
        David Laight <David.Laight@aculab.com>,
        Mingkai Dong <mingkaidong@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Whitehouse <swhiteho@redhat.com>,
        Eric Sandeen <esandeen@redhat.com>,
        Dave Chinner <dchinner@redhat.com>,
        Wang Jianchao <jianchao.wan9@gmail.com>,
        Rajesh Tadakamadla <rajesh.tadakamadla@hpe.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>
Message-ID: <323586311.2762348.1611246600848.JavaMail.zimbra@sjtu.edu.cn>
In-Reply-To: <20210120141834.GA24063@quack2.suse.cz>
References: <alpine.LRH.2.02.2101061245100.30542@file01.intranet.prod.int.rdu2.redhat.com> <20210107151125.GB5270@casper.infradead.org> <17045315-CC1F-4165-B8E3-BA55DD16D46B@gmail.com> <2041983017.5681521.1610459100858.JavaMail.zimbra@sjtu.edu.cn> <alpine.LRH.2.02.2101131008530.27448@file01.intranet.prod.int.rdu2.redhat.com> <1224425872.715547.1610703643424.JavaMail.zimbra@sjtu.edu.cn> <20210120044700.GA4626@dread.disaster.area> <20210120141834.GA24063@quack2.suse.cz>
Subject: Re: Expense of read_iter
MIME-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: 7bit
X-Originating-IP: [58.196.139.16]
X-Mailer: Zimbra 8.8.15_GA_3980 (ZimbraWebClient - FF84 (Win)/8.8.15_GA_3928)
Thread-Topic: Expense of read_iter
Thread-Index: iDlr565GHhmBWjkzqz9bX3XXoj59EA==
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On Wed, 20 Jan 2021, Jan Kara wrote:
> On Wed 20-01-21 15:47:00, Dave Chinner wrote:
> > On Fri, Jan 15, 2021 at 05:40:43PM +0800, Zhongwei Cai wrote:
> > > On Thu, 14 Jan 2021, Mikulas wrote:
> > > For Ext4-dax, the overhead of dax_iomap_rw is significant
> > > compared to the overhead of struct iov_iter. Although methods
> > > proposed by Mikulas can eliminate the overhead of iov_iter
> > > well, they can not be applied in Ext4-dax unless we implement an
> > > internal "read" method in Ext4-dax.
> > >
>> > For Ext4-dax, there could be two approaches to optimizing:
> > > 1) implementing the internal "read" method without the complexity
> > > of iterators and dax_iomap_rw;
> >
> > Please do not go an re-invent the wheel just for ext4. If there's a
> > problem in a shared path - ext2, FUSE and XFS all use dax_iomap_rw()
> > as well, so any improvements to that path benefit all DAX users, not
> > just ext4.
> >
> > > 2) optimizing how dax_iomap_rw works.
> > > Since dax_iomap_rw requires ext4_iomap_begin, which further involves
> > > the iomap structure and others (e.g., journaling status locks in Ext4),
> > > we think implementing the internal "read" method would be easier.
> >
> > Maybe it is, but it's also very selfish. The DAX iomap path was
> > written to be correct for all users, not inecessarily provide
> > optimal performance. There will be lots of things that could be done
> > to optimise it, so rather than creating a special snowflake in ext4
> > that makes DAX in ext4 much harder to maintain for non-ext4 DAX
> > developers, please work to improve the common DAX IO path and so
> > provide the same benefit to all the filesystems that use it.
>
> Yeah, I agree. I'm against ext4 private solution for this read problem. And
> I'm also against duplicating ->read_iter functionatily in ->read handler.
> The maintenance burden of this code duplication is IMHO just too big. We
> rather need to improve the generic code so that the fast path is faster.
> And every filesystem will benefit because this is not ext4 specific
> problem.
> 
>                                                                 Honza

We agree that maintenance burden could be a problem here. So we will take
your suggestions and try to optimize on the generic path. But as Mikulas
said ( https://lkml.org/lkml/2021/1/20/618 ), it seems that some parts of
the overhead are hard to avoid, such as new_sync_read, and we are concerned
that optimizing on the generic path will have limited effect. Nevertheless,
we will try to optimize the generic path and see how much we can improve.

Zhongwei
