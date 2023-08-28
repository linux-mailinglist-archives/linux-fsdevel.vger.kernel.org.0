Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F61F78B52A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Aug 2023 18:13:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232699AbjH1QNS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Aug 2023 12:13:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232693AbjH1QM5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Aug 2023 12:12:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA10EBF;
        Mon, 28 Aug 2023 09:12:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 45696629C7;
        Mon, 28 Aug 2023 16:12:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98108C433CA;
        Mon, 28 Aug 2023 16:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693239172;
        bh=UlOpgZ1tTkEvhgiFkpB4fX52Blna1Vdbp2aw+mf4OyI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PaQaZTm0bop52Wh7cRun2MIqNp2xzkJRnte2fNo1uK4IXlOx1giGdjBJ8pSZr67td
         Jyx4nv7OkHMmbn4NjSC+657pCJ/JWbrAxPoSUDnwQc1Var2pGb4p/9fLx2qDUAhVYW
         rsB17DrlJI4mhtrNwBdunYfT5yIY/Rk+RHeDEuonrxFLOSrgiQyVqgzkYveTBn9rSj
         kYovnFPOTYgNHhS+XDenTzXSrj84KPN7JW/NKwTbF/Clqcabsp6U1Qa96gKoJ5VPhj
         hvLXdYXOch/nSzwXrg+QKTSNfrQVXx7XpuJHBPwve/Kq4vR36UtUlspaht00Ialop6
         KIognVKQekHug==
