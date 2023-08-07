Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 162A1771D2D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Aug 2023 11:34:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231578AbjHGJe5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Aug 2023 05:34:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjHGJe4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Aug 2023 05:34:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7D4210C1
        for <linux-fsdevel@vger.kernel.org>; Mon,  7 Aug 2023 02:34:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3BD00614F9
        for <linux-fsdevel@vger.kernel.org>; Mon,  7 Aug 2023 09:34:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05C8DC433C8;
        Mon,  7 Aug 2023 09:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691400893;
        bh=3SfiyW6E+RYUHCU/WAvrqX/20S2uFqTMiqg8tb47xOQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DJugEg3+SRBmJ0PAVl5xYwdDH/bFmaulsaRFnKFZJnh2U9g10XoyDNvlXKjv7e+oN
         daWuND06FU5GTLrEaRNcW/JQf4c1RcgzkzsiLNgNbuTWzDidz9dVe6P+udI9JRVSHS
         /m9nde6/S0rMwbuR+6eWHvl2UA7XFewQjFqM4C5EbfZoveYkFhAcFChLY2sp6acvEF
         fFH2sUJ2IXFsQVyaUzatZyxYZvQp+juuetGIuJ8ykgAjgXSkDiHQqdu+JubhpXBLbF
         /sYmMRsCPgjq/fg6nAkm/6c46mSWblGX6VaD7Iu2HPre4jLDjAry9DmdkrneBVdr29
         /IVQETymEh07Q==
Date:   Mon, 7 Aug 2023 11:34:49 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Hugh Dickins <hughd@google.com>, Carlos Maiolino <cem@kernel.org>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH vfs.tmpfs] shmem: move spinlock into shmem_recalc_inode()
 to fix quota support
Message-ID: <20230807-zuschauen-wachpersonal-6ce2b6002dac@brauner>
References: <29f48045-2cb5-7db-ecf1-72462f1bef5@google.com>
 <20230807092030.krout2mwwa3yesd4@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230807092030.krout2mwwa3yesd4@quack3>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 07, 2023 at 11:20:30AM +0200, Jan Kara wrote:
> On Thu 03-08-23 22:46:11, Hugh Dickins wrote:
> > Commit "shmem: fix quota lock nesting in huge hole handling" was not so
> > good: Smatch caught shmem_recalc_inode()'s shmem_inode_unacct_blocks()
> > descending into quota_send_warning(): where blocking GFP_NOFS is used,
> > yet shmem_recalc_inode() is called holding the shmem inode's info->lock.
> > 
> > Yes, both __dquot_alloc_space() and __dquot_free_space() are commented
> > "This operation can block, but only after everything is updated" - when
> > calling flush_warnings() at the end - both its print_warning() and its
> > quota_send_warning() may block.
> > 
> > Rework shmem_recalc_inode() to take the shmem inode's info->lock inside,
> > and drop it before calling shmem_inode_unacct_blocks().
> > 
> > And why were the spin_locks disabling interrupts?  That was just a relic
> > from when shmem_charge() and shmem_uncharge() were called while holding
> > i_pages xa_lock: stop disabling interrupts for info->lock now.
> > 
> > To help stop me from making the same mistake again, add a might_sleep()
> > into shmem_inode_acct_block() and shmem_inode_unacct_blocks(); and those
> > functions have grown, so let the compiler decide whether to inline them.
> > 
> > Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> > Closes: https://lore.kernel.org/linux-fsdevel/ffd7ca34-7f2a-44ee-b05d-b54d920ce076@moroto.mountain/
> > Signed-off-by: Hugh Dickins <hughd@google.com>
> 
> Thanks for the fix Hugh! The patch looks good to me so feel free to add:
> 
> Reviewed-by: Jan Kara <jack@suse.cz>

Added, thank you!
