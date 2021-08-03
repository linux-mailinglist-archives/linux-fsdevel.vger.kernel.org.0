Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 102423DE895
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Aug 2021 10:40:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234453AbhHCIkk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Aug 2021 04:40:40 -0400
Received: from mail110.syd.optusnet.com.au ([211.29.132.97]:59379 "EHLO
        mail110.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234356AbhHCIkj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Aug 2021 04:40:39 -0400
Received: from dread.disaster.area (pa49-195-182-146.pa.nsw.optusnet.com.au [49.195.182.146])
        by mail110.syd.optusnet.com.au (Postfix) with ESMTPS id DAA83108EFA;
        Tue,  3 Aug 2021 18:40:26 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1mApyK-00DyTQ-Uv; Tue, 03 Aug 2021 18:40:24 +1000
Date:   Tue, 3 Aug 2021 18:40:24 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Gao Xiang <hsiangkao@linux.alibaba.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Eric Biggers <ebiggers@kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        xfs <linux-xfs@vger.kernel.org>
Subject: Re: iomap 5.15 branch construction ...
Message-ID: <20210803084024.GJ2757197@dread.disaster.area>
References: <20210802221114.GG3601466@magnolia>
 <YQj7oYHpz3zqOGCB@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YQj7oYHpz3zqOGCB@infradead.org>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=YKPhNiOx c=1 sm=1 tr=0
        a=QpfB3wCSrn/dqEBSktpwZQ==:117 a=QpfB3wCSrn/dqEBSktpwZQ==:17
        a=kj9zAlcOel0A:10 a=MhDmnRu9jo8A:10 a=7-415B0cAAAA:8
        a=7JT1_2E538Rp00IizEwA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 03, 2021 at 09:17:37AM +0100, Christoph Hellwig wrote:
> I'm on vacation this week, so just a quick note:
> 
> I'd love to see 1. and 2. from your list in a public branch ASAP,
> maybe also 3 and 4 if they get positive reviews so that I can
> rebased the iter stuff ontop of that so that I can repost the iter
> series with that as a baseline.
> 
> I still haven't succeeded getting a working DAX setup, though.

Just set up a VM with a chunk of RAM and then use the memmap=
command line option to use some of that RAM as pmem. I use a VM with 32GB
of RAM (-m 32768) and then use this command line:

-append "console=ttyS0,115200 root=/dev/sda1 scsi_debug.add_host=0 memmap=8G!15G,8G!24G $1"

that gives me two 8GB pmem devices, one at a base address of 15GB
and the other at a base address of 24GB. This is the only way I've
been able to get "pmem" to work reliably with qemu. The persistence
lasts for the qemu process lifetime, so you can reboot the VM and
the devices still contain the data from the previous boot, but they
do not persist across restarting the qemu process.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
