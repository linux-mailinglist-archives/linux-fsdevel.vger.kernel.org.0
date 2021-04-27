Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5360936C121
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Apr 2021 10:41:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235033AbhD0Ij7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Apr 2021 04:39:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231148AbhD0Ij6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Apr 2021 04:39:58 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AC62C061574;
        Tue, 27 Apr 2021 01:39:14 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id g125so4536546iof.3;
        Tue, 27 Apr 2021 01:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Wl9KaP9Euc+PMibq3F14vkXfHRg6Jg2IyRSH6anShfw=;
        b=qIRme1Tm5Iq7C+h6pMw1gTDTpnxlvRTl7f53UPYVj1Vsv6tSPr5X7Ji2C32KyhK1V6
         4qFb3dFM6hjl9yC1tITtvdGewFm2hi5cfLyK46hv1Dc+pL4KnRZt7Jsshg26sBNmyOY6
         3cQIFTgMMe2wHNwhM9M4nX2AayZXs7YRK1VRLLjDoPQCoaH/2atUzlP9r3CsB/DrRR86
         OSDbOFILNoqTZuk8XJVWlX3VaRL+reTyI5SYYcrB6Z8DTDStu0Q36dq8jRYIYNGvjzdc
         kleO1JIqPrg6w8JoKQyylyvaQ4SOlRAClmyynyHrmQegTUAiQQk59BQLbdazggR7WK6G
         q59A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Wl9KaP9Euc+PMibq3F14vkXfHRg6Jg2IyRSH6anShfw=;
        b=rFbT12SyxEo7A/yCMoVgVPNerWOS9ZpMMEbiL4ly9aBeTzvvBKWkfQpOmjMUTclQ4m
         ZnWc0Lo6zXERqCUIDPeELkVcIpzz+ypZnE6+eaZQopbHQfNd0jAHT88Kr9Ngv0zm9OkB
         r/Wsa10lje2xNn+483y3VbBGsLfLQaOP4bk4283dqyamQxEIKVACZUdBj1UnwPOgZCXC
         pVaWT0Smo6xJPYQ7JVfs4oQaiYGVq1VIOpxa9JtMgmxWlmDkWzOn70Z/+uESALlOBi53
         Y83L1qK1ISXFm343fzcJ1koue1uoI7jm58fcrNOU6TMFkIlnlALlCwc09JcwnViUoj6E
         pqlw==
X-Gm-Message-State: AOAM533j5PgZxHe4rVTJQqNQ5hJnmqgp7vbu5Afq2lorDFpBKaUDMtBh
        b+iSyhnLVia0yAwARpbGNpvotkaKIJQ6u8lijfA=
X-Google-Smtp-Source: ABdhPJyvxUhkcMwFIcsofEldbp9u8JnbLfercFV7BBPTkFw2oarVWSL+lXLjZBJ/ztbnPfp7EbTKj6st1F+OHSCGWQo=
X-Received: by 2002:a6b:f00f:: with SMTP id w15mr17973273ioc.72.1619512753506;
 Tue, 27 Apr 2021 01:39:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210426184201.4177978-1-krisman@collabora.com> <20210426184201.4177978-8-krisman@collabora.com>
In-Reply-To: <20210426184201.4177978-8-krisman@collabora.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 27 Apr 2021 11:39:02 +0300
Message-ID: <CAOQ4uxgfjfa+j00rO8S9MnCUMUjPbOQx3OVsXLZw_VSAgB7Ckw@mail.gmail.com>
Subject: Re: [PATCH RFC 07/15] fsnotify: Support FS_ERROR event type
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     Theodore Tso <tytso@mit.edu>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Dave Chinner <david@fromorbit.com>, Jan Kara <jack@suse.com>,
        David Howells <dhowells@redhat.com>,
        Khazhismel Kumykov <khazhy@google.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Ext4 <linux-ext4@vger.kernel.org>, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 26, 2021 at 9:42 PM Gabriel Krisman Bertazi
<krisman@collabora.com> wrote:
>
> Expose a new type of fsnotify event for filesystems to report errors for
> userspace monitoring tools.  fanotify will send this type of
> notification for FAN_ERROR marks.
>
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
> ---
>  fs/notify/fsnotify.c             |  2 +-
>  include/linux/fsnotify_backend.h | 16 ++++++++++++++++
>  2 files changed, 17 insertions(+), 1 deletion(-)
>
> diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
> index 30d422b8c0fc..9fff35e67b37 100644
> --- a/fs/notify/fsnotify.c
> +++ b/fs/notify/fsnotify.c
> @@ -558,7 +558,7 @@ static __init int fsnotify_init(void)
>  {
>         int ret;
>
> -       BUILD_BUG_ON(HWEIGHT32(ALL_FSNOTIFY_BITS) != 25);
> +       BUILD_BUG_ON(HWEIGHT32(ALL_FSNOTIFY_BITS) != 26);
>
>         ret = init_srcu_struct(&fsnotify_mark_srcu);
>         if (ret)
> diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
> index a1a4dd69e5ed..f850bfbe30d4 100644
> --- a/include/linux/fsnotify_backend.h
> +++ b/include/linux/fsnotify_backend.h
> @@ -48,6 +48,8 @@
>  #define FS_ACCESS_PERM         0x00020000      /* access event in a permissions hook */
>  #define FS_OPEN_EXEC_PERM      0x00040000      /* open/exec event in a permission hook */
>
> +#define FS_ERROR               0x00100000      /* Used for filesystem error reporting */
> +

Why skip 0x00080000?

Anyway, event bits are starting to run out so I would prefer that you overload
an existing bit used only by inotify/dnotify.

FS_IN_IGNORED is completely internal to inotify and there is no need to
set it in i_fsnotify_mask at all, so if we remove the bit from the output of
inotify_arg_to_mask() no functionality will change and we will be able to
overload the event bit for FS_ERROR (see patch below).

I also kind of like that FS_ERROR is adjacent to FS_UMOUNT and
FS_Q_OVERFLOW :-)

Other FS_IN/FS_DN bits may also be reclaimed but it takes a bit more work
I have patches for those.

Thanks,
Amir.

diff --git a/fs/notify/inotify/inotify_user.c b/fs/notify/inotify/inotify_user.c
index 98f61b31745a..351517bae716 100644
--- a/fs/notify/inotify/inotify_user.c
+++ b/fs/notify/inotify/inotify_user.c
@@ -89,10 +89,10 @@ static inline __u32 inotify_arg_to_mask(struct
inode *inode, u32 arg)
        __u32 mask;

        /*
-        * Everything should accept their own ignored and should receive events
-        * when the inode is unmounted.  All directories care about children.
+        * Everything should receive events when the inode is unmounted.
+        * All directories care about children.
         */
-       mask = (FS_IN_IGNORED | FS_UNMOUNT);
+       mask = FS_UNMOUNT;
        if (S_ISDIR(inode->i_mode))
                mask |= FS_EVENT_ON_CHILD;

diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
index 1ce66748a2d2..ecbafb3f36d7 100644
--- a/include/linux/fsnotify_backend.h
+++ b/include/linux/fsnotify_backend.h
@@ -42,6 +42,11 @@

 #define FS_UNMOUNT             0x00002000      /* inode on umount fs */
 #define FS_Q_OVERFLOW          0x00004000      /* Event queued overflowed */
+#define FS_ERROR               0x00008000      /* Filesystem error report */
+/*
+ * FS_IN_IGNORED overloads FS_ERROR.  It is only used internally by inotify
+ * which does not support FS_ERROR.
+ */
 #define FS_IN_IGNORED          0x00008000      /* last inotify event here */
