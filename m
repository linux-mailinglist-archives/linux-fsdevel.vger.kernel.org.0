Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD2BD6D937A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Apr 2023 12:00:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236536AbjDFKAw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Apr 2023 06:00:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236526AbjDFKA1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Apr 2023 06:00:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5B2E86AB;
        Thu,  6 Apr 2023 03:00:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F07B96455C;
        Thu,  6 Apr 2023 10:00:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5A27C433EF;
        Thu,  6 Apr 2023 10:00:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1680775202;
        bh=WvH1QLnSC75c7SwSR4krkaAJCUF9p5g8TKLp+jWis7Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kKx34QXDiBpYMeOdyqG1cMkXCMSHVlSTIRiwCWuJuXOMOXlrex211Y6tZRGc5mlOO
         fRN/5A/7zX5zx5GFHEf7VFMATL90bpAqXa9WnIaFMuoISHzLy0/Hx5Kw3bc2ZYw7bj
         kloCJgm5v9nL3I8Ocv+IrclcbnDtuZphLhtewL64=
Date:   Thu, 6 Apr 2023 11:59:59 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Yangtao Li <frank.li@vivo.com>
Cc:     xiang@kernel.org, chao@kernel.org, huyue2@coolpad.com,
        jefflexu@linux.alibaba.com, damien.lemoal@opensource.wdc.com,
        naohiro.aota@wdc.com, jth@kernel.org, rafael@kernel.org,
        linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/3] kobject: introduce kobject_is_added()
Message-ID: <2023040628-cocoa-lizard-9941@gregkh>
References: <20230406093056.33916-1-frank.li@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230406093056.33916-1-frank.li@vivo.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 06, 2023 at 05:30:54PM +0800, Yangtao Li wrote:
> Add kobject_is_added() to avoid consumers from directly accessing
> the internal variables of kobject.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>  include/linux/kobject.h | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/include/linux/kobject.h b/include/linux/kobject.h
> index bdab370a24f4..b5cdb0c58729 100644
> --- a/include/linux/kobject.h
> +++ b/include/linux/kobject.h
> @@ -203,6 +203,11 @@ static inline const struct kobj_type *get_ktype(const struct kobject *kobj)
>  	return kobj->ktype;
>  }
>  
> +static inline int kobject_is_added(struct kobject *kobj)
> +{
> +	return kobj->state_in_sysfs;
> +}
> +

No, this implies that the caller is not doing something correctly as it
should always know if it has added a kobject or not.  Let me review the
please where you used this to find the problems there...

thanks,

greg k-h
