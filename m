Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDEBF6EBDC5
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Apr 2023 09:51:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbjDWHvQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 23 Apr 2023 03:51:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjDWHvP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 23 Apr 2023 03:51:15 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F205D1712;
        Sun, 23 Apr 2023 00:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682236273; x=1713772273;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=hLqzuB/dsyGdPuw8pDlg/eKJWZevKf5YyeT9JmqhmFM=;
  b=g4YkJ+WFyT2Sj6Hhrj+KVRf8j4An1E+SbbBnDk/foFA0Mpr8s/rLtbTz
   UuFvZnC50A1YesDE57eajCm9HHqK4/Mgs5CNdEzQsFiTNpmIUEI8ck/+V
   2PquNEScYFd/ujJM4EDQj+tgBIOBD+gnQiDY8duxcf5NH673oOWGIKeLH
   sGymAV2VAszoHUMOt7yP2Y9ZRh3iMyRyKW57BzgMdUbjfFbV/WLL2ltUx
   ZMCTd6ypUA4Wc7nA+5naOhlxLBX7a8YKuXpUAFhP8wPnk5S1btjHJKY3j
   /XIwdBSsF1OPXSjVlAfeY8N99FP6MOSJP38yDB7LR6w4Xo5/wqxyVXCMY
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10688"; a="325857887"
X-IronPort-AV: E=Sophos;i="5.99,220,1677571200"; 
   d="scan'208";a="325857887"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2023 00:51:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10688"; a="867132673"
X-IronPort-AV: E=Sophos;i="5.99,220,1677571200"; 
   d="scan'208";a="867132673"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2023 00:51:10 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Yu Zhao <yuzhao@google.com>, linux-fsdevel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v2 1/4] mm/filemap: Add folio_lock_timeout()
References: <20230421221249.1616168-1-dianders@chromium.org>
        <20230421151135.v2.1.I2b71e11264c5c214bc59744b9e13e4c353bc5714@changeid>
