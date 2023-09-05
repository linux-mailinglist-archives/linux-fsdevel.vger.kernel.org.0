Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 822107924E5
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Sep 2023 18:00:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233516AbjIEQAM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Sep 2023 12:00:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354009AbjIEJLb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Sep 2023 05:11:31 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 686F0D8;
        Tue,  5 Sep 2023 02:11:26 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 264EC1F74D;
        Tue,  5 Sep 2023 09:11:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1693905085; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=v79WjEoDs9F3Vjum42PGJ2z1rLJctnjtDsFsxwG5ncw=;
        b=YwCV9ly9uMbP4j/3wlPUUVRkCgsnK1naBjvvJPu4QBUMKwCOEgjaPZlqrvgy603pTk8hlk
        coK14ruzlL73hUQUgNmR88ZDkdIXjiAjCM/edY46kkdfypsGJxiuvkBtZdL3eOQkf8SC3X
        f4wfQ5CTl9QdaSASXxJ0rYZo7QGOAQE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1693905085;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=v79WjEoDs9F3Vjum42PGJ2z1rLJctnjtDsFsxwG5ncw=;
        b=BoCEOx9hi3vLZ2Hors/zNhmhQX/Iy59H63pmpDIj9rxrwzvt9S6IElLpLmEQ/zEDcOiCow
        XDcu+G2NGV120lAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 18D8013499;
        Tue,  5 Sep 2023 09:11:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id hQf6Bb3w9mR7JgAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 05 Sep 2023 09:11:25 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id A6B15A0776; Tue,  5 Sep 2023 11:11:24 +0200 (CEST)
Date:   Tue, 5 Sep 2023 11:11:24 +0200
From:   Jan Kara <jack@suse.cz>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Jan Kara <jack@suse.com>, linux-fscrypt@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, stable@vger.kernel.org
Subject: Re: [PATCH] quota: explicitly forbid quota files from being encrypted
Message-ID: <20230905091124.giawwm3tu6fm2buq@quack3>
References: <20230905003227.326998-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230905003227.326998-1-ebiggers@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 04-09-23 17:32:27, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Since commit d7e7b9af104c ("fscrypt: stop using keyrings subsystem for
> fscrypt_master_key"), xfstest generic/270 causes a WARNING when run on
> f2fs with test_dummy_encryption in the mount options:
> 
> $ kvm-xfstests -c f2fs/encrypt generic/270
> [...]
> WARNING: CPU: 1 PID: 2453 at fs/crypto/keyring.c:240 fscrypt_destroy_keyring+0x1f5/0x260
> 
> The cause of the WARNING is that not all encrypted inodes have been
> evicted before fscrypt_destroy_keyring() is called, which violates an
> assumption.  This happens because the test uses an external quota file,
> which gets automatically encrypted due to test_dummy_encryption.
> 
> Encryption of quota files has never really been supported.  On ext4,
> ext4_quota_read() does not decrypt the data, so encrypted quota files
> are always considered invalid on ext4.  On f2fs, f2fs_quota_read() uses
> the pagecache, so trying to use an encrypted quota file gets farther,
> resulting in the issue described above being possible.  But this was
> never intended to be possible, and there is no use case for it.
> 
> Therefore, make the quota support layer explicitly reject using
> IS_ENCRYPTED inodes when quotaon is attempted.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Looks good. I'll queue this patch into my tree and send it to Linus for
RC2.

								Honza

> ---
>  fs/quota/dquot.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
> index 9e72bfe8bbad9..7e268cd2727cc 100644
> --- a/fs/quota/dquot.c
> +++ b/fs/quota/dquot.c
> @@ -2339,6 +2339,20 @@ static int vfs_setup_quota_inode(struct inode *inode, int type)
>  	if (sb_has_quota_loaded(sb, type))
>  		return -EBUSY;
>  
> +	/*
> +	 * Quota files should never be encrypted.  They should be thought of as
> +	 * filesystem metadata, not user data.  New-style internal quota files
> +	 * cannot be encrypted by users anyway, but old-style external quota
> +	 * files could potentially be incorrectly created in an encrypted
> +	 * directory, hence this explicit check.  Some reasons why encrypted
> +	 * quota files don't work include: (1) some filesystems that support
> +	 * encryption don't handle it in their quota_read and quota_write, and
> +	 * (2) cleaning up encrypted quota files at unmount would need special
> +	 * consideration, as quota files are cleaned up later than user files.
> +	 */
> +	if (IS_ENCRYPTED(inode))
> +		return -EINVAL;
> +
>  	dqopt->files[type] = igrab(inode);
>  	if (!dqopt->files[type])
>  		return -EIO;
> 
> base-commit: 708283abf896dd4853e673cc8cba70acaf9bf4ea
> -- 
> 2.42.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
