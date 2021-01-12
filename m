Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A9052F3236
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Jan 2021 14:52:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727845AbhALNwE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Jan 2021 08:52:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728132AbhALNwD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Jan 2021 08:52:03 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D83DC06179F
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Jan 2021 05:51:23 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id r5so2345156eda.12
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Jan 2021 05:51:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gR76E+hgdNRlJHpowh3xLAsehspUfAyQ4NgaYNaNiqI=;
        b=XSibZhFRvJZDohRMzV6+t73OXFgW6De8K3ufGffee+z31Ye2gR/Ilr01EgaJEmnlwL
         ZvpXtsqyg8hZMyFXUvtYWyDBrbSkBOoa/mJuQYQckbFEHWup5ZBxuA+Obs8dgGlQiShn
         S6y1oYFJWXDD7jtkLOY1+PBoYoXaeZ5uiAlEpqgxA1hulebf1LeMSebaZhUw9qisGPUI
         QYJK+AwC9hk98Qoo4vzmGHmHXJGf7fsEopq1aWLfeL7PD3vZu3ESJrxjWxrMYf+PcEIv
         tJtfkw6iOT2EwqRpB2ydI4SuETItMfTbuVYTLDoae0FS+uCpP1GKxTdwIlVT163ocGk6
         72fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gR76E+hgdNRlJHpowh3xLAsehspUfAyQ4NgaYNaNiqI=;
        b=jXU9hji30ofVwqb47SKWPZIMEQjJLNE/A/CnugJ4faxhgR5jQZH5J1gLMnIfkxxAZD
         gMJfJHHlKDke5wA+QEWfxUDuv75XUZNxA8Zf4A9cTid935gPa7i5Awx9PM+enbEtwsQO
         CkkYhjFwadbfwMdzO6rFxBXPE9bHnyrtS1rxAVjZl72gbuHQnjBb3l5WcCaTFS3e1TT+
         Jog7cYVHjqDS0GF2I0bv8AsG37r2orrLHaIy0javpBPwa32+0YGVBazJ9kDh1d7u1FBH
         XNn/G/Q/QGzKCD5+kT5GwMmlhayoh8Jn0a5InnEym6emoul+xXRHPUdoozhtbMS1futU
         ERhA==
X-Gm-Message-State: AOAM530CTAdjj2UT/mT6iv7KELShj35dBxXCWazp2ATK/mzQasusVlLg
        nIBvBCn+qcVmNm/DId72I5RXKe6677HpNflG7Ptx
X-Google-Smtp-Source: ABdhPJx605NSGp4j1uinNyJCwVFX1VMEUon54nemEZnMArRth7X4vUuuw5rSwz7bOLn+xqkTJxC/1/vEaRcM7/ExqxM=
X-Received: by 2002:aa7:cd63:: with SMTP id ca3mr3528729edb.164.1610459481682;
 Tue, 12 Jan 2021 05:51:21 -0800 (PST)
