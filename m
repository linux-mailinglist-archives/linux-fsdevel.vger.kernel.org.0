Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F18579FE85
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Sep 2023 10:35:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236387AbjINIfy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Sep 2023 04:35:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236334AbjINIfx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Sep 2023 04:35:53 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9478EB
        for <linux-fsdevel@vger.kernel.org>; Thu, 14 Sep 2023 01:35:49 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 77FD12185C;
        Thu, 14 Sep 2023 08:35:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1694680548; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=68ixjezFjychLSk/ARwxyqHqjw2JZMbFHwrYo9sIkYE=;
        b=mqgMj9Fb6jEZpycFdkd3m2zmXf/vVbrgMBt30o46G30EHZK3ohocEYjl0kzS0uYY1jvuzf
        JyCrxuvOTRgqeQv11qYhswgYRv80bs5mmaefyfISZ2OAsVRz+UNnBIDOmPCE9AVJWoDc+9
        OmaV1g+9jWftqLNenZtadbjuKApOWP8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1694680548;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=68ixjezFjychLSk/ARwxyqHqjw2JZMbFHwrYo9sIkYE=;
        b=aoxETUzX8zXPnPS3tqwYigHjpnbkoAq/LU88iuV4AomDR1psertmw+f1bc/z8R+sE63e+j
        4/b80RxnwM8hP0AQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 68DAE13580;
        Thu, 14 Sep 2023 08:35:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 7eKPGeTFAmWYMAAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 14 Sep 2023 08:35:48 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id F1A3EA07C2; Thu, 14 Sep 2023 10:35:47 +0200 (CEST)
Date:   Thu, 14 Sep 2023 10:35:47 +0200
From:   Jan Kara <jack@suse.cz>
To:     Reuben Hawkins <reubenhwk@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, amir73il@gmail.com,
        mszeredi@redhat.com, willy@infradead.org, viro@zeniv.linux.org.uk,
        brauner@kernel.org
Subject: Re: [PATCH v2] vfs: fix readahead(2) on block devices
Message-ID: <20230914083547.zppfoovcc7yemjht@quack3>
References: <20230911114713.25625-1-reubenhwk@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230911114713.25625-1-reubenhwk@gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 11-09-23 06:47:13, Reuben Hawkins wrote:
> Readahead was factored to call generic_fadvise.  That refactor added an
> S_ISREG restriction which broke readahead on block devices.
> 
> This change removes the S_ISREG restriction to fix block device readahead.
> The change also means that readahead will return -ESPIPE on FIFO files
> instead of -EINVAL.
> 
> Fixes: 3d8f7615319b ("vfs: implement readahead(2) using POSIX_FADV_WILLNEED")
> Signed-off-by: Reuben Hawkins <reubenhwk@gmail.com>

Nice catch! Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  mm/readahead.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/mm/readahead.c b/mm/readahead.c
> index e815c114de21..ef3b23a41973 100644
> --- a/mm/readahead.c
> +++ b/mm/readahead.c
> @@ -734,8 +734,7 @@ ssize_t ksys_readahead(int fd, loff_t offset, size_t count)
>  	 * on this file, then we must return -EINVAL.
>  	 */
>  	ret = -EINVAL;
> -	if (!f.file->f_mapping || !f.file->f_mapping->a_ops ||
> -	    !S_ISREG(file_inode(f.file)->i_mode))
> +	if (!f.file->f_mapping || !f.file->f_mapping->a_ops)
>  		goto out;
>  
>  	ret = vfs_fadvise(f.file, offset, count, POSIX_FADV_WILLNEED);
> -- 
> 2.34.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
