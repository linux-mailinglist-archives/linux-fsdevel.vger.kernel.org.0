Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12C622530E3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Aug 2020 16:07:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730457AbgHZOG7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Aug 2020 10:06:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730520AbgHZOGs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Aug 2020 10:06:48 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C42AC061574
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Aug 2020 07:06:47 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id u1so1855729edi.4
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Aug 2020 07:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bbCLf44tPL1VrlVQnBs/m6YE6IztZziG+eT5Zyluack=;
        b=polHhTbcNjoCuNN1KrxuhlDQ0QcWTRAikyJHtiLpMSWO5H17yll+2WDhRmV4fHo2Vt
         m0iiDSDziYMrorpT5PtWXPQtBp6b1kv5ADoY7vwK50KBCe3DMkTW+bzqZOkanWk+eZ1n
         xJjzF4uRaJp9o2Lz930ice6NsswOkB/Xs3HGQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bbCLf44tPL1VrlVQnBs/m6YE6IztZziG+eT5Zyluack=;
        b=YDQP5VoIk28u93NWQVq0Zk6cZNsOEykbNiwvTPv/HGJjlVLWnrt/58+esDAy5DFmag
         PCsbuBl/rVuX6LAXz78Pe/W+NybriXW4LZbpOPGgaQaoITM462aTD/V3ZdgazVQKZUDU
         TOYAS9kB32oAesI/sLL2F7mZ22nCkCV8TG6p5sF5sWV4fsIufqm9yY/mbmbFF3QLOiLq
         z5DgCUGxsTKehQr+nA3l2DVQOixyLYbfkwoJd4EUnJ35/bths1AA7k0HwAdTHS6upxfG
         rlONvqO7B/Le5PnI2RqsUfxchJAKjSy2s1UkSl4tXpjVsZBCpvot1gCnWhcprkAZMQ5P
         98gw==
X-Gm-Message-State: AOAM532XK9KoSR9mcbNtV9KLY735fBvz4TXp1UnEin+qPfRVR6ApKEsI
        MXM6BqSknN+k8UwzQG+4u7+hOj5Yk6tl480fDq4Ox7vrCY2ZJQ==
X-Google-Smtp-Source: ABdhPJw6epfkcpeJl9n7M3qW9BBciR5eiiqlaFhec2flVUht2YGYESwiDUbkjooxqvde4jWdkbN4D2QRt1VCOWkx4xw=
X-Received: by 2002:a50:fe17:: with SMTP id f23mr13515936edt.364.1598450806237;
 Wed, 26 Aug 2020 07:06:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200819221956.845195-1-vgoyal@redhat.com> <20200819221956.845195-12-vgoyal@redhat.com>
