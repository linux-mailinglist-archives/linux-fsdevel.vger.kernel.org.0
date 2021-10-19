Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF2AE432DD1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Oct 2021 08:07:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234356AbhJSGJ6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Oct 2021 02:09:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234297AbhJSGJk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Oct 2021 02:09:40 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 026C8C061775;
        Mon, 18 Oct 2021 23:07:17 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id d125so19065585iof.5;
        Mon, 18 Oct 2021 23:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OJPnE53wDyw02nOZlJ76Hqx6u6J9KEzgtWn7Df9CAAI=;
        b=giPgNCUAm5DSjZ2U+HWQSSU+UpwWS02/Xog9QldoFnm/LHkmiM4bGI1LBd+YPk48ZL
         RR4acYiTNdWzPcbMeqkDg7UlvOzCbOSowC8lxOSCrnmevFdoDdyCtNBkF6CZpXeI7CzW
         65HYY9/YK5tclFq4rDP38kURAhUHIF0C0jQYoOP4agFM3RyEjIF6rZHUV5qh3AXDgHWN
         UJksna0Q5aNtfT5endGY8x5r5NJbkUHzGJDlCI4zVClra7UdLmO30TWDFuKYdgOD1KGW
         E0jRmNXvYpaBaPFEaVZrngrGb1p5sqgfViSiDzFM4N7GIzKX0wAEea0ixhREdUtUcDmM
         R6tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OJPnE53wDyw02nOZlJ76Hqx6u6J9KEzgtWn7Df9CAAI=;
        b=OH1J/3r/ADn842oyS7g1Emv9+m25+030RADvAa2YYjOywyMMDFOnxkS7AAu8OYgrkM
         Sst5miZ16Z7dcXvHyD0A5qU07qxnSxaJFxnJTrZ10+hJxOYExRz3QpTwIXzmSc/iWR6z
         4XtRUmQff6GrGaGM1sPKyBi+Iv/L5QAPmc33434aXD/Hq+eNjwIgE4CCJdimZIKso1/t
         yU5klTdggyasYUqk/r2z2cpJK0uLAyF4hPwt14OFdCuPn74hd1bVf/PFm2w4aGdwXtHB
         3NtAJ5i/wLPlRA+9xy87s0G4WMljCLblVVY7L+ndcpSztsBigDOzPVv1/a/al5Bcg3OE
         V71A==
X-Gm-Message-State: AOAM531oI1wVJZSIQchX7Bs+MVcUzlI6vNZFbxJ88Ym4MhT6H7I4qwsv
        WfvRVwFhT5SO3iM/JMtrryJBZPRYw7/tvWOsQjbvXAUC4I4=
X-Google-Smtp-Source: ABdhPJx4ccelib8vlLM4qPixkaASw6oYPSIM6qKaP0qyu1l0IRUYulcWwEH5x4dNznBKB1kk7NLxf0O0wtcCYJ/JB10=
X-Received: by 2002:a05:6638:39c:: with SMTP id y28mr2803433jap.47.1634623635626;
 Mon, 18 Oct 2021 23:07:15 -0700 (PDT)
MIME-Version: 1.0
References: <20211019000015.1666608-1-krisman@collabora.com> <20211019000015.1666608-28-krisman@collabora.com>
In-Reply-To: <20211019000015.1666608-28-krisman@collabora.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 19 Oct 2021 09:07:04 +0300
Message-ID: <CAOQ4uxjm_106b-KDS09MEa9tUdzywh2P5HCCfWxRZMuy3XM8xw@mail.gmail.com>
Subject: Re: [PATCH v8 27/32] fanotify: Report fid info for file related file
 system errors
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
> Plumb the pieces to add a FID report to error records.  Since all error
> event memory must be pre-allocated, we pre-allocate the maximum file
> handle size possible, such that it should always fit.
>
> For errors that don't expose a file handle report it with an invalid
> FID.
>
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
>
Reviewed-by: Amir Goldstein <amir73il@gmail.com>

with minor nit below..

> ---
> Changes since v7:
>   - Move WARN_ON to separate patch (Amir)
>   - Avoid duplication in the structure definition (Amir)
> Changes since v6:
>   - pass fsid from handle_events
> Changes since v5:
>   - Use preallocated MAX_HANDLE_SZ FH buffer
>   - Report superblock errors with a zerolength INVALID FID (jan, amir)
> ---
>  fs/notify/fanotify/fanotify.c | 10 ++++++++++
>  fs/notify/fanotify/fanotify.h | 11 +++++++++++
>  2 files changed, 21 insertions(+)
>
> diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
> index 45df610debbe..335ce8f88eb8 100644
> --- a/fs/notify/fanotify/fanotify.c
> +++ b/fs/notify/fanotify/fanotify.c
> @@ -609,7 +609,9 @@ static struct fanotify_event *fanotify_alloc_error_event(
>  {
>         struct fs_error_report *report =
>                         fsnotify_data_error_report(data, data_type);
> +       struct inode *inode = report->inode;
>         struct fanotify_error_event *fee;
> +       int fh_len;
>
>         if (WARN_ON_ONCE(!report))
>                 return NULL;
> @@ -622,6 +624,14 @@ static struct fanotify_event *fanotify_alloc_error_event(
>         fee->err_count = 1;
>         fee->fsid = *fsid;
>
> +       fh_len = fanotify_encode_fh_len(inode);
> +
> +       /* Bad fh_len. Fallback to using an invalid fh. Should never happen. */
> +       if (!fh_len && inode)
> +               inode = NULL;
> +
> +       fanotify_encode_fh(&fee->object_fh, inode, fh_len, NULL, 0);
> +
>         *hash ^= fanotify_hash_fsid(fsid);
>
>         return &fee->fae;
> diff --git a/fs/notify/fanotify/fanotify.h b/fs/notify/fanotify/fanotify.h
> index bdf01ad4f9bf..4246a34667b5 100644
> --- a/fs/notify/fanotify/fanotify.h
> +++ b/fs/notify/fanotify/fanotify.h
> @@ -209,6 +209,9 @@ struct fanotify_error_event {
>         u32 err_count; /* Suppressed errors count */
>
>         __kernel_fsid_t fsid; /* FSID this error refers to. */
> +
> +       /* This must be the last element of the structure. */
> +       FANOTIFY_INLINE_FH(MAX_HANDLE_SZ);

Does not really have to be last but certainly doesn't hurt

Thanks,
Amir.
