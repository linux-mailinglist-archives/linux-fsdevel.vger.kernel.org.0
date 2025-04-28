Return-Path: <linux-fsdevel+bounces-47470-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C848A9E632
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Apr 2025 04:19:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F29CE3B1BAC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Apr 2025 02:18:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B770815F41F;
	Mon, 28 Apr 2025 02:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XnxwZW0F"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C607A930;
	Mon, 28 Apr 2025 02:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745806736; cv=none; b=RFxgvb1FouTFamVOCPyL0HD53k2LFng6UyGBsE0SLlpBOSxmPw0pNMx5Gn41CTi2a5Fr+DEpqOxfXV/SbNy2R/7liGJm4pdGZ67GBM9nwaIrj4/qYqDzpMvuQvFrHStX7EJ++UzJ2YGt/n52Vk3ekCL5scY+/AELYsS2DfNAnCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745806736; c=relaxed/simple;
	bh=zE4iPOA34UkR2Qmpjvr4GgW6AG4mrSCsIHDRpj55+AU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=az+ZeVhDxRGFg/i5wNMsXewsnBgLo3zmBJ1injGYfvxYODLy7vryyEdu2RC8BvmjSuu6moN0q8nyDQLbt/c6mBHxAC1Q37DJ7G2FtjFFdI20PaKG5JyPlisPjSPWs3SgzeJhX1VREDLLzT4FHl7YqbICtHHa4npb5NYaycd+L+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XnxwZW0F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 790CEC4CEE3;
	Mon, 28 Apr 2025 02:18:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745806734;
	bh=zE4iPOA34UkR2Qmpjvr4GgW6AG4mrSCsIHDRpj55+AU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XnxwZW0F+VF0ENfbBKk/GVeNtgVRZ7tDADZCsFjQQoPgP7J8Rd9dV8NozCjR2XOlV
	 5g8HvHm9ARFikOcbFGk2R2NSaoeIwxWU1A6Q5YJ8sTpPYlTyiT5yuQS6vZ06/c/4B5
	 97eVbm63KwfLYPfsrJhaS+7FpTPhzqOUnELzy8GiKuHMGMjq5/RdZ3lPVU7quapXck
	 iK2UXiYxiLhzeg6s2fJ2XpNL5aJWBcgmWN5yPzgZ2fU44egR/B6o/E7r941aX4kZ6z
	 sHLEoFnvxb+lL0wN7k2vli4V+wBDieLd8GdPYBxXkANhRR+g8+2fZfVNjk3sagxMWD
	 0VkWRcD/kVHGQ==
Date: Mon, 28 Apr 2025 10:18:47 +0800
From: Coly Li <colyli@kernel.org>
To: Fedor Pchelkin <pchelkin@ispras.ru>
Cc: linux-kernel@vger.kernel.org, 
	Kent Overstreet <kent.overstreet@linux.dev>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Carlos Maiolino <cem@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, "Darrick J. Wong" <djwong@kernel.org>, 
	linux-bcache@vger.kernel.org, linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-xfs@vger.kernel.org, lvc-project@linuxtesting.org
Subject: Re: [PATCH] sort.h: hoist cmp_int() into generic header file
Message-ID: <igz7aobnoaknndyms7apqguvybgvrxdfl22cwim5skbrrsjv7a@64wxcaiohjdx>
References: <20250427201451.900730-1-pchelkin@ispras.ru>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250427201451.900730-1-pchelkin@ispras.ru>

On Sun, Apr 27, 2025 at 11:14:49PM +0800, Fedor Pchelkin wrote:
> Deduplicate the same functionality implemented in several places by
> moving the cmp_int() helper macro into linux/sort.h.
> 
> The macro performs a three-way comparison of the arguments mostly useful
> in different sorting strategies and algorithms.
> 
> Suggested-by: Darrick J. Wong <djwong@kernel.org>
> Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>

Acked-by: Coly Li <colyli@kernel.org>


Thanks.

