Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E323640487C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Sep 2021 12:31:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233963AbhIIKcR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Sep 2021 06:32:17 -0400
Received: from mail-ed1-f49.google.com ([209.85.208.49]:42960 "EHLO
        mail-ed1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234057AbhIIKcQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Sep 2021 06:32:16 -0400
Received: by mail-ed1-f49.google.com with SMTP id z19so1964088edi.9;
        Thu, 09 Sep 2021 03:31:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+PPfPZ/vyA7kRm7LtesplHagTfP12DiHosfGgqo5nmM=;
        b=zOXk0Kfra5W2OMCIU0Npx3j7u5w6ztPkB7e9nEQSuxE1+cp/Fc+zcq+seWSwcEc8U5
         r8XBwVxXX4fE0JvsgzwZd58r82QOsZ4iHoS8LrsiXaL0giUc4zid1ZNDThTrWLJohHoe
         3/U3QvgbaDQc1yNS/aQbUIkpSB+N8p7LrciNKKmRF/i/8BjV3tZ6Ys14vOSfW9AGPV/Z
         xrhRvSmi7SnyM2MJOXAPv0EDnWVvjezPp7AwYka7ATpYJoV6fEKMPTW/tCA84pPl8q/A
         nXvsjaPgJ2X3eLpsdLA01XlCUOT9QT22+DKRxXbFGByVhWo9IICs74BWPPmMhLGgA1NK
         cbvg==
X-Gm-Message-State: AOAM530a2emNXOTyYZCG+gOT3rD66ZTotR5vJEdgOQZb6KrwL9DB/33B
        PkdYixg/MizrVTrN1YZLYYVtev2A7ZFSDQ==
X-Google-Smtp-Source: ABdhPJyZ3S9XJPToGy6BASZaXAZ/t9vu9z8Rq/Ga5BGZs7N32f3wa/XKr1j0P6YR1uIze1YTFqFwQw==
X-Received: by 2002:a05:6402:1913:: with SMTP id e19mr2443428edz.9.1631183466499;
        Thu, 09 Sep 2021 03:31:06 -0700 (PDT)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com. [209.85.221.51])
        by smtp.gmail.com with ESMTPSA id o12sm834389edv.19.2021.09.09.03.31.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Sep 2021 03:31:06 -0700 (PDT)
Received: by mail-wr1-f51.google.com with SMTP id d6so1803105wrc.11;
        Thu, 09 Sep 2021 03:31:06 -0700 (PDT)
X-Received: by 2002:adf:e349:: with SMTP id n9mr2715415wrj.326.1631183466040;
 Thu, 09 Sep 2021 03:31:06 -0700 (PDT)
MIME-Version: 1.0
References: <163113612442.352844.11162345591911691150.stgit@warthog.procyon.org.uk>
In-Reply-To: <163113612442.352844.11162345591911691150.stgit@warthog.procyon.org.uk>
From:   Marc Dionne <marc.dionne@auristor.com>
Date:   Thu, 9 Sep 2021 07:30:50 -0300
X-Gmail-Original-Message-ID: <CAB9dFdvVcdfxkRZ36Z-V4_tcMws01xZ=UNTmjqTuqYvW_7-X_Q@mail.gmail.com>
Message-ID: <CAB9dFdvVcdfxkRZ36Z-V4_tcMws01xZ=UNTmjqTuqYvW_7-X_Q@mail.gmail.com>
Subject: Re: [PATCH] afs: Fix updating of i_blocks on file/dir extension
To:     David Howells <dhowells@redhat.com>
Cc:     Markus Suvanto <markus.suvanto@gmail.com>,
        linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 8, 2021 at 6:22 PM David Howells <dhowells@redhat.com> wrote:
