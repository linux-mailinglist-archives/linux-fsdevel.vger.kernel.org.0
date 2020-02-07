Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99007154F95
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2020 01:08:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726543AbgBGAI4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Feb 2020 19:08:56 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:48416 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726502AbgBGAI4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Feb 2020 19:08:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=pN0iI2R6rQdmuuVfN/ywYGLta/+ZSKXcgSvDvEZwm1M=; b=kd6ZoNv7jTlQE1C/YZx3xGUfRc
        AWMtKofCtt9Emz1cr9AUHLgv9drPc/yXf/eSDD8FUNBCGsdEQkIYeAJPjCG98+i8xiJ6eF4ZPhtaX
        Pvbfx4gp2+lreUyGZhJIKP7uFfxaRZ1YfGSiYiWUWCUzMqD0+g9Zz32od65nlIio3Brnr3qjzSz1L
        y7pgjrZvl/SQUmcNM7UHq7zcTWsaruRoYht/2muWj6NVmTNOr98gL6PO+8CpA8XZdpehzpcALsW0u
        0IKiSmVmhua2ewmV055wJiHFVESufRRbnfadamMvUqtcCjM+LcZxZQ2aF9Y7qgToAv+yx6KrDYtWy
        WvcVdf9A==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1izrCX-0007WL-L8; Fri, 07 Feb 2020 00:08:53 +0000
Date:   Thu, 6 Feb 2020 16:08:53 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Mel Gorman <mgorman@techsingularity.net>, Jan Kara <jack@suse.cz>,
        Michal Hocko <mhocko@kernel.org>,
        lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, Mel Gorman <mgorman@suse.de>
Subject: Re: [Lsf-pc] [LSF/MM TOPIC] Congestion
Message-ID: <20200207000853.GD8731@bombadil.infradead.org>
References: <20191231125908.GD6788@bombadil.infradead.org>
 <20200106115514.GG12699@dhcp22.suse.cz>
 <20200106232100.GL23195@dread.disaster.area>
 <20200109110751.GF27035@quack2.suse.cz>
 <20200109230043.GS23195@dread.disaster.area>
 <20200205160551.GI3466@techsingularity.net>
 <20200206231928.GA21953@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200206231928.GA21953@dread.disaster.area>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 07, 2020 at 10:19:28AM +1100, Dave Chinner wrote:
> But detecting an abundance dirty pages/inodes on the LRU doesn't
> really solve the problem of determining if and/or how long we should
> wait for IO before we try to free more objects. There is no problem
> with having lots of dirty pages/inodes on the LRU as long as the IO
> subsystem keeps up with the rate at which reclaim is asking them to
> be written back via async mechanisms (bdi writeback, metadata
> writeback, etc).
> 
> The problem comes when we cannot make efficient progress cleaning
> pages/inodes on the LRU because the IO subsystem is overloaded and
> cannot clean pages/inodes any faster. At this point, we have to wait
> for the IO subsystem to make progress and without feedback from the
> IO subsystem, we have no idea how fast that progress is made. Hence
> we have no idea how long we need to wait before trying to reclaim
> again. i.e. the answer can be different depending on hardware
> behaviour, not just the current instantaneous reclaim and IO state.
> 
> That's the fundamental problem we need to solve, and realistically
> it can only be done with some level of feedback from the IO
> subsystem.

That triggered a memory for me.  Jeremy Kerr presented a paper at LCA2006
on a different model where the device driver pulls dirty things from the VM
rather than having the VM push dirty things to the device driver.  It was
prototyped in K42 rather than Linux, but the idea might be useful.

http://jk.ozlabs.org/projects/k42/
http://jk.ozlabs.org/projects/k42/device-driven-IO-lca06.pdf