> ---
> 
> https://lore.kernel.org/linux-xfs/20250426150359.GQ25675@frogsfrogsfrogs/T/#u
> 
>  drivers/md/bcache/btree.c |  3 +--
>  fs/bcachefs/util.h        |  3 +--
>  fs/pipe.c                 |  3 +--
>  fs/xfs/xfs_zone_gc.c      |  2 --
>  include/linux/sort.h      | 10 ++++++++++
>  5 files changed, 13 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/md/bcache/btree.c b/drivers/md/bcache/btree.c
> index ed40d8600656..2cc2eb24dc8a 100644
> --- a/drivers/md/bcache/btree.c
> +++ b/drivers/md/bcache/btree.c
> @@ -36,6 +36,7 @@
>  #include <linux/sched/clock.h>
>  #include <linux/rculist.h>
>  #include <linux/delay.h>
> +#include <linux/sort.h>
>  #include <trace/events/bcache.h>
>  
>  /*
> @@ -559,8 +560,6 @@ static void mca_data_alloc(struct btree *b, struct bkey *k, gfp_t gfp)
>  	}
>  }
>  
> -#define cmp_int(l, r)		((l > r) - (l < r))
> -
>  #ifdef CONFIG_PROVE_LOCKING
>  static int btree_lock_cmp_fn(const struct lockdep_map *_a,
>  			     const struct lockdep_map *_b)
> diff --git a/fs/bcachefs/util.h b/fs/bcachefs/util.h
> index 3e52c7f8ddd2..7ec1fc8b46f9 100644
> --- a/fs/bcachefs/util.h
> +++ b/fs/bcachefs/util.h
> @@ -16,6 +16,7 @@
>  #include <linux/preempt.h>
>  #include <linux/ratelimit.h>
>  #include <linux/slab.h>
> +#include <linux/sort.h>
>  #include <linux/vmalloc.h>
>  #include <linux/workqueue.h>
>  
> @@ -669,8 +670,6 @@ static inline void percpu_memset(void __percpu *p, int c, size_t bytes)
>  
>  u64 *bch2_acc_percpu_u64s(u64 __percpu *, unsigned);
>  
> -#define cmp_int(l, r)		((l > r) - (l < r))
> -
>  static inline int u8_cmp(u8 l, u8 r)
>  {
>  	return cmp_int(l, r);
> diff --git a/fs/pipe.c b/fs/pipe.c
> index da45edd68c41..45077c37bad1 100644
> --- a/fs/pipe.c
> +++ b/fs/pipe.c
> @@ -26,6 +26,7 @@
>  #include <linux/memcontrol.h>
>  #include <linux/watch_queue.h>
>  #include <linux/sysctl.h>
> +#include <linux/sort.h>
>  
>  #include <linux/uaccess.h>
>  #include <asm/ioctls.h>
> @@ -76,8 +77,6 @@ static unsigned long pipe_user_pages_soft = PIPE_DEF_BUFFERS * INR_OPEN_CUR;
>   * -- Manfred Spraul <manfred@colorfullife.com> 2002-05-09
>   */
>  
> -#define cmp_int(l, r)		((l > r) - (l < r))
> -
>  #ifdef CONFIG_PROVE_LOCKING
>  static int pipe_lock_cmp_fn(const struct lockdep_map *a,
>  			    const struct lockdep_map *b)
> diff --git a/fs/xfs/xfs_zone_gc.c b/fs/xfs/xfs_zone_gc.c
> index 81c94dd1d596..2f9caa3eb828 100644
> --- a/fs/xfs/xfs_zone_gc.c
> +++ b/fs/xfs/xfs_zone_gc.c
> @@ -290,8 +290,6 @@ xfs_zone_gc_query_cb(
>  	return 0;
>  }
>  
> -#define cmp_int(l, r)		((l > r) - (l < r))
> -
>  static int
>  xfs_zone_gc_rmap_rec_cmp(
>  	const void			*a,
> diff --git a/include/linux/sort.h b/include/linux/sort.h
> index 8e5603b10941..c01ef804a0eb 100644
> --- a/include/linux/sort.h
> +++ b/include/linux/sort.h
> @@ -4,6 +4,16 @@
>  
>  #include <linux/types.h>
>  
> +/**
> + * cmp_int - perform a three-way comparison of the arguments
> + * @l: the left argument
> + * @r: the right argument
> + *
> + * Return: 1 if the left argument is greater than the right one; 0 if the
> + * arguments are equal; -1 if the left argument is less than the right one.
> + */
> +#define cmp_int(l, r) (((l) > (r)) - ((l) < (r)))
> +
>  void sort_r(void *base, size_t num, size_t size,
>  	    cmp_r_func_t cmp_func,
>  	    swap_r_func_t swap_func,
> -- 
> 2.49.0
> 

-- 
Coly Li

