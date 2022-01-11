Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27E6348A42E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jan 2022 01:08:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345822AbiAKAIO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Jan 2022 19:08:14 -0500
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:58226 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242685AbiAKAIM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Jan 2022 19:08:12 -0500
Received: from dread.disaster.area (pa49-181-243-119.pa.nsw.optusnet.com.au [49.181.243.119])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id CF03E62C003;
        Tue, 11 Jan 2022 11:08:10 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1n74hs-00DnUR-7j; Tue, 11 Jan 2022 11:08:08 +1100
Date:   Tue, 11 Jan 2022 11:08:08 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "bfoster@redhat.com" <bfoster@redhat.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "trondmy@kernel.org" <trondmy@kernel.org>,
        "hch@infradead.org" <hch@infradead.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "willy@infradead.org" <willy@infradead.org>
Subject: Re: [PATCH] iomap: Address soft lockup in iomap_finish_ioend()
Message-ID: <20220111000808.GD945095@dread.disaster.area>
References: <20220101035516.GE945095@dread.disaster.area>
 <fb964769132eb01ed4e8b67d6972d50ee3387e24.camel@hammerspace.com>
 <20220103220310.GG945095@dread.disaster.area>
 <9f51fa6169f4c67d54dd8563b52c540c94c7703a.camel@hammerspace.com>
 <20220104012215.GH945095@dread.disaster.area>
 <0996c40657b5873dda5119344bf74556491e27b9.camel@hammerspace.com>
 <c9d9b7850c6086b123b4add4de7b1992cb62f6ad.camel@hammerspace.com>
 <20220105224829.GO945095@dread.disaster.area>
 <28e975e8235a41c529bccb2bc0e73b4bb2d1e45e.camel@hammerspace.com>
 <20220110233746.GB945095@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220110233746.GB945095@dread.disaster.area>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=e9dl9Yl/ c=1 sm=1 tr=0 ts=61dcca6b
        a=BEa52nrBdFykVEm6RU8P4g==:117 a=BEa52nrBdFykVEm6RU8P4g==:17
        a=kj9zAlcOel0A:10 a=DghFqjY3_ZEA:10 a=7-415B0cAAAA:8
        a=tzrAO7XPkmZgBS5PYtwA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 11, 2022 at 10:37:46AM +1100, Dave Chinner wrote:
> diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
> index c8c15c3c3147..82515d1ad4e0 100644
> --- a/fs/xfs/xfs_aops.c
> +++ b/fs/xfs/xfs_aops.c
> @@ -136,7 +136,20 @@ xfs_end_ioend(
>  	memalloc_nofs_restore(nofs_flag);
>  }
>  
> -/* Finish all pending io completions. */
> +/*
> + * Finish all pending IO completions that require transactional modifications.
> + *
> + * We try to merge physical and logically contiguous ioends before completion to
> + * minimise the number of transactions we need to perform during IO completion.
> + * Both unwritten extent conversion and COW remapping need to iterate and modify
> + * one physical extent at a time, so we gain nothing by merging physically
> + * discontiguous extents here.
> + *
> + * The ioend chain length that we can be processing here is largely unbound in
> + * length and we may have to perform significant amounts of work on each ioend
> + * to complete it. Hence we have to be careful about holding the CPU for too
> + * long in this loop.
> + */
>  void
>  xfs_end_io(
>  	struct work_struct	*work)
> @@ -147,6 +160,7 @@ xfs_end_io(
>  	struct list_head	tmp;
>  	unsigned long		flags;
>  
> +	msleep(5000);
>  	spin_lock_irqsave(&ip->i_ioend_lock, flags);
>  	list_replace_init(&ip->i_ioend_list, &tmp);
>  	spin_unlock_irqrestore(&ip->i_ioend_lock, flags);

You might want to comment that 5s completion delay out before you
run the patch, Trond...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
