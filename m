Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4192957491F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Jul 2022 11:33:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231278AbiGNJdV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Jul 2022 05:33:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbiGNJdU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Jul 2022 05:33:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FC912A6;
        Thu, 14 Jul 2022 02:33:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CE70761F26;
        Thu, 14 Jul 2022 09:33:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3B6DC34114;
        Thu, 14 Jul 2022 09:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1657791199;
        bh=TZFJzI83IXQ3alcqCeK81amEe32n0bI6+EbmGjL6HmQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SFUep/cQWieLvydhW9xM+lmIflbSOPI7xiOaEZ7uRjcyiarVUAYWiBCYTGw76PUAj
         37gACZE9pMEmyyv634VLoVd6RYeiqy27yo5f6yzpbBA520JMJYKKziNVZCsP2FCcFL
         Nk/6f6NFyyIz3bUXR94Scvd4aXhT/E5uDH08tcQ8=
Date:   Thu, 14 Jul 2022 11:33:16 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        logang@deltatee.com, dan.j.williams@intel.com,
        hans.verkuil@cisco.com, alexandre.belloni@free-electrons.com,
        viro@zeniv.linux.org.uk
Subject: Re: [PATCH RESEND] chardev: fix error handling in cdev_device_add()
Message-ID: <Ys/i3EBk2nZea8Hy@kroah.com>
References: <20220714092355.991306-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220714092355.991306-1-yangyingliang@huawei.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 14, 2022 at 05:23:55PM +0800, Yang Yingliang wrote:
> If dev->devt is not set, cdev_add() will not be called, so if device_add()
> fails, cdev_del() is not needed. Fix this by checking dev->devt in error
> case.
> 
> Fixes: 233ed09d7fda ("chardev: add helper function to register char devs with a struct device")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>  fs/char_dev.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/char_dev.c b/fs/char_dev.c
> index ba0ded7842a7..3f667292608c 100644
> --- a/fs/char_dev.c
> +++ b/fs/char_dev.c
> @@ -547,7 +547,7 @@ int cdev_device_add(struct cdev *cdev, struct device *dev)
>  	}
>  
>  	rc = device_add(dev);
> -	if (rc)
> +	if (rc && dev->devt)
>  		cdev_del(cdev);
>  
>  	return rc;
> -- 
> 2.25.1
> 

Please see https://lore.kernel.org/r/YsLtXYa4kRYEEaX/@kroah.com for why
I will no longer accept patches from Huawei with the "hulk robot" claim
without the required information.

Also, you did not state why this was a RESEND.

Now dropped from my review queue,

greg k-h
