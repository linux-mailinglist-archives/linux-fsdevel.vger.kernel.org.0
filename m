Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9422E429927
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Oct 2021 23:50:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235446AbhJKVwz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Oct 2021 17:52:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235437AbhJKVwt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Oct 2021 17:52:49 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86033C061749;
        Mon, 11 Oct 2021 14:50:48 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id j5so79265582lfg.8;
        Mon, 11 Oct 2021 14:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CFOKAogMPVQB4oZNJlqugjaqysN1b1PYFPOt9WrOaLM=;
        b=nA0+CHF93/xmhq6amcMoaHPsMhXaApVzdhVkN5jWi2UvnLoAtsQb9YyzA4I0WJ3qmI
         RhAd+LxzrFJTy9m4foJchTdiqMTMOlU9coIQM+UFHhuwOCqv/9+ot+ktYznvBK2ZNWzw
         QwgBYNjhIzww4+J9B09dh0l8V3pirFrne46ybTSriXLotideg1SA/mdRmtO3+zR/FCY0
         vvzwcb7/ec7qQgzPyBuEUXBJtqjapKSX3NSPNvl72bSkVxN6ZYoYG1F592KAUdiVgWwT
         Sngg6Sw1QI6lcVb3dxqoVrUnhxkVfB72l7TQNv/LM++Jiyu6tjcBulHYeGobqhHFcA3E
         2b6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CFOKAogMPVQB4oZNJlqugjaqysN1b1PYFPOt9WrOaLM=;
        b=w4cKbAEMEsCmnH8LU4SgnAlpT/DJN6BeEWMyRVjXTlZYG/mJc5cEgFZfATl1ffrf9l
         SYT7OBNhzQ/XTKXHvxyQ90gQr7hiL/XnQitxauJQ+vwbHMPaqsWA+I8RybLwziK1Alqm
         UaPiDRp2pMux6yJw4F61XnbEO+sQrzhI0I3qPp9Twfu4nyWZDYUpywJF8iOI0XPep2Xf
         c7oDdtPyMJFxgQa0AROIOSzdB9xhEolUGYkRGeGHnqC9EDWjWLXRGufjAmXaquWbRgO1
         xiWYEFBzp1EQOz0jOFHd+dohQggLzm9USXS8a+18K0K235iq4u2gMcihRofXCoURl6Wz
         +zcw==
X-Gm-Message-State: AOAM533JzYARlgwPbzf+qkdhoPQVsdx+RlzIWmUTQyaj+/Aavf1dGKwu
        zF8jL5hoRWSKX0IFrlM5hGoHuoShje4=
X-Google-Smtp-Source: ABdhPJyV7p5NoQM7I45hzXf6Ifacl28t/3kSejfgMVnTOMkGgFwyBTiZkiRHs/0homVhYv9tMBHrnw==
X-Received: by 2002:a2e:7205:: with SMTP id n5mr7220886ljc.65.1633989046697;
        Mon, 11 Oct 2021 14:50:46 -0700 (PDT)
Received: from kari-VirtualBox (85-23-89-224.bb.dnainternet.fi. [85.23.89.224])
        by smtp.gmail.com with ESMTPSA id w6sm913789lfk.200.2021.10.11.14.50.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Oct 2021 14:50:46 -0700 (PDT)
Date:   Tue, 12 Oct 2021 00:50:44 +0300
From:   Kari Argillander <kari.argillander@gmail.com>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc:     ntfs3@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2] fs/ntfs3: Fix memory leak if fill_super failed
Message-ID: <20211011215044.dwxmyy2o6nqers3i@kari-VirtualBox>
References: <79791816-db23-f3b4-3ea8-139add705c45@paragon-software.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <79791816-db23-f3b4-3ea8-139add705c45@paragon-software.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 05, 2021 at 06:26:53PM +0300, Konstantin Komarov wrote:
> In ntfs_init_fs_context we allocate memory in fc->s_fs_info.
> In case of failed mount we must free it in ntfs_fill_super.
> We can't do it in ntfs_fs_free, because ntfs_fs_free called
> with fc->s_fs_info == NULL.
> fc->s_fs_info became NULL in sget_fc.

