Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F14B8BEB3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2019 18:35:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727697AbfHMQfx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Aug 2019 12:35:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37057 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727150AbfHMQfx (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Aug 2019 12:35:53 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8009E309BDA2;
        Tue, 13 Aug 2019 16:35:53 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D843C1000337;
        Tue, 13 Aug 2019 16:35:50 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id x7DGZog1008729;
        Tue, 13 Aug 2019 12:35:50 -0400
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id x7DGZoLu008726;
        Tue, 13 Aug 2019 12:35:50 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Tue, 13 Aug 2019 12:35:49 -0400 (EDT)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     Dave Chinner <david@fromorbit.com>
cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Mike Snitzer <msnitzer@redhat.com>, junxiao.bi@oracle.com,
        dm-devel@redhat.com, Alasdair Kergon <agk@redhat.com>,
        honglei.wang@oracle.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH] direct-io: use GFP_NOIO to avoid deadlock
In-Reply-To: <20190809215733.GZ7777@dread.disaster.area>
Message-ID: <alpine.LRH.2.02.1908131231010.6852@file01.intranet.prod.int.rdu2.redhat.com>
References: <alpine.LRH.2.02.1908080540240.15519@file01.intranet.prod.int.rdu2.redhat.com> <20190809013403.GY7777@dread.disaster.area> <alpine.LRH.2.02.1908090725290.31061@file01.intranet.prod.int.rdu2.redhat.com>
 <20190809215733.GZ7777@dread.disaster.area>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Tue, 13 Aug 2019 16:35:53 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On Sat, 10 Aug 2019, Dave Chinner wrote:

> No, you misunderstand. I'm talking about blocking kswapd being
> wrong.  i.e. Blocking kswapd in shrinkers causes problems
> because th ememory reclaim code does not expect kswapd to be
> arbitrarily delayed by waiting on IO. We've had this problem with
> the XFS inode cache shrinker for years, and there are many reports
> of extremely long reclaim latencies for both direct and kswapd
> reclaim that result from kswapd not making progress while waiting
> in shrinkers for IO to complete.
> 
> The work I'm currently doing to fix this XFS problem can be found
> here:
> 
> https://lore.kernel.org/linux-fsdevel/20190801021752.4986-1-david@fromorbit.com/
> 
> 
> i.e. the point I'm making is that waiting for IO in kswapd reclaim
> context is considered harmful - kswapd context shrinker reclaim
> should be as non-blocking as possible, and any back-off to wait for
> IO to complete should be done by the high level reclaim core once
> it's completed an entire reclaim scan cycle of everything....
> 
> What follows from that, and is pertinent for in this situation, is
> that if you don't block kswapd, then other reclaim contexts are not
> going to get stuck waiting for it regardless of the reclaim context
> they use.
> 
> Cheers,
> 
> Dave.

So, what do you think the dm-bufio shrinker should do?

Currently it tries to free buffers on the clean list and if there are not 
enough buffers on the clean list, it goes into the dirty list - it writes 
the buffers back and then frees them.

What should it do? Should it just start writeback of the dirty list 
without waiting for it? What should it do if all the buffers are under 
writeback?

Mikulas
