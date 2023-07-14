Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96E1B75317F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Jul 2023 07:49:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234924AbjGNFt3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Jul 2023 01:49:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234921AbjGNFt2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Jul 2023 01:49:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93B6126BC;
        Thu, 13 Jul 2023 22:49:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2664C61C17;
        Fri, 14 Jul 2023 05:49:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49121C433C8;
        Fri, 14 Jul 2023 05:49:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689313766;
        bh=7DnQ3lPm58MYsorHdkMUvAqvzRj0azqqi5D765n2mkg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S579h9VF/gTjL7FvtkLYx19YYonmDP7oeWhNKTLavRhs6b3XqYHgciC57V+g2JAc6
         XDYLHNlyHIPB90N1QlVqUjNVjTxyaOg6ZCus0W7CSpPcYIuqXGgDChAB8aTb7TWtxC
         A2pqs2CMuucrYF7hFG6kcldXkI/W7HCnK06IDecW3moef29b2zPcK4doO2IUvh4Ydi
         0igEQZt+pNQk3PsQyt1sm21qdsqaiCQ3xvKjameBVU14iiQVByJpgZfhVWgrRIZvu3
         NRr/X6QyILlYhdnE6gydOJpJvUQX0oua2oHDN7N+GHaEOqaB3yLnswxVELldGyWbkQ
         MFzFnxcJJdtjw==
Date:   Thu, 13 Jul 2023 22:49:24 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Gabriel Krisman Bertazi <krisman@suse.de>
Cc:     viro@zeniv.linux.org.uk, brauner@kernel.org, tytso@mit.edu,
        jaegeuk@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH v2 7/7] f2fs: Enable negative dentries on
 case-insensitive lookup
Message-ID: <20230714054924.GF913@sol.localdomain>
References: <20230422000310.1802-1-krisman@suse.de>
 <20230422000310.1802-8-krisman@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230422000310.1802-8-krisman@suse.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 21, 2023 at 08:03:10PM -0400, Gabriel Krisman Bertazi wrote:
> From: Gabriel Krisman Bertazi <krisman@collabora.com>
> 
> Instead of invalidating negative dentries during case-insensitive
> lookups, mark them as such and let them be added to the dcache.
> d_ci_revalidate is able to properly filter them out if necessary based
> on the dentry casefold flag.
> 
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
> ---
>  fs/f2fs/namei.c | 23 ++---------------------
>  1 file changed, 2 insertions(+), 21 deletions(-)
> 
> diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
> index 11fc4c8036a9..57ca7ea86509 100644
> --- a/fs/f2fs/namei.c
> +++ b/fs/f2fs/namei.c
> @@ -564,17 +564,8 @@ static struct dentry *f2fs_lookup(struct inode *dir, struct dentry *dentry,
>  		goto out_iput;
>  	}
>  out_splice:
> -#if IS_ENABLED(CONFIG_UNICODE)
> -	if (!inode && IS_CASEFOLDED(dir)) {
> -		/* Eventually we want to call d_add_ci(dentry, NULL)
> -		 * for negative dentries in the encoding case as
> -		 * well.  For now, prevent the negative dentry
> -		 * from being cached.
> -		 */
> -		trace_f2fs_lookup_end(dir, dentry, ino, err);
> -		return NULL;
> -	}
> -#endif
> +	if (IS_ENABLED(CONFIG_UNICODE) && IS_CASEFOLDED(dir))
> +		d_set_casefold_lookup(dentry);

I wonder if a more consistent place for the above code would be earlier in
f2fs_lookup(), next to the call to generic_set_encrypted_ci_d_ops()?  That's
where the dentry_operations are set.  It's also next to f2fs_prepare_lookup()
which is where DCACHE_NOKEY_NAME gets set if needed.

- Eric
