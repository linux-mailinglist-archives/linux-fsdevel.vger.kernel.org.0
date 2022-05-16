Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA81552934B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 May 2022 00:02:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349541AbiEPWCt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 May 2022 18:02:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238440AbiEPWCs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 May 2022 18:02:48 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C047E639D;
        Mon, 16 May 2022 15:02:46 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 795551F939;
        Mon, 16 May 2022 22:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1652738565;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6cIkZu1t4JcnuW9jTK0PkgF8th7GaouWhYTdI3D3pyk=;
        b=WIhYvYEZcJpAzfluzqgnCgqoHviPg90OjQmw4bs072LgnnGqsiE/4UuMiX7NNiu7SYt0tG
        N29JVeHRfPwAAO9zoEFeDTIvjtO682d2smEJwb8eqWO+upjxNP+SQ10Vg5hyFnbAuIZ8zk
        DAltVMxGzxwpgu2Y/RcPgjBCG29y9zI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1652738565;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6cIkZu1t4JcnuW9jTK0PkgF8th7GaouWhYTdI3D3pyk=;
        b=98ihLesEtp+MaFmDUwSOzucf9EYfg9IyKPNxVVFd/HqJJ3yMz3X35in+n0wIM10GXhgEZu
        JK7GAlzwShThY5CQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 102A313ADC;
        Mon, 16 May 2022 22:02:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id w1/AAgXKgmLnQAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 16 May 2022 22:02:45 +0000
Date:   Mon, 16 May 2022 23:58:26 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Pankaj Raghav <p.raghav@samsung.com>
Cc:     axboe@kernel.dk, damien.lemoal@opensource.wdc.com,
        pankydev8@gmail.com, dsterba@suse.com, hch@lst.de,
        linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, jiangbo.365@bytedance.com,
        linux-block@vger.kernel.org, gost.dev@samsung.com,
        linux-kernel@vger.kernel.org, dm-devel@redhat.com,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [PATCH v4 05/13] btrfs: zoned: Cache superblock location in
 btrfs_zoned_device_info
Message-ID: <20220516215826.GZ18596@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Pankaj Raghav <p.raghav@samsung.com>,
        axboe@kernel.dk, damien.lemoal@opensource.wdc.com,
        pankydev8@gmail.com, dsterba@suse.com, hch@lst.de,
        linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, jiangbo.365@bytedance.com,
        linux-block@vger.kernel.org, gost.dev@samsung.com,
        linux-kernel@vger.kernel.org, dm-devel@redhat.com,
        Luis Chamberlain <mcgrof@kernel.org>
References: <20220516165416.171196-1-p.raghav@samsung.com>
 <CGME20220516165425eucas1p29fcd11d7051d9d3a9a9efc17cd3b6999@eucas1p2.samsung.com>
 <20220516165416.171196-6-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220516165416.171196-6-p.raghav@samsung.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 16, 2022 at 06:54:08PM +0200, Pankaj Raghav wrote:
> Instead of calculating the superblock location every time, cache the
> superblock zone location in btrfs_zoned_device_info struct and use it to
> locate the zone index.
> 
> The functions such as btrfs_sb_log_location_bdev() and
> btrfs_reset_sb_log_zones() which work directly on block_device shall
> continue to use the sb_zone_number because btrfs_zoned_device_info
> struct might not have been initialized at that point.
> 
> This patch will enable non power-of-2 zoned devices to not perform
> division to lookup superblock and its mirror location.
> 
> Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> ---
>  fs/btrfs/zoned.c | 13 +++++++++----
>  fs/btrfs/zoned.h |  1 +
>  2 files changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
> index 06f22c021..e8c7cebb2 100644
> --- a/fs/btrfs/zoned.c
> +++ b/fs/btrfs/zoned.c
> @@ -511,6 +511,11 @@ int btrfs_get_dev_zone_info(struct btrfs_device *device, bool populate_cache)
>  			   max_active_zones - nactive);
>  	}
>  
> +	/* Cache the sb zone number */
> +	for (i = 0; i < BTRFS_SUPER_MIRROR_MAX; ++i) {
> +		zone_info->sb_zone_location[i] =
> +			sb_zone_number(zone_info->zone_size_shift, i);
> +	}

I don't think we need to cache the value right now, it's not in any hot
path and call to bdev_zone_no is relatively cheap (only dereferencing a
few pointers, all in-memory values).
