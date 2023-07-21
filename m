Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59BCE75BDB9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jul 2023 07:22:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbjGUFWW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Jul 2023 01:22:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbjGUFWU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Jul 2023 01:22:20 -0400
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91C14B4;
        Thu, 20 Jul 2023 22:22:19 -0700 (PDT)
Received: by mail-vs1-xe2f.google.com with SMTP id ada2fe7eead31-440ad406bc8so508031137.3;
        Thu, 20 Jul 2023 22:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689916938; x=1690521738;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PUgA0BOBLvUnQGO4XUDe/mEntZbMH9oPKtQD8XsVYi8=;
        b=d8+XppcJafCOqVH33NrgT96K09WpKE2KW+PJCO9efl25W9oHVQgfYItaNLBEMkw7KT
         7mNZbyku3RGxhglXsCBnG3zQqKMNjRgWZMBGq5l/Yh0++2WQLTnC9U6Ua+iYuKfUGTDn
         c0Bw4c0MYdGX35YUtHc8cyEwVDtMIugmzr+fmEPXZhDsiW8mtn/lbc5LAH+RCP8BHS1m
         skWXKfdV6Ha5Eqdal5OnDNkCEy68JN2r6EPCp77aGn3PTJjdLVueEnsMxsuE3v9Eqhee
         SSNhz6lfsVo3rjeeud3YwCHmHcO+P8VroFe8Kz/hJJhdC5MidNes1b/jsIk8eXvIcfOM
         7jBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689916938; x=1690521738;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PUgA0BOBLvUnQGO4XUDe/mEntZbMH9oPKtQD8XsVYi8=;
        b=JUzuSssv+KrnFbghE2e5xbpJIp/4bmWl3/wj5Qc2FSvRj8zesM2Mq0OaBoime1wyWb
         5C/0RLNbP8SuXppcZ2XRNm9UfJNzhcbQJ6rYFQQMSurNMP1TcIZj6LYRbEfLsMuflZ0v
         rscl3muJyz/4HXvy7R0pQD1bip9E754eXZLNzGoA7JqJxuTgkFGQzrWzvPVEx9VenXjf
         PC//+uR3Vs3p5pVScFDWXXWQqMS41+QRrBs74UOQVOoBBkjH8UQBsvbyLhK8QUUjC/VA
         w5Tv3V2W7erwaxtvOm0CFe2jQXTAD8EzZXzZWb8rtIkk39tooS8PBk67hYGVUIOJvGsI
         sggg==
X-Gm-Message-State: ABy/qLacSPelxDWbHoyK0AOCog2z/tFURdTu3jWcI5oeBqLAz1Yb05xd
        yC7bk1k8L8repPcuWCJJG2o9/fimQWmX76dqnxU=
X-Google-Smtp-Source: APBJJlGF5Fekfx6iPEs21h77zaIvi5oibxzSNyTHhscKYQYEiIOcgLLWnqbVBjaaipCqG5UCq4MkM+7Kp/YmOCsrJIw=
X-Received: by 2002:a05:6102:50d:b0:440:d726:c8f0 with SMTP id
 l13-20020a056102050d00b00440d726c8f0mr233069vsa.17.1689916938416; Thu, 20 Jul
 2023 22:22:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230629165206.383-1-jack@suse.cz> <20230704122224.16257-27-jack@suse.cz>
In-Reply-To: <20230704122224.16257-27-jack@suse.cz>
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date:   Fri, 21 Jul 2023 14:22:00 +0900
Message-ID: <CAKFNMok9dE4MBB6J9_OLQMxJ=BC+kroFRZF5yCxaO3Njxr8eGw@mail.gmail.com>
Subject: Re: [PATCH 27/32] nilfs2: Convert to use blkdev_get_handle_by_path()
To:     Jan Kara <jack@suse.cz>
Cc:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        linux-nilfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 4, 2023 at 9:24=E2=80=AFPM Jan Kara wrote:
>
> Convert nilfs2 to use blkdev_get_handle_by_path() and initialize the
> superblock with the handle.
>
> CC: linux-nilfs@vger.kernel.org
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
>  fs/nilfs2/super.c | 21 ++++++++++++---------
>  1 file changed, 12 insertions(+), 9 deletions(-)

Acked-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>

You may revise this patch to reflect comments on the patch 1/32, but
the changes here look fine, and I have no objection to rewriting to
use bdev_handle.

Thanks,
Ryusuke Konishi




>
> diff --git a/fs/nilfs2/super.c b/fs/nilfs2/super.c
> index 0ef8c71bde8e..0aba0daa06d2 100644
> --- a/fs/nilfs2/super.c
> +++ b/fs/nilfs2/super.c
> @@ -1283,14 +1283,15 @@ static int nilfs_identify(char *data, struct nilf=
s_super_data *sd)
>
>  static int nilfs_set_bdev_super(struct super_block *s, void *data)
>  {
> -       s->s_bdev =3D data;
> +       s->s_bdev_handle =3D data;
> +       s->s_bdev =3D s->s_bdev_handle->bdev;
>         s->s_dev =3D s->s_bdev->bd_dev;
>         return 0;
>  }
>
>  static int nilfs_test_bdev_super(struct super_block *s, void *data)
>  {
> -       return (void *)s->s_bdev =3D=3D data;
> +       return s->s_bdev =3D=3D ((struct bdev_handle *)data)->bdev;
>  }
>
>  static struct dentry *
> @@ -1298,15 +1299,17 @@ nilfs_mount(struct file_system_type *fs_type, int=
 flags,
>              const char *dev_name, void *data)
>  {
>         struct nilfs_super_data sd;
> +       struct bdev_handle *bdev_handle;
>         struct super_block *s;
>         struct dentry *root_dentry;
>         int err, s_new =3D false;
>
> -       sd.bdev =3D blkdev_get_by_path(dev_name, sb_open_mode(flags), fs_=
type,
> -                                    NULL);
> -       if (IS_ERR(sd.bdev))
> -               return ERR_CAST(sd.bdev);
> +       bdev_handle =3D blkdev_get_handle_by_path(dev_name, sb_open_mode(=
flags),
> +                               fs_type, NULL);
> +       if (IS_ERR(bdev_handle))
> +               return ERR_CAST(bdev_handle);
>
> +       sd.bdev =3D bdev_handle->bdev;
>         sd.cno =3D 0;
>         sd.flags =3D flags;
>         if (nilfs_identify((char *)data, &sd)) {
> @@ -1326,7 +1329,7 @@ nilfs_mount(struct file_system_type *fs_type, int f=
lags,
>                 goto failed;
>         }
>         s =3D sget(fs_type, nilfs_test_bdev_super, nilfs_set_bdev_super, =
flags,
> -                sd.bdev);
> +                bdev_handle);
>         mutex_unlock(&sd.bdev->bd_fsfreeze_mutex);
>         if (IS_ERR(s)) {
>                 err =3D PTR_ERR(s);
> @@ -1374,7 +1377,7 @@ nilfs_mount(struct file_system_type *fs_type, int f=
lags,
>         }
>
>         if (!s_new)
> -               blkdev_put(sd.bdev, fs_type);
> +               blkdev_handle_put(bdev_handle);
>
>         return root_dentry;
>
> @@ -1383,7 +1386,7 @@ nilfs_mount(struct file_system_type *fs_type, int f=
lags,
>
>   failed:
>         if (!s_new)
> -               blkdev_put(sd.bdev, fs_type);
> +               blkdev_handle_put(bdev_handle);
>         return ERR_PTR(err);
>  }
>
> --
> 2.35.3
>
