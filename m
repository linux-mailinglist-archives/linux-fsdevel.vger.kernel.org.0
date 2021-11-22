Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28FA04589F4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Nov 2021 08:41:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235975AbhKVHoR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Nov 2021 02:44:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232870AbhKVHoQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Nov 2021 02:44:16 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9041C061574;
        Sun, 21 Nov 2021 23:41:10 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id f9so21917956ioo.11;
        Sun, 21 Nov 2021 23:41:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EgK3Fxmt2Ep/12cKLL6aWGBCcDYN8BbadOm8B5KUg8E=;
        b=Oklkv7AgYAiXeDSbCLqFfwB1huhraxdAJZfZ5WjKYwXiTSqAK9bWfVy/HLCAJUQswM
         F6JvDDh51VfwJpvOgEN333Wqcli0rVQDggh5FcCrdBC49J7PswDOZQa14QEuRG2Adjj+
         U78QVmNrh1lm/9s8PZakdnenBtmNERGsTjt4eMfd2tZeAb5cPI/heuYDrbwj7wZjm9YY
         A9bZCGffPphun2+TbuUoBGJa37IGJ1NgVNCFowOIjPSPePkrAGGqL/7C2oUyY5AcUUbI
         Adc5pHvGG70GlB7Ouo7ZE0R4UF8ZcNOtEd/H8jvOwMz7p4Yy2J82Uu931gxrSW3gtHwL
         GKdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EgK3Fxmt2Ep/12cKLL6aWGBCcDYN8BbadOm8B5KUg8E=;
        b=nw94UApv5LGdnoRZ2ZD7P5bREv4iEZ5D64L3HHt3zijH1W/wu8mWta7eqEf1RcZYmH
         DcaigWKV1lUXdxIyl59vtcEFM+XvHL2bgygRPQgmIPH5/PMM/Fm5FbfAKDn2f1JWbpsH
         s6tq2OnWY1tlClvZbLJ1DBEmRjBbmElfIp2o5M9KZSvGRUGJJXs1NidxqrBWXVBRFNjE
         KfVduuhscY/bUS94941ZyJTIKjxyt5VpZyP/RebehADU0tmJGJZjvg+R5Kf5U/JvxNVo
         2MwaDQjPHB0Fz5PZiNgzGPBQFa0POUOwrN5D9uYoz2I5dJPVYhpvnky3vs0hsUcds+76
         PIaw==
X-Gm-Message-State: AOAM532ypr8J+Q8Rc67waNF4C4jR3wusYeAswdOwcPC1OWWTAJl9BydQ
        JNRxoUFvkMGyxOi+M/AwSHdKhj2uy7Kp6puyyNFJRTKhW6k=
X-Google-Smtp-Source: ABdhPJzzsjZNvfLzBRWCOI9wZkvYKWyX2dOOoZsNa7F089FqnSUQcaYN0/9aN2OVkz/DGXsQgjyVqsOAUowqlpCVPOw=
X-Received: by 2002:a05:6602:26d0:: with SMTP id g16mr1885952ioo.70.1637566870216;
 Sun, 21 Nov 2021 23:41:10 -0800 (PST)
MIME-Version: 1.0
References: <20211122030038.1938875-1-cgxu519@mykernel.net> <20211122030038.1938875-8-cgxu519@mykernel.net>
In-Reply-To: <20211122030038.1938875-8-cgxu519@mykernel.net>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 22 Nov 2021 09:40:59 +0200
Message-ID: <CAOQ4uxhrg=MAL7sArmP47oyF_QmhG-1b=srs30VNdiT-9s-P0w@mail.gmail.com>
Subject: Re: [RFC PATCH V6 7/7] ovl: implement containerized syncfs for overlayfs
To:     Chengguang Xu <cgxu519@mykernel.net>
Cc:     Miklos Szeredi <miklos@szeredi.hu>, Jan Kara <jack@suse.cz>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Chengguang Xu <charliecgxu@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 22, 2021 at 5:01 AM Chengguang Xu <cgxu519@mykernel.net> wrote:
>
> From: Chengguang Xu <charliecgxu@tencent.com>
>
> Now overlayfs can only sync own dirty inodes during syncfs,
> so remove unnecessary sync_filesystem() on upper file system.
>
> Signed-off-by: Chengguang Xu <charliecgxu@tencent.com>
> ---
>  fs/overlayfs/super.c | 14 +++++---------
>  1 file changed, 5 insertions(+), 9 deletions(-)
>
> diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
> index ccffcd96491d..213b795a6a86 100644
> --- a/fs/overlayfs/super.c
> +++ b/fs/overlayfs/super.c
> @@ -292,18 +292,14 @@ static int ovl_sync_fs(struct super_block *sb, int wait)
>         /*
>          * Not called for sync(2) call or an emergency sync (SB_I_SKIP_SYNC).
>          * All the super blocks will be iterated, including upper_sb.
> -        *
> -        * If this is a syncfs(2) call, then we do need to call
> -        * sync_filesystem() on upper_sb, but enough if we do it when being
> -        * called with wait == 1.
>          */
> -       if (!wait)
> -               return 0;
> -
>         upper_sb = ovl_upper_mnt(ofs)->mnt_sb;
> -
>         down_read(&upper_sb->s_umount);
> -       ret = sync_filesystem(upper_sb);
> +       if (wait)
> +               wait_sb_inodes(upper_sb);
> +       if (upper_sb->s_op->sync_fs)
> +               upper_sb->s_op->sync_fs(upper_sb, wait);
> +       ret = ovl_sync_upper_blockdev(upper_sb, wait);

I think it will be cleaner to use a helper ovl_sync_upper_filesystem()
with everything from  upper_sb = ... and a comment to explain that
this is a variant of __sync_filesystem() where all the dirty inodes write
have already been started.

Thanks,
Amir.

P.S. I like this "stoopid proof" v6 because I can understand it ;-)
