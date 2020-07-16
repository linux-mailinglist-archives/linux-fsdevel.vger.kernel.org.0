Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB9C5221AC7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jul 2020 05:21:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728159AbgGPDTl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Jul 2020 23:19:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:45684 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726905AbgGPDTl (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Jul 2020 23:19:41 -0400
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7BE5B2076C;
        Thu, 16 Jul 2020 03:19:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594869580;
        bh=vgPMdz/7sCKkyj9OaQrErsOsGTtsVIrq+sr8sn87GuU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EtE9oJJqUTVTtM4nTcziXAOegeBwz5zdOszxhZLgXYpmLgOq2RPCOIbDz2/1B0yJ3
         rQguRgZjmQmCGqFgM6CNv9bqyDe4SnhFo/PSqFv3bOc0lqMPWvrV/GCp1Yk8me8Lk4
         yHnooUxaiKYqSapJvsfpqkwplyY2oPQ6f8LV2bHc=
Date:   Wed, 15 Jul 2020 20:19:39 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Dave Chinner <david@fromorbit.com>, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [PATCH] fs/direct-io: avoid data race on ->s_dio_done_wq
Message-ID: <20200716031939.GF1167@sol.localdomain>
References: <20200713033330.205104-1-ebiggers@kernel.org>
 <20200715013008.GD2005@dread.disaster.area>
 <20200715023714.GA38091@sol.localdomain>
 <20200715080144.GF2005@dread.disaster.area>
 <20200715161342.GA1167@sol.localdomain>
 <20200716014656.GJ2005@dread.disaster.area>
 <20200716024717.GJ12769@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200716024717.GJ12769@casper.infradead.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 16, 2020 at 03:47:17AM +0100, Matthew Wilcox wrote:
> On Thu, Jul 16, 2020 at 11:46:56AM +1000, Dave Chinner wrote:
> > And why should we compromise performance on hundreds of millions of
> > modern systems to fix an extremely rare race on an extremely rare
> > platform that maybe only a hundred people world-wide might still
> > use?
> 
> I thought that wasn't the argument here.  It was that some future
> compiler might choose to do something absolutely awful that no current
> compiler does, and that rather than disable the stupid "optimisation",
> we'd be glad that we'd already stuffed the source code up so that it
> lay within some tortuous reading of the C spec.

There are actually many reasons to avoid data races; see
https://github.com/google/ktsan/wiki/READ_ONCE-and-WRITE_ONCE

> 
> The memory model is just too complicated.  Look at the recent exchange
> between myself & Dan Williams.  I spent literally _hours_ trying to
> figure out what rules to follow.
> 
> https://lore.kernel.org/linux-mm/CAPcyv4jgjoLqsV+aHGJwGXbCSwbTnWLmog5-rxD2i31vZ2rDNQ@mail.gmail.com/
> https://lore.kernel.org/linux-mm/CAPcyv4j2+7XiJ9BXQ4mj_XN0N+rCyxch5QkuZ6UsOBsOO1+2Vg@mail.gmail.com/
> 
> Neither Dan nor I are exactly "new" to Linux kernel development.  As Dave
> is saying here, having to understand the memory model is too high a bar.
> 
> Hell, I don't know if what we ended up with for v4 is actually correct.
> It lokos good to me, but *shrug*
> 
> https://lore.kernel.org/linux-mm/159009507306.847224.8502634072429766747.stgit@dwillia2-desk3.amr.corp.intel.com/

Yes, it's too complicated.  I'm not sure there's much of a solution, though.

Of course, we also have easy-to-use synchronization primitives like mutex,
spinlock, rw_semaphore, etc.  The problems arise when people think they know
better and try to write something more "optimized".  We need to have a higher
bar for accepting changes where the memory model is a concern at all.

- Eric
