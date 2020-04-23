Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A2761B65AA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Apr 2020 22:43:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726168AbgDWUm5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Apr 2020 16:42:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725877AbgDWUm4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Apr 2020 16:42:56 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7DAEC09B042;
        Thu, 23 Apr 2020 13:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=nJLSDGN5VY8xtXJ36BBTvatwr9Gu5FO1bsWGt3pWVi0=; b=IhCQdgX+d7fMn24cC4Sw1CdfzY
        PtZCU6+PS7X24P8ln/X+tthGWSIP/ZXh7ecDD5CMnEP9uWiQd4HwIELGXgmaU0By/DVBfV+uRn0Zm
        n6BRCG0WdMWlKepAeJaDmIWlmR1Mznmo4hofGUy438Tsa+ZAYhDzTaaWKp5x8OxYQvKYPVhVxVNIm
        RGZS1eW0pfVDC57wenXBRd4HqTgHQz51P4sYwToBrMU6yCxQ4kUPNF5dKrU82TRwtDv/2Rfe1ia0r
        a/WfkJhpuAebfWCeWfwNwp6sQheN6XBjA0lR5ZrOn7L8g92eUEgdUm0FxfwhjHHQ7GYUhdZXclZyv
        OA7U+C1w==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jRigI-0000Td-NL; Thu, 23 Apr 2020 20:42:46 +0000
Subject: Re: [PATCH] firmware_loader: re-export fw_fallback_config into
 firmware_loader's own namespace
To:     "Luis R. Rodriguez" <mcgrof@kernel.org>, gregkh@linuxfoundation.org
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
        Stephen Rothwell <sfr@canb.auug.org.au>
References: <20200423203140.19510-1-mcgrof@kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <3b9dcfdc-a9bf-5a52-7fcf-1a3ea4826147@infradead.org>
Date:   Thu, 23 Apr 2020 13:42:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200423203140.19510-1-mcgrof@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 4/23/20 1:31 PM, Luis R. Rodriguez wrote:
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

Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>

thanks.

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
> diff --git a/drivers/base/firmware_loader/fallback_table.c b/drivers/base/firmware_loader/fallback_table.c
> index 0a737349f78f..46a731dede6f 100644
> --- a/drivers/base/firmware_loader/fallback_table.c
> +++ b/drivers/base/firmware_loader/fallback_table.c
> @@ -21,6 +21,7 @@ struct firmware_fallback_config fw_fallback_config = {
>  	.loading_timeout = 60,
>  	.old_timeout = 60,
>  };
> +EXPORT_SYMBOL_NS_GPL(fw_fallback_config, FIRMWARE_LOADER_PRIVATE);
>  
>  #ifdef CONFIG_SYSCTL
>  struct ctl_table firmware_config_table[] = {
> 


-- 
~Randy
