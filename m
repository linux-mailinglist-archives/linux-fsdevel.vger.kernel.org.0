Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C9B32317F3
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Jun 2019 01:29:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbfEaX27 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 31 May 2019 19:28:59 -0400
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:47250 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726538AbfEaX26 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 31 May 2019 19:28:58 -0400
Received: from dread.disaster.area (pa49-180-144-61.pa.nsw.optusnet.com.au [49.180.144.61])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id CE37F43BC9C;
        Sat,  1 Jun 2019 09:28:54 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92)
        (envelope-from <david@fromorbit.com>)
        id 1hWqxA-00015z-AQ; Sat, 01 Jun 2019 09:28:52 +1000
Date:   Sat, 1 Jun 2019 09:28:52 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Chris Mason <clm@fb.com>, Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Ext4 <linux-ext4@vger.kernel.org>,
        Linux Btrfs <linux-btrfs@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: [RFC][PATCH] link.2: AT_ATOMIC_DATA and AT_ATOMIC_METADATA
Message-ID: <20190531232852.GG29573@dread.disaster.area>
References: <20190527172655.9287-1-amir73il@gmail.com>
 <20190528202659.GA12412@mit.edu>
 <CAOQ4uxgo5jmwQbLAKQre9=7pLQw=CwMgDaWPaJxi-5NGnPEVPQ@mail.gmail.com>
 <CAOQ4uxgj94WR82iHE4PDGSD0UDxG5sCtr+Sv+t1sOHHmnXFYzQ@mail.gmail.com>
 <20190531164136.GA3066@mit.edu>
 <20190531224549.GF29573@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190531224549.GF29573@dread.disaster.area>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=P6RKvmIu c=1 sm=1 tr=0 cx=a_idp_d
        a=8RU0RCro9O0HS2ezTvitPg==:117 a=8RU0RCro9O0HS2ezTvitPg==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=dq6fvYVFJ5YA:10
        a=7-415B0cAAAA:8 a=BQGzBlD28bJaGxRButIA:9 a=CjuIK1q_8ugA:10
        a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jun 01, 2019 at 08:45:49AM +1000, Dave Chinner wrote:
> Given that we can already use AIO to provide this sort of ordering,
> and AIO is vastly faster than synchronous IO, I don't see any point
> in adding complex barrier interfaces that can be /easily implemented
> in userspace/ using existing AIO primitives. You should start
> thinking about expanding libaio with stuff like
> "link_after_fdatasync()" and suddenly the whole problem of
> filesystem data vs metadata ordering goes away because the
> application directly controls all ordering without blocking and
> doesn't need to care what the filesystem under it does....

And let me point out that this is also how userspace can do an
efficient atomic rename - rename_after_fdatasync(). i.e. on
completion of the AIO_FSYNC, run the rename. This guarantees that
the application will see either the old file of the complete new
file, and it *doesn't have to wait for the operation to complete*.
Once it is in flight, the file will contain the old data until some
point in the near future when will it contain the new data....

Seriously, sit down and work out all the "atomic" data vs metadata
behaviours you want, and then tell me how many of them cannot be
implemented as "AIO_FSYNC w/ completion callback function" in
userspace. This mechanism /guarantees ordering/ at the application
level, the application does not block waiting for these data
integrity operations to complete, and you don't need any new kernel
side functionality to implement this.

Fundamentally, the assertion that disk cache flushes are not what
causes fsync "to be slow" is incorrect. It's the synchronous
"waiting for IO completion" that makes fsync "slow". AIO_FSYNC
avoids needing to wait for IO completion, allowing the application
to do useful work (like issue more DI ops) while data integrity
operations are in flight. At this point, fsync is no longer a "slow"
operation - it's just another background async data flush operation
like the BDI flusher thread...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
