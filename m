Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C12606EBE15
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Apr 2023 10:49:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbjDWItL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 23 Apr 2023 04:49:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjDWItK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 23 Apr 2023 04:49:10 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 314DB1726;
        Sun, 23 Apr 2023 01:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682239749; x=1713775749;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=SVZBxnuP4vBlqDAzvKI6hIM4GkXNlEyFfSy/CkYXJ7w=;
  b=YxfZlPmJFokwDKZ3WvY6N266OkxHZ9fJF0/7E20kxDNVKOEjgy+htF7+
   UQA0lOVIOkS81WpSpYw++tvfrV3TwKOHETx7aoAGE1aZAE5Um3czKkrfX
   kplFXiMkEdKh/9AQe2UpGyx94Lj0Yv0Jd4jWxbbjo9MAdupBY3h5SciG1
   t9cKY2u/y9ccALPev3tdZbptFOYjHuBx2mNLekAIejXMp5rNLL+XeLvU6
   INBrbFeQMVDv3EfwLDCSidCRD0iEUuJBmNklO7uvyPOnhaS3wJ+QybT8c
   KhEByZ/EeY8n9wnFP4Tm+7e3A0mMCbPQQQCkyVhO18RCK6+JrTSt68gv6
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10688"; a="326585497"
X-IronPort-AV: E=Sophos;i="5.99,220,1677571200"; 
   d="scan'208";a="326585497"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2023 01:49:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10688"; a="686359883"
X-IronPort-AV: E=Sophos;i="5.99,220,1677571200"; 
   d="scan'208";a="686359883"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2023 01:49:02 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Yu Zhao <yuzhao@google.com>, linux-fsdevel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>, Jan Kara <jack@suse.cz>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Valentin Schneider <vschneid@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Will Deacon <will@kernel.org>, Zhang Yi <yi.zhang@huawei.com>
Subject: Re: [PATCH v2 2/4] buffer: Add lock_buffer_timeout()
In-Reply-To: <20230421151135.v2.2.Ie146eec4d41480ebeb15f0cfdfb3bc9095e4ebd9@changeid>
        (Douglas Anderson's message of "Fri, 21 Apr 2023 15:12:46 -0700")
References: <20230421221249.1616168-1-dianders@chromium.org>
        <20230421151135.v2.2.Ie146eec4d41480ebeb15f0cfdfb3bc9095e4ebd9@changeid>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
Date:   Sun, 23 Apr 2023 16:47:58 +0800
Message-ID: <87bkjfkmrl.fsf@yhuang6-desk2.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Douglas Anderson <dianders@chromium.org> writes:

> Add a variant of lock_buffer() that can timeout. This is useful to
> avoid unbounded waits for the page lock in kcompactd.
>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
>
> Changes in v2:
> - "Add lock_buffer_timeout()" new for v2.
>
>  fs/buffer.c                 |  7 +++++++
>  include/linux/buffer_head.h | 10 ++++++++++
>  include/linux/wait_bit.h    | 24 ++++++++++++++++++++++++
>  kernel/sched/wait_bit.c     | 14 ++++++++++++++
>  4 files changed, 55 insertions(+)
>
> diff --git a/fs/buffer.c b/fs/buffer.c
> index 9e1e2add541e..fcd19c270024 100644
> --- a/fs/buffer.c
> +++ b/fs/buffer.c
> @@ -71,6 +71,13 @@ void __lock_buffer(struct buffer_head *bh)
>  }
>  EXPORT_SYMBOL(__lock_buffer);
>  
> +int __lock_buffer_timeout(struct buffer_head *bh, unsigned long timeout)
> +{
> +	return wait_on_bit_lock_io_timeout(&bh->b_state, BH_Lock,
> +					   TASK_UNINTERRUPTIBLE, timeout);
> +}
> +EXPORT_SYMBOL(__lock_buffer_timeout);
> +
>  void unlock_buffer(struct buffer_head *bh)
>  {
>  	clear_bit_unlock(BH_Lock, &bh->b_state);
> diff --git a/include/linux/buffer_head.h b/include/linux/buffer_head.h
> index 8f14dca5fed7..2bae464f89d5 100644
> --- a/include/linux/buffer_head.h
> +++ b/include/linux/buffer_head.h
> @@ -237,6 +237,7 @@ struct buffer_head *alloc_buffer_head(gfp_t gfp_flags);
>  void free_buffer_head(struct buffer_head * bh);
>  void unlock_buffer(struct buffer_head *bh);
>  void __lock_buffer(struct buffer_head *bh);
> +int __lock_buffer_timeout(struct buffer_head *bh, unsigned long timeout);
>  int sync_dirty_buffer(struct buffer_head *bh);
>  int __sync_dirty_buffer(struct buffer_head *bh, blk_opf_t op_flags);
>  void write_dirty_buffer(struct buffer_head *bh, blk_opf_t op_flags);
> @@ -400,6 +401,15 @@ static inline void lock_buffer(struct buffer_head *bh)
>  		__lock_buffer(bh);
>  }
>  
> +static inline int lock_buffer_timeout(struct buffer_head *bh,
> +				      unsigned long timeout)
> +{
> +	might_sleep();
> +	if (!trylock_buffer(bh))
> +		return __lock_buffer_timeout(bh, timeout);
> +	return 0;
> +}
> +

