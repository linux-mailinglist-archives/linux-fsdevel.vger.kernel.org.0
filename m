Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76012288D5F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Oct 2020 17:54:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389447AbgJIPyA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Oct 2020 11:54:00 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:41660 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388745AbgJIPx7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Oct 2020 11:53:59 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 099FneKe041555;
        Fri, 9 Oct 2020 15:53:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=XuWnsL5lgcta7pemx636Wy4SNS7IjVArBRC42Pl8f6M=;
 b=IBztltLheJCYsvy1I4q74Fp2nbdAG0UR3Ze0Kv9+k9Dva/kx3aQB9xSUFwScehDLc1JL
 CEfuZUWdhaRFgqALhIofg6NgPypkSlUrZoS2YBwGwhQ5QRR4V6e3ANwi6CYlT5rjI6wx
 FLkEmlXK9mwZroCLnaxiDT8qj0n4w12E2+P913JYC4zTDYbjrJ7aJVmWHMqw+CLVRcve
 kpr7BUv3u4G+vyJ7SI2Z4Vy3Hzqbnul228hitJFDbI8Ku40Cr5qTnqrMco9ElcE1Y0RI
 d/xFKlOr6Y5owJV8DONr0dRPC7gaZxZgF0Aa4okI2ieDOxmONCkjFnikN4FFewwCFbB4 EQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 3429jmmant-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 09 Oct 2020 15:53:43 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 099FnQQa069144;
        Fri, 9 Oct 2020 15:53:42 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 342gurm4mu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 09 Oct 2020 15:53:42 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 099FrdIX003764;
        Fri, 9 Oct 2020 15:53:40 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 09 Oct 2020 08:53:39 -0700
Date:   Fri, 9 Oct 2020 08:53:38 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     david@fromorbit.com, hch@infradead.org, willy@infradead.org,
        mhocko@kernel.org, akpm@linux-foundation.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v8 1/2] mm: Add become_kswapd and restore_kswapd
