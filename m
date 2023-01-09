Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 603C4662B4A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jan 2023 17:33:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbjAIQdJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Jan 2023 11:33:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjAIQdI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Jan 2023 11:33:08 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1044DB8
        for <linux-fsdevel@vger.kernel.org>; Mon,  9 Jan 2023 08:33:07 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A453F3369C;
        Mon,  9 Jan 2023 16:33:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1673281985; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FOMqudGlT1v37JyuSX5h3Sk+nY6O9kkiQLgmr0k5Vlw=;
        b=gGU2aeYPWVjGlOnDnAUWgFvVVg7UTiSW8jYyX1KdzxKni08Pk43pNzCl3iN9T60f7LFheS
        W0hNwWQkNeV7CD+7HyQQ134O1Imtj8cDJnkbjmdJvOJo2b3r+k87yvfpMgUoWzAu6+bHRc
        xYZ4KxNscqqVuTGxVGxsdHVsCN0/0hw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1673281985;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FOMqudGlT1v37JyuSX5h3Sk+nY6O9kkiQLgmr0k5Vlw=;
        b=z8p4n93PIa8POcmC6KTF5EFDIhqMknufPqv+MGZcIP4agUYMxASnQEzeDNpQQpi62xEHmf
        DuYPrA1qZy5XxlAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9793713583;
        Mon,  9 Jan 2023 16:33:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id KfXrJMFBvGOKdgAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 09 Jan 2023 16:33:05 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 21B24A0749; Mon,  9 Jan 2023 17:33:05 +0100 (CET)
Date:   Mon, 9 Jan 2023 17:33:05 +0100
From:   Jan Kara <jack@suse.cz>
To:     lijiazi <jqqlijiazi@gmail.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>, jiazi.li@transsion.com,
        linux-fsdevel@vger.kernel.org
Subject: Re: inactive buffer head in lrus prevents page migrate
Message-ID: <20230109163305.wu7itl2jcm22ca7q@quack3>
References: <20221012094011.GB19004@Jiazi.Li>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221012094011.GB19004@Jiazi.Li>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Reading some old email... Maybe the reply is still useful.

On Wed 12-10-22 17:40:11, lijiazi wrote:
> I recently encountered a CMA page migration failure issue.
> This page has private, and private data is buffer_head struct pointer.
> buffer_head->b_count is not zero, so drop_buffers failed.
> 
> This leads to the failure of both directly reclaim and migration attempts for
> this page.
> Finally, CMA memory alloc failed.
> 
> This buffer_head detail info are as follows:
> 
> crash> struct buffer_head 0xffffffec9f0200d0 -x
> struct buffer_head {
>   b_state = 0x29, //has Uptodate, Req, Mapped flags
>   b_this_page = 0xffffffec9f0200d0,
>   b_page = 0xffffffbfb4bb0080,
>   b_blocknr = 0x801b,
>   b_size = 0x1000,
>   b_data = 0xffffffed2ec02000 "\244\201",
>   b_bdev = 0xffffffed169b2580,
>   b_end_io = 0xffffff91006c44e4 <end_buffer_read_sync>,
>   b_private = 0x0,
>   b_assoc_buffers = {
>     next = 0xffffffec9f020118,
>     prev = 0xffffffec9f020118
>   },
>   b_assoc_map = 0x0,
>   b_count = {
>     counter = 0x1
>   }
> }
> 
> The b_count is 1, just because it's in cpu6 bh_lru:
> crash> p bh_lrus:a | grep 0xffffffec9f0200d0 -B 1
> per_cpu(bh_lrus, 6) = $7 = {
>   bhs = {0xffffffed146867b8, 0xffffffec9f020548, 0xffffffed0f7e3138, 0xffffffed0f7e30d0,
> 	 0xffffffed0f6f7340, 0xffffffed0b8c59c0, 0xffffffeb7bdb7888, 0xffffffed0b8c5548,
> 	 0xffffffed0f7b7270, 0xffffffed0f7b7208, 0xffffffed0f7b7138, 0xffffffec9f0200d0,//this entry
> 	 0xffffffed0f7b7068, 0xffffffed0f7b7000, 0xffffffed0f7b7bc8, 0xffffffec9f020068}
> 
> On my device using kernel-4.19, inactive bh may be in bh_lrus for a long
> time, and cause the corresponding page migration failure.
> 
> In function buffer_busy, can we check if b_count is greater than zero
> just because it's in bh_lrus?
> If yes, can we evict some inactive bhs to improve the success rate of
> migration?

Not sure about your codebase but at least upstream __buffer_migrate_folio()
(which used to be buffer_migrate_page() in your kernel) does
invalidate_bh_lrus() call if it finds any buffer is busy, exactly to avoid
this problem. Maybe you're missing some backport?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