Add document about return value of lock_buffer_timeout()?

Otherwise looks good to me.

Best Regards,
Huang, Ying

>  static inline struct buffer_head *getblk_unmovable(struct block_device *bdev,
>  						   sector_t block,
>  						   unsigned size)
> diff --git a/include/linux/wait_bit.h b/include/linux/wait_bit.h
> index 7725b7579b78..33f0f60b1c8c 100644
> --- a/include/linux/wait_bit.h
> +++ b/include/linux/wait_bit.h
> @@ -30,6 +30,7 @@ void wake_up_bit(void *word, int bit);
>  int out_of_line_wait_on_bit(void *word, int, wait_bit_action_f *action, unsigned int mode);
>  int out_of_line_wait_on_bit_timeout(void *word, int, wait_bit_action_f *action, unsigned int mode, unsigned long timeout);
>  int out_of_line_wait_on_bit_lock(void *word, int, wait_bit_action_f *action, unsigned int mode);
> +int out_of_line_wait_on_bit_lock_timeout(void *word, int, wait_bit_action_f *action, unsigned int mode, unsigned long timeout);
>  struct wait_queue_head *bit_waitqueue(void *word, int bit);
>  extern void __init wait_bit_init(void);
>  
> @@ -208,6 +209,29 @@ wait_on_bit_lock_io(unsigned long *word, int bit, unsigned mode)
>  	return out_of_line_wait_on_bit_lock(word, bit, bit_wait_io, mode);
>  }
>  
> +/**
> + * wait_on_bit_lock_io_timeout - wait_on_bit_lock_io() with a timeout
> + * @word: the word being waited on, a kernel virtual address
> + * @bit: the bit of the word being waited on
> + * @mode: the task state to sleep in
> + * @timeout: the timeout in jiffies; %MAX_SCHEDULE_TIMEOUT means wait forever
> + *
> + * Returns zero if the bit was (eventually) found to be clear and was
> + * set.  Returns non-zero if a timeout happened or a signal was delivered to
> + * the process and the @mode allows that signal to wake the process.
> + */
> +static inline int
> +wait_on_bit_lock_io_timeout(unsigned long *word, int bit, unsigned mode,
> +			    unsigned long timeout)
> +{
> +	might_sleep();
> +	if (!test_and_set_bit(bit, word))
> +		return 0;
> +	return out_of_line_wait_on_bit_lock_timeout(word, bit,
> +						    bit_wait_io_timeout,
> +						    mode, timeout);
> +}
> +
>  /**
>   * wait_on_bit_lock_action - wait for a bit to be cleared, when wanting to set it
>   * @word: the word being waited on, a kernel virtual address
> diff --git a/kernel/sched/wait_bit.c b/kernel/sched/wait_bit.c
> index 0b1cd985dc27..629acd1c6c79 100644
> --- a/kernel/sched/wait_bit.c
> +++ b/kernel/sched/wait_bit.c
> @@ -118,6 +118,20 @@ int __sched out_of_line_wait_on_bit_lock(void *word, int bit,
>  }
>  EXPORT_SYMBOL(out_of_line_wait_on_bit_lock);
>  
> +int __sched out_of_line_wait_on_bit_lock_timeout(void *word, int bit,
> +						 wait_bit_action_f *action,
> +						 unsigned mode,
> +						 unsigned long timeout)
> +{
> +	struct wait_queue_head *wq_head = bit_waitqueue(word, bit);
> +	DEFINE_WAIT_BIT(wq_entry, word, bit);
> +
> +	wq_entry.key.timeout = jiffies + timeout;
> +
> +	return __wait_on_bit_lock(wq_head, &wq_entry, action, mode);
> +}
> +EXPORT_SYMBOL(out_of_line_wait_on_bit_lock_timeout);
> +
>  void __wake_up_bit(struct wait_queue_head *wq_head, void *word, int bit)
>  {
>  	struct wait_bit_key key = __WAIT_BIT_KEY_INITIALIZER(word, bit);
