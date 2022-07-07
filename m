Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B54C956A7B7
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Jul 2022 18:13:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235976AbiGGQMD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Jul 2022 12:12:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235953AbiGGQLj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Jul 2022 12:11:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97FE433350;
        Thu,  7 Jul 2022 09:10:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 347E0623E2;
        Thu,  7 Jul 2022 16:10:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D6AAC3411E;
        Thu,  7 Jul 2022 16:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657210249;
        bh=9Rh396CKXH0FuHlZMYkM5a1yPWoX1HChEl9dRmBJAm0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=jmK0c+vyGAqHN6jPfTbrSNu9EnDBttNpGRdQSMwCFbEfc7KdToJwScXAWeTYRvbie
         kHRCTjiKCsuuC2ihifrSa2lHfXRe053aS5BgvUgySDICUtvvDItDggQ8nqgnC9DYqe
         oaBSvLRzQ7MzgQKEtLLyu+x6vmqpqKnVt92AhZ5jIo2UYbnSVbOidhyYEAl6V9huZQ
         YfhBlFr3Y2B+WVwhgHTXQMzqh4kbYqOh4yZ6RFL8nPKnv/VPEUc4QEnLngxEKyd8QU
         HkGvJCBESZA5E7NDpwdCpKawMTaj1TKeIuv7Z4aKB0RrsYDifUOv0fcdJj+Iub6Ji5
         xCIzxtgKH1k+A==
Date:   Thu, 7 Jul 2022 11:10:47 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     ira.weiny@intel.com
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH 1/3] xarray: Introduce devm_xa_init()
Message-ID: <20220707161047.GA307158@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220705232159.2218958-2-ira.weiny@intel.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 05, 2022 at 04:21:57PM -0700, ira.weiny@intel.com wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> Many devices may have arrays of resources which are allocated with
> device managed functions.  The objects referenced by the XArray are
> therefore automatically destroyed without the need for the XArray.

"... without the need for the XArray" seems like it's missing
something.

Should this say something like "... without the need for destroying
them in the XArray destroy action"?

> Introduce devm_xa_init() which takes care of the destruction of the
> XArray meta data automatically as well.
> 
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Matthew Wilcox <willy@infradead.org>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 
> ---
> The main issue I see with this is defining devm_xa_init() in device.h.
> This makes sense because a device is required to use the call.  However,
> I'm worried about if users will find the call there vs including it in
> xarray.h?
> ---
>  drivers/base/core.c    | 20 ++++++++++++++++++++
>  include/linux/device.h |  3 +++
>  2 files changed, 23 insertions(+)
> 
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 2eede2ec3d64..8c5c20a62744 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -2609,6 +2609,26 @@ void devm_device_remove_groups(struct device *dev,
>  }
>  EXPORT_SYMBOL_GPL(devm_device_remove_groups);
>  
> +static void xa_destroy_cb(void *xa)
> +{
> +	xa_destroy(xa);
> +}
> +
> +/**
> + * devm_xa_init() - Device managed initialization of an empty XArray
> + * @dev: The device this xarray is associated with
> + * @xa: XArray
> + *
> + * Context: Any context
> + * Returns: 0 on success, -errno if the action fails to be set
> + */
> +int devm_xa_init(struct device *dev, struct xarray *xa)
> +{
> +	xa_init(xa);
> +	return devm_add_action(dev, xa_destroy_cb, xa);
> +}
> +EXPORT_SYMBOL(devm_xa_init);
> +
>  static int device_add_attrs(struct device *dev)
>  {
>  	struct class *class = dev->class;
> diff --git a/include/linux/device.h b/include/linux/device.h
> index 073f1b0126ac..e06dc63e375b 100644
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -27,6 +27,7 @@
>  #include <linux/uidgid.h>
>  #include <linux/gfp.h>
>  #include <linux/overflow.h>
> +#include <linux/xarray.h>
>  #include <linux/device/bus.h>
>  #include <linux/device/class.h>
>  #include <linux/device/driver.h>
> @@ -978,6 +979,8 @@ int __must_check devm_device_add_group(struct device *dev,
>  void devm_device_remove_group(struct device *dev,
>  			      const struct attribute_group *grp);
>  
> +int devm_xa_init(struct device *dev, struct xarray *xa);
> +
>  /*
>   * Platform "fixup" functions - allow the platform to have their say
>   * about devices and actions that the general device layer doesn't
> -- 
> 2.35.3
> 
