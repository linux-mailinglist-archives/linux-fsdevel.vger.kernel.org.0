Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BBA43E8356
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Aug 2021 20:57:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231789AbhHJS5W (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Aug 2021 14:57:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230351AbhHJS5V (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Aug 2021 14:57:21 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9E58C0613D3
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Aug 2021 11:56:58 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id w20so16939439lfu.7
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Aug 2021 11:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5J8TNSHzverklWCIf6vRYydGxpzdFZnm4R0kskdp9cc=;
        b=ndautaOoQT38CMmBdyfavMBZQUrg4llGLquOvj3ILSUjkPPYbfklhyWsnujm3oeuRe
         f9IzYajcg7Y1Unc2VFiYw+v2O5d059adb6UQ/chnQ50HQlwUPNHmkI+V0r/qWJHWxGcx
         +UiNPb6e4jgWnwA76Jp6kE9fW+owItNRsZYgVncNN92BQr2PYDi4DC5QS7OGRpllpqHQ
         KHx3FECO1R+SyjtFH55pJDHgT5TJn9pXovWEeCRFpibD7ewlW+WOhZvBuDJYClcZx4aV
         5bj/H88uu3p8vzO/Vm113dRyqgx9Pk9/HjmWi7pRjwRPw4IQWN3uQW36y3z6bgaQ6SOB
         eKLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5J8TNSHzverklWCIf6vRYydGxpzdFZnm4R0kskdp9cc=;
        b=tnzVGyrlHjZSX4+x7kYZLw3/2nERkhMtxIW+1WhsazeKWyqFGjjZMuNHUGU+hmK4FK
         1aAH9HuVg8PR4HSfxa/KzKjdrXbnmmmEOuGavjxKbns4Ohh3MSofMrp3aUtY1vUld+zf
         q+nm711sEj2vKt1YCIYQ+4ytBTVSprZrVA9A/MLfpdJ7SGjAQaJY8x6CE/nq40XHDRE5
         UQjc1GkEcEwiFGeU8hlwcJzG5imvT550oOhIe1NqBwtFtNY2lrTa2qwsWULOImTsiMc/
         kcw76+EIMDip3GE5fvb6T/0FqB0zdzujvY+JZTYsEGh4UAhGK79BVuRj1p++FW4IYgFN
         GkZQ==
X-Gm-Message-State: AOAM533RGM93bB3BOIqEVetoGesFMOCAMyTeFckL27sQdM2TwUtoHZBP
        btwT54O7/Kdee1CKsSnjn6BVqa4uDo2Dd7dNyBTkV1bU+1M=
X-Google-Smtp-Source: ABdhPJwiqBhRvlH8/uuFuNBs8e9nbzelvuQvFY1dIv6HDEfvgTFOIGeW4ZQ6fABsspcNorfg54oPNZND463/mV7PV+U=
X-Received: by 2002:ac2:531c:: with SMTP id c28mr24026257lfh.74.1628621817084;
 Tue, 10 Aug 2021 11:56:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210810020441.62806-1-qiuxi1@huawei.com>
In-Reply-To: <20210810020441.62806-1-qiuxi1@huawei.com>
From:   Jann Horn <jannh@google.com>
Date:   Tue, 10 Aug 2021 20:56:30 +0200
Message-ID: <CAG48ez0NQd1h8PvJbHmXsPu+K1s-fw97RXZiU4hRJ8U0MT7qaA@mail.gmail.com>
Subject: Re: [PATCH 1/1] coredump: fix memleak in dump_vma_snapshot()
To:     QiuXi <qiuxi1@huawei.com>
Cc:     viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, xiekunxun@huawei.com,
        young.liuyang@huawei.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 10, 2021 at 4:04 AM QiuXi <qiuxi1@huawei.com> wrote:
> dump_vma_snapshot() allocs memory for *vma_meta, when dump_vma_snapshot()
> returns -EFAULT, the memory will be leaked, so we free it correctly.

The change itself looks reasonable to me.

> Fixes: a07279c9a8cd7 ("binfmt_elf, binfmt_elf_fdpic: use a VMA list snapshot")
> Cc: stable@vger.kernel.org # v5.10

But I think this shouldn't be "Cc: stable". The patch only removes a
memory leak in a WARN_ON() path, and that WARN_ON() path can only be
taken if there is a kernel bug; if we reach this branch, there's a
good chance that kernel memory corruption has already occurred.


> Signed-off-by: QiuXi <qiuxi1@huawei.com>
> ---
>  fs/coredump.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/fs/coredump.c b/fs/coredump.c
> index 07afb5ddb1c4..19fe5312c10f 100644
> --- a/fs/coredump.c
> +++ b/fs/coredump.c
> @@ -1127,8 +1127,10 @@ int dump_vma_snapshot(struct coredump_params *cprm, int *vma_count,
>
>         mmap_write_unlock(mm);
>
> -       if (WARN_ON(i != *vma_count))
> +       if (WARN_ON(i != *vma_count)) {
> +               kvfree(*vma_meta);
>                 return -EFAULT;
> +       }
>
>         *vma_data_size_ptr = vma_data_size;
>         return 0;
> --
> 2.12.3
>