Date:   Mon, 28 Aug 2023 09:12:51 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Jan Cincera <hcincera@gmail.com>
Cc:     Namjae Jeon <linkinjeon@kernel.org>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] exfat: add ioctls for accessing attributes
Message-ID: <20230828161251.GA28160@frogsfrogsfrogs>
References: <30bfc906-1d73-01c9-71d0-aa441ac34b96@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30bfc906-1d73-01c9-71d0-aa441ac34b96@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Aug 27, 2023 at 12:42:07PM +0200, Jan Cincera wrote:
> Add GET and SET attributes ioctls to enable attribute modification.
> We already do this in FAT and a few userspace utils made for it would
> benefit from this also working on exFAT, namely fatattr.
> 
> Signed-off-by: Jan Cincera <hcincera@gmail.com>
> ---
> Changes in v2:
>   - Removed irrelevant comments.
>   - Now masking reserved fields.
> 
>  fs/exfat/exfat_fs.h |  6 +++
>  fs/exfat/file.c     | 93 +++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 99 insertions(+)
> 
> diff --git a/fs/exfat/exfat_fs.h b/fs/exfat/exfat_fs.h
> index 729ada9e26e8..ebe8c4b928f4 100644
> --- a/fs/exfat/exfat_fs.h
> +++ b/fs/exfat/exfat_fs.h
> @@ -149,6 +149,12 @@ enum {
>  #define DIR_CACHE_SIZE		\
>  	(DIV_ROUND_UP(EXFAT_DEN_TO_B(ES_MAX_ENTRY_NUM), SECTOR_SIZE) + 1)
>  
> +/*
> + * attribute ioctls, same as their FAT equivalents.
> + */
> +#define EXFAT_IOCTL_GET_ATTRIBUTES	_IOR('r', 0x10, __u32)
> +#define EXFAT_IOCTL_SET_ATTRIBUTES	_IOW('r', 0x11, __u32)

Can you reuse the definitions from include/uapi/linux/msdos_fs.h instead
of redefining them here?

Otherwise this looks like a mostly straight port of the fs/fat/
versions of these functions.

--D

> +
>  struct exfat_dentry_namebuf {
>  	char *lfn;
>  	int lfnbuf_len; /* usually MAX_UNINAME_BUF_SIZE */
> diff --git a/fs/exfat/file.c b/fs/exfat/file.c
> index 3cbd270e0cba..b31ce0868ddd 100644
> --- a/fs/exfat/file.c
> +++ b/fs/exfat/file.c
> @@ -8,6 +8,8 @@
>  #include <linux/cred.h>
>  #include <linux/buffer_head.h>
>  #include <linux/blkdev.h>
> +#include <linux/fsnotify.h>
> +#include <linux/security.h>
>  
>  #include "exfat_raw.h"
>  #include "exfat_fs.h"
> @@ -316,6 +318,92 @@ int exfat_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
>  	return error;
>  }
>  
> +/*
> + * modified ioctls from fat/file.c by Welmer Almesberger
> + */
> +static int exfat_ioctl_get_attributes(struct inode *inode, u32 __user *user_attr)
> +{
> +	u32 attr;
> +
> +	inode_lock_shared(inode);
> +	attr = exfat_make_attr(inode);
> +	inode_unlock_shared(inode);
> +
> +	return put_user(attr, user_attr);
> +}
> +
> +static int exfat_ioctl_set_attributes(struct file *file, u32 __user *user_attr)
> +{
> +	struct inode *inode = file_inode(file);
> +	struct exfat_sb_info *sbi = EXFAT_SB(inode->i_sb);
> +	int is_dir = S_ISDIR(inode->i_mode);
> +	u32 attr, oldattr;
> +	struct iattr ia;
> +	int err;
> +
> +	err = get_user(attr, user_attr);
> +	if (err)
> +		goto out;
> +
> +	err = mnt_want_write_file(file);
> +	if (err)
> +		goto out;
> +	inode_lock(inode);
> +
> +	oldattr = exfat_make_attr(inode);
> +
> +	/*
> +	 * Mask attributes so we don't set reserved fields.
> +	 */
> +	attr &= (ATTR_READONLY | ATTR_HIDDEN | ATTR_SYSTEM | ATTR_ARCHIVE);
> +	attr |= (is_dir ? ATTR_SUBDIR : 0);
> +
> +	/* Equivalent to a chmod() */
> +	ia.ia_valid = ATTR_MODE | ATTR_CTIME;
> +	ia.ia_ctime = current_time(inode);
> +	if (is_dir)
> +		ia.ia_mode = exfat_make_mode(sbi, attr, 0777);
> +	else
> +		ia.ia_mode = exfat_make_mode(sbi, attr, 0666 | (inode->i_mode & 0111));
> +
> +	/* The root directory has no attributes */
> +	if (inode->i_ino == EXFAT_ROOT_INO && attr != ATTR_SUBDIR) {
> +		err = -EINVAL;
> +		goto out_unlock_inode;
> +	}
> +
> +	if (((attr | oldattr) & ATTR_SYSTEM) &&
> +	    !capable(CAP_LINUX_IMMUTABLE)) {
> +		err = -EPERM;
> +		goto out_unlock_inode;
> +	}
> +
> +	/*
> +	 * The security check is questionable...  We single
> +	 * out the RO attribute for checking by the security
> +	 * module, just because it maps to a file mode.
> +	 */
> +	err = security_inode_setattr(file_mnt_idmap(file),
> +				     file->f_path.dentry, &ia);
> +	if (err)
> +		goto out_unlock_inode;
> +
> +	/* This MUST be done before doing anything irreversible... */
> +	err = exfat_setattr(file_mnt_idmap(file), file->f_path.dentry, &ia);
> +	if (err)
> +		goto out_unlock_inode;
> +
> +	fsnotify_change(file->f_path.dentry, ia.ia_valid);
> +
> +	exfat_save_attr(inode, attr);
> +	mark_inode_dirty(inode);
> +out_unlock_inode:
> +	inode_unlock(inode);
> +	mnt_drop_write_file(file);
> +out:
> +	return err;
> +}
> +
>  static int exfat_ioctl_fitrim(struct inode *inode, unsigned long arg)
>  {
>  	struct fstrim_range range;
> @@ -346,8 +434,13 @@ static int exfat_ioctl_fitrim(struct inode *inode, unsigned long arg)
>  long exfat_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
>  {
>  	struct inode *inode = file_inode(filp);
> +	u32 __user *user_attr = (u32 __user *)arg;
>  
>  	switch (cmd) {
> +	case EXFAT_IOCTL_GET_ATTRIBUTES:
> +		return exfat_ioctl_get_attributes(inode, user_attr);
> +	case EXFAT_IOCTL_SET_ATTRIBUTES:
> +		return exfat_ioctl_set_attributes(filp, user_attr);
>  	case FITRIM:
>  		return exfat_ioctl_fitrim(inode, arg);
>  	default:
> -- 
> 2.40.1
