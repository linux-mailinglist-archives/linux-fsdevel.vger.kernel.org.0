Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B1A5215ADAC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2020 17:50:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727054AbgBLQuT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Feb 2020 11:50:19 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:55822 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726728AbgBLQuT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Feb 2020 11:50:19 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01CGcTse113041;
        Wed, 12 Feb 2020 16:50:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=P7Kw67h/ZApfPL1ZreJHw29g3oWW/typFfH0YIUrnvk=;
 b=qZPfQarOZK0SRaebBkOzD0Ycj0xv+n7wlFYN5TMkwXFYxV2Bor7KUYREBY8C8ayxauSf
 FslY5miwsK1XeIogc4LUoR2zgZ2qHgCuHDZffRsCn3iYx4HoY5DGBA6KolaFOCJ1sCmX
 uzXLkRDQuE1PJ/90a8o8swkXeVU/hx49GgQ4Nm1iG8YDoe7TiD7v6ML6PgYbzDRKAQH3
 kQ5Jv5uyaYCuzUbLFNO6sy7S/QfoUebyUyfjGgQU0OefaORk7mwLFvsZBM6Y+KQX4hD8
 CaFdWxvi8E4A9+L9Fj8sxu+RUk954RuukX+IuGIUtRYe/ZNQYWYkj4bOTN/Wo+s56DSl DA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2y2k88c9bs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 12 Feb 2020 16:50:02 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01CGb2uj083361;
        Wed, 12 Feb 2020 16:50:02 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2y4kaggdje-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Feb 2020 16:50:02 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 01CGnvb3010870;
        Wed, 12 Feb 2020 16:49:57 GMT
