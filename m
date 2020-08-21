Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2098424DE29
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Aug 2020 19:27:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728230AbgHUR1M (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Aug 2020 13:27:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727807AbgHUR1C (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Aug 2020 13:27:02 -0400
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C799C061573;
        Fri, 21 Aug 2020 10:27:02 -0700 (PDT)
Received: by mail-vs1-xe42.google.com with SMTP id b16so868089vsl.6;
        Fri, 21 Aug 2020 10:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=ZJ/SgEY6vmZqsnENuzbboQsYNBFC3MlqyIs3liaUOz8=;
        b=Bj9wRRg+SAtCbnx135wzg9FnaNwBTJ58EScRtp5mP0abu16VpY5abDpT5pp4FW7rAQ
         9hunUys45Fc95kO3MZvknCnrk+s7/KHhteSHYQDpyYB0wVVobDkWFW/2BrKKeTlUbzVq
         Jw2or6oMghzyYyqadV1S6ftgUcWXy0F3gsGXcZQ6O8KfS/TGgpWpPdxI2WfKVbcEcmzX
         NhGiC5f3b6cM38dCqCvO4NH9QuFQias+hAzGoLZPazd5USkt5LZ1cK+y0bLqUJHPKQqN
         WMOlc2w5jxIOkINcQ9cBhJsX6VzjwJ1RG5fbhb7Xk8jrwnOMbmn24bDJKWJ67xHRDCUH
         iCqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=ZJ/SgEY6vmZqsnENuzbboQsYNBFC3MlqyIs3liaUOz8=;
        b=micMsIuOf+KTKHi4MGjEJBt914qwStFXtOg/29zAO8TYm0NEIlmnDwiLVVPtpf8Xit
         ctGg9m0faojrupEGdJKHV0MX7QNBVG9Pw7IygPZvb1+507WShGDodTm3gJ0SDhG9e/0m
         jYV0wKU9Zx7zGmFZM7uVAgUvg7Fy1jGq7aA+6d1ZoHL3QQOd06cVyMnIltppLc6VDkkq
         3Zj5JG3ndKkg8qEZl3Nn+tUOem9vdrLkfxeLNFz7ndvezfBKbzcmrTzAdoixeddu4A9q
         pGmr2OLd0oR0bCchipRW5t9m6qWnGOJKSoFSR/LaSNj+9bcCCmAziLrOVRZ8Sf4uC+Bu
         e53Q==
X-Gm-Message-State: AOAM532z1YCVI0KL8xzErBI37SlMv9fc9GZufVwGTDkCwITN9zm7/iTh
        dbyszYHMTTFLG2N7Imea7zXOmCMWxNRSNaC7dmYbF6Vg
X-Google-Smtp-Source: ABdhPJz0Pt0psYREaz5GhuMS21n5We/1CfqmYgv9fuo64R0BNMnEBfjOZnwffpQgSNcFQIB8eGSbX1Lf7MCt/qp4rXY=
X-Received: by 2002:a67:3015:: with SMTP id w21mr2359672vsw.99.1598030821256;
 Fri, 21 Aug 2020 10:27:01 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1597994106.git.osandov@osandov.com> <16f28691ff66e8aeb280532cc146c8ee49d6cda4.1597994106.git.osandov@osandov.com>
In-Reply-To: <16f28691ff66e8aeb280532cc146c8ee49d6cda4.1597994106.git.osandov@osandov.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Fri, 21 Aug 2020 18:26:50 +0100
Message-ID: <CAL3q7H70xhsW5pK5pzu2mUfmcUhzRUoWd5RTFMEX_-ut5HALpQ@mail.gmail.com>
Subject: Re: [PATCH 1/9] btrfs: send: get rid of i_size logic in send_write()
To:     Omar Sandoval <osandov@osandov.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 21, 2020 at 8:42 AM Omar Sandoval <osandov@osandov.com> wrote:
>
> From: Omar Sandoval <osandov@fb.com>
>
> send_write()/fill_read_buf() have some logic for avoiding reading past
> i_size. However, everywhere that we call
> send_write()/send_extent_data(), we've already clamped the length down
> to i_size. Get rid of the i_size handling, which simplifies the next
> change.
>
> Signed-off-by: Omar Sandoval <osandov@fb.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good, and it passed some long duration tests with both full and
incremental sends here (with and without compression, no-holes, etc).

Thanks.

> ---
>  fs/btrfs/send.c | 37 ++++++++++---------------------------
>  1 file changed, 10 insertions(+), 27 deletions(-)
>
> diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
> index 7c7c09fc65e8..8af5e867e4ca 100644
> --- a/fs/btrfs/send.c
> +++ b/fs/btrfs/send.c
> @@ -4794,7 +4794,7 @@ static int process_all_new_xattrs(struct send_ctx *=
sctx)
>         return ret;
>  }
>
> -static ssize_t fill_read_buf(struct send_ctx *sctx, u64 offset, u32 len)
> +static int fill_read_buf(struct send_ctx *sctx, u64 offset, u32 len)
>  {
>         struct btrfs_root *root =3D sctx->send_root;
>         struct btrfs_fs_info *fs_info =3D root->fs_info;
> @@ -4804,21 +4804,13 @@ static ssize_t fill_read_buf(struct send_ctx *sct=
x, u64 offset, u32 len)
>         pgoff_t index =3D offset >> PAGE_SHIFT;
>         pgoff_t last_index;
>         unsigned pg_offset =3D offset_in_page(offset);
> -       ssize_t ret =3D 0;
> +       int ret =3D 0;
> +       size_t read =3D 0;
>
>         inode =3D btrfs_iget(fs_info->sb, sctx->cur_ino, root);
>         if (IS_ERR(inode))
>                 return PTR_ERR(inode);
>
> -       if (offset + len > i_size_read(inode)) {
> -               if (offset > i_size_read(inode))
> -                       len =3D 0;
> -               else
> -                       len =3D offset - i_size_read(inode);
> -       }
> -       if (len =3D=3D 0)
> -               goto out;
> -
>         last_index =3D (offset + len - 1) >> PAGE_SHIFT;
>
>         /* initial readahead */
> @@ -4859,16 +4851,15 @@ static ssize_t fill_read_buf(struct send_ctx *sct=
x, u64 offset, u32 len)
>                 }
>
>                 addr =3D kmap(page);
> -               memcpy(sctx->read_buf + ret, addr + pg_offset, cur_len);
> +               memcpy(sctx->read_buf + read, addr + pg_offset, cur_len);
>                 kunmap(page);
>                 unlock_page(page);
>                 put_page(page);
>                 index++;
>                 pg_offset =3D 0;
>                 len -=3D cur_len;
> -               ret +=3D cur_len;
> +               read +=3D cur_len;
>         }
> -out:
>         iput(inode);
>         return ret;
>  }
> @@ -4882,7 +4873,6 @@ static int send_write(struct send_ctx *sctx, u64 of=
fset, u32 len)
>         struct btrfs_fs_info *fs_info =3D sctx->send_root->fs_info;
>         int ret =3D 0;
>         struct fs_path *p;
> -       ssize_t num_read =3D 0;
>
>         p =3D fs_path_alloc();
>         if (!p)
> @@ -4890,12 +4880,9 @@ static int send_write(struct send_ctx *sctx, u64 o=
ffset, u32 len)
>
>         btrfs_debug(fs_info, "send_write offset=3D%llu, len=3D%d", offset=
, len);
>
> -       num_read =3D fill_read_buf(sctx, offset, len);
> -       if (num_read <=3D 0) {
> -               if (num_read < 0)
> -                       ret =3D num_read;
> +       ret =3D fill_read_buf(sctx, offset, len);
> +       if (ret < 0)
>                 goto out;
> -       }
>
>         ret =3D begin_cmd(sctx, BTRFS_SEND_C_WRITE);
>         if (ret < 0)
> @@ -4907,16 +4894,14 @@ static int send_write(struct send_ctx *sctx, u64 =
offset, u32 len)
>
>         TLV_PUT_PATH(sctx, BTRFS_SEND_A_PATH, p);
>         TLV_PUT_U64(sctx, BTRFS_SEND_A_FILE_OFFSET, offset);
> -       TLV_PUT(sctx, BTRFS_SEND_A_DATA, sctx->read_buf, num_read);
> +       TLV_PUT(sctx, BTRFS_SEND_A_DATA, sctx->read_buf, len);
>
>         ret =3D send_cmd(sctx);
>
>  tlv_put_failure:
>  out:
>         fs_path_free(p);
> -       if (ret < 0)
> -               return ret;
> -       return num_read;
> +       return ret;
>  }
>
>  /*
> @@ -5095,9 +5080,7 @@ static int send_extent_data(struct send_ctx *sctx,
>                 ret =3D send_write(sctx, offset + sent, size);
>                 if (ret < 0)
>                         return ret;
> -               if (!ret)
> -                       break;
> -               sent +=3D ret;
> +               sent +=3D size;
>         }
>         return 0;
>  }
> --
> 2.28.0
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
