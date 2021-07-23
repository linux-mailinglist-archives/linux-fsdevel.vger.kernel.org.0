Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 455243D36ED
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jul 2021 10:39:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234517AbhGWH7U (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Jul 2021 03:59:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32894 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229907AbhGWH7T (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Jul 2021 03:59:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627029593;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0R6geRNUNQC0kRoF+lSv0pifLg2KS6M6ylGJCMhofy4=;
        b=IF4/l2ffsAVJmuw29rHktc4SwMyJ4y0K0BcSlO2tua+9Rx7EaPkkM5FhCmO+okA/6oW0sX
        yWOLuOvbyQCjf8p5QkNb2TUkxD0yZTib2yDJSgiSYfvokeQ6LHwvmdxXdFQY3qOCDp5KNv
        5SvV5y0q9g7lB/Ue0IfhnsaZipA8h8U=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-357-milNMvjwNN6dtxSgP3CV4Q-1; Fri, 23 Jul 2021 04:39:51 -0400
X-MC-Unique: milNMvjwNN6dtxSgP3CV4Q-1
Received: by mail-yb1-f200.google.com with SMTP id a6-20020a25ae060000b0290551bbd99700so1130352ybj.6
        for <linux-fsdevel@vger.kernel.org>; Fri, 23 Jul 2021 01:39:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0R6geRNUNQC0kRoF+lSv0pifLg2KS6M6ylGJCMhofy4=;
        b=N0EbthgmTPG9Fnp2vKq0aG8m3Q5n1k4vJjsbEQfE29ahAYzwrbc4SBdXdJw3UQVod0
         9dMjAFj3/tFdBpvGKiBrn5gKFntLpdJfNC63cys5Wg/4MSWo7VGoN4XgRUXClkKUbHEP
         Pel4zQtftbrhFMF+taOiFLjAyS4pO/0QkGW76YP2qUnDIsYgNj50oTWymx5TvJoTNPVr
         CAfqkqIoutN8pWp5AMO+57FiL0KS3CqyoAv1MFHk6GksdUOuZ8FQbbNtJXvsuW4I3zKv
         vPBtz17Weib7Q71imkqKpC64yreHvQ/oUD4SOu9cF3dZmIv+lKQhAHwGPf3fy0SkMceF
         Qg4w==
X-Gm-Message-State: AOAM532hME2ev1PORN4cj/K3GP6hjU0whC+WBnoToQGRl1fxEGn7M4Au
        O3o2wMRkQPQL/zYcm8PMPvwdahymCFmOqSf7zjvNrZdxi736lmyNb2sYD6IehaR+oWFCNbWhamy
        bUeCCYRRZJn05PX7zzUIMmb4BdgUoBPVqvQZb6IL6rg==
X-Received: by 2002:a25:ad06:: with SMTP id y6mr4824947ybi.439.1627029591446;
        Fri, 23 Jul 2021 01:39:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwoipMlzBA/c+4YtmIWldiJukH66ZNqDaJOTH+DaPJOdlJ6BqCck6ROt8is3ynzWvQ2IC9DyGQaGkkj7dNqS/Y=
X-Received: by 2002:a25:ad06:: with SMTP id y6mr4824924ybi.439.1627029591301;
 Fri, 23 Jul 2021 01:39:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210624152515.1844133-1-omosnace@redhat.com>
In-Reply-To: <20210624152515.1844133-1-omosnace@redhat.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Fri, 23 Jul 2021 10:39:40 +0200
Message-ID: <CAFqZXNtb-VdL9f8Ntg3RLZtP0x-7ZgEP1D0qL9fWCM7SPWcHXQ@mail.gmail.com>
Subject: Re: [RFC PATCH] userfaultfd: open userfaultfds with O_RDONLY
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        SElinux list <selinux@vger.kernel.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        "Robert O'Callahan" <roc@ocallahan.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 24, 2021 at 5:25 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> Since userfaultfd doesn't implement a write operation, it is more
> appropriate to open it read-only.
>
> When userfaultfds are opened read-write like it is now, and such fd is
> passed from one process to another, SELinux will check both read and
> write permissions for the target process, even though it can't actually
> do any write operation on the fd later.
>
> Inspired by the following bug report, which has hit the SELinux scenario
> described above:
> https://bugzilla.redhat.com/show_bug.cgi?id=1974559
>
> Reported-by: Robert O'Callahan <roc@ocallahan.org>
> Fixes: 86039bd3b4e6 ("userfaultfd: add new syscall to provide memory externalization")
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>
> I marked this as RFC, because I'm not sure if this has any unwanted side
> effects. I only ran this patch through selinux-testsuite, which has a
> simple userfaultfd subtest, and a reproducer from the Bugzilla report.
>
> Please tell me whether this makes sense and/or if it passes any
> userfaultfd tests you guys might have.
>
>  fs/userfaultfd.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
> index 14f92285d04f..24e14c36068f 100644
> --- a/fs/userfaultfd.c
> +++ b/fs/userfaultfd.c
> @@ -986,7 +986,7 @@ static int resolve_userfault_fork(struct userfaultfd_ctx *new,
>         int fd;
>
>         fd = anon_inode_getfd_secure("[userfaultfd]", &userfaultfd_fops, new,
> -                       O_RDWR | (new->flags & UFFD_SHARED_FCNTL_FLAGS), inode);
> +                       O_RDONLY | (new->flags & UFFD_SHARED_FCNTL_FLAGS), inode);
>         if (fd < 0)
>                 return fd;
>
> @@ -2088,7 +2088,7 @@ SYSCALL_DEFINE1(userfaultfd, int, flags)
>         mmgrab(ctx->mm);
>
>         fd = anon_inode_getfd_secure("[userfaultfd]", &userfaultfd_fops, ctx,
> -                       O_RDWR | (flags & UFFD_SHARED_FCNTL_FLAGS), NULL);
> +                       O_RDONLY | (flags & UFFD_SHARED_FCNTL_FLAGS), NULL);
>         if (fd < 0) {
>                 mmdrop(ctx->mm);
>                 kmem_cache_free(userfaultfd_ctx_cachep, ctx);
> --
> 2.31.1

Ping? Any comments on this patch?

-- 
Ondrej Mosnacek
Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

