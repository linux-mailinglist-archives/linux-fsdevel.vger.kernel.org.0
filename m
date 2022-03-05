Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 884E04CE336
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Mar 2022 07:03:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231321AbiCEGE1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 5 Mar 2022 01:04:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiCEGE0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 5 Mar 2022 01:04:26 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9024C23B4CF;
        Fri,  4 Mar 2022 22:03:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3B6E260EF1;
        Sat,  5 Mar 2022 06:03:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F272C340EE;
        Sat,  5 Mar 2022 06:03:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646460213;
        bh=m3yvozZ792No26ca3pP4/XMLgVq+iBFxYpN2iMjjebY=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=MTHU5SjwqjPAkWPd48sd8JU08MfMVv6NRT1i5fUVSPieSgQdaxjfABd5spQi7I5rZ
         Nj9fOExGetQIh6bl3husnOW89yFbQZhGI9KDUIdiDMeEYTSfdErQ7mX43MklktCB5a
         M7Dz3c4G/a1MwxTal0cHzlTpUmqAqsSfDJFul/YhmEOCIk0AAHY7+GbDC/u/H1HABK
         KGYcQXHERHQEyE6NYYGAVg61a7pKJcLldmXz3lqKD0JhwJZyBrUCL2AxneKgVqGHoF
         JLZ8meVFn9BdCCrxDeHajYVdAHdOTXJmISOvt1u1v0t9ww1+OdVWjJPkNkaM+MLSP/
         7iBuCUiE8x+7w==
Received: by mail-wr1-f52.google.com with SMTP id n15so1420221wra.6;
        Fri, 04 Mar 2022 22:03:33 -0800 (PST)
X-Gm-Message-State: AOAM531LvpZ1Xsm6hybcudT2omvY1kEtN+YSIlsyX7sPpxLr9oHCemnU
        g1E2uP+75R2jO+5zcRCoUMI5Wruxjwlbavp5vY8=
X-Google-Smtp-Source: ABdhPJyejB6pe7hZ+HhxkuXjN9vglqw6GhCNi3XtLx/b7ReBYExKt1RfBfKGY9AhrwPeQXTXHHOhhgf5H8i0g1WFYN0=
X-Received: by 2002:a05:6000:1c16:b0:1ef:d315:8c58 with SMTP id
 ba22-20020a0560001c1600b001efd3158c58mr1346808wrb.504.1646460211726; Fri, 04
 Mar 2022 22:03:31 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a5d:4e02:0:0:0:0:0 with HTTP; Fri, 4 Mar 2022 22:03:30 -0800 (PST)
In-Reply-To: <HK2PR04MB38914869B1FEE326CFE11779812D9@HK2PR04MB3891.apcprd04.prod.outlook.com>
References: <HK2PR04MB38914869B1FEE326CFE11779812D9@HK2PR04MB3891.apcprd04.prod.outlook.com>
From:   Namjae Jeon <linkinjeon@kernel.org>
Date:   Sat, 5 Mar 2022 15:03:30 +0900
X-Gmail-Original-Message-ID: <CAKYAXd_hF+xYXNiawCZLYmnha+wSUSUCEJTVBw8v6UDYfjPiUg@mail.gmail.com>
Message-ID: <CAKYAXd_hF+xYXNiawCZLYmnha+wSUSUCEJTVBw8v6UDYfjPiUg@mail.gmail.com>
Subject: Re: [PATCH] exfat: do not clear VolumeDirty in writeback
To:     "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
Cc:     "sj1557.seo@samsung.com" <sj1557.seo@samsung.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

2022-02-08 14:18 GMT+09:00, Yuezhang.Mo@sony.com <Yuezhang.Mo@sony.com>:
Hi Yuezhang,

> Before this commit, VolumeDirty will be cleared first in
> writeback if 'dirsync' or 'sync' is not enabled. If the power
> is suddenly cut off after cleaning VolumeDirty but other
> updates are not written, the exFAT filesystem will not be able
> to detect the power failure in the next mount.
>
> And VolumeDirty will be set again when updating the parent
> directory. It means that BootSector will be written twice in each
> writeback, that will shorten the life of the device.
>
> Reviewed-by: Andy.Wu <Andy.Wu@sony.com>
> Reviewed-by: Aoyama, Wataru <wataru.aoyama@sony.com>
> Signed-off-by: Yuezhang.Mo <Yuezhang.Mo@sony.com>
> ---
>  fs/exfat/super.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
>
> diff --git a/fs/exfat/super.c b/fs/exfat/super.c
> index 8c9fb7dcec16..f4906c17475e 100644
> --- a/fs/exfat/super.c
> +++ b/fs/exfat/super.c
> @@ -25,6 +25,8 @@
>  static char exfat_default_iocharset[] = CONFIG_EXFAT_DEFAULT_IOCHARSET;
>  static struct kmem_cache *exfat_inode_cachep;
>
> +static int __exfat_clear_volume_dirty(struct super_block *sb);
> +
>  static void exfat_free_iocharset(struct exfat_sb_info *sbi)
>  {
>  	if (sbi->options.iocharset != exfat_default_iocharset)
> @@ -64,7 +66,7 @@ static int exfat_sync_fs(struct super_block *sb, int wait)
>  	/* If there are some dirty buffers in the bdev inode */
>  	mutex_lock(&sbi->s_lock);
>  	sync_blockdev(sb->s_bdev);
> -	if (exfat_clear_volume_dirty(sb))
> +	if (__exfat_clear_volume_dirty(sb))
>  		err = -EIO;
>  	mutex_unlock(&sbi->s_lock);
>  	return err;
> @@ -139,13 +141,21 @@ int exfat_set_volume_dirty(struct super_block *sb)
>  	return exfat_set_vol_flags(sb, sbi->vol_flags | VOLUME_DIRTY);
>  }
>
> -int exfat_clear_volume_dirty(struct super_block *sb)
> +static int __exfat_clear_volume_dirty(struct super_block *sb)
>  {
>  	struct exfat_sb_info *sbi = EXFAT_SB(sb);
>
>  	return exfat_set_vol_flags(sb, sbi->vol_flags & ~VOLUME_DIRTY);
>  }
>
> +int exfat_clear_volume_dirty(struct super_block *sb)
> +{
> +	if (sb->s_flags & (SB_SYNCHRONOUS | SB_DIRSYNC))
How about moving exfat_clear_volume_dirty() to IS_DIRSYNC() check in
each operations instead of this check?

> +		return __exfat_clear_volume_dirty(sb);
> +
> +	return 0;
> +}
> +
>  static int exfat_show_options(struct seq_file *m, struct dentry *root)
>  {
>  	struct super_block *sb = root->d_sb;
> --
> 2.25.1
