Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CFBF2DDBC7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Dec 2020 00:08:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732335AbgLQXHj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Dec 2020 18:07:39 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:49340 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730665AbgLQXHj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Dec 2020 18:07:39 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BHMxmD2167996;
        Thu, 17 Dec 2020 23:06:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=yHRG2cIyTDdXJWqBhRPKMVR8pBdq09T6/OxbIHavaE0=;
 b=VExB0Z5AgzXK+6Hw44QNINhy7zvaKjc1hANZCVHck6sJzwtgWoupyyMIgHkBXnjfTBlQ
 LcWUPxwME7VHY0PlB8KxbTJu8WAAHSdDTBRcTELK5zAZR8gR+VAbIutdls31ix/Ht9b+
 GMFqJRPkiSD0jbJ0fDt1fiGAW2wK6L3dZg0PV5pWlu1t0Re5pYJf+K82sXPkvmAhmHcO
 AeYMQxjFQf0SlUtsuSM79EH98jEJUBd6614cR7r6X+LmD6CSZzOZcoBH6h1uY/VpjDcU
 H3mEoDrEghh9kqGxhKSEAlMuoRK0mckVIfHAevVTQ2jDESbeN90FNLFiWCgfFuDCApTR KA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 35cntmfwfg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 17 Dec 2020 23:06:33 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BHN1JBp144449;
        Thu, 17 Dec 2020 23:06:33 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 35d7erjp92-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Dec 2020 23:06:33 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0BHN6TUd022834;
        Thu, 17 Dec 2020 23:06:29 GMT
Received: from localhost (/10.159.157.202)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 17 Dec 2020 15:06:29 -0800
Date:   Thu, 17 Dec 2020 15:06:27 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Yafang Shao <laoar.shao@gmail.com>, willy@infradead.org,
        hch@infradead.org, mhocko@kernel.org, akpm@linux-foundation.org,
        dhowells@redhat.com, jlayton@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
        linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v13 3/4] xfs: refactor the usage around
 xfs_trans_context_{set,clear}
Message-ID: <20201217230627.GB6911@magnolia>
References: <20201217011157.92549-1-laoar.shao@gmail.com>
 <20201217011157.92549-4-laoar.shao@gmail.com>
 <20201217221509.GQ632069@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201217221509.GQ632069@dread.disaster.area>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9838 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 bulkscore=0
 suspectscore=0 adultscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012170149
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9838 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 mlxscore=0
 lowpriorityscore=0 spamscore=0 adultscore=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 impostorscore=0 priorityscore=1501 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012170149
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Dec 18, 2020 at 09:15:09AM +1100, Dave Chinner wrote:
> On Thu, Dec 17, 2020 at 09:11:56AM +0800, Yafang Shao wrote:
> > The xfs_trans context should be active after it is allocated, and
> > deactive when it is freed.
> > The rolling transaction should be specially considered, because in the
> > case when we clear the old transaction the thread's NOFS state shouldn't
> > be changed, as a result we have to set NOFS in the old transaction's
> > t_pflags in xfs_trans_context_swap().
> > 
> > So these helpers are refactored as,
> > - xfs_trans_context_set()
> >   Used in xfs_trans_alloc()
> > - xfs_trans_context_clear()
> >   Used in xfs_trans_free()
> > 
> > And a new helper is instroduced to handle the rolling transaction,
> > - xfs_trans_context_swap()
> >   Used in rolling transaction
> > 
> > This patch is based on Darrick's work to fix the issue in xfs/141 in the
> > earlier version. [1]
> > 
> > 1. https://lore.kernel.org/linux-xfs/20201104001649.GN7123@magnolia
> 
> As I said in my last comments, this change of logic is not
> necessary.  All we need to do is transfer the NOFS state to the new
> transactions and *remove it from the old one*.
> 
> IOWs, all this patch should do is:
> 
> > @@ -119,7 +123,9 @@ xfs_trans_dup(
> >  
> >  	ntp->t_rtx_res = tp->t_rtx_res - tp->t_rtx_res_used;
> >  	tp->t_rtx_res = tp->t_rtx_res_used;
> > -	ntp->t_pflags = tp->t_pflags;
> > +
> > +	/* Associate the new transaction with this thread. */
> > +	xfs_trans_context_swap(tp, ntp);
> >  
> >  	/* move deferred ops over to the new tp */
> >  	xfs_defer_move(ntp, tp);
> 
> This, and
> 
> > diff --git a/fs/xfs/xfs_trans.h b/fs/xfs/xfs_trans.h
> > index 44b11c64a15e..12380eaaf7ce 100644
> > --- a/fs/xfs/xfs_trans.h
> > +++ b/fs/xfs/xfs_trans.h
> > @@ -280,4 +280,17 @@ xfs_trans_context_clear(struct xfs_trans *tp)
> >  	memalloc_nofs_restore(tp->t_pflags);
> >  }
> >  
> > +static inline void
> > +xfs_trans_context_swap(struct xfs_trans *tp, struct xfs_trans *ntp)
> > +{
> 
> introduce this wrapper.
> 
> > +	ntp->t_pflags = tp->t_pflags;
> > +	/*
> > +	 * For the rolling transaction, we have to set NOFS in the old
> > +	 * transaction's t_pflags so that when we clear the context on
> > +	 * the old transaction we don't actually change the thread's NOFS
> > +	 * state.
> > +	 */
> > +	tp->t_pflags = current->flags | PF_MEMALLOC_NOFS;
> > +}
> 
> But not with this implementation.
> 
> Think for a minute, please. All we want to do is avoid clearing
> the nofs state when we call xfs_trans_context_clear(tp) if the state
> has been handed to another transaction.
> 
> Your current implementation hands the state to ntp, but *then leaves
> it on tp* as well. So then you hack a PF_MEMALLOC_NOFS flag into
> tp->t_pflags so that it doesn't clear that flag (abusing the masking
> done during clearing). That's just nasty because it relies on
> internal memalloc_nofs_restore() details for correct functionality.
> 
> The obvious solution: we've moved the saved process state to a
> different context, so it is no longer needed for the current
> transaction we are about to commit. So How about just clearing the
> saved state from the original transaction when swappingi like so:
> 
> static inline void
> xfs_trans_context_swap(struct xfs_trans *tp, struct xfs_trans *ntp)
> {
> 	ntp->t_pflags = tp->t_pflags;
> 	tp->t_flags = 0;
> }
> 
> And now, when we go to clear the transaction context, we can simply
> do this:
> 
> static inline void
> xfs_trans_context_clear(struct xfs_trans *tp)
> {
> 	if (tp->t_pflags)
> 		memalloc_nofs_restore(tp->t_pflags);
> }
> 
> and the problem is solved. The NOFS state will follow the active
> transaction and not be reset until the entire transaction chain is
> completed.

Er... correct me if I'm wrong, but I thought t_pflags stores the old
state of current->flags from before we call xfs_trans_alloc?  So if we
call into xfs_trans_alloc with current->flags==0 and we commit the
transaction having not rolled, we won't unset the _NOFS state, and exit
back to userspace with _NOFS set.

I think the logic is correct here -- we transfer the old pflags value
from @tp to @ntp, which effectively puts @ntp in charge of restoring the
old pflags value; and then we set tp->t_pflags to current->flags, which
means that @tp will "restore" the current pflags value into pflags, which
is a nop.

--D

> In the next patch you can go and introduce current->journal_info
> into just the wrapper functions, maintaining the same overall
> logic.
> 
> -Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
