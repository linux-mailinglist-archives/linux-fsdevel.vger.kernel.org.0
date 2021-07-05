Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24D2D3BBAA8
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Jul 2021 11:59:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230450AbhGEKBh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Jul 2021 06:01:37 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:41924 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbhGEKBg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Jul 2021 06:01:36 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 5BFDF22667;
        Mon,  5 Jul 2021 09:58:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1625479139; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JURz8cTHFUcitamF477u1DRonwG3FVDJaV2V9oytrAU=;
        b=dgt+T8jKpZooIm0VAFwjrxADCR2sdhMHBm7UC/BMS1kx0ZoQF1bc+dawUaOrH+bdkXu5uG
        1OFfkZEwem7kNOAHIAUiayRKItOMY2Gu6Kyq9uooR4EkKl6i5KGVcIYwglgd5sydhwf6ap
        URy/YI8+oI4Fbrnrn/pGvnAzrn3HdIo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1625479139;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JURz8cTHFUcitamF477u1DRonwG3FVDJaV2V9oytrAU=;
        b=MVtxSL0toIKNMQ+DjszyIpNU2N43r3KytBsnZ4Uq/IuUHwcewh96YcG06cjWkOVyQvNzvs
        DuHvCfH6OHi4x1DA==
Received: from quack2.suse.cz (unknown [10.163.43.118])
        by relay2.suse.de (Postfix) with ESMTP id 3DEC9A3B93;
        Mon,  5 Jul 2021 09:58:59 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 1035B1E1139; Mon,  5 Jul 2021 11:58:59 +0200 (CEST)
Date:   Mon, 5 Jul 2021 11:58:59 +0200
From:   Jan Kara <jack@suse.cz>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Zhang Yi <yi.zhang@huawei.com>, Jan Kara <jack@suse.cz>,
        linuxppc-dev@lists.ozlabs.org,
        Guoqing Jiang <guoqing.jiang@linux.dev>,
        Sachin Sant <sachinp@linux.vnet.ibm.com>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [powerpc][5.13.0-next-20210701] Kernel crash while running
 ltp(chdir01) tests
Message-ID: <20210705095859.GB15373@quack2.suse.cz>
References: <26ACA75D-E13D-405B-9BFC-691B5FB64243@linux.vnet.ibm.com>
 <bf1c5b38-92f1-65db-e210-a97a199718ba@linux.dev>
 <4cc87ab3-aaa6-ed87-b690-5e5b99de8380@huawei.com>
 <03f734bd-f36e-f55b-0448-485b8a0d5b75@huawei.com>
 <YN86yl5kgVaRixxQ@mit.edu>
 <36778615-86fd-9a19-9bc9-f93a6f2d5817@huawei.com>
 <YN/a70ucYXu0DqGf@mit.edu>
 <66fb56cd-f1ff-c592-0202-0691372e32f5@huawei.com>
 <YOG/5ZY1AL05jumi@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YOG/5ZY1AL05jumi@mit.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun 04-07-21 10:04:21, Theodore Ts'o wrote:
> On Sat, Jul 03, 2021 at 12:55:09PM +0800, Zhang Yi wrote:
> > Yeah, it sounds good to me. Do you want me to send the fix patch, or you
> > modify your commit 8f9e16badb8fd in another email directly?
> 
> I've gone ahead and made the changes; what do you think?
> 
> I like how it also removes 40 lines of code.  :-)
> 
>      	  	    	     	      	   - Ted
> 
> From ef3130d1b0b8ca769252d6a722a2e59a00141383 Mon Sep 17 00:00:00 2001
> From: Theodore Ts'o <tytso@mit.edu>
> Date: Fri, 2 Jul 2021 18:05:03 -0400
> Subject: [PATCH] ext4: inline jbd2_journal_[un]register_shrinker()
> 
> The function jbd2_journal_unregister_shrinker() was getting called
> twice when the file system was getting unmounted.  On Power and ARM
> platforms this was causing kernel crash when unmounting the file
> system, when a percpu_counter was destroyed twice.
> 
> Fix this by removing jbd2_journal_[un]register_shrinker() functions,
> and inlining the shrinker setup and teardown into
> journal_init_common() and jbd2_journal_destroy().  This means that
> ext4 and ocfs2 now no longer need to know about registering and
> unregistering jbd2's shrinker.
> 
> Also, while we're at it, rename the percpu counter from
> j_jh_shrink_count to j_checkpoint_jh_count, since this makes it
> clearer what this counter is intended to track.
> 
> Fixes: 4ba3fcdde7e3 ("jbd2,ext4: add a shrinker to release checkpointed buffers")
> Reported-by: Sachin Sant <sachinp@linux.vnet.ibm.com>
> Reported-by: Jon Hunter <jonathanh@nvidia.com>
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>

