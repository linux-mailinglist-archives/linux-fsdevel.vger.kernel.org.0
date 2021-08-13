Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B94E3EB2A1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Aug 2021 10:29:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238739AbhHMI3g (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Aug 2021 04:29:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233580AbhHMI3g (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Aug 2021 04:29:36 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31A07C061756;
        Fri, 13 Aug 2021 01:29:10 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id r72so12212159iod.6;
        Fri, 13 Aug 2021 01:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PvmkkgqDnb57G4INPQzSJ/lBkARfpdUpdI7+r4gTfuA=;
        b=eAKcv4tuSarby3T6TnoCXIFb1uNYogS+LJzxQb9mZ+wfMGLN3FNOY+TMhWL8jiSgIR
         VzlH9k08axygrF2Sz0qleF+qeE2o4SgcCu1WjZD66Uq7SH4SrvfOiJtu/FPb6yXXIo2h
         +QN3S+p+VGsTETRRvfmJuwK/qnhMbAqvI1LkSFhIaiwICpriXsbfU9FtMoEUfn9UFTzL
         2S06aSYmiL+XYmr5K8O/d9xPBQtQH2min9LWC9Z1SxwZOGf51CuzpxG1l7qN9PKCWjD/
         Kd17waFoaB639aWrOKqwIQ3Kz2FAcWj/oRRq/EUuDA1VZLxEwoOrPJpvm/Kc5eqRMCEr
         egmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PvmkkgqDnb57G4INPQzSJ/lBkARfpdUpdI7+r4gTfuA=;
        b=Kdyoo0vry6HXo7MHhMXA6FGrLvkva0QCuo4+DqFA3nqsqtq3w9pkqwHuq8RYdjijEU
         RwSJDA+YSYscPy0/oMNVXoNVa7cvo3gQvHTAcuk3m0AN02afKFm+Wb/Ebyt0x+XcJ5e6
         sEm+i+Q7QlcELDvmDTv6ORzDWLhliIhe8ACha7DxPYe8i0DaXM4J0E1oy3Inxgw+1qZB
         yEMazNHYM4diajVELU6PZLyCTjA50EmTTHVtoWdr3094hMqX/OuB0y9Mr+S8poG+Jxt8
         M5rB8B7AXcmdYbvict/Ee9tXevQQRoTGAGOM4AsIe3gF+8ZyhB6G2QpsMByObGvrbsQN
         zHjQ==
X-Gm-Message-State: AOAM5302tMYvPHd2qOLfCRMHX5Y12ImIzYAzHJL3J0CV3VxViDxwcxHL
        3cWy7LztIewaH5X2yJOwYhqhPzn6wsrE4b9SfaU=
X-Google-Smtp-Source: ABdhPJyfCrz9s+R1PxeR204G0OtiRDZQw82D5lePEBMtxHYZkGPa6HNdp58DN4Scc04G3who0Kh7LzLoGiOgZFk8jNk=
X-Received: by 2002:a6b:ea0b:: with SMTP id m11mr1176425ioc.186.1628843349714;
 Fri, 13 Aug 2021 01:29:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210812214010.3197279-1-krisman@collabora.com> <20210812214010.3197279-14-krisman@collabora.com>
In-Reply-To: <20210812214010.3197279-14-krisman@collabora.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 13 Aug 2021 11:28:58 +0300
Message-ID: <CAOQ4uxjQ_pFxzr00woh+eqcY2p-=L6tdBnuepg-=WKYGUWUqDQ@mail.gmail.com>
Subject: Re: [PATCH v6 13/21] fanotify: Require fid_mode for any non-fd event
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     Jan Kara <jack@suse.com>, Linux API <linux-api@vger.kernel.org>,
        Ext4 <linux-ext4@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Khazhismel Kumykov <khazhy@google.com>,
        David Howells <dhowells@redhat.com>,
        Dave Chinner <david@fromorbit.com>,
        Theodore Tso <tytso@mit.edu>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Matthew Bobrowski <repnop@google.com>, kernel@collabora.com,
        Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 13, 2021 at 12:41 AM Gabriel Krisman Bertazi
<krisman@collabora.com> wrote:
>
> Like inode events, FAN_FS_ERROR will require fid mode.  Therefore,
> convert the verification during fanotify_mark(2) to require fid for any
> non-fd event.  This means fid_mode will not only be required for inode
> events, but for any event that doesn't provide a descriptor.
>
> Suggested-by: Amir Goldstein <amir73il@gmail.com>
> Reviewed-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

>
> ---
> changes since v5:
>   - Fix condition to include FANOTIFY_EVENT_FLAGS. (me)
>   - Fix comment identation  (jan)
> ---
>  fs/notify/fanotify/fanotify_user.c | 12 ++++++------
>  include/linux/fanotify.h           |  3 +++
>  2 files changed, 9 insertions(+), 6 deletions(-)
>
> diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
> index 4cacea5fcaca..54107f1533d5 100644
> --- a/fs/notify/fanotify/fanotify_user.c
> +++ b/fs/notify/fanotify/fanotify_user.c
> @@ -1387,14 +1387,14 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
>                 goto fput_and_out;
>
>         /*
> -        * Events with data type inode do not carry enough information to report
> -        * event->fd, so we do not allow setting a mask for inode events unless
> -        * group supports reporting fid.
> -        * inode events are not supported on a mount mark, because they do not
> -        * carry enough information (i.e. path) to be filtered by mount point.
> +        * Events that do not carry enough information to report
> +        * event->fd require a group that supports reporting fid.  Those
> +        * events are not supported on a mount mark, because they do not
> +        * carry enough information (i.e. path) to be filtered by mount
> +        * point.
>          */
>         fid_mode = FAN_GROUP_FLAG(group, FANOTIFY_FID_BITS);
> -       if (mask & FANOTIFY_INODE_EVENTS &&
> +       if (mask & ~(FANOTIFY_FD_EVENTS|FANOTIFY_EVENT_FLAGS) &&
>             (!fid_mode || mark_type == FAN_MARK_MOUNT))
>                 goto fput_and_out;
>
> diff --git a/include/linux/fanotify.h b/include/linux/fanotify.h
> index a16dbeced152..c05d45bde8b8 100644
> --- a/include/linux/fanotify.h
> +++ b/include/linux/fanotify.h
> @@ -81,6 +81,9 @@ extern struct ctl_table fanotify_table[]; /* for sysctl */
>   */
>  #define FANOTIFY_DIRENT_EVENTS (FAN_MOVE | FAN_CREATE | FAN_DELETE)
>
> +/* Events that can be reported with event->fd */
> +#define FANOTIFY_FD_EVENTS (FANOTIFY_PATH_EVENTS | FANOTIFY_PERM_EVENTS)
> +
>  /* Events that can only be reported with data type FSNOTIFY_EVENT_INODE */
>  #define FANOTIFY_INODE_EVENTS  (FANOTIFY_DIRENT_EVENTS | \
>                                  FAN_ATTRIB | FAN_MOVE_SELF | FAN_DELETE_SELF)
> --
> 2.32.0
>