Message-ID: <20201009155338.GV6540@magnolia>
References: <20201009125127.37435-1-laoar.shao@gmail.com>
 <20201009125127.37435-2-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201009125127.37435-2-laoar.shao@gmail.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9769 signatures=668681
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 bulkscore=0 malwarescore=0 mlxscore=0 spamscore=0 adultscore=0
 suspectscore=5 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010090118
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9769 signatures=668681
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 suspectscore=5
 clxscore=1011 phishscore=0 lowpriorityscore=0 impostorscore=0
 malwarescore=0 mlxlogscore=999 priorityscore=1501 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010090118
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 09, 2020 at 08:51:26PM +0800, Yafang Shao wrote:
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> 
> Since XFS needs to pretend to be kswapd in some of its worker threads,
> create methods to save & restore kswapd state.  Don't bother restoring
> kswapd state in kswapd -- the only time we reach this code is when we're
> exiting and the task_struct is about to be destroyed anyway.
> 
> Cc: Dave Chinner <david@fromorbit.com>
> Cc: Christoph Hellwig <hch@infradead.org>
> Cc: Darrick J. Wong <darrick.wong@oracle.com>
> Cc: Matthew Wilcox <willy@infradead.org>
> Acked-by: Michal Hocko <mhocko@suse.com>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> ---
>  fs/xfs/libxfs/xfs_btree.c | 14 ++++++++------
>  include/linux/sched/mm.h  | 23 +++++++++++++++++++++++
>  mm/vmscan.c               | 16 +---------------
>  3 files changed, 32 insertions(+), 21 deletions(-)
> 
> diff --git a/fs/xfs/libxfs/xfs_btree.c b/fs/xfs/libxfs/xfs_btree.c
> index 2d25bab68764..a04a44238aab 100644
> --- a/fs/xfs/libxfs/xfs_btree.c
> +++ b/fs/xfs/libxfs/xfs_btree.c
> @@ -2813,8 +2813,9 @@ xfs_btree_split_worker(
>  {
>  	struct xfs_btree_split_args	*args = container_of(work,
>  						struct xfs_btree_split_args, work);
> +	bool			is_kswapd = args->kswapd;
>  	unsigned long		pflags;
> -	unsigned long		new_pflags = PF_MEMALLOC_NOFS;
> +	int			memalloc_nofs;
>  
>  	/*
>  	 * we are in a transaction context here, but may also be doing work
> @@ -2822,16 +2823,17 @@ xfs_btree_split_worker(
>  	 * temporarily to ensure that we don't block waiting for memory reclaim
>  	 * in any way.
>  	 */
> -	if (args->kswapd)
> -		new_pflags |= PF_MEMALLOC | PF_SWAPWRITE | PF_KSWAPD;
> -
> -	current_set_flags_nested(&pflags, new_pflags);
> +	if (is_kswapd)
> +		pflags = become_kswapd();
> +	memalloc_nofs = memalloc_nofs_save();
>  
>  	args->result = __xfs_btree_split(args->cur, args->level, args->ptrp,
>  					 args->key, args->curp, args->stat);
>  	complete(args->done);
>  
> -	current_restore_flags_nested(&pflags, new_pflags);
> +	memalloc_nofs_restore(memalloc_nofs);
> +	if (is_kswapd)
> +		restore_kswapd(pflags);

It's kind of a pity that these two APIs both touch current->flags but
there isn't a clean way to only use one flags variable to pop all of
these things at the end. :/

Oh well, at least the end result is more compact but still communicates
what we're doing with all these PF_ mods.

Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

>  }
>  
>  /*
> diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
> index f889e332912f..b38fdcb977a4 100644
> --- a/include/linux/sched/mm.h
> +++ b/include/linux/sched/mm.h
> @@ -303,6 +303,29 @@ static inline void memalloc_nocma_restore(unsigned int flags)
>  }
>  #endif
>  
> +/*
> + * Tell the memory management code that this thread is working on behalf
> + * of background memory reclaim (like kswapd).  That means that it will
> + * get access to memory reserves should it need to allocate memory in
> + * order to make forward progress.  With this great power comes great
> + * responsibility to not exhaust those reserves.
> + */
> +#define KSWAPD_PF_FLAGS		(PF_MEMALLOC | PF_SWAPWRITE | PF_KSWAPD)
> +
> +static inline unsigned long become_kswapd(void)
> +{
> +	unsigned long flags = current->flags & KSWAPD_PF_FLAGS;
> +
> +	current->flags |= KSWAPD_PF_FLAGS;
> +
> +	return flags;
> +}
> +
> +static inline void restore_kswapd(unsigned long flags)
> +{
> +	current->flags &= ~(flags ^ KSWAPD_PF_FLAGS);
> +}
> +
>  #ifdef CONFIG_MEMCG
>  /**
>   * memalloc_use_memcg - Starts the remote memcg charging scope.
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 466fc3144fff..eb6f6e8103c1 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -3867,19 +3867,7 @@ static int kswapd(void *p)
>  	if (!cpumask_empty(cpumask))
>  		set_cpus_allowed_ptr(tsk, cpumask);
>  
> -	/*
> -	 * Tell the memory management that we're a "memory allocator",
> -	 * and that if we need more memory we should get access to it
> -	 * regardless (see "__alloc_pages()"). "kswapd" should
> -	 * never get caught in the normal page freeing logic.
> -	 *
> -	 * (Kswapd normally doesn't need memory anyway, but sometimes
> -	 * you need a small amount of memory in order to be able to
> -	 * page out something else, and this flag essentially protects
> -	 * us from recursively trying to free more memory as we're
> -	 * trying to free the first piece of memory in the first place).
> -	 */
> -	tsk->flags |= PF_MEMALLOC | PF_SWAPWRITE | PF_KSWAPD;
> +	become_kswapd();
>  	set_freezable();
>  
>  	WRITE_ONCE(pgdat->kswapd_order, 0);
> @@ -3929,8 +3917,6 @@ static int kswapd(void *p)
>  			goto kswapd_try_sleep;
>  	}
>  
> -	tsk->flags &= ~(PF_MEMALLOC | PF_SWAPWRITE | PF_KSWAPD);
> -
>  	return 0;
>  }
>  
> -- 
> 2.17.1
> 
