Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 716E841B5A1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Sep 2021 20:03:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242140AbhI1SEz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Sep 2021 14:04:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236453AbhI1SEz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Sep 2021 14:04:55 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44258C06161C;
        Tue, 28 Sep 2021 11:03:15 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id y28so95315094lfb.0;
        Tue, 28 Sep 2021 11:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=g5T99dSi8dQg7Ihj73OPFwSxUQ8IoNsRLiLCuXcEeJA=;
        b=feRVhuQrnABDU9OFTZis+TLDGYP84edOeNQwPxivaL2HddIGcbpZgooKDI0Myzrt03
         wUbZeRozpkRjFGrM6X5lvQYP+XdHxaVWJ20/+OluttkOaOGnP7I85JdpEU2ex2+Z0BH2
         rd1DKjv7E2gpRL9aFZhjmi+T16hu+zw8NtNObzyhIw/qU/CXPps48W3R9aR0kcpiGA7N
         3BwGHNq7Y0rH9oerCZP1MUHSgPnyLGfq5j1uqJBcTdkviPg1XK6zcKuo+d0OcnYEWouT
         eeHTRd6c0DSKS5qcnR0UckSV13kACdQTlyqh+6VT/YBsE9zGRcTBo9GgwViW5MQFpfe+
         DZxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=g5T99dSi8dQg7Ihj73OPFwSxUQ8IoNsRLiLCuXcEeJA=;
        b=7Brh9abHOdPTpAypkZeAt/TMJ8UWcYvjPlaFZ2OBn4knQ/G38bANuH9pnVUy8quRSm
         Ve348552/imIVIoEtp5DHZzKQf0yCBz3Mu/AhpEIDwHKTbfnKu8rfSyYTL0pBa7KvEHE
         KuZNYSdQOPVtquKwkLDcR+C40lWC29kEPkMGT0q0MVnq9zdWpOqP45fA6HwsQwN+4uxf
         jH8MhDnmXU15Y3iMrGwFyiFP7ogGitwylpYD+aea+htWYQHVeqTQHY0/ucJiHG6Yds5T
         WY19PHMqVU2CQVoVgRtOpYuH2bAbJDE54UvEC4brzgvDK0Sw2DcZKI1hqS17ok+jjafb
         SNbQ==
X-Gm-Message-State: AOAM530uCiFH2VAzak6RjD/BxoL0i5imAcXFOh4mq+izCDK0+g145DJh
        xsXSdBEjT6Ju5zOhOgyuZEM6areF0M4=
X-Google-Smtp-Source: ABdhPJzROxesMHK1UNtlIaYnsvi6bY2MSXXtEQXbOHw+WQNnArEq8xVyLxubeknFx7GnpqpHilEbEA==
X-Received: by 2002:ac2:420d:: with SMTP id y13mr4466243lfh.527.1632852193604;
        Tue, 28 Sep 2021 11:03:13 -0700 (PDT)
Received: from kari-VirtualBox (85-23-89-224.bb.dnainternet.fi. [85.23.89.224])
        by smtp.gmail.com with ESMTPSA id i8sm1986394lfb.227.2021.09.28.11.03.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 11:03:13 -0700 (PDT)
Date:   Tue, 28 Sep 2021 21:03:11 +0300
From:   Kari Argillander <kari.argillander@gmail.com>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc:     ntfs3@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] fs/ntfs3: Reject mount if boot's cluster size <
 media sector size
Message-ID: <20210928180311.eu5pldpiuio7ssah@kari-VirtualBox>
References: <a7c2e6d3-68a1-25f7-232e-935ae9e5f6c8@paragon-software.com>
 <228cbe20-87d6-4020-55fb-111d22e2b487@paragon-software.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <228cbe20-87d6-4020-55fb-111d22e2b487@paragon-software.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 28, 2021 at 08:18:07PM +0300, Konstantin Komarov wrote:
> If we continue to work in this case, then we can corrupt fs.
> 

Remember to add fixes tag.

> Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
> ---
>  fs/ntfs3/super.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
> index aff90f70e7bf..890c5d9d6d60 100644
> --- a/fs/ntfs3/super.c
> +++ b/fs/ntfs3/super.c
> @@ -763,9 +763,20 @@ static int ntfs_init_from_boot(struct super_block *sb, u32 sector_size,
>  	sbi->mft.lbo = mlcn << sbi->cluster_bits;
>  	sbi->mft.lbo2 = mlcn2 << sbi->cluster_bits;
>  
> -	if (sbi->cluster_size < sbi->sector_size)
> +	/* Compare boot's cluster and sector. */
> +	if (sbi->cluster_size < boot_sector_size)

This should actually be in patch 3/3 as this has nothing to do with bug
fix and bug fix is most important thing to be seperated and as you have
do be front in the series. After that

Reviewed-by: Kari Argillander <kari.argillander@gmail.com>

>  		goto out;
>  
> +	/* Compare boot's cluster and media sector. */
> +	if (sbi->cluster_size < sector_size) {
> +		/* No way to use ntfs_get_block in this case. */
> +		ntfs_err(
> +			sb,
> +			"Failed to mount 'cause NTFS's cluster size (%u) is less than media sector size (%u)",
> +			sbi->cluster_size, sector_size);
> +		goto out;
> +	}
> +
>  	sbi->cluster_mask = sbi->cluster_size - 1;
>  	sbi->cluster_mask_inv = ~(u64)sbi->cluster_mask;
>  	sbi->record_size = record_size = boot->record_size < 0
> -- 
> 2.33.0
> 
> 
