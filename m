Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51A1849AB65
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jan 2022 06:15:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244828AbiAYEuf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jan 2022 23:50:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S3412751AbiAYEmD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jan 2022 23:42:03 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3CC0C061756;
        Mon, 24 Jan 2022 19:21:56 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id p125so17203776pga.2;
        Mon, 24 Jan 2022 19:21:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dRYUZ3M7rYppnI+hr0K9I96s0E7Snr+RM+8KvNOCFtU=;
        b=VD8oeGdqW09JSIqWe22HlKYenwRDp2U8WB+CnjY9QLzalkATlxubrBmgjYYpfW6yCY
         1n07L6NKNOdq6J5J+VoxM0dHKSLcYBwSHN1OUYe2tsN889Jw9me66zKLHFVus7BiiWUw
         RLkkqAtHIvkBY32Zec94woTaIa0mYUIvOEzYAQzbiU2k4Q4nJwMcuLPd3DDGGEMxpdRR
         dIeGhMe0j2TWZUIW20y/3h0vUAStXPE1oj0nGC5Klr7KclyeFrKIZKGaoLDP+jx4ZAuQ
         IF9XsGGcHnzSbDikDNG3Lq27ObcBgORcGhKZfLNzpKtXqKo6rbyACvIgwmpFVyAmvJrA
         N+4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dRYUZ3M7rYppnI+hr0K9I96s0E7Snr+RM+8KvNOCFtU=;
        b=7TtkTlHWL/GsEi1zsoQyXJikadWnbkvlZb9A4CSyc2CilJ+X34/rEjZ02W/Ec79o1V
         TkHGX9w9WmTRoASan8r9h6D19IMvYlZ1GVTW2wht56uvySeh7Z3Gp6ZEDpr0AZhdTZs/
         Rxpy7bSOW3y4WQW8jXUMUuHqPJHtlTNnvgqjdUqPTS2+Nm4iwBzCuKwNH3BM/8XIyzJc
         +YeccKAooOtLpDYQC8c/DxOT63lajz7zsgRRvkp+AVYuegg2OLFFvA5PHHI9817QBlti
         5NI8tIgs4xu7OGGFhq90ZcqjAc1Ajza+x96/OK1jTFWejNyhpSHB1eug5YVFkO85ojbV
         DxaQ==
X-Gm-Message-State: AOAM5304+GLtwtkmSaNWCHTuRKtB9mTrarJsLmEnkrA+0zg0VLnpsz8u
        XYeVADl1v+O2UjX6+BUCTQffnIZKqPLmBIVZ0cQdfBfGkEE=
X-Google-Smtp-Source: ABdhPJywmScDK7JzNLK/WwmQPFrg9zEjpJrbDmlinzZCQUfw9Uu/CfMyBOT1zd0fMVAprCPY+u6ivYkhqGRTbivhBTk=
X-Received: by 2002:aa7:88d4:0:b0:4ca:a670:d05f with SMTP id
 k20-20020aa788d4000000b004caa670d05fmr2460464pff.38.1643080915561; Mon, 24
 Jan 2022 19:21:55 -0800 (PST)
MIME-Version: 1.0
References: <20220104171058.22580-1-avagin@gmail.com>
In-Reply-To: <20220104171058.22580-1-avagin@gmail.com>
From:   Andrei Vagin <avagin@gmail.com>
Date:   Mon, 24 Jan 2022 19:21:44 -0800
Message-ID: <CANaxB-x83ZUSw493feutgF4_sBD7Uj_p0VwNxpmaq1u7eMsq-w@mail.gmail.com>
Subject: Re: [PATCH] fs/pipe: use kvcalloc to allocate a pipe_buffer array
To:     LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian.brauner@ubuntu.com>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 4, 2022 at 9:11 AM Andrei Vagin <avagin@gmail.com> wrote:
>
> Right now, kcalloc is used to allocate a pipe_buffer array.  The size of
> the pipe_buffer struct is 40 bytes. kcalloc allows allocating reliably
> chunks with sizes less or equal to PAGE_ALLOC_COSTLY_ORDER (3). It means
> that the maximum pipe size is 3.2MB in this case.
>
> In CRIU, we use pipes to dump processes memory. CRIU freezes a target
> process, injects a parasite code into it and then this code splices
> memory into pipes. If a maximum pipe size is small, we need to
> do many iterations or create many pipes.
>
> kvcalloc attempt to allocate physically contiguous memory, but upon
> failure, fall back to non-contiguous (vmalloc) allocation and so it
> isn't limited by PAGE_ALLOC_COSTLY_ORDER.
>
> The maximum pipe size for non-root users is limited by
> the /proc/sys/fs/pipe-max-size sysctl that is 1MB by default, so only
> the root user will be able to trigger vmalloc allocations.
>
> Cc: Dmitry Safonov <0x7f454c46@gmail.com>
> Signed-off-by: Andrei Vagin <avagin@gmail.com>

Alexander and Andrew,

Do you have any objections? Could you merge this patch?

Dmitry's comments have been addressed in the separate patch:
https://lkml.org/lkml/2022/1/6/463

BTW: I found that fuse already uses kvmalloc to allocate pipe buffers
(e. g. fuse_dev_splice_read).

Thanks,
Andrei
