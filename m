Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90642771D04
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Aug 2023 11:20:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231488AbjHGJUf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Aug 2023 05:20:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231478AbjHGJUe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Aug 2023 05:20:34 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C040E7B
        for <linux-fsdevel@vger.kernel.org>; Mon,  7 Aug 2023 02:20:32 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1AE0A2188B;
        Mon,  7 Aug 2023 09:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1691400031; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ldbyD0y3FMLrvUev8d7HhhzelDqG0pQ1MDVEdGC5cZs=;
        b=ARr8CM1SbMWQQ6OHM3V9TPLpQXEOUbwwRs6PpQ5+8lF4ASK8H0sr8faRW+7AbTyKFQxwwX
        X24LpHjHof2+M2ln5rHhv2fqma3w+DWn+hTna2c9CedEDDrU2gIp/BURdjEc2qWKWm9PLW
        D/huRnd+asloGUFqlwQzv+977ccAl0s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1691400031;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ldbyD0y3FMLrvUev8d7HhhzelDqG0pQ1MDVEdGC5cZs=;
        b=4HTzHgXp2hX9Xk73TT0MUqbJRFwkRkNAn3cSHz1y8q8Z2OpIuWVgvJIx7a8uES2zV8VS/s
        eygN5YMhC0YeTWDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0678213910;
        Mon,  7 Aug 2023 09:20:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 1uCAAV+30GTgHgAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 07 Aug 2023 09:20:31 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 756D1A076C; Mon,  7 Aug 2023 11:20:30 +0200 (CEST)
Date:   Mon, 7 Aug 2023 11:20:30 +0200
From:   Jan Kara <jack@suse.cz>
To:     Hugh Dickins <hughd@google.com>
Cc:     Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Carlos Maiolino <cem@kernel.org>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH vfs.tmpfs] shmem: move spinlock into shmem_recalc_inode()
 to fix quota support
Message-ID: <20230807092030.krout2mwwa3yesd4@quack3>
References: <29f48045-2cb5-7db-ecf1-72462f1bef5@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <29f48045-2cb5-7db-ecf1-72462f1bef5@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 03-08-23 22:46:11, Hugh Dickins wrote:
> Commit "shmem: fix quota lock nesting in huge hole handling" was not so
> good: Smatch caught shmem_recalc_inode()'s shmem_inode_unacct_blocks()
> descending into quota_send_warning(): where blocking GFP_NOFS is used,
> yet shmem_recalc_inode() is called holding the shmem inode's info->lock.
> 
> Yes, both __dquot_alloc_space() and __dquot_free_space() are commented
> "This operation can block, but only after everything is updated" - when
> calling flush_warnings() at the end - both its print_warning() and its
> quota_send_warning() may block.
> 
> Rework shmem_recalc_inode() to take the shmem inode's info->lock inside,
> and drop it before calling shmem_inode_unacct_blocks().
> 
> And why were the spin_locks disabling interrupts?  That was just a relic
> from when shmem_charge() and shmem_uncharge() were called while holding
> i_pages xa_lock: stop disabling interrupts for info->lock now.
> 
> To help stop me from making the same mistake again, add a might_sleep()
> into shmem_inode_acct_block() and shmem_inode_unacct_blocks(); and those
> functions have grown, so let the compiler decide whether to inline them.
> 
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/linux-fsdevel/ffd7ca34-7f2a-44ee-b05d-b54d920ce076@moroto.mountain/
> Signed-off-by: Hugh Dickins <hughd@google.com>

Thanks for the fix Hugh! The patch looks good to me so feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

(FWIW for shmem code).
								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
