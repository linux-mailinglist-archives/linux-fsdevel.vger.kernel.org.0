Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D03024DE67
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Aug 2020 19:30:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728922AbgHUR3y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Aug 2020 13:29:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728073AbgHUR3m (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Aug 2020 13:29:42 -0400
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40F80C061574;
        Fri, 21 Aug 2020 10:29:42 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id y8so1199954vsq.8;
        Fri, 21 Aug 2020 10:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=smI891Q3FmbjoOIjkCuWKAVNd1ZCWF+ht5pb17V8UgE=;
        b=UCJyXfmIKgNC62T6Xdn/l7EP9RL7W+CqActf9YsyCdLnc9i3oZ828de5S1KnEBTC7j
         tWXLqKVNipQE3tSydzwTxaEZw3qWh9cP12bucoNi8POAOn750/gHLU1wgVgit2laP+q6
         UdXWF9qsHrYAfYJl0uNH0jjaMzqmpfdCvctB9LLnmpul7+qsUfRnLvlx62v5Z8pvAGeH
         d+xfFnOZo0zd5honRrNP87i6n98p5Jv9EaIQLLalz57FM+M0bK2gktTkhxfCa6sVhknm
         xD4YIvcuUCZSLrR+3jnmI0SJI9ZzwdlKX0o96vwaG9dSWnh9mTHMoDhdCJ/pfMvwvSTr
         tGYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=smI891Q3FmbjoOIjkCuWKAVNd1ZCWF+ht5pb17V8UgE=;
        b=d5WBgxj3qCrO2b7JY8ZcSDMu4+Cq7kFzQSm9h6CpmscsYBAJGTD0J1siVP1e3WMHQz
         c+pl2NQeI14pbVVGTLEJsKRalLgO5iupyRJlXyWYYoTlGddtgv8yZYavMJUyJt7yege+
         oSUC2dxPZzj3cexJmr86zLfa6aVE7ROkJnDcQBiiB9xZysmHTtOKQrB+kRvzrFHiHB2E
         JbHkMde4NAZGtZIrd5C0ePiPTr95y2766SrJPeSR2KUdAEvd5xu5XkkPch44pGNxppsj
         xw3PFyxrKIYM0dK2VId6Z8IKySTy5PBQwroiY5pu87/2QLKTyM/5oCIuNVoN+7gM2ge8
         rjfQ==
X-Gm-Message-State: AOAM532WrwQea0WlaEN0PSPFqD4qnnDOk2q9K4A6be7dX7OwvIP4H+X4
        r8pkOoCypXgRtiRDRoITUIqG11srbYcze7GSbSZHKxrmNu4=
X-Google-Smtp-Source: ABdhPJxzMzpbJ+XRrSz2W8dM9AE6lRGIiqMsSixhS2DvNwbAW4CyjdavwkcvOVbeWflT4/WWsjyw56Wwvfd+OtOQs0g=
X-Received: by 2002:a67:e40a:: with SMTP id d10mr2473468vsf.95.1598030981392;
 Fri, 21 Aug 2020 10:29:41 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1597994106.git.osandov@osandov.com> <be54e8e7658f85dd5e62627a1ad02beb7a4aeed8.1597994106.git.osandov@osandov.com>
In-Reply-To: <be54e8e7658f85dd5e62627a1ad02beb7a4aeed8.1597994106.git.osandov@osandov.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Fri, 21 Aug 2020 18:29:30 +0100
Message-ID: <CAL3q7H5s3OgdNWH-7snH0cpPb2euQKB8pJN0oeO-rdh=8LB6jA@mail.gmail.com>
Subject: Re: [PATCH 2/9] btrfs: send: avoid copying file data
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
> send_write() currently copies from the page cache to sctx->read_buf, and
> then from sctx->read_buf to sctx->send_buf. Similarly, send_hole()
> zeroes sctx->read_buf and then copies from sctx->read_buf to
> sctx->send_buf. However, if we write the TLV header manually, we can
> copy to sctx->send_buf directly and get rid of sctx->read_buf.
>
> Signed-off-by: Omar Sandoval <osandov@fb.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good, and it passed some long duration tests with both full and
incremental sends here (with and without compression, no-holes, etc).
Only one minor thing below, but it's really subjective and doesn't
make much of a difference.

Thanks.

> ---
>  fs/btrfs/send.c | 65 +++++++++++++++++++++++++++++--------------------
>  fs/btrfs/send.h |  1 -
>  2 files changed, 39 insertions(+), 27 deletions(-)
>
> diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
> index 8af5e867e4ca..e70f5ceb3261 100644
> --- a/fs/btrfs/send.c
> +++ b/fs/btrfs/send.c
> @@ -122,8 +122,6 @@ struct send_ctx {
>
>         struct file_ra_state ra;
>
> -       char *read_buf;
> -
>         /*
>          * We process inodes by their increasing order, so if before an
>          * incremental send we reverse the parent/child relationship of
> @@ -4794,7 +4792,25 @@ static int process_all_new_xattrs(struct send_ctx =
*sctx)
>         return ret;
>  }
>
> -static int fill_read_buf(struct send_ctx *sctx, u64 offset, u32 len)
> +static u64 max_send_read_size(struct send_ctx *sctx)

We could make this inline, since it's so small and trivial, and
constify the argument too.

> +{
> +       return sctx->send_max_size - SZ_16K;
> +}
> +
> +static int put_data_header(struct send_ctx *sctx, u32 len)
> +{
> +       struct btrfs_tlv_header *hdr;
> +
> +       if (sctx->send_max_size - sctx->send_size < sizeof(*hdr) + len)
> +               return -EOVERFLOW;
> +       hdr =3D (struct btrfs_tlv_header *)(sctx->send_buf + sctx->send_s=
ize);
> +       hdr->tlv_type =3D cpu_to_le16(BTRFS_SEND_A_DATA);
> +       hdr->tlv_len =3D cpu_to_le16(len);
> +       sctx->send_size +=3D sizeof(*hdr);
> +       return 0;
> +}
> +
> +static int put_file_data(struct send_ctx *sctx, u64 offset, u32 len)
>  {
>         struct btrfs_root *root =3D sctx->send_root;
>         struct btrfs_fs_info *fs_info =3D root->fs_info;
> @@ -4804,8 +4820,11 @@ static int fill_read_buf(struct send_ctx *sctx, u6=
4 offset, u32 len)
>         pgoff_t index =3D offset >> PAGE_SHIFT;
>         pgoff_t last_index;
>         unsigned pg_offset =3D offset_in_page(offset);
> -       int ret =3D 0;
> -       size_t read =3D 0;
> +       int ret;
> +
> +       ret =3D put_data_header(sctx, len);
> +       if (ret)
> +               return ret;
>
>         inode =3D btrfs_iget(fs_info->sb, sctx->cur_ino, root);
>         if (IS_ERR(inode))
> @@ -4851,14 +4870,15 @@ static int fill_read_buf(struct send_ctx *sctx, u=
64 offset, u32 len)
>                 }
>
>                 addr =3D kmap(page);
> -               memcpy(sctx->read_buf + read, addr + pg_offset, cur_len);
> +               memcpy(sctx->send_buf + sctx->send_size, addr + pg_offset=
,
> +                      cur_len);
>                 kunmap(page);
>                 unlock_page(page);
>                 put_page(page);
>                 index++;
>                 pg_offset =3D 0;
>                 len -=3D cur_len;
> -               read +=3D cur_len;
> +               sctx->send_size +=3D cur_len;
>         }
>         iput(inode);
>         return ret;
> @@ -4880,10 +4900,6 @@ static int send_write(struct send_ctx *sctx, u64 o=
ffset, u32 len)
>
>         btrfs_debug(fs_info, "send_write offset=3D%llu, len=3D%d", offset=
, len);
>
> -       ret =3D fill_read_buf(sctx, offset, len);
> -       if (ret < 0)
> -               goto out;
> -
>         ret =3D begin_cmd(sctx, BTRFS_SEND_C_WRITE);
>         if (ret < 0)
>                 goto out;
> @@ -4894,7 +4910,9 @@ static int send_write(struct send_ctx *sctx, u64 of=
fset, u32 len)
>
>         TLV_PUT_PATH(sctx, BTRFS_SEND_A_PATH, p);
>         TLV_PUT_U64(sctx, BTRFS_SEND_A_FILE_OFFSET, offset);
> -       TLV_PUT(sctx, BTRFS_SEND_A_DATA, sctx->read_buf, len);
> +       ret =3D put_file_data(sctx, offset, len);
> +       if (ret < 0)
> +               goto out;
>
>         ret =3D send_cmd(sctx);
>
> @@ -5013,8 +5031,8 @@ static int send_update_extent(struct send_ctx *sctx=
,
>  static int send_hole(struct send_ctx *sctx, u64 end)
>  {
>         struct fs_path *p =3D NULL;
> +       u64 read_size =3D max_send_read_size(sctx);
>         u64 offset =3D sctx->cur_inode_last_extent;
> -       u64 len;
>         int ret =3D 0;
>
>         /*
> @@ -5041,16 +5059,19 @@ static int send_hole(struct send_ctx *sctx, u64 e=
nd)
>         ret =3D get_cur_path(sctx, sctx->cur_ino, sctx->cur_inode_gen, p)=
;
>         if (ret < 0)
>                 goto tlv_put_failure;
> -       memset(sctx->read_buf, 0, BTRFS_SEND_READ_SIZE);
>         while (offset < end) {
> -               len =3D min_t(u64, end - offset, BTRFS_SEND_READ_SIZE);
> +               u64 len =3D min(end - offset, read_size);
>
>                 ret =3D begin_cmd(sctx, BTRFS_SEND_C_WRITE);
>                 if (ret < 0)
>                         break;
>                 TLV_PUT_PATH(sctx, BTRFS_SEND_A_PATH, p);
>                 TLV_PUT_U64(sctx, BTRFS_SEND_A_FILE_OFFSET, offset);
> -               TLV_PUT(sctx, BTRFS_SEND_A_DATA, sctx->read_buf, len);
> +               ret =3D put_data_header(sctx, len);
> +               if (ret < 0)
> +                       break;
> +               memset(sctx->send_buf + sctx->send_size, 0, len);
> +               sctx->send_size +=3D len;
>                 ret =3D send_cmd(sctx);
>                 if (ret < 0)
>                         break;
> @@ -5066,17 +5087,16 @@ static int send_extent_data(struct send_ctx *sctx=
,
>                             const u64 offset,
>                             const u64 len)
>  {
> +       u64 read_size =3D max_send_read_size(sctx);
>         u64 sent =3D 0;
>
>         if (sctx->flags & BTRFS_SEND_FLAG_NO_FILE_DATA)
>                 return send_update_extent(sctx, offset, len);
>
>         while (sent < len) {
> -               u64 size =3D len - sent;
> +               u64 size =3D min(len - sent, read_size);
>                 int ret;
>
> -               if (size > BTRFS_SEND_READ_SIZE)
> -                       size =3D BTRFS_SEND_READ_SIZE;
>                 ret =3D send_write(sctx, offset + sent, size);
>                 if (ret < 0)
>                         return ret;
> @@ -7145,12 +7165,6 @@ long btrfs_ioctl_send(struct file *mnt_file, struc=
t btrfs_ioctl_send_args *arg)
>                 goto out;
>         }
>
> -       sctx->read_buf =3D kvmalloc(BTRFS_SEND_READ_SIZE, GFP_KERNEL);
> -       if (!sctx->read_buf) {
> -               ret =3D -ENOMEM;
> -               goto out;
> -       }
> -
>         sctx->pending_dir_moves =3D RB_ROOT;
>         sctx->waiting_dir_moves =3D RB_ROOT;
>         sctx->orphan_dirs =3D RB_ROOT;
> @@ -7354,7 +7368,6 @@ long btrfs_ioctl_send(struct file *mnt_file, struct=
 btrfs_ioctl_send_args *arg)
>
>                 kvfree(sctx->clone_roots);
>                 kvfree(sctx->send_buf);
> -               kvfree(sctx->read_buf);
>
>                 name_cache_free(sctx);
>
> diff --git a/fs/btrfs/send.h b/fs/btrfs/send.h
> index ead397f7034f..de91488b7cd0 100644
> --- a/fs/btrfs/send.h
> +++ b/fs/btrfs/send.h
> @@ -13,7 +13,6 @@
>  #define BTRFS_SEND_STREAM_VERSION 1
>
>  #define BTRFS_SEND_BUF_SIZE SZ_64K
> -#define BTRFS_SEND_READ_SIZE (48 * SZ_1K)
>
>  enum btrfs_tlv_type {
>         BTRFS_TLV_U8,
> --
> 2.28.0
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
