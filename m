Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB4E180039
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Aug 2019 20:34:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405518AbfHBSeW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Aug 2019 14:34:22 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:58270 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405370AbfHBSeW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Aug 2019 14:34:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=2kEy2KClG3alDj03YfM34b+mCKk6wTiisUQufFSVdlI=; b=fGJG11C2pbKbbrqF3XBVAwW6q
        KxNlRGiE/D5EhURS1DioBlHhyjyk1M8FPn06HpEbQdOWUPT4Gs+mlHU0Af2k16yZRuf/cMIPY3n0r
        XK41cehqZldoz+EzicIdSIEaXJr//184sJwD7ES4euh7HNw15jUF+7w3gtjI253p7Y7QWYu858Vq3
        0dOzlAycnebIJB/vzWbG0pcCoMkKcNdbTEhMkE6iydjxtmLRsaRg4qDyYqwm3U0lBzR9rlFGUAH10
        YjzaL2L0nLNA/txU2Io+Jd1Wosp7Wa83n0s9XAak00CoTHlzAuj6+p99MMPhWN4Mh18utGNQ/A0We
        tqylaKRLw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1htcNg-0006S8-2m; Fri, 02 Aug 2019 18:34:20 +0000
Date:   Fri, 2 Aug 2019 11:34:19 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Chris Mason <clm@fb.com>
Cc:     Dave Chinner <david@fromorbit.com>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 09/24] xfs: don't allow log IO to be throttled
Message-ID: <20190802183419.GC5597@bombadil.infradead.org>
References: <20190801021752.4986-1-david@fromorbit.com>
 <20190801021752.4986-10-david@fromorbit.com>
 <F1E7CC65-D2CB-4078-9AA3-9D172ECDE17B@fb.com>
 <20190801235849.GO7777@dread.disaster.area>
 <7093F5C3-53D2-4C49-9C0D-64B20C565D18@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7093F5C3-53D2-4C49-9C0D-64B20C565D18@fb.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 02, 2019 at 02:11:53PM +0000, Chris Mason wrote:
> Yes and no.  At some point important FS threads have the potential to 
> wait on every single REQ_META IO on the box, so every single REQ_META IO 
> has the potential to create priority inversions.

[...]

> Tejun reminded me that in a lot of ways, swap is user IO and it's 
> actually fine to have it prioritized at the same level as user IO.  We 
> don't want to let a low prio app thrash the drive swapping things in and 
> out all the time, and it's actually fine to make them wait as long as 
> other higher priority processes aren't waiting for the memory.  This 
> depends on the cgroup config, so wrt your current patches it probably 
> sounds crazy, but we have a lot of data around this from the fleet.

swap is only user IO if we're doing the swapping in response to an
allocation done on behalf of a user thread.  If one of the above-mentioned
important FS threads does a memory allocation which causes swapping,
that priority needs to be inherited by the IO.
