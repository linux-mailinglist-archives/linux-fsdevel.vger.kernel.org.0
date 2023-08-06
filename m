Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA79D771516
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Aug 2023 14:45:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbjHFMpv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 6 Aug 2023 08:45:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbjHFMpu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 6 Aug 2023 08:45:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 183E7E47;
        Sun,  6 Aug 2023 05:45:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A0FEA610AA;
        Sun,  6 Aug 2023 12:45:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 302AFC433C7;
        Sun,  6 Aug 2023 12:45:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691325948;
        bh=wXYWg26OzEPN2k/ZF3JgHRFogg3a61pPPpi9inOVm0Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tx0smzmfap8JWuh2SZ9JmhyGP1aSjTUCbKer+myYAxc9LGi8YZptXIxr9qyE965RE
         ubARg98QO+oI84FfP2kWZwNqMooABOZ9r+nlA6U+wkeLYmfD6wgM0t0zi+nC74b5GR
         vZZmMI7+IKKxCQ1sdGzSbEQzQVxtrhPC3SRgaVj+R6o8MFN36bf5kB2MGXt0A9KcGd
         AJ4xpkm39pPw3QuGja99kp0sNJAUUGk+eQFCg6015bn1uW1+hKmtELU60Fb1e58Suw
         lNrdwirRHXYFe6lVToMHh44PHxq4yMFnKxipckUoYNsipvbaGepjxKwWbE4gSibC7d
         SROX5an+Cm3gQ==
Date:   Sun, 6 Aug 2023 14:45:43 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Loic Poulain <loic.poulain@linaro.org>
Cc:     viro@zeniv.linux.org.uk, corbet@lwn.net,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, hch@infradead.org,
        rdunlap@infradead.org
Subject: Re: [PATCH v3] init: Add support for rootwait timeout parameter
Message-ID: <20230806-leibhaftig-deutung-dd4a6b01d038@brauner>
References: <20230806101217.164068-1-loic.poulain@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230806101217.164068-1-loic.poulain@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Aug 06, 2023 at 12:12:17PM +0200, Loic Poulain wrote:
> Add an optional timeout arg to 'rootwait' as the maximum time in
> seconds to wait for the root device to show up before attempting
> forced mount of the root filesystem.
> 
> Use case:
> In case of device mapper usage for the rootfs (e.g. root=/dev/dm-0),
> if the mapper is not able to create the virtual block for any reason
> (wrong arguments, bad dm-verity signature, etc), the `rootwait` param
> causes the kernel to wait forever. It may however be desirable to only
> wait for a given time and then panic (force mount) to cause device reset.
> This gives the bootloader a chance to detect the problem and to take some
> measures, such as marking the booted partition as bad (for A/B case) or
> entering a recovery mode.
> 
> In success case, mounting happens as soon as the root device is ready,
> unlike the existing 'rootdelay' parameter which performs an unconditional
> pause.
> 
> Signed-off-by: Loic Poulain <loic.poulain@linaro.org>
> ---
>  v2: rebase + reword: add use case example
>  v3: Use kstrtoint instead of deprecated simple_strtoul
> 
>  .../admin-guide/kernel-parameters.txt         |  4 ++++
>  init/do_mounts.c                              | 24 +++++++++++++++++--
>  2 files changed, 26 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index a1457995fd41..387cf9c2a2c5 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -5501,6 +5501,10 @@
>  			Useful for devices that are detected asynchronously
>  			(e.g. USB and MMC devices).
>  
> +	rootwait=	[KNL] Maximum time (in seconds) to wait for root device
> +			to show up before attempting to mount the root
> +			filesystem.
> +
>  	rproc_mem=nn[KMG][@address]
>  			[KNL,ARM,CMA] Remoteproc physical memory block.
>  			Memory area to be used by remote processor image,
> diff --git a/init/do_mounts.c b/init/do_mounts.c
> index 1aa015883519..98190bf34a9f 100644
> --- a/init/do_mounts.c
> +++ b/init/do_mounts.c
> @@ -18,6 +18,7 @@
>  #include <linux/slab.h>
>  #include <linux/ramfs.h>
>  #include <linux/shmem_fs.h>
> +#include <linux/ktime.h>
>  
>  #include <linux/nfs_fs.h>
>  #include <linux/nfs_fs_sb.h>
> @@ -71,12 +72,25 @@ static int __init rootwait_setup(char *str)
>  {
>  	if (*str)
>  		return 0;
> -	root_wait = 1;
> +	root_wait = -1;
>  	return 1;
>  }
>  
>  __setup("rootwait", rootwait_setup);
>  
> +static int __init rootwait_timeout_setup(char *str)
> +{
> +	if (kstrtoint(str, 0, &root_wait) || root_wait < 0) {
> +		pr_warn("ignoring invalid rootwait value\n");
> +		/* fallback to indefinite wait */
> +		root_wait = -1;
> +	}
> +
> +	return 1;
> +}
> +
> +__setup("rootwait=", rootwait_timeout_setup);
> +
>  static char * __initdata root_mount_data;
>  static int __init root_data_setup(char *str)
>  {
> @@ -384,14 +398,20 @@ void __init mount_root(char *root_device_name)
>  /* wait for any asynchronous scanning to complete */
>  static void __init wait_for_root(char *root_device_name)
>  {
> +	const ktime_t end = ktime_add_ms(ktime_get_raw(), root_wait * MSEC_PER_SEC);

I'd only initialize @end after the ROOT_DEV check.

Also, afaict, this currently allows userspace to overflow, i.e.,

root_wait=2147483647

ktime_add_ms(..., root_wait(2147483647) * MSEC_PER_SEC(1000))

So idk, you probably want to convert root_wait to ms right away and do
sm like (completely untested):

static int __init rootwait_timeout_setup(char *str)
{
	int ret, tmp;

	THIS LINE WILL BREAK COMPILATION

	if (*str)
		return 0;

	/* always fallback to indefinite wait */
	root_wait = -1;

	ret = kstrtoint(str, 0, &tmp));
	if (ret || tmp < 0) {
		pr_warn("ignoring invalid rootwait value\n");
		return 1;
	}

	if (check_mul_overflow(tmp, MSEC_PER_SEC, &root_wait))
		pr_warn("ignoring excessive rootwait value\n");

	return 1;
}
