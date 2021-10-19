Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A41C432DAC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Oct 2021 08:03:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234020AbhJSGFT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Oct 2021 02:05:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233790AbhJSGFS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Oct 2021 02:05:18 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23DD5C06161C;
        Mon, 18 Oct 2021 23:03:06 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id i189so19096927ioa.1;
        Mon, 18 Oct 2021 23:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sjjZIJpTUkT1xmsfXR+ZEc/F2dOVUZrERJVvNocXmpk=;
        b=emeA/axyycmOCXtwHTQoEvOE73qU2BxUQ8ub46QZey94ak1GuxgP5lQn+KWM1JcRY9
         5i5R+bOkn8KVdZGjSz4XIi7s6oeivWT+BfEz5ZcoXHZ+kCVY2rNDQr9Ldcm11k8cXglh
         lKmVZ3bfuKYnmxCzvi+vbZw39kIs3wV5yPiKN7DDPXZt70xwOAY/lp8VZt2iEDvv/fW/
         fQM+WD8GOUMeUZCaBZgRORX1Xyw1rs3+adn6bFj+XBh3YOEo2t2vfAcjf58ubn1r37dc
         Y7HqV01H/fzubIjFUvhGqKpHTJ7m8wYeBbBj3cly9tgubLmtOqYGPvQpkXq9Rpj1ERbp
         ixiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sjjZIJpTUkT1xmsfXR+ZEc/F2dOVUZrERJVvNocXmpk=;
        b=fD5ys5ddnw7C3wobA+zHqeXB7JOlwqpjCg/yenh6xuK1ot6i0Wm0QkBm76nKoyaMJ/
         Zyzw/5OFe0JexiXrTr9y+wwFuRM4BhrwdELQjutaKNAADliCCAozgwd3+iEf57HZ1OLX
         uCjdsTaZhPjbITmZ9GhVZifHPfiZY1o653PM3js7TuaxtePnxDpzTHwiWfaC26Y6EHhU
         5Cxjq+xDyJRvViZqhuGTToNWDYoqPav4HnUcyn8A/0R+zq9eEOGMYUYNhwI2VxoK02zq
         ReywZQhuhGvvcw9SMY7o5SzgYTsfMRTD48KAqi9VHjDXPJVb6e01GxTEgu26gnXTRr5F
         RgMg==
X-Gm-Message-State: AOAM530DDYZjRnzj09wcKaByuhWBH0IVveHgM4sziN7QbOFgeOZnltu9
        Yc4hRaI9LmmgDU3MWagP0j4WtghGEQv83F+5nJ4=
X-Google-Smtp-Source: ABdhPJyXUwckFMrWrkOOVCHl1xtQPJFjEQv8anpRDpCvvGrR0O53oNROAAD9zxc7peDExrhWkWYHLb2zDUjtJrQJtMM=
X-Received: by 2002:a05:6602:26d2:: with SMTP id g18mr16990031ioo.70.1634623385512;
 Mon, 18 Oct 2021 23:03:05 -0700 (PDT)
MIME-Version: 1.0
References: <20211019000015.1666608-1-krisman@collabora.com> <20211019000015.1666608-27-krisman@collabora.com>
In-Reply-To: <20211019000015.1666608-27-krisman@collabora.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 19 Oct 2021 09:02:54 +0300
Message-ID: <CAOQ4uxhQBm3=eVOmcQkvR3AvbdzUAuP1cH6EFrB8YJRQL8WU_g@mail.gmail.com>
Subject: Re: [PATCH v8 26/32] fanotify: WARN_ON against too large file handles
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
> struct fanotify_error_event, at least, is preallocated and isn't able to
> to handle arbitrarily large file handles.  Future-proof the code by
> complaining loudly if a handle larger than MAX_HANDLE_SZ is ever found.
>
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
Reviewed-by: Amir Goldstein <amir73il@gmail.com>

> ---
>  fs/notify/fanotify/fanotify.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
> index cedcb1546804..45df610debbe 100644
> --- a/fs/notify/fanotify/fanotify.c
> +++ b/fs/notify/fanotify/fanotify.c
> @@ -360,13 +360,23 @@ static u32 fanotify_group_event_mask(struct fsnotify_group *group,
>  static int fanotify_encode_fh_len(struct inode *inode)
>  {
>         int dwords = 0;
> +       int fh_len;
>
>         if (!inode)
>                 return 0;
>
>         exportfs_encode_inode_fh(inode, NULL, &dwords, NULL);
> +       fh_len = dwords << 2;
>
> -       return dwords << 2;
> +       /*
> +        * struct fanotify_error_event might be preallocated and is
> +        * limited to MAX_HANDLE_SZ.  This should never happen, but
> +        * safeguard by forcing an invalid file handle.
> +        */
> +       if (WARN_ON_ONCE(fh_len > MAX_HANDLE_SZ))
> +               return 0;
> +
> +       return fh_len;
>  }
>
>  /*
> --
> 2.33.0
>
