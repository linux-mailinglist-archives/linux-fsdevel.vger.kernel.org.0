Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD3B3786C49
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Aug 2023 11:51:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240361AbjHXJud (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Aug 2023 05:50:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230125AbjHXJuC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Aug 2023 05:50:02 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCC7910C7;
        Thu, 24 Aug 2023 02:49:56 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 8323820ABE;
        Thu, 24 Aug 2023 09:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1692870595; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OLwPzBreyOpR95YcVVb3yFmDKybDs7swq9/uz2pOYw8=;
        b=pIILLK6VFVIGHfOid6dE0pz/PWtA7zHKr/Lal9VQKx1HvmUYqmnNOp48GblM2ukV+J4MJV
        qAuiAtQ7bIfvBAHpyWWf3ahO1SIrtCYI4Dn9nffO/+XqMwP0c5bvybg1JKaZtjcx2M3iS5
        oF0RLgHTygiLRVe9UQuRPmQiXjtS0o8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1692870595;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OLwPzBreyOpR95YcVVb3yFmDKybDs7swq9/uz2pOYw8=;
        b=fButr8P1xPqo0MdN43U0wNMp6A8A0DEH+CUD0eDxqWGDZmqkMD0kdU1+oBQBCxi5sZF6Uo
        jUUPPVxveU2Z2KCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 64994132F2;
        Thu, 24 Aug 2023 09:49:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id k7MOF8Mn52QhIwAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 24 Aug 2023 09:49:55 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id D7A14A0774; Thu, 24 Aug 2023 11:49:54 +0200 (CEST)
Date:   Thu, 24 Aug 2023 11:49:54 +0200
From:   Jan Kara <jack@suse.cz>
To:     Qi Zheng <zhengqi.arch@bytedance.com>
Cc:     akpm@linux-foundation.org, david@fromorbit.com, tkhai@ya.ru,
        vbabka@suse.cz, roman.gushchin@linux.dev, djwong@kernel.org,
        brauner@kernel.org, paulmck@kernel.org, tytso@mit.edu,
        steven.price@arm.com, cel@kernel.org, senozhatsky@chromium.org,
        yujie.liu@intel.com, gregkh@linuxfoundation.org,
        muchun.song@linux.dev, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>,
        Jan Kara <jack@suse.com>, linux-ext4@vger.kernel.org
Subject: Re: [PATCH v5 31/45] jbd2,ext4: dynamically allocate the
 jbd2-journal shrinker
Message-ID: <20230824094954.ndobdyabdxw3xvbc@quack3>
References: <20230824034304.37411-1-zhengqi.arch@bytedance.com>
 <20230824034304.37411-32-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230824034304.37411-32-zhengqi.arch@bytedance.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_PASS,
        T_SPF_HELO_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 24-08-23 11:42:50, Qi Zheng wrote:
> In preparation for implementing lockless slab shrink, use new APIs to
> dynamically allocate the jbd2-journal shrinker, so that it can be freed
> asynchronously via RCU. Then it doesn't need to wait for RCU read-side
> critical section when releasing the struct journal_s.
> 
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> Reviewed-by: Muchun Song <songmuchun@bytedance.com>
> CC: "Theodore Ts'o" <tytso@mit.edu>
> CC: Jan Kara <jack@suse.com>
> CC: linux-ext4@vger.kernel.org

Looks good to me. Feel free to add:

Acked-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/jbd2/journal.c    | 30 +++++++++++++++++++-----------
>  include/linux/jbd2.h |  2 +-
>  2 files changed, 20 insertions(+), 12 deletions(-)
> 
> diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
> index 768fa05bcbed..75692baa76e8 100644
> --- a/fs/jbd2/journal.c
> +++ b/fs/jbd2/journal.c
> @@ -1290,7 +1290,7 @@ static int jbd2_min_tag_size(void)
>  static unsigned long jbd2_journal_shrink_scan(struct shrinker *shrink,
>  					      struct shrink_control *sc)
>  {
> -	journal_t *journal = container_of(shrink, journal_t, j_shrinker);
> +	journal_t *journal = shrink->private_data;
>  	unsigned long nr_to_scan = sc->nr_to_scan;
>  	unsigned long nr_shrunk;
>  	unsigned long count;
> @@ -1316,7 +1316,7 @@ static unsigned long jbd2_journal_shrink_scan(struct shrinker *shrink,
>  static unsigned long jbd2_journal_shrink_count(struct shrinker *shrink,
>  					       struct shrink_control *sc)
>  {
> -	journal_t *journal = container_of(shrink, journal_t, j_shrinker);
> +	journal_t *journal = shrink->private_data;
>  	unsigned long count;
>  
>  	count = percpu_counter_read_positive(&journal->j_checkpoint_jh_count);
> @@ -1588,14 +1588,22 @@ static journal_t *journal_init_common(struct block_device *bdev,
>  		goto err_cleanup;
>  
>  	journal->j_shrink_transaction = NULL;
> -	journal->j_shrinker.scan_objects = jbd2_journal_shrink_scan;
> -	journal->j_shrinker.count_objects = jbd2_journal_shrink_count;
> -	journal->j_shrinker.seeks = DEFAULT_SEEKS;
> -	journal->j_shrinker.batch = journal->j_max_transaction_buffers;
> -	err = register_shrinker(&journal->j_shrinker, "jbd2-journal:(%u:%u)",
> -				MAJOR(bdev->bd_dev), MINOR(bdev->bd_dev));
> -	if (err)
> +
> +	journal->j_shrinker = shrinker_alloc(0, "jbd2-journal:(%u:%u)",
> +					     MAJOR(bdev->bd_dev),
> +					     MINOR(bdev->bd_dev));
> +	if (!journal->j_shrinker) {
> +		err = -ENOMEM;
>  		goto err_cleanup;
> +	}
> +
> +	journal->j_shrinker->scan_objects = jbd2_journal_shrink_scan;
> +	journal->j_shrinker->count_objects = jbd2_journal_shrink_count;
> +	journal->j_shrinker->seeks = DEFAULT_SEEKS;
> +	journal->j_shrinker->batch = journal->j_max_transaction_buffers;
> +	journal->j_shrinker->private_data = journal;
> +
> +	shrinker_register(journal->j_shrinker);
>  
>  	return journal;
>  
> @@ -2170,9 +2178,9 @@ int jbd2_journal_destroy(journal_t *journal)
>  		brelse(journal->j_sb_buffer);
>  	}
>  
> -	if (journal->j_shrinker.flags & SHRINKER_REGISTERED) {
> +	if (journal->j_shrinker) {
>  		percpu_counter_destroy(&journal->j_checkpoint_jh_count);
> -		unregister_shrinker(&journal->j_shrinker);
> +		shrinker_free(journal->j_shrinker);
>  	}
>  	if (journal->j_proc_entry)
>  		jbd2_stats_proc_exit(journal);
> diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
> index 52772c826c86..6dcbb4eb80fb 100644
> --- a/include/linux/jbd2.h
> +++ b/include/linux/jbd2.h
> @@ -886,7 +886,7 @@ struct journal_s
>  	 * Journal head shrinker, reclaim buffer's journal head which
>  	 * has been written back.
>  	 */
> -	struct shrinker		j_shrinker;
> +	struct shrinker		*j_shrinker;
>  
>  	/**
>  	 * @j_checkpoint_jh_count:
> -- 
> 2.30.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
