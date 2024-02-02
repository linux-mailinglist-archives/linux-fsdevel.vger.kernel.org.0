Return-Path: <linux-fsdevel+bounces-9980-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B28F846DC7
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 11:20:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 021F3285021
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 10:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62FAE7E58B;
	Fri,  2 Feb 2024 10:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eXpydKss"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B62B97E566;
	Fri,  2 Feb 2024 10:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706869127; cv=none; b=kAqNBCf/YXawmCc3TW6sjM5POOnSST9FqssY1l5DQ9US6EIJ42wNNPUiBI0JQbz3m/wPizyhfzIizIFnL2L+ztcIjjUfj5WXDncE4vWtubWnkg/Y9ykznHQpyaDVE5T/j05O7FfxAVI0jfxafL01rAl70Ew1Sk4AL7nCpIm8RD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706869127; c=relaxed/simple;
	bh=Yd0a+ZftwyTSvlXWR+7CaTgcZSKrnc27VqQo89TiJJM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fXc6kNq+EMn9MNhkolgabk6SbWpUa5yV5/azfJBbhpOwU1Szj2eBHvtTVjVyKpWS99ATkmkVGfNRZSwPCMkVMhtYf4QgmyPVZ5nBDd4rdJg3dQVE5dbHAVO1fqf7a6XSmFd9Pozfn5ASWQ2opfRye+waPH27OthGcwK2Qlin128=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eXpydKss; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9D0EC433C7;
	Fri,  2 Feb 2024 10:18:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706869127;
	bh=Yd0a+ZftwyTSvlXWR+7CaTgcZSKrnc27VqQo89TiJJM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eXpydKss+cXyo54ANmjEsyHUZese9myseD6Et1zIfD/9lfc5ho81DAwNz4ALSUmlC
	 IzgvysWWg7TfYlTq0s2jTmoPsyzrsaUkkADtmThC7O4cxUx69jWiltz8Zm9xMNE1AO
	 xF9mSKZ+X+WCsC61LRWDW7dZirMb+PFfYYU5Gu7OZ1UsnH2pw2p2wHf/4A3hAucLN7
	 QI4FdBirlBBQbASj9aePqMVq6vossStgbx9+8B5KKi/bMAKNsFW7ZEwxemdy69apvB
	 jf/vmQ6K/HJex3AJKYuWku4kClGVYCiTl6PNCd5OpCx/1nOBA+T8c90n+halAry8Rk
	 b/6HuiMy9ilnQ==
Date: Fri, 2 Feb 2024 11:18:41 +0100
From: Christian Brauner <brauner@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: viro@zeniv.linux.org.uk, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, CobeChen@zhaoxin.com, LouisQi@zhaoxin.com, JonasZhou@zhaoxin.com, 
	JonasZhou-oc <JonasZhou-oc@zhaoxin.com>
Subject: Re: [PATCH] fs/address_space: move i_mmap_rwsem to mitigate a false
 sharing with i_mmap.
Message-ID: <20240202-erdacht-bereuen-825309cf8c78@brauner>
References: <20240202093407.12536-1-JonasZhou-oc@zhaoxin.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240202093407.12536-1-JonasZhou-oc@zhaoxin.com>

[That needs a review from Willy.]

