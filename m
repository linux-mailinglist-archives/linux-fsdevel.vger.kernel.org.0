Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E54B098867
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2019 02:17:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728042AbfHVAR0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Aug 2019 20:17:26 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:32983 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727629AbfHVAR0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Aug 2019 20:17:26 -0400
Received: by mail-yw1-f68.google.com with SMTP id e65so1695550ywh.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Aug 2019 17:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ulFbNzA9b5vRVN6/SZzhpTQBctv6NDxyo6JV6dAYMZI=;
        b=arq4xCxeNbVzw1mj9oaCKvl7JTiIF99/NsrNSN+AnMEyM0a/Xfg9vhQv0BvOqpWpe/
         v3tA64zDckl5lhF90Woh7EfD80UCUDCUEkwHgJdQ+pgFlUTEMuywha9octggJ/sq9T5Y
         BW0hphWaaZLycOGI8NXBkBcqchnfncBPqVisO4hct/IOUJeJzhUN+rFzeKfW8Pz+ppmK
         PFAFiA/jizlGE0vBh8SKextDcb6FTDqYsYmTawuXiPYSyxmEOMOlGVhwsUcKMPM2e4/A
         DQA9FatJIVjx3ZWptpeZUDKwSqY/MY/d2t3JV0ySCIdBuqC1sXmOflg4USbr6TCSBC8P
         m/qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ulFbNzA9b5vRVN6/SZzhpTQBctv6NDxyo6JV6dAYMZI=;
        b=en+dj21K9kLHKXuHyBSTsURpH5nYAcSn2XbRMOy5XXd/cWe71+HByMWAbqC88/tUxW
         jUe04Joa/vYim5QI68ao58lndqvMKn5BxYpsYQyy/t/AsIeQ6l/c8kehyxUznBqhxupN
         o9V5zpy/tGbN57M4Mxo7ZYTjBnYeeVNQ8a47EorEoyIuKSitjipbLcsfS50LVKvY9Ix8
         ZS3ODxKGOt04kPMJBzH/OJOXI0z/2lllvJM/gkg589RuHokiW+i1olgWoYlyJkScZMLq
         dzRSqAIH/XiXBWF6F2yB05yMSmoszUG7sn7AMV9ed/9dgQA1A3b8Df4+MJRP+OV8qwYI
         /QsA==
X-Gm-Message-State: APjAAAU7j/ZYx/MAjo7u7F2G8hKqgZqIHvtfa06CUOh04fW8vPHta1zb
        xCUjTsWKEHMELtud97wsgSdNEmJdHqha/DDJKbCkJA==
X-Google-Smtp-Source: APXvYqxx4Ps49Zdl5TE5I7hU6AIZpEVV3CyqprwPfgkXjdI6SdjvtAetbjni64AXIBGuff4VhHRJBdFvRBwd2sZ2ER0=
X-Received: by 2002:a81:a448:: with SMTP id b69mr25417748ywh.4.1566433045475;
 Wed, 21 Aug 2019 17:17:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190822000933.180870-1-khazhy@google.com>
In-Reply-To: <20190822000933.180870-1-khazhy@google.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 21 Aug 2019 17:17:14 -0700
Message-ID: <CALvZod44CHWEUxa4Mi7nRLfgyCnGgNAxso8SLA5xVoR=DdQiWw@mail.gmail.com>
Subject: Re: [PATCH 1/3] fuse: on 64-bit store time in d_fsdata directly
To:     Khazhismel Kumykov <khazhy@google.com>
Cc:     miklos@szeredi.hu, linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 21, 2019 at 5:09 PM Khazhismel Kumykov <khazhy@google.com> wrote:
>
> Implements the optimization noted in f75fdf22b0a8 ("fuse: don't use
> ->d_time"), as the additional memory can be significant. (In particular,
> on SLAB configurations this 8-byte alloc becomes 32 bytes). Per-dentry,
> this can consume significant memory.
>
> Signed-off-by: Khazhismel Kumykov <khazhy@google.com>

Actually we are seeing this in production where a job creating a lot
of fuse files cause a lot of extra system level overhead.

Reviewed-by: Shakeel Butt <shakeelb@google.com>

> ---
>  fs/fuse/dir.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>
> diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
> index dd0f64f7bc06..f9c59a296568 100644
> --- a/fs/fuse/dir.c
> +++ b/fs/fuse/dir.c
> @@ -24,6 +24,18 @@ static void fuse_advise_use_readdirplus(struct inode *dir)
>         set_bit(FUSE_I_ADVISE_RDPLUS, &fi->state);
>  }
>
> +#if BITS_PER_LONG >= 64
> +static inline void fuse_dentry_settime(struct dentry *entry, u64 time)
> +{
> +       entry->d_fsdata = (void *) time;
> +}
> +
> +static inline u64 fuse_dentry_time(struct dentry *entry)
> +{
> +       return (u64)entry->d_fsdata;
> +}
> +
> +#else
>  union fuse_dentry {
>         u64 time;
>         struct rcu_head rcu;
> @@ -38,6 +50,7 @@ static inline u64 fuse_dentry_time(struct dentry *entry)
>  {
>         return ((union fuse_dentry *) entry->d_fsdata)->time;
>  }
> +#endif
>
>  /*
>   * FUSE caches dentries and attributes with separate timeout.  The
> @@ -242,6 +255,7 @@ static int fuse_dentry_revalidate(struct dentry *entry, unsigned int flags)
>         goto out;
>  }
>
> +#if BITS_PER_LONG < 64
>  static int fuse_dentry_init(struct dentry *dentry)
>  {
>         dentry->d_fsdata = kzalloc(sizeof(union fuse_dentry), GFP_KERNEL);
> @@ -254,16 +268,21 @@ static void fuse_dentry_release(struct dentry *dentry)
>
>         kfree_rcu(fd, rcu);
>  }
> +#endif
>
>  const struct dentry_operations fuse_dentry_operations = {
>         .d_revalidate   = fuse_dentry_revalidate,
> +#if BITS_PER_LONG < 64
>         .d_init         = fuse_dentry_init,
>         .d_release      = fuse_dentry_release,
> +#endif
>  };
>
>  const struct dentry_operations fuse_root_dentry_operations = {
> +#if BITS_PER_LONG < 64
>         .d_init         = fuse_dentry_init,
>         .d_release      = fuse_dentry_release,
> +#endif
>  };
>
>  int fuse_valid_type(int m)
> --
> 2.23.0.187.g17f5b7556c-goog
>
