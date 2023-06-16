Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 561AA7334B4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jun 2023 17:28:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345852AbjFPP22 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Jun 2023 11:28:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245134AbjFPP21 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Jun 2023 11:28:27 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01E70270B;
        Fri, 16 Jun 2023 08:28:26 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B030C21D85;
        Fri, 16 Jun 2023 15:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1686929304; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0Kausdl49qJGfqu39jLtos4uf5kYOvO/lFvNKQ0Af1w=;
        b=W+pmP7MwL/U/YnM7oawRQovQaVWhkNKeM6iNmCmjaTpzQv9vXxp2c8tIDX4plttkoy/w/z
        nHA2FHYVip6S/o2bL4QPTK5ylIjsrTwbcKcWyVKVTNaCd7xrr1zw20ADayDe0OTJNrigMg
        IJ5PVLM6hf+q4AfF8treZyyKYvdHqJE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1686929304;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0Kausdl49qJGfqu39jLtos4uf5kYOvO/lFvNKQ0Af1w=;
        b=jjeFLEvXAN6LWxX6D+K19arDU9xpflBqH6voD4rCG+Du0GYpQfNZeQTEPql2atIsf5DrFN
        eCFgDtEJGbDmRCCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A09391330B;
        Fri, 16 Jun 2023 15:28:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id FHkvJ5h/jGSwAQAAMHmgww
        (envelope-from <jack@suse.cz>); Fri, 16 Jun 2023 15:28:24 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 34F31A0755; Fri, 16 Jun 2023 17:28:24 +0200 (CEST)
Date:   Fri, 16 Jun 2023 17:28:24 +0200
From:   Jan Kara <jack@suse.cz>
To:     Baokun Li <libaokun1@huawei.com>
Cc:     jack@suse.cz, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, yangerkun@huawei.com, chengzhihao1@huawei.com,
        yukuai3@huawei.com
Subject: Re: [PATCH] quota: fix race condition between dqput() and
 dquot_mark_dquot_dirty()
Message-ID: <20230616152824.ndpgvkegvvip2ahh@quack3>
References: <20230616085608.42435-1-libaokun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230616085608.42435-1-libaokun1@huawei.com>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello Baokun!

On Fri 16-06-23 16:56:08, Baokun Li wrote:
> We ran into a problem that dqput() and dquot_mark_dquot_dirty() may race
> like the function graph below, causing a released dquot to be added to the
> dqi_dirty_list, and this leads to that dquot being released again in
> dquot_writeback_dquots(), making two identical quotas in free_dquots.
> 
>        cpu1              cpu2
> _________________|_________________
> wb_do_writeback         CHOWN(1)
>  ...
>   ext4_da_update_reserve_space
>    dquot_claim_block
>     ...
>      dquot_mark_dquot_dirty // try to dirty old quota
>       test_bit(DQ_ACTIVE_B, &dquot->dq_flags) // still ACTIVE
>       if (test_bit(DQ_MOD_B, &dquot->dq_flags))
>       // test no dirty, wait dq_list_lock
>                     ...
>                      dquot_transfer
>                       __dquot_transfer
>                       dqput_all(transfer_from) // rls old dquot
>                        dqput // last dqput
>                         dquot_release
>                          clear_bit(DQ_ACTIVE_B, &dquot->dq_flags)
>                         atomic_dec(&dquot->dq_count)
>                         put_dquot_last(dquot)
>                          list_add_tail(&dquot->dq_free, &free_dquots)
>                          // first add the dquot to free_dquots
>       if (!test_and_set_bit(DQ_MOD_B, &dquot->dq_flags))
>         add dqi_dirty_list // add freed dquot to dirty_list
> P3:
> ksys_sync
>  ...
>   dquot_writeback_dquots
>    WARN_ON(!test_bit(DQ_ACTIVE_B, &dquot->dq_flags))
>    dqgrab(dquot)
>     WARN_ON_ONCE(!atomic_read(&dquot->dq_count))
>     WARN_ON_ONCE(!test_bit(DQ_ACTIVE_B, &dquot->dq_flags))
>    dqput(dquot)
>     put_dquot_last(dquot)
>      list_add_tail(&dquot->dq_free, &free_dquots)
>      // Double add the dquot to free_dquots
> 
> This causes a list_del corruption when removing the entry from free_dquots,
> and even trying to free the dquot twice in dqcache_shrink_scan triggers a
> use-after-free.
> 
> A warning may also be triggered by a race like the function diagram below:
> 
>        cpu1            cpu2           cpu3
> ________________|_______________|________________
> wb_do_writeback   CHOWN(1)        QUOTASYNC(1)
>  ...                              ...
>   ext4_da_update_reserve_space
>     ...           __dquot_transfer
>                    dqput // last dqput
>                     dquot_release
>                      dquot_is_busy
>                       if (test_bit(DQ_MOD_B, &dquot->dq_flags))
>                        // not dirty and still active
>      dquot_mark_dquot_dirty
>       if (!test_and_set_bit(DQ_MOD_B, &dquot->dq_flags))
>         add dqi_dirty_list
>                        clear_bit(DQ_ACTIVE_B, &dquot->dq_flags)
>                                    dquot_writeback_dquots
>                                     WARN_ON(!test_bit(DQ_ACTIVE_B))
> 
> To solve this problem, it is similar to the way dqget() avoids racing with
> dquot_release(). First set the DQ_MOD_B flag, then execute wait_on_dquot(),
> after this we know that either dquot_release() is already finished or it
> will be canceled due to DQ_MOD_B flag test, at this point if the quota is
> DQ_ACTIVE_B, then we can safely add the dquot to the dqi_dirty_list,
> otherwise clear the DQ_MOD_B flag and exit directly.
> 
> Fixes: 4580b30ea887 ("quota: Do not dirty bad dquots")
> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> ---
> 
> Hello Honza,
> 
> This problem can also be solved by modifying the reference count mechanism,
> where dquots hold a reference count after they are allocated until they are
> destroyed, i.e. the dquots in the free_dquots list have dq_count == 1. This
> allows us to reduce the reference count as soon as we enter the dqput(),
> and then add the dquot to the dqi_dirty_list only when dq_count > 1. This
> also prevents the dquot in the dqi_dirty_list from not having the
> DQ_ACTIVE_B flag, but this is a more impactful modification, so we chose to
> refer to dqget() to avoid racing with dquot_release(). If you prefer this
> solution by modifying the dq_count mechanism, I would be happy to send
> another version of the patch.

The way this *should* work is that dquot_mark_dquot_dirty() using dquot
references from the inode should be protected by dquot_srcu. quota_off
code takes care to call synchronize_srcu(&dquot_srcu) to not drop dquot
references while they are used by other users. But you are right
dquot_transfer() breaks this assumption. Most callers are fine since they
are also protected by inode->i_lock but still I'd prefer to fix
dquot_transfer() to follow the guarantees dquot_srcu should provide.

Now calling synchronize_srcu() directly from dquot_transfer() is too
expensive (and mostly unnecessary) so what I would rather suggest is to
create another dquot list (use dq_free list_head inside struct dquot for
it) and add dquot whose last reference should be dropped there. We'd then
queue work item which would call synchronize_srcu() and after that perform
the final cleanup of all the dquots on the list.

Now this also needs some modifications to dqget() and to quotaoff code to
handle various races with the new dqput() code so if you feel it is too
complex for your taste, I can implement this myself.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