Received: from localhost (/10.159.151.237)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 12 Feb 2020 08:49:57 -0800
Date:   Wed, 12 Feb 2020 08:49:56 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v2] mm, swap: move inode_lock out of claim_swapfile
Message-ID: <20200212164956.GK6874@magnolia>
References: <20200206090132.154869-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200206090132.154869-1-naohiro.aota@wdc.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9529 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 bulkscore=0
 suspectscore=2 mlxscore=0 malwarescore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002120128
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9529 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 lowpriorityscore=0
 suspectscore=2 bulkscore=0 phishscore=0 mlxlogscore=999 mlxscore=0
 malwarescore=0 impostorscore=0 clxscore=1015 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002120128
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 06, 2020 at 06:01:32PM +0900, Naohiro Aota wrote:
> claim_swapfile() currently keeps the inode locked when it is successful, or
> the file is already swapfile (with -EBUSY). And, on the other error cases,
> it does not lock the inode.
> 
> This inconsistency of the lock state and return value is quite confusing
> and actually causing a bad unlock balance as below in the "bad_swap"
> section of __do_sys_swapon().
> 
> This commit fixes this issue by moving the inode_lock() and IS_SWAPFILE
> check out of claim_swapfile(). The inode is unlocked in
> "bad_swap_unlock_inode" section, so that the inode is ensured to be
> unlocked at "bad_swap". Thus, error handling codes after the locking now
> jumps to "bad_swap_unlock_inode" instead of "bad_swap".
> 
>     =====================================
>     WARNING: bad unlock balance detected!
>     5.5.0-rc7+ #176 Not tainted
>     -------------------------------------
>     swapon/4294 is trying to release lock (&sb->s_type->i_mutex_key) at:
>     [<ffffffff8173a6eb>] __do_sys_swapon+0x94b/0x3550
>     but there are no more locks to release!
> 
>     other info that might help us debug this:
>     no locks held by swapon/4294.
> 
>     stack backtrace:
>     CPU: 5 PID: 4294 Comm: swapon Not tainted 5.5.0-rc7-BTRFS-ZNS+ #176
>     Hardware name: ASUS All Series/H87-PRO, BIOS 2102 07/29/2014
>     Call Trace:
>      dump_stack+0xa1/0xea
>      ? __do_sys_swapon+0x94b/0x3550
>      print_unlock_imbalance_bug.cold+0x114/0x123
>      ? __do_sys_swapon+0x94b/0x3550
>      lock_release+0x562/0xed0
>      ? kvfree+0x31/0x40
>      ? lock_downgrade+0x770/0x770
>      ? kvfree+0x31/0x40
>      ? rcu_read_lock_sched_held+0xa1/0xd0
>      ? rcu_read_lock_bh_held+0xb0/0xb0
>      up_write+0x2d/0x490
>      ? kfree+0x293/0x2f0
>      __do_sys_swapon+0x94b/0x3550
>      ? putname+0xb0/0xf0
>      ? kmem_cache_free+0x2e7/0x370
>      ? do_sys_open+0x184/0x3e0
>      ? generic_max_swapfile_size+0x40/0x40
>      ? do_syscall_64+0x27/0x4b0
>      ? entry_SYSCALL_64_after_hwframe+0x49/0xbe
>      ? lockdep_hardirqs_on+0x38c/0x590
>      __x64_sys_swapon+0x54/0x80
>      do_syscall_64+0xa4/0x4b0
>      entry_SYSCALL_64_after_hwframe+0x49/0xbe
>     RIP: 0033:0x7f15da0a0dc7
> 
> Fixes: 1638045c3677 ("mm: set S_SWAPFILE on blockdev swap devices")
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> ---
> Changelog:
> - Avoid taking inode lock in claim_swapfile()
> - Change error handling
>   - Add "bad_swap_unlock_inode" section to ensure the inode is unlocked at
>     "bad_swap"
> ---
>  mm/swapfile.c | 41 ++++++++++++++++++++---------------------
>  1 file changed, 20 insertions(+), 21 deletions(-)
> 
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index bb3261d45b6a..2c4c349e1101 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -2899,10 +2899,6 @@ static int claim_swapfile(struct swap_info_struct *p, struct inode *inode)
>  		p->bdev = inode->i_sb->s_bdev;
>  	}
>  
> -	inode_lock(inode);
> -	if (IS_SWAPFILE(inode))
> -		return -EBUSY;
> -
>  	return 0;
>  }
>  
> @@ -3157,36 +3153,41 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
>  	mapping = swap_file->f_mapping;
>  	inode = mapping->host;
>  
> -	/* If S_ISREG(inode->i_mode) will do inode_lock(inode); */
>  	error = claim_swapfile(p, inode);
>  	if (unlikely(error))
>  		goto bad_swap;
>  
> +	inode_lock(inode);
> +	if (IS_SWAPFILE(inode)) {
> +		error = -EBUSY;
> +		goto bad_swap_unlock_inode;
> +	}
> +
>  	/*
>  	 * Read the swap header.
>  	 */
>  	if (!mapping->a_ops->readpage) {
>  		error = -EINVAL;
> -		goto bad_swap;
> +		goto bad_swap_unlock_inode;
>  	}
>  	page = read_mapping_page(mapping, 0, swap_file);
>  	if (IS_ERR(page)) {
>  		error = PTR_ERR(page);
> -		goto bad_swap;
> +		goto bad_swap_unlock_inode;
>  	}
>  	swap_header = kmap(page);
>  
>  	maxpages = read_swap_header(p, swap_header, inode);
>  	if (unlikely(!maxpages)) {
>  		error = -EINVAL;
> -		goto bad_swap;
> +		goto bad_swap_unlock_inode;
>  	}
>  
>  	/* OK, set up the swap map and apply the bad block list */
>  	swap_map = vzalloc(maxpages);
>  	if (!swap_map) {
>  		error = -ENOMEM;
> -		goto bad_swap;
> +		goto bad_swap_unlock_inode;
>  	}
>  
>  	if (bdi_cap_stable_pages_required(inode_to_bdi(inode)))
> @@ -3211,7 +3212,7 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
>  					GFP_KERNEL);
>  		if (!cluster_info) {
>  			error = -ENOMEM;
> -			goto bad_swap;
> +			goto bad_swap_unlock_inode;
>  		}
>  
>  		for (ci = 0; ci < nr_cluster; ci++)
> @@ -3220,7 +3221,7 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
>  		p->percpu_cluster = alloc_percpu(struct percpu_cluster);
>  		if (!p->percpu_cluster) {
>  			error = -ENOMEM;
> -			goto bad_swap;
> +			goto bad_swap_unlock_inode;
>  		}
>  		for_each_possible_cpu(cpu) {
>  			struct percpu_cluster *cluster;
> @@ -3234,13 +3235,13 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
>  
>  	error = swap_cgroup_swapon(p->type, maxpages);
>  	if (error)
> -		goto bad_swap;
> +		goto bad_swap_unlock_inode;
>  
>  	nr_extents = setup_swap_map_and_extents(p, swap_header, swap_map,
>  		cluster_info, maxpages, &span);
>  	if (unlikely(nr_extents < 0)) {
>  		error = nr_extents;
> -		goto bad_swap;
> +		goto bad_swap_unlock_inode;
>  	}
>  	/* frontswap enabled? set up bit-per-page map for frontswap */
>  	if (IS_ENABLED(CONFIG_FRONTSWAP))
> @@ -3280,7 +3281,7 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
>  
>  	error = init_swap_address_space(p->type, maxpages);
>  	if (error)
> -		goto bad_swap;
> +		goto bad_swap_unlock_inode;
>  
>  	/*
>  	 * Flush any pending IO and dirty mappings before we start using this
> @@ -3290,7 +3291,7 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
>  	error = inode_drain_writes(inode);
>  	if (error) {
>  		inode->i_flags &= ~S_SWAPFILE;
> -		goto bad_swap;
> +		goto bad_swap_unlock_inode;
>  	}
>  
>  	mutex_lock(&swapon_mutex);
> @@ -3315,6 +3316,8 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
>  
>  	error = 0;
>  	goto out;

Sorry to wander in late, but I don't see how we unlock the inode in the
success case.  Before this patch, the "if (inode) inode_unlock(inode);"
below out: would take care of this for both the success case and the
bad_swap case, but now that's gone, and AFAICT after this patch we only
unlock the inode when erroring out...

> +bad_swap_unlock_inode:
> +	inode_unlock(inode);

...since we never goto bad_swap_unlock_inode when error == 0, correct?

--D

>  bad_swap:
>  	free_percpu(p->percpu_cluster);
>  	p->percpu_cluster = NULL;
> @@ -3322,6 +3325,7 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
>  		set_blocksize(p->bdev, p->old_block_size);
>  		blkdev_put(p->bdev, FMODE_READ | FMODE_WRITE | FMODE_EXCL);
>  	}
> +	inode = NULL;
>  	destroy_swap_extents(p);
>  	swap_cgroup_swapoff(p->type);
>  	spin_lock(&swap_lock);
> @@ -3333,13 +3337,8 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
>  	kvfree(frontswap_map);
>  	if (inced_nr_rotate_swap)
>  		atomic_dec(&nr_rotate_swap);
> -	if (swap_file) {
> -		if (inode) {
> -			inode_unlock(inode);
> -			inode = NULL;
> -		}
> +	if (swap_file)
>  		filp_close(swap_file, NULL);
> -	}
>  out:
>  	if (page && !IS_ERR(page)) {
>  		kunmap(page);
> -- 
> 2.25.0
> 
