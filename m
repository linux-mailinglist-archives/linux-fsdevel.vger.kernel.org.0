Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DA9D76CB0A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Aug 2023 12:38:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234075AbjHBKij (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Aug 2023 06:38:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232480AbjHBKiM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Aug 2023 06:38:12 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD2254682;
        Wed,  2 Aug 2023 03:34:24 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 764A41F747;
        Wed,  2 Aug 2023 10:34:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1690972463; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MR58NMBglJtxUxpSgzfkjnZorzDEMsBbaguIyc3mpKs=;
        b=TmbFmgfwfLg9UiwJyY4spbAzOMrXavHMXBOiqxAIOwPFBgpM+LJm0+qmZCaBUIZGCDTGrE
        fRg903IGUjPcrRFNtuZGT0D6u3CFXvgSqDTTPtmfR20P33YAX5EhhQgEwLKGstRMxY8IYP
        /WQZ2vIFg4FibpaKv4AS/V3BxxqhZxE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1690972463;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MR58NMBglJtxUxpSgzfkjnZorzDEMsBbaguIyc3mpKs=;
        b=ErQJZxwi/4DRe4LY5xycNVKcu6lQanAV3vJzTxo1eJ/06fLw6ANa8v4Z0yYYiLNgvvT/f4
        Ns5BsunpYqjDacCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6847113919;
        Wed,  2 Aug 2023 10:34:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id V9VqGS8xymSDCgAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 02 Aug 2023 10:34:23 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id EAB7CA076B; Wed,  2 Aug 2023 12:34:22 +0200 (CEST)
Date:   Wed, 2 Aug 2023 12:34:22 +0200
From:   Jan Kara <jack@suse.cz>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>,
        Christian Brauner <brauner@kernel.org>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH] ext4: fix the time handling macros when ext4 is using
 small inodes
Message-ID: <20230802103422.lzgb7yyksfbpw4rh@quack3>
References: <20230718-ctime-v1-1-24e2f96dcdf3@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230718-ctime-v1-1-24e2f96dcdf3@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 18-07-23 13:31:59, Jeff Layton wrote:
> If ext4 is using small on-disk inodes, then it may not be able to store
> fine grained timestamps. It also can't store the i_crtime at all in that
> case since that fully lives in the extended part of the inode.
> 
> 979492850abd got the EXT4_EINODE_{GET,SET}_XTIME macros wrong, and would
> still store the tv_sec field of the i_crtime into the raw_inode, even
> when they were small, corrupting adjacent memory.
> 
> This fixes those macros to skip setting anything in the raw_inode if the
> tv_sec field doesn't fit, and to properly return a {0,0} timestamp when
> the raw_inode doesn't support it.
> 
> Cc: Jan Kara <jack@suse.cz>
> Fixes: 979492850abd ("ext4: convert to ctime accessor functions")
> Reported-by: Hugh Dickins <hughd@google.com>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

I've seen Christian has already folded this fixup so I just want to say:
Thanks for fixing this up while I was away!

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
