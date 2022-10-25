Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1D0060CB44
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Oct 2022 13:51:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231376AbiJYLvD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Oct 2022 07:51:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbiJYLvC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Oct 2022 07:51:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97F79AD990;
        Tue, 25 Oct 2022 04:51:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 41797B818C7;
        Tue, 25 Oct 2022 11:50:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99B8FC433D6;
        Tue, 25 Oct 2022 11:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1666698658;
        bh=2q9yCMJPloB0tSzUJjbYgjAx8y4cQSUIuV+sBYUgmo4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Rz/lhElhFKy9egwIUiV8Rn6Eze7fddqhSTvsIjQ3Ob1FehsTmM2ANPc5YtNA6sK1P
         3NniVi1OeM+8qaWKZsgzKC5gXeerKeZ+FJAzfhrtmMORBSELtU+Iwkdj4DaE1DSgRh
         juInSSeKa6MAbkOxY9lUjZIQAj1v84jUgRCicyWk=
Date:   Tue, 25 Oct 2022 13:50:55 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        logang@deltatee.com, dan.j.williams@intel.com,
        hans.verkuil@cisco.com, alexandre.belloni@free-electrons.com,
        viro@zeniv.linux.org.uk
Subject: Re: [PATCH v2] chardev: fix error handling in cdev_device_add()
Message-ID: <Y1fNnwLlY079xGVY@kroah.com>
References: <20221025113957.693723-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221025113957.693723-1-yangyingliang@huawei.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 25, 2022 at 07:39:57PM +0800, Yang Yingliang wrote:
> While doing fault injection test, I got the following report:
> 
> ------------[ cut here ]------------
> kobject: '(null)' (0000000039956980): is not initialized, yet kobject_put() is being called.
> WARNING: CPU: 3 PID: 6306 at kobject_put+0x23d/0x4e0
> CPU: 3 PID: 6306 Comm: 283 Tainted: G        W          6.1.0-rc2-00005-g307c1086d7c9 #1253
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1ubuntu1.1 04/01/2014
> RIP: 0010:kobject_put+0x23d/0x4e0
> Call Trace:
>  <TASK>
>  cdev_device_add+0x15e/0x1b0
>  __iio_device_register+0x13b4/0x1af0 [industrialio]
>  __devm_iio_device_register+0x22/0x90 [industrialio]
>  max517_probe+0x3d8/0x6b4 [max517]
>  i2c_device_probe+0xa81/0xc00
> 
> When device_add() is injected fault and returns error, if dev->devt is not set,
> cdev_add() is not called, cdev_del() is not needed. Fix this by checking dev->devt
> in error path.

Nit, please wrap your changelog text at 72 columns.

> 
> Fixes: 233ed09d7fda ("chardev: add helper function to register char devs with a struct device")
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
> v1 -> v2:
>   Add information to update commit message.
>   v1 link: https://lore.kernel.org/lkml/1959fa74-b06c-b8bc-d14f-b71e5c4290ee@huawei.com/T/
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

No, this is a layering violation and one that you do not know is really
going to be true or not.  the devt being present, or not, should not be
an issue of if the device_add failed or not.  This isn't correct, sorry.

thanks,

greg k-h
