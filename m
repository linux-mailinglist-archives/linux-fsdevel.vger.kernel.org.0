Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 941CB724548
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Jun 2023 16:09:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236322AbjFFOId (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Jun 2023 10:08:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237865AbjFFOIW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Jun 2023 10:08:22 -0400
X-Greylist: delayed 429 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 06 Jun 2023 07:08:18 PDT
Received: from out-39.mta0.migadu.com (out-39.mta0.migadu.com [91.218.175.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF83B10D1
        for <linux-fsdevel@vger.kernel.org>; Tue,  6 Jun 2023 07:08:18 -0700 (PDT)
Message-ID: <c3173405-713d-d2eb-bd9c-af8b8c747533@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1686060065;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2uml8vTQA7Jk00qED6Wb0yWaRiW4bBmvkl2obmUQkoY=;
        b=cvjjhEbuIw4XMzuXB1gNKv2SDPspUiKAG9c1qfukbOq4Vu+Xvk3hRzqZTUkoLf1h8WgeIK
        mX4iw7SxtoUFhollyDxq/cwh3Lh7vZZIsBzxlwz6oUhiblNeM4/UDIe/0JjU4VNs7YUQW0
        +fKrohXUbW3ugX9LtBnHc4V513usgsI=
Date:   Tue, 6 Jun 2023 22:00:57 +0800
MIME-Version: 1.0
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
Subject: Re: [PATCH v2 09/12] ext4: Ensure ext4_mb_prefetch_fini() is called
 for all prefetched BGs
To:     Ojaswin Mujoo <ojaswin@linux.ibm.com>, linux-ext4@vger.kernel.org,
        Theodore Ts'o <tytso@mit.edu>
Cc:     Ritesh Harjani <riteshh@linux.ibm.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.cz>,
        Kemeng Shi <shikemeng@huaweicloud.com>,
        Ritesh Harjani <ritesh.list@gmail.com>
References: <cover.1685449706.git.ojaswin@linux.ibm.com>
 <05e648ae04ec5b754207032823e9c1de9a54f87a.1685449706.git.ojaswin@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <05e648ae04ec5b754207032823e9c1de9a54f87a.1685449706.git.ojaswin@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

On 5/30/23 20:33, Ojaswin Mujoo wrote:
> Before this patch, the call stack in ext4_run_li_request is as follows:
>
>    /*
>     * nr = no. of BGs we want to fetch (=s_mb_prefetch)
>     * prefetch_ios = no. of BGs not uptodate after
>     * 		    ext4_read_block_bitmap_nowait()
>     */
>    next_group = ext4_mb_prefetch(sb, group, nr, prefetch_ios);
>    ext4_mb_prefetch_fini(sb, next_group prefetch_ios);
>
> ext4_mb_prefetch_fini() will only try to initialize buddies for BGs in
> range [next_group - prefetch_ios, next_group). This is incorrect since
> sometimes (prefetch_ios < nr), which causes ext4_mb_prefetch_fini() to
> incorrectly ignore some of the BGs that might need initialization. This
> issue is more notable now with the previous patch enabling "fetching" of
> BLOCK_UNINIT BGs which are marked buffer_uptodate by default.
>
> Fix this by passing nr to ext4_mb_prefetch_fini() instead of
> prefetch_ios so that it considers the right range of groups.

Thanks for the series.

> Similarly, make sure we don't pass nr=0 to ext4_mb_prefetch_fini() in
> ext4_mb_regular_allocator() since we might have prefetched BLOCK_UNINIT
> groups that would need buddy initialization.

Seems ext4_mb_prefetch_fini can't be called by ext4_mb_regular_allocator
if nr is 0.

https://elixir.bootlin.com/linux/v6.4-rc5/source/fs/ext4/mballoc.c#L2816

Am I miss something?

Thanks,
Guoqing

> Signed-off-by: Ojaswin Mujoo<ojaswin@linux.ibm.com>
> Reviewed-by: Ritesh Harjani (IBM)<ritesh.list@gmail.com>
> Reviewed-by: Jan Kara<jack@suse.cz>
> ---
>   fs/ext4/mballoc.c |  4 ----
>   fs/ext4/super.c   | 11 ++++-------
>   2 files changed, 4 insertions(+), 11 deletions(-)
>
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index 79455c7e645b..6775d73dfc68 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -2735,8 +2735,6 @@ ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
>   			if ((prefetch_grp == group) &&
>   			    (cr > CR1 ||
>   			     prefetch_ios < sbi->s_mb_prefetch_limit)) {
> -				unsigned int curr_ios = prefetch_ios;
> -
>   				nr = sbi->s_mb_prefetch;
>   				if (ext4_has_feature_flex_bg(sb)) {
>   					nr = 1 << sbi->s_log_groups_per_flex;
> @@ -2745,8 +2743,6 @@ ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
>   				}
>   				prefetch_grp = ext4_mb_prefetch(sb, group,
>   							nr, &prefetch_ios);
> -				if (prefetch_ios == curr_ios)
> -					nr = 0;
>   			}
>   
>   			/* This now checks without needing the buddy page */
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 2da5476fa48b..27c1dabacd43 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -3692,16 +3692,13 @@ static int ext4_run_li_request(struct ext4_li_request *elr)
>   	ext4_group_t group = elr->lr_next_group;
>   	unsigned int prefetch_ios = 0;
>   	int ret = 0;
> +	int nr = EXT4_SB(sb)->s_mb_prefetch;
>   	u64 start_time;
>   
>   	if (elr->lr_mode == EXT4_LI_MODE_PREFETCH_BBITMAP) {
> -		elr->lr_next_group = ext4_mb_prefetch(sb, group,
> -				EXT4_SB(sb)->s_mb_prefetch, &prefetch_ios);
> -		if (prefetch_ios)
> -			ext4_mb_prefetch_fini(sb, elr->lr_next_group,
> -					      prefetch_ios);
> -		trace_ext4_prefetch_bitmaps(sb, group, elr->lr_next_group,
> -					    prefetch_ios);
> +		elr->lr_next_group = ext4_mb_prefetch(sb, group, nr, &prefetch_ios);
> +		ext4_mb_prefetch_fini(sb, elr->lr_next_group, nr);
> +		trace_ext4_prefetch_bitmaps(sb, group, elr->lr_next_group, nr);
>   		if (group >= elr->lr_next_group) {
>   			ret = 1;
>   			if (elr->lr_first_not_zeroed != ngroups &&

