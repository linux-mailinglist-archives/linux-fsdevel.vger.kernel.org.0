Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDE46382D4C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 May 2021 15:21:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236054AbhEQNW5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 May 2021 09:22:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234106AbhEQNW5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 May 2021 09:22:57 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C9F2C061573;
        Mon, 17 May 2021 06:21:40 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id c16so6084384ilo.1;
        Mon, 17 May 2021 06:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MQyS3XJe4AKUr1SWVpgv2bs2/GuaT0/cfk3NUPLHQ08=;
        b=dGZa+sD+S3wBlqHS13HTMc3qEXBZLPBYHl6BzQZzo9YDo6xgCbxZyRBv5dPWN+Aj9L
         5m+gBW3elWiEH7YYw1YDfUkyxWfDPPqQxiRJnWie+1BAuI1K3qhY/OU/OybuLQZ9AzOs
         Qi3ZJhM78kbmVyR4L2tHQbyGIJUatgoOlyntKgySbRe3pzGu14J5lHdEwgpUM2v6/Arr
         3kmGliEVdHpb3sAahauZ8+h5/NtAfir4P/d+gCKT40KgKS/F/UScpMo8v+UTqDep7Fgk
         0D8hQ64XCZn+yrNKgGyeHA0kCSyXgB798DA42Fbg6wRF4mYNdg67YqYBMM/a7gXm1axW
         26FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MQyS3XJe4AKUr1SWVpgv2bs2/GuaT0/cfk3NUPLHQ08=;
        b=ilP/gMZ7ezYjnyFZKAkBbsOKVqAQ13gSrgrznCozOS/+14594nWQYF3IOXpu4FNz4F
         qxdplFxGmsx4j+x1MUeEURBRrZb+1plASByeGIbUxoG/pZ0/BGhC9yphnWVwJa+H5PCE
         56WyfB3XQPFzmKa1LIcJNDK0e6eoZ9W/73ghl288oMBRFevTu22WUSkfbjCt6ePyPvlK
         hgRfIBdnODHOT2JC+/BocY+jsLdSnzT63KGNtm2F82XeaebJuhzm73h6Tom1CpxqKjzu
         jYJo7uGs/1lN9hFhhV6bVZeb1FYRCF/6lp86kVViRb/ZhxhMC9DRobA7CS+lpLjNAoOr
         ymlg==
X-Gm-Message-State: AOAM5313RchiT8AK9e1NtE9nVVRE8N8JvLwlkXoGQgrZOI6ddny20QIi
        4DZe+a36V54Y1qSVRI2bjpZO8tHYClFQNP8hjVC5290V3bo=
X-Google-Smtp-Source: ABdhPJxhBSD4WvdOfYB6sx8VDZJJLMKintD92fmsIcCWYpAzSoK9/buptc6zD372ZfU6UGj0nRTAspMZ3WR9b+W/rtc=
X-Received: by 2002:a92:cc43:: with SMTP id t3mr4301180ilq.250.1621257699449;
 Mon, 17 May 2021 06:21:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210125153057.3623715-1-balsini@android.com> <20210125153057.3623715-5-balsini@android.com>
 <CAJfpegvL2kOCkbP9bBL8YD-YMFKiSazD3_wet2-+emFafA6y5A@mail.gmail.com>
 <CAOQ4uxjOGx8gZ2biTEb4a54gw5c_aDn+FFkUvRpY+cmgEEh=sA@mail.gmail.com> <YKJVUUUapNSijV38@google.com>
In-Reply-To: <YKJVUUUapNSijV38@google.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 17 May 2021 16:21:28 +0300
Message-ID: <CAOQ4uxjpHTerNq70gp+GQP26RijzWOJR1pB+9GxVBSdJyjN1mQ@mail.gmail.com>
Subject: Re: [PATCH RESEND V12 4/8] fuse: Passthrough initialization and release
To:     Alessio Balsini <balsini@android.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Akilesh Kailash <akailash@google.com>,
        Antonio SJ Musumeci <trapexit@spawn.link>,
        David Anderson <dvander@google.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Jann Horn <jannh@google.com>, Jens Axboe <axboe@kernel.dk>,
        Martijn Coenen <maco@android.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Lawrence <paullawrence@google.com>,
        Peng Tao <bergwolf@gmail.com>,
        Stefano Duo <duostefano93@gmail.com>,
        Zimuzo Ezeozue <zezeozue@google.com>, wuyan <wu-yan@tcl.com>,
        fuse-devel <fuse-devel@lists.sourceforge.net>,
        kernel-team <kernel-team@android.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> I have an ugly patch which uses IDR as Miklos asked, but unfortunately
> I'm facing some performance issues due to the locking mechanisms to keep
> guarantee the RCU consistency. I can post the new patch set as an RFC
> soon for the community to take a look.
> At a glance what happens is:
> - the IDR, one for each fuse_conn, contains pointers to "struct
>   fuse_passthrough" containing:
>   - fuse_file *: which is using passthrough,
>   - file *: native file system file target,
>   - cred of the FUSE server,
> - ioctl(PASSTHROUGH_OPEN): updates IDR, requires spinlock:
>   - kmalloc(fuse_passthrough), update file and cred,
>   - ID = idr_alloc(),
>   - return ID,
> - fuse_open reply from FUSE server with passthrough ID: updates IDR,
>   requires spinlock:
>   - pt = idr_find(ID),
>   - update fuse_file with the current fuse_file,
>   - update fuse_file->passthrough_id = ID,
>   - idr_replace(),
> - read/write/mmap: lock-free IDR read:
>   - idr_find(fuse_file::passthrough_id),
>   - forward request to lower file system as for the current FUSE
>     passthrough patches.
> - ioctl(PASSTHROUGH_CLOSE): updates IDR, requires spinlock:
>   - idr_remove();
>   - call_rcu(): tell possible open fuse_file user that the ID is no more
>     valid and kfree() the allocated struct;
> - close(fuse_file): updates IDR, requires spinlock:
>   - ID = fuse_file::passthrough_id
>   - idr_find(ID),
>   - fuse_passthrough::fuse_file = NULL,
>   - idr_replace().
>
> This would be fine if passthrough is activated for a few, big files,
> where the passthrough overhead is dominated by the direct access
> benefits, but if passthrough is enabled for many small files which just
> do one or two read/writes (as what I did for my benchmark of total build
> time for the kernel, where I was passing-through every opened file), the
> overhead becomes a real issue.
>
> If you have any thoughts on how to make this simpler, I'm absolutely
> open to fix this.
>

This IDR namespace usually serves a single process. Right?
It sounds a bit more like a file table, more specifically, like io_file_table.
I may be way off, but this sounds a bit like IORING_REGISTER_FILES.
Is there anything that can be learned from this UAPI?
Maybe even reuse of some of the io_uring file register code?

Thanks,
Amir.
