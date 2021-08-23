Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CF5C3F52A8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Aug 2021 23:16:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232787AbhHWVQl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Aug 2021 17:16:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232710AbhHWVQl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Aug 2021 17:16:41 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70917C061757
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Aug 2021 14:15:58 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id 28-20020a17090a031cb0290178dcd8a4d1so705079pje.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Aug 2021 14:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0HdgMfJjfBUm06w/tbdcTogg+ww6k//RogO3PbAJzw0=;
        b=QxjpQlOpuTkQV12epR2VAzo/40qiPmok1VA6W1DpNVqrUjJZzo6eDTeOAHSllTPRk5
         PCHJj4sa6Cc+zFYb+qagXaPuZIVnelMvGgQSrmER0WaH8FCD6WbClmdwL/5ivRwnh7Tr
         OlxIZtj6qvJP26iCb46k2X+oYiRGJnM7szuyUAAjyWh/ew+lAPB9DLrS/JNm80ahAaQ3
         OCezKZoWmAZh/d3UXDKW6re2ffhwpL/CbGe+scowDWt4jGvMyKioieZ/cTqBW3/sPEsw
         yQi9J5uIeeS+cZ9Q278rjGN4pnDH5ekMzhp0L914a+t9gnxjIOixK5iNFQn+7bU0o7zt
         ESCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0HdgMfJjfBUm06w/tbdcTogg+ww6k//RogO3PbAJzw0=;
        b=tcoLpMfmMS9amo6rDRqlBP4IYllmi3s/jnmKDLCjDMyifChjCW2L51PCkCaZ+lAx0j
         nevtCgkgSbEJlX4qHkU4thAfPEYYriTcs++IYPSskuRMeJG5ehHsUFCaLdulEo9xVa+L
         s5ipbJqZJVZIxHxnbKzTBxjiM8Sza1zTa9fRx2xiZk14YOe2t3M/eU6ADMf92+KE7Csa
         t+tDcA/URhhNvH1J+Rl1L2N5IT/vQ12orOsHzULtZN40tkNnscb+ujyadyufZHhc3Rcn
         8Jx6OewY8AEdxWmj3VBlDNsSHH1GqwLRnnbSmgRNiae8wHRLHwQFHS+Td1Y0S7Z/BRJR
         PPHA==
X-Gm-Message-State: AOAM5308y1AAGI/78pFyDx8ZFf35o65S9ODD7kC+IC4mwLnGqUj8xmtz
        eHeA0dg6aMPNnjGyhJhzs1q0qmtRuFjrkV7n1NCondeF7yVyNg==
X-Google-Smtp-Source: ABdhPJwH2kZSUy5ZuN/S6Vj/YVaQMRJ9BeKt4NxFFtK5ME19C8ip4tZgOdf3QfLPpgM4bV40q4bP/8FpdYJXB3P7rOI=
X-Received: by 2002:a17:90b:23d6:: with SMTP id md22mr517969pjb.149.1629753357862;
 Mon, 23 Aug 2021 14:15:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210823123516.969486-1-hch@lst.de> <20210823123516.969486-8-hch@lst.de>
In-Reply-To: <20210823123516.969486-8-hch@lst.de>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 23 Aug 2021 14:15:47 -0700
Message-ID: <CAPcyv4hezYrurYEsBZ-7obnNYr0qbdtw+k0NBviOqqgT70ZL+w@mail.gmail.com>
Subject: Re: [PATCH 7/9] dax: stub out dax_supported for !CONFIG_FS_DAX
To:     Christoph Hellwig <hch@lst.de>
Cc:     Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-ext4 <linux-ext4@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 23, 2021 at 5:43 AM Christoph Hellwig <hch@lst.de> wrote:
>
> dax_supported calls into ->dax_supported which checks for fsdax support.
> Don't bother building it for !CONFIG_FS_DAX as it will always return
> false.
>

Looks good, modulo formatting question below:

Reviewed-by: Dan Williams <dan.j.williams@intel.com>

> diff --git a/include/linux/dax.h b/include/linux/dax.h
> index 0a3ef9701e03..32dce5763f2c 100644
> --- a/include/linux/dax.h
> +++ b/include/linux/dax.h
[..]
> @@ -149,6 +144,13 @@ static inline bool bdev_dax_supported(struct block_device *bdev,
>
>  #define generic_fsdax_supported                NULL
>
> +static inline bool dax_supported(struct dax_device *dax_dev,
> +               struct block_device *bdev, int blocksize, sector_t start,
> +               sector_t len)
> +{
> +       return false;
> +}

I've started clang-formatting new dax and nvdimm code:

static inline bool dax_supported(struct dax_device *dax_dev,
                                 struct block_device *bdev, int blocksize,
                                 sector_t start, sector_t len)
{
        return false;
}

...but I also don't mind staying consistent with the surrounding code for now.