On Fri, Feb 02, 2024 at 05:34:07PM +0800, JonasZhou-oc wrote:
> In the struct address_space, there is a 32-byte gap between i_mmap
> and i_mmap_rwsem. Due to the alignment of struct address_space
> variables to 8 bytes, in certain situations, i_mmap and
> i_mmap_rwsem may end up in the same CACHE line.
> 
> While running Unixbench/execl, we observe high false sharing issues
> when accessing i_mmap against i_mmap_rwsem. We move i_mmap_rwsem
> after i_private_list, ensuring a 64-byte gap between i_mmap and
> i_mmap_rwsem.
> 
> For Intel Silver machines (2 sockets) using kernel v6.8 rc-2, the
> score of Unixbench/execl improves by ~3.94%, and the score of
> Unixbench/shell improves by ~3.26%.
> 
> Baseline:
> -------------------------------------------------------------
>   162      546      748    11374       21  0xffff92e266af90c0
> -------------------------------------------------------------
>         46.89%   44.65%    0.00%    0.00%                 0x0     1       1  0xffffffff86d5fb96       460       258       271     1069        32  [k] __handle_mm_fault          [kernel.vmlinux]  memory.c:2940            0  1
>          4.21%    4.41%    0.00%    0.00%                 0x4     1       1  0xffffffff86d0ed54       473       311       288       95        28  [k] filemap_read               [kernel.vmlinux]  atomic.h:23              0  1
>          0.00%    0.00%    0.04%    4.76%                 0x8     1       1  0xffffffff86d4bcf1         0         0         0        5         4  [k] vma_interval_tree_remove   [kernel.vmlinux]  rbtree_augmented.h:204   0  1
>          6.41%    6.02%    0.00%    0.00%                 0x8     1       1  0xffffffff86d4ba85       411       271       339      210        32  [k] vma_interval_tree_insert   [kernel.vmlinux]  interval_tree.c:23       0  1
>          0.00%    0.00%    0.47%   95.24%                0x10     1       1  0xffffffff86d4bd34         0         0         0       74        32  [k] vma_interval_tree_remove   [kernel.vmlinux]  rbtree_augmented.h:339   0  1
>          0.37%    0.13%    0.00%    0.00%                0x10     1       1  0xffffffff86d4bb4f       328       212       380        7         5  [k] vma_interval_tree_remove   [kernel.vmlinux]  rbtree_augmented.h:338   0  1
>          5.13%    5.08%    0.00%    0.00%                0x10     1       1  0xffffffff86d4bb4b       416       255       357      197        32  [k] vma_interval_tree_remove   [kernel.vmlinux]  rbtree_augmented.h:338   0  1
>          1.10%    0.53%    0.00%    0.00%                0x28     1       1  0xffffffff86e06eb8       395       228       351       24        14  [k] do_dentry_open             [kernel.vmlinux]  open.c:966               0  1
>          1.10%    2.14%   57.07%    0.00%                0x38     1       1  0xffffffff878c9225      1364       792       462     7003        32  [k] down_write                 [kernel.vmlinux]  atomic64_64.h:109        0  1
>          0.00%    0.00%    0.01%    0.00%                0x38     1       1  0xffffffff878c8e75         0         0       252        3         2  [k] rwsem_down_write_slowpath  [kernel.vmlinux]  atomic64_64.h:109        0  1
>          0.00%    0.13%    0.00%    0.00%                0x38     1       1  0xffffffff878c8e23         0       596        63        2         2  [k] rwsem_down_write_slowpath  [kernel.vmlinux]  atomic64_64.h:15         0  1
>          2.38%    2.94%    6.53%    0.00%                0x38     1       1  0xffffffff878c8ccb      1150       818       570     1197        32  [k] rwsem_down_write_slowpath  [kernel.vmlinux]  atomic64_64.h:109        0  1
>         30.59%   32.22%    0.00%    0.00%                0x38     1       1  0xffffffff878c8cb4       423       251       380      648        32  [k] rwsem_down_write_slowpath  [kernel.vmlinux]  atomic64_64.h:15         0  1
>          1.83%    1.74%   35.88%    0.00%                0x38     1       1  0xffffffff86b4f833      1217      1112       565     4586        32  [k] up_write                   [kernel.vmlinux]  atomic64_64.h:91         0  1
> 
> with this change:
> -------------------------------------------------------------
>   360       12      300       57       35  0xffff982cdae76400
> -------------------------------------------------------------
>         50.00%   59.67%    0.00%    0.00%                 0x0     1       1  0xffffffff8215fb86       352       200       191      558        32  [k] __handle_mm_fault         [kernel.vmlinux]  memory.c:2940            0  1
>          8.33%    5.00%    0.00%    0.00%                 0x4     1       1  0xffffffff8210ed44       370       284       263       42        24  [k] filemap_read              [kernel.vmlinux]  atomic.h:23              0  1
>          0.00%    0.00%    5.26%    2.86%                 0x8     1       1  0xffffffff8214bce1         0         0         0        4         4  [k] vma_interval_tree_remove  [kernel.vmlinux]  rbtree_augmented.h:204   0  1
>         33.33%   14.33%    0.00%    0.00%                 0x8     1       1  0xffffffff8214ba75       344       186       219      140        32  [k] vma_interval_tree_insert  [kernel.vmlinux]  interval_tree.c:23       0  1
>          0.00%    0.00%   94.74%   97.14%                0x10     1       1  0xffffffff8214bd24         0         0         0       88        29  [k] vma_interval_tree_remove  [kernel.vmlinux]  rbtree_augmented.h:339   0  1
>          8.33%   20.00%    0.00%    0.00%                0x10     1       1  0xffffffff8214bb3b       296       209       226      167        31  [k] vma_interval_tree_remove  [kernel.vmlinux]  rbtree_augmented.h:338   0  1
>          0.00%    0.67%    0.00%    0.00%                0x28     1       1  0xffffffff82206f45         0       140       334        4         3  [k] do_dentry_open            [kernel.vmlinux]  open.c:966               0  1
>          0.00%    0.33%    0.00%    0.00%                0x38     1       1  0xffffffff8250a6c4         0       286       126        5         5  [k] errseq_sample             [kernel.vmlinux]  errseq.c:125             0
> 
> Signed-off-by: JonasZhou-oc <JonasZhou-oc@zhaoxin.com>
> ---
>  include/linux/fs.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index ed5966a70495..2d6ccde5d1be 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -482,10 +482,10 @@ struct address_space {
>  	pgoff_t			writeback_index;
>  	const struct address_space_operations *a_ops;
>  	unsigned long		flags;
> -	struct rw_semaphore	i_mmap_rwsem;
>  	errseq_t		wb_err;
>  	spinlock_t		i_private_lock;
>  	struct list_head	i_private_list;
> +	struct rw_semaphore	i_mmap_rwsem;
>  	void *			i_private_data;
>  } __attribute__((aligned(sizeof(long)))) __randomize_layout;
>  	/*
> -- 
> 2.25.1
> 

