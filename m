Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 982FC71265C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 May 2023 14:13:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231378AbjEZMNW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 May 2023 08:13:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231270AbjEZMNV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 May 2023 08:13:21 -0400
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com [IPv6:2607:f8b0:4864:20::935])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7C2B128;
        Fri, 26 May 2023 05:13:18 -0700 (PDT)
Received: by mail-ua1-x935.google.com with SMTP id a1e0cc1a2514c-783fc329e72so184746241.3;
        Fri, 26 May 2023 05:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685103198; x=1687695198;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tcRKotHm11Cr8qUj3/GWYcYV61NEa/MLisov9OVu4ms=;
        b=qNJVBcO0pgHk1FtxZZZInxG5XdghYq7HW2ekZSNyUQKTTieVyOCgSQa5g6QfgxAXWF
         iIs7lRqeZCDwFbkve3kKHr9GsFUj+d35A5TRs7wO415HxBqGDGT95xEufzLk/Sa1RXGk
         lB7Wrb+zVHQ10S32Geo1slxl2hH6pKR3lJ4CD5uFKCeVSnzlcY3bWA+tnKor4r/5U5g3
         BE93yg4DE21BXoVnRKhW/JbF37e3FVKkdGs/LhFb6lx2FqFEPKXvR6IAYjCQn8XcEpVV
         uyUeEcnXATJBcn5bk4BW/Mrr6TxBU05movLQG5wkaep6Un+LO0pXOwrLpOCvqf7Tgynv
         Ihsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685103198; x=1687695198;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tcRKotHm11Cr8qUj3/GWYcYV61NEa/MLisov9OVu4ms=;
        b=Y8/MgVUgZnXAOj5ApFIYN5x29kEGHJg7mbcUNlRqkUlRxV2Es13Ki8ZUr+6Za5bDGn
         xkMn1qBVGhZwdxmAELFUQ8L9kzDium2wUl1fS2HNOxmiH0iAjVPZYeplkM/3UvyLKRMr
         HUBjDHe6t9diTSEyEfum1aVmXrCu8P9x6gxhzZgoDd8Mv5xZ+SyZpg2bTGU9xqsL3Fbt
         VIWCjuR2cXQ1sCCGvVUV7+h1N/j5J6ZVBUiED+HeY52uvu1/1gZ+6HSAMXt5XHZ5CpE6
         ZuYvRzGdslfKR75lFwlzjJ2xQSQJvUbRc/LI7dK3uHS4db8f5IFMCjBSJKogrNA/3cJ3
         XVhg==
X-Gm-Message-State: AC+VfDyb6LPwu2s9DGuxBNDii8A9KP9iXHDcL6ry2ZSCy8RpOdao5pAj
        ElOFXEjca6mKtzhtWtzFhWepa3ZM9n/PXZOad6c=
X-Google-Smtp-Source: ACHHUZ65ecGR6Dzg9pcCYcUOIL+cztRir6Po2LaPk6wm4K318CXvLnjQsqidAmmm+l52h3OiA8iZpjdjHa+3MI8cCXs=
X-Received: by 2002:a67:f554:0:b0:439:40d7:c66f with SMTP id
 z20-20020a67f554000000b0043940d7c66fmr346571vsn.14.1685103197744; Fri, 26 May
 2023 05:13:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230525100654.15069-1-jack@suse.cz> <20230525101624.15814-6-jack@suse.cz>
In-Reply-To: <20230525101624.15814-6-jack@suse.cz>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 26 May 2023 15:13:06 +0300
Message-ID: <CAOQ4uxhL0w+yqg2u_xW6r4J_gJX=_zoZjo3vh0ONqAbgxm2VTA@mail.gmail.com>
Subject: Re: [PATCH 6/6] fs: Restrict lock_two_nondirectories() to
 non-directory inodes
To:     Jan Kara <jack@suse.cz>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        "Darrick J. Wong" <djwong@kernel.org>, Ted Tso <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 25, 2023 at 1:17=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> Currently lock_two_nondirectories() is skipping any passed directories.
> After vfs_rename() uses lock_two_inodes(), all the remaining four users
> of this function pass only regular files to it. So drop the somewhat
> unusual "skip directory" logic and instead warn if anybody passes
> directory to it. This also allows us to use lock_two_inodes() in
> lock_two_nondirectories() to concentrate the lock ordering logic in less
> places.
>
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
>  fs/inode.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
>
> diff --git a/fs/inode.c b/fs/inode.c
> index 2015fa50d34a..accf5125a049 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -1140,7 +1140,7 @@ void lock_two_inodes(struct inode *inode1, struct i=
node *inode2,
>  /**
>   * lock_two_nondirectories - take two i_mutexes on non-directory objects
>   *
> - * Lock any non-NULL argument that is not a directory.
> + * Lock any non-NULL argument. Passed objects must not be directories.
>   * Zero, one or two objects may be locked by this function.
>   *
>   * @inode1: first inode to lock
> @@ -1148,13 +1148,9 @@ void lock_two_inodes(struct inode *inode1, struct =
inode *inode2,
>   */
>  void lock_two_nondirectories(struct inode *inode1, struct inode *inode2)
>  {
> -       if (inode1 > inode2)
> -               swap(inode1, inode2);
> -
> -       if (inode1 && !S_ISDIR(inode1->i_mode))
> -               inode_lock(inode1);
> -       if (inode2 && !S_ISDIR(inode2->i_mode) && inode2 !=3D inode1)
> -               inode_lock_nested(inode2, I_MUTEX_NONDIR2);
> +       WARN_ON_ONCE(S_ISDIR(inode1->i_mode));
> +       WARN_ON_ONCE(S_ISDIR(inode2->i_mode));
> +       lock_two_inodes(inode1, inode2, I_MUTEX_NORMAL, I_MUTEX_NONDIR2);
>  }
>  EXPORT_SYMBOL(lock_two_nondirectories);
>

Need the same treatment to unlock_two_nondirectories() because now if
someone does pass a directory they will get a warning but also a leaked loc=
k.

Thanks,
Amir.
