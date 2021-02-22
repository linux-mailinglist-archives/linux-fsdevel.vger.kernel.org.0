Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84067321BFF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Feb 2021 17:00:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230223AbhBVP6x (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Feb 2021 10:58:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbhBVP6r (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Feb 2021 10:58:47 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89930C061574;
        Mon, 22 Feb 2021 07:58:04 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id h25so9003508eds.4;
        Mon, 22 Feb 2021 07:58:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eqt4tyVUm6sFFSl2X77cgXFxmGm9zkPl59fYAb4UtLM=;
        b=CRGzM9snCLPk0WcXCIhX/L5eaQ49/xpzBacwDJLahWleNBDO+XJsBkpdLGp9kguzNz
         Scu4+dMvFBSh6DuJgtkw6J8FBzj5SZ5UExMOQD++T2jBuwCNKJdRcVHgrLfx3m2WDTsv
         WFKIJk+7uIq5nf7FW9GOotYbtPcypKJ3yZuZnj6VqyBa0tQcsY6sXD8Go6SX3nxK676O
         rn1Qxl7xUt29Ssr577+0saPIioLrKs8jSpb2ornKbVURE2X3vMaMfHDPxKAyNZxfJMVQ
         nLaSu0D9wtfIW4jgsqT+m7YmXQxYTBn63lFDgkuoKeYUtiLJTgdckMD1kekyxN2AV2Vk
         UHpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eqt4tyVUm6sFFSl2X77cgXFxmGm9zkPl59fYAb4UtLM=;
        b=OXx5N3GST+NT75YHtBVuxLhuQNi7658OOLB5Gn2nWDmfeMy0d/bZrt03QtQ+gPRrmj
         cNbaF8XDvrZbmLeSC39QhEfCIeaF42853Va6bEYobsw+MsXcDfIDrRBPr8FL5WbjNj37
         xtNA7lRcNQdOAw0HRIFMhu39A9gCwwdz/40ry/h5aCULVKq4wRRocdjSK7krH/uPsuGf
         SvKrPHQZ7j1vEZ/BWqvnf7raGvNHt00gG9yazF4f2sr8pqywdSaqYdm4ml5pRRvwlGpW
         MtMQtA0WdNteAu4J/a8IIje17Ky96GMrBb34DauB2e4yfb5GCuwwzBr2WVPnOd5uagO5
         3pGQ==
X-Gm-Message-State: AOAM533DofuHolWvYo/+svQYGvH1ZNrJNkERlmwPs1x8u4BB9qrcFTTI
        LzygatMp/oJaFsuAzDnqNkHfFY/0iQawyIUwviA=
X-Google-Smtp-Source: ABdhPJwZCZVZf9WeJRPU+J8UGCkToLST5tkhlxw8G27fU8a5k7VbjCKgwE2fc0X960Ko9awC2JIhDm7WjyG+QPkPyN4=
X-Received: by 2002:a50:cf02:: with SMTP id c2mr23026578edk.333.1614009483256;
 Mon, 22 Feb 2021 07:58:03 -0800 (PST)
MIME-Version: 1.0
References: <20210219124517.79359-1-selvakuma.s1@samsung.com>
 <CGME20210219124608epcas5p2a673f9e00c3e7b5352f115497b0e2d98@epcas5p2.samsung.com>
 <20210219124517.79359-4-selvakuma.s1@samsung.com> <20210220033637.GA2858050@casper.infradead.org>
In-Reply-To: <20210220033637.GA2858050@casper.infradead.org>
From:   Selva Jove <selvajove@gmail.com>
Date:   Mon, 22 Feb 2021 21:27:50 +0530
Message-ID: <CAHqX9vYdz-SRP2y6gzR1ei5WukNGzWhrHrvtXo4L8iFw4Lb9Hg@mail.gmail.com>
Subject: Re: [RFC PATCH v5 3/4] nvme: add simple copy support
To:     Matthew Wilcox <willy@infradead.org>
Cc:     SelvaKumar S <selvakuma.s1@samsung.com>,
        linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
        axboe@kernel.dk, Damien Le Moal <damien.lemoal@wdc.com>,
        hch@lst.de, sagi@grimberg.me, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, dm-devel@redhat.com,
        snitzer@redhat.com, joshiiitr@gmail.com, nj.shetty@samsung.com,
        joshi.k@samsung.com, javier.gonz@samsung.com, kch@kernel.org,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Matthew,

Maximum Source Range Count (MSRC) is limited by u8. So the maximum
number of source ranges is 256 (0 base value). The number of pages
required to be sent to the device is at most 2. Since we are
allocating the memory using kmalloc_array(), we would get a continuous
physical segment. nvme_map_data() maps the physical segment either by
setting 2 PRP pointers or by SGL. So the copy command sends two pages
to the device for copying more than128 ranges.

On Sat, Feb 20, 2021 at 9:08 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Fri, Feb 19, 2021 at 06:15:16PM +0530, SelvaKumar S wrote:
> > +     struct nvme_copy_range *range = NULL;
> [...]
> > +     range = kmalloc_array(nr_range, sizeof(*range),
> > +                     GFP_ATOMIC | __GFP_NOWARN);
> [...]
> > +     req->special_vec.bv_page = virt_to_page(range);
> > +     req->special_vec.bv_offset = offset_in_page(range);
> > +     req->special_vec.bv_len = sizeof(*range) * nr_range;
> [...]
> > +struct nvme_copy_range {
> > +     __le64                  rsvd0;
> > +     __le64                  slba;
> > +     __le16                  nlb;
> > +     __le16                  rsvd18;
> > +     __le32                  rsvd20;
> > +     __le32                  eilbrt;
> > +     __le16                  elbat;
> > +     __le16                  elbatm;
> > +};
>
> so ... at 32 bytes, you can get 128 per 4kB page.  What happens if you
> try to send down a command that attempts to copy 129 ranges?
