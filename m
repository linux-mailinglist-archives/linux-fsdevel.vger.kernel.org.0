Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44D4D6EA655
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Apr 2023 10:54:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231881AbjDUIyi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Apr 2023 04:54:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231723AbjDUIyD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Apr 2023 04:54:03 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F417A268;
        Fri, 21 Apr 2023 01:53:43 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 8E75821A45;
        Fri, 21 Apr 2023 08:53:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1682067222; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TCgmgxLZjgBpHMVFd5dl+S+78y8snFvoa5hj4IkLKoE=;
        b=DD3XydQvq2QEpcTvPifPVBUDTl+Q1vC8UkEnUANJmx94wjnPGZMZIdPgbbIjDTb6puvIEX
        N0IA1hP0Gyew7LmVfFz6UQqOWSYav9dSa+4gOBWY2nM+bid/rQgR+n896ET5c8MDUjLGhD
        +1gtKZkb0byMBdkk5cHcQhLuievKAbA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1682067222;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TCgmgxLZjgBpHMVFd5dl+S+78y8snFvoa5hj4IkLKoE=;
        b=X9A5npHx6rz1+iay8T2pmWurjIpbJdx/lP8Xi7ZG6oyuIl696EnQV4LsYls8Itl45mA1vJ
        dpFF1YcwgA4pfhBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7D84C13456;
        Fri, 21 Apr 2023 08:53:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id IRKIHhZPQmTsPAAAMHmgww
        (envelope-from <jack@suse.cz>); Fri, 21 Apr 2023 08:53:42 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 06E2FA0729; Fri, 21 Apr 2023 10:53:42 +0200 (CEST)
Date:   Fri, 21 Apr 2023 10:53:41 +0200
From:   Jan Kara <jack@suse.cz>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH mm-unstable RFC 1/5] writeback: move wb_over_bg_thresh()
 call outside lock section
Message-ID: <20230421085341.b2zvzeuc745bs6sa@quack3>
References: <20230403220337.443510-1-yosryahmed@google.com>
 <20230403220337.443510-2-yosryahmed@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230403220337.443510-2-yosryahmed@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 03-04-23 22:03:33, Yosry Ahmed wrote:
> wb_over_bg_thresh() calls mem_cgroup_wb_stats() which invokes an rstat
> flush, which can be expensive on large systems. Currently,
> wb_writeback() calls wb_over_bg_thresh() within a lock section, so we
> have to make the rstat flush atomically. On systems with a lot of
> cpus/cgroups, this can cause us to disable irqs for a long time,
> potentially causing problems.
> 
> Move the call to wb_over_bg_thresh() outside the lock section in
> preparation to make the rstat flush in mem_cgroup_wb_stats() non-atomic.
> The list_empty(&wb->work_list) should be okay outside the lock section
> of wb->list_lock as it is protected by a separate lock (wb->work_lock),
> and wb_over_bg_thresh() doesn't seem like it is modifying any of the b_*
> lists the wb->list_lock is protecting. Also, the loop seems to be
> already releasing and reacquring the lock, so this refactoring looks
> safe.
> 
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>

The patch looks good to me. Nice find. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/fs-writeback.c | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> index 195dc23e0d831..012357bc8daa3 100644
> --- a/fs/fs-writeback.c
> +++ b/fs/fs-writeback.c
> @@ -2021,7 +2021,6 @@ static long wb_writeback(struct bdi_writeback *wb,
>  	struct blk_plug plug;
>  
>  	blk_start_plug(&plug);
> -	spin_lock(&wb->list_lock);
>  	for (;;) {
>  		/*
>  		 * Stop writeback when nr_pages has been consumed
> @@ -2046,6 +2045,9 @@ static long wb_writeback(struct bdi_writeback *wb,
>  		if (work->for_background && !wb_over_bg_thresh(wb))
>  			break;
>  
> +
> +		spin_lock(&wb->list_lock);
> +
>  		/*
>  		 * Kupdate and background works are special and we want to
>  		 * include all inodes that need writing. Livelock avoidance is
> @@ -2075,13 +2077,19 @@ static long wb_writeback(struct bdi_writeback *wb,
>  		 * mean the overall work is done. So we keep looping as long
>  		 * as made some progress on cleaning pages or inodes.
>  		 */
> -		if (progress)
> +		if (progress) {
> +			spin_unlock(&wb->list_lock);
>  			continue;
> +		}
> +
>  		/*
>  		 * No more inodes for IO, bail
>  		 */
> -		if (list_empty(&wb->b_more_io))
> +		if (list_empty(&wb->b_more_io)) {
> +			spin_unlock(&wb->list_lock);
>  			break;
> +		}
> +
>  		/*
>  		 * Nothing written. Wait for some inode to
>  		 * become available for writeback. Otherwise
> @@ -2093,9 +2101,7 @@ static long wb_writeback(struct bdi_writeback *wb,
>  		spin_unlock(&wb->list_lock);
>  		/* This function drops i_lock... */
>  		inode_sleep_on_writeback(inode);
> -		spin_lock(&wb->list_lock);
>  	}
> -	spin_unlock(&wb->list_lock);
>  	blk_finish_plug(&plug);
>  
>  	return nr_pages - work->nr_pages;
> -- 
> 2.40.0.348.gf938b09366-goog
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