MIME-Version: 1.0
References: <20201118102342.154277-1-omosnace@redhat.com>
In-Reply-To: <20201118102342.154277-1-omosnace@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 12 Jan 2021 08:51:10 -0500
Message-ID: <CAHC9VhQWbiqi_C-iw7i=qiz8gSikW6LM-EufNsPjs-pU3ABHcg@mail.gmail.com>
Subject: Re: [PATCH] vfs: fix fsconfig(2) LSM mount option handling for btrfs
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>, linux-btrfs@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Richard Haines <richard_c_haines@btinternet.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 18, 2020 at 5:23 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> When SELinux security options are passed to btrfs via fsconfig(2) rather
> than via mount(2), the operation aborts with an error. What happens is
> roughly this sequence:
>
> 1. vfs_parse_fs_param() eats away the LSM options and parses them into
>    fc->security.
> 2. legacy_get_tree() finds nothing in ctx->legacy_data, passes this
>    nothing to btrfs.
> [here btrfs calls another layer of vfs_kern_mount(), but let's ignore
>  that for simplicity]
> 3. btrfs calls security_sb_set_mnt_opts() with empty options.
> 4. vfs_get_tree() then calls its own security_sb_set_mnt_opts() with the
>    options stashed in fc->security.
> 5. SELinux doesn't like that different options were used for the same
>    superblock and returns -EINVAL.
>
> In the case of mount(2), the options are parsed by
> legacy_parse_monolithic(), which skips the eating away of security
> opts because of the FS_BINARY_MOUNTDATA flag, so they are passed to the
> FS via ctx->legacy_data. The second call to security_sb_set_mnt_opts()
> (from vfs_get_tree()) now passes empty opts, but the non-empty -> empty
> sequence is allowed by SELinux for the FS_BINARY_MOUNTDATA case.
>
> It is a total mess, but the only sane fix for now seems to be to skip
> processing the security opts in vfs_parse_fs_param() if the fc has
> legacy opts set AND the fs specfies the FS_BINARY_MOUNTDATA flag. This
> combination currently matches only btrfs and coda. For btrfs this fixes
> the fsconfig(2) behavior, and for coda it makes setting security opts
> via fsconfig(2) fail the same way as it would with mount(2) (because
> FS_BINARY_MOUNTDATA filesystems are expected to call the mount opts LSM
> hooks themselves, but coda never cared enough to do that). I believe
> that is an acceptable state until both filesystems (or at least btrfs)
> are converted to the new mount API (at which point btrfs won't need to
> pretend it takes binary mount data any more and also won't need to call
> the LSM hooks itself, assuming it will pass the fc->security information
> properly).
>
> Note that we can't skip LSM opts handling in vfs_parse_fs_param() solely
> based on FS_BINARY_MOUNTDATA because that would break NFS.
>
> See here for the original report and reproducer:
> https://lore.kernel.org/selinux/c02674c970fa292610402aa866c4068772d9ad4e.camel@btinternet.com/
>
> Reported-by: Richard Haines <richard_c_haines@btinternet.com>
> Fixes: 3e1aeb00e6d1 ("vfs: Implement a filesystem superblock creation/configuration context")
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>  fs/fs_context.c | 28 ++++++++++++++++++++++------
>  1 file changed, 22 insertions(+), 6 deletions(-)

What do the VFS folks think about this patch?  It has been sitting for
a couple of months now without any real comment and it would be nice
to get some initial feedback on this as it fixes a real problem.

> diff --git a/fs/fs_context.c b/fs/fs_context.c
> index 2834d1afa6e80..cfc5ee2e381ef 100644
> --- a/fs/fs_context.c
> +++ b/fs/fs_context.c
> @@ -106,12 +106,28 @@ int vfs_parse_fs_param(struct fs_context *fc, struct fs_parameter *param)
>         if (ret != -ENOPARAM)
>                 return ret;
>
> -       ret = security_fs_context_parse_param(fc, param);
> -       if (ret != -ENOPARAM)
> -               /* Param belongs to the LSM or is disallowed by the LSM; so
> -                * don't pass to the FS.
> -                */
> -               return ret;
> +       /*
> +        * In the legacy+binary mode, skip the security_fs_context_parse_param()
> +        * call and let the legacy handler process also the security options.
> +        * It will format them into the monolithic string, where the FS can
> +        * process them (with FS_BINARY_MOUNTDATA it is expected to do it).
> +        *
> +        * Currently, this matches only btrfs and coda. Coda is broken with
> +        * fsconfig(2) anyway, because it does actually take binary data. Btrfs
> +        * only *pretends* to take binary data to work around the SELinux's
> +        * no-remount-with-different-options check, so this allows it to work
> +        * with fsconfig(2) properly.
> +        *
> +        * Once btrfs is ported to the new mount API, this hack can be reverted.
> +        */
> +       if (fc->ops != &legacy_fs_context_ops || !(fc->fs_type->fs_flags & FS_BINARY_MOUNTDATA)) {
> +               ret = security_fs_context_parse_param(fc, param);
> +               if (ret != -ENOPARAM)
> +                       /* Param belongs to the LSM or is disallowed by the LSM;
> +                        * so don't pass to the FS.
> +                        */
> +                       return ret;
> +       }
>
>         if (fc->ops->parse_param) {
>                 ret = fc->ops->parse_param(fc, param);
> --
> 2.26.2

-- 
paul moore
www.paul-moore.com
