Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 555803668C5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Apr 2021 12:01:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237514AbhDUKC3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Apr 2021 06:02:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:43666 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232442AbhDUKC1 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Apr 2021 06:02:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id BC2BEB304;
        Wed, 21 Apr 2021 10:01:53 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 548CB1F2B69; Wed, 21 Apr 2021 12:01:53 +0200 (CEST)
Date:   Wed, 21 Apr 2021 12:01:53 +0200
From:   Jan Kara <jack@suse.cz>
To:     Zhang Yi <yi.zhang@huawei.com>
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
        yukuai3@huawei.com
Subject: Re: [RFC PATCH v2 1/7] jbd2: remove the out label in
 __jbd2_journal_remove_checkpoint()
Message-ID: <20210421100153.GQ8706@quack2.suse.cz>
References: <20210414134737.2366971-1-yi.zhang@huawei.com>
 <20210414134737.2366971-2-yi.zhang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210414134737.2366971-2-yi.zhang@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 14-04-21 21:47:31, Zhang Yi wrote:
> The 'out' lable just return the 'ret' value and seems not required, so
> remove this label and switch to return appropriate value immediately.
> This patch also do some minor cleanup, no logical change.
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/jbd2/checkpoint.c | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/fs/jbd2/checkpoint.c b/fs/jbd2/checkpoint.c
> index 63b526d44886..bf5511d19ac5 100644
> --- a/fs/jbd2/checkpoint.c
> +++ b/fs/jbd2/checkpoint.c
> @@ -564,13 +564,13 @@ int __jbd2_journal_remove_checkpoint(struct journal_head *jh)
>  	struct transaction_chp_stats_s *stats;
>  	transaction_t *transaction;
>  	journal_t *journal;
> -	int ret = 0;
>  
>  	JBUFFER_TRACE(jh, "entry");
>  
> -	if ((transaction = jh->b_cp_transaction) == NULL) {
> +	transaction = jh->b_cp_transaction;
> +	if (!transaction) {
>  		JBUFFER_TRACE(jh, "not on transaction");
> -		goto out;
> +		return 0;
>  	}
>  	journal = transaction->t_journal;
>  
> @@ -579,9 +579,9 @@ int __jbd2_journal_remove_checkpoint(struct journal_head *jh)
>  	jh->b_cp_transaction = NULL;
>  	jbd2_journal_put_journal_head(jh);
>  
> -	if (transaction->t_checkpoint_list != NULL ||
> -	    transaction->t_checkpoint_io_list != NULL)
> -		goto out;
> +	/* Is this transaction empty? */
> +	if (transaction->t_checkpoint_list || transaction->t_checkpoint_io_list)
> +		return 0;
>  
>  	/*
>  	 * There is one special case to worry about: if we have just pulled the
> @@ -593,10 +593,12 @@ int __jbd2_journal_remove_checkpoint(struct journal_head *jh)
>  	 * See the comment at the end of jbd2_journal_commit_transaction().
>  	 */
>  	if (transaction->t_state != T_FINISHED)
> -		goto out;
> +		return 0;
>  
> -	/* OK, that was the last buffer for the transaction: we can now
> -	   safely remove this transaction from the log */
> +	/*
> +	 * OK, that was the last buffer for the transaction, we can now
> +	 * safely remove this transaction from the log.
> +	 */
>  	stats = &transaction->t_chp_stats;
>  	if (stats->cs_chp_time)
>  		stats->cs_chp_time = jbd2_time_diff(stats->cs_chp_time,
> @@ -606,9 +608,7 @@ int __jbd2_journal_remove_checkpoint(struct journal_head *jh)
>  
>  	__jbd2_journal_drop_transaction(journal, transaction);
>  	jbd2_journal_free_transaction(transaction);
> -	ret = 1;
> -out:
> -	return ret;
> +	return 1;
>  }
>  
>  /*
> -- 
> 2.25.4
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
