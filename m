Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24775786C51
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Aug 2023 11:52:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239139AbjHXJwL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Aug 2023 05:52:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240730AbjHXJvn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Aug 2023 05:51:43 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B9EC170F;
        Thu, 24 Aug 2023 02:51:41 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 02EE822D5B;
        Thu, 24 Aug 2023 09:51:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1692870700; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Pxa2+V0kwHi7/2sGDFOZCd/7KeQpScvLV6JBpiWsk4k=;
        b=IZRptfoBVD/TYrolu2gsnOLFquFZFJQ3aE9XMeP5jS5XqQYEzeKmnmA+8dyJ+WYqDkOXSx
        vFS47ORMJDzroWmoPIPF4YBfrDma38dUcmTuX2oqIA3sabZheLzP1kq7SCKrDG/KoNs9Hc
        HAx3XWJM1TzLI+CtfFBamRN45q6wrkY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1692870700;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Pxa2+V0kwHi7/2sGDFOZCd/7KeQpScvLV6JBpiWsk4k=;
        b=salJb2fiqKUtpqOkG3IpAjHOystViyxxebLhcCIKBS7mP/pK0zQN8Whkp3APgcfmazQ6Jw
        +A338wBHgt4eEZAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E5011132F2;
        Thu, 24 Aug 2023 09:51:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id oP3kNyso52QWJAAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 24 Aug 2023 09:51:39 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 8132DA0774; Thu, 24 Aug 2023 11:51:39 +0200 (CEST)
Date:   Thu, 24 Aug 2023 11:51:39 +0200
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
        Jan Kara <jack@suse.com>
Subject: Re: [PATCH v5 13/45] quota: dynamically allocate the dquota-cache
 shrinker
Message-ID: <20230824095139.nvdozxopqq65yiln@quack3>
References: <20230824034304.37411-1-zhengqi.arch@bytedance.com>
 <20230824034304.37411-14-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230824034304.37411-14-zhengqi.arch@bytedance.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 24-08-23 11:42:32, Qi Zheng wrote:
> Use new APIs to dynamically allocate the dquota-cache shrinker.
> 
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> Reviewed-by: Muchun Song <songmuchun@bytedance.com>
> CC: Jan Kara <jack@suse.com>

Looks good to me. Feel free to add:

Acked-by: Jan Kara <jack@suse.cz>

								Honza



> ---
>  fs/quota/dquot.c | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
> index 9e72bfe8bbad..c303cffdf433 100644
> --- a/fs/quota/dquot.c
> +++ b/fs/quota/dquot.c
> @@ -791,12 +791,6 @@ dqcache_shrink_count(struct shrinker *shrink, struct shrink_control *sc)
>  	percpu_counter_read_positive(&dqstats.counter[DQST_FREE_DQUOTS]));
>  }
>  
> -static struct shrinker dqcache_shrinker = {
> -	.count_objects = dqcache_shrink_count,
> -	.scan_objects = dqcache_shrink_scan,
> -	.seeks = DEFAULT_SEEKS,
> -};
> -
>  /*
>   * Safely release dquot and put reference to dquot.
>   */
> @@ -2956,6 +2950,7 @@ static int __init dquot_init(void)
>  {
>  	int i, ret;
>  	unsigned long nr_hash, order;
> +	struct shrinker *dqcache_shrinker;
>  
>  	printk(KERN_NOTICE "VFS: Disk quotas %s\n", __DQUOT_VERSION__);
>  
> @@ -2990,8 +2985,15 @@ static int __init dquot_init(void)
>  	pr_info("VFS: Dquot-cache hash table entries: %ld (order %ld,"
>  		" %ld bytes)\n", nr_hash, order, (PAGE_SIZE << order));
>  
> -	if (register_shrinker(&dqcache_shrinker, "dquota-cache"))
> -		panic("Cannot register dquot shrinker");
> +	dqcache_shrinker = shrinker_alloc(0, "dquota-cache");
> +	if (!dqcache_shrinker)
> +		panic("Cannot allocate dquot shrinker");
> +
> +	dqcache_shrinker->count_objects = dqcache_shrink_count;
> +	dqcache_shrinker->scan_objects = dqcache_shrink_scan;
> +	dqcache_shrinker->seeks = DEFAULT_SEEKS;
> +
> +	shrinker_register(dqcache_shrinker);
>  
>  	return 0;
>  }
> -- 
> 2.30.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
