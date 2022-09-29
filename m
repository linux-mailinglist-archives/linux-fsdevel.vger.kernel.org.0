Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7E2F5EF6C0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Sep 2022 15:39:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234946AbiI2NjY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Sep 2022 09:39:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234856AbiI2NjX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Sep 2022 09:39:23 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AAAC18A48F;
        Thu, 29 Sep 2022 06:39:22 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C1FE81F8AC;
        Thu, 29 Sep 2022 13:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1664458760; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ns2J5FCqMyaCVXAnlOwlYGE0L/n4dIeDiQPDs896ezA=;
        b=IjHgqEycgP5J5wD2VLtonf+O1JFaEAlB2L/rY9szh34RIByWZDffula3+ZxNprIQvguaAG
        uEgekbkMgXYkvo1ApZ5trxjIixhRO2mrk1cf7bDAsSwjOieA97PVgsp1g/30wnWDEV5rET
        Iv7mvC2sImR4NKq151WheRZNvzxFSz8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1664458760;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ns2J5FCqMyaCVXAnlOwlYGE0L/n4dIeDiQPDs896ezA=;
        b=TuFYLQQcGaR9AcwAgJye4uhGokl2Gf8cI0mVsUFJsMZpMFPwN5EohuYrzfk+e4PYT0s3Tt
        OGy9UulWHTUO8xBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B47331348E;
        Thu, 29 Sep 2022 13:39:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id fsUALAigNWPMKwAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 29 Sep 2022 13:39:20 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 4EDB8A0681; Thu, 29 Sep 2022 15:39:20 +0200 (CEST)
Date:   Thu, 29 Sep 2022 15:39:20 +0200
From:   Jan Kara <jack@suse.cz>
To:     Zhihao Cheng <chengzhihao1@huawei.com>
Cc:     jack@suse.com, tytso@mit.edu, brauner@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com
Subject: Re: [PATCH v3 0/3] Check content after reading from quota file
Message-ID: <20220929133920.ckqbg7qjm557yyp3@quack3>
References: <20220923134555.2623931-1-chengzhihao1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220923134555.2623931-1-chengzhihao1@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 23-09-22 21:45:51, Zhihao Cheng wrote:
> v1->v2:
>   Add CC-stable tag in first patch.
>   Rename check_free_block() -> check_dquot_block_header().
> v2->v3:
>   Define do_check_range() completely in patch 1.
>   Move 'dqdh_entries' checking into check_dquot_block_header().
>   Do block checing later in find_next_id().
> 
> Zhihao Cheng (3):
>   quota: Check next/prev free block number after reading from quota file
>   quota: Replace all block number checking with helper function
>   quota: Add more checking after reading from quota file
> 
>  fs/quota/quota_tree.c | 73 ++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 61 insertions(+), 12 deletions(-)

Thanks! I've merged the patches to my tree now!

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
