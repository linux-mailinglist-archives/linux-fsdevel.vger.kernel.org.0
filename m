Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50DE142EAC1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Oct 2021 09:56:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236438AbhJOH64 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Oct 2021 03:58:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236437AbhJOH64 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Oct 2021 03:58:56 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24FC1C061570;
        Fri, 15 Oct 2021 00:56:50 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id d125so6754766iof.5;
        Fri, 15 Oct 2021 00:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=asgAoD7hEKzJ/qZ9adq8sS5MAkVz4meEm7kJkZ4qRQ0=;
        b=DbvTNxlFUL0liJKp8+U3zMfWOBHnbXl0UxWxAHf/tOlhMaTsgzaAgUuAT3kkePjfT+
         5Tf4VvebcpTc0qYSMIp3YYi8Sv+ORgWs72h1/jSWwhqO5nUcsUMXcijT9r9JkDEQm+El
         viWfQ11oHOmWRu5zKIO5uQ7CI3n25PLpCthK40RtxJ1QDwB8petMa0Q3tmt86XiJFkuy
         Tb3LevaNQ8fwS72mtKhvhuAZpFtEi0m1oyS5sgCQjgkksddI0kyXEEvA5aauZ0qxHgtO
         Uijw2B1U7GjGNA63Y4nXUYRy8Azzmk6Z1skcVdxVn8Inz9eCbNC0kH8jagXVIbI3PE3m
         QWgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=asgAoD7hEKzJ/qZ9adq8sS5MAkVz4meEm7kJkZ4qRQ0=;
        b=e7xlGj1jZSbH+/GkJsf+oewoC/NqncwDu1MY/hugalpUR0bolzgflUWpx7bY6lUmSW
         LMtGZGnpzLwRDND2ufIapDMRXTPcYgUocqbdK0VnFeGbIPwDpBNYw++38x+oqWjt6gX/
         ZXbA/3ZoV/Sgdq85Ir5Skx3eC8+tdPspuFa491BOvxe8un7riIly+ufj/gkfa9Gm6G2t
         p26vxCqKYEn244DLUK2lk6ei0KJ+JHMJ5gZZfg1T+i1bpcGYTdGGEqvQIT27L4DSXO2A
         pjg5/mj7+O4MRQM+TmIJA+r3+hz/nBk5bXZvRMS74OGb+ZFdAIVnWOLkklMe8s7YmQ8J
         uWsA==
X-Gm-Message-State: AOAM5307sUEouPKf6A+VcQrEvprUWPpLcpdyVNS/LlECAEQ/zK5jiX5A
        8kEOUYEtw+9Fr7m5JCrDFYuVnmEw2jg7n8YMPhc=
X-Google-Smtp-Source: ABdhPJzYO+7e40VLm5hw5NcGBzYEkTKv7xdDBCRbDcbAzMpl90wvynQegBiSUaxxtuyO2NoEMpqtiEpFm9tCSVZ5bp0=
X-Received: by 2002:a5d:9e0e:: with SMTP id h14mr2823548ioh.196.1634284609585;
 Fri, 15 Oct 2021 00:56:49 -0700 (PDT)
