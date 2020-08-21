Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B512124D94D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Aug 2020 18:03:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726816AbgHUQDE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Aug 2020 12:03:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:35600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725866AbgHUQC6 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Aug 2020 12:02:58 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 363A7207BB;
        Fri, 21 Aug 2020 16:02:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598025777;
        bh=EV/GR+9VB23wO4HYAr+8yBHz5vSm7Ev/KRXR37JYI2g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ImovsCZrJ/tdgS2ncCQiTS/L8yCwYE9ohFeJBAvirJKdRqeaxw8/m9aRr5h2sGaHC
         XgEWMfxB3M1PQKRQRdjLE03otqTFiLJPx5bVVQi35AAXT1D6p1YlIv8iZWEuFzqiAP
         FPJxlahOObcq2GKrNbYshgjpdDJ/xEuoFZEgWaJk=
Date:   Fri, 21 Aug 2020 17:02:53 +0100
From:   Will Deacon <will@kernel.org>
To:     Shaokun Zhang <zhangshaokun@hisilicon.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Boqun Feng <boqun.feng@gmail.com>,
        Yuqi Jin <jinyuqi@huawei.com>
Subject: Re: [PATCH RESEND] fs: Move @f_count to different cacheline with
 @f_mode
Message-ID: <20200821160252.GC21517@willie-the-truck>
References: <1592987548-8653-1-git-send-email-zhangshaokun@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1592987548-8653-1-git-send-email-zhangshaokun@hisilicon.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 24, 2020 at 04:32:28PM +0800, Shaokun Zhang wrote:
> get_file_rcu_many, which is called by __fget_files, has used
> atomic_try_cmpxchg now and it can reduce the access number of the global
> variable to improve the performance of atomic instruction compared with
> atomic_cmpxchg. 
> 
> __fget_files does check the @f_mode with mask variable and will do some
> atomic operations on @f_count, but both are on the same cacheline.
> Many CPU cores do file access and it will cause much conflicts on @f_count. 
> If we could make the two members into different cachelines, it shall relax
> the siutations.
> 
> We have tested this on ARM64 and X86, the result is as follows:
> Syscall of unixbench has been run on Huawei Kunpeng920 with this patch:
> 24 x System Call Overhead  1
> 
> System Call Overhead                    3160841.4 lps   (10.0 s, 1 samples)
> 
> System Benchmarks Partial Index              BASELINE       RESULT    INDEX
> System Call Overhead                          15000.0    3160841.4   2107.2
>                                                                    ========
> System Benchmarks Index Score (Partial Only)                         2107.2
> 
> Without this patch:
> 24 x System Call Overhead  1
> 
> System Call Overhead                    2222456.0 lps   (10.0 s, 1 samples)
> 
> System Benchmarks Partial Index              BASELINE       RESULT    INDEX
> System Call Overhead                          15000.0    2222456.0   1481.6
>                                                                    ========
> System Benchmarks Index Score (Partial Only)                         1481.6
> 
> And on Intel 6248 platform with this patch:
> 40 CPUs in system; running 24 parallel copies of tests
> 
> System Call Overhead                        4288509.1 lps   (10.0 s, 1 samples)
> 
> System Benchmarks Partial Index              BASELINE       RESULT    INDEX
> System Call Overhead                          15000.0    4288509.1   2859.0
>                                                                    ========
> System Benchmarks Index Score (Partial Only)                         2859.0
> 
> Without this patch:
> 40 CPUs in system; running 24 parallel copies of tests
> 
> System Call Overhead                        3666313.0 lps   (10.0 s, 1 samples)
> 
> System Benchmarks Partial Index              BASELINE       RESULT    INDEX
> System Call Overhead                          15000.0    3666313.0   2444.2
>                                                                    ========
> System Benchmarks Index Score (Partial Only)                         2444.2
> 
> Cc: Will Deacon <will@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Signed-off-by: Yuqi Jin <jinyuqi@huawei.com>
> Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
> ---
>  include/linux/fs.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 3f881a892ea7..0faeab5622fb 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -955,7 +955,6 @@ struct file {
>  	 */
>  	spinlock_t		f_lock;
>  	enum rw_hint		f_write_hint;
> -	atomic_long_t		f_count;
>  	unsigned int 		f_flags;
>  	fmode_t			f_mode;
>  	struct mutex		f_pos_lock;
> @@ -979,6 +978,7 @@ struct file {
>  	struct address_space	*f_mapping;
>  	errseq_t		f_wb_err;
>  	errseq_t		f_sb_err; /* for syncfs */
> +	atomic_long_t		f_count;
>  } __randomize_layout
>    __attribute__((aligned(4)));	/* lest something weird decides that 2 is OK */

Hmm. So the microbenchmark numbers look lovely, but:

  - What impact does it actually have for real workloads?
  - How do we avoid regressing performance by innocently changing the struct
    again later on?
  - This thing is tagged with __randomize_layout, so it doesn't help anybody
    using that crazy plugin
  - What about all the other atomics and locks that share cachelines?

Will
