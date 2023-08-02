Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6723276CFEF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Aug 2023 16:22:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231858AbjHBOWd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Aug 2023 10:22:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229948AbjHBOWc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Aug 2023 10:22:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 144F526A8
        for <linux-fsdevel@vger.kernel.org>; Wed,  2 Aug 2023 07:22:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9D3E761935
        for <linux-fsdevel@vger.kernel.org>; Wed,  2 Aug 2023 14:22:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7AB9C433C7;
        Wed,  2 Aug 2023 14:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690986150;
        bh=MT7Z87ljmi261J3BpUCjdlTWrdReq1Vhk/D48RchVA0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NLqB6L8e5q5r5pM8yrBZJCKzaFMATviq+jMFe0VuKx7xIZlwzTMLKRl0qnPXOhB7E
         RRlIk9wM7ReNYlQoZO4wcXeRVaf7P9z1wP7F4LdBW3xChri0mLxdcQlYQ1txm24Wvk
         wCNlGt6syJLEBHyFHZitiX2YotrOw5r44Yvum58diRec26C9PCZKHHUt2odH025HBQ
         bbOuyKHlu//MX0BfGJ7ju4o1jFQQYKY1qJ2Lh1Vgpq49DGhoY5ofql8rMi1iUEgRqY
         Y1Mk0QOVBfVeSdD1SW8ty7lkNbUtmTHRB8snhEdatln2P5r53r4zIYenHGstdsopJi
         tSSBa3iK8trrw==
Date:   Wed, 2 Aug 2023 16:22:25 +0200
From:   Carlos Maiolino <cem@kernel.org>
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     linux-fsdevel@vger.kernel.org, jack@suse.cz, brauner@kernel.org,
        hughd@google.com
Subject: Re: [bug report] shmem: quota support
Message-ID: <20230802142225.of27saigrzotlmza@andromeda>
References: <kU3N4tqbYA3gHO6AXf5TbwIkfbkKFI9NaCK_39Uj4qC6YJKXa_j98uqXcegkmzc8Nxj8L3rD_UWv_x6y0RGv1Q==@protonmail.internalid>
 <ffd7ca34-7f2a-44ee-b05d-b54d920ce076@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ffd7ca34-7f2a-44ee-b05d-b54d920ce076@moroto.mountain>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 02, 2023 at 09:53:54AM +0300, Dan Carpenter wrote:
> Hello Carlos Maiolino,
> 
> The patch 9a9f8f590f6d: "shmem: quota support" from Jul 25, 2023
> (linux-next), leads to the following Smatch static checker warning:
> 
> 	fs/quota/dquot.c:1271 flush_warnings()
> 	warn: sleeping in atomic context
> 

Thanks for the report Dan!

> fs/quota/dquot.c
>     1261 static void flush_warnings(struct dquot_warn *warn)
>     1262 {
>     1263         int i;
>     1264
>     1265         for (i = 0; i < MAXQUOTAS; i++) {
>     1266                 if (warn[i].w_type == QUOTA_NL_NOWARN)
>     1267                         continue;
>     1268 #ifdef CONFIG_PRINT_QUOTA_WARNING
>     1269                 print_warning(&warn[i]);
>     1270 #endif
> --> 1271                 quota_send_warning(warn[i].w_dq_id,
>     1272                                    warn[i].w_sb->s_dev, warn[i].w_type);
> 
> The quota_send_warning() function does GFP_NOFS allocations, which don't
> touch the fs but can still sleep.  GFP_ATOMIC or GFP_NOWAIT don't sleep.
> 

Hmm, tbh I think the simplest way to fix it is indeed change GFP_NOFS to
GFP_NOWAIT when calling genlmsg_new(), quota_send_warnings() already abstain to
pass any error back to its caller, I don't think moving it from GFP_NOFS ->
GFP_NOWAIT will have much impact here as the amount of memory required for it is
not that big and wouldn't fail unless free memory is really short. I might be
wrong though.

If not that, another option would be to swap tmpfs spinlocks for mutexes, but I
would rather avoid that.

CC'ing other folks for more suggestions.

Carlos

>     1273         }
>     1274 }
> 
> The call trees that Smatch is worried about are listed.  The "disables
> preempt" functions take the spin_lock_irq(&info->lock) before calling
> shmem_recalc_inode().
> 
> shmem_charge() <- disables preempt
> shmem_uncharge() <- disables preempt
> shmem_undo_range() <- disables preempt
> shmem_getattr() <- disables preempt
> shmem_writepage() <- disables preempt
> shmem_set_folio_swapin_error() <- disables preempt
> shmem_swapin_folio() <- disables preempt
> shmem_get_folio_gfp() <- disables preempt
> -> shmem_recalc_inode()
>    -> shmem_inode_unacct_blocks()
>       -> dquot_free_block_nodirty()
>          -> dquot_free_space_nodirty()
>             -> __dquot_free_space()
>                -> flush_warnings()

Hm, I see, we add dquot_free_block_nodirty() call to shmem_inode_unacct_blocks()
here, which leads to this possible sleep inside spin_lock_irq().
> 
> regards,
> dan carpenter
