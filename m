Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A4177DA54
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2019 13:29:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731033AbfHAL31 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Aug 2019 07:29:27 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45814 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730946AbfHAL31 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Aug 2019 07:29:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ksRJLOMTOIWRq2Nag2thMkKvE3lWaLrnStcxxBgysnw=; b=Wjf8pXawCgcKFVf3bV3iZbnJj
        rX+WDMifwGDiVc6ecMzHbsMT/+jfAGFFMugdHvw6yBSTK2tn/Q2Syt1Nwxm9oCCVHkDM78I/RIZUk
        2m7+IzAEQpvn/0rkMsTYP3zgSsxUxl05sRnKRrkqE9q2n46dcLvOao+xLjN4Q3wAYafVTbDxZFd7z
        UmhJLhJPbpNXPZishSqd2zv3poZ1lQ1U0UsPMZ9mCaz9/iLnd/tJwBaSsLDdYfcOGixo7gWzMT8DD
        Ff36e4PoTKL35KsJGZCYslDjYcnwWBiXJDap1Co63OVM8uSON30wBYA7ntBMnnquigXHA15H7/BFi
        cOaFb6Z6w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1ht9GN-0001Zu-6n; Thu, 01 Aug 2019 11:28:51 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9B7432029F4C7; Thu,  1 Aug 2019 13:28:49 +0200 (CEST)
Date:   Thu, 1 Aug 2019 13:28:49 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Julia Cartwright <julia@ni.com>, Jan Kara <jack@suse.com>,
        Theodore Tso <tytso@mit.edu>, Mark Fasheh <mark@fasheh.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Joel Becker <jlbec@evilplan.org>, linux-ext4@vger.kernel.org,
        Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [patch V2 6/7] fs/jbd2: Make state lock a spinlock
Message-ID: <20190801112849.GB31381@hirez.programming.kicks-ass.net>
References: <20190801010126.245731659@linutronix.de>
 <20190801010944.457499601@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190801010944.457499601@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 01, 2019 at 03:01:32AM +0200, Thomas Gleixner wrote:

> @@ -1931,7 +1932,7 @@ static void __jbd2_journal_temp_unlink_b
>  	transaction_t *transaction;
>  	struct buffer_head *bh = jh2bh(jh);
>  
> -	J_ASSERT_JH(jh, jbd_is_locked_bh_state(bh));
> +	assert_spin_locked(&jh->state_lock);
>  	transaction = jh->b_transaction;
>  	if (transaction)
>  		assert_spin_locked(&transaction->t_journal->j_list_lock);

> @@ -2415,7 +2416,7 @@ void __jbd2_journal_file_buffer(struct j
>  	int was_dirty = 0;
>  	struct buffer_head *bh = jh2bh(jh);
>  
> -	J_ASSERT_JH(jh, jbd_is_locked_bh_state(bh));
> +	assert_spin_locked(&jh->state_lock);
>  	assert_spin_locked(&transaction->t_journal->j_list_lock);
>  
>  	J_ASSERT_JH(jh, jh->b_jlist < BJ_Types);

> @@ -2500,7 +2501,7 @@ void __jbd2_journal_refile_buffer(struct
>  	int was_dirty, jlist;
>  	struct buffer_head *bh = jh2bh(jh);
>  
> -	J_ASSERT_JH(jh, jbd_is_locked_bh_state(bh));
> +	assert_spin_locked(&jh->state_lock);
>  	if (jh->b_transaction)
>  		assert_spin_locked(&jh->b_transaction->t_journal->j_list_lock);
>  

Do those want to be:

  lockdep_assert_held(&jh->state_lock);

instead? The difference is of course that lockdep_assert_held() requires
the current context to hold the lock, where assert_*_locked() merely
checks _someone_ holds it.
