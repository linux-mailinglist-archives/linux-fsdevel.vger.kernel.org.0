Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7B352201F7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jul 2020 03:47:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727961AbgGOBrk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Jul 2020 21:47:40 -0400
Received: from mail107.syd.optusnet.com.au ([211.29.132.53]:49166 "EHLO
        mail107.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726356AbgGOBrk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Jul 2020 21:47:40 -0400
Received: from dread.disaster.area (pa49-180-53-24.pa.nsw.optusnet.com.au [49.180.53.24])
        by mail107.syd.optusnet.com.au (Postfix) with ESMTPS id CDEB3D5A5FF;
        Wed, 15 Jul 2020 11:47:35 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1jvWWE-0001ob-2Y; Wed, 15 Jul 2020 11:47:34 +1000
Date:   Wed, 15 Jul 2020 11:47:34 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.de>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <jth@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        cluster-devel@redhat.com, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org
Subject: Re: RFC: iomap write invalidation
Message-ID: <20200715014734.GE2005@dread.disaster.area>
References: <20200713074633.875946-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200713074633.875946-1-hch@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=X6os11be c=1 sm=1 tr=0
        a=moVtWZxmCkf3aAMJKIb/8g==:117 a=moVtWZxmCkf3aAMJKIb/8g==:17
        a=kj9zAlcOel0A:10 a=_RQrkK6FrEwA:10 a=20KFwNOVAAAA:8 a=7-415B0cAAAA:8
        a=GT6RCiLZAcxHUuuf7VQA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 13, 2020 at 09:46:31AM +0200, Christoph Hellwig wrote:
> Hi all,
> 
> this series has two parts:  the first one picks up Dave's patch to avoid
> invalidation entierly for reads, picked up deep down from the btrfs iomap
> thread.  The second one falls back to buffered writes if invalidation fails
> instead of leaving a stale cache around.  Let me know what you think about
> this approch.

Either we maintain application level concurrency for direct IOs and
ignore the stale data in the page cache, or we kill application IO
concurrency and keep the page cache coherent.

It's a lose-lose choice and I'm on the fence as to which is the
lesser of two evils.

The main factor is whether the buffered IO fallback can be
diagnosed. There's a new tracepoint for that case, so at least we
will be able to tell if the fallback co-incides with application
performance cratering. Hopefully this will only be a rare event.

So, to hoist myself on my own petard: correctness first, performance
second.

Acked-by: Dave Chinner <dchinner@redhat.com>

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
