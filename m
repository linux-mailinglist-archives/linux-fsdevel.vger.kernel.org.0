Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53477B488E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Sep 2019 09:52:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404548AbfIQHwZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Sep 2019 03:52:25 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:42730 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404544AbfIQHwY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Sep 2019 03:52:24 -0400
Received: by mail-io1-f65.google.com with SMTP id n197so5304128iod.9
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Sep 2019 00:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Jic4rHTv3yMtwdOu17+6UfT3+SUC7jTwi6ljBW+pvYE=;
        b=IV3dtqvSDIRWDXPjXcX06Ffl/7ljGdcE8DIosKk5L/JRHh8kzXH24Rye+VdBQibPHO
         xg1S+GArM7qvm+Fr283w2sx1nmfwITJFPnv5lIMEc69DZgNWxtaa4tA2zilqhBEkHKXc
         zp0zekRQXdYTzXqNFgWZSH8mQTgV7Bq1ZMFKg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Jic4rHTv3yMtwdOu17+6UfT3+SUC7jTwi6ljBW+pvYE=;
        b=VsuydNpiH9Jv8xhG8SSSO8umH9Mv35VUcWNJq8W5AYNkhndp4iaJc9YP5+Gi/7g9Ij
         JvgjFJGNDmL7dm6ZJ7AesgzsNDugF06j3neSEhItY9l0XwE2EniY+JQXaZFzE5mRK5JA
         oQPgdHgOn47QOkn1a379uOpp8LcKsF/g2pAKaKVKEDKTeMAMOThsKrGBmqd9sm3oJtMA
         5EroxBkCurmhYgK4musJepPV4sSIPJecJnhrOcLDcvjLqyrdSGmy1h1mD8v4aBCb5b0y
         B6iiSVHHGXGXn/fkH4jRViIhe8JO056m7fx/aBx3THBLyDcMQEGF5J4bM4taUkUbR+Dn
         VJlw==
X-Gm-Message-State: APjAAAXeYteVrz04xfW1x/0HvcISgcSTg941u0OevWO1KaigMynfhxbW
        cpccumrjJfvENfuxjZlQdR4936Lfet/NGzVdUPq/wsx7
X-Google-Smtp-Source: APXvYqwq9xhPNKB8OWh2wP8Z5AXGp8coGFe7f76p7eudxsi0rAEIGsWCQE314CRVRHw/1VuCFwiZB1UffSV7/kgP1/0=
X-Received: by 2002:a6b:bec6:: with SMTP id o189mr2094109iof.62.1568706743655;
 Tue, 17 Sep 2019 00:52:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190916235642.167583-1-khazhy@google.com> <20190916235642.167583-2-khazhy@google.com>
In-Reply-To: <20190916235642.167583-2-khazhy@google.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 17 Sep 2019 09:52:12 +0200
Message-ID: <CAJfpegtevJHaOpeaGCTmj6WMjOt-RsfMs+oJBgNTLTOJt9Je_g@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] fuse: kmemcg account fs data
To:     Khazhismel Kumykov <khazhy@google.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shakeel B <shakeelb@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 17, 2019 at 1:56 AM Khazhismel Kumykov <khazhy@google.com> wrote:
>
> account per-file, dentry, and inode data
>
> blockdev/superblock and temporary per-request data was left alone, as
> this usually isn't accounted
>
> Signed-off-by: Khazhismel Kumykov <khazhy@google.com>
> Reviewed-by: Shakeel Butt <shakeelb@google.com>
> ---
>  fs/fuse/dir.c   | 3 ++-
>  fs/fuse/file.c  | 5 +++--
>  fs/fuse/inode.c | 3 ++-
>  3 files changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
> index 58557d4817e9..d572c900bb0f 100644
> --- a/fs/fuse/dir.c
> +++ b/fs/fuse/dir.c
> @@ -279,7 +279,8 @@ static int fuse_dentry_revalidate(struct dentry *entry, unsigned int flags)
>  #if BITS_PER_LONG < 64
>  static int fuse_dentry_init(struct dentry *dentry)
>  {
> -       dentry->d_fsdata = kzalloc(sizeof(union fuse_dentry), GFP_KERNEL);
> +       dentry->d_fsdata = kzalloc(sizeof(union fuse_dentry),
> +                                  GFP_KERNEL_ACCOUNT | __GFP_RECLAIMABLE);
>
>         return dentry->d_fsdata ? 0 : -ENOMEM;
>  }
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index a2ea347c4d2c..862aff3665b5 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -63,12 +63,13 @@ struct fuse_file *fuse_file_alloc(struct fuse_conn *fc)
>  {
>         struct fuse_file *ff;
>
> -       ff = kzalloc(sizeof(struct fuse_file), GFP_KERNEL);
> +       ff = kzalloc(sizeof(struct fuse_file), GFP_KERNEL_ACCOUNT);
>         if (unlikely(!ff))
>                 return NULL;
>
>         ff->fc = fc;
> -       ff->release_args = kzalloc(sizeof(*ff->release_args), GFP_KERNEL);
> +       ff->release_args = kzalloc(sizeof(*ff->release_args),
> +                                  GFP_KERNEL_ACCOUNT);
>         if (!ff->release_args) {
>                 kfree(ff);
>                 return NULL;
> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> index 3d598a5bb5b5..6cb445bed89d 100644
> --- a/fs/fuse/inode.c
> +++ b/fs/fuse/inode.c
> @@ -66,7 +66,8 @@ static struct file_system_type fuseblk_fs_type;
>
>  struct fuse_forget_link *fuse_alloc_forget(void)
>  {
> -       return kzalloc(sizeof(struct fuse_forget_link), GFP_KERNEL);
> +       return kzalloc(sizeof(struct fuse_forget_link),
> +                      GFP_KERNEL_ACCOUNT | __GFP_RECLAIMABLE);

What does __GFP_RECLAIMBALE signify in slab allocs?

You understand that the forget_link is not reclaimable in the sense,
that it requires action (reading requests from the fuse device) from
the userspace filesystem daemon?

Thanks,
Miklos
