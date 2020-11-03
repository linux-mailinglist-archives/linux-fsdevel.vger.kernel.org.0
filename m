Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A5602A5066
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Nov 2020 20:48:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729795AbgKCTsd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Nov 2020 14:48:33 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:43872 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729737AbgKCTsd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Nov 2020 14:48:33 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A3Jk17L104720;
        Tue, 3 Nov 2020 19:48:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=Y1yUClLcgi9YZbPCP84TKPcE5DOxGrg0KhgPBKB3C8w=;
 b=eoj0Jx71Lr425C6AOPbv4fAInJmVA3FoiflhgGwNPl0cGX/pbjaDEFREsEGuLxPbh5ML
 FcAbLF6NyBgVayS/3SURnrj62dxW9Cltui0vWWKcacJEKA7VlucI4rHOcemCkHWUsS9D
 1H54QyFgIttwcHiIRukkzA/9OecryD5L6ovFNuQzCj8w6moaITDblBieBQYDhL2BmSx0
 i74hgy21YY+B55t33Msnai+HctVw10x6mli5qdk6GP9Gn3vje7tzhIV+o5PdG7StvMSc
 rL99IxLH9G5pY24G7u/g5wNKh7obkh8lcm7h2ej+h0y/uLgT0pKG72wCRSIz85IzqnEo vg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 34hhvcb7qw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 03 Nov 2020 19:48:22 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A3JegOh081256;
        Tue, 3 Nov 2020 19:48:21 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 34hw0e3m14-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Nov 2020 19:48:21 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0A3JmKq0012617;
        Tue, 3 Nov 2020 19:48:20 GMT
Received: from localhost (/10.159.234.173)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 03 Nov 2020 11:48:20 -0800
Date:   Tue, 3 Nov 2020 11:48:19 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     akpm@linux-foundation.org, david@fromorbit.com, hch@infradead.org,
        willy@infradead.org, mhocko@kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH v8 resend 1/2] mm: Add become_kswapd and restore_kswapd
Message-ID: <20201103194819.GM7123@magnolia>
References: <20201103131754.94949-1-laoar.shao@gmail.com>
 <20201103131754.94949-2-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201103131754.94949-2-laoar.shao@gmail.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9794 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=5 mlxlogscore=999
 phishscore=0 bulkscore=0 spamscore=0 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011030132
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9794 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=5
 impostorscore=0 malwarescore=0 priorityscore=1501 mlxlogscore=999
 bulkscore=0 phishscore=0 adultscore=0 mlxscore=0 lowpriorityscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011030132
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 03, 2020 at 09:17:53PM +0800, Yafang Shao wrote:
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> 
> Since XFS needs to pretend to be kswapd in some of its worker threads,
> create methods to save & restore kswapd state.  Don't bother restoring
> kswapd state in kswapd -- the only time we reach this code is when we're
> exiting and the task_struct is about to be destroyed anyway.
> 
> Cc: Dave Chinner <david@fromorbit.com>
> Acked-by: Michal Hocko <mhocko@suse.com>
> Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> ---
>  fs/xfs/libxfs/xfs_btree.c | 14 ++++++++------
>  include/linux/sched/mm.h  | 23 +++++++++++++++++++++++
>  mm/vmscan.c               | 16 +---------------
>  3 files changed, 32 insertions(+), 21 deletions(-)
> 
> diff --git a/fs/xfs/libxfs/xfs_btree.c b/fs/xfs/libxfs/xfs_btree.c
> index 2d25bab..a04a442 100644
> --- a/fs/xfs/libxfs/xfs_btree.c
> +++ b/fs/xfs/libxfs/xfs_btree.c
> @@ -2813,8 +2813,9 @@ struct xfs_btree_split_args {
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
> @@ -2822,16 +2823,17 @@ struct xfs_btree_split_args {
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

Note that there's a trivial merge conflict with the mrlock_t removal
series.  I'll carry the fix in the tree, assuming that everything
passes.

--D

>  }
>  
>  /*
> diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
> index d5ece7a..2faf03e 100644
> --- a/include/linux/sched/mm.h
> +++ b/include/linux/sched/mm.h
> @@ -278,6 +278,29 @@ static inline void memalloc_nocma_restore(unsigned int flags)
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
>  DECLARE_PER_CPU(struct mem_cgroup *, int_active_memcg);
>  /**
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 1b8f0e0..77bc1dd 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -3869,19 +3869,7 @@ static int kswapd(void *p)
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
> @@ -3931,8 +3919,6 @@ static int kswapd(void *p)
>  			goto kswapd_try_sleep;
>  	}
>  
> -	tsk->flags &= ~(PF_MEMALLOC | PF_SWAPWRITE | PF_KSWAPD);
> -
>  	return 0;
>  }
>  
> -- 
> 1.8.3.1
> 
