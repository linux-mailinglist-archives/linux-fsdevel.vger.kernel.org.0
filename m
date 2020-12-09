Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5323F2D395C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Dec 2020 04:56:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726207AbgLIDyZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Dec 2020 22:54:25 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:54918 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725915AbgLIDyZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Dec 2020 22:54:25 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B93pQoY136307;
        Wed, 9 Dec 2020 03:53:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=+FpJI8QdOTW8zOK2N4NA02KTUHNe7JDiNjV6PXLGB7s=;
 b=pHO9RrJze0mEMXBYGqVM0imQOkO61BZ31QD2rVaierR6CzFQveuajwigIvx1qI1GaZsY
 GtFfVyLl1p5+IWmT4T1LB8ggvP9hPRpHvgXLezhVw9vd/uOSeb30wzsqEMbdZrCsKzgy
 c/MC/3Xq7jGT4ccvpvVNo5qCc8SbsYgUHuZ4rheMjqS55SZDWF8hytgGnBdmSL0UjBRN
 BwsFOszh7r8yYnmJTMoEMMACJNZ2MiNt3Lq/DAqJFVCU9AiJXnTn7B+pHpiRuvsrgCga
 sTzUyam2dysv07+xKgy5nPR5SgyIew9I6Tm6L3UKKjhsOORvorBEzCHQ+l/6665QUm+/ Kg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 357yqbx6hq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 09 Dec 2020 03:53:25 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B93igKR193786;
        Wed, 9 Dec 2020 03:53:25 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 358kyty357-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Dec 2020 03:53:25 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0B93rN6P029917;
        Wed, 9 Dec 2020 03:53:23 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 08 Dec 2020 19:53:23 -0800
Date:   Tue, 8 Dec 2020 19:53:20 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Howells <dhowells@redhat.com>, jlayton@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
        linux-xfs@vger.kernel.org, Linux MM <linux-mm@kvack.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v11 3/4] xfs: refactor the usage around
 xfs_trans_context_{set,clear}
