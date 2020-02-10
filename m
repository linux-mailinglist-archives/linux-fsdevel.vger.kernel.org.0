Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4CD33156E6A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2020 05:16:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727029AbgBJEQO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 9 Feb 2020 23:16:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:40654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726944AbgBJEQO (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 9 Feb 2020 23:16:14 -0500
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 63385208C4;
        Mon, 10 Feb 2020 04:16:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581308173;
        bh=nXYmlFSwyHQs6qYhtrGmfUzzDBURe/MKElHOFDZXMlA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qP2KLxi4EabEgWS1NlSK3Ty6R/ZpvA2J3f1t0wixGyaZwg4bih+vw/XYqZ9FWYbzn
         wuJy8TrOExVCjWHkeLig7vYn4ENRutSDb6fh3obeZMocOoqR3ilrTrtZ34Wotha4dk
         fNjWd10OJqoSt/7c6+YMhOLbyio257afQFt4651I=
Date:   Sun, 9 Feb 2020 20:16:12 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <darrick.wong@oracle.com>
Subject: Re: [PATCH v2] mm, swap: move inode_lock out of claim_swapfile
Message-Id: <20200209201612.e5f234b357823df574104cb9@linux-foundation.org>
In-Reply-To: <20200206090132.154869-1-naohiro.aota@wdc.com>
References: <20200206090132.154869-1-naohiro.aota@wdc.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu,  6 Feb 2020 18:01:32 +0900 Naohiro Aota <naohiro.aota@wdc.com> wrote:

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
>  mm/swapfile.c | 41 ++++++++++++++++++++---------------------
>  1 file changed, 20 insertions(+), 21 deletions(-)
> 
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index bb3261d45b6a..2c4c349e1101 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c

Look correct to me.

But I don't think this code at the end of sys_swapon():

	if (inode)
		inode_unlock(inode);

will ever execute?  `inode' is always NULL here?

