Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7AF632D89A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Mar 2021 18:27:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238063AbhCDR1R (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Mar 2021 12:27:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:40324 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239347AbhCDR1M (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Mar 2021 12:27:12 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E386664E89;
        Thu,  4 Mar 2021 17:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614878792;
        bh=HB4loAXLWA5MoyQDvfOGFQeSomA30bqcWhsrZ2wxtsw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TFRhTk+0/ppdWpGnyHUxo6Gb/F0UjQUMOROnNxn+GSprEm5X8oX5gmpzN6xRwA9J9
         KVwwRFZvXZ3gY1fFfRNdjgOdjDgZbAReN2aHjgNZ2mEDV+JQayw7cdCfPvK623by0N
         w7jjIoMN/hKzcGwh+YIa3JNYvksroW4Z9vMFNluOX5p/aCIdRc0MNl73I6jBj1uByJ
         Le9C9eepeV831JgDxJuoMXfI7DbRx8N9auvR49Zc6+CQAw+0saca14lm6DBBvYS4Ir
         WxytlnNqmujBaSs6vdBwbGw6w+XHLD4hR0zEnynHOgXs3eBHX0TbHHxNJTNfwlo7m2
         PekzeBi/fDf0g==
Date:   Thu, 4 Mar 2021 09:26:31 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, anju@linux.vnet.ibm.com
Subject: Re: [PATCH] iomap: Fix negative assignment to unsigned sis->pages in
 iomap_swapfile_activate
Message-ID: <20210304172631.GD7267@magnolia>
References: <b39319ab99d9c5541b2cdc172a4b25f39cbaad50.1614838615.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b39319ab99d9c5541b2cdc172a4b25f39cbaad50.1614838615.git.riteshh@linux.ibm.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 04, 2021 at 11:51:26AM +0530, Ritesh Harjani wrote:
> In case if isi.nr_pages is 0, we are making sis->pages (which is
> unsigned int) a huge value in iomap_swapfile_activate() by assigning -1.
> This could cause a kernel crash in kernel v4.18 (with below signature).
> Or could lead to unknown issues on latest kernel if the fake big swap gets
> used.
> 
> Fix this issue by returning -EINVAL in case of nr_pages is 0, since it
> is anyway a invalid swapfile. Looks like this issue will be hit when
> we have pagesize < blocksize type of configuration.
> 
> I was able to hit the issue in case of a tiny swap file with below
> test script.
> https://raw.githubusercontent.com/riteshharjani/LinuxStudy/master/scripts/swap-issue.sh

Can you turn this into a dangerous-group fstest, please?

> kernel crash analysis on v4.18
> ==============================
> On v4.18 kernel, it causes a kernel panic, since sis->pages becomes
> a huge value and isi.nr_extents is 0. When 0 is returned it is
> considered as a swapfile over NFS and SWP_FILE is set (sis->flags |= SWP_FILE).
> Then when swapoff was getting called it was calling a_ops->swap_deactivate()
> if (sis->flags & SWP_FILE) is true. Since a_ops->swap_deactivate() is
> NULL in case of XFS, it causes below panic.

Does the same reasoning apply to upstream?

> Panic signature on v4.18 kernel:
> =======================================
> root@qemu:/home/qemu# [ 8291.723351] XFS (loop2): Unmounting Filesystem
> [ 8292.123104] XFS (loop2): Mounting V5 Filesystem
> [ 8292.132451] XFS (loop2): Ending clean mount
> [ 8292.263362] Adding 4294967232k swap on /mnt1/test/swapfile.  Priority:-2 extents:1 across:274877906880k
> [ 8292.277834] Unable to handle kernel paging request for instruction fetch
> [ 8292.278677] Faulting instruction address: 0x00000000
> cpu 0x19: Vector: 400 (Instruction Access) at [c0000009dd5b7ad0]
>     pc: 0000000000000000
>     lr: c0000000003eb9dc: destroy_swap_extents+0xfc/0x120
>     sp: c0000009dd5b7d50
>    msr: 8000000040009033
>   current = 0xc0000009b6710080
>   paca    = 0xc00000003ffcb280   irqmask: 0x03   irq_happened: 0x01
>     pid   = 5604, comm = swapoff
> Linux version 4.18.0 (riteshh@xxxxxxx) (gcc version 8.4.0 (Ubuntu 8.4.0-1ubuntu1~18.04)) #57 SMP Wed Mar 3 01:33:04 CST 2021
> enter ? for help
> [link register   ] c0000000003eb9dc destroy_swap_extents+0xfc/0x120
> [c0000009dd5b7d50] c0000000025a7058 proc_poll_event+0x0/0x4 (unreliable)
> [c0000009dd5b7da0] c0000000003f0498 sys_swapoff+0x3f8/0x910
> [c0000009dd5b7e30] c00000000000bbe4 system_call+0x5c/0x70
> --- Exception: c01 (System Call) at 00007ffff7d208d8
> 
> Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
> ---
>  fs/iomap/swapfile.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/fs/iomap/swapfile.c b/fs/iomap/swapfile.c
> index a648dbf6991e..67953678c99f 100644
> --- a/fs/iomap/swapfile.c
> +++ b/fs/iomap/swapfile.c
> @@ -170,6 +170,15 @@ int iomap_swapfile_activate(struct swap_info_struct *sis,
>  			return ret;
>  	}
> 
> +	/*
> +	 * In case if nr_pages is 0 then we better return -EINVAL
> +	 * since it is anyway an empty swapfile.
> +	 */
> +	if (isi.nr_pages == 0) {
> +		pr_warn("swapon: Empty swap-file\n");

The swapfile might not be empty, it's just that we couldn't find even a
single page's worth of contiguous space in the whole file.  I would
suggest:

	/*
	 * If this swapfile doesn't contain even a single page-aligned
	 * contiguous range of blocks, reject this useless swapfile to
	 * prevent confusion later on.
	 */
	if (isi.nr_pages == 0) {
		pr_warn("swapon: Cannot find a single usable page in file.\n");
		return -EINVAL;
	}

--D

> +		return -EINVAL;
> +	}
> +
>  	*pagespan = 1 + isi.highest_ppage - isi.lowest_ppage;
>  	sis->max = isi.nr_pages;
>  	sis->pages = isi.nr_pages - 1;
> --
> 2.26.2
> 
