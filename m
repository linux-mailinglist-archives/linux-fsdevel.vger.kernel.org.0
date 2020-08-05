Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F051823C307
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Aug 2020 03:28:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726282AbgHEB2S (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Aug 2020 21:28:18 -0400
Received: from mail109.syd.optusnet.com.au ([211.29.132.80]:41195 "EHLO
        mail109.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725863AbgHEB2Q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Aug 2020 21:28:16 -0400
Received: from dread.disaster.area (pa49-180-53-24.pa.nsw.optusnet.com.au [49.180.53.24])
        by mail109.syd.optusnet.com.au (Postfix) with ESMTPS id AFC0FD7BA6F;
        Wed,  5 Aug 2020 11:28:11 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1k38Dx-00017a-Uq; Wed, 05 Aug 2020 11:28:09 +1000
Date:   Wed, 5 Aug 2020 11:28:09 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Yafang Shao <laoar.shao@gmail.com>, hch@infradead.org,
        darrick.wong@oracle.com, mhocko@kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, Yafang Shao <shaoyafang@didiglobal.com>
Subject: Re: [PATCH v4 1/2] xfs: avoid double restore PF_MEMALLOC_NOFS if
 transaction reservation fails
Message-ID: <20200805012809.GF2114@dread.disaster.area>
References: <20200801154632.866356-1-laoar.shao@gmail.com>
 <20200801154632.866356-2-laoar.shao@gmail.com>
 <20200804232005.GD2114@dread.disaster.area>
 <20200804235038.GL23808@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200804235038.GL23808@casper.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=QIgWuTDL c=1 sm=1 tr=0
        a=moVtWZxmCkf3aAMJKIb/8g==:117 a=moVtWZxmCkf3aAMJKIb/8g==:17
        a=kj9zAlcOel0A:10 a=y4yBn9ojGxQA:10 a=7-415B0cAAAA:8
        a=W0NPVQ3eBDKKx8uhsfQA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 05, 2020 at 12:50:38AM +0100, Matthew Wilcox wrote:
> On Wed, Aug 05, 2020 at 09:20:05AM +1000, Dave Chinner wrote:
> > Also, please convert these to memalloc_nofs_save()/restore() calls
> > as that is the way we are supposed to mark these regions now.
> 
> I have a patch for that!

Did you compile test it? :)

> ---
>  fs/xfs/kmem.c      |  2 +-
>  fs/xfs/xfs_aops.c  |  4 ++--
>  fs/xfs/xfs_buf.c   |  2 +-
>  fs/xfs/xfs_linux.h |  6 ------
>  fs/xfs/xfs_trans.c | 14 +++++++-------
>  fs/xfs/xfs_trans.h |  2 +-
>  6 files changed, 12 insertions(+), 18 deletions(-)

.....

> diff --git a/fs/xfs/xfs_linux.h b/fs/xfs/xfs_linux.h
> index 9f70d2f68e05..e1daf242a53b 100644
> --- a/fs/xfs/xfs_linux.h
> +++ b/fs/xfs/xfs_linux.h
> @@ -104,12 +104,6 @@ typedef __u32			xfs_nlink_t;
>  #define current_cpu()		(raw_smp_processor_id())
>  #define current_pid()		(current->pid)
>  #define current_test_flags(f)	(current->flags & (f))
> -#define current_set_flags_nested(sp, f)		\
> -		(*(sp) = current->flags, current->flags |= (f))
> -#define current_clear_flags_nested(sp, f)	\
> -		(*(sp) = current->flags, current->flags &= ~(f))
> -#define current_restore_flags_nested(sp, f)	\
> -		(current->flags = ((current->flags & ~(f)) | (*(sp) & (f))))

current_set_flags_nested() and current_restore_flags_nested()
are used in xfs_btree_split_worker() in fs/xfs/libxfs/xfs_btree.c
and that's not a file you modified in this patch...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
