Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8119F46F588
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Dec 2021 22:03:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232563AbhLIVHG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Dec 2021 16:07:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232547AbhLIVHG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Dec 2021 16:07:06 -0500
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E671C061746;
        Thu,  9 Dec 2021 13:03:32 -0800 (PST)
Received: by mail-io1-xd36.google.com with SMTP id c3so8198303iob.6;
        Thu, 09 Dec 2021 13:03:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OQHy1bXS7MSNc4y1X7Ea+FIUv0jLINhYPtZYDEpKbkE=;
        b=FhQ85vNKHELwZo0nkCQibyvUxqFyQZ8r9HhGYfEqeBcJI5OgQpd0zTKTiwqZYvh60i
         qjsAhP03ZKxoU9+cHeJdrlXQrxI+whAiA8lqzhwWYF7zlQ/xjje85v1RkkUo3ZEHOSU+
         9aOs6BBudIhoml99lowBeByulXk0Es3Y9YbPTlP8wTMzapdGRmBVlUXcHGklztQKEk9l
         n9VVb4s/5cRwmt+E97QAUaDArG1yQX/2JdE/Xl0qJn1eE+v9eN2zMLnWvIjnFO4Iz0Q9
         d+5IriPiiRSFMD/LfCZIy5obLpKahKrTu5KcJICfwM/PMAhTUuC/dyJo9L1nwXhJdyPg
         E4cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OQHy1bXS7MSNc4y1X7Ea+FIUv0jLINhYPtZYDEpKbkE=;
        b=fgsBiniGBixNhFekedFZ1xr2RdYoC16VPcYFl6/3pznfnkmMU+uFoqQ5mgYPnHCXKz
         /FHo3vkXzUhDa1sDpFEiHXHStsulh5tLOTzlj/CkMzv7jOkb/EQKJi7ciSsnBN1AWfDH
         GYaBThrbCoBxopauVi2mnlgtqCabG67q3Rcuz/SFi9OE5XixA4yNlOLut5eB9dnY3pqY
         H6g9acFGfqrxApdqBn76TGb6v0C0m42DxzatqKEF4rDbztUn0TPFW4z4vML9G/CfkcCD
         1UV0pVW2KzYLqZ61UHeQFXCHfXgfbn1eXziOzmJZ2oKc54pYDar5HqlsUQ49Q4C729Tk
         TppQ==
X-Gm-Message-State: AOAM530ZGx/geQ0R/tHGAnyO3G6t1MQKBfJKQiUeBGyY3c+7WlfAnqgb
        klbjH6Pa0BPasXPloFVBGi5DsxvEvnItPdjDS4A=
X-Google-Smtp-Source: ABdhPJzdR8/xxlTzc1bhOu3h5WQNw3hb9R+B7FFn/3yf7TVl7aIyML2KG3xS+LK6+egSaCHAjnHNjsBgCItR+Bz7wsI=
X-Received: by 2002:a6b:7711:: with SMTP id n17mr16789543iom.21.1639083811769;
 Thu, 09 Dec 2021 13:03:31 -0800 (PST)
MIME-Version: 1.0
References: <20211209063828.18944-1-hch@lst.de> <20211209063828.18944-3-hch@lst.de>
In-Reply-To: <20211209063828.18944-3-hch@lst.de>
From:   Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Date:   Thu, 9 Dec 2021 22:03:20 +0100
Message-ID: <CAM9Jb+j2Gu8MCyV1w-E=C-MPFW6zQLTi1M9kM+36efrbFZRPtQ@mail.gmail.com>
Subject: Re: [PATCH 2/5] dax: simplify dax_synchronous and set_dax_synchronous
To:     Christoph Hellwig <hch@lst.de>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Matthew Wilcox <willy@infradead.org>, dm-devel@redhat.com,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        linux-s390@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> Remove the pointless wrappers.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/dax/super.c |  8 ++++----
>  include/linux/dax.h | 12 ++----------
>  2 files changed, 6 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/dax/super.c b/drivers/dax/super.c
> index e7152a6c4cc40..e18155f43a635 100644
> --- a/drivers/dax/super.c
> +++ b/drivers/dax/super.c
> @@ -208,17 +208,17 @@ bool dax_write_cache_enabled(struct dax_device *dax_dev)
>  }
>  EXPORT_SYMBOL_GPL(dax_write_cache_enabled);
>
> -bool __dax_synchronous(struct dax_device *dax_dev)
> +bool dax_synchronous(struct dax_device *dax_dev)
>  {
>         return test_bit(DAXDEV_SYNC, &dax_dev->flags);
>  }
> -EXPORT_SYMBOL_GPL(__dax_synchronous);
> +EXPORT_SYMBOL_GPL(dax_synchronous);
>
> -void __set_dax_synchronous(struct dax_device *dax_dev)
> +void set_dax_synchronous(struct dax_device *dax_dev)
>  {
>         set_bit(DAXDEV_SYNC, &dax_dev->flags);
>  }
> -EXPORT_SYMBOL_GPL(__set_dax_synchronous);
> +EXPORT_SYMBOL_GPL(set_dax_synchronous);
>
>  bool dax_alive(struct dax_device *dax_dev)
>  {
> diff --git a/include/linux/dax.h b/include/linux/dax.h
> index 87ae4c9b1d65b..3bd1fdb5d5f4b 100644
> --- a/include/linux/dax.h
> +++ b/include/linux/dax.h
> @@ -48,16 +48,8 @@ void put_dax(struct dax_device *dax_dev);
>  void kill_dax(struct dax_device *dax_dev);
>  void dax_write_cache(struct dax_device *dax_dev, bool wc);
>  bool dax_write_cache_enabled(struct dax_device *dax_dev);
> -bool __dax_synchronous(struct dax_device *dax_dev);
> -static inline bool dax_synchronous(struct dax_device *dax_dev)
> -{
> -       return  __dax_synchronous(dax_dev);
> -}
> -void __set_dax_synchronous(struct dax_device *dax_dev);
> -static inline void set_dax_synchronous(struct dax_device *dax_dev)
> -{
> -       __set_dax_synchronous(dax_dev);
> -}
> +bool dax_synchronous(struct dax_device *dax_dev);
> +void set_dax_synchronous(struct dax_device *dax_dev);
>  /*
>   * Check if given mapping is supported by the file / underlying device.
>   */

Looks good to me.

Reviewed-by: Pankaj Gupta <pankaj.gupta@ionos.com>
