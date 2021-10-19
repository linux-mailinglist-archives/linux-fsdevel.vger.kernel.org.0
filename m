Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FE57432DF3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Oct 2021 08:14:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233925AbhJSGQV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Oct 2021 02:16:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbhJSGQV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Oct 2021 02:16:21 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6E6EC06161C;
        Mon, 18 Oct 2021 23:14:08 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id z69so15942662iof.9;
        Mon, 18 Oct 2021 23:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xQz7pPJ5LCEpoqmh45rJ065Eda8sosjGcwwBJFpRNZw=;
        b=I390vrS52uYaWWn8uJzOsuNyHTbthmLJP9J8F6E6EOqWFV/rlDalOWKTavRrqe4QTQ
         RMosSuziATFWtHeQ2/y70+sOZw4scIssI7fqd3c9kFHYcc5gWjLa/XQ/oRyCTizBDFqV
         j+UMpXe0WeF/eWnSFCb19sYeWa7e1JGwGB45KtiYjTgv94o6OM1W4JXkBRnRdfzanSoU
         7kY+oliJ0InnzEyEjv6rHhQB8vHEW9R4WOfI3u0xivdgpSUbMKLMXyJqco8Y/2AN2c9x
         7stSGkR6opFib2onVumq0AjcaOqSGP1nPa+CdWHpfolqr6PrHuv3R1RWpFkfNWn93fxo
         WZGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xQz7pPJ5LCEpoqmh45rJ065Eda8sosjGcwwBJFpRNZw=;
        b=5WVdMiPkK9jlWQ0O7jHJAsob3JxXH2Ah2mpTkysca95M5tlFqzPdDPhDaV80oXrX+y
         Phd3cEFtRsvC6wsrwlluiv2yVOoEUNFqrodXqbA9KQduygucLFK4b/i86MB14sRj+cwc
         hhoWtjsCIAA6D/fTtP8OOxDrQ/2CjsbFbLsOeFGvbdGxH+xGVU5rnIRSuugEEM8QNa5x
         x83/5RZwvhWrXSyqdPfdkOC3DZEn3dr9XOXg4LlgUrJ+BQ+KvVjN4ZY99rGuSt5QdA+U
         W+rFrsygN+AX8d3pHa2tjz3Sbjvv+jQNTZH7nA98irW5WfhGPwVB3jkF+qz13oyv09sR
         wtNQ==
X-Gm-Message-State: AOAM532oCNwslX4I8O/KByxiC0mwGEO02P028pFrFAygBdrDg3rAkC1D
        KRYlS/22HWzT6PPCEJwS8ZClSS7OSkPcTPGI3Qg=
X-Google-Smtp-Source: ABdhPJzjqRuD8Yh40wU8JHXkyRwkUGvauW1Hn3EMJyXde5oDETyoXVCRbhaTqwYzFJ7bcNBDM90Rm63R3FetL3Ursoo=
X-Received: by 2002:a05:6602:26d2:: with SMTP id g18mr17017756ioo.70.1634624048360;
 Mon, 18 Oct 2021 23:14:08 -0700 (PDT)
MIME-Version: 1.0
References: <20211019000015.1666608-1-krisman@collabora.com> <20211019000015.1666608-26-krisman@collabora.com>
In-Reply-To: <20211019000015.1666608-26-krisman@collabora.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 19 Oct 2021 09:13:57 +0300
Message-ID: <CAOQ4uxgd42EW0KGVMjaG4RdLQHOaMMMZ7+0XY5+we4jRs1Nggg@mail.gmail.com>
Subject: Re: [PATCH v8 25/32] fanotify: Report fid entry even for zero-length file_handle
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

On Tue, Oct 19, 2021 at 3:03 AM Gabriel Krisman Bertazi
<krisman@collabora.com> wrote:
>
> Non-inode errors will reported with an empty file_handle.  In
> preparation for that, allow some events to print the FID record even if
> there isn't any file_handle encoded
>
> Even though FILEID_ROOT is used internally, make zero-length file
> handles be reported as FILEID_INVALID.
>
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
Reviewed-by: Amir Goldstein <amir73il@gmail.com>

> ---
>  fs/notify/fanotify/fanotify_user.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
> index ae848306a017..cd962deefeb7 100644
> --- a/fs/notify/fanotify/fanotify_user.c
> +++ b/fs/notify/fanotify/fanotify_user.c
> @@ -339,9 +339,6 @@ static int copy_fid_info_to_user(__kernel_fsid_t *fsid, struct fanotify_fh *fh,
>         pr_debug("%s: fh_len=%zu name_len=%zu, info_len=%zu, count=%zu\n",
>                  __func__, fh_len, name_len, info_len, count);
>
> -       if (!fh_len)
> -               return 0;
> -
>         if (WARN_ON_ONCE(len < sizeof(info) || len > count))
>                 return -EFAULT;
>
> @@ -376,6 +373,11 @@ static int copy_fid_info_to_user(__kernel_fsid_t *fsid, struct fanotify_fh *fh,
>
>         handle.handle_type = fh->type;
>         handle.handle_bytes = fh_len;
> +
> +       /* Mangle handle_type for bad file_handle */
> +       if (!fh_len)
> +               handle.handle_type = FILEID_INVALID;
> +
>         if (copy_to_user(buf, &handle, sizeof(handle)))
>                 return -EFAULT;
>
> --
> 2.33.0
>
