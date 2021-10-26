Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69BCC43B4EC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Oct 2021 16:56:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235158AbhJZO6k (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Oct 2021 10:58:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231178AbhJZO6j (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Oct 2021 10:58:39 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E74A4C061745;
        Tue, 26 Oct 2021 07:56:15 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id l13so6044970ilh.3;
        Tue, 26 Oct 2021 07:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R9HURV+keZ8+RC861ppVS61dq4P1A4mNf2+AcYkA9y0=;
        b=Cv/et1PndkMkn8UTWO3ufwFO3ktYT4DKlDSaO20ZP9zP0iuOIVbhe0ZJPblA2037zi
         3Xnv7+QiOHayz4gmA3MJOWDz8NleLjcj4QiK+fM1zhQKU9B+sG5zHXSwXeceIRPz9pgV
         voPxq5YylpBb0OZWuAg7HsKeB06F/xhY924mfGzG5zXsrtXj6wUcTICoSeq6we7rbnIe
         rTmRSiVv56NUktYKJEt1vzAPhRKcE5owbJblP0e7nxG3N0Q+C3cOU3SLtCQzqZF2nOvS
         ir9pOzabDhSqgU3QMb4PK0ytwdr4Og6UImCUH2ai30e/K7aZxxdKgt/CyAAmAcfe2Vwi
         B+NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R9HURV+keZ8+RC861ppVS61dq4P1A4mNf2+AcYkA9y0=;
        b=2l8tzGdXjeSvml9yGHD5C9ZuZN7Bwgiank+sqm05+b3Ck7meIbxfraSQ7ErfC1neUl
         H0Zoxl5gsOD31HmPaEJJVnwTlasqlNg3QlMXbHb243s0/FZnyrYLQjPMDm0/3eKg05ay
         voTo4ZJYd8CamhAyCaWm5IDLpA7t9JHsOxf0eGtpjuh4cwBRBAMJ1ZfjJAtV0JKbDggN
         9fwbr8zk5aI6PWvtwPS9lWdJri9O9++CFCKUptEhHCa13hL0ecYMUwuiDQtTJWGXtTlH
         FHLl7Zmp/+dF3lMPH+78YcFhgZOdFRLWGRIoJ2ZpmUjqfjBmDea2kUqMrQKd2j6b/DQy
         /WZA==
X-Gm-Message-State: AOAM530ro6OKYSVxFUuPW45tOKRf/rm7hHXiAYoojvRZTlmEU6XVoKKe
        usbR/eSzcfq6Y/LnMyeDgiI9FpvD5ox+uPhXRz8=
X-Google-Smtp-Source: ABdhPJyQxAk3RWdnDVx9xb0R6GVIYMqcYvNwcAhAeXE+Y0IjtY12vXvMexhQ8VLMYbkWoW/9FuXedJYwWrcf6YXm1vY=
X-Received: by 2002:a05:6e02:18cf:: with SMTP id s15mr10170813ilu.198.1635260175196;
 Tue, 26 Oct 2021 07:56:15 -0700 (PDT)
MIME-Version: 1.0
References: <20211025204634.2517-1-iangelak@redhat.com> <20211025204634.2517-2-iangelak@redhat.com>
In-Reply-To: <20211025204634.2517-2-iangelak@redhat.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 26 Oct 2021 17:56:03 +0300
Message-ID: <CAOQ4uxinGYb0QtgE8To5wc2iijT9VpTgDiXEp-9YXz=t_6eMbA@mail.gmail.com>
Subject: Re: [RFC PATCH 1/7] FUSE: Add the fsnotify opcode and in/out structs
 to FUSE
To:     Ioannis Angelakopoulos <iangelak@redhat.com>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        virtio-fs-list <virtio-fs@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>, Al Viro <viro@zeniv.linux.org.uk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Vivek Goyal <vgoyal@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 25, 2021 at 11:47 PM Ioannis Angelakopoulos
<iangelak@redhat.com> wrote:
>
> Since fsnotify is the backend for the inotify subsystem all the backend
> code implementation we add is related to fsnotify.
>
> To support an fsnotify request in FUSE and specifically virtiofs we add a
> new opcode for the FSNOTIFY (51) operation request in the "fuse.h" header.
>
> Also add the "fuse_notify_fsnotify_in" and "fuse_notify_fsnotify_out"
> structs that are responsible for passing the fsnotify/inotify related data
> to and from the FUSE server.
>
> Signed-off-by: Ioannis Angelakopoulos <iangelak@redhat.com>
> ---
>  include/uapi/linux/fuse.h | 23 ++++++++++++++++++++++-
>  1 file changed, 22 insertions(+), 1 deletion(-)
>
> diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
> index 46838551ea84..418b7fc72417 100644
> --- a/include/uapi/linux/fuse.h
> +++ b/include/uapi/linux/fuse.h
> @@ -186,6 +186,9 @@
>   *  - add FUSE_SYNCFS
>   *  7.35
>   *  - add FUSE_NOTIFY_LOCK
> + *  7.36
> + *  - add FUSE_HAVE_FSNOTIFY
> + *  - add fuse_notify_fsnotify_(in,out)
>   */
>
>  #ifndef _LINUX_FUSE_H
> @@ -221,7 +224,7 @@
>  #define FUSE_KERNEL_VERSION 7
>
>  /** Minor version number of this interface */
> -#define FUSE_KERNEL_MINOR_VERSION 35
> +#define FUSE_KERNEL_MINOR_VERSION 36
>
>  /** The node ID of the root inode */
>  #define FUSE_ROOT_ID 1
> @@ -338,6 +341,7 @@ struct fuse_file_lock {
>   *                     write/truncate sgid is killed only if file has group
>   *                     execute permission. (Same as Linux VFS behavior).
>   * FUSE_SETXATTR_EXT:  Server supports extended struct fuse_setxattr_in
> + * FUSE_HAVE_FSNOTIFY: remote fsnotify/inotify event subsystem support
>   */
>  #define FUSE_ASYNC_READ                (1 << 0)
>  #define FUSE_POSIX_LOCKS       (1 << 1)
> @@ -369,6 +373,7 @@ struct fuse_file_lock {
>  #define FUSE_SUBMOUNTS         (1 << 27)
>  #define FUSE_HANDLE_KILLPRIV_V2        (1 << 28)
>  #define FUSE_SETXATTR_EXT      (1 << 29)
> +#define FUSE_HAVE_FSNOTIFY     (1 << 30)
>
>  /**
>   * CUSE INIT request/reply flags
> @@ -515,6 +520,7 @@ enum fuse_opcode {
>         FUSE_SETUPMAPPING       = 48,
>         FUSE_REMOVEMAPPING      = 49,
>         FUSE_SYNCFS             = 50,
> +       FUSE_FSNOTIFY           = 51,
>
>         /* CUSE specific operations */
>         CUSE_INIT               = 4096,
> @@ -532,6 +538,7 @@ enum fuse_notify_code {
>         FUSE_NOTIFY_RETRIEVE = 5,
>         FUSE_NOTIFY_DELETE = 6,
>         FUSE_NOTIFY_LOCK = 7,
> +       FUSE_NOTIFY_FSNOTIFY = 8,
>         FUSE_NOTIFY_CODE_MAX,
>  };
>
> @@ -571,6 +578,20 @@ struct fuse_getattr_in {
>         uint64_t        fh;
>  };
>
> +struct fuse_notify_fsnotify_out {
> +       uint64_t inode;

64bit inode is not a good unique identifier of the object.
you need to either include the generation in object identifier
or much better use the object's nfs file handle, the same way
that fanotify stores object identifiers.

> +       uint64_t mask;
> +       uint32_t namelen;
> +       uint32_t cookie;

I object to persisting with the two-events-joined-by-cookie design.
Any new design should include a single event for rename
with information about src and dst.

I know this is inconvenient, but we are NOT going to create a "remote inotify"
interface, we need to create a "remote fsnotify" interface and if server wants
to use inotify, it will need to join the disjoined MOVE_FROM/TO event into
a single "remote event", that FUSE will use to call fsnotify_move().

Thanks,
Amir.
