Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 394AC17D6F8
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Mar 2020 00:13:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726508AbgCHXNA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 Mar 2020 19:13:00 -0400
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:46679 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726354AbgCHXNA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 Mar 2020 19:13:00 -0400
Received: from dread.disaster.area (pa49-195-202-68.pa.nsw.optusnet.com.au [49.195.202.68])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 7F5A43A1EC1;
        Mon,  9 Mar 2020 10:12:54 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1jB56L-0004tJ-SX; Mon, 09 Mar 2020 10:12:53 +1100
Date:   Mon, 9 Mar 2020 10:12:53 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] fs/direct-io.c: avoid workqueue allocation race
Message-ID: <20200308231253.GN10776@dread.disaster.area>
References: <CACT4Y+Zt+fjBwJk-TcsccohBgxRNs37Hb4m6ZkZGy7u5P2+aaA@mail.gmail.com>
 <20200308055221.1088089-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200308055221.1088089-1-ebiggers@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=X6os11be c=1 sm=1 tr=0
        a=mqTaRPt+QsUAtUurwE173Q==:117 a=mqTaRPt+QsUAtUurwE173Q==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=SS2py6AdgQ4A:10
        a=1XWaLZrsAAAA:8 a=7-415B0cAAAA:8 a=sjk0pT0bszA0zqNz9kcA:9
        a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Mar 07, 2020 at 09:52:21PM -0800, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> When a thread loses the workqueue allocation race in
> sb_init_dio_done_wq(), lockdep reports that the call to
> destroy_workqueue() can deadlock waiting for work to complete.  This is
> a false positive since the workqueue is empty.  But we shouldn't simply
> skip the lockdep check for empty workqueues for everyone.

Why not? If the wq is empty, it can't deadlock, so this is a problem
with the workqueue lockdep annotations, not a problem with code that
is destroying an empty workqueue.

> Just avoid this issue by using a mutex to serialize the workqueue
> allocation.  We still keep the preliminary check for ->s_dio_done_wq, so
> this doesn't affect direct I/O performance.
> 
> Also fix the preliminary check for ->s_dio_done_wq to use READ_ONCE(),
> since it's a data race.  (That part wasn't actually found by syzbot yet,
> but it could be detected by KCSAN in the future.)
> 
> Note: the lockdep false positive could alternatively be fixed by
> introducing a new function like "destroy_unused_workqueue()" to the
> workqueue API as previously suggested.  But I think it makes sense to
> avoid the double allocation anyway.

Fix the infrastructure, don't work around it be placing constraints
on how the callers can use the infrastructure to work around
problems internal to the infrastructure.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