In-Reply-To: <20200819221956.845195-12-vgoyal@redhat.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 26 Aug 2020 16:06:35 +0200
Message-ID: <CAJfpegsgHE0MkZLFgE4yrZXO5ThDxCj85-PjizrXPRC2CceT1g@mail.gmail.com>
Subject: Re: [PATCH v3 11/18] fuse: implement FUSE_INIT map_alignment field
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        virtio-fs-list <virtio-fs@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 20, 2020 at 12:21 AM Vivek Goyal <vgoyal@redhat.com> wrote:
>
> The device communicates FUSE_SETUPMAPPING/FUSE_REMOVMAPPING alignment
> constraints via the FUST_INIT map_alignment field.  Parse this field and
> ensure our DAX mappings meet the alignment constraints.
>
> We don't actually align anything differently since our mappings are
> already 2MB aligned.  Just check the value when the connection is
> established.  If it becomes necessary to honor arbitrary alignments in
> the future we'll have to adjust how mappings are sized.
>
> The upshot of this commit is that we can be confident that mappings will
> work even when emulating x86 on Power and similar combinations where the
> host page sizes are different.
>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> ---
>  fs/fuse/fuse_i.h          |  5 ++++-
>  fs/fuse/inode.c           | 18 ++++++++++++++++--
>  include/uapi/linux/fuse.h |  4 +++-
>  3 files changed, 23 insertions(+), 4 deletions(-)
>
> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> index 478c940b05b4..4a46e35222c7 100644
> --- a/fs/fuse/fuse_i.h
> +++ b/fs/fuse/fuse_i.h
> @@ -47,7 +47,10 @@
>  /** Number of dentries for each connection in the control filesystem */
>  #define FUSE_CTL_NUM_DENTRIES 5
>
> -/* Default memory range size, 2MB */
> +/*
> + * Default memory range size.  A power of 2 so it agrees with common FUSE_INIT
> + * map_alignment values 4KB and 64KB.
> + */
>  #define FUSE_DAX_SZ    (2*1024*1024)
>  #define FUSE_DAX_SHIFT (21)
>  #define FUSE_DAX_PAGES (FUSE_DAX_SZ/PAGE_SIZE)
> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> index b82eb61d63cc..947abdd776ca 100644
> --- a/fs/fuse/inode.c
> +++ b/fs/fuse/inode.c
> @@ -980,9 +980,10 @@ static void process_init_reply(struct fuse_conn *fc, struct fuse_args *args,
>  {
>         struct fuse_init_args *ia = container_of(args, typeof(*ia), args);
>         struct fuse_init_out *arg = &ia->out;
> +       bool ok = true;
>
>         if (error || arg->major != FUSE_KERNEL_VERSION)
> -               fc->conn_error = 1;
> +               ok = false;
>         else {
>                 unsigned long ra_pages;
>
> @@ -1045,6 +1046,13 @@ static void process_init_reply(struct fuse_conn *fc, struct fuse_args *args,
>                                         min_t(unsigned int, FUSE_MAX_MAX_PAGES,
>                                         max_t(unsigned int, arg->max_pages, 1));
>                         }
> +                       if ((arg->flags & FUSE_MAP_ALIGNMENT) &&
> +                           (FUSE_DAX_SZ % (1ul << arg->map_alignment))) {

This just obfuscates "arg->map_alignment != FUSE_DAX_SHIFT".

So the intention was that userspace can ask the kernel for a
particular alignment, right?

In that case kernel can definitely succeed if the requested alignment
is smaller than the kernel provided one, no?    It would also make
sense to make this a two way negotiation.  I.e. send the largest
alignment (FUSE_DAX_SHIFT in this implementation) that the kernel can
provide in fuse_init_in.   In that case the only error would be if
userspace ignored the given constraints.

Am I getting not getting something?

> +                               pr_err("FUSE: map_alignment %u incompatible"
> +                                      " with dax mem range size %u\n",
> +                                      arg->map_alignment, FUSE_DAX_SZ);
> +                               ok = false;
> +                       }
>                 } else {
>                         ra_pages = fc->max_read / PAGE_SIZE;
>                         fc->no_lock = 1;
> @@ -1060,6 +1068,11 @@ static void process_init_reply(struct fuse_conn *fc, struct fuse_args *args,
>         }
>         kfree(ia);
>
> +       if (!ok) {
> +               fc->conn_init = 0;
> +               fc->conn_error = 1;
> +       }
> +
>         fuse_set_initialized(fc);
>         wake_up_all(&fc->blocked_waitq);
>  }
> @@ -1082,7 +1095,8 @@ void fuse_send_init(struct fuse_conn *fc)
>                 FUSE_WRITEBACK_CACHE | FUSE_NO_OPEN_SUPPORT |
>                 FUSE_PARALLEL_DIROPS | FUSE_HANDLE_KILLPRIV | FUSE_POSIX_ACL |
>                 FUSE_ABORT_ERROR | FUSE_MAX_PAGES | FUSE_CACHE_SYMLINKS |
> -               FUSE_NO_OPENDIR_SUPPORT | FUSE_EXPLICIT_INVAL_DATA;
> +               FUSE_NO_OPENDIR_SUPPORT | FUSE_EXPLICIT_INVAL_DATA |
> +               FUSE_MAP_ALIGNMENT;
>         ia->args.opcode = FUSE_INIT;
>         ia->args.in_numargs = 1;
>         ia->args.in_args[0].size = sizeof(ia->in);
> diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
> index 373cada89815..5b85819e045f 100644
> --- a/include/uapi/linux/fuse.h
> +++ b/include/uapi/linux/fuse.h
> @@ -313,7 +313,9 @@ struct fuse_file_lock {
>   * FUSE_CACHE_SYMLINKS: cache READLINK responses
>   * FUSE_NO_OPENDIR_SUPPORT: kernel supports zero-message opendir
>   * FUSE_EXPLICIT_INVAL_DATA: only invalidate cached pages on explicit request
> - * FUSE_MAP_ALIGNMENT: map_alignment field is valid
> + * FUSE_MAP_ALIGNMENT: init_out.map_alignment contains log2(byte alignment) for
> + *                    foffset and moffset fields in struct
> + *                    fuse_setupmapping_out and fuse_removemapping_one.

fuse_setupmapping_in

Thanks,
Miklos
