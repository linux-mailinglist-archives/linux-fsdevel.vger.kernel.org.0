Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 296D93A94BE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jun 2021 10:07:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231761AbhFPIJg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Jun 2021 04:09:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231376AbhFPIJg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Jun 2021 04:09:36 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86D93C061574;
        Wed, 16 Jun 2021 01:07:30 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id s19so2104930ioc.3;
        Wed, 16 Jun 2021 01:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Aawz4KrDSfE1sRyy91mWXvyNZiPbdTlPW10y2Ia3xNQ=;
        b=VlcerfMUG8fopKETs+lN3ycmkaxddG1zEhvjwIabwPv9dW/kniNkTXDGrPEbmZdjH9
         KrhSjvtzZjpxmYcbGfslLvtWQao2xVb2x6RUfUoH9YxvWtYOBuCHlwozHKSIGk/FGphK
         emvzT/FKjmJRVEouqjxePNl4VQdMTAQL8mDN4YNub3bWNZGk4P/boKr/VC5D9ii6HhxR
         0iCVjm9jWXa4b2QbscRRt+TZ0Sy7gHn9Gh6MRG9rW6kKcwuEn3bHi72HhkzI8X+N7ydZ
         8JJcTlwIYMgAPktJ6ua/5DSXth2V86R4ejh5bjYnPqbHbARfElzt6u6vgekCVrQcL79c
         TvzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Aawz4KrDSfE1sRyy91mWXvyNZiPbdTlPW10y2Ia3xNQ=;
        b=HGgFXnbVkeE0CvpKhNaX1dtoHBqu9fnoL3COKZ7QzqFDD2zeUa7caeXm/CsLoOSIWw
         9j+YrciXwy2CTCkmgrycIemOgjHJLKH15q2nzhzK0ETV1Gs4VRhFbPvn/2rs2wuwzETm
         BsaVHXnRuC1lxPpvdYjWwePtiw56o42zE/248Ftw6JGoKVQm9KenEl54K7VhNMGgorA8
         OBkE0Krrb0MVPYRy32gRWUcyd0eS5V+ONmAMYUJdTPZwlAAA8Mo/4/m/1hRzekvtBPpP
         FubJxVWP8DzytJGUmDpoy9QqEcWgAdF/820NHa7bxqyviiuaKOrCYLKT8y1MmDzdmXeR
         CnXg==
X-Gm-Message-State: AOAM532ZWRSQ2LDQFCgii0LaVZui4tbzwTJhXl97MhE0P5V3yYorgxwD
        O02eGjn8JlrncyPi6NaeI5OK9P8tazQdMJUt0wM=
X-Google-Smtp-Source: ABdhPJzSe2CX8Hrsvr+74sSts1snGMzU2QP7xaexcj1OH5uH7u81JygJ8sTxa+dsBnvF6o/kaInP41UeW8gioR9T5o4=
X-Received: by 2002:a5d:8b03:: with SMTP id k3mr2601886ion.203.1623830848997;
 Wed, 16 Jun 2021 01:07:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210615235556.970928-1-krisman@collabora.com> <20210615235556.970928-4-krisman@collabora.com>
In-Reply-To: <20210615235556.970928-4-krisman@collabora.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 16 Jun 2021 11:07:18 +0300
Message-ID: <CAOQ4uxhNku-QG8ubKqrTUNFy=FbpwJabFznKOD7tkuxMqxkj9g@mail.gmail.com>
Subject: Re: [PATCH v2 03/14] fanotify: Split fsid check from other fid mode checks
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     kernel@collabora.com, "Darrick J. Wong" <djwong@kernel.org>,
        Theodore Tso <tytso@mit.edu>,
        Dave Chinner <david@fromorbit.com>, Jan Kara <jack@suse.com>,
        David Howells <dhowells@redhat.com>,
        Khazhismel Kumykov <khazhy@google.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Ext4 <linux-ext4@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 16, 2021 at 2:56 AM Gabriel Krisman Bertazi
<krisman@collabora.com> wrote:
>
> FAN_ERROR will require fsid, but not necessarily require the filesystem

FAN_FS_ERROR

> to expose a file handle.  Split those checks into different functions, so
> they can be used separately when setting up an event.
>
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
>
> ---
> Changes since v1:
>   (Amir)
>   - Sort hunks to simplify diff.
> Changes since RFC:
>   (Amir)
>   - Rename fanotify_check_path_fsid -> fanotify_test_fsid.
>   - Use dentry directly instead of path.
> ---
>  fs/notify/fanotify/fanotify_user.c | 27 ++++++++++++++++++---------
>  1 file changed, 18 insertions(+), 9 deletions(-)
>
> diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
> index 0da4e5dcab0f..af518790a80f 100644
> --- a/fs/notify/fanotify/fanotify_user.c
> +++ b/fs/notify/fanotify/fanotify_user.c
> @@ -1192,16 +1192,15 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flags, unsigned int, event_f_flags)
>         return fd;
>  }
>
> -/* Check if filesystem can encode a unique fid */
> -static int fanotify_test_fid(struct path *path, __kernel_fsid_t *fsid)
> +static int fanotify_test_fsid(struct dentry *dentry, __kernel_fsid_t *fsid)
>  {
>         __kernel_fsid_t root_fsid;
>         int err;
>
>         /*
> -        * Make sure path is not in filesystem with zero fsid (e.g. tmpfs).
> +        * Make sure dentry is not of a filesystem with zero fsid (e.g. tmpfs).

Sorry.... I forgot to update this comment
59cda49ecf6c ("shmem: allow reporting fanotify events with file
handles on tmpfs")
Not your fault, but best we fix the comment if we change it to be correct.
It can be changed to (e.g. fuse)

Thanks,
Amir.