Except for the bug Zhang Yi noticed the patch looks good to me. Feel free
to add:

Reviewed-by: Jan Kara <jack@suse.cz>

after fixing that.

								Honza


> ---
>  fs/ext4/super.c      |   8 ---
>  fs/jbd2/checkpoint.c |   4 +-
>  fs/jbd2/journal.c    | 148 +++++++++++++++++--------------------------
>  include/linux/jbd2.h |   6 +-
>  4 files changed, 63 insertions(+), 103 deletions(-)
> 
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index b8ff0399e171..dfa09a277b56 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -1184,7 +1184,6 @@ static void ext4_put_super(struct super_block *sb)
>  	ext4_unregister_sysfs(sb);
>  
>  	if (sbi->s_journal) {
> -		jbd2_journal_unregister_shrinker(sbi->s_journal);
>  		aborted = is_journal_aborted(sbi->s_journal);
>  		err = jbd2_journal_destroy(sbi->s_journal);
>  		sbi->s_journal = NULL;
> @@ -5176,7 +5175,6 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
>  	sbi->s_ea_block_cache = NULL;
>  
>  	if (sbi->s_journal) {
> -		jbd2_journal_unregister_shrinker(sbi->s_journal);
>  		jbd2_journal_destroy(sbi->s_journal);
>  		sbi->s_journal = NULL;
>  	}
> @@ -5502,12 +5500,6 @@ static int ext4_load_journal(struct super_block *sb,
>  		ext4_commit_super(sb);
>  	}
>  
> -	err = jbd2_journal_register_shrinker(journal);
> -	if (err) {
> -		EXT4_SB(sb)->s_journal = NULL;
> -		goto err_out;
> -	}
> -
>  	return 0;
>  
>  err_out:
> diff --git a/fs/jbd2/checkpoint.c b/fs/jbd2/checkpoint.c
> index 51d1eb2ffeb9..746132998c57 100644
> --- a/fs/jbd2/checkpoint.c
> +++ b/fs/jbd2/checkpoint.c
> @@ -701,7 +701,7 @@ int __jbd2_journal_remove_checkpoint(struct journal_head *jh)
>  
>  	__buffer_unlink(jh);
>  	jh->b_cp_transaction = NULL;
> -	percpu_counter_dec(&journal->j_jh_shrink_count);
> +	percpu_counter_dec(&journal->j_checkpoint_jh_count);
>  	jbd2_journal_put_journal_head(jh);
>  
>  	/* Is this transaction empty? */
> @@ -764,7 +764,7 @@ void __jbd2_journal_insert_checkpoint(struct journal_head *jh,
>  		jh->b_cpnext->b_cpprev = jh;
>  	}
>  	transaction->t_checkpoint_list = jh;
> -	percpu_counter_inc(&transaction->t_journal->j_jh_shrink_count);
> +	percpu_counter_inc(&transaction->t_journal->j_checkpoint_jh_count);
>  }
>  
>  /*
> diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
> index 152880c298ca..8a9c94dd3599 100644
> --- a/fs/jbd2/journal.c
> +++ b/fs/jbd2/journal.c
> @@ -1283,6 +1283,48 @@ static int jbd2_min_tag_size(void)
>  	return sizeof(journal_block_tag_t) - 4;
>  }
>  
> +/**
> + * jbd2_journal_shrink_scan()
> + *
> + * Scan the checkpointed buffer on the checkpoint list and release the
> + * journal_head.
> + */
> +static unsigned long jbd2_journal_shrink_scan(struct shrinker *shrink,
> +					      struct shrink_control *sc)
> +{
> +	journal_t *journal = container_of(shrink, journal_t, j_shrinker);
> +	unsigned long nr_to_scan = sc->nr_to_scan;
> +	unsigned long nr_shrunk;
> +	unsigned long count;
> +
> +	count = percpu_counter_read_positive(&journal->j_checkpoint_jh_count);
> +	trace_jbd2_shrink_scan_enter(journal, sc->nr_to_scan, count);
> +
> +	nr_shrunk = jbd2_journal_shrink_checkpoint_list(journal, &nr_to_scan);
> +
> +	count = percpu_counter_read_positive(&journal->j_checkpoint_jh_count);
> +	trace_jbd2_shrink_scan_exit(journal, nr_to_scan, nr_shrunk, count);
> +
> +	return nr_shrunk;
> +}
> +
> +/**
> + * jbd2_journal_shrink_count()
> + *
> + * Count the number of checkpoint buffers on the checkpoint list.
> + */
> +static unsigned long jbd2_journal_shrink_count(struct shrinker *shrink,
> +					       struct shrink_control *sc)
> +{
> +	journal_t *journal = container_of(shrink, journal_t, j_shrinker);
> +	unsigned long count;
> +
> +	count = percpu_counter_read_positive(&journal->j_checkpoint_jh_count);
> +	trace_jbd2_shrink_count(journal, sc->nr_to_scan, count);
> +
> +	return count;
> +}
> +
>  /*
>   * Management for journal control blocks: functions to create and
>   * destroy journal_t structures, and to initialise and read existing
> @@ -1361,6 +1403,19 @@ static journal_t *journal_init_common(struct block_device *bdev,
>  	journal->j_sb_buffer = bh;
>  	journal->j_superblock = (journal_superblock_t *)bh->b_data;
>  
> +	journal->j_shrink_transaction = NULL;
> +	journal->j_shrinker.scan_objects = jbd2_journal_shrink_scan;
> +	journal->j_shrinker.count_objects = jbd2_journal_shrink_count;
> +	journal->j_shrinker.seeks = DEFAULT_SEEKS;
> +	journal->j_shrinker.batch = journal->j_max_transaction_buffers;
> +
> +	if (percpu_counter_init(&journal->j_checkpoint_jh_count, 0, GFP_KERNEL))
> +		goto err_cleanup;
> +
> +	if (register_shrinker(&journal->j_shrinker)) {
> +		percpu_counter_destroy(&journal->j_checkpoint_jh_count);
> +		goto err_cleanup;
> +	}
>  	return journal;
>  
>  err_cleanup:
> @@ -2050,93 +2105,6 @@ int jbd2_journal_load(journal_t *journal)
>  	return -EIO;
>  }
>  
> -/**
> - * jbd2_journal_shrink_scan()
> - *
> - * Scan the checkpointed buffer on the checkpoint list and release the
> - * journal_head.
> - */
> -static unsigned long jbd2_journal_shrink_scan(struct shrinker *shrink,
> -					      struct shrink_control *sc)
> -{
> -	journal_t *journal = container_of(shrink, journal_t, j_shrinker);
> -	unsigned long nr_to_scan = sc->nr_to_scan;
> -	unsigned long nr_shrunk;
> -	unsigned long count;
> -
> -	count = percpu_counter_read_positive(&journal->j_jh_shrink_count);
> -	trace_jbd2_shrink_scan_enter(journal, sc->nr_to_scan, count);
> -
> -	nr_shrunk = jbd2_journal_shrink_checkpoint_list(journal, &nr_to_scan);
> -
> -	count = percpu_counter_read_positive(&journal->j_jh_shrink_count);
> -	trace_jbd2_shrink_scan_exit(journal, nr_to_scan, nr_shrunk, count);
> -
> -	return nr_shrunk;
> -}
> -
> -/**
> - * jbd2_journal_shrink_count()
> - *
> - * Count the number of checkpoint buffers on the checkpoint list.
> - */
> -static unsigned long jbd2_journal_shrink_count(struct shrinker *shrink,
> -					       struct shrink_control *sc)
> -{
> -	journal_t *journal = container_of(shrink, journal_t, j_shrinker);
> -	unsigned long count;
> -
> -	count = percpu_counter_read_positive(&journal->j_jh_shrink_count);
> -	trace_jbd2_shrink_count(journal, sc->nr_to_scan, count);
> -
> -	return count;
> -}
> -
> -/**
> - * jbd2_journal_register_shrinker()
> - * @journal: Journal to act on.
> - *
> - * Init a percpu counter to record the checkpointed buffers on the checkpoint
> - * list and register a shrinker to release their journal_head.
> - */
> -int jbd2_journal_register_shrinker(journal_t *journal)
> -{
> -	int err;
> -
> -	journal->j_shrink_transaction = NULL;
> -
> -	err = percpu_counter_init(&journal->j_jh_shrink_count, 0, GFP_KERNEL);
> -	if (err)
> -		return err;
> -
> -	journal->j_shrinker.scan_objects = jbd2_journal_shrink_scan;
> -	journal->j_shrinker.count_objects = jbd2_journal_shrink_count;
> -	journal->j_shrinker.seeks = DEFAULT_SEEKS;
> -	journal->j_shrinker.batch = journal->j_max_transaction_buffers;
> -
> -	err = register_shrinker(&journal->j_shrinker);
> -	if (err) {
> -		percpu_counter_destroy(&journal->j_jh_shrink_count);
> -		return err;
> -	}
> -
> -	return 0;
> -}
> -EXPORT_SYMBOL(jbd2_journal_register_shrinker);
> -
> -/**
> - * jbd2_journal_unregister_shrinker()
> - * @journal: Journal to act on.
> - *
> - * Unregister the checkpointed buffer shrinker and destroy the percpu counter.
> - */
> -void jbd2_journal_unregister_shrinker(journal_t *journal)
> -{
> -	percpu_counter_destroy(&journal->j_jh_shrink_count);
> -	unregister_shrinker(&journal->j_shrinker);
> -}
> -EXPORT_SYMBOL(jbd2_journal_unregister_shrinker);
> -
>  /**
>   * jbd2_journal_destroy() - Release a journal_t structure.
>   * @journal: Journal to act on.
> @@ -2209,8 +2177,10 @@ int jbd2_journal_destroy(journal_t *journal)
>  		brelse(journal->j_sb_buffer);
>  	}
>  
> -	jbd2_journal_unregister_shrinker(journal);
> -
> +	if (journal->j_shrinker.flags & SHRINKER_REGISTERED) {
> +		percpu_counter_destroy(&journal->j_checkpoint_jh_count);
> +		unregister_shrinker(&journal->j_shrinker);
> +	}
>  	if (journal->j_proc_entry)
>  		jbd2_stats_proc_exit(journal);
>  	iput(journal->j_inode);
> diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
> index 6cc035321562..fd933c45281a 100644
> --- a/include/linux/jbd2.h
> +++ b/include/linux/jbd2.h
> @@ -918,11 +918,11 @@ struct journal_s
>  	struct shrinker		j_shrinker;
>  
>  	/**
> -	 * @j_jh_shrink_count:
> +	 * @j_checkpoint_jh_count:
>  	 *
>  	 * Number of journal buffers on the checkpoint list. [j_list_lock]
>  	 */
> -	struct percpu_counter	j_jh_shrink_count;
> +	struct percpu_counter	j_checkpoint_jh_count;
>  
>  	/**
>  	 * @j_shrink_transaction:
> @@ -1556,8 +1556,6 @@ extern int	   jbd2_journal_set_features
>  		   (journal_t *, unsigned long, unsigned long, unsigned long);
>  extern void	   jbd2_journal_clear_features
>  		   (journal_t *, unsigned long, unsigned long, unsigned long);
> -extern int	   jbd2_journal_register_shrinker(journal_t *journal);
> -extern void	   jbd2_journal_unregister_shrinker(journal_t *journal);
>  extern int	   jbd2_journal_load       (journal_t *journal);
>  extern int	   jbd2_journal_destroy    (journal_t *);
>  extern int	   jbd2_journal_recover    (journal_t *journal);
> -- 
> 2.31.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
