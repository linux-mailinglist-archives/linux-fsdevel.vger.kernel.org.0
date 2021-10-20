Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 745B7434E18
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Oct 2021 16:40:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230061AbhJTOnB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Oct 2021 10:43:01 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:37586 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbhJTOnA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Oct 2021 10:43:00 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id D21AF21981;
        Wed, 20 Oct 2021 14:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1634740844; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+hJgAW2xx50BzR2rX4mlcXSbU5B0LhOwVBhbeQTEvos=;
        b=FSv56sui4dMt+PIBRwErbnSw2qPzY7Fqq1ki+ygBydcD9KS5/JAMtyoD4CpDNIsjS+ryBd
        xxqrsT1LouofpWogfbE6lOiA1Srro8kCcVVmGCf1cOQS0Czf/Oy+9SIKmUBOP10pk5IHkM
        i8uIpwhY0CKQESuGkXTTaxwRROomvAs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1634740844;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+hJgAW2xx50BzR2rX4mlcXSbU5B0LhOwVBhbeQTEvos=;
        b=t0EXJ90f+im6X7Onw6DiZwwZPTtFX0Xkd+yRryz6sNYUFEoabRjgRaRZt1yuSubVID1pXV
        zJxLuSllka0hICDQ==
Received: from quack2.suse.cz (unknown [10.100.224.230])
        by relay2.suse.de (Postfix) with ESMTP id AE8D7A3B84;
        Wed, 20 Oct 2021 14:40:44 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 998151F2C7D; Wed, 20 Oct 2021 16:40:44 +0200 (CEST)
Date:   Wed, 20 Oct 2021 16:40:44 +0200
From:   Jan Kara <jack@suse.cz>
To:     Len Baker <len.baker@gmx.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-hardening@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] writeback: prefer struct_size over open coded
 arithmetic
Message-ID: <20211020144044.GB16460@quack2.suse.cz>
References: <20210925114308.11455-1-len.baker@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210925114308.11455-1-len.baker@gmx.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat 25-09-21 13:43:08, Len Baker wrote:
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

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

BTW, writeback patches are usually merged by Andrew Morton so probably send
it to him. Thanks!

								Honza

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
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
