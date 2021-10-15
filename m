Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D399342E8A5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Oct 2021 08:03:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231703AbhJOGFF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Oct 2021 02:05:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbhJOGFE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Oct 2021 02:05:04 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A0D0C061570;
        Thu, 14 Oct 2021 23:02:58 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id s3so6099959ild.0;
        Thu, 14 Oct 2021 23:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8/S51zX4pr2QU+J9qft8HmXq8g/X9xnf7JRaBK+P4tU=;
        b=HfrAZKguB+raI1O2TivEjBgSqziGJGdG3VnAhvQizw/RB3JxOnzLcfiuJEoxzJm8k0
         qjYv5Bh4W7fC5nGfXowWhnWO81e0IaaDyW/3AbcddWoe7rhy91VHE04inlDJw+nv6/9Y
         dnv8cvMZDyyyAobFQ81fXBgIkZktx4iDyml3yXO/A5iUQdACYAqK2TMiFmFt/VUOZYL7
         A6yvEl9O0IL8QSLtqVboRdZY7r9sd5T5IRa0kq0Xgnh91wMcPzXhqrnlrFXtyKOLRHDq
         xm/CRnK1SMxPZu3Q0sODpaLNBhsllYGczfIH7gW42WuqggIL9G81jDM0195k9/jpMOGP
         6TFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8/S51zX4pr2QU+J9qft8HmXq8g/X9xnf7JRaBK+P4tU=;
        b=u7c51z8CcTZvwdDBLR59aR2GFS4GHofH+SDcRrCSYgudVQqO19zDTUAnx6I+ilgNrt
         J0J5CWbMjny/3VRq9uOCcfolV/gnCLRKtjxNaa/BFRLGj46YReGZqnLT6bPARfhLX8LL
         Y8xD47/85wR7QlNKBSv2MrDIf0mmdkQsqMgdJAMiL3nzqSj8pH0uKdiwjZROs+JkRyLd
         +mijdYZoNNHDjx4deH04xpXV0+CrxjNIRRpKLsBiI4FMd6eQoa2Ed8CkgkxPBKfMvfTy
         cmA9D5hPon+05YiQlb36iBE9V98ZRBsTAW+osXc0tnd0EFVHUqk4sCDLjMvHa4zF8Iwf
         H0Yg==
X-Gm-Message-State: AOAM530tzLiZtxTYa7TiKKktgQFHc5QH4sZQAPEoaEE5vEbzhjy+dKCI
        Lvgjf4PxjL21QMo5Ee3lJG5cdetgba4965WviTU=
X-Google-Smtp-Source: ABdhPJzKnDZl9q7NBKNTceUm8C3nYVhOS6rE27aET4YcQTNuf1TDZ0FIuaNF8MAo0XjJ7pIpSNJb7+RNDNps3xD6EaM=
X-Received: by 2002:a05:6e02:1be8:: with SMTP id y8mr2522282ilv.24.1634277777880;
 Thu, 14 Oct 2021 23:02:57 -0700 (PDT)
MIME-Version: 1.0
References: <20211014213646.1139469-1-krisman@collabora.com> <20211014213646.1139469-15-krisman@collabora.com>
In-Reply-To: <20211014213646.1139469-15-krisman@collabora.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 15 Oct 2021 09:02:47 +0300
Message-ID: <CAOQ4uxh48S+A+BbnY-oDeEVYzFOtK_RJzq04xH8aLp1d1ep-Ng@mail.gmail.com>
Subject: Re: [PATCH v7 14/28] fanotify: Encode empty file handle when no inode
 is provided
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

On Fri, Oct 15, 2021 at 12:38 AM Gabriel Krisman Bertazi
<krisman@collabora.com> wrote:
>
> Instead of failing, encode an invalid file handle in fanotify_encode_fh
> if no inode is provided.  This bogus file handle will be reported by
> FAN_FS_ERROR for non-inode errors.
>
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
Reviewed-by: Amir Goldstein <amir73il@gmail.com>

>
> ---
> Changes since v6:
>   - Use FILEID_ROOT as the internal value (jan)
>   - Create an empty FH (jan)
>
> Changes since v5:
>   - Preserve flags initialization (jan)
>   - Add BUILD_BUG_ON (amir)
>   - Require minimum of FANOTIFY_NULL_FH_LEN for fh_len(amir)
>   - Improve comment to explain the null FH length (jan)
>   - Simplify logic
> ---
>  fs/notify/fanotify/fanotify.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
> index ec84fee7ad01..c64d61b673ca 100644
> --- a/fs/notify/fanotify/fanotify.c
> +++ b/fs/notify/fanotify/fanotify.c
> @@ -370,8 +370,14 @@ static int fanotify_encode_fh(struct fanotify_fh *fh, struct inode *inode,
>         fh->type = FILEID_ROOT;
>         fh->len = 0;
>         fh->flags = 0;
> +
> +       /*
> +        * Invalid FHs are used by FAN_FS_ERROR for errors not
> +        * linked to any inode. The f_handle won't be reported
> +        * back to userspace.
> +        */
>         if (!inode)
> -               return 0;
> +               goto out;
>
>         /*
>          * !gpf means preallocated variable size fh, but fh_len could
> @@ -403,6 +409,7 @@ static int fanotify_encode_fh(struct fanotify_fh *fh, struct inode *inode,
>         fh->type = type;
>         fh->len = fh_len;
>
> +out:
>         /*
>          * Mix fh into event merge key.  Hash might be NULL in case of
>          * unhashed FID events (i.e. FAN_FS_ERROR).
> --
> 2.33.0
>
