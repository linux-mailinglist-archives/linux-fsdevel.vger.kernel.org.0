Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1BDB7E09C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2019 18:55:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733213AbfHAQzM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Aug 2019 12:55:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:34102 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1733208AbfHAQzM (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Aug 2019 12:55:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6893DAECA;
        Thu,  1 Aug 2019 16:55:10 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 6CC5D1E3F4D; Thu,  1 Aug 2019 11:22:23 +0200 (CEST)
Date:   Thu, 1 Aug 2019 11:22:23 +0200
From:   Jan Kara <jack@suse.cz>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Julia Cartwright <julia@ni.com>, Jan Kara <jack@suse.com>,
        linux-ext4@vger.kernel.org, Theodore Tso <tytso@mit.edu>,
        Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, Mark Fasheh <mark@fasheh.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Joel Becker <jlbec@evilplan.org>
Subject: Re: [patch V2 7/7] fs/jbd2: Free journal head outside of locked
 region
Message-ID: <20190801092223.GG25064@quack2.suse.cz>
References: <20190801010126.245731659@linutronix.de>
 <20190801010944.549462805@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190801010944.549462805@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 01-08-19 03:01:33, Thomas Gleixner wrote:
> On PREEMPT_RT bit-spinlocks have the same semantics as on PREEMPT_RT=n,
> i.e. they disable preemption. That means functions which are not safe to be
> called in preempt disabled context on RT trigger a might_sleep() assert.
> 
> The journal head bit spinlock is mostly held for short code sequences with
> trivial RT safe functionality, except for one place:
> 
> jbd2_journal_put_journal_head() invokes __journal_remove_journal_head()
> with the journal head bit spinlock held. __journal_remove_journal_head()
> invokes kmem_cache_free() which must not be called with preemption disabled
> on RT.
> 
> Jan suggested to rework the removal function so the actual free happens
> outside the bit-spinlocked region.
> 
> Split it into two parts:
> 
>   - Do the sanity checks and the buffer head detach under the lock
> 
>   - Do the actual free after dropping the lock
> 
> There is error case handling in the free part which needs to dereference
> the b_size field of the now detached buffer head. Due to paranoia (caused
> by ignorance) the size is retrieved in the detach function and handed into
> the free function. Might be over-engineered, but better safe than sorry.
> 
> This makes the journal head bit-spinlock usage RT compliant and also avoids
> nested locking which is not covered by lockdep.
> 
> Suggested-by: Jan Kara <jack@suse.com>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: linux-ext4@vger.kernel.org
> Cc: "Theodore Ts'o" <tytso@mit.edu>
> Cc: Jan Kara <jack@suse.com>

Looks mostly good. Just a small suggestion for simplification below:

> @@ -2559,11 +2568,14 @@ void jbd2_journal_put_journal_head(struc
>  	J_ASSERT_JH(jh, jh->b_jcount > 0);
>  	--jh->b_jcount;
>  	if (!jh->b_jcount) {
> -		__journal_remove_journal_head(bh);
> +		size_t b_size = __journal_remove_journal_head(bh);
> +
>  		jbd_unlock_bh_journal_head(bh);
> +		journal_release_journal_head(jh, b_size);
>  		__brelse(bh);

The bh is pinned until you call __brelse(bh) above and bh->b_size doesn't
change during the lifetime of the buffer. So there's no need of
fetching bh->b_size in __journal_remove_journal_head() and passing it back.
You can just:

		journal_release_journal_head(jh, bh->b_size);

> -	} else
> +	} else {
>  		jbd_unlock_bh_journal_head(bh);
> +	}
>  }
>  

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