Date:   Sun, 23 Apr 2023 15:50:01 +0800
In-Reply-To: <20230421151135.v2.1.I2b71e11264c5c214bc59744b9e13e4c353bc5714@changeid>
        (Douglas Anderson's message of "Fri, 21 Apr 2023 15:12:45 -0700")
Message-ID: <87leijkpg6.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Douglas Anderson <dianders@chromium.org> writes:

> Add a variant of folio_lock() that can timeout. This is useful to
> avoid unbounded waits for the page lock in kcompactd.
>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
>
> Changes in v2:
> - "Add folio_lock_timeout()" new for v2.
>
>  include/linux/pagemap.h | 16 ++++++++++++++
>  mm/filemap.c            | 47 +++++++++++++++++++++++++++++------------
>  2 files changed, 50 insertions(+), 13 deletions(-)
>
> diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> index 0acb8e1fb7af..0f3ef9f79300 100644
> --- a/include/linux/pagemap.h
> +++ b/include/linux/pagemap.h
> @@ -892,6 +892,7 @@ static inline bool wake_page_match(struct wait_page_queue *wait_page,
>  }
>  
>  void __folio_lock(struct folio *folio);
> +int __folio_lock_timeout(struct folio *folio, long timeout);
>  int __folio_lock_killable(struct folio *folio);
>  bool __folio_lock_or_retry(struct folio *folio, struct mm_struct *mm,
>  				unsigned int flags);
> @@ -952,6 +953,21 @@ static inline void folio_lock(struct folio *folio)
>  		__folio_lock(folio);
>  }
>  
> +/**
> + * folio_lock_timeout() - Lock this folio, with a timeout.
> + * @folio: The folio to lock.
> + * @timeout: The timeout in jiffies; %MAX_SCHEDULE_TIMEOUT means wait forever.
> + *
> + * Return: 0 upon success; -ETIMEDOUT upon failure.

IIUC, the funtion may return -EINTR too.

Otherwise looks good to me.  Thanks!

Best Regards,
Huang, Ying

> + */
> +static inline int folio_lock_timeout(struct folio *folio, long timeout)
> +{
> +	might_sleep();
> +	if (!folio_trylock(folio))
> +		return __folio_lock_timeout(folio, timeout);
> +	return 0;
> +}
> +
>  /**
>   * lock_page() - Lock the folio containing this page.
>   * @page: The page to lock.
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 2723104cc06a..c6056ec41284 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -1220,7 +1220,7 @@ static inline bool folio_trylock_flag(struct folio *folio, int bit_nr,
>  int sysctl_page_lock_unfairness = 5;
>  
>  static inline int folio_wait_bit_common(struct folio *folio, int bit_nr,
> -		int state, enum behavior behavior)
> +		int state, enum behavior behavior, long timeout)
>  {
>  	wait_queue_head_t *q = folio_waitqueue(folio);
>  	int unfairness = sysctl_page_lock_unfairness;
> @@ -1229,6 +1229,7 @@ static inline int folio_wait_bit_common(struct folio *folio, int bit_nr,
>  	bool thrashing = false;
>  	unsigned long pflags;
>  	bool in_thrashing;
> +	int err;
>  
>  	if (bit_nr == PG_locked &&
>  	    !folio_test_uptodate(folio) && folio_test_workingset(folio)) {
> @@ -1295,10 +1296,13 @@ static inline int folio_wait_bit_common(struct folio *folio, int bit_nr,
>  		/* Loop until we've been woken or interrupted */
>  		flags = smp_load_acquire(&wait->flags);
>  		if (!(flags & WQ_FLAG_WOKEN)) {
> +			if (!timeout)
> +				break;
> +
>  			if (signal_pending_state(state, current))
>  				break;
>  
> -			io_schedule();
> +			timeout = io_schedule_timeout(timeout);
>  			continue;
>  		}
>  
> @@ -1324,10 +1328,10 @@ static inline int folio_wait_bit_common(struct folio *folio, int bit_nr,
>  	}
>  
>  	/*
> -	 * If a signal happened, this 'finish_wait()' may remove the last
> -	 * waiter from the wait-queues, but the folio waiters bit will remain
> -	 * set. That's ok. The next wakeup will take care of it, and trying
> -	 * to do it here would be difficult and prone to races.
> +	 * If a signal/timeout happened, this 'finish_wait()' may remove the
> +	 * last waiter from the wait-queues, but the folio waiters bit will
> +	 * remain set. That's ok. The next wakeup will take care of it, and
> +	 * trying to do it here would be difficult and prone to races.
>  	 */
>  	finish_wait(q, wait);
>  
> @@ -1336,6 +1340,13 @@ static inline int folio_wait_bit_common(struct folio *folio, int bit_nr,
>  		psi_memstall_leave(&pflags);
>  	}
>  
> +	/*
> +	 * If we don't meet the success criteria below then we've got an error
> +	 * of some sort. Differentiate between the two error cases. If there's
> +	 * no time left it must have been a timeout.
> +	 */
> +	err = !timeout ? -ETIMEDOUT : -EINTR;
> +
>  	/*
>  	 * NOTE! The wait->flags weren't stable until we've done the
>  	 * 'finish_wait()', and we could have exited the loop above due
> @@ -1350,9 +1361,9 @@ static inline int folio_wait_bit_common(struct folio *folio, int bit_nr,
>  	 * waiter, but an exclusive one requires WQ_FLAG_DONE.
>  	 */
>  	if (behavior == EXCLUSIVE)
> -		return wait->flags & WQ_FLAG_DONE ? 0 : -EINTR;
> +		return wait->flags & WQ_FLAG_DONE ? 0 : err;
>  
> -	return wait->flags & WQ_FLAG_WOKEN ? 0 : -EINTR;
> +	return wait->flags & WQ_FLAG_WOKEN ? 0 : err;
>  }
>  
>  #ifdef CONFIG_MIGRATION
> @@ -1442,13 +1453,15 @@ void migration_entry_wait_on_locked(swp_entry_t entry, pte_t *ptep,
>  
>  void folio_wait_bit(struct folio *folio, int bit_nr)
>  {
> -	folio_wait_bit_common(folio, bit_nr, TASK_UNINTERRUPTIBLE, SHARED);
> +	folio_wait_bit_common(folio, bit_nr, TASK_UNINTERRUPTIBLE, SHARED,
> +			      MAX_SCHEDULE_TIMEOUT);
>  }
>  EXPORT_SYMBOL(folio_wait_bit);
>  
>  int folio_wait_bit_killable(struct folio *folio, int bit_nr)
>  {
> -	return folio_wait_bit_common(folio, bit_nr, TASK_KILLABLE, SHARED);
> +	return folio_wait_bit_common(folio, bit_nr, TASK_KILLABLE, SHARED,
> +				     MAX_SCHEDULE_TIMEOUT);
>  }
>  EXPORT_SYMBOL(folio_wait_bit_killable);
>  
> @@ -1467,7 +1480,8 @@ EXPORT_SYMBOL(folio_wait_bit_killable);
>   */
>  static int folio_put_wait_locked(struct folio *folio, int state)
>  {
> -	return folio_wait_bit_common(folio, PG_locked, state, DROP);
> +	return folio_wait_bit_common(folio, PG_locked, state, DROP,
> +				     MAX_SCHEDULE_TIMEOUT);
>  }
>  
>  /**
> @@ -1662,17 +1676,24 @@ EXPORT_SYMBOL_GPL(page_endio);
>  void __folio_lock(struct folio *folio)
>  {
>  	folio_wait_bit_common(folio, PG_locked, TASK_UNINTERRUPTIBLE,
> -				EXCLUSIVE);
> +				EXCLUSIVE, MAX_SCHEDULE_TIMEOUT);
>  }
>  EXPORT_SYMBOL(__folio_lock);
>  
>  int __folio_lock_killable(struct folio *folio)
>  {
>  	return folio_wait_bit_common(folio, PG_locked, TASK_KILLABLE,
> -					EXCLUSIVE);
> +					EXCLUSIVE, MAX_SCHEDULE_TIMEOUT);
>  }
>  EXPORT_SYMBOL_GPL(__folio_lock_killable);
>  
> +int __folio_lock_timeout(struct folio *folio, long timeout)
> +{
> +	return folio_wait_bit_common(folio, PG_locked, TASK_KILLABLE,
> +					EXCLUSIVE, timeout);
> +}
> +EXPORT_SYMBOL_GPL(__folio_lock_timeout);
> +
>  static int __folio_lock_async(struct folio *folio, struct wait_page_queue *wait)
>  {
>  	struct wait_queue_head *q = folio_waitqueue(folio);
