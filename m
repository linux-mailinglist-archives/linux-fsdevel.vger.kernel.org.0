Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2812779C6B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Aug 2023 03:59:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236157AbjHLB7T (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Aug 2023 21:59:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbjHLB7T (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Aug 2023 21:59:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5277630F8;
        Fri, 11 Aug 2023 18:59:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DB224629E9;
        Sat, 12 Aug 2023 01:59:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06E97C433C7;
        Sat, 12 Aug 2023 01:59:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691805557;
        bh=nAJmbpwTFQg79wN1L8Hwf7i2NhG4ry3JrZqe/1RgP6Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uo+6bf47lZ6FIDB/B6UeLXM9d5L7Wkv8oX/AwcApqynO7J5p1UBnfMdR91KELqHqc
         F1QL7ifceNwBQmF6ny1QzGIbHPdZvQIfEj53kJ3QOhKHCRz/S/eEBo6AhpDLpwDiVE
         xDKzrW766UaBxMsBJ5IDiaSuwwnSC6+FgDFrER5i2Th+1WVD6tGy7ca1sYVl2ZZHl4
         C5tyTThejdiELIai1/gNPgpHDzLE0cFycvpifjF2db5MREBAPdIJ415qdvmHvgBq9k
         aLOh1GK+dTbQW2H80fWrWTbAbq0kU3AG/ZC07Y47Yx/hvtbQde1GdDGxdVmzDXSLrL
         4qME5GREFAxLg==
Date:   Fri, 11 Aug 2023 18:59:15 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Gabriel Krisman Bertazi <krisman@suse.de>
Cc:     viro@zeniv.linux.org.uk, brauner@kernel.org, tytso@mit.edu,
        jaegeuk@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH v5 01/10] fs: Expose helper to check if a directory needs
 casefolding
Message-ID: <20230812015915.GA971@sol.localdomain>
References: <20230812004146.30980-1-krisman@suse.de>
 <20230812004146.30980-2-krisman@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230812004146.30980-2-krisman@suse.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 11, 2023 at 08:41:37PM -0400, Gabriel Krisman Bertazi wrote:
> In preparation to use it in ecryptfs, move needs_casefolding into a
> public header and give it a namespaced name.
> 
> Signed-off-by: Gabriel Krisman Bertazi <krisman@suse.de>
> ---
>  fs/libfs.c         | 14 ++------------
>  include/linux/fs.h | 21 +++++++++++++++++++++
>  2 files changed, 23 insertions(+), 12 deletions(-)
> 
> diff --git a/fs/libfs.c b/fs/libfs.c
> index 5b851315eeed..8d0b64cfd5da 100644
> --- a/fs/libfs.c
> +++ b/fs/libfs.c
> @@ -1381,16 +1381,6 @@ bool is_empty_dir_inode(struct inode *inode)
>  }
>  
>  #if IS_ENABLED(CONFIG_UNICODE)
> -/*
> - * Determine if the name of a dentry should be casefolded.
> - *
> - * Return: if names will need casefolding
> - */
> -static bool needs_casefold(const struct inode *dir)
> -{
> -	return IS_CASEFOLDED(dir) && dir->i_sb->s_encoding;
> -}
> -
>  /**
>   * generic_ci_d_compare - generic d_compare implementation for casefolding filesystems
>   * @dentry:	dentry whose name we are checking against
> @@ -1411,7 +1401,7 @@ static int generic_ci_d_compare(const struct dentry *dentry, unsigned int len,
>  	char strbuf[DNAME_INLINE_LEN];
>  	int ret;
>  
> -	if (!dir || !needs_casefold(dir))
> +	if (!dir || !dir_is_casefolded(dir))
>  		goto fallback;
>  	/*
>  	 * If the dentry name is stored in-line, then it may be concurrently
> @@ -1453,7 +1443,7 @@ static int generic_ci_d_hash(const struct dentry *dentry, struct qstr *str)
>  	const struct unicode_map *um = sb->s_encoding;
>  	int ret = 0;
>  
> -	if (!dir || !needs_casefold(dir))
> +	if (!dir || !dir_is_casefolded(dir))
>  		return 0;
>  
>  	ret = utf8_casefold_hash(um, dentry, str);
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 6867512907d6..e3b631c6d24a 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -3213,6 +3213,27 @@ static inline bool dir_relax_shared(struct inode *inode)
>  	return !IS_DEADDIR(inode);
>  }
>  
> +/**
> + * dir_is_casefolded - Safely determine if filenames inside of a
> + * directory should be casefolded.
> + * @dir: The directory inode to be checked
> + *
> + * Filesystems should usually rely on this instead of checking the
> + * S_CASEFOLD flag directly when handling inodes, to avoid surprises
> + * with corrupted volumes.  Checking i_sb->s_encoding ensures the
> + * filesystem knows how to deal with case-insensitiveness.
> + *
> + * Return: if names will need casefolding
> + */
> +static inline bool dir_is_casefolded(const struct inode *dir)
> +{
> +#if IS_ENABLED(CONFIG_UNICODE)
> +	return IS_CASEFOLDED(dir) && dir->i_sb->s_encoding;
> +#else
> +	return false;
> +#endif
> +}

To be honest I've always been confused about why the ->s_encoding check is
there.  It looks like Ted added it in 6456ca6520ab ("ext4: fix kernel oops
caused by spurious casefold flag") to address a fuzzing report for a filesystem
that had a casefolded directory but didn't have the casefold feature flag set.
It seems like an unnecessarily complex fix, though.  The filesystem should just
reject the inode earlier, in __ext4_iget().  And likewise for f2fs.  Then no
other code has to worry about this problem.

Actually, f2fs already does it, as I added it in commit f6322f3f1212:

        if ((fi->i_flags & F2FS_CASEFOLD_FL) && !f2fs_sb_has_casefold(sbi)) {
                set_sbi_flag(sbi, SBI_NEED_FSCK);
                f2fs_warn(sbi, "%s: inode (ino=%lx) has casefold flag, but casefold feature is off",
                          __func__, inode->i_ino);
                return false;
        }

So just __ext4_iget() needs to be fixed.  I think we should consider doing that
before further entrenching all the extra ->s_encoding checks.

Also I don't understand why this needs to be part of your patch series anyway.
Shouldn't eCryptfs check IS_CASEFOLDED() anyway?

- Eric
