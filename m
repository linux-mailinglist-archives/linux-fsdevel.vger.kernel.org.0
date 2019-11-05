Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5CDFF03BF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Nov 2019 18:05:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389908AbfKERFV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Nov 2019 12:05:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:43254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388958AbfKERFV (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Nov 2019 12:05:21 -0500
Received: from localhost (unknown [62.119.166.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 46DDE2087E;
        Tue,  5 Nov 2019 17:05:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572973520;
        bh=jTO8reKcT4C5kCnNyyvTf8GTELx7dazG4WitwpYdsJE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HeBSfHogBHebaNjOYUBn6YSGujIWYFpHH6SK1/G8DvZ0qXliA7nwXkgqvwd+LvWrl
         C4JGrsF4eNG0U2wVB0iEpgseqXIB4ewsamhCfis3ZYbB1m43kZXPCZE3zpJ5qUOi0b
         2vLj3xuNAgfGmmG9t3FtgOqvC+uzwLvY5Oa09w4Y=
Date:   Tue, 5 Nov 2019 18:05:15 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Valdis Kletnieks <valdis.kletnieks@vt.edu>
Cc:     linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 01/10] staging: exfat: Clean up return codes -
 FFS_FORMATERR
Message-ID: <20191105170515.GA2788121@kroah.com>
References: <20191104014510.102356-1-Valdis.Kletnieks@vt.edu>
 <20191104014510.102356-2-Valdis.Kletnieks@vt.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191104014510.102356-2-Valdis.Kletnieks@vt.edu>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Nov 03, 2019 at 08:44:57PM -0500, Valdis Kletnieks wrote:
> Convert FFS_FORMATERR to -EFSCORRUPTED
> 
> Signed-off-by: Valdis Kletnieks <Valdis.Kletnieks@vt.edu>
> ---
>  drivers/staging/exfat/exfat.h      | 3 ++-
>  drivers/staging/exfat/exfat_core.c | 8 ++++----
>  2 files changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/staging/exfat/exfat.h b/drivers/staging/exfat/exfat.h
> index acb73f47a253..4f9ba235d967 100644
> --- a/drivers/staging/exfat/exfat.h
> +++ b/drivers/staging/exfat/exfat.h
> @@ -30,6 +30,8 @@
>  #undef DEBUG
>  #endif
>  
> +#define EFSCORRUPTED	EUCLEAN		/* Filesystem is corrupted */
> +
>  #define DENTRY_SIZE		32	/* dir entry size */
>  #define DENTRY_SIZE_BITS	5
>  
> @@ -209,7 +211,6 @@ static inline u16 get_row_index(u16 i)
>  /* return values */
>  #define FFS_SUCCESS             0
>  #define FFS_MEDIAERR            1
> -#define FFS_FORMATERR           2
>  #define FFS_MOUNTED             3
>  #define FFS_NOTMOUNTED          4
>  #define FFS_ALIGNMENTERR        5
> diff --git a/drivers/staging/exfat/exfat_core.c b/drivers/staging/exfat/exfat_core.c
> index b23fbf3ebaa5..e90b54a17150 100644
> --- a/drivers/staging/exfat/exfat_core.c
> +++ b/drivers/staging/exfat/exfat_core.c
> @@ -573,7 +573,7 @@ s32 load_alloc_bitmap(struct super_block *sb)
>  			return FFS_MEDIAERR;
>  	}
>  
> -	return FFS_FORMATERR;
> +	return -EFSCORRUPTED;
>  }
>  
>  void free_alloc_bitmap(struct super_block *sb)
> @@ -3016,7 +3016,7 @@ s32 fat16_mount(struct super_block *sb, struct pbr_sector_t *p_pbr)
>  	struct bd_info_t *p_bd = &(EXFAT_SB(sb)->bd_info);
>  
>  	if (p_bpb->num_fats == 0)
> -		return FFS_FORMATERR;
> +		return -EFSCORRUPTED;
>  
>  	num_root_sectors = GET16(p_bpb->num_root_entries) << DENTRY_SIZE_BITS;
>  	num_root_sectors = ((num_root_sectors - 1) >>
> @@ -3078,7 +3078,7 @@ s32 fat32_mount(struct super_block *sb, struct pbr_sector_t *p_pbr)
>  	struct bd_info_t *p_bd = &(EXFAT_SB(sb)->bd_info);
>  
>  	if (p_bpb->num_fats == 0)
> -		return FFS_FORMATERR;
> +		return -EFSCORRUPTED;
>  
>  	p_fs->sectors_per_clu = p_bpb->sectors_per_clu;
>  	p_fs->sectors_per_clu_bits = ilog2(p_bpb->sectors_per_clu);
> @@ -3157,7 +3157,7 @@ s32 exfat_mount(struct super_block *sb, struct pbr_sector_t *p_pbr)
>  	struct bd_info_t *p_bd = &(EXFAT_SB(sb)->bd_info);
>  
>  	if (p_bpb->num_fats == 0)
> -		return FFS_FORMATERR;
> +		return -EFSCORRUPTED;
>  
>  	p_fs->sectors_per_clu = 1 << p_bpb->sectors_per_clu_bits;
>  	p_fs->sectors_per_clu_bits = p_bpb->sectors_per_clu_bits;

This patch breaks the build:

drivers/staging/exfat/exfat_super.c: In function ‘ffsMountVol’:
drivers/staging/exfat/exfat_super.c:387:9: error: ‘FFS_FORMATERR’ undeclared (first use in this function)
  387 |   ret = FFS_FORMATERR;
      |         ^~~~~~~~~~~~~


Did you test-build this thing?

thanks,

greg k-h
