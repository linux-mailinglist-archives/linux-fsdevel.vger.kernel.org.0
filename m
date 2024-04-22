Return-Path: <linux-fsdevel+bounces-17439-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 300EA8AD600
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Apr 2024 22:42:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0D1F283324
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Apr 2024 20:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9477E1BDDC;
	Mon, 22 Apr 2024 20:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u8NIHaco"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4F681BC41;
	Mon, 22 Apr 2024 20:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713818547; cv=none; b=UVx3E0MoBBlbMiX10qBJRBtTIiwUd6MWkYtHvDHqLQ34r5ootuUFIxqMlnqyvkfAQC4tBJzYWCrAxssOfmyIyN3sZ/C1vnLXlDP0X/LeCX/Oe3MCbdwrlWpgR7m2EnWT6KbyZmYCt9TjvNFF40s5X0NSGKAvTE4yPrC+5+HwVWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713818547; c=relaxed/simple;
	bh=qhK/xyI0znuaULfWmCQs605RLjIK84N6jBnKTLXgc9E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=khVBTBYbZ+dJz4G+wflpC7QOzyvAqNZZRTSp1YmsSxMlkfuTrAseHAXJbBUuZ5+fF5KsDwAJODQB5XmY8NarxS7Os7BR2tIALZKX6veKyLiXKPBGgzCkli0Diw9z2Y9q/3tjR5RRcXnLjEBCi6oO4WiXn3hTuinqZulVNnqI+OE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u8NIHaco; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F6D3C113CC;
	Mon, 22 Apr 2024 20:42:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713818546;
	bh=qhK/xyI0znuaULfWmCQs605RLjIK84N6jBnKTLXgc9E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u8NIHaco8Lh+wWUK53bG85Cl7txTWMyWoo8o4kEpZemgV96kdOgSOOvlFHpUCvZN2
	 9zWha28gPiHGE1Jks74qG0oOYpJGyhGrnsbcPtDqdg+SyWlHoJW+tYLM3BUr8WWEwY
	 JXgSvmUze9igyfEQyqINKNkSFGc9h6D6time6KCE9/uJSeChzOzrpzKN9AYCJovVm5
	 uJCFOOuoXlL5MvcDNwy15jCfdVZ7g1862Y4JVzqirsP6gf5kFpFbOHmIGuBvuojS7y
	 YoUI8lumh7Th/36frzx0j4//sKOHB7eXXwyvFA16WFE/Vw+p5ZEF/+UHZUr4/EzFIz
	 zx0lUkN8zx3zw==
Date: Mon, 22 Apr 2024 13:42:24 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc: ntfs3@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>,
	Linux-fsdevel <linux-fsdevel@vger.kernel.org>, llvm@lists.linux.dev
Subject: Re: [PATCH 10/11] fs/ntfs3: Remove cached label from sbi
Message-ID: <20240422204224.GA770800@dev-arch.thelio-3990X>
References: <6c99c1bd-448d-4301-8404-50df34e8df8e@paragon-software.com>
 <890cc224-fdb8-4c5e-a22e-b96dc86e6908@paragon-software.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <890cc224-fdb8-4c5e-a22e-b96dc86e6908@paragon-software.com>

Hi Konstantin,

On Wed, Apr 17, 2024 at 04:09:00PM +0300, Konstantin Komarov wrote:
> Add more checks using $AttrDef.
> 
> Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>

<snip>

> diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
> index 8beefbca5769..dae961d2d6f8 100644
> --- a/fs/ntfs3/super.c
> +++ b/fs/ntfs3/super.c
> @@ -481,11 +481,39 @@ static int ntfs3_volinfo_open(struct inode *inode,
> struct file *file)
>  /* read /proc/fs/ntfs3/<dev>/label */
>  static int ntfs3_label_show(struct seq_file *m, void *o)
>  {
> +    int len;
>      struct super_block *sb = m->private;
>      struct ntfs_sb_info *sbi = sb->s_fs_info;
> +    struct ATTRIB *attr;
> +    u8 *label = kmalloc(PAGE_SIZE, GFP_NOFS);
> +
> +    if (!label)
> +        return -ENOMEM;
> +
> +    attr = ni_find_attr(sbi->volume.ni, NULL, NULL, ATTR_LABEL, NULL, 0,
> +                NULL, NULL);
> +
> +    if (!attr) {
> +        /* It is ok if no ATTR_LABEL */
> +        label[0] = 0;
> +        len = 0;
> +    } else if (!attr_check(attr, sbi, sbi->volume.ni)) {
> +        len = sprintf(label, "%pg: failed to get label", sb->s_bdev);
> +    } else {
> +        len = ntfs_utf16_to_nls(sbi, resident_data(attr),
> +                    le32_to_cpu(attr->res.data_size) >> 1,
> +                    label, PAGE_SIZE);
> +        if (len < 0) {
> +            label[0] = 0;
> +            len = 0;
> +        } else if (len >= PAGE_SIZE) {
> +            len = PAGE_SIZE - 1;
> +        }
> +    }
> 
> -    seq_printf(m, "%s\n", sbi->volume.label);
> +    seq_printf(m, "%.*s\n", len, label);
> 
> +    kfree(label);
>      return 0;
>  }
> 
> @@ -1210,25 +1238,6 @@ static int ntfs_fill_super(struct super_block *sb,
> struct fs_context *fc)
> 
>      ni = ntfs_i(inode);
> 
> -    /* Load and save label (not necessary). */
> -    attr = ni_find_attr(ni, NULL, NULL, ATTR_LABEL, NULL, 0, NULL, NULL);
> -
> -    if (!attr) {
> -        /* It is ok if no ATTR_LABEL */
> -    } else if (!attr->non_res && !is_attr_ext(attr)) {
> -        /* $AttrDef allows labels to be up to 128 symbols. */
> -        err = utf16s_to_utf8s(resident_data(attr),
> -                      le32_to_cpu(attr->res.data_size) >> 1,
> -                      UTF16_LITTLE_ENDIAN, sbi->volume.label,
> -                      sizeof(sbi->volume.label));
> -        if (err < 0)
> -            sbi->volume.label[0] = 0;
> -    } else {
> -        /* Should we break mounting here? */
> -        //err = -EINVAL;
> -        //goto put_inode_out;
> -    }
> -

The attr initialization above causes the use in the ni_find_attr() to be
uninitialized, which results in the following clang warning (or error
when CONFIG_WERROR is enabled):

  fs/ntfs3/super.c:1247:26: error: variable 'attr' is uninitialized when used here [-Werror,-Wuninitialized]
   1247 |         attr = ni_find_attr(ni, attr, NULL, ATTR_VOL_INFO, NULL, 0, NULL, NULL);
        |                                 ^~~~
  fs/ntfs3/super.c:1192:21: note: initialize the variable 'attr' to silence this warning
   1192 |         struct ATTRIB *attr;
        |                            ^
        |                             = NULL
  1 error generated.

Please either fix this quickly (as this isn't the first time an ntfs3
change has broken us for some time in -next for a similar reason [1]) or
remove this series from -next. Given the issues that Johan has brought
up in other comments in this thread, I feel like the latter may be
better, as this series is clearly not ready for Linus (which is one of
-next's general requirements AFAIUI).

>      attr = ni_find_attr(ni, attr, NULL, ATTR_VOL_INFO, NULL, 0, NULL,
> NULL);
>      if (!attr || is_attr_ext(attr) ||
>          !(info = resident_data_ex(attr, SIZEOF_ATTRIBUTE_VOLUME_INFO))) {

[1]: https://github.com/ClangBuiltLinux/linux/issues/1729

Cheers,
Nathan

