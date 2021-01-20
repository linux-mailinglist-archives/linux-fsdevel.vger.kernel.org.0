Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A73C2FD285
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Jan 2021 15:22:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388263AbhATOU1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Jan 2021 09:20:27 -0500
Received: from mx2.suse.de ([195.135.220.15]:55878 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388178AbhATOTV (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Jan 2021 09:19:21 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A2825AB7F;
        Wed, 20 Jan 2021 14:18:35 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 642A01E0802; Wed, 20 Jan 2021 15:18:34 +0100 (CET)
Date:   Wed, 20 Jan 2021 15:18:34 +0100
From:   Jan Kara <jack@suse.cz>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Zhongwei Cai <sunrise_l@sjtu.edu.cn>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Matthew Wilcox <willy@infradead.org>,
        David Laight <David.Laight@aculab.com>,
        Mingkai Dong <mingkaidong@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jan Kara <jack@suse.cz>,
        Steven Whitehouse <swhiteho@redhat.com>,
        Eric Sandeen <esandeen@redhat.com>,
        Dave Chinner <dchinner@redhat.com>,
        Wang Jianchao <jianchao.wan9@gmail.com>,
        Rajesh Tadakamadla <rajesh.tadakamadla@hpe.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>
Subject: Re: Expense of read_iter
Message-ID: <20210120141834.GA24063@quack2.suse.cz>
References: <alpine.LRH.2.02.2101061245100.30542@file01.intranet.prod.int.rdu2.redhat.com>
 <20210107151125.GB5270@casper.infradead.org>
 <17045315-CC1F-4165-B8E3-BA55DD16D46B@gmail.com>
 <2041983017.5681521.1610459100858.JavaMail.zimbra@sjtu.edu.cn>
 <alpine.LRH.2.02.2101131008530.27448@file01.intranet.prod.int.rdu2.redhat.com>
 <1224425872.715547.1610703643424.JavaMail.zimbra@sjtu.edu.cn>
 <20210120044700.GA4626@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210120044700.GA4626@dread.disaster.area>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 20-01-21 15:47:00, Dave Chinner wrote:
> On Fri, Jan 15, 2021 at 05:40:43PM +0800, Zhongwei Cai wrote:
> > On Thu, 14 Jan 2021, Mikulas wrote:
> > For Ext4-dax, the overhead of dax_iomap_rw is significant
> > compared to the overhead of struct iov_iter. Although methods
> > proposed by Mikulas can eliminate the overhead of iov_iter
> > well, they can not be applied in Ext4-dax unless we implement an
> > internal "read" method in Ext4-dax.
> > 
> > For Ext4-dax, there could be two approaches to optimizing:
> > 1) implementing the internal "read" method without the complexity
> > of iterators and dax_iomap_rw;
> 
> Please do not go an re-invent the wheel just for ext4. If there's a
> problem in a shared path - ext2, FUSE and XFS all use dax_iomap_rw()
> as well, so any improvements to that path benefit all DAX users, not
> just ext4.
> 
> > 2) optimizing how dax_iomap_rw works.
> > Since dax_iomap_rw requires ext4_iomap_begin, which further involves
> > the iomap structure and others (e.g., journaling status locks in Ext4),
> > we think implementing the internal "read" method would be easier.
> 
> Maybe it is, but it's also very selfish. The DAX iomap path was
> written to be correct for all users, not inecessarily provide
> optimal performance. There will be lots of things that could be done
> to optimise it, so rather than creating a special snowflake in ext4
> that makes DAX in ext4 much harder to maintain for non-ext4 DAX
> developers, please work to improve the common DAX IO path and so
> provide the same benefit to all the filesystems that use it.

Yeah, I agree. I'm against ext4 private solution for this read problem. And
I'm also against duplicating ->read_iter functionatily in ->read handler.
The maintenance burden of this code duplication is IMHO just too big. We
rather need to improve the generic code so that the fast path is faster.
And every filesystem will benefit because this is not ext4 specific
problem.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