MIME-Version: 1.0
References: <20211014213646.1139469-1-krisman@collabora.com> <20211014213646.1139469-24-krisman@collabora.com>
In-Reply-To: <20211014213646.1139469-24-krisman@collabora.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 15 Oct 2021 10:56:38 +0300
Message-ID: <CAOQ4uxgR9jGSyGoHvDEPpSpMVHGssnkXJJ5a8HRKD6nxMyMLmA@mail.gmail.com>
Subject: Re: [PATCH v7 23/28] fanotify: Report fid info for file related file
 system errors
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     Jan Kara <jack@suse.com>, "Darrick J. Wong" <djwong@kernel.org>,
        Theodore Tso <tytso@mit.edu>,
        David Howells <dhowells@redhat.com>,
        Khazhismel Kumykov <khazhy@google.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Ext4 <linux-ext4@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Matthew Bobrowski <repnop@google.com>, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 15, 2021 at 12:39 AM Gabriel Krisman Bertazi
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
> ---
> Changes since v6:
>   - pass fsid from handle_events
> Changes since v5:
>   - Use preallocated MAX_HANDLE_SZ FH buffer
>   - Report superblock errors with a zerolength INVALID FID (jan, amir)
> ---
>  fs/notify/fanotify/fanotify.c | 15 +++++++++++++++
>  fs/notify/fanotify/fanotify.h |  8 ++++++++
>  2 files changed, 23 insertions(+)
>
> diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
> index 7032083df62a..8a60c96f5fb2 100644
> --- a/fs/notify/fanotify/fanotify.c
> +++ b/fs/notify/fanotify/fanotify.c
> @@ -611,7 +611,9 @@ static struct fanotify_event *fanotify_alloc_error_event(
>  {
>         struct fs_error_report *report =
>                         fsnotify_data_error_report(data, data_type);
> +       struct inode *inode = report->inode;
>         struct fanotify_error_event *fee;
> +       int fh_len;
>
>         if (WARN_ON(!report))
>                 return NULL;
> @@ -622,6 +624,19 @@ static struct fanotify_event *fanotify_alloc_error_event(
>
>         fee->fae.type = FANOTIFY_EVENT_TYPE_FS_ERROR;
>         fee->err_count = 1;
> +       fee->fsid = *fsid;
> +
> +       fh_len = fanotify_encode_fh_len(inode);
> +       if (WARN_ON(fh_len > MAX_HANDLE_SZ)) {

WARN_ON_ONCE please and I rather that this sanity check is moved inside
fanotify_encode_fh_len() where it will return 0 for encoding failure.

> +               /*
> +                * Fallback to reporting the error against the super
> +                * block.  It should never happen.
> +                */
> +               inode = NULL;
> +               fh_len = fanotify_encode_fh_len(NULL);
> +       }
> +
> +       fanotify_encode_fh(&fee->object_fh, inode, fh_len, NULL, 0);
>
>         *hash ^= fanotify_hash_fsid(fsid);
>
> diff --git a/fs/notify/fanotify/fanotify.h b/fs/notify/fanotify/fanotify.h
> index 2b032b79d5b0..b58400926f92 100644
> --- a/fs/notify/fanotify/fanotify.h
> +++ b/fs/notify/fanotify/fanotify.h
> @@ -202,6 +202,10 @@ struct fanotify_error_event {
>         u32 err_count; /* Suppressed errors count */
>
>         __kernel_fsid_t fsid; /* FSID this error refers to. */
> +       /* object_fh must be followed by the inline handle buffer. */
> +       struct fanotify_fh object_fh;
> +       /* Reserve space in object_fh.buf[] - access with fanotify_fh_buf() */
> +       unsigned char _inline_fh_buf[MAX_HANDLE_SZ];
>  };

This struct duplicates most of struct fanotify_fid_event.
How about:

#define FANOTIFY_ERROR_FH_LEN \
             (MAX_HANDLE_SZ - FANOTIFY_INLINE_FH_LEN)

struct fanotify_error_event {
         u32 err_count; /* Suppressed errors count */
         struct fanotify_event ffe;
         /* Reserve space in ffe.object_fh.buf[] - access with
fanotify_fh_buf() */
         unsigned char _fh_buf[FANOTIFY_ERROR_FH_LEN];
}

Or leaving out the struct padding and passing
FANOTIFY_ERROR_EVENT_SIZE as mempool object size?

#define FANOTIFY_ERROR_EVENT_SIZE \
            (sizeof(struct fanotify_error_event) + FANOTIFY_ERROR_FH_LEN)

You do not have to make this change - it is a proposal that can have
supporters and objectors, so let's wait to see what you and other reviewers
have to say.

Thanks,
Amir.
