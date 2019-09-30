Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E662C1D74
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Sep 2019 10:54:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730140AbfI3IyN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Sep 2019 04:54:13 -0400
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:48079 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726008AbfI3IyM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Sep 2019 04:54:12 -0400
Received: from dread.disaster.area (pa49-181-226-196.pa.nsw.optusnet.com.au [49.181.226.196])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id A189536291A;
        Mon, 30 Sep 2019 18:54:06 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.2)
        (envelope-from <david@fromorbit.com>)
        id 1iErRW-0007JB-D1; Mon, 30 Sep 2019 18:54:06 +1000
Date:   Mon, 30 Sep 2019 18:54:06 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Florian Weimer <fw@deneb.enyo.de>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: xfs_inode not reclaimed/memory leak on 5.2.16
Message-ID: <20190930085406.GP16973@dread.disaster.area>
References: <87pnji8cpw.fsf@mid.deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87pnji8cpw.fsf@mid.deneb.enyo.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=FNpr/6gs c=1 sm=1 tr=0
        a=dRuLqZ1tmBNts2YiI0zFQg==:117 a=dRuLqZ1tmBNts2YiI0zFQg==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=IkcTkHD0fZMA:10 a=J70Eh1EUuV4A:10
        a=7-415B0cAAAA:8 a=p-vD6gt0l82YhtYKeuUA:9 a=QEXdDO2ut3YA:10
        a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 30, 2019 at 09:28:27AM +0200, Florian Weimer wrote:
> Simply running “du -hc” on a large directory tree causes du to be
> killed because of kernel paging request failure in the XFS code.

dmesg output? if the system was still running, then you might be
able to pull the trace from syslog. But we can't do much without
knowing what the actual failure was....

FWIW, one of my regular test workloads is iterating a directory tree
with 50 million inodes in several different ways to stress reclaim
algorithms in ways that users do. I haven't seen issues with that
test for a while, so it's not an obvious problem whatever you came
across.

> I ran slabtop, and it showed tons of xfs_inode objects.

Sure, because your workload is iterating inodes.

> The system was rather unhappy after that, so I wasn't able to capture
> much more information.
> 
> Is this a known issue on Linux 5.2?

Not that I know of.

> I don't see it with kernel
> 5.0.20.  Those are plain upstream kernels built for x86-64, with no
> unusual config options (that I know of).

We've had quite a few memory reclaim regressions in recent times
that have displayed similar symptoms - XFS is often just the
messenger because the inode cache is generating the memory pressure.
e.g. the shrinker infrastructure was broken in 4.16 and then broken
differently in 4.17 to try to fix it, and we didn't hear about them
until about 4.18/4.19 when users started to trip over them. I fixed
those problems in 5.0, but there's every chance that there have been
new regressions since then.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
