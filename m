Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 950B115B7A3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Feb 2020 04:18:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729404AbgBMDSM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Feb 2020 22:18:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:43568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729333AbgBMDSM (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Feb 2020 22:18:12 -0500
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 781F020724;
        Thu, 13 Feb 2020 03:18:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581563891;
        bh=g+NNc5bvmGUPsB1+om2/l6UwJ/5p/Et+Ls7zATWGcmg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ne9p5XvgtDz/Zi6mRsN4MU3xSQYDZJfnlhrqoO9g0UYPrGzJf+5dSINYRnHxQyuxQ
         V8coDy+VwPgESISaw/OK/A48iItM/kBlzaouJsosW6+XBgPM2oHIi83INo3LwUpnzM
         5iQ+jnSlOehuizL7zCs/T6waRie6WRznEI2+w0HQ=
Date:   Wed, 12 Feb 2020 19:18:10 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Dave Chinner <david@fromorbit.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Jan Kara <jack@suse.cz>, Michal Hocko <mhocko@kernel.org>,
        lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, Mel Gorman <mgorman@suse.de>
Subject: Re: [Lsf-pc] [LSF/MM TOPIC] Congestion
Message-Id: <20200212191810.0b991dcf08138c4170453d6b@linux-foundation.org>
In-Reply-To: <20200207000853.GD8731@bombadil.infradead.org>
References: <20191231125908.GD6788@bombadil.infradead.org>
        <20200106115514.GG12699@dhcp22.suse.cz>
        <20200106232100.GL23195@dread.disaster.area>
        <20200109110751.GF27035@quack2.suse.cz>
        <20200109230043.GS23195@dread.disaster.area>
        <20200205160551.GI3466@techsingularity.net>
        <20200206231928.GA21953@dread.disaster.area>
        <20200207000853.GD8731@bombadil.infradead.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 6 Feb 2020 16:08:53 -0800 Matthew Wilcox <willy@infradead.org> wrote:

> On Fri, Feb 07, 2020 at 10:19:28AM +1100, Dave Chinner wrote:
> > But detecting an abundance dirty pages/inodes on the LRU doesn't
> > really solve the problem of determining if and/or how long we should
> > wait for IO before we try to free more objects. There is no problem
> > with having lots of dirty pages/inodes on the LRU as long as the IO
> > subsystem keeps up with the rate at which reclaim is asking them to
> > be written back via async mechanisms (bdi writeback, metadata
> > writeback, etc).
> > 
> > The problem comes when we cannot make efficient progress cleaning
> > pages/inodes on the LRU because the IO subsystem is overloaded and
> > cannot clean pages/inodes any faster. At this point, we have to wait
> > for the IO subsystem to make progress and without feedback from the
> > IO subsystem, we have no idea how fast that progress is made. Hence
> > we have no idea how long we need to wait before trying to reclaim
> > again. i.e. the answer can be different depending on hardware
> > behaviour, not just the current instantaneous reclaim and IO state.
> > 
> > That's the fundamental problem we need to solve, and realistically
> > it can only be done with some level of feedback from the IO
> > subsystem.
> 
> That triggered a memory for me.  Jeremy Kerr presented a paper at LCA2006
> on a different model where the device driver pulls dirty things from the VM
> rather than having the VM push dirty things to the device driver.  It was
> prototyped in K42 rather than Linux, but the idea might be useful.
> 
> http://jk.ozlabs.org/projects/k42/
> http://jk.ozlabs.org/projects/k42/device-driven-IO-lca06.pdf

Fun.  Device drivers says "I have spare bandwidth so send me some stuff".

But if device drivers could do that, we wouldn't have broken congestion
in the first place ;)

