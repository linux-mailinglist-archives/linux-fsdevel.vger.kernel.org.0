Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 920F4432D8C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Oct 2021 07:57:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233904AbhJSF76 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Oct 2021 01:59:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbhJSF76 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Oct 2021 01:59:58 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7CD1C06161C;
        Mon, 18 Oct 2021 22:57:45 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id j8so17268927ila.11;
        Mon, 18 Oct 2021 22:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5lAUP3jqPno1fIvkezQw6XWrCUmUSD+cCPVURLWlg/4=;
        b=mAyGW5CrXwFlmdOA6f9e4OuSZTB4edtRyTRWms1JdfnlTN+fkivQ/tjT9cS6hW/0iW
         fHWfSucuLnWmseQNSpgBd6ah5RQpKCyAz9+TSGMEXaRXs/PV55bUZrn2+RGUAakqt/W0
         oOXWcuUYx0jLZZ7IAxIWqkqY2vVDN+aibE7ujFty/WE4Ue/rtwfXzDhRbQxKhDAo/ApE
         rwZkvHRy9dJYPoT66DHYiAecHFqxMVIu/x5SaZOKJalvV4ZIOeqQ1YnzIKOnKNn0SNie
         YYEztOsIl8KtasrWv9iooXBOxD3aqavIxDPt9SFqhpKJerWwOal+ldWMF2eZiO82tZfe
         QdEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5lAUP3jqPno1fIvkezQw6XWrCUmUSD+cCPVURLWlg/4=;
        b=5/F53tVbVhFZr/cB8lkRR0BxgtSbacLZcX97dRG1NPRZ0IGDboajZLB44AYQNowziQ
         quD1I5WyqUJg7d768zad8fTozwdP/4hWE1iSTxs1ysx0p86sgd92t/Mg3YxZoMYZT/NE
         /GnAs8Td5Fq2F/nMHDpkL7jVs9WNw5xJ/7i0BBBVt9cMNHoFMKcTJPwFQbG+Iw8cYmln
         Db0LsubLyevDdPjiilmnPkcyH6IBnS5G3XWDGXHDwDSmJKjnZe1RKYwy0/EuoC/i519X
         sZSMrfCIumQmFUwwNNAVF1zlRqNGEDCiKJ4qjVX8zSDovSyb4eODnz26gGKiahut5f+E
         VLdA==
X-Gm-Message-State: AOAM530Xc6nJKTB4cSQLOxEgLsvy3El3badUtGNU3npQTH4QlmadrR5+
        hs625W12wAVXUDQjnqvLNRJTD3DdrjpSjNqE9A8=
X-Google-Smtp-Source: ABdhPJxzbRTIBeUELxAb8n+DpH76vHUZ9PJYFH+ap54i0XtfDfa3OZ+hSmW51oasrrVHSVFjF+Mu5O1ZCQhdP8RGn0w=
X-Received: by 2002:a05:6e02:1b04:: with SMTP id i4mr17491724ilv.319.1634623065214;
 Mon, 18 Oct 2021 22:57:45 -0700 (PDT)
MIME-Version: 1.0
References: <20211019000015.1666608-1-krisman@collabora.com> <20211019000015.1666608-30-krisman@collabora.com>
In-Reply-To: <20211019000015.1666608-30-krisman@collabora.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 19 Oct 2021 08:57:34 +0300
Message-ID: <CAOQ4uxhiXdKEo0o9joQ=7PTRkbQAEmFjjD2BgyZTTAdJ_QZ7Vg@mail.gmail.com>
Subject: Re: [PATCH v8 29/32] fanotify: Allow users to request FAN_FS_ERROR events
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     Jan Kara <jack@suse.com>, "Darrick J. Wong" <djwong@kernel.org>,
        Theodore Tso <tytso@mit.edu>,
        Dave Chinner <david@fromorbit.com>,
        David Howells <dhowells@redhat.com>,
        Khazhismel Kumykov <khazhy@google.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Ext4 <linux-ext4@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 19, 2021 at 3:04 AM Gabriel Krisman Bertazi
<krisman@collabora.com> wrote:
>
> Wire up the FAN_FS_ERROR event in the fanotify_mark syscall, allowing
> user space to request the monitoring of FAN_FS_ERROR events.
>
> These events are limited to filesystem marks, so check it is the
> case in the syscall handler.
>
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
>
Reviewed-by: Amir Goldstein <amir73il@gmail.com>

> ---
> Changes since v7:
>   - Move the verification closer to similar code (Amir)
> ---
>  fs/notify/fanotify/fanotify.c      | 2 +-
>  fs/notify/fanotify/fanotify_user.c | 4 ++++
>  include/linux/fanotify.h           | 6 +++++-
>  3 files changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
> index 0f6694eadb63..20169b8d5ab7 100644
> --- a/fs/notify/fanotify/fanotify.c
> +++ b/fs/notify/fanotify/fanotify.c
> @@ -821,7 +821,7 @@ static int fanotify_handle_event(struct fsnotify_group *group, u32 mask,
>         BUILD_BUG_ON(FAN_OPEN_EXEC_PERM != FS_OPEN_EXEC_PERM);
>         BUILD_BUG_ON(FAN_FS_ERROR != FS_ERROR);
>
> -       BUILD_BUG_ON(HWEIGHT32(ALL_FANOTIFY_EVENT_BITS) != 19);
> +       BUILD_BUG_ON(HWEIGHT32(ALL_FANOTIFY_EVENT_BITS) != 20);
>
>         mask = fanotify_group_event_mask(group, iter_info, mask, data,
>                                          data_type, dir);
> diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
> index b83c61c934d0..22dca806c7e2 100644
> --- a/fs/notify/fanotify/fanotify_user.c
> +++ b/fs/notify/fanotify/fanotify_user.c
> @@ -1535,6 +1535,10 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
>             group->priority == FS_PRIO_0)
>                 goto fput_and_out;
>
> +       if (mask & FAN_FS_ERROR &&
> +           mark_type != FAN_MARK_FILESYSTEM)
> +               goto fput_and_out;
> +
>         /*
>          * Events that do not carry enough information to report
>          * event->fd require a group that supports reporting fid.  Those
> diff --git a/include/linux/fanotify.h b/include/linux/fanotify.h
> index 52d464802d99..616af2ea20f3 100644
> --- a/include/linux/fanotify.h
> +++ b/include/linux/fanotify.h
> @@ -91,9 +91,13 @@ extern struct ctl_table fanotify_table[]; /* for sysctl */
>  #define FANOTIFY_INODE_EVENTS  (FANOTIFY_DIRENT_EVENTS | \
>                                  FAN_ATTRIB | FAN_MOVE_SELF | FAN_DELETE_SELF)
>
> +/* Events that can only be reported with data type FSNOTIFY_EVENT_ERROR */
> +#define FANOTIFY_ERROR_EVENTS  (FAN_FS_ERROR)
> +
>  /* Events that user can request to be notified on */
>  #define FANOTIFY_EVENTS                (FANOTIFY_PATH_EVENTS | \
> -                                FANOTIFY_INODE_EVENTS)
> +                                FANOTIFY_INODE_EVENTS | \
> +                                FANOTIFY_ERROR_EVENTS)
>
>  /* Events that require a permission response from user */
>  #define FANOTIFY_PERM_EVENTS   (FAN_OPEN_PERM | FAN_ACCESS_PERM | \
> --
> 2.33.0
>
