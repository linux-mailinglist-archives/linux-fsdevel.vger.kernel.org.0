Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38CF127ED0D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Sep 2020 17:33:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728329AbgI3Pdn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Sep 2020 11:33:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725823AbgI3Pdm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Sep 2020 11:33:42 -0400
Received: from mail-ua1-x942.google.com (mail-ua1-x942.google.com [IPv6:2607:f8b0:4864:20::942])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCB07C061755
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Sep 2020 08:33:42 -0700 (PDT)
Received: by mail-ua1-x942.google.com with SMTP id z1so594790uaa.6
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Sep 2020 08:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/uO4l1Irl7Jc1Dt7f5WL2j3BxSE2iGdkPJ94cD3diLM=;
        b=LA4JYerDPZmq+2E8pGXpoAJ2R3R6DSDIFyoXhn37oGwuZ5e0jbNqwYQZruoOCXsvCI
         RShTjEmbsgKKLzzvoOOBIZaU/R7wbt7JatMDRzQvaaekkbfQcFSpULtcQ4A/cKq/vxaG
         FXErj58Js4dFB08C6gceZtiUM7h0QE6nd6OdA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/uO4l1Irl7Jc1Dt7f5WL2j3BxSE2iGdkPJ94cD3diLM=;
        b=c3cfzBHzVXnngE5VWF3F1+/a0MEklLxmZX1L9kM99BwT/DjJcsg2Wim7EevGpI7sOm
         2ZxKZI31VoJR+FzwrUbX/Hk0SWylUEGkU+jYHQD9MxGmrULP3XIlVl5yBwBOZ1wNBAM8
         K3phi+F5VhpLLLW3FsyiE/X7mnIgZyv/Pcbycb3YkeKZMEWEU6vSbkQo/e1ALyeEYN+d
         5zJmX7pM/n8VA3+vAYEhHg753DZxK/9i6PJ3fADgTaDfuIkDNzI4+heJBFJ6/P+I32OP
         0nv3bPrAFYeqg6o2gCUgjCAB0+AykrAghmE48N+32Gjvf7jqOw/c06rsgoBBG43aRNDz
         Ie2w==
X-Gm-Message-State: AOAM530Zcg3rnnZ26AKhJZn+JOm7JMhQpxlXPE67r/eNUlmNiUkpZU3q
        rY2tEkAq8oU2XWi+trCZH0tO/TlzvzmYdjIz/q1H6Q==
X-Google-Smtp-Source: ABdhPJzyumaQn67a2uysWGSs3pQrDLQnwa3K/NizNBUQXsUBZVlCHdIlWthWT9umZ5q8w7kmZMHdnhq8Zg0vNAnpYNM=
X-Received: by 2002:ab0:6298:: with SMTP id z24mr2147413uao.105.1601480021939;
 Wed, 30 Sep 2020 08:33:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200924131318.2654747-1-balsini@android.com>
In-Reply-To: <20200924131318.2654747-1-balsini@android.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 30 Sep 2020 17:33:30 +0200
Message-ID: <CAJfpeguFZwkZh0wkPjOLpXODdp_9jELKUrwBgEhDVF4+T8FgTw@mail.gmail.com>
Subject: Re: [PATCH V9 0/4] fuse: Add support for passthrough read/write
To:     Alessio Balsini <balsini@android.com>
Cc:     Akilesh Kailash <akailash@google.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Antonio SJ Musumeci <trapexit@spawn.link>,
        David Anderson <dvander@google.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Jann Horn <jannh@google.com>, Jens Axboe <axboe@kernel.dk>,
        Martijn Coenen <maco@android.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Lawrence <paullawrence@google.com>,
        Stefano Duo <stefanoduo@google.com>,
        Zimuzo Ezeozue <zezeozue@google.com>,
        fuse-devel <fuse-devel@lists.sourceforge.net>,
        kernel-team <kernel-team@android.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 24, 2020 at 3:13 PM Alessio Balsini <balsini@android.com> wrote:

> The first benchmarks were done by running FIO (fio-3.21) with:
> - bs=4Ki;
> - file size: 50Gi;
> - ioengine: sync;
> - fsync_on_close: true.
> The target file has been chosen large enough to avoid it to be entirely
> loaded into the page cache.
> Results are presented in the following table:
>
> +-----------+--------+-------------+--------+
> | Bandwidth |  FUSE  |     FUSE    |  Bind  |
> |  (KiB/s)  |        | passthrough |  mount |
> +-----------+--------+-------------+--------+
> | read      | 468897 |      502085 | 516830 |
> +-----------+--------+-------------+--------+
> | randread  |  15773 |       26632 |  21386 |


Have you looked into why passthrough is faster than native?

Thanks,
Miklos
