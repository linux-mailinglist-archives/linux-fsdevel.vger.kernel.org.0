Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26B4D42D530
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Oct 2021 10:36:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbhJNIik (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Oct 2021 04:38:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230051AbhJNIij (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Oct 2021 04:38:39 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DBECC06174E
        for <linux-fsdevel@vger.kernel.org>; Thu, 14 Oct 2021 01:36:34 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id r7so16943329wrc.10
        for <linux-fsdevel@vger.kernel.org>; Thu, 14 Oct 2021 01:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cfakvhen/wxw5fHdRu0DEuLT5DMfJlXe2a/johLjqxo=;
        b=h40uJnzRy4bIKfqfvwm3i/kik60+Kgx2sfXbHxmv0MsZax7HkeDmryc9yctryM7xlU
         37bg2VuoZWdH4kTXGosC95Fa3QYJayYirIbI/UeFVNH/Nzn2/7/VodB6g1hiMuG9zp+p
         egl0Br7pM5vnKxSuUDa7BUq17cmPH9MsIYOosVtDeEDQMUaCZ6h+AWD2esXOH1LRk+zZ
         X2uV1Nn3ulaudun/4f5AT6jS5oilV0myDq9ozSQAqUnytF1YgcEInQmj+cCLjl5OgT5o
         004n5bwSXge4iP3a4skCS8avlQccw5QvPN8BVpAjam8zZmlkvShcDVpQvgmxjplGDMKz
         pkRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cfakvhen/wxw5fHdRu0DEuLT5DMfJlXe2a/johLjqxo=;
        b=CX7wywshvNPrbUxguymA6qcMzjh+abISmv8Ba9UJeAxukkfY8y9AFGbSYuHw99UdLf
         JFiV5nC+7Duz8u3LquclZzEldesSYrF16oG3CXVFtPCzeQHIcd0oNnqTmua2sC2SFlSU
         QH3YHrfWMR830ZX8MC/vg/n+ZWKJq8dINPrqma3ZOxoplbWTPbV+8WxDMzEJ8BxayK/F
         F0N/nG6zZDmZO5RAjPsQmJJ+4EB1EZxhoAsV8l1sSDEfbVQoT+TfeHf93vyB1SWs5sTF
         7CYge7X6jl/zqChSVXQZMXmFMC/Z4dO/jHIOWRkH5/Lf5chHXND8LPVE8o9sMIKFXS17
         7/IA==
X-Gm-Message-State: AOAM530uTPx/wgP4m6L9LL6NG0r/1QW+MHV3muR9d5euyLxSrbBfhTdn
        0yRnLOOyh7SK7y4Z80kf96CVZA==
X-Google-Smtp-Source: ABdhPJzpVg8OIER+zTALG2ilasSHxD7bC/dTlVAeWBUDgRwrRvN9DCthCd2lRX0ZyZDpw2FTk6Hq6g==
X-Received: by 2002:a5d:59a9:: with SMTP id p9mr5151873wrr.386.1634200593067;
        Thu, 14 Oct 2021 01:36:33 -0700 (PDT)
Received: from myrica (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net. [82.27.106.168])
        by smtp.gmail.com with ESMTPSA id r4sm2299114wrz.58.2021.10.14.01.36.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Oct 2021 01:36:32 -0700 (PDT)
Date:   Thu, 14 Oct 2021 09:36:09 +0100
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Jason Wang <jasowang@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Matt Mackall <mpm@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Amit Shah <amit@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Gonglei <arei.gonglei@huawei.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        "Enrico Weigelt, metux IT consult" <info@metux.net>,
        Viresh Kumar <vireshk@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        David Airlie <airlied@linux.ie>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>, Jie Deng <jie.deng@intel.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Kalle Valo <kvalo@codeaurora.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        David Hildenbrand <david@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Stefano Garzarella <sgarzare@redhat.com>,
        Anton Yakovlev <anton.yakovlev@opensynergy.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, linux-um@lists.infradead.org,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-gpio@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-i2c@vger.kernel.org, iommu@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-wireless@vger.kernel.org,
        nvdimm@lists.linux.dev, linux-remoteproc@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net, kvm@vger.kernel.org,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH RFC] virtio: wrap config->reset calls
Message-ID: <YWfr+Z0wgpQ48yC5@myrica>
References: <20211013105226.20225-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211013105226.20225-1-mst@redhat.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 13, 2021 at 06:55:31AM -0400, Michael S. Tsirkin wrote:
> This will enable cleanups down the road.
> The idea is to disable cbs, then add "flush_queued_cbs" callback
> as a parameter, this way drivers can flush any work
> queued after callbacks have been disabled.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---

>  drivers/iommu/virtio-iommu.c               | 2 +-

Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
