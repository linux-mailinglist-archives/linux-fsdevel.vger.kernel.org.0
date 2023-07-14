Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCB407530CF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Jul 2023 07:00:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234417AbjGNFAe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Jul 2023 01:00:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232670AbjGNFAd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Jul 2023 01:00:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3941F2D40;
        Thu, 13 Jul 2023 22:00:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 75BD861BF5;
        Fri, 14 Jul 2023 05:00:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 934F3C433C7;
        Fri, 14 Jul 2023 05:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689310830;
        bh=QzWokqxMlJGGBJ8InXGlEOPwPkVO/C5DuMF8p5rfuaE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PduTiZ8iu1FlTJIHhn4f7FVNuGIbB4f+Z4cZT18CGgVWzGOc8C2fyxNN/yNn/qFbA
         Fwwa+isVWU5GP804E5iS2ksmvvI2/56Q9srWh4XB26UKcyeDG0nqSumlxw1dh7AB1p
         GtYK6rJ1zL+s5jgcwu7Yxyxm+d5z3oWBQEWuR5y4R2SJWasM+V9tCMKYWTFGaF0e64
         O3IoCduSBCEy9RMSIePJiMPb+t7pSu1DXpcpF+rkgpQIA9/13170cCNbadw7l+gme3
         9TqFi0uLhlpEufD+Uj87BVuRqUYmj+U3QEVobivPBn3wEIbYwG0sOpmJ+2qal9EZsX
         jLtxjZckqpiLw==
Date:   Thu, 13 Jul 2023 22:00:28 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Gabriel Krisman Bertazi <krisman@suse.de>
Cc:     viro@zeniv.linux.org.uk, brauner@kernel.org, tytso@mit.edu,
        jaegeuk@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH v2 3/7] libfs: Validate negative dentries in
 case-insensitive directories
Message-ID: <20230714050028.GC913@sol.localdomain>
References: <20230422000310.1802-1-krisman@suse.de>
 <20230422000310.1802-4-krisman@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230422000310.1802-4-krisman@suse.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_FILL_THIS_FORM_SHORT,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 21, 2023 at 08:03:06PM -0400, Gabriel Krisman Bertazi wrote:
> diff --git a/fs/libfs.c b/fs/libfs.c
> index 4eda519c3002..f8881e29c5d5 100644
> --- a/fs/libfs.c
> +++ b/fs/libfs.c
> @@ -1467,9 +1467,43 @@ static int generic_ci_d_hash(const struct dentry *dentry, struct qstr *str)
>  	return 0;
>  }
>  
> +static inline int generic_ci_d_revalidate(struct dentry *dentry,
> +					  const struct qstr *name,
> +					  unsigned int flags)
> +{
> +	int is_creation = flags & (LOOKUP_CREATE | LOOKUP_RENAME_TARGET);
> +
> +	if (d_is_negative(dentry)) {
> +		const struct dentry *parent = READ_ONCE(dentry->d_parent);
> +		const struct inode *dir = READ_ONCE(parent->d_inode);
> +
> +		if (dir && needs_casefold(dir)) {
> +			if (!d_is_casefold_lookup(dentry))
> +				return 0;

A comment that explains why the !d_is_casefold_lookup() check is needed would be
helpful.  I know it's in the commit message, but that's not enough.

> +
> +			if (is_creation) {
> +				/*
> +				 * dentry->d_name won't change from under us in
> +				 * the is_creation path only, since d_revalidate
> +				 * during creation and renames is always called
> +				 * with the parent inode locked.  This isn't the
> +				 * case for all lookup callpaths, so it should
> +				 * not be accessed outside
> +				 * (LOOKUP_CREATE|LOOKUP_RENAME_TARGET) context.
> +				 */
> +				if (dentry->d_name.len != name->len ||
> +				    memcmp(dentry->d_name.name, name->name, name->len))
> +					return 0;
> +			}
> +		}
> +	}
> +	return 1;
> +}

I notice that the existing vfat_revalidate_ci() in fs/fat/namei_vfat.c behaves
differently in the 'flags == 0' case:


	/*
	 * This may be nfsd (or something), anyway, we can't see the
	 * intent of this. So, since this can be for creation, drop it.
	 */
	if (!flags)
		return 0;

I don't know whether that's really needed, but have you thought about this?

- Eric
