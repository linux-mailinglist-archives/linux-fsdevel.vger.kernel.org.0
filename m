Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D3AE77C065
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Aug 2023 21:10:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbjHNTKR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Aug 2023 15:10:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231834AbjHNTJm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Aug 2023 15:09:42 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D826310F2;
        Mon, 14 Aug 2023 12:09:41 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 68B8E21921;
        Mon, 14 Aug 2023 19:09:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1692040180; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=onjKw2D7T28KbiV2fqNVPG/lTv3CeMZukA/2FuhuI3k=;
        b=OaoCL+1HGmRHBb/F9NAWbs1Yqpa6tVc9MIOMVhrIMHAqEdUNMLyHbG0FGdhY90iwfKuI5k
        j9TCcXQEfk026eQ3FqiDSRR1GGqdp8VHedICVMqlRHvR+fGIDPOr+TjttqKQVHBiShlhgY
        P3wILlVnPYGNSNAK425Epk4m9m4zUG8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1692040180;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=onjKw2D7T28KbiV2fqNVPG/lTv3CeMZukA/2FuhuI3k=;
        b=kRIzSOepmu2YkLWh1KFqx2AkwdR4+jq7yPp/s/r6AK4a2fNs8aCyiw1PyGOKEFF9ftMRoe
        5rjqLvHyahidoDCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1A2F8138EE;
        Mon, 14 Aug 2023 19:09:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id zankOfN72mQLdwAAMHmgww
        (envelope-from <krisman@suse.de>); Mon, 14 Aug 2023 19:09:39 +0000
From:   Gabriel Krisman Bertazi <krisman@suse.de>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH 1/3] ext4: reject casefold inode flag without casefold
 feature
In-Reply-To: <20230814182903.37267-2-ebiggers@kernel.org> (Eric Biggers's
        message of "Mon, 14 Aug 2023 11:29:01 -0700")
Organization: SUSE
References: <20230814182903.37267-1-ebiggers@kernel.org>
        <20230814182903.37267-2-ebiggers@kernel.org>
Date:   Mon, 14 Aug 2023 15:09:33 -0400
Message-ID: <87jztx5tle.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Eric Biggers <ebiggers@kernel.org> writes:

> From: Eric Biggers <ebiggers@google.com>
>
> It is invalid for the casefold inode flag to be set without the casefold
> superblock feature flag also being set.  e2fsck already considers this
> case to be invalid and handles it by offering to clear the casefold flag
> on the inode.  __ext4_iget() also already considered this to be invalid,
> sort of, but it only got so far as logging an error message; it didn't
> actually reject the inode.  Make it reject the inode so that other code
> doesn't have to handle this case.  This matches what f2fs does.
>
> Note: we could check 's_encoding != NULL' instead of
> ext4_has_feature_casefold().  This would make the check robust against
> the casefold feature being enabled by userspace writing to the page
> cache of the mounted block device.  However, it's unsolvable in general
> for filesystems to be robust against concurrent writes to the page cache
> of the mounted block device.  Though this very particular scenario
> involving the casefold feature is solvable, we should not pretend that
> we can support this model, so let's just check the casefold feature.
> tune2fs already forbids enabling casefold on a mounted filesystem.

just because we can't fix the general issue for the entire filesystem
doesn't mean this case *must not* ever be addressed. What is the
advantage of making the code less robust against the syzbot code?  Just
check sb->s_encoding and be safe later knowing the unicode map is
available.

>
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
>  fs/ext4/inode.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 43775a6ca505..390dedbb7e8a 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -4940,9 +4940,12 @@ struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
>  				 "iget: bogus i_mode (%o)", inode->i_mode);
>  		goto bad_inode;
>  	}
> -	if (IS_CASEFOLDED(inode) && !ext4_has_feature_casefold(inode->i_sb))
> +	if (IS_CASEFOLDED(inode) && !ext4_has_feature_casefold(inode->i_sb)) {
>  		ext4_error_inode(inode, function, line, 0,
>  				 "casefold flag without casefold feature");
> +		ret = -EFSCORRUPTED;
> +		goto bad_inode;
> +	}
>  	if ((err_str = check_igot_inode(inode, flags)) != NULL) {
>  		ext4_error_inode(inode, function, line, 0, err_str);
>  		ret = -EFSCORRUPTED;

-- 
Gabriel Krisman Bertazi
