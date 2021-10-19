Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C76C3432DEE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Oct 2021 08:12:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234152AbhJSGO6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Oct 2021 02:14:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233969AbhJSGO5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Oct 2021 02:14:57 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88D48C06161C;
        Mon, 18 Oct 2021 23:12:45 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id r134so19049294iod.11;
        Mon, 18 Oct 2021 23:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lqhzqzBkyGSAFetezScDi+vfXQP62DR1meUWJxZ7j/I=;
        b=qzdIzuEv1vYlVO4ngeZ51kz0jsNzHQbYlv2Ypi6qYePQ5gUW0nOPlD7hukXHfgA9Vh
         tbcuDjG6yGOc2zhX+jEy7eBVV1TryhAXd359TzyuLqPYnYa6ciSOhzHRXsE3xvpYjoCA
         bDtXx+b7c9NmbLSUyAlKsvaij6lU7C/xliQZd2zcHIty480OsOs697TwxM13PScRQ381
         u+oViMG9zZhKYtB8SdGG4DSJ8sA3+bjsfTAyGlewejM98/0+iwpsE2H+KavVhXv8nAdx
         H6JLINdgDmL6gRA4pQsEfC9Gmw+qTXy02kTM7J4iWd7UsjnlBF2m3vsqC6wHgVct1xtm
         lOFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lqhzqzBkyGSAFetezScDi+vfXQP62DR1meUWJxZ7j/I=;
        b=iZ51PN945XjGhrbv2p3ojIwsBFQI1w1oc4FY6Dl0w35GDHx711U+B6iAB992h7teFp
         8885puUioPC0WzxqVe/R1H9NrAapdL7B5oNsPzaZ8IITKwetzieJRJ0J3YyebMTRzjPo
         gs47Whz+NTO+Vp6DFkXMrYcaV2vJl9P3anOyI9KM8NwwADUtsKkL46nps6R7DamErZfO
         MzW6BwKGVQSmKqDYl/9Vrhx9po+KpDLAamBpfEVQR1E/TieFcxmMzhxcQwuNxajAWYNQ
         4nbz/n7h1a3IeRhgDtfcrqsyueFVnl10o1ea6FNp+m7XpdFj5/pKFNiTHTvrnhwNY9u1
         6w6Q==
X-Gm-Message-State: AOAM533BpQrHClZoX1YHJxiZEWZjfJYlyUKMCYARmpeSC5dY6eeY2vZg
        BHtc++PupHhAUqppy7C2pSoUWpS3KKkG79cvkVw=
X-Google-Smtp-Source: ABdhPJwUp6aIyX840KhoHuD0dFEGDJbklc3KpPsU9SowPntMm6zTpgOq78/neNxqjuYEmr/N04510ntQcwUioHI8a8A=
X-Received: by 2002:a02:6987:: with SMTP id e129mr2840265jac.136.1634623965022;
 Mon, 18 Oct 2021 23:12:45 -0700 (PDT)
MIME-Version: 1.0
References: <20211019000015.1666608-1-krisman@collabora.com> <20211019000015.1666608-25-krisman@collabora.com>
In-Reply-To: <20211019000015.1666608-25-krisman@collabora.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 19 Oct 2021 09:12:34 +0300
Message-ID: <CAOQ4uxha3CVzMTnvh70vXCVg8zeoS1vkQYuS2GwgqGXxzYWTRw@mail.gmail.com>
Subject: Re: [PATCH v8 24/32] fanotify: Add helpers to decide whether to
 report FID/DFID
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
> Now that there is an event that reports FID records even for a zeroed
> file handle, wrap the logic that deides whether to issue the records
> into helper functions.  This shouldn't have any impact on the code, but
> simplifies further patches.
>
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
> ---
>  fs/notify/fanotify/fanotify.h      | 13 +++++++++++++
>  fs/notify/fanotify/fanotify_user.c | 13 +++++++------
>  2 files changed, 20 insertions(+), 6 deletions(-)
>
> diff --git a/fs/notify/fanotify/fanotify.h b/fs/notify/fanotify/fanotify.h
> index a5e81d759f65..bdf01ad4f9bf 100644
> --- a/fs/notify/fanotify/fanotify.h
> +++ b/fs/notify/fanotify/fanotify.h
> @@ -265,6 +265,19 @@ static inline int fanotify_event_dir_fh_len(struct fanotify_event *event)
>         return info ? fanotify_info_dir_fh_len(info) : 0;
>  }
>
> +static inline bool fanotify_event_has_object_fh(struct fanotify_event *event)
> +{
> +       if (fanotify_event_object_fh_len(event) > 0)
> +               return true;
> +
> +       return false;

Sorry, this construct gives me a rush ;)
What's wrong with

return fanotify_event_object_fh_len(event) > 0;

> +}
> +
> +static inline bool fanotify_event_has_dir_fh(struct fanotify_event *event)
> +{
> +       return (fanotify_event_dir_fh_len(event) > 0) ? true : false;
> +}

Likewise, except '(cond) ? true : false' gives me an even more
irritating rush...

Thanks,
Amir.
