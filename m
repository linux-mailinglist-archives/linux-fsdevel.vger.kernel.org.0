Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 374DF3526E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jun 2019 00:01:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726341AbfFDWBt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Jun 2019 18:01:49 -0400
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:42664 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726179AbfFDWBt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Jun 2019 18:01:49 -0400
Received: from dread.disaster.area (pa49-180-144-61.pa.nsw.optusnet.com.au [49.180.144.61])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id F3AC843A4E2;
        Wed,  5 Jun 2019 08:01:45 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92)
        (envelope-from <david@fromorbit.com>)
        id 1hYHV0-0002Sg-8E; Wed, 05 Jun 2019 08:01:42 +1000
Date:   Wed, 5 Jun 2019 08:01:42 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Lucas Stach <dev@lynxeye.de>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: understanding xfs vs. ext4 log performance
Message-ID: <20190604220142.GY29573@dread.disaster.area>
References: <7a642f570980609ccff126a78f1546265ba913e2.camel@lynxeye.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7a642f570980609ccff126a78f1546265ba913e2.camel@lynxeye.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=P6RKvmIu c=1 sm=1 tr=0 cx=a_idp_d
        a=8RU0RCro9O0HS2ezTvitPg==:117 a=8RU0RCro9O0HS2ezTvitPg==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=dq6fvYVFJ5YA:10
        a=nt1UNTH2AAAA:8 a=7-415B0cAAAA:8 a=cMg6eYb3LdCH74NCmdMA:9
        a=CjuIK1q_8ugA:10 a=1jnEqRSf4vEA:10 a=7AW3Uk2BEroXwU7YnAE8:22
        a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 04, 2019 at 11:21:15AM +0200, Lucas Stach wrote:
> Hi all,
> 
> this question is more out of curiosity and because I want to take the
> chance to learn something.
> 
> At work we've stumbled over a workload that seems to hit pathological
> performance on XFS. Basically the critical part of the workload is a
> "rm -rf" of a pretty large directory tree, filled with files of mixed
> size ranging from a few KB to a few MB. The filesystem resides on quite
> slow spinning rust disks, directly attached to the host, so no
> controller with a BBU or something like that involved.
> 
> We've tested the workload with both xfs and ext4, and while the numbers
> aren't completely accurate due to other factors playing into the
> runtime, performance difference between XFS and ext4 seems to be an
> order of magnitude. (Ballpark runtime XFS is 30 mins, while ext4
> handles the remove in ~3 mins).

Without knowing exactly what filesystem configurations you are
testing on, the performance numbers are meaningless:

http://xfs.org/index.php/XFS_FAQ#Q:_What_information_should_I_include_when_reporting_a_problem.3F

> The XFS performance seems to be completly dominated by log buffer
> writes, which happen with both REQ_PREFLUSH and REQ_FUA set. It's
> pretty obvious why this kills performance on slow spinning rust.

In general, you should see almost no log traffic on a rm -rf
workload as the eventual result is that all the inodes and metadata
are marked stale and they don't even get written to the log.

If you are seeing lots of log writes, it indicates to me that you
are testing on very small filesystems and/or filesystems with tiny
logs, resulting in frequent tail pushing to make space in the log
for transaction reservations....

> Now the thing I wonder about is why ext4 seems to get a away without
> those costly flags for its log writes. At least blktrace shows almost
> zero PREFLUSH or FUA requests. Is there some fundamental difference in
> how ext4 handles its logging to avoid the need for this ordering and
> forced access, or is it ext just living more dangerously with regard to
> reordered writes?

If ext4 is not doing cache flushes and/or FUA for it's log writes
then it's broken w.r.t. data integrity. I'm pretty sure that's not
the case. Fundamentally, ext4 has the same journal write ordering
requirements as XFS, it's probably just that for the filesystem
sizes you are testing the ext4 log is larger and fitting the working
set of operations in it without running out of space and having to
flush frequently....

> Does XFS really require such a strong ordering on the log buffer
> writes? I don't understand enough of the XFS transaction code and
> wonder if it would be possible to do the strongly ordered writes only
> on transaction commit.

We don't write anything on transaction commit. We aggregate
committed transactions in memory and then checkpoint the journal
when a flush is required. It's all spelled out in detail in
Documentation/filesystems/xfs-delayed-logging-design.txt in the
kernel tree. It's a similar checkpointing architecture to what ext4
uses, with similar performance in most cases.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
