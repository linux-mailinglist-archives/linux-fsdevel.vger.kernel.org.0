Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD2D7782DBF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Aug 2023 18:04:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233928AbjHUQEs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Aug 2023 12:04:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232742AbjHUQEs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Aug 2023 12:04:48 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 260BADB
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Aug 2023 09:04:46 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D7CAA1F459;
        Mon, 21 Aug 2023 16:04:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1692633884; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ueILNRs574QNlXo4XjapMTIEKHqbry2FamRaR/1g4Cg=;
        b=E2u1KKE4twtze6lwmIIWqvmZmEkfS9M6iwvRNYFaA+GFv5/by91ZjkiWSaTxBdPpvD0iIF
        dZyMnRdFGNIIJV2QemOjnPg9D3DISGDdJVDeVg0AMdH7d3TfXnXbhzlrHrusWO6qMmKAei
        XhvtgvPhTqBM39440Jl6ypnGTgZzVdg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1692633884;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ueILNRs574QNlXo4XjapMTIEKHqbry2FamRaR/1g4Cg=;
        b=bm/oeel0XRWqqujfguK7qhDSg03X20ETpwwxPNY+mpR1LB+wfFnwCAdyT4Rm97Y1uyYRSJ
        JMshRGQ0H+R5U7Cw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CB0D51330D;
        Mon, 21 Aug 2023 16:04:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id +OmaMRyL42QQLwAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 21 Aug 2023 16:04:44 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 5BE27A0774; Mon, 21 Aug 2023 18:04:44 +0200 (CEST)
Date:   Mon, 21 Aug 2023 18:04:44 +0200
From:   Jan Kara <jack@suse.cz>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 3/4] super: wait for nascent superblocks
Message-ID: <20230821160444.twqbtcik7l3yxjv4@quack3>
References: <20230818-vfs-super-fixes-v3-v3-0-9f0b1876e46b@kernel.org>
 <20230818-vfs-super-fixes-v3-v3-3-9f0b1876e46b@kernel.org>
 <20230821155237.d4luoqrzhnlffbti@quack3>
 <20230821-dingo-befund-4eb177ad9df8@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230821-dingo-befund-4eb177ad9df8@brauner>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 21-08-23 17:56:07, Christian Brauner wrote:
> > I think we misunderstood here. I believe we need:
> > 
> > 	/*
> > 	 * Pairs with smp_load_acquire() in super_lock() to make sure
> > 	 * all initializations in the superblock are seen by the user
> > 	 * seeing SB_BORN sent.
> > 	 */
> > 	smp_store_release(&sb->s_flags, sb->s_flags | flag);
> > 	/*
> > 	 * Pairs with the barrier in prepare_to_wait_event() to make sure
> > 	 * ___wait_var_event() either sees SB_BORN set or
> > 	 * waitqueue_active() check in wake_up_var() sees the waiter
> > 	 */
> > 	smp_rmb();
> > 	wake_up_var(&sb->s_flags);
> 
> Oh right, sorry I missed this.
> 
> > Maybe we can have in these places rather:
> > 
> > 	if (!super_lock_excl(sb))
> > 		WARN(1, "Dying superblock while freezing!");
> > 
> > So that we reduce the amount of __super_lock_excl() calls which are kind of
> > special. In these places we hold active reference so practically this is
> > equivalent. Just a though, pick whatever you find better, I don't have a
> > strong opinion but wanted to share this idea.
> 
> Ok, will pick yours.
> 
> Do you want me to resend?

No need to resend as far as I'm concerned - and my suggestion was subtly
wrong as well - see my other email.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
