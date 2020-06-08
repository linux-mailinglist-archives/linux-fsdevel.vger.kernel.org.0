Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 483391F1316
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jun 2020 08:53:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728956AbgFHGxJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Jun 2020 02:53:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726929AbgFHGxI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Jun 2020 02:53:08 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68147C08C5C3;
        Sun,  7 Jun 2020 23:53:08 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id r2so17421086ioo.4;
        Sun, 07 Jun 2020 23:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=J7n7SjeAB90BEcrzPElTv6I73DAXjp+Cu0iwgMAiPUc=;
        b=np4HWYG8n3V0PTL0Ue1cxqRR3IU/8t/jEP3KTZ9OxJg0/MiBSoDZC8rmoZFHz/flGZ
         cfbzuwOM/CTEcgA9FZF08IhGGt+eQ88VNSDuq0r8SoyxBUsMbGoMQAUEDcIxiS27UatR
         UpFJvBOSIJ7ETgF+hhL3xAUPHhvK0sjQ5u5c6f7qAYtkofz87Kath5leAmzbYNKwPSyW
         coP1fENs/B5gcTDA6GF2DScAlj5gZGO+Ygv6Co05Rc35D/OrFaiYzbQES7rpp2cSNPxb
         d6wSF2VUDGHvXGH3wQejv7aEBjR8HWjCf91W2Bo/FRu494LsJYbha1z1199JmHoV23z8
         IbaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=J7n7SjeAB90BEcrzPElTv6I73DAXjp+Cu0iwgMAiPUc=;
        b=ktV6KmnhtHUFjRvASAxn1XiAFsFqYAD23q44vcGQOAvHSPndfJi8d97vxQFj/Pd5dd
         8W8Ci7V2HhVi2zHfNY3ZZ16qZ9YYAHL5pyy0UmpBUqliY/DhcGEg4WAJwubzYgDAI44D
         nWE8qvNmZcsZz32Zf7g4k83BCDjCMi40ZIcsWVU/VkVCt+5ozWanq4d89vJX8SrojT+1
         AuO6zB8bl1ASbn/MvtYudjl9DzbsUzkCpxQcl6UrQ03CCksOiTGSgfqeJv6vXUE1yEA6
         ARpZaoHz+za3gfl+z2DyVv5tm9OnI2zyzzaRw9aYtRryfcz1r4298AljXHsxiZGBer02
         uWlA==
X-Gm-Message-State: AOAM532q81nfbCYQwEvCQNcA8VCPUGXg+8p1QZVNmjdaA5BqF/sUZjs/
        htfQPxYw8kyOJ4M5f14B397Ln/UIFUznHE/0jI4=
X-Google-Smtp-Source: ABdhPJwq/zLR1ycs1e5A5/QIjkyALxZ9JXyMe/FGPYXRbctdQgtgnz5ByB0ebLrnhatIKDuy5ODhKnnAJfJKQ97P4QE=
X-Received: by 2002:a05:6638:406:: with SMTP id q6mr20880697jap.125.1591599187633;
 Sun, 07 Jun 2020 23:53:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200608020557.31668-1-yanaijie@huawei.com> <20200608061502.GB17366@lst.de>
 <CA+icZUUks4oJGJLhiRLTJTzyNxfsT_TZQ12MMvBVLXSaR8t0zA@mail.gmail.com>
In-Reply-To: <CA+icZUUks4oJGJLhiRLTJTzyNxfsT_TZQ12MMvBVLXSaR8t0zA@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Mon, 8 Jun 2020 08:52:56 +0200
Message-ID: <CA+icZUXg2H7a4BVLpPXiw2D5Xzpy=Nxj8OJyw96giDvjNuBt+w@mail.gmail.com>
Subject: Re: [PATCH v4] block: Fix use-after-free in blkdev_get()
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jason Yan <yanaijie@huawei.com>, viro@zeniv.linux.org.uk,
        axboe@kernel.dk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Ming Lei <ming.lei@redhat.com>, Jan Kara <jack@suse.cz>,
        Hulk Robot <hulkci@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 8, 2020 at 8:47 AM Sedat Dilek <sedat.dilek@gmail.com> wrote:
>
> On Mon, Jun 8, 2020 at 8:18 AM Christoph Hellwig <hch@lst.de> wrote:
> >
> > Looks good,
> >
> > Reviewed-by: Christoph Hellwig <hch@lst.de>
> >
> > Can you dig into the history for a proper fixes tag?
>
> [ CC Dan ]
>
> Dan gave the hint for the Fixes: tag in reply to the first patch:
>
> > The Fixes tag is a good idea though:
> >
> > Fixes: 89e524c04fa9 ("loop: Fix mount(2) failure due to race with LOOP_SET_FD")
>
> > It broke last July.  Before that, we used to check if __blkdev_get()
> > failed before dereferencing "bdev".
>

Here is the Link.

https://www.spinics.net/lists/linux-block/msg54825.html

- Sedat -