>
> When an afs file or directory is modified locally such that the total file
> size is extended, i_blocks needs to be recalculated too.
>
> Fix this by making afs_write_end() and afs_edit_dir_add() call
> afs_set_i_size() rather than setting inode->i_size directly as that also
> recalculates inode->i_blocks.
>
> This can be tested by creating and writing into directories and files and
> then examining them with du.  Without this change, directories show a 4
> blocks (they start out at 2048 bytes) and files show 0 blocks; with this
> change, they should show a number of blocks proportional to the file size
> rounded up to 1024.
>
> Fixes: 31143d5d515ece617ffccb7df5ff75e4d1dfa120 ("AFS: implement basic file write support")
> Fixes: 63a4681ff39c ("afs: Locally edit directory data for mkdir/create/unlink/...")
> Reported-by: Markus Suvanto <markus.suvanto@gmail.com>
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: linux-afs@lists.infradead.org
> ---
>
>  fs/afs/dir_edit.c |    4 ++--
>  fs/afs/inode.c    |   10 ----------
>  fs/afs/internal.h |   10 ++++++++++
>  fs/afs/write.c    |    2 +-
>  4 files changed, 13 insertions(+), 13 deletions(-)
>
> diff --git a/fs/afs/dir_edit.c b/fs/afs/dir_edit.c
> index f4600c1353ad..540b9fc96824 100644
> --- a/fs/afs/dir_edit.c
> +++ b/fs/afs/dir_edit.c
> @@ -263,7 +263,7 @@ void afs_edit_dir_add(struct afs_vnode *vnode,
>                 if (b == nr_blocks) {
>                         _debug("init %u", b);
>                         afs_edit_init_block(meta, block, b);
> -                       i_size_write(&vnode->vfs_inode, (b + 1) * AFS_DIR_BLOCK_SIZE);
> +                       afs_set_i_size(vnode, (b + 1) * AFS_DIR_BLOCK_SIZE);
>                 }
>
>                 /* Only lower dir pages have a counter in the header. */
> @@ -296,7 +296,7 @@ void afs_edit_dir_add(struct afs_vnode *vnode,
>  new_directory:
>         afs_edit_init_block(meta, meta, 0);
>         i_size = AFS_DIR_BLOCK_SIZE;
> -       i_size_write(&vnode->vfs_inode, i_size);
> +       afs_set_i_size(vnode, i_size);
>         slot = AFS_DIR_RESV_BLOCKS0;
>         page = page0;
>         block = meta;
> diff --git a/fs/afs/inode.c b/fs/afs/inode.c
> index 126daf9969db..8fcffea2daf5 100644
> --- a/fs/afs/inode.c
> +++ b/fs/afs/inode.c
> @@ -53,16 +53,6 @@ static noinline void dump_vnode(struct afs_vnode *vnode, struct afs_vnode *paren
>                 dump_stack();
>  }
>
> -/*
> - * Set the file size and block count.  Estimate the number of 512 bytes blocks
> - * used, rounded up to nearest 1K for consistency with other AFS clients.
> - */
> -static void afs_set_i_size(struct afs_vnode *vnode, u64 size)
> -{
> -       i_size_write(&vnode->vfs_inode, size);
> -       vnode->vfs_inode.i_blocks = ((size + 1023) >> 10) << 1;
> -}
> -
>  /*
>   * Initialise an inode from the vnode status.
>   */
> diff --git a/fs/afs/internal.h b/fs/afs/internal.h
> index c97618855b46..12b2bdae6d1a 100644
> --- a/fs/afs/internal.h
> +++ b/fs/afs/internal.h
> @@ -1595,6 +1595,16 @@ static inline void afs_update_dentry_version(struct afs_operation *op,
>                         (void *)(unsigned long)dir_vp->scb.status.data_version;
>  }
>
> +/*
> + * Set the file size and block count.  Estimate the number of 512 bytes blocks
> + * used, rounded up to nearest 1K for consistency with other AFS clients.
> + */
> +static inline void afs_set_i_size(struct afs_vnode *vnode, u64 size)
> +{
> +       i_size_write(&vnode->vfs_inode, size);
> +       vnode->vfs_inode.i_blocks = ((size + 1023) >> 10) << 1;
> +}
> +
>  /*
>   * Check for a conflicting operation on a directory that we just unlinked from.
>   * If someone managed to sneak a link or an unlink in on the file we just
> diff --git a/fs/afs/write.c b/fs/afs/write.c
> index 32a764c24284..2dfe3b3a53d6 100644
> --- a/fs/afs/write.c
> +++ b/fs/afs/write.c
> @@ -137,7 +137,7 @@ int afs_write_end(struct file *file, struct address_space *mapping,
>                 write_seqlock(&vnode->cb_lock);
>                 i_size = i_size_read(&vnode->vfs_inode);
>                 if (maybe_i_size > i_size)
> -                       i_size_write(&vnode->vfs_inode, maybe_i_size);
> +                       afs_set_i_size(vnode, maybe_i_size);
>                 write_sequnlock(&vnode->cb_lock);
>         }
>
>
>
>
> _______________________________________________
> linux-afs mailing list
> http://lists.infradead.org/mailman/listinfo/linux-afs

Reviewed-by: Marc Dionne <marc.dionne@auristor.com>

Marc
