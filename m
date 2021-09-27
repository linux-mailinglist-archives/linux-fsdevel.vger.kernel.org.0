Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 526364196A4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Sep 2021 16:47:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234909AbhI0OtK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Sep 2021 10:49:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:46994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234799AbhI0OtK (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Sep 2021 10:49:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AA79960FC2;
        Mon, 27 Sep 2021 14:47:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632754052;
        bh=adeXHUS73Lj4zzzb/ETuBZ3Thy9j9oPRwZgoXcZ7QtI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KY8V7Rjf4MkCkhxYzzkzdHSNH6rbG3D5QDqXAOskiwC5yZMY4FFU1wVvw/NWMfupo
         Td3hW8o6PB3ZF3RSOmcRMGMZfMfFQ51S2qZMNImcn1ZVuGLk7N71b4kDUGdk+ZL4nC
         q6/n3a2kzGmzhNJFqCblYhdJosOHaR5/YazgacjJxShd+rwzfpB7bZIFLU2cZPYzjX
         s69SWf2hO0wk1rgm7ouxc/WMdLYokIpimbREqJCQsR/cF2AnQICM7d5i20N/tJE8ZO
         fiEUGoXvmFUNV/Y897l2weu/v3XP3YpmPnbboRRc7l1puXpcmu0FB3+4WBfk0lbADq
         53WfbxZXnE09Q==
Date:   Mon, 27 Sep 2021 09:51:31 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Len Baker <len.baker@gmx.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        linux-fsdevel@vger.kernel.org, linux-hardening@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] writeback: prefer struct_size over open coded
 arithmetic
Message-ID: <20210927145131.GB168427@embeddedor>
References: <20210925114308.11455-1-len.baker@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210925114308.11455-1-len.baker@gmx.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Sep 25, 2021 at 01:43:08PM +0200, Len Baker wrote:
> As noted in the "Deprecated Interfaces, Language Features, Attributes,
> and Conventions" documentation [1], size calculations (especially
> multiplication) should not be performed in memory allocator (or similar)
> function arguments due to the risk of them overflowing. This could lead
> to values wrapping around and a smaller allocation being made than the
> caller was expecting. Using those allocations could lead to linear
> overflows of heap memory and other misbehaviors.
> 
> In this case these are not actually dynamic sizes: all the operands
> involved in the calculation are constant values. However it is better to
> refactor them anyway, just to keep the open-coded math idiom out of
> code.
> 
> So, use the struct_size() helper to do the arithmetic instead of the
> argument "size + count * size" in the kzalloc() functions.
> 
> This code was detected with the help of Coccinelle and audited and fixed
> manually.
> 
> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments
> 
> Signed-off-by: Len Baker <len.baker@gmx.com>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks
--
Gustavo

> ---
> Changelog v1 -> v2
> - Rebase against v5.15-rc2
> - Refactor another instance in the same file (Gustavo A. R. Silva).
> - Update the commit changelog to inform that this code was detected
>   using a Coccinelle script (Gustavo A. R. Silva).
> 
>  fs/fs-writeback.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> index 81ec192ce067..5eb0ada7468c 100644
> --- a/fs/fs-writeback.c
> +++ b/fs/fs-writeback.c
> @@ -566,7 +566,7 @@ static void inode_switch_wbs(struct inode *inode, int new_wb_id)
>  	if (atomic_read(&isw_nr_in_flight) > WB_FRN_MAX_IN_FLIGHT)
>  		return;
> 
> -	isw = kzalloc(sizeof(*isw) + 2 * sizeof(struct inode *), GFP_ATOMIC);
> +	isw = kzalloc(struct_size(isw, inodes, 2), GFP_ATOMIC);
>  	if (!isw)
>  		return;
> 
> @@ -624,8 +624,8 @@ bool cleanup_offline_cgwb(struct bdi_writeback *wb)
>  	int nr;
>  	bool restart = false;
> 
> -	isw = kzalloc(sizeof(*isw) + WB_MAX_INODES_PER_ISW *
> -		      sizeof(struct inode *), GFP_KERNEL);
> +	isw = kzalloc(struct_size(isw, inodes, WB_MAX_INODES_PER_ISW),
> +		      GFP_KERNEL);
>  	if (!isw)
>  		return restart;
> 
> --
> 2.25.1
> 
