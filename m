Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 458061B70A7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Apr 2020 11:21:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbgDXJVW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Apr 2020 05:21:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:52594 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726298AbgDXJVW (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Apr 2020 05:21:22 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4E18B20724;
        Fri, 24 Apr 2020 09:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587720081;
        bh=oMdVEGseu3X/uVHRcbF5bwxXym0BrmbiTesm/lnUwAY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SUjtBfnhnrnzWa6W6RINqmGOPrcrjJv7CIwkZIfNi9fbEITE82prDj298vVf38/7u
         dmi7pkaadA69Zro+u4mHv91OBsx8Hzb5zPVnkkimxORXQHCQlFQZPEumUJJOrVuaeO
         22yCx35mZauNiPsuor/b1+9me7fbc8DeI0NUyBHI=
Date:   Fri, 24 Apr 2020 11:21:19 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc:     akpm@linux-foundation.org, josh@joshtriplett.org,
        rishabhb@codeaurora.org, kubakici@wp.pl, maco@android.com,
        andy.gross@linaro.org, david.brown@linaro.org,
        bjorn.andersson@linaro.org, linux-wireless@vger.kernel.org,
        keescook@chromium.org, shuah@kernel.org, mfuzzey@parkeon.com,
        zohar@linux.vnet.ibm.com, dhowells@redhat.com,
        pali.rohar@gmail.com, tiwai@suse.de, arend.vanspriel@broadcom.com,
        zajec5@gmail.com, nbroeking@me.com, markivx@codeaurora.org,
        broonie@kernel.org, dmitry.torokhov@gmail.com, dwmw2@infradead.org,
        torvalds@linux-foundation.org, Abhay_Salunke@dell.com,
        jewalt@lgsinnovations.com, cantabile.desu@gmail.com, ast@fb.com,
        andresx7@gmail.com, dan.rue@linaro.org, brendanhiggins@google.com,
        yzaikin@google.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] firmware_loader: re-export fw_fallback_config into
 firmware_loader's own namespace
Message-ID: <20200424092119.GA360114@kroah.com>
References: <20200423203140.19510-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200423203140.19510-1-mcgrof@kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 23, 2020 at 08:31:40PM +0000, Luis R. Rodriguez wrote:
> From: Luis Chamberlain <mcgrof@kernel.org>
> 
> Christoph's recent patch "firmware_loader: remove unused exports", which
> is not merged upstream yet, removed two exported symbols. One is fine to
> remove since only built-in code uses it but the other is incorrect.
> 
> If CONFIG_FW_LOADER=m so the firmware_loader is modular but
> CONFIG_FW_LOADER_USER_HELPER=y we fail at mostpost with:
> 
> ERROR: modpost: "fw_fallback_config" [drivers/base/firmware_loader/firmware_class.ko] undefined!
> 
> This happens because the variable fw_fallback_config is built into the
> kernel if CONFIG_FW_LOADER_USER_HELPER=y always, so we need to grant
> access to the firmware loader module by exporting it.
> 
> Instead of just exporting it as we used to, take advantage of the new
> kernel symbol namespacing functionality, and export the symbol only to
> the firmware loader private namespace. This would prevent misuses from
> other drivers and makes it clear the goal is to keep this private to
> the firmware loader alone.
> 
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Randy Dunlap <rdunlap@infradead.org>
> Cc: Stephen Rothwell <sfr@canb.auug.org.au>
> Fixes: "firmware_loader: remove unused exports"
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
>  drivers/base/firmware_loader/fallback.c       | 3 +++
>  drivers/base/firmware_loader/fallback_table.c | 1 +
>  2 files changed, 4 insertions(+)
> 
> diff --git a/drivers/base/firmware_loader/fallback.c b/drivers/base/firmware_loader/fallback.c
> index 1e9c96e3ed63..d9ac7296205e 100644
> --- a/drivers/base/firmware_loader/fallback.c
> +++ b/drivers/base/firmware_loader/fallback.c
> @@ -9,6 +9,7 @@
>  #include <linux/umh.h>
>  #include <linux/sysctl.h>
>  #include <linux/vmalloc.h>
> +#include <linux/module.h>
>  
>  #include "fallback.h"
>  #include "firmware.h"
> @@ -17,6 +18,8 @@
>   * firmware fallback mechanism
>   */
>  
> +MODULE_IMPORT_NS(FIRMWARE_LOADER_PRIVATE);
> +
>  extern struct firmware_fallback_config fw_fallback_config;
>  
>  /* These getters are vetted to use int properly */

While nice, that does not fix the existing build error that people are
having, right?

> diff --git a/drivers/base/firmware_loader/fallback_table.c b/drivers/base/firmware_loader/fallback_table.c
> index 0a737349f78f..46a731dede6f 100644
> --- a/drivers/base/firmware_loader/fallback_table.c
> +++ b/drivers/base/firmware_loader/fallback_table.c
> @@ -21,6 +21,7 @@ struct firmware_fallback_config fw_fallback_config = {
>  	.loading_timeout = 60,
>  	.old_timeout = 60,
>  };
> +EXPORT_SYMBOL_NS_GPL(fw_fallback_config, FIRMWARE_LOADER_PRIVATE);


How about you send a patch that just reverts the single symbol change
first, and then a follow-on patch that does this namespace addition.  I
can queue the first one up now, for 5.7-final, and the second one for
5.8-rc1.

thanks,

greg k-h
