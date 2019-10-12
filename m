Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2034DD4B7B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Oct 2019 02:48:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727891AbfJLAs1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Oct 2019 20:48:27 -0400
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:50934 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726269AbfJLAs0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Oct 2019 20:48:26 -0400
Received: from dread.disaster.area (pa49-181-198-88.pa.nsw.optusnet.com.au [49.181.198.88])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 3608943EA12;
        Sat, 12 Oct 2019 11:48:23 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.2)
        (envelope-from <david@fromorbit.com>)
        id 1iJ5a1-0008Iw-Qv; Sat, 12 Oct 2019 11:48:21 +1100
Date:   Sat, 12 Oct 2019 11:48:21 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH V2 00/26] mm, xfs: non-blocking inode reclaim
Message-ID: <20191012004821.GR16973@dread.disaster.area>
References: <20191009032124.10541-1-david@fromorbit.com>
 <20191011190305.towurweq7gsah4vr@macbook-pro-91.dhcp.thefacebook.com>
 <20191011234842.GQ16973@dread.disaster.area>
 <20191012001919.lknks3k2at5xpxwf@macbook-pro-91.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191012001919.lknks3k2at5xpxwf@macbook-pro-91.dhcp.thefacebook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=FNpr/6gs c=1 sm=1 tr=0
        a=ocld+OpnWJCUTqzFQA3oTA==:117 a=ocld+OpnWJCUTqzFQA3oTA==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=XobE76Q3jBoA:10
        a=7-415B0cAAAA:8 a=lunlTiudoaBRvRPLOwEA:9 a=CjuIK1q_8ugA:10
        a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 11, 2019 at 08:19:21PM -0400, Josef Bacik wrote:
> Ok, I just read the mm patches and made assumptions about what you were trying
> to accomplish.  I suppose I should probably dig my stuff back out.  Thanks,

Fair enough.

The mm bits are basically providing backoffs when shrinkers can't
make progress for whatever reason (e.g. GFP_NOFS context, requires
IO, etc) so that other reclaim scanning can be done while we wait
for other progress (like cleaning inodes) can be made before trying
to reclaim inodes again.

The back-offs are required to prevent priority wind-up and OOM if
reclaim progress is extremely slow. These patches aggregate them
into bound global reclaim delays between page reclaim and slab
shrinking rather than lots of unbound individual delays inside
specific shrinkers that end up slowing down the entire slab
shrinking scan.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
