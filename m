Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A68848D6A6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jan 2022 12:27:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234143AbiAML1v (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Jan 2022 06:27:51 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:46128 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230283AbiAML1u (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Jan 2022 06:27:50 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 858EC1F387;
        Thu, 13 Jan 2022 11:27:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1642073269; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LyGhN7hblXB7OSogHgGIQp9mGn45dx0dO14tJWAFnYQ=;
        b=iRO0oF76FHvA3jwng5an+CJn/ltBuOQZyF881Dv93bS2hDqiESIvHK5nfCcwxrHygYLr4+
        zB+wW44O8FIxDL7qCMPtls2taxwVEJCTufTuK9WuUI3VjTxy4cWbNC92Y+1J/B7hdrlWmC
        YKfRqZhNheOK9527IQCZX5m3jpNPmDY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1642073269;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LyGhN7hblXB7OSogHgGIQp9mGn45dx0dO14tJWAFnYQ=;
        b=FFxcOOpTXVSqzs602md/Ux8LTX6kFiJQ/Z0d26owzBBf6V2PqP1/mD1yWwHyrGfi2B8E/0
        3F4aRUnFAhPjNdBQ==
Received: from quack3.suse.cz (unknown [10.163.28.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 72FBFA3B85;
        Thu, 13 Jan 2022 11:27:49 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 235C1A05E2; Thu, 13 Jan 2022 12:27:49 +0100 (CET)
Date:   Thu, 13 Jan 2022 12:27:49 +0100
From:   Jan Kara <jack@suse.cz>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jan Kara <jack@suse.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>, tytso@mit.edu,
        Eric Whitney <enwlinux@gmail.com>
Subject: Re: [PATCH 6/6] jbd2: No need to use t_handle_lock in
 jbd2_journal_wait_updates
Message-ID: <20220113112749.d5tfszcksvxvshnn@quack3.lan>
References: <cover.1642044249.git.riteshh@linux.ibm.com>
 <e7e0f8c54306591a3a9c8fead1e0e54358052ab6.1642044249.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e7e0f8c54306591a3a9c8fead1e0e54358052ab6.1642044249.git.riteshh@linux.ibm.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 13-01-22 08:56:29, Ritesh Harjani wrote:
> Since jbd2_journal_wait_updates() uses waitq based on t_updates atomic_t
> variable. So from code review it looks like we don't need to use
> t_handle_lock spinlock for checking t_updates value.
> Hence this patch gets rid of the spinlock protection in
> jbd2_journal_wait_updates()
> 
> Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>

This patch looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

Actually looking at it, t_handle_lock seems to be very much unused. I agree
we don't need it when waiting for outstanding handles but the only
remaining uses are:

1) jbd2_journal_extend() where it is not needed either - we use
atomic_add_return() to manipulate t_outstanding_credits and hold
j_state_lock for reading which provides us enough exclusion.

2) update_t_max_wait() - this is the only valid use of t_handle_lock but we
can just switch it to cmpxchg loop with a bit of care. Something like:

	unsigned long old;

	ts = jbd2_time_diff(ts, transaction->t_start);
	old = transaction->t_max_wait;
	while (old < ts)
		old = cmpxchg(&transaction->t_max_wait, old, ts);

So perhaps you can add two more patches to remove other t_handle_lock uses
and drop it completely.

								Honza

> ---
>  include/linux/jbd2.h | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
> index 34b051aa9009..9bef47622b9d 100644
> --- a/include/linux/jbd2.h
> +++ b/include/linux/jbd2.h
> @@ -1768,22 +1768,18 @@ static inline void jbd2_journal_wait_updates(journal_t *journal)
>  	if (!commit_transaction)
>  		return;
>  
> -	spin_lock(&commit_transaction->t_handle_lock);
>  	while (atomic_read(&commit_transaction->t_updates)) {
>  		DEFINE_WAIT(wait);
>  
>  		prepare_to_wait(&journal->j_wait_updates, &wait,
>  					TASK_UNINTERRUPTIBLE);
>  		if (atomic_read(&commit_transaction->t_updates)) {
> -			spin_unlock(&commit_transaction->t_handle_lock);
>  			write_unlock(&journal->j_state_lock);
>  			schedule();
>  			write_lock(&journal->j_state_lock);
> -			spin_lock(&commit_transaction->t_handle_lock);
>  		}
>  		finish_wait(&journal->j_wait_updates, &wait);
>  	}
> -	spin_unlock(&commit_transaction->t_handle_lock);
>  }
>  
>  /*
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
