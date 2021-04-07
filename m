Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB33B3569B1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Apr 2021 12:30:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346727AbhDGKar (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Apr 2021 06:30:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346649AbhDGKak (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Apr 2021 06:30:40 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F62EC061756
        for <linux-fsdevel@vger.kernel.org>; Wed,  7 Apr 2021 03:30:31 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id p8so11404027ilm.13
        for <linux-fsdevel@vger.kernel.org>; Wed, 07 Apr 2021 03:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Mve0RiIdmT95tyXWmJ7dRzQXxzh2mzMYhh6+hE97H3s=;
        b=ffCxe3fc9coTNGfEBykz3gyn7a4H30N+J7p3DBHybhEVIUeqJeOn5plMHDI1DDoYgZ
         +CpE9OIcQgvVNcxs0xdqZGQLWcMkG1YZwepr805VFFvnF/rTeOp2288u06q51uhazhJH
         dGbl/+/acYBujNW4jrQGcnMBQ5YUORHLQirWIRysvKXLQskJhYPTFSC5yF5ciu4pfuBl
         zkkA0c4UyIKfJDz6vKjD+izhQss/UDAxKEnT4qS6aPRdb8Plm73unG6FzEKaUc7v/lLZ
         34aw+F3E2hJ1XyOoYSM4SxPQURHtDva+eyREp0cZQfqY7ndv2CPGSmV2OoNmyxqsS7t8
         IfgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Mve0RiIdmT95tyXWmJ7dRzQXxzh2mzMYhh6+hE97H3s=;
        b=P5Ezm5vUHR1YFvNfdIzJVrCiXOaM/8AIPrW0i/zWGUjW8C7NERP/pA/Z/Hkza2/3Xw
         FapK4Tg58Lcf7tG6fL2oGFxpvRpsTRumC0DuutKnzV/HTvEqjTDGUaOnx5jkNXmVYl+G
         ATgp7+/qexoBkrzfOoh+iGIj6OapIUJvpRa9Ou57WhR0rG86pmRCg9qOkOo0MR9Dusjh
         OOc/8Igkyh6iCYXcig1kxMpo3ITTMy+coHVKIhojpv/b3QXkKcZNmObhHjVhdv5w7u5N
         Ydc9waJvVcLyD6zw6d2XyeVJBLTO9zaTvevkia7oMdO/QGb/+12J2uq+Qxarw8abcCqe
         hHUA==
X-Gm-Message-State: AOAM533QgBN6icv2/FZc6bmVsGOeTJkSRgAHV89dZyyFFFBa59M8yVnr
        wpc8mTMs6XZdSgoahVxHewM+WSegp/EmcV5zUmADg95tbmE=
X-Google-Smtp-Source: ABdhPJxCYn4dJ2OBz/UUqG0CNWn1X/X8ExgfGF5CfPFdBLY5eFd/iwwfRzgmqpl5MJz8qceShD5xrRXAC/gcGXYgDsk=
X-Received: by 2002:a92:2c08:: with SMTP id t8mr2202549ile.72.1617791430937;
 Wed, 07 Apr 2021 03:30:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210407090208.876920-1-brauner@kernel.org> <20210407090208.876920-2-brauner@kernel.org>
In-Reply-To: <20210407090208.876920-2-brauner@kernel.org>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 7 Apr 2021 13:30:19 +0300
Message-ID: <CAOQ4uxijmfgbYiZ231ndRYKyrYOcgqQAz4wqZeRje7-Had22fw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] cachefiles: extend ro check to private mount
To:     Christian Brauner <brauner@kernel.org>
Cc:     David Howells <dhowells@redhat.com>, linux-cachefs@redhat.com,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Tyler Hicks <code@tyhicks.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 7, 2021 at 12:02 PM Christian Brauner <brauner@kernel.org> wrote:
>
> From: Christian Brauner <christian.brauner@ubuntu.com>
>
> So far cachefiles only verified that the superblock wasn't read-only but
> didn't check whether the mount was. This made sense when we did not use
> a private mount because the read-only state could change at any point.
>
> Now that we have a private mount and mount properties can't change
> behind our back extend the read-only check to include the vfsmount.
>
> The __mnt_is_readonly() helper will check both the mount and the
> superblock.  Note that before we checked root->d_sb and now we check
> mnt->mnt_sb but since we have a matching <vfsmount, dentry> pair here
> this is only syntactical change, not a semantic one.
>
> Here's how this works:
>
> mount -o ro --bind /var/cache/fscache/ /var/cache/fscache/
>
> systemctl start cachefilesd
>   Job for cachefilesd.service failed because the control process exited with error code.
>   See "systemctl status cachefilesd.service" and "journalctl -xe" for details.
>
> dmesg | grep CacheFiles
>   [    2.922514] CacheFiles: Loaded
>   [  272.206907] CacheFiles: Failed to register: -30
>
> errno 30
>   EROFS 30 Read-only file system
>
> Cc: David Howells <dhowells@redhat.com>
> Cc: linux-cachefs@redhat.com
> Cc: linux-fsdevel@vger.kernel.org
> Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
> ---
> /* v2 */
> patch introduced
> ---
>  fs/cachefiles/bind.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/fs/cachefiles/bind.c b/fs/cachefiles/bind.c
> index bbace3e51f52..cb8dd9ecc090 100644
> --- a/fs/cachefiles/bind.c
> +++ b/fs/cachefiles/bind.c
> @@ -141,8 +141,13 @@ static int cachefiles_daemon_add_cache(struct cachefiles_cache *cache)
>             !root->d_sb->s_op->sync_fs)
>                 goto error_unsupported;
>
> +       /*
> +        * Verify our mount and superblock aren't read-only.
> +        * Note, while our private mount is guaranteed to not change anymore
> +        * the superblock may still go read-only later.
> +        */
>         ret = -EROFS;
> -       if (sb_rdonly(root->d_sb))
> +       if (__mnt_is_readonly(cache->mnt))
>                 goto error_unsupported;
>

I suppose ovl_get_upper() and ecryptfs_mount() could use a similar fix?
I can post the ovl fix myself.

Thanks,
Amir.
