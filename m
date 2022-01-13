Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9322B48D6B0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jan 2022 12:30:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234184AbiAMLax (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Jan 2022 06:30:53 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:46446 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230283AbiAMLaw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Jan 2022 06:30:52 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 861181F3A5;
        Thu, 13 Jan 2022 11:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1642073451; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=knNxTHuHCUWy+TfikTNU9RikhIY8xv43/13z9bJTOUE=;
        b=hPdAG+6sEAbjAcgtqa89wm7DgwL8JgdEyvPYxKcqohHVkCH/gjeus+5xKe4Z+jBtifr8gT
        sS5iyvLPxGb5VRDeOxFyCMG2sYOsTY+a5B7mj2hzB/bwj2Qn1nBy7Bruz68U1jrXWTsrK6
        NIxnXAhHdzFOZlrEfRmbM2Hkm02J3kE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1642073451;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=knNxTHuHCUWy+TfikTNU9RikhIY8xv43/13z9bJTOUE=;
        b=ByKIMFrBvSO/sVz8lPoa39xOYyxeqYwimGsvQdry6rrvuIYkGSP/fegbtaLrTFBQYEIWbX
        Qr3a96MQCvZ1xaBw==
Received: from quack3.suse.cz (unknown [10.163.28.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 72926A3B87;
        Thu, 13 Jan 2022 11:30:51 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 317CAA05E2; Thu, 13 Jan 2022 12:30:51 +0100 (CET)
Date:   Thu, 13 Jan 2022 12:30:51 +0100
From:   Jan Kara <jack@suse.cz>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jan Kara <jack@suse.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>, tytso@mit.edu,
        Eric Whitney <enwlinux@gmail.com>
Subject: Re: [PATCH 5/6] jbd2: Refactor wait logic for transaction updates
 into a common function
Message-ID: <20220113113051.5ehxl2ap3v64eyya@quack3.lan>
References: <cover.1642044249.git.riteshh@linux.ibm.com>
 <95fa94cbeb4bb0275430a6721a588bd738d5a9aa.1642044249.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <95fa94cbeb4bb0275430a6721a588bd738d5a9aa.1642044249.git.riteshh@linux.ibm.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 13-01-22 08:56:28, Ritesh Harjani wrote:
> No functionality change as such in this patch. This only refactors the
> common piece of code which waits for t_updates to finish into a common
> function named as jbd2_journal_wait_updates(journal_t *)
> 
> Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>

Just one nit, otherwise. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

> @@ -1757,6 +1757,35 @@ static inline unsigned long jbd2_log_space_left(journal_t *journal)
>  	return max_t(long, free, 0);
>  }
>  
> +/*
> + * Waits for any outstanding t_updates to finish.
> + * This is called with write j_state_lock held.
> + */
> +static inline void jbd2_journal_wait_updates(journal_t *journal)
> +{
> +	transaction_t *commit_transaction = journal->j_running_transaction;
> +
> +	if (!commit_transaction)
> +		return;
> +
> +	spin_lock(&commit_transaction->t_handle_lock);
> +	while (atomic_read(&commit_transaction->t_updates)) {
> +		DEFINE_WAIT(wait);
> +
> +		prepare_to_wait(&journal->j_wait_updates, &wait,
> +					TASK_UNINTERRUPTIBLE);
> +		if (atomic_read(&commit_transaction->t_updates)) {
> +			spin_unlock(&commit_transaction->t_handle_lock);
> +			write_unlock(&journal->j_state_lock);
> +			schedule();
> +			write_lock(&journal->j_state_lock);
> +			spin_lock(&commit_transaction->t_handle_lock);
> +		}
> +		finish_wait(&journal->j_wait_updates, &wait);
> +	}
> +	spin_unlock(&commit_transaction->t_handle_lock);
> +}
> +

I don't think making this inline makes sence. Neither the commit code nor
jbd2_journal_lock_updates() are so hot that it would warrant this large
inline function...

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
