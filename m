Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E9664A93CF
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Feb 2022 07:03:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346153AbiBDGDu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Feb 2022 01:03:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238191AbiBDGDt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Feb 2022 01:03:49 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B08EC061714
        for <linux-fsdevel@vger.kernel.org>; Thu,  3 Feb 2022 22:03:49 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id 132so4236343pga.5
        for <linux-fsdevel@vger.kernel.org>; Thu, 03 Feb 2022 22:03:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6l4Se70qE+syqGJMrB/AsP3g/MR2GzyK9H999D6OCfQ=;
        b=twPrCIMqWtmqtJsfNPwMsDsagV0gpq4f/8DzAU4geJD+UGyGQgOqnMEBqrAHSi3ysi
         OZFSBTZO5Scr/Eb4sDzoWZKuO22QYO5PJeDNB1xNcD9U488BQ2Q3VPKA36Ehsd517Ilg
         pc8yNaoLDB9uzx1gwGShF90NNYCooU++3EoqDWqYITqP6Y7KjmGWoLjSM2XlV4M0zrvI
         xrlWbjtiknXe9msgZUmE1ZHfB3bxHcqzJ4oiS782bN9s3p2OCIzwRnTXNMGbJMuilLeF
         NkfoSjXMv/9pHRyF+Qt9n6thJRR4Iw1FmFt0llnpocTri/ZiS91bSirzeyBt8FQ96JpR
         WN/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6l4Se70qE+syqGJMrB/AsP3g/MR2GzyK9H999D6OCfQ=;
        b=QRUIUlfna4XREOkBNThfm1t68xZW/l3QRZjeXls8PfdJKlWVaHFzdkfCBQdtJAtlK/
         4Hnn7sQWe17j/v/shcyJk7V/ODFLnE3kKikK33TQBzesmbcAH/+gTxmqpTxnt+rTRe1T
         2aEdqPQgOtuQhCAezXtPTlZjee/7ztBOmTS/0jI0ZbQSuANDhwIq1BH2kHHTrD6KCbkZ
         TjXVtEmlKADVtK1XXX4GLuGg/CO333cNU+lRAPKBQvLr1YKFZxrP7kpEGibNN+2K/SDe
         6lbLEjNdJbM07voblu47iwmVCvJO/LkPEt+fqTntbQFMcrrCRCPWheXN3B6O1yjJXKYO
         JEAQ==
X-Gm-Message-State: AOAM532EyiipV1A33BZe2KOZ78HbVbFyf/urYe/rSNKi0SyihbUFK46S
        18P/tjTWdB3GkO8sjfBAu/l5F1fZZ4tjzs2HdDrSFA==
X-Google-Smtp-Source: ABdhPJzjeIgvLiv+7Q+Z36tObcCbqLcIUwq8r4zgIpIDVk4uTWYWTdh9zto49CaVa1EjbgHgLmkXgdhhNjk2Px33Rsw=
X-Received: by 2002:a63:550f:: with SMTP id j15mr1228156pgb.40.1643954628595;
 Thu, 03 Feb 2022 22:03:48 -0800 (PST)
MIME-Version: 1.0
References: <20220128213150.1333552-1-jane.chu@oracle.com> <20220128213150.1333552-5-jane.chu@oracle.com>
In-Reply-To: <20220128213150.1333552-5-jane.chu@oracle.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 3 Feb 2022 22:03:36 -0800
Message-ID: <CAPcyv4hFyoHgX9mo=NwOj_FPnfD8zkg_svM1sJZLn41vBm4Z8w@mail.gmail.com>
Subject: Re: [PATCH v5 4/7] dax: add dax_recovery_write to dax_op and dm
 target type
