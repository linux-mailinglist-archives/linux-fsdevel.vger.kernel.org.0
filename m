Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89897782D98
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Aug 2023 17:56:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbjHUP4S (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Aug 2023 11:56:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbjHUP4S (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Aug 2023 11:56:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30722DB
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Aug 2023 08:56:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AE5EC61599
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Aug 2023 15:56:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AE10C433C8;
        Mon, 21 Aug 2023 15:56:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692633376;
        bh=+PH6ttHc/CbHLjy8XYxB7ibSlP7m8i4lG1fgCJCMeyo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cAeSLYu7Cb8m56GK3bYR1mZgThBFeKZSjBpI6FJt1kQ8MeThv4rqPj63Ysn6FPivc
         OHyqVA/qepXV6KcS12ZaRjkXYOtChimnHJH3OnNdZjf/g8JuHM7mK3lub6nVhOCsFO
         y1nu7L0V6vjaiDLaCNDsYIVJsibhCxC1H96RHWV4UqiU5d7YfqLDME+mHl7oNJumxx
         djggNzyfwOGzywnofz862hKfSZ03dokbqjexjslw4rDnctiHx97dNX7K6rdzlcpUBJ
         Ie9gCzd9MmGK7sBa5LwcYGyGl89b+0jDg5FZlfgVPycOYeXoYPnE4+eiNAqhrACZ7w
         6YI+mvse6tQ5A==
Date:   Mon, 21 Aug 2023 17:56:07 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 3/4] super: wait for nascent superblocks
Message-ID: <20230821-dingo-befund-4eb177ad9df8@brauner>
References: <20230818-vfs-super-fixes-v3-v3-0-9f0b1876e46b@kernel.org>
 <20230818-vfs-super-fixes-v3-v3-3-9f0b1876e46b@kernel.org>
 <20230821155237.d4luoqrzhnlffbti@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230821155237.d4luoqrzhnlffbti@quack3>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> I think we misunderstood here. I believe we need:
> 
> 	/*
> 	 * Pairs with smp_load_acquire() in super_lock() to make sure
> 	 * all initializations in the superblock are seen by the user
> 	 * seeing SB_BORN sent.
> 	 */
> 	smp_store_release(&sb->s_flags, sb->s_flags | flag);
> 	/*
> 	 * Pairs with the barrier in prepare_to_wait_event() to make sure
> 	 * ___wait_var_event() either sees SB_BORN set or
> 	 * waitqueue_active() check in wake_up_var() sees the waiter
> 	 */
> 	smp_rmb();
> 	wake_up_var(&sb->s_flags);

Oh right, sorry I missed this.

> Maybe we can have in these places rather:
> 
> 	if (!super_lock_excl(sb))
> 		WARN(1, "Dying superblock while freezing!");
> 
> So that we reduce the amount of __super_lock_excl() calls which are kind of
> special. In these places we hold active reference so practically this is
> equivalent. Just a though, pick whatever you find better, I don't have a
> strong opinion but wanted to share this idea.

Ok, will pick yours.

Do you want me to resend?
