Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9742A6D939A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Apr 2023 12:05:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236658AbjDFKFU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Apr 2023 06:05:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236829AbjDFKFI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Apr 2023 06:05:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 433D74C25;
        Thu,  6 Apr 2023 03:05:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 91C3262C20;
        Thu,  6 Apr 2023 10:05:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79D2FC433EF;
        Thu,  6 Apr 2023 10:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1680775506;
        bh=92lTD3EX6QZGcz05caCSQGuverBGUc9p+3YV5LN7ZSk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IFDIe4FeiUOzbC59cAl1tE1lGX2tjalx7s96DwtifkQljZVqq+gTmWhspg+RQf7h9
         EfF6Gza3ykeaYehWWBBfJjDzlJRDtzXQ91BIKws7z5Xn2An7LjW41Nk+tlTvAGx8tu
         HToafdlfkrlTxVzsZqyeuyITw91bjpabpMF64WxQ=
Date:   Thu, 6 Apr 2023 12:05:03 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Yangtao Li <frank.li@vivo.com>
Cc:     xiang@kernel.org, chao@kernel.org, huyue2@coolpad.com,
        jefflexu@linux.alibaba.com, damien.lemoal@opensource.wdc.com,
        naohiro.aota@wdc.com, jth@kernel.org, rafael@kernel.org,
        linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 3/3] zonefs: convert to use kobject_is_added()
Message-ID: <2023040616-armory-unmade-4422@gregkh>
References: <20230406093056.33916-1-frank.li@vivo.com>
 <20230406093056.33916-3-frank.li@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230406093056.33916-3-frank.li@vivo.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 06, 2023 at 05:30:56PM +0800, Yangtao Li wrote:
> Use kobject_is_added() instead of local `s_sysfs_registered` variables.
> BTW kill kobject_del() directly, because kobject_put() actually covers
> kobject removal automatically.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>  fs/zonefs/sysfs.c  | 11 +++++------
>  fs/zonefs/zonefs.h |  1 -
>  2 files changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/zonefs/sysfs.c b/fs/zonefs/sysfs.c
> index 8ccb65c2b419..f0783bf7a25c 100644
> --- a/fs/zonefs/sysfs.c
> +++ b/fs/zonefs/sysfs.c
> @@ -101,8 +101,6 @@ int zonefs_sysfs_register(struct super_block *sb)
>  		return ret;
>  	}
>  
> -	sbi->s_sysfs_registered = true;

You know this, why do you need to have a variable tell you this or not?

> -
>  	return 0;
>  }
>  
> @@ -110,12 +108,13 @@ void zonefs_sysfs_unregister(struct super_block *sb)
>  {
>  	struct zonefs_sb_info *sbi = ZONEFS_SB(sb);
>  
> -	if (!sbi || !sbi->s_sysfs_registered)

How can either of these ever be true?  Note, sbi should be passed here
to this function, not the super block as that is now unregistered from
the system.  Looks like no one has really tested this codepath that much
:(

> +	if (!sbi)
>  		return;

this can not ever be true, right?


>  
> -	kobject_del(&sbi->s_kobj);
> -	kobject_put(&sbi->s_kobj);
> -	wait_for_completion(&sbi->s_kobj_unregister);
> +	if (kobject_is_added(&sbi->s_kobj)) {

Again, not needed.

thanks,

greg k-h
