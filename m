Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E2CC32D553
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Mar 2021 15:34:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbhCDOdY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Mar 2021 09:33:24 -0500
Received: from mx2.suse.de ([195.135.220.15]:52044 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229499AbhCDOdM (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Mar 2021 09:33:12 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 7C606AAC5;
        Thu,  4 Mar 2021 14:32:31 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 58191DA81D; Thu,  4 Mar 2021 15:30:35 +0100 (CET)
Date:   Thu, 4 Mar 2021 15:30:35 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.com,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] btrfs: zoned: use sector_t to get zone sectors
Message-ID: <20210304143034.GQ7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Naohiro Aota <naohiro.aota@wdc.com>,
        linux-btrfs@vger.kernel.org, dsterba@suse.com,
        linux-fsdevel@vger.kernel.org
References: <cover.1614760899.git.naohiro.aota@wdc.com>
 <8068e2e54817aff858207101677e442a21eb10e3.1614760899.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8068e2e54817aff858207101677e442a21eb10e3.1614760899.git.naohiro.aota@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 03, 2021 at 05:55:46PM +0900, Naohiro Aota wrote:
> We need to use sector_t for zone_sectors, or it set the zone size = 0 when
> the size >= 4GB (=  2^24 sectors) by shifting the zone_sectors value by
> SECTOR_SHIFT.

This does not fix the same bug in btrfs_sb_log_location_bdev.

> Fixes: 5b316468983d ("btrfs: get zone information of zoned block devices")
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> ---
>  fs/btrfs/zoned.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
> index 9a5cf153da89..1324bb6c3946 100644
> --- a/fs/btrfs/zoned.c
> +++ b/fs/btrfs/zoned.c
> @@ -269,7 +269,7 @@ int btrfs_get_dev_zone_info(struct btrfs_device *device)
>  	sector_t sector = 0;
>  	struct blk_zone *zones = NULL;
>  	unsigned int i, nreported = 0, nr_zones;
> -	unsigned int zone_sectors;
> +	sector_t zone_sectors;
>  	char *model, *emulated;
>  	int ret;
>  
> -- 
> 2.30.1
