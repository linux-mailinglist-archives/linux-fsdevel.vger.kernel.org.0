Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 817AA13101E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jan 2020 11:15:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726373AbgAFKPY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Jan 2020 05:15:24 -0500
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:38217 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726155AbgAFKPY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Jan 2020 05:15:24 -0500
Received: from dread.disaster.area (pa49-180-68-255.pa.nsw.optusnet.com.au [49.180.68.255])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id E54697E8337;
        Mon,  6 Jan 2020 21:15:20 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1ioPPq-0001lH-KH; Mon, 06 Jan 2020 21:15:18 +1100
Date:   Mon, 6 Jan 2020 21:15:18 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Sitsofe Wheeler <sitsofe@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, drh@sqlite.org
Subject: Re: Questions about filesystems from SQLite author presentation
Message-ID: <20200106101518.GI23195@dread.disaster.area>
References: <CALjAwxi3ZpRZLS9QaGfAqwAVST0Biyj_p-b22f=iq_ns4ZQyiA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALjAwxi3ZpRZLS9QaGfAqwAVST0Biyj_p-b22f=iq_ns4ZQyiA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=X6os11be c=1 sm=1 tr=0
        a=sbdTpStuSq8iNQE8viVliQ==:117 a=sbdTpStuSq8iNQE8viVliQ==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=Jdjhy38mL1oA:10
        a=jJrOw3FHAAAA:8 a=mLKua8RHAAAA:8 a=vnREMb7VAAAA:8 a=7-415B0cAAAA:8
        a=wD3FcUrPhhqBU1ysDdUA:9 a=CjuIK1q_8ugA:10 a=9bePgjUHLSYA:10
        a=ihO_LYgJu9wA:10 a=-FEs8UIgK8oA:10 a=NWVoK91CQyQA:10
        a=lsIkP6lG2H4f0j7eDx0G:22 a=ewTM_9iNE6a0vsrYD_ou:22
        a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 06, 2020 at 07:24:53AM +0000, Sitsofe Wheeler wrote:
> At Linux Plumbers 2019 Dr Richard Hipp presented a talk about SQLite
> (https://youtu.be/-oP2BOsMpdo?t=5525 ). One of the slides was titled
> "Things to discuss"
> (https://sqlite.org/lpc2019/doc/trunk/slides/sqlite-intro.html/#6 )
> and had a few questions:
> 
> 1. Reliable ways to discover detailed filesystem properties
> 2. fbarrier()
> 3. Notify the OS about unused regions in the database file
> 
> For 1. I think Jan Kara said that supporting it was undesirable for
> details like just how much additional fsync were needed due to
> competing constraints (https://youtu.be/-oP2BOsMpdo?t=6063 ). Someone
> mentioned there was a
> patch for fsinfo to discover if you were on a network filesystem
> (https://www.youtube.com/watch?v=-oP2BOsMpdo&feature=youtu.be&t=5525
> )...
> For 2. there was a talk by MySQL dev Sergei Golubchik (
> https://youtu.be/-oP2BOsMpdo?t=1219 ) talking about how barriers had
> been taken out and was there a replacement. In
> https://youtu.be/-oP2BOsMpdo?t=1731 Chris Mason(?) seems to suggest
> that the desired effect could be achieved with io_uring chaining.

Even though it wasn't explicitly mentioned, I'm pretty sure that
those "write barriers" for ordering groups of writes against other
groups of writes are intended to be used for data integrity
purposes.

The problem is that data integrity writes also require any
uncommitted filesytsem metadata to be written in the correct order
to disk along with the data. i.e.  you can write to the log file,
but if the transactions during that write that allocate space and/or
convert it to written space have not been committed to the journal
then the data is not on stable storage and so data completion
ordering cannot be relied on for integrity related operations.

This is why write ordering always comes back to "you need to use
fdatasync(), O_DSYNC or RWF_DSYNC" - it is the only way to guarantee
the integrity of a initial data write(s) right down to the hardware
before starting the new dependent write(s).

Hence AIO_FSYNC and now chained operations in io_uring to allow
fsync to be issues asynchronously and be used as a "write barrier"
between groups of order dependent IOs...

> For 3. it sounded like Jan Kara was saying there wasn't anything at
> the moment (hypothetically you could introduce a call that marked the
> extents as "unwritten" but it doesn't sound like you can do that

You can do that with fallocate() - FALLOC_FL_ZERO_RANGE will mark
the unused range as unwritten in XFS, or you can just punch a hole
to free the unused space with FALLOC_FL_PUNCH_HOLE...

> today) and even if you wanted to use something like TRIM it wouldn't
> be worth it unless you were trimming a large (gigabytes) amount of
> data (https://youtu.be/-oP2BOsMpdo?t=6330 ).

Punch the space out, then run a periodic background fstrim so the
filesystem can issue efficient TRIM commands over free space...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
