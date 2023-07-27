Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BD05764674
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jul 2023 08:08:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232582AbjG0GIn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Jul 2023 02:08:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232502AbjG0GIm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Jul 2023 02:08:42 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FF3F10F9;
        Wed, 26 Jul 2023 23:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=HOjfkUq3p22xP8kOD+j8BQJBJjD59Omrm1gEuBPwYmU=; b=fcUXEHtdA78JEdJygveP8HpZ86
        DPR3f1yho5ZGvB12gAv398M2mPsJnNVUBiSUUuaQNWgxGXMRPM68iLVvYS2qxKlHQLn24NktVe9Ah
        gYCTQu+Lx44qclc3WdsVPgF1tf9SbNnyUMMIOxciSf8J0tkdmMOQ49W8/lmixj0K869cWKh4G8/AP
        n1hQveKidiM43PkRIciVA4QJ1a/yepbUWv1LpUDKYdDo6r2xj95gX7qmrQcmmTLUU6SdgKZXxhD/C
        +5e8YdXr5dzsyNN4dcQE7dZPdIr699KoYaGb0Z3cW+hH/YCQTH9MfScSw3nN6l8aiMKxmOa/miSP/
        JIXPgGAw==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qOuAv-00CHuh-1F;
        Thu, 27 Jul 2023 06:08:37 +0000
Message-ID: <1d363177-2629-1ab3-7a4b-bc67d94bb87a@infradead.org>
Date:   Wed, 26 Jul 2023 23:08:35 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2] init: Add support for rootwait timeout parameter
Content-Language: en-US
To:     Loic Poulain <loic.poulain@linaro.org>, brauner@kernel.org,
        viro@zeniv.linux.org.uk, corbet@lwn.net
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, hch@infradead.org
References: <20230726152232.932288-1-loic.poulain@linaro.org>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230726152232.932288-1-loic.poulain@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi--

On 7/26/23 08:22, Loic Poulain wrote:
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
> 
>  .../admin-guide/kernel-parameters.txt         |  4 ++++
>  init/do_mounts.c                              | 19 +++++++++++++++++--
>  2 files changed, 21 insertions(+), 2 deletions(-)
> 

> diff --git a/init/do_mounts.c b/init/do_mounts.c
> index 1aa015883519..118f2bbe7b38 100644
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
> @@ -71,12 +72,20 @@ static int __init rootwait_setup(char *str)
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
> +	root_wait = simple_strtoul(str, NULL, 0);

Better to use kstrtoul().  simple_strtoul() says:

 * This function has caveats. Please use kstrtoul instead.

and kstrtoul() says:

 * Returns 0 on success, -ERANGE on overflow and -EINVAL on parsing error.
 * Preferred over simple_strtoul(). Return code must be checked.

> +	return 1;
> +}
> +
> +__setup("rootwait=", rootwait_timeout_setup);


-- 
~Randy