Message-ID: <20201209035320.GI1943235@magnolia>
References: <20201208122824.16118-1-laoar.shao@gmail.com>
 <20201208122824.16118-4-laoar.shao@gmail.com>
 <20201208185946.GC1943235@magnolia>
 <CALOAHbB1uKmQ7ns08KW4zH1ikqD0GAY_Y7VySzmTY0=LTEPURA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALOAHbB1uKmQ7ns08KW4zH1ikqD0GAY_Y7VySzmTY0=LTEPURA@mail.gmail.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9829 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 mlxscore=0
 malwarescore=0 suspectscore=0 mlxlogscore=999 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012090025
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9829 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 clxscore=1015 malwarescore=0 bulkscore=0 phishscore=0 adultscore=0
 spamscore=0 priorityscore=1501 mlxscore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012090025
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 09, 2020 at 09:47:38AM +0800, Yafang Shao wrote:
> On Wed, Dec 9, 2020 at 2:59 AM Darrick J. Wong <darrick.wong@oracle.com> wrote:
> >
> > On Tue, Dec 08, 2020 at 08:28:23PM +0800, Yafang Shao wrote:
> > > The xfs_trans context should be active after it is allocated, and
> > > deactive when it is freed.
> > >
> > > So these two helpers are refactored as,
> > > - xfs_trans_context_set()
> > >   Used in xfs_trans_alloc()
> > > - xfs_trans_context_clear()
> > >   Used in xfs_trans_free()
> > >
> > > This patch is based on Darrick's work to fix the issue in xfs/141 in the
> > > earlier version. [1]
> > >
> > > 1. https://lore.kernel.org/linux-xfs/20201104001649.GN7123@magnolia
> > >
> > > Cc: Darrick J. Wong <darrick.wong@oracle.com>
> > > Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
> > > Cc: Christoph Hellwig <hch@lst.de>
> > > Cc: Dave Chinner <david@fromorbit.com>
> > > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > > ---
> > >  fs/xfs/xfs_trans.c | 20 +++++++-------------
> > >  1 file changed, 7 insertions(+), 13 deletions(-)
> > >
> > > diff --git a/fs/xfs/xfs_trans.c b/fs/xfs/xfs_trans.c
> > > index 11d390f0d3f2..fe20398a214e 100644
> > > --- a/fs/xfs/xfs_trans.c
> > > +++ b/fs/xfs/xfs_trans.c
> > > @@ -67,6 +67,9 @@ xfs_trans_free(
> > >       xfs_extent_busy_sort(&tp->t_busy);
> > >       xfs_extent_busy_clear(tp->t_mountp, &tp->t_busy, false);
> > >
> > > +     /* Detach the transaction from this thread. */
> > > +     xfs_trans_context_clear(tp);
> >
> > Don't you need to check if tp is still the current transaction before
> > you clear PF_MEMALLOC_NOFS, now that the NOFS is bound to the lifespan
> > of the transaction itself instead of the reservation?
> >
> 
> The current->journal_info is always the same with tp here in my verification.
> I don't know in which case they are different.

I don't know why you changed it from the previous version.

> It would be better if you could explain in detail.  Anyway I can add
> the check with your comment in the next version.

xfs_trans_alloc is called to allocate a transaction.  We set _NOFS and
save the old flags (which don't contain _NOFS) to this transaction.

thread logs some changes and calls xfs_trans_roll.

xfs_trans_roll calls xfs_trans_dup to duplicate the old transaction.

xfs_trans_dup allocates a new transaction, which sets PF_MEMALLOC_NOFS
and saves the current context flags (in which _NOFS is set) in the new
transaction.

xfs_trans_roll then commits the old transaction

xfs_trans_commit frees the old transaction

xfs_trans_free restores the old context (which didn't have _NOFS) and
now we've dropped NOFS incorrectly

now we move on with the new transaction, but in the wrong NOFS mode.

note that this becomes a lot more obvious once you start fiddling with
current->journal_info in the last patch.

--D

> 
> >
> > > +
> > >       trace_xfs_trans_free(tp, _RET_IP_);
> > >       if (!(tp->t_flags & XFS_TRANS_NO_WRITECOUNT))
> > >               sb_end_intwrite(tp->t_mountp->m_super);
> > > @@ -153,9 +156,6 @@ xfs_trans_reserve(
> > >       int                     error = 0;
> > >       bool                    rsvd = (tp->t_flags & XFS_TRANS_RESERVE) != 0;
> > >
> > > -     /* Mark this thread as being in a transaction */
> > > -     xfs_trans_context_set(tp);
> > > -
> > >       /*
> > >        * Attempt to reserve the needed disk blocks by decrementing
> > >        * the number needed from the number available.  This will
> > > @@ -163,10 +163,9 @@ xfs_trans_reserve(
> > >        */
> > >       if (blocks > 0) {
> > >               error = xfs_mod_fdblocks(mp, -((int64_t)blocks), rsvd);
> > > -             if (error != 0) {
> > > -                     xfs_trans_context_clear(tp);
> > > +             if (error != 0)
> > >                       return -ENOSPC;
> > > -             }
> > > +
> > >               tp->t_blk_res += blocks;
> > >       }
> > >
> > > @@ -241,8 +240,6 @@ xfs_trans_reserve(
> > >               tp->t_blk_res = 0;
> > >       }
> > >
> > > -     xfs_trans_context_clear(tp);
> > > -
> > >       return error;
> > >  }
> > >
> > > @@ -284,6 +281,8 @@ xfs_trans_alloc(
> > >       INIT_LIST_HEAD(&tp->t_dfops);
> > >       tp->t_firstblock = NULLFSBLOCK;
> > >
> > > +     /* Mark this thread as being in a transaction */
> > > +     xfs_trans_context_set(tp);
> > >       error = xfs_trans_reserve(tp, resp, blocks, rtextents);
> > >       if (error) {
> > >               xfs_trans_cancel(tp);
> > > @@ -878,7 +877,6 @@ __xfs_trans_commit(
> > >
> > >       xfs_log_commit_cil(mp, tp, &commit_lsn, regrant);
> > >
> > > -     xfs_trans_context_clear(tp);
> > >       xfs_trans_free(tp);
> > >
> > >       /*
> > > @@ -911,7 +909,6 @@ __xfs_trans_commit(
> > >               tp->t_ticket = NULL;
> > >       }
> > >
> > > -     xfs_trans_context_clear(tp);
> > >       xfs_trans_free_items(tp, !!error);
> > >       xfs_trans_free(tp);
> > >
> > > @@ -971,9 +968,6 @@ xfs_trans_cancel(
> > >               tp->t_ticket = NULL;
> > >       }
> > >
> > > -     /* mark this thread as no longer being in a transaction */
> > > -     xfs_trans_context_clear(tp);
> > > -
> > >       xfs_trans_free_items(tp, dirty);
> > >       xfs_trans_free(tp);
> > >  }
> > > --
> > > 2.18.4
> > >
> 
> 
> 
> -- 
> Thanks
> Yafang