To:     Jane Chu <jane.chu@oracle.com>
Cc:     david <david@fromorbit.com>, "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        device-mapper development <dm-devel@redhat.com>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vivek Goyal <vgoyal@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 28, 2022 at 1:32 PM Jane Chu <jane.chu@oracle.com> wrote:
>
> dax_recovery_write() dax op is only required for DAX device that
> export DAXDEV_RECOVERY indicating its capability to recover from
> poisons.
>
> DM may be nested, if part of the base dax devices forming a DM
> device support dax recovery, the DM device is marked with such
> capability.
>
> Signed-off-by: Jane Chu <jane.chu@oracle.com>
[..]
> diff --git a/include/linux/dax.h b/include/linux/dax.h
> index 2fc776653c6e..1b3d6ebf3e49 100644
> --- a/include/linux/dax.h
> +++ b/include/linux/dax.h
> @@ -30,6 +30,9 @@ struct dax_operations {
>                         sector_t, sector_t);
>         /* zero_page_range: required operation. Zero page range   */
>         int (*zero_page_range)(struct dax_device *, pgoff_t, size_t);
> +       /* recovery_write: optional operation. */
> +       size_t (*recovery_write)(struct dax_device *, pgoff_t, void *, size_t,
> +                               struct iov_iter *);

The removal of the ->copy_{to,from}_iter() operations set the
precedent that dax ops should not be needed when the operation can be
carried out generically. The only need to call back to the pmem driver
is so that it can call nvdimm_clear_poison(). nvdimm_clear_poison() in
turn only needs the 'struct device' hosting the pmem and the physical
address to be cleared. The physical address is already returned by
dax_direct_access(). The device is something that could be added to
dax_device, and the pgmap could host the callback that pmem fills in.
Something like:


diff --git a/drivers/nvdimm/pfn_devs.c b/drivers/nvdimm/pfn_devs.c
index 58eda16f5c53..36486ba4753a 100644
--- a/drivers/nvdimm/pfn_devs.c
+++ b/drivers/nvdimm/pfn_devs.c
@@ -694,6 +694,7 @@ static int __nvdimm_setup_pfn(struct nd_pfn
*nd_pfn, struct dev_pagemap *pgmap)
                .end = nsio->res.end - end_trunc,
        };
        pgmap->nr_range = 1;
+       pgmap->owner = &nd_pfn->dev;
        if (nd_pfn->mode == PFN_MODE_RAM) {
                if (offset < reserve)
                        return -EINVAL;
diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
index 58d95242a836..95e1b6326f88 100644
--- a/drivers/nvdimm/pmem.c
+++ b/drivers/nvdimm/pmem.c
@@ -481,6 +481,7 @@ static int pmem_attach_disk(struct device *dev,
        }
        set_dax_nocache(dax_dev);
        set_dax_nomc(dax_dev);
+       set_dax_pgmap(dax_dev, &pmem->pgmap);
        if (is_nvdimm_sync(nd_region))
                set_dax_synchronous(dax_dev);
        rc = dax_add_host(dax_dev, disk);
diff --git a/include/linux/memremap.h b/include/linux/memremap.h
index 1fafcc38acba..8cb59b5df38b 100644
--- a/include/linux/memremap.h
+++ b/include/linux/memremap.h
@@ -81,6 +81,11 @@ struct dev_pagemap_ops {

 #define PGMAP_ALTMAP_VALID     (1 << 0)

+struct dev_pagemap_operations {
+       size_t (*recovery_write)(struct dev_pagemap *pgmap, void *, size_t,
+                                struct iov_iter *);
+};
+
 /**
  * struct dev_pagemap - metadata for ZONE_DEVICE mappings
  * @altmap: pre-allocated/reserved memory for vmemmap allocations
@@ -111,12 +116,15 @@ struct dev_pagemap {
        const struct dev_pagemap_ops *ops;
        void *owner;
        int nr_range;
+       struct dev_pagemap_operations ops;
        union {
                struct range range;
                struct range ranges[0];
        };
 };

...then DM does not need to be involved in the recovery path, fs/dax.c
just does dax_direct_access(..., DAX_RECOVERY, ...) and then looks up
the pgmap to generically coordinate the recovery_write(). The pmem
driver would be responsible for setting pgmap->recovery_write() to a
function that calls nvdimm_clear_poison().

This arch works for anything that can be described by a pgmap, and
supports error clearing, it need not be limited to the pmem block
driver.
