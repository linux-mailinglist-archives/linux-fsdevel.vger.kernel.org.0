Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A8557D832
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2019 11:04:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731006AbfHAJE2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Aug 2019 05:04:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:33058 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729084AbfHAJE2 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Aug 2019 05:04:28 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1AEA5AC63;
        Thu,  1 Aug 2019 09:04:27 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 4EC4E1E3F4D; Thu,  1 Aug 2019 11:04:26 +0200 (CEST)
Date:   Thu, 1 Aug 2019 11:04:26 +0200
From:   Jan Kara <jack@suse.cz>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Julia Cartwright <julia@ni.com>, linux-ext4@vger.kernel.org,
        Theodore Tso <tytso@mit.edu>, Jan Kara <jack@suse.com>,
        Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, Mark Fasheh <mark@fasheh.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Joel Becker <jlbec@evilplan.org>
Subject: Re: [patch V2 5/7] fs/jbd2: Simplify journal_unmap_buffer()
Message-ID: <20190801090426.GF25064@quack2.suse.cz>
References: <20190801010126.245731659@linutronix.de>
 <20190801010944.364767635@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190801010944.364767635@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 01-08-19 03:01:31, Thomas Gleixner wrote:
> journal_unmap_buffer() checks first whether the buffer head is a journal.
> If so it takes locks and then invokes jbd2_journal_grab_journal_head()
> followed by another check whether this is journal head buffer.
> 
> The double checking is pointless.
> 
> Replace the initial check with jbd2_journal_grab_journal_head() which
> alredy checks whether the buffer head is actually a journal.
> 
> Allows also early access to the journal head pointer for the upcoming
> conversion of state lock to a regular spinlock.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: linux-ext4@vger.kernel.org
> Cc: "Theodore Ts'o" <tytso@mit.edu>
> Cc: Jan Kara <jack@suse.com>

Nice simplification. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
> V2: New patch
> ---
>  fs/jbd2/transaction.c |    8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> --- a/fs/jbd2/transaction.c
> +++ b/fs/jbd2/transaction.c
> @@ -2196,7 +2196,8 @@ static int journal_unmap_buffer(journal_
>  	 * holding the page lock. --sct
>  	 */
>  
> -	if (!buffer_jbd(bh))
> +	jh = jbd2_journal_grab_journal_head(bh);
> +	if (!jh)
>  		goto zap_buffer_unlocked;
>  
>  	/* OK, we have data buffer in journaled mode */
> @@ -2204,10 +2205,6 @@ static int journal_unmap_buffer(journal_
>  	jbd_lock_bh_state(bh);
>  	spin_lock(&journal->j_list_lock);
>  
> -	jh = jbd2_journal_grab_journal_head(bh);
> -	if (!jh)
> -		goto zap_buffer_no_jh;
> -
>  	/*
>  	 * We cannot remove the buffer from checkpoint lists until the
>  	 * transaction adding inode to orphan list (let's call it T)
> @@ -2329,7 +2326,6 @@ static int journal_unmap_buffer(journal_
>  	 */
>  	jh->b_modified = 0;
>  	jbd2_journal_put_journal_head(jh);
> -zap_buffer_no_jh:
>  	spin_unlock(&journal->j_list_lock);
>  	jbd_unlock_bh_state(bh);
>  	write_unlock(&journal->j_state_lock);
> 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
