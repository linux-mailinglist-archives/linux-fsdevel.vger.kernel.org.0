Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3804A497B9C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jan 2022 10:13:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233563AbiAXJNF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jan 2022 04:13:05 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:42444 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233534AbiAXJMp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jan 2022 04:12:45 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id B94711F38F;
        Mon, 24 Jan 2022 09:12:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1643015563; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=te56RQ99aqPTc41NPJHLgL/zz3BVpI2tpkzPhnGSaYY=;
        b=FNyUO63n86aC6LffHgwaiXuA5ojWMjJ1XEaOzV/m7vIGXnEXt4sPIgJthaRWeMnKRgGOmz
        78S1vbJAV/nyv1uemiOIrWR+C4RBsHUcZ8UCSwupwFBu94zUyfvhXgWnUFy+anPUx+qx87
        iNKhd1p7VOsIR4WpGRMGDpIi6gyN1BY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1643015563;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=te56RQ99aqPTc41NPJHLgL/zz3BVpI2tpkzPhnGSaYY=;
        b=qxPnKufainIaDn/nurTznWTh23bbgVSgRjZmoOYkNubkWcXresnuRNRVtF2QH7XLXm7Vy5
        fKWmhfZIDmaAC7BA==
Received: from quack3.suse.cz (unknown [10.163.43.118])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id AA18FA3B96;
        Mon, 24 Jan 2022 09:12:43 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 695C1A05E7; Mon, 24 Jan 2022 10:12:43 +0100 (CET)
Date:   Mon, 24 Jan 2022 10:12:43 +0100
From:   Jan Kara <jack@suse.cz>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.com>,
        tytso@mit.edu
Subject: Re: [PATCHv1 2/2] jbd2: Remove CONFIG_JBD2_DEBUG to update t_max_wait
Message-ID: <20220124091243.cua4apgkd64fw6iv@quack3.lan>
References: <cover.1642953021.git.riteshh@linux.ibm.com>
 <c1424ac2e6f6f5a21bcf2fb7679203df865c8a60.1642953021.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c1424ac2e6f6f5a21bcf2fb7679203df865c8a60.1642953021.git.riteshh@linux.ibm.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun 23-01-22 22:53:28, Ritesh Harjani wrote:
> CONFIG_JBD2_DEBUG and jbd2_journal_enable_debug knobs were added in
> update_t_max_wait(), since earlier it used to take a spinlock for updating
> t_max_wait, which could cause a bottleneck while starting a txn
> (start_this_handle()).
> Since in previous patch, we have killed t_handle_lock completely, we
> could get rid of this debug config and knob to let t_max_wait be updated
> by default again.
> 
> Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>

Sounds fine. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/jbd2/transaction.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/jbd2/transaction.c b/fs/jbd2/transaction.c
> index 68dd7de49aff..77634e2e118e 100644
> --- a/fs/jbd2/transaction.c
> +++ b/fs/jbd2/transaction.c
> @@ -141,20 +141,19 @@ static void jbd2_get_transaction(journal_t *journal,
>   * t_max_wait is carefully updated here with use of atomic compare exchange.
>   * Note that there could be multiplre threads trying to do this simultaneously
>   * hence using cmpxchg to avoid any use of locks in this case.
> + * With this t_max_wait can be updated w/o enabling jbd2_journal_enable_debug.
>   */
>  static inline void update_t_max_wait(transaction_t *transaction,
>  				     unsigned long ts)
>  {
> -#ifdef CONFIG_JBD2_DEBUG
>  	unsigned long oldts, newts;
> -	if (jbd2_journal_enable_debug &&
> -	    time_after(transaction->t_start, ts)) {
> +
> +	if (time_after(transaction->t_start, ts)) {
>  		newts = jbd2_time_diff(ts, transaction->t_start);
>  		oldts = READ_ONCE(transaction->t_max_wait);
>  		while (oldts < newts)
>  			oldts = cmpxchg(&transaction->t_max_wait, oldts, newts);
>  	}
> -#endif
>  }
> 
>  /*
> --
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
