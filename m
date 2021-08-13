Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4A903EB21C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Aug 2021 10:00:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239523AbhHMIAc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Aug 2021 04:00:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234844AbhHMIAb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Aug 2021 04:00:31 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A441C061756;
        Fri, 13 Aug 2021 01:00:05 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id k3so9939616ilu.2;
        Fri, 13 Aug 2021 01:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M81MoqGpPkvhEhozDSmYgBewMgKBobvD8HDiesRhbLk=;
        b=qP7/MVR3O62sq72JuRyuJh+BKIss3XdUgxJhKGj2k08hR5tdtv+Uprjoo9vx7D/uin
         bemZXzpItxbVeathA2ZzkKgGn/1/v4yywnt+DxXMqGM2iqY1dijsJS3lfe9g1YNdZujk
         X+8cFps4Bgz1tZjgnSYhC3ysITJG3hGpdfzyuAnItgB0TcvrU0n8tpyUBM04Y4XKHmUz
         umr9erizDd+hQl7YFdSoIAEcDyqv0A/JKyaijRg6E1l8/oFBYFMqogIn1Yhbp14db/tH
         E6+Py2rGsDJViRQSmaZ/5KQU9/tQfYYG7ip7RY2F8VShvduIhpsm6Inc38OkDGrN3/Ht
         mopQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M81MoqGpPkvhEhozDSmYgBewMgKBobvD8HDiesRhbLk=;
        b=OyXqCjNGEG9aDbFiN5dwnVyhhbTZdQQclc+zsPxLzSlf+DiwYOdqdapQZjF4E7O0RS
         uCyPa/54Rd5VoEKFa8NhaJQR+XdLCYChK/JnLUXDRMNkbbSbe+oqlgWNpbndeD81WGu+
         dbonThijocNXaA/RX2CFNdK8VK7fcjQQOreuj0/LNMVT5u8pUSJ2USVsHssW0u5TWRmx
         4WY/w0Ug4xhO/MWuUy6hvAnVWHBvsA6ujnzPluirYZYXM/q2d0DM0cJ6GmAF6ywFmpMS
         j/O3x4spO0Sv6WrnGpMCa/NUUxhcJTxoWfAjAuyNZWilEmoZ+LJ5JfzXdTgEfjfXkZlv
         U0Dg==
X-Gm-Message-State: AOAM530CgbIp8dDjwqlzZC2BkA3u479yBrcLJPCwydk3JTm9PhDnvHd7
        AS7P/WA44DhwbrFIf3NmR9VrQR24Jmq+TzREt3U=
X-Google-Smtp-Source: ABdhPJwAsqlRgSJQ4jCyBJhtn4Rsi8qL2Gxtu5swXXARTyOHIpYjRSH48G42xlNCovEIYsLXuiKwbYogtGcCbDW+L6c=
X-Received: by 2002:a92:8702:: with SMTP id m2mr987312ild.250.1628841605007;
 Fri, 13 Aug 2021 01:00:05 -0700 (PDT)
MIME-Version: 1.0
References: <20210812214010.3197279-1-krisman@collabora.com> <20210812214010.3197279-12-krisman@collabora.com>
In-Reply-To: <20210812214010.3197279-12-krisman@collabora.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 13 Aug 2021 10:59:52 +0300
Message-ID: <CAOQ4uxiDQ+=gwFQPsa_F-A85rQ9d1wi9-fg+L6mTUv6tPZ93xg@mail.gmail.com>
Subject: Re: [PATCH v6 11/21] fanotify: Allow file handle encoding for
 unhashed events
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
> FAN_FS_ERROR will report a file handle, but it is an unhashed event.
> Allow passing a NULL hash to fanotify_encode_fh and avoid calculating
> the hash if not needed.
>
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
> Reviewed-by: Jan Kara <jack@suse.cz>

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

> ---
>  fs/notify/fanotify/fanotify.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
> index acf78c0ed219..50fce4fec0d6 100644
> --- a/fs/notify/fanotify/fanotify.c
> +++ b/fs/notify/fanotify/fanotify.c
> @@ -403,8 +403,12 @@ static int fanotify_encode_fh(struct fanotify_fh *fh, struct inode *inode,
>         fh->type = type;
>         fh->len = fh_len;
>
> -       /* Mix fh into event merge key */
> -       *hash ^= fanotify_hash_fh(fh);
> +       /*
> +        * Mix fh into event merge key.  Hash might be NULL in case of
> +        * unhashed FID events (i.e. FAN_FS_ERROR).
> +        */
> +       if (hash)
> +               *hash ^= fanotify_hash_fh(fh);
>
>         return FANOTIFY_FH_HDR_LEN + fh_len;
>
> --
> 2.32.0
>