Thanks for fixing this. You can always ask that person who introduce bug
will fix it.

> Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>

Reviewed-by: Kari Argillander <kari.argillander@gmail.com>

> ---
> v2:
>   Changed fix - now we free memory instead of restoring pointer to memory.
>   Added context how we allocate and free memory.
>   Many commits affected, so no fixes tag.

Many commit affected, but fixed tag is the first one which introduce it.
This case: 

Fixes: 610f8f5a7baf ("fs/ntfs3: Use new api for mounting")

This will help backporting fixes to stable branches.

> 
>  fs/ntfs3/super.c | 90 ++++++++++++++++++++++++++++++------------------
>  1 file changed, 56 insertions(+), 34 deletions(-)
> 
> diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
> index 705d8b4f4894..d41d76979e12 100644
> --- a/fs/ntfs3/super.c
> +++ b/fs/ntfs3/super.c
> @@ -908,7 +908,8 @@ static int ntfs_fill_super(struct super_block *sb, struct fs_context *fc)
>  	if (IS_ERR(sbi->options->nls)) {
>  		sbi->options->nls = NULL;
>  		errorf(fc, "Cannot load nls %s", sbi->options->nls_name);
> -		return -EINVAL;
> +		err = -EINVAL;
> +		goto out;
>  	}
>  
>  	rq = bdev_get_queue(bdev);
> @@ -922,7 +923,7 @@ static int ntfs_fill_super(struct super_block *sb, struct fs_context *fc)
>  	err = ntfs_init_from_boot(sb, rq ? queue_logical_block_size(rq) : 512,
>  				  bdev->bd_inode->i_size);
>  	if (err)
> -		return err;
> +		goto out;
>  
>  	/*
>  	 * Load $Volume. This should be done before $LogFile
> @@ -933,7 +934,8 @@ static int ntfs_fill_super(struct super_block *sb, struct fs_context *fc)
>  	inode = ntfs_iget5(sb, &ref, &NAME_VOLUME);
>  	if (IS_ERR(inode)) {
>  		ntfs_err(sb, "Failed to load $Volume.");
> -		return PTR_ERR(inode);
> +		err = PTR_ERR(inode);
> +		goto out;
>  	}
>  
>  	ni = ntfs_i(inode);
> @@ -954,19 +956,19 @@ static int ntfs_fill_super(struct super_block *sb, struct fs_context *fc)
>  	} else {
>  		/* Should we break mounting here? */
>  		//err = -EINVAL;
> -		//goto out;
> +		//goto put_inode_out;
>  	}
>  
>  	attr = ni_find_attr(ni, attr, NULL, ATTR_VOL_INFO, NULL, 0, NULL, NULL);
>  	if (!attr || is_attr_ext(attr)) {
>  		err = -EINVAL;
> -		goto out;
> +		goto put_inode_out;
>  	}
>  
>  	info = resident_data_ex(attr, SIZEOF_ATTRIBUTE_VOLUME_INFO);
>  	if (!info) {
>  		err = -EINVAL;
> -		goto out;
> +		goto put_inode_out;
>  	}
>  
>  	sbi->volume.major_ver = info->major_ver;
> @@ -980,7 +982,8 @@ static int ntfs_fill_super(struct super_block *sb, struct fs_context *fc)
>  	inode = ntfs_iget5(sb, &ref, &NAME_MIRROR);
>  	if (IS_ERR(inode)) {
>  		ntfs_err(sb, "Failed to load $MFTMirr.");
> -		return PTR_ERR(inode);
> +		err = PTR_ERR(inode);
> +		goto out;
>  	}
>  
>  	sbi->mft.recs_mirr =
> @@ -994,14 +997,15 @@ static int ntfs_fill_super(struct super_block *sb, struct fs_context *fc)
>  	inode = ntfs_iget5(sb, &ref, &NAME_LOGFILE);
>  	if (IS_ERR(inode)) {
>  		ntfs_err(sb, "Failed to load \x24LogFile.");
> -		return PTR_ERR(inode);
> +		err = PTR_ERR(inode);
> +		goto out;
>  	}
>  
>  	ni = ntfs_i(inode);
>  
>  	err = ntfs_loadlog_and_replay(ni, sbi);
>  	if (err)
> -		goto out;
> +		goto put_inode_out;
>  
>  	iput(inode);
>  
> @@ -1009,14 +1013,16 @@ static int ntfs_fill_super(struct super_block *sb, struct fs_context *fc)
>  		if (!sb_rdonly(sb)) {
>  			ntfs_warn(sb,
>  				  "failed to replay log file. Can't mount rw!");
> -			return -EINVAL;
> +			err = -EINVAL;
> +			goto out;
>  		}
>  	} else if (sbi->volume.flags & VOLUME_FLAG_DIRTY) {
>  		if (!sb_rdonly(sb) && !sbi->options->force) {
>  			ntfs_warn(
>  				sb,
>  				"volume is dirty and \"force\" flag is not set!");
> -			return -EINVAL;
> +			err = -EINVAL;
> +			goto out;
>  		}
>  	}
>  
> @@ -1027,7 +1033,8 @@ static int ntfs_fill_super(struct super_block *sb, struct fs_context *fc)
>  	inode = ntfs_iget5(sb, &ref, &NAME_MFT);
>  	if (IS_ERR(inode)) {
>  		ntfs_err(sb, "Failed to load $MFT.");
> -		return PTR_ERR(inode);
> +		err = PTR_ERR(inode);
> +		goto out;
>  	}
>  
>  	ni = ntfs_i(inode);
> @@ -1038,11 +1045,11 @@ static int ntfs_fill_super(struct super_block *sb, struct fs_context *fc)
>  
>  	err = wnd_init(&sbi->mft.bitmap, sb, tt);
>  	if (err)
> -		goto out;
> +		goto put_inode_out;
>  
>  	err = ni_load_all_mi(ni);
>  	if (err)
> -		goto out;
> +		goto put_inode_out;
>  
>  	sbi->mft.ni = ni;
>  
> @@ -1052,7 +1059,8 @@ static int ntfs_fill_super(struct super_block *sb, struct fs_context *fc)
>  	inode = ntfs_iget5(sb, &ref, &NAME_BADCLUS);
>  	if (IS_ERR(inode)) {
>  		ntfs_err(sb, "Failed to load $BadClus.");
> -		return PTR_ERR(inode);
> +		err = PTR_ERR(inode);
> +		goto out;
>  	}
>  
>  	ni = ntfs_i(inode);
> @@ -1075,13 +1083,14 @@ static int ntfs_fill_super(struct super_block *sb, struct fs_context *fc)
>  	inode = ntfs_iget5(sb, &ref, &NAME_BITMAP);
>  	if (IS_ERR(inode)) {
>  		ntfs_err(sb, "Failed to load $Bitmap.");
> -		return PTR_ERR(inode);
> +		err = PTR_ERR(inode);
> +		goto out;
>  	}
>  
>  #ifndef CONFIG_NTFS3_64BIT_CLUSTER
>  	if (inode->i_size >> 32) {
>  		err = -EINVAL;
> -		goto out;
> +		goto put_inode_out;
>  	}
>  #endif
>  
> @@ -1089,21 +1098,21 @@ static int ntfs_fill_super(struct super_block *sb, struct fs_context *fc)
>  	tt = sbi->used.bitmap.nbits;
>  	if (inode->i_size < bitmap_size(tt)) {
>  		err = -EINVAL;
> -		goto out;
> +		goto put_inode_out;
>  	}
>  
>  	/* Not necessary. */
>  	sbi->used.bitmap.set_tail = true;
>  	err = wnd_init(&sbi->used.bitmap, sb, tt);
>  	if (err)
> -		goto out;
> +		goto put_inode_out;
>  
>  	iput(inode);
>  
>  	/* Compute the MFT zone. */
>  	err = ntfs_refresh_zone(sbi);
>  	if (err)
> -		return err;
> +		goto out;
>  
>  	/* Load $AttrDef. */
>  	ref.low = cpu_to_le32(MFT_REC_ATTR);
> @@ -1111,18 +1120,19 @@ static int ntfs_fill_super(struct super_block *sb, struct fs_context *fc)
>  	inode = ntfs_iget5(sb, &ref, &NAME_ATTRDEF);
>  	if (IS_ERR(inode)) {
>  		ntfs_err(sb, "Failed to load $AttrDef -> %d", err);
> -		return PTR_ERR(inode);
> +		err = PTR_ERR(inode);
> +		goto out;
>  	}
>  
>  	if (inode->i_size < sizeof(struct ATTR_DEF_ENTRY)) {
>  		err = -EINVAL;
> -		goto out;
> +		goto put_inode_out;
>  	}
>  	bytes = inode->i_size;
>  	sbi->def_table = t = kmalloc(bytes, GFP_NOFS);
>  	if (!t) {
>  		err = -ENOMEM;
> -		goto out;
> +		goto put_inode_out;
>  	}
>  
>  	for (done = idx = 0; done < bytes; done += PAGE_SIZE, idx++) {
> @@ -1131,7 +1141,7 @@ static int ntfs_fill_super(struct super_block *sb, struct fs_context *fc)
>  
>  		if (IS_ERR(page)) {
>  			err = PTR_ERR(page);
> -			goto out;
> +			goto put_inode_out;
>  		}
>  		memcpy(Add2Ptr(t, done), page_address(page),
>  		       min(PAGE_SIZE, tail));
> @@ -1139,7 +1149,7 @@ static int ntfs_fill_super(struct super_block *sb, struct fs_context *fc)
>  
>  		if (!idx && ATTR_STD != t->type) {
>  			err = -EINVAL;
> -			goto out;
> +			goto put_inode_out;
>  		}
>  	}
>  
> @@ -1173,12 +1183,13 @@ static int ntfs_fill_super(struct super_block *sb, struct fs_context *fc)
>  	inode = ntfs_iget5(sb, &ref, &NAME_UPCASE);
>  	if (IS_ERR(inode)) {
>  		ntfs_err(sb, "Failed to load $UpCase.");
> -		return PTR_ERR(inode);
> +		err = PTR_ERR(inode);
> +		goto out;
>  	}
>  
>  	if (inode->i_size != 0x10000 * sizeof(short)) {
>  		err = -EINVAL;
> -		goto out;
> +		goto put_inode_out;
>  	}
>  
>  	for (idx = 0; idx < (0x10000 * sizeof(short) >> PAGE_SHIFT); idx++) {
> @@ -1188,7 +1199,7 @@ static int ntfs_fill_super(struct super_block *sb, struct fs_context *fc)
>  
>  		if (IS_ERR(page)) {
>  			err = PTR_ERR(page);
> -			goto out;
> +			goto put_inode_out;
>  		}
>  
>  		src = page_address(page);
> @@ -1214,7 +1225,7 @@ static int ntfs_fill_super(struct super_block *sb, struct fs_context *fc)
>  		/* Load $Secure. */
>  		err = ntfs_security_init(sbi);
>  		if (err)
> -			return err;
> +			goto out;
>  
>  		/* Load $Extend. */
>  		err = ntfs_extend_init(sbi);
> @@ -1239,19 +1250,30 @@ static int ntfs_fill_super(struct super_block *sb, struct fs_context *fc)
>  	inode = ntfs_iget5(sb, &ref, &NAME_ROOT);
>  	if (IS_ERR(inode)) {
>  		ntfs_err(sb, "Failed to load root.");
> -		return PTR_ERR(inode);
> +		err = PTR_ERR(inode);
> +		goto out;
>  	}
>  
>  	sb->s_root = d_make_root(inode);
> -	if (!sb->s_root)
> -		return -ENOMEM;
> +	if (!sb->s_root) {
> +		err = -ENOMEM;
> +		goto put_inode_out;
> +	}
>  
>  	fc->fs_private = NULL;
> -	fc->s_fs_info = NULL;
>  
>  	return 0;
> -out:
> +
> +put_inode_out:
>  	iput(inode);
> +out:
> +	/*
> +	 * Free resources here.
> +	 * ntfs_fs_free will be called with fc->s_fs_info = NULL
> +	 */
> +	put_ntfs(sbi);
> +	sb->s_fs_info = NULL;
> +
>  	return err;
>  }
>  
> -- 
> 2.33.0
> 
