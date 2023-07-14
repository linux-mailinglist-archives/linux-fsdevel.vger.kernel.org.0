Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F59675315D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Jul 2023 07:40:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234899AbjGNFkX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Jul 2023 01:40:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234787AbjGNFkT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Jul 2023 01:40:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B61562738;
        Thu, 13 Jul 2023 22:40:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3EDE461C11;
        Fri, 14 Jul 2023 05:40:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51FFEC433C7;
        Fri, 14 Jul 2023 05:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689313216;
        bh=/ol5axUvlJefWQd68V0SGGSQUQblf2xCDTj6ilSSOck=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K/qaDPeog95g7fGiCfUXnsUqlrU+jq+roS/vQAeGo0jBIGM4VH9fEoVVmCUKxDb1+
         q3BD8rcolyEdPzwxnhg0tcUw/SP+OL0fFt3/uEo1yTYz+e0PlTeb/3D5DlbUTT2JYX
         pRtBESOCH/LrO2C0hfdgPbi99gwhpgHwz25PZoaSosXExddrDDI5SgLsdo1YZhxebT
         9I7freBJu0zIzr8WrofubjomRomL/RAg/JzwiHUNsVY7yfiWuiHYTuCZyq4XRZzCUr
         sGbMdzMrzdsoohluRd1z+jDuKC4sSCwuXq24j6lUD0o4JODtff2rVAL3p5tGjJ5EOv
         xT7bsw+GwVn+A==
Date:   Thu, 13 Jul 2023 22:40:14 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Gabriel Krisman Bertazi <krisman@suse.de>
Cc:     viro@zeniv.linux.org.uk, brauner@kernel.org, tytso@mit.edu,
        jaegeuk@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH v2 5/7] libfs: Merge encrypted_ci_dentry_ops and
 ci_dentry_ops
Message-ID: <20230714054014.GE913@sol.localdomain>
References: <20230422000310.1802-1-krisman@suse.de>
 <20230422000310.1802-6-krisman@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230422000310.1802-6-krisman@suse.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 21, 2023 at 08:03:08PM -0400, Gabriel Krisman Bertazi wrote:
> From: Gabriel Krisman Bertazi <krisman@collabora.com>
> 
> Now that casefold needs d_revalidate and calls fscrypt_d_revalidate
> itself, generic_encrypt_ci_dentry_ops and generic_ci_dentry_ops are now
> equivalent.  Merge them together and simplify the setup code.
> 
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
> ---
>  fs/libfs.c | 44 +++++++++++++-------------------------------
>  1 file changed, 13 insertions(+), 31 deletions(-)
> 
> diff --git a/fs/libfs.c b/fs/libfs.c
> index 0886044db593..348ec6130198 100644
> --- a/fs/libfs.c
> +++ b/fs/libfs.c
> @@ -1504,7 +1504,7 @@ static inline int generic_ci_d_revalidate(struct dentry *dentry,
>  	return fscrypt_d_revalidate(dentry, flags);
>  }
>  
> -static const struct dentry_operations generic_ci_dentry_ops = {
> +static const struct dentry_operations generic_encrypted_ci_dentry_ops = {
>  	.d_hash = generic_ci_d_hash,
>  	.d_compare = generic_ci_d_compare,
>  	.d_revalidate_name = generic_ci_d_revalidate,
> @@ -1517,26 +1517,20 @@ static const struct dentry_operations generic_encrypted_dentry_ops = {
>  };
>  #endif
>  
> -#if defined(CONFIG_FS_ENCRYPTION) && IS_ENABLED(CONFIG_UNICODE)
> -static const struct dentry_operations generic_encrypted_ci_dentry_ops = {
> -	.d_hash = generic_ci_d_hash,
> -	.d_compare = generic_ci_d_compare,
> -	.d_revalidate_name = generic_ci_d_revalidate,
> -};
> -#endif
> -
>  /**
>   * generic_set_encrypted_ci_d_ops - helper for setting d_ops for given dentry
>   * @dentry:	dentry to set ops on
>   *
> - * Casefolded directories need d_hash and d_compare set, so that the dentries
> - * contained in them are handled case-insensitively.  Note that these operations
> - * are needed on the parent directory rather than on the dentries in it, and
> - * while the casefolding flag can be toggled on and off on an empty directory,
> - * dentry_operations can't be changed later.  As a result, if the filesystem has
> - * casefolding support enabled at all, we have to give all dentries the
> - * casefolding operations even if their inode doesn't have the casefolding flag
> - * currently (and thus the casefolding ops would be no-ops for now).
> + * Casefolded directories need d_hash, d_compare and d_revalidate set, so
> + * that the dentries contained in them are handled case-insensitively,
> + * but implement support for fs_encryption.  Note that these operations

The part ", but implement support for fs_encryption" is confusing.  It would be
clearer with that deleted, since encryption is covered by the next paragraph.

> + * are needed on the parent directory rather than on the dentries in it,
> + * and while the casefolding flag can be toggled on and off on an empty
> + * directory, dentry_operations can't be changed later.  As a result, if
> + * the filesystem has casefolding support enabled at all, we have to
> + * give all dentries the casefolding operations even if their inode
> + * doesn't have the casefolding flag currently (and thus the casefolding
> + * ops would be no-ops for now).
>   *
>   * Encryption works differently in that the only dentry operation it needs is
>   * d_revalidate, which it only needs on dentries that have the no-key name flag.
>   * The no-key flag can't be set "later", so we don't have to worry about that.
>   *
>   * Finally, to maximize compatibility with overlayfs (which isn't compatible
>   * with certain dentry operations) and to avoid taking an unnecessary
>   * performance hit, we use custom dentry_operations for each possible
>   * combination rather than always installing all operations.

When I wrote the last paragraph, I think I had in mind "each possible
combination of features".  Now it's changing in meaning to "each possible
combination of operations".  Maybe replace it with that to make it clearer?

- Eric
