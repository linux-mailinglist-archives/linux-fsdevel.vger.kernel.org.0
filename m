Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C319B32819A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Mar 2021 15:59:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236705AbhCAO7B (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Mar 2021 09:59:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236377AbhCAO67 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Mar 2021 09:58:59 -0500
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5273C061756;
        Mon,  1 Mar 2021 06:58:18 -0800 (PST)
Received: by mail-io1-xd36.google.com with SMTP id o11so10113954iob.1;
        Mon, 01 Mar 2021 06:58:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZlENCPvxf7DjKyfZ7xMGkDQ8iQrc9BRxxJPj+woaL84=;
        b=PboAFXfJuiBB/erCa7BBODs55QRuQHo6MhgsR2x1tHo/26H7gElGza013dhcsZd1Lp
         IMxSqWNrzGk/Q8unn9tteC0eK0JnnoeyuRQVBeYN2uofqpC5kcbuz5O3TJhAxbMPld5I
         emGwXGGoL8TTUdEDT3trWqZRTAM0zQi5QhUJusaPdUwFOOOeyJFJh0X8jrbt3pf6c3r9
         H+9EqXWs5c7lKn6XgK37Z+PGqF3FN2JAmi37jH2xJBeSRT+gPWrPSb0K33/1ITjKERK3
         Tgtj0IOJzes4HEOBAm661cXOqYYguCjdatJnQlyAn0peoAFk9joqW3PbYIvenKZ1jswg
         S8WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZlENCPvxf7DjKyfZ7xMGkDQ8iQrc9BRxxJPj+woaL84=;
        b=YIK9lyqp+LmHYywR0zdw5uLgY9o7azHzTxmL9p9bKzRpbve31WDeluN9ATnKWp3xh2
         T23FYd3wfjIiL+XjPzupZNJo9BfBYUhJo0nXGBZy4CcZsdhiPx3mBdNtR++1r4IdTkRF
         qnweQuvN/DL8muU3PkB3l7fn2Z3FhZ7CkIxexYz531kgin1UG7mf4jXxJe+M4LYpluJ8
         rOvTRDM3NrM96d+sbDWb+XzglJSAI7GIe4BA1I88eN6F31AjJEDmpAL9W9RjmF1kHOm4
         WUZTKtQJqjw8PngX/2il/Nt3ZtXqJ2p+4FZpMmyKclSoOw6H/oL2qIe1nPFk1V4ga+Oc
         41Qw==
X-Gm-Message-State: AOAM532FFvrS6mnwh3x2A6MVrpt+KLEMS2F8UxpkQU/tUXbkyGcCE8pm
        z/Rimt4rHgS8nKQ7I4HR7Pms6ZpBx5RIcomT6Fs=
X-Google-Smtp-Source: ABdhPJy7FjQBWY1ihxlwvOYAiAHDv3SDnb/44m9QuJRQ9OCZb/W36La/3S1FImZDuDQVA2xbLkAs3qN4HZMba3Nh2nU=
X-Received: by 2002:a05:6602:2c52:: with SMTP id x18mr14201484iov.5.1614610698219;
 Mon, 01 Mar 2021 06:58:18 -0800 (PST)
MIME-Version: 1.0
References: <20210224142307.7284-1-lhenriques@suse.de> <20210301144104.75545-1-alx.manpages@gmail.com>
In-Reply-To: <20210301144104.75545-1-alx.manpages@gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 1 Mar 2021 16:58:07 +0200
Message-ID: <CAOQ4uxiEih1Ojy4ncvNKV-71OMGw8964F9RQrBaxdszxHArznQ@mail.gmail.com>
Subject: Re: [RFC v3] copy_file_range.2: Update cross-filesystem support for 5.12
To:     Alejandro Colomar <alx.manpages@gmail.com>
Cc:     linux-man <linux-man@vger.kernel.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Luis Henriques <lhenriques@suse.de>,
        Steve French <sfrench@samba.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Jeff Layton <jlayton@kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Dave Chinner <dchinner@redhat.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Ian Lance Taylor <iant@google.com>,
        Luis Lozano <llozano@chromium.org>,
        Andreas Dilger <adilger@dilger.ca>,
        Olga Kornievskaia <aglo@umich.edu>,
        Christoph Hellwig <hch@infradead.org>,
        ceph-devel <ceph-devel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        samba-technical <samba-technical@lists.samba.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Walter Harms <wharms@bfs.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 1, 2021 at 4:45 PM Alejandro Colomar <alx.manpages@gmail.com> wrote:
>
> Linux 5.12 fixes a regression.
>
> Cross-filesystem (introduced in 5.3) copies were buggy.
>
> Move the statements documenting cross-fs to BUGS.
> Kernels 5.3..5.11 should be patched soon.
>
> State version information for some errors related to this.
>
> Reported-by: Luis Henriques <lhenriques@suse.de>
> Reported-by: Amir Goldstein <amir73il@gmail.com>
> Related: <https://lwn.net/Articles/846403/>
> Cc: Greg KH <gregkh@linuxfoundation.org>
> Cc: Michael Kerrisk <mtk.manpages@gmail.com>
> Cc: Anna Schumaker <anna.schumaker@netapp.com>
> Cc: Jeff Layton <jlayton@kernel.org>
> Cc: Steve French <sfrench@samba.org>
> Cc: Miklos Szeredi <miklos@szeredi.hu>
> Cc: Trond Myklebust <trond.myklebust@hammerspace.com>
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Cc: "Darrick J. Wong" <darrick.wong@oracle.com>
> Cc: Dave Chinner <dchinner@redhat.com>
> Cc: Nicolas Boichat <drinkcat@chromium.org>
> Cc: Ian Lance Taylor <iant@google.com>
> Cc: Luis Lozano <llozano@chromium.org>
> Cc: Andreas Dilger <adilger@dilger.ca>
> Cc: Olga Kornievskaia <aglo@umich.edu>
> Cc: Christoph Hellwig <hch@infradead.org>
> Cc: ceph-devel <ceph-devel@vger.kernel.org>
> Cc: linux-kernel <linux-kernel@vger.kernel.org>
> Cc: CIFS <linux-cifs@vger.kernel.org>
> Cc: samba-technical <samba-technical@lists.samba.org>
> Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>
> Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
> Cc: Walter Harms <wharms@bfs.de>
> Signed-off-by: Alejandro Colomar <alx.manpages@gmail.com>
> ---
>
> v3:
>         - Don't remove some important text.
>         - Reword BUGS.
>
> ---
> Hi Amir,
>
> I covered your comments.  I may need to add something else after your
> discussion with Steve; please comment.
>
> I tried to reword BUGS so that it's as specific and understandable as I can.
> If you still find it not good enough, please comment :)
>
> Thanks,
>
> Alex
>
> ---
>  man2/copy_file_range.2 | 26 ++++++++++++++++++++++----
>  1 file changed, 22 insertions(+), 4 deletions(-)
>
> diff --git a/man2/copy_file_range.2 b/man2/copy_file_range.2
> index 611a39b80..1c0df3f74 100644
> --- a/man2/copy_file_range.2
> +++ b/man2/copy_file_range.2
> @@ -169,6 +169,9 @@ Out of memory.
>  .B ENOSPC
>  There is not enough space on the target filesystem to complete the copy.
>  .TP
> +.BR EOPNOTSUPP " (since Linux 5.12)"
> +The filesystem does not support this operation.
> +.TP
>  .B EOVERFLOW
>  The requested source or destination range is too large to represent in the
>  specified data types.
> @@ -184,10 +187,17 @@ or
>  .I fd_out
>  refers to an active swap file.
>  .TP
> -.B EXDEV
> +.BR EXDEV " (before Linux 5.3)"
> +The files referred to by
> +.IR fd_in " and " fd_out
> +are not on the same filesystem.
> +.TP
> +.BR EXDEV " (since Linux 5.12)"
>  The files referred to by
>  .IR fd_in " and " fd_out
> -are not on the same mounted filesystem (pre Linux 5.3).
> +are not on the same filesystem,
> +and the source and target filesystems are not of the same type,
> +or do not support cross-filesystem copy.
>  .SH VERSIONS
>  The
>  .BR copy_file_range ()
> @@ -200,8 +210,10 @@ Areas of the API that weren't clearly defined were clarified and the API bounds
>  are much more strictly checked than on earlier kernels.
>  Applications should target the behaviour and requirements of 5.3 kernels.
>  .PP
> -First support for cross-filesystem copies was introduced in Linux 5.3.
> -Older kernels will return -EXDEV when cross-filesystem copies are attempted.
> +Since 5.12,
> +cross-filesystem copies can be achieved
> +when both filesystems are of the same type,
> +and that filesystem implements support for it.

Maybe refer to BUGS here for pre 5.12 behavior?

>  .SH CONFORMING TO
>  The
>  .BR copy_file_range ()
> @@ -226,6 +238,12 @@ gives filesystems an opportunity to implement "copy acceleration" techniques,
>  such as the use of reflinks (i.e., two or more inodes that share
>  pointers to the same copy-on-write disk blocks)
>  or server-side-copy (in the case of NFS).
> +.SH BUGS
> +In Linux kernels 5.3 to 5.11,
> +cross-filesystem copies were supported by the kernel,
> +instead of being supported by individual filesystems.

Not so clear/accurate IMO. Maybe:

cross-filesystem copies were implemented by the kernel,
if the operation was not supported by individual filesystems.

> +However, on some virtual filesystems,
> +the call failed to copy, while still reporting success.

Thanks,
Amir.
