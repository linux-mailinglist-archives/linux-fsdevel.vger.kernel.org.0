Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D5EF36EEAA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Apr 2021 19:14:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240843AbhD2RPW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Apr 2021 13:15:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:26758 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233329AbhD2RPW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Apr 2021 13:15:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619716475;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8RXzvV9OayhG64BmNGxjD390UiscULVbN0Giy/F/zR4=;
        b=PUiGa7sBzt54uGUKOL14PkXwJWp3XWxGbo7GhGrVFQvxndGpOWq+CLrk8B5vu8fkI1Zu9G
        3a4E1Iw8K9jtkZf1Xm2xt8jVPigcJVzrLuFyCVFMjt/l2N3hwr/HJ5eF85YaMu9RSMLRco
        tal44/OQt6DS+BA5tSIqNEEd+abn22E=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-580-qf9AbUHoNeSRlaEwfvTy8g-1; Thu, 29 Apr 2021 13:14:33 -0400
X-MC-Unique: qf9AbUHoNeSRlaEwfvTy8g-1
Received: by mail-wm1-f71.google.com with SMTP id d78-20020a1c1d510000b0290132794b7801so54425wmd.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Apr 2021 10:14:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8RXzvV9OayhG64BmNGxjD390UiscULVbN0Giy/F/zR4=;
        b=ILA23sDtGuJCgrt1WUW13/+zAEdtCRM3rWSsommHyJrK1RpMUSBIyBIhSf3aLdczS6
         DT9ygAtRZweHbirJVRu1JVXStiyMrwDrirtWqTm7a+5BlguHMr3KRaS3gPs8m00VFv4F
         x2UeaghkUU1tZoWX8X1pazrJ1ovZLvSeup8X5GvExZ0MpUWgawbBu7/7W6E2gm7WYDdE
         7qkGO1V5/ttxNYDUrJZD9bmIi6AqicYPjioTRFLKeSwdoOIMdGh7tAflWHn6SoIHDHZ5
         rOxFRJpwzC6nkTjB8oTcBgdZmh2+OWLRbmzBjcp6y2O7w7TfWhgEWXFYVSmWPT1h65pg
         Fy6g==
X-Gm-Message-State: AOAM533Dh3T9sm56KniylnHrlzGY6HIWrR19sGdAsWLtW3slMdViwk4A
        qk1pSguR4Sbs49m6YQ+m2sAYbE6KuosFrRrv4Hb1obF6MtIhNiXs5blJ+/RzBba6LxHkFbEGD83
        6TgX1crusZFHPtVWtb8a1iAPJ+bsRGbKki12+lUOPFw==
X-Received: by 2002:a7b:c5c8:: with SMTP id n8mr1303766wmk.2.1619716471705;
        Thu, 29 Apr 2021 10:14:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzqqJNwW6qO+gOOYbgUVgcP4w2CGtX5ilJ2ey5tGpv23Te/nOWasO76frpbdhzHgMiUs34r0vc0+rJcpHDH1co=
X-Received: by 2002:a7b:c5c8:: with SMTP id n8mr1303722wmk.2.1619716471400;
 Thu, 29 Apr 2021 10:14:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210426220552.45413-1-junxiao.bi@oracle.com>
In-Reply-To: <20210426220552.45413-1-junxiao.bi@oracle.com>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Thu, 29 Apr 2021 19:14:20 +0200
Message-ID: <CAHc6FU62TpZTnAYd3DWFNWWPZP-6z+9JrS82t+YnU-EtFrnU0Q@mail.gmail.com>
Subject: Re: [Cluster-devel] [PATCH 1/3] fs/buffer.c: add new api to allow eof writeback
To:     Junxiao Bi <junxiao.bi@oracle.com>
Cc:     Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>,
        ocfs2-devel@oss.oracle.com,
        cluster-devel <cluster-devel@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Junxiao,

On Tue, Apr 27, 2021 at 4:44 AM Junxiao Bi <junxiao.bi@oracle.com> wrote:
> When doing truncate/fallocate for some filesytem like ocfs2, it
> will zero some pages that are out of inode size and then later
> update the inode size, so it needs this api to writeback eof
> pages.

is this in reaction to Jan's "[PATCH 0/12 v4] fs: Hole punch vs page
cache filling races" patch set [*]? It doesn't look like the kind of
patch Christoph would be happy with.

Thanks,
Andreas

[*] https://lore.kernel.org/linux-fsdevel/20210423171010.12-1-jack@suse.cz/

> Cc: <stable@vger.kernel.org>
> Signed-off-by: Junxiao Bi <junxiao.bi@oracle.com>
> ---
>  fs/buffer.c                 | 14 +++++++++++---
>  include/linux/buffer_head.h |  3 +++
>  2 files changed, 14 insertions(+), 3 deletions(-)
>
> diff --git a/fs/buffer.c b/fs/buffer.c
> index 0cb7ffd4977c..802f0bacdbde 100644
> --- a/fs/buffer.c
> +++ b/fs/buffer.c
> @@ -1709,9 +1709,9 @@ static struct buffer_head *create_page_buffers(struct page *page, struct inode *
>   * WB_SYNC_ALL, the writes are posted using REQ_SYNC; this
>   * causes the writes to be flagged as synchronous writes.
>   */
> -int __block_write_full_page(struct inode *inode, struct page *page,
> +int __block_write_full_page_eof(struct inode *inode, struct page *page,
>                         get_block_t *get_block, struct writeback_control *wbc,
> -                       bh_end_io_t *handler)
> +                       bh_end_io_t *handler, bool eof_write)
>  {
>         int err;
>         sector_t block;
> @@ -1746,7 +1746,7 @@ int __block_write_full_page(struct inode *inode, struct page *page,
>          * handle any aliases from the underlying blockdev's mapping.
>          */
>         do {
> -               if (block > last_block) {
> +               if (block > last_block && !eof_write) {
>                         /*
>                          * mapped buffers outside i_size will occur, because
>                          * this page can be outside i_size when there is a
> @@ -1871,6 +1871,14 @@ int __block_write_full_page(struct inode *inode, struct page *page,
>         unlock_page(page);
>         goto done;
>  }
> +EXPORT_SYMBOL(__block_write_full_page_eof);
> +
> +int __block_write_full_page(struct inode *inode, struct page *page,
> +                       get_block_t *get_block, struct writeback_control *wbc,
> +                       bh_end_io_t *handler)
> +{
> +       return __block_write_full_page_eof(inode, page, get_block, wbc, handler, false);
> +}
>  EXPORT_SYMBOL(__block_write_full_page);
>
>  /*
> diff --git a/include/linux/buffer_head.h b/include/linux/buffer_head.h
> index 6b47f94378c5..5da15a1ba15c 100644
> --- a/include/linux/buffer_head.h
> +++ b/include/linux/buffer_head.h
> @@ -221,6 +221,9 @@ int block_write_full_page(struct page *page, get_block_t *get_block,
>  int __block_write_full_page(struct inode *inode, struct page *page,
>                         get_block_t *get_block, struct writeback_control *wbc,
>                         bh_end_io_t *handler);
> +int __block_write_full_page_eof(struct inode *inode, struct page *page,
> +                       get_block_t *get_block, struct writeback_control *wbc,
> +                       bh_end_io_t *handler, bool eof_write);
>  int block_read_full_page(struct page*, get_block_t*);
>  int block_is_partially_uptodate(struct page *page, unsigned long from,
>                                 unsigned long count);
> --
> 2.24.3 (Apple Git-128)
>

