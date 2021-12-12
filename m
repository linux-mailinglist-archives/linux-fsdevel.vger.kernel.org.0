Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7FFC471AB1
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 Dec 2021 15:23:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231391AbhLLOXx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 12 Dec 2021 09:23:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231384AbhLLOXw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 12 Dec 2021 09:23:52 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91775C061714
        for <linux-fsdevel@vger.kernel.org>; Sun, 12 Dec 2021 06:23:52 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id cq22-20020a17090af99600b001a9550a17a5so12842435pjb.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 12 Dec 2021 06:23:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8lwwZWzMg5a3s7lwMASlg5tu9b+fzGmp/D7TMwKxKFc=;
        b=C1VDazYvOsHerGRum3UpDemvC3bLBABNz77cgqTNDNW/AlDRjmxr+knCqOb3lbM8WO
         nCuRMxTi17hjy2mfZFS6DLg1CC+TyYg8zaU2aBeKKFky3Rcsp4/9vOZKTntOjByb+hJ5
         0z6NFJU2SLN62ZWqorLtNFaHccHYM1JZ7Mu2yHUUiPrzmD1llDNRqRtKoHw0vprZZn1C
         nm6MqHIyalByp/KuSOcHH4nPAdw2l3b13tMdWhLdbsNZfg7ms1Wl3ArmPz5baUq43ARi
         V4c990kOWIh9SL0yrCBDZ7oIc/+hdYouELCNB6m6IMhS2kuwbJLs9VZytg0tPw2o9EEM
         7w2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8lwwZWzMg5a3s7lwMASlg5tu9b+fzGmp/D7TMwKxKFc=;
        b=CzXvDRWW32GJWw8cz3qbDBxhjpKo7bX2H2grJtOC3bTUIHE8Cr8vSg/YI0xZ+a3l/J
         d7jSJGvDQJyMimmtXdf9R8iR7mCnuphvXyaQ6RsMcwxsMNE1Sn3FizUbMJjeIV+6PF/r
         iPZDovXkC1c2kTLPfzpvNXGVt2VMKf2Sk120Dm08AnAhlE0um/fjQ6tbWAKMPIQJ0miT
         jplOyjiNkzBgdVAC7ioC4b99hC0vsf3LZNd32iNysyTFx7i72KVUu3qsnyBOyg9Dq1Kq
         B4qwTPMzjPnLi+km6OliWNS6/unKmHxEGHee9p7hynRs0GWTx26fz0hRTpt63hfkdrSS
         alXA==
X-Gm-Message-State: AOAM530b2SIMW4FAuCvSVi3zD2XIa1FPXJJr+LQklUGMWkVRq3BAE0M7
        AobxkWNdzx59yASWeNNHZj/vbF/Wf2q4fo3ZL0iFdA==
X-Google-Smtp-Source: ABdhPJwD+M0MBopqkFuJGa9sgfSVBzZnNozNDZqwXOq1RFaO0zbunOMva9BpA++y2ooxKRxQrM2G01fpVQgDA3WnFR8=
X-Received: by 2002:a17:90b:1e49:: with SMTP id pi9mr38028565pjb.220.1639319032132;
 Sun, 12 Dec 2021 06:23:52 -0800 (PST)
MIME-Version: 1.0
References: <20211209063828.18944-1-hch@lst.de> <20211209063828.18944-3-hch@lst.de>
In-Reply-To: <20211209063828.18944-3-hch@lst.de>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Sun, 12 Dec 2021 06:23:41 -0800
Message-ID: <CAPcyv4gZvE69C8wCukFGgFLqzD49U8Wn8X4F9N6RmMFebgyqzg@mail.gmail.com>
Subject: Re: [PATCH 2/5] dax: simplify dax_synchronous and set_dax_synchronous
To:     Christoph Hellwig <hch@lst.de>
Cc:     Vishal Verma <vishal.l.verma@intel.com>,
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
        Matthew Wilcox <willy@infradead.org>,
        device-mapper development <dm-devel@redhat.com>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        linux-s390 <linux-s390@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        virtualization@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 8, 2021 at 10:38 PM Christoph Hellwig <hch@lst.de> wrote:
>
> Remove the pointless wrappers.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good, not sure why those ever existed.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>

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
> --
> 2.30.2
>
