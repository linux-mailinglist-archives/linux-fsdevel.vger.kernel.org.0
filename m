Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 350403A8DD4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jun 2021 02:49:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231741AbhFPAvG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Jun 2021 20:51:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231307AbhFPAvF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Jun 2021 20:51:05 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91E86C061760
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Jun 2021 17:49:00 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id i11-20020a17090a2acbb029016f0cce7c3fso507850pjg.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Jun 2021 17:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N705IiD7n6FnNdMOVPwQtLkiV4KgkJ6X1/De6zQZWwI=;
        b=Vdg0YlGJ8YdIQxJsskt857Kp1UiDME+54VPtdHVPVXgoShl4VVVAaR6LXE0dbZKVV2
         +W+U4JeT3w/znleh/vZYdYXLbeE/pb0HV5ZEWUPDcvLxO26mt2qXZgivFzn3uSvahElD
         IwGdaPoF4IcRH7qJIdQjXQmZCbal2lLL+QkYNIl2RRjAfHR9PYesk+uc+Sgyx5CZHFfl
         e2DUPodC5WlhmtLJUFdwdvpJ9eljMdTNGqS+3FoZy7nhDaFOgT1hWfV8NXRx6YQNwhKl
         h2XdYcERWOQAJ9xAgYdgl/J4fe3qT8u41yhXFC39k2ZstvQJHVRG9+iqruFGveOSagxS
         R4dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N705IiD7n6FnNdMOVPwQtLkiV4KgkJ6X1/De6zQZWwI=;
        b=iHy2sLU5Gj41azthNJAHqtnhS0ccPuXF9yLnbwb4maPH4Vj9vw6iZii72eqnMRHsWc
         NyhM5UjXreVDfc+FC6rvfFpLvukVpX6GdCAOBESJDPSOItua5aJ6J4vd472J/2aFkRLQ
         4WR4Sxb2FkX6MMXZ1BLsI24XVzmCwyTOV/cbKg+LXHej5fQNiPxws7cy/kXbksALSlPN
         ScBIHxzFqbIoBk1kwd2cn2x6owz1gaKo8SLEQPwPlkvev14L0qgkZ1BUr1uP3Lt4gHO9
         dtXHr3WJzrLpVAIYFLCxvEax1jKYg+TMffUseB1qx9uy4sRBQiTPE1Z6Dc9TOd27MZgy
         4Vkg==
X-Gm-Message-State: AOAM530iq0zlOrTkj1cywnXW29JFJ/RnlbSI4V6UqRuqWcE6ob/UEi6Q
        Hk61zAz6tW4hBBEUKmgSWSisDT9ind8if7u4KkKuAg==
X-Google-Smtp-Source: ABdhPJyPFTJSM7pJ7JUKFEZ8HQ+iir1f0oux2sr4aUWcOno+cjQdFNUvLXFLljz8kRS7NiWvMxxI/6TF54PHQ215JUQ=
X-Received: by 2002:a17:90a:8589:: with SMTP id m9mr7683966pjn.168.1623804539893;
 Tue, 15 Jun 2021 17:48:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210604011844.1756145-1-ruansy.fnst@fujitsu.com> <20210604011844.1756145-4-ruansy.fnst@fujitsu.com>
In-Reply-To: <20210604011844.1756145-4-ruansy.fnst@fujitsu.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 15 Jun 2021 17:48:49 -0700
Message-ID: <CAPcyv4h=bUCgFudKTrW09dzi8MWxg7cBC9m68zX1=HY24ftR-A@mail.gmail.com>
Subject: Re: [PATCH v4 03/10] fs: Introduce ->corrupted_range() for superblock
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        device-mapper development <dm-devel@redhat.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        david <david@fromorbit.com>, Christoph Hellwig <hch@lst.de>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Goldwyn Rodrigues <rgoldwyn@suse.de>,
        Linux NVDIMM <nvdimm@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

[ drop old linux-nvdimm@lists.01.org, add nvdimm@lists.linux.dev ]

On Thu, Jun 3, 2021 at 6:19 PM Shiyang Ruan <ruansy.fnst@fujitsu.com> wrote:
>
> Memory failure occurs in fsdax mode will finally be handled in
> filesystem.  We introduce this interface to find out files or metadata
> affected by the corrupted range, and try to recover the corrupted data
> if possiable.
>
> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
> ---
>  include/linux/fs.h | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index c3c88fdb9b2a..92af36c4225f 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -2176,6 +2176,8 @@ struct super_operations {
>                                   struct shrink_control *);
>         long (*free_cached_objects)(struct super_block *,
>                                     struct shrink_control *);
> +       int (*corrupted_range)(struct super_block *sb, struct block_device *bdev,
> +                              loff_t offset, size_t len, void *data);

Why does the superblock need a new operation? Wouldn't whatever
function is specified here just be specified to the dax_dev as the
->notify_failure() holder callback?
