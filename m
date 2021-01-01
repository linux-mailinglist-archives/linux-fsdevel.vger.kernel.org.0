Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 717BE2E85C8
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Jan 2021 22:57:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727396AbhAAVyk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 Jan 2021 16:54:40 -0500
Received: from mail109.syd.optusnet.com.au ([211.29.132.80]:33908 "EHLO
        mail109.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727173AbhAAVyj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 Jan 2021 16:54:39 -0500
Received: from dread.disaster.area (pa49-179-167-107.pa.nsw.optusnet.com.au [49.179.167.107])
        by mail109.syd.optusnet.com.au (Postfix) with ESMTPS id 0D56D8BF5;
        Sat,  2 Jan 2021 08:53:54 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1kvSMr-00244f-HB; Sat, 02 Jan 2021 08:53:53 +1100
Date:   Sat, 2 Jan 2021 08:53:53 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     kernel test robot <oliver.sang@intel.com>,
        0day robot <lkp@intel.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@lst.de>,
        Michal Hocko <mhocko@kernel.org>,
        David Howells <dhowells@redhat.com>,
        Jeff Layton <jlayton@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        Christoph Hellwig <hch@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
        linux-xfs@vger.kernel.org, Linux MM <linux-mm@kvack.org>
Subject: Re: [xfs] db962cd266: Assertion_failed
Message-ID: <20210101215353.GB331610@dread.disaster.area>
References: <20201222012131.47020-5-laoar.shao@gmail.com>
 <20201231030158.GB379@xsang-OptiPlex-9020>
 <CALOAHbD+mLMJSizToKPsx0iUd5Z71sJBOyMaV2enVvUHfHwLzg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALOAHbD+mLMJSizToKPsx0iUd5Z71sJBOyMaV2enVvUHfHwLzg@mail.gmail.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=Ubgvt5aN c=1 sm=1 tr=0 cx=a_idp_d
        a=+wqVUQIkAh0lLYI+QRsciw==:117 a=+wqVUQIkAh0lLYI+QRsciw==:17
        a=kj9zAlcOel0A:10 a=EmqxpYm9HcoA:10 a=QyXUC8HyAAAA:8 a=7-415B0cAAAA:8
        a=XA52iYJiZECpFeylV-IA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 01, 2021 at 05:10:49PM +0800, Yafang Shao wrote:
> On Thu, Dec 31, 2020 at 10:46 AM kernel test robot
> <oliver.sang@intel.com> wrote:
.....
> > [  552.905799] XFS: Assertion failed: !current->journal_info, file: fs/xfs/xfs_trans.h, line: 280
> > [  553.104459]  xfs_trans_reserve+0x225/0x320 [xfs]
> > [  553.110556]  xfs_trans_roll+0x6e/0xe0 [xfs]
> > [  553.116134]  xfs_defer_trans_roll+0x104/0x2a0 [xfs]
> > [  553.122489]  ? xfs_extent_free_create_intent+0x62/0xc0 [xfs]
> > [  553.129780]  xfs_defer_finish_noroll+0xb8/0x620 [xfs]
> > [  553.136299]  xfs_defer_finish+0x11/0xa0 [xfs]
> > [  553.142017]  xfs_itruncate_extents_flags+0x141/0x440 [xfs]
> > [  553.149053]  xfs_setattr_size+0x3da/0x480 [xfs]
> > [  553.154939]  ? setattr_prepare+0x6a/0x1e0
> > [  553.160250]  xfs_vn_setattr+0x70/0x120 [xfs]
> > [  553.165833]  notify_change+0x364/0x500
> > [  553.170820]  ? do_truncate+0x76/0xe0
> > [  553.175673]  do_truncate+0x76/0xe0
> > [  553.180184]  path_openat+0xe6c/0x10a0
> > [  553.184981]  do_filp_open+0x91/0x100
> > [  553.189707]  ? __check_object_size+0x136/0x160
> > [  553.195493]  do_sys_openat2+0x20d/0x2e0
> > [  553.200481]  do_sys_open+0x44/0x80
> > [  553.204926]  do_syscall_64+0x33/0x40
> > [  553.209588]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> 
> Thanks for the report.
> 
> At a first glance, it seems we should make a similar change as we did
> in xfs_trans_context_clear().
> 
> static inline void
> xfs_trans_context_set(struct xfs_trans *tp)
> {
>     /*
>      * We have already handed over the context via xfs_trans_context_swap().
>      */
>     if (current->journal_info)
>         return;
>     current->journal_info = tp;
>     tp->t_pflags = memalloc_nofs_save();
> }

Ah, no.

Remember how I said "split out the wrapping of transaction
context setup in xfs_trans_reserve() from
the lifting of the context setting into xfs_trans_alloc()"?

Well, you did the former and dropped the latter out of the patch
set.

Now when a transaction rolls after xfs_trans_context_swap(), it
calls xfs_trans_reserve() and tries to do transaction context setup
work inside a transaction context that already exists.  IOWs, you
need to put the patch that lifts of the context setting up into
xfs_trans_alloc() back into the patchset before adding the
current->journal functionality patch.

Also, you need to test XFS code with CONFIG_XFS_DEBUG=y so that
asserts are actually built into the code and exercised, because this
ASSERT should have fired on the first rolling transaction that the
kernel executes...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
