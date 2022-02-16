Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C93294B7D4F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Feb 2022 03:21:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245726AbiBPB5Y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Feb 2022 20:57:24 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243224AbiBPB5N (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Feb 2022 20:57:13 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6510674DD
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Feb 2022 17:56:58 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id i10so848430plr.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Feb 2022 17:56:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g9VpagkCm3Zq8LHRqp7Sd8KVDdtAi+2psByAzPmlH8Q=;
        b=OX5SPjLuavnTkCLr8WtH3fiuGK0vgZnKvfHC7cRdadYwiOyeALa1XWHTRabLHUZJW5
         qbWl6P2YJrGtFL9FyOWN5Q8/Iuj4eJ/9N47Bp2ZbP0qM15gEQw3Phwvn8mbuL6WndWyr
         u9bG5FiHgVL8Z8hMzXVXvb+lwGxykG0/A8P6KouONu8qckocXRqSodoctz/ma5dmgYh9
         PprRZnDuU4424cFU0gqM0O2Rz7fFjd6S2vU/MIW9y7DfnzLyWv/1Ia9n/oYnjN6CI47G
         ngOmaOL+OMF/Q/2x2MNCDRlW+elI0NF9oo9C7q3fpcbrZkmKV2eb5Q/gbnyghR6mr1xi
         sPEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g9VpagkCm3Zq8LHRqp7Sd8KVDdtAi+2psByAzPmlH8Q=;
        b=elT4j8i7Yb1dhJQ5wx4yN32yk3tCUkSV7k3pJgbRfwTBqbqjckouNV5SdAZ2iCgumV
         lNwbReQjT8jqgKcOVcvptqcRcXnLDW7Ee9a/OPPetTOQ9L5UYPc4zZurl3PEvZBNXplb
         AlNyw5yuy9vd336Q9j6a0r61dXaUi7gzjh5F+9vXOTgKmLAt6SYcIKcSWA9Ljdj0olyY
         Gr9DWJJ2heudVf3s8ACaA5dMWTACbobiMKxYTUrQnOzTqi9Kl7y7Z/iyv4/CNQrCu4ac
         wvozuLjCz1N+o2n3W5pla8TZLLC4KlpyNWc6nk2WvMb+BG0ZdnFDmPY2vNYGIugfXK1C
         6bug==
X-Gm-Message-State: AOAM532hmeJYMvmneWfVLJWq9oepL+dliq/3u4mi4SEUtetEmBL9KqMA
        /qVl2dEdMOvjPvNr2oDXqnHH3VPkx7bF9ulY66Br6w==
X-Google-Smtp-Source: ABdhPJw2yis7sUqbyWLoCMEwA+ho+yJ8iYuYSPqma/sk1aZPvQf+EuskChvI0MgRYeFBLEk/VweW6nLWdLkGdIj4/0k=
X-Received: by 2002:a17:902:f68a:b0:14f:308f:ed3b with SMTP id
 l10-20020a170902f68a00b0014f308fed3bmr304005plg.147.1644976617803; Tue, 15
 Feb 2022 17:56:57 -0800 (PST)
MIME-Version: 1.0
References: <20220127124058.1172422-1-ruansy.fnst@fujitsu.com> <20220127124058.1172422-9-ruansy.fnst@fujitsu.com>
In-Reply-To: <20220127124058.1172422-9-ruansy.fnst@fujitsu.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 15 Feb 2022 17:56:51 -0800
Message-ID: <CAPcyv4hBpHsPRXZKtHtN0hVQhjZspZBz9egO=wn+54KDJokStw@mail.gmail.com>
Subject: Re: [PATCH v10 8/9] xfs: Implement ->notify_failure() for XFS
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        Linux MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>, david <david@fromorbit.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jane Chu <jane.chu@oracle.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 27, 2022 at 4:41 AM Shiyang Ruan <ruansy.fnst@fujitsu.com> wrote:
>
> Introduce xfs_notify_failure.c to handle failure related works, such as
> implement ->notify_failure(), register/unregister dax holder in xfs, and
> so on.
>
> If the rmap feature of XFS enabled, we can query it to find files and
> metadata which are associated with the corrupt data.  For now all we do
> is kill processes with that file mapped into their address spaces, but
> future patches could actually do something about corrupt metadata.
>
> After that, the memory failure needs to notify the processes who are
> using those files.
>
> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
> ---
>  fs/xfs/Makefile             |   1 +
>  fs/xfs/xfs_buf.c            |  12 ++
>  fs/xfs/xfs_fsops.c          |   3 +
>  fs/xfs/xfs_mount.h          |   1 +
>  fs/xfs/xfs_notify_failure.c | 222 ++++++++++++++++++++++++++++++++++++
>  fs/xfs/xfs_notify_failure.h |  10 ++
>  6 files changed, 249 insertions(+)
>  create mode 100644 fs/xfs/xfs_notify_failure.c
>  create mode 100644 fs/xfs/xfs_notify_failure.h
>
> diff --git a/fs/xfs/Makefile b/fs/xfs/Makefile
> index 04611a1068b4..389970b3e13b 100644
> --- a/fs/xfs/Makefile
> +++ b/fs/xfs/Makefile
> @@ -84,6 +84,7 @@ xfs-y                         += xfs_aops.o \
>                                    xfs_message.o \
>                                    xfs_mount.o \
>                                    xfs_mru_cache.o \
> +                                  xfs_notify_failure.o \
>                                    xfs_pwork.o \
>                                    xfs_reflink.o \
>                                    xfs_stats.o \
> diff --git a/fs/xfs/xfs_buf.c b/fs/xfs/xfs_buf.c
> index b45e0d50a405..017010b3d601 100644
> --- a/fs/xfs/xfs_buf.c
> +++ b/fs/xfs/xfs_buf.c
> @@ -19,6 +19,7 @@
>  #include "xfs_errortag.h"
>  #include "xfs_error.h"
>  #include "xfs_ag.h"
> +#include "xfs_notify_failure.h"
>
>  static struct kmem_cache *xfs_buf_cache;
>
> @@ -1892,6 +1893,8 @@ xfs_free_buftarg(
>         list_lru_destroy(&btp->bt_lru);
>
>         blkdev_issue_flush(btp->bt_bdev);
> +       if (btp->bt_daxdev)
> +               dax_unregister_holder(btp->bt_daxdev);
>         fs_put_dax(btp->bt_daxdev);
>
>         kmem_free(btp);
> @@ -1946,6 +1949,15 @@ xfs_alloc_buftarg(
>         btp->bt_dev =  bdev->bd_dev;
>         btp->bt_bdev = bdev;
>         btp->bt_daxdev = fs_dax_get_by_bdev(bdev, &btp->bt_dax_part_off);
> +       if (btp->bt_daxdev) {
> +               if (dax_get_holder(btp->bt_daxdev)) {
> +                       xfs_err(mp, "DAX device already in use?!");

Per the earlier feedback this can be checked atomically inside of
dax_register_holder() with cmpxchg().

> +                       goto error_free;
> +               }
> +
> +               dax_register_holder(btp->bt_daxdev, mp,
> +                               &xfs_dax_holder_operations);
> +       }
>
>         /*
>          * Buffer IO error rate limiting. Limit it to no more than 10 messages
> diff --git a/fs/xfs/xfs_fsops.c b/fs/xfs/xfs_fsops.c
> index 33e26690a8c4..d4d36c5bef11 100644
> --- a/fs/xfs/xfs_fsops.c
> +++ b/fs/xfs/xfs_fsops.c
> @@ -542,6 +542,9 @@ xfs_do_force_shutdown(
>         } else if (flags & SHUTDOWN_CORRUPT_INCORE) {
>                 tag = XFS_PTAG_SHUTDOWN_CORRUPT;
>                 why = "Corruption of in-memory data";
> +       } else if (flags & SHUTDOWN_CORRUPT_ONDISK) {
> +               tag = XFS_PTAG_SHUTDOWN_CORRUPT;
> +               why = "Corruption of on-disk metadata";
>         } else {
>                 tag = XFS_PTAG_SHUTDOWN_IOERROR;
>                 why = "Metadata I/O Error";
> diff --git a/fs/xfs/xfs_mount.h b/fs/xfs/xfs_mount.h
> index 00720a02e761..47ff4ac53c4c 100644
> --- a/fs/xfs/xfs_mount.h
> +++ b/fs/xfs/xfs_mount.h
> @@ -435,6 +435,7 @@ void xfs_do_force_shutdown(struct xfs_mount *mp, int flags, char *fname,
>  #define SHUTDOWN_LOG_IO_ERROR  0x0002  /* write attempt to the log failed */
>  #define SHUTDOWN_FORCE_UMOUNT  0x0004  /* shutdown from a forced unmount */
>  #define SHUTDOWN_CORRUPT_INCORE        0x0008  /* corrupt in-memory data structures */
> +#define SHUTDOWN_CORRUPT_ONDISK        0x0010  /* corrupt metadata on device */
>
>  #define XFS_SHUTDOWN_STRINGS \
>         { SHUTDOWN_META_IO_ERROR,       "metadata_io" }, \
> diff --git a/fs/xfs/xfs_notify_failure.c b/fs/xfs/xfs_notify_failure.c
> new file mode 100644
> index 000000000000..6abaa043f4bc
> --- /dev/null
> +++ b/fs/xfs/xfs_notify_failure.c
> @@ -0,0 +1,222 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2021 Fujitsu.  All Rights Reserved.
> + */
> +
> +#include "xfs.h"
> +#include "xfs_shared.h"
> +#include "xfs_format.h"
> +#include "xfs_log_format.h"
> +#include "xfs_trans_resv.h"
> +#include "xfs_mount.h"
> +#include "xfs_alloc.h"
> +#include "xfs_bit.h"
> +#include "xfs_btree.h"
> +#include "xfs_inode.h"
> +#include "xfs_icache.h"
> +#include "xfs_rmap.h"
> +#include "xfs_rmap_btree.h"
> +#include "xfs_rtalloc.h"
> +#include "xfs_trans.h"
> +
> +#include <linux/mm.h>
> +#include <linux/dax.h>
> +
> +struct failure_info {
> +       xfs_agblock_t           startblock;
> +       xfs_extlen_t            blockcount;
> +       int                     mf_flags;
> +};
> +
> +#if IS_ENABLED(CONFIG_MEMORY_FAILURE) && IS_ENABLED(CONFIG_FS_DAX)
> +static pgoff_t
> +xfs_failure_pgoff(
> +       struct xfs_mount                *mp,
> +       const struct xfs_rmap_irec      *rec,
> +       const struct failure_info       *notify)
> +{
> +       uint64_t                        pos = rec->rm_offset;
> +
> +       if (notify->startblock > rec->rm_startblock)
> +               pos += XFS_FSB_TO_B(mp,
> +                               notify->startblock - rec->rm_startblock);
> +       return pos >> PAGE_SHIFT;
> +}
> +
> +static unsigned long
> +xfs_failure_pgcnt(
> +       struct xfs_mount                *mp,
> +       const struct xfs_rmap_irec      *rec,
> +       const struct failure_info       *notify)
> +{
> +       xfs_agblock_t                   end_rec;
> +       xfs_agblock_t                   end_notify;
> +       xfs_agblock_t                   start_cross;
> +       xfs_agblock_t                   end_cross;
> +
> +       start_cross = max(rec->rm_startblock, notify->startblock);
> +
> +       end_rec = rec->rm_startblock + rec->rm_blockcount;
> +       end_notify = notify->startblock + notify->blockcount;
> +       end_cross = min(end_rec, end_notify);
> +
> +       return XFS_FSB_TO_B(mp, end_cross - start_cross) >> PAGE_SHIFT;
> +}
> +
> +static int
> +xfs_dax_failure_fn(
> +       struct xfs_btree_cur            *cur,
> +       const struct xfs_rmap_irec      *rec,
> +       void                            *data)
> +{
> +       struct xfs_mount                *mp = cur->bc_mp;
> +       struct xfs_inode                *ip;
> +       struct failure_info             *notify = data;
> +       int                             error = 0;
> +
> +       if (XFS_RMAP_NON_INODE_OWNER(rec->rm_owner) ||
> +           (rec->rm_flags & (XFS_RMAP_ATTR_FORK | XFS_RMAP_BMBT_BLOCK))) {
> +               xfs_force_shutdown(mp, SHUTDOWN_CORRUPT_ONDISK);
> +               return -EFSCORRUPTED;
> +       }
> +
> +       /* Get files that incore, filter out others that are not in use. */
> +       error = xfs_iget(mp, cur->bc_tp, rec->rm_owner, XFS_IGET_INCORE,
> +                        0, &ip);
> +       /* Continue the rmap query if the inode isn't incore */
> +       if (error == -ENODATA)
> +               return 0;
> +       if (error)
> +               return error;
> +
> +       error = mf_dax_kill_procs(VFS_I(ip)->i_mapping,
> +                                 xfs_failure_pgoff(mp, rec, notify),
> +                                 xfs_failure_pgcnt(mp, rec, notify),
> +                                 notify->mf_flags);
> +       xfs_irele(ip);
> +       return error;
> +}
> +#else
> +static int
> +xfs_dax_failure_fn(
> +       struct xfs_btree_cur            *cur,
> +       const struct xfs_rmap_irec      *rec,
> +       void                            *data)
> +{
> +       struct xfs_mount                *mp = cur->bc_mp;
> +
> +       /* No other option besides shutting down the fs. */
> +       xfs_force_shutdown(mp, SHUTDOWN_CORRUPT_ONDISK);
> +       return -EFSCORRUPTED;
> +}
> +#endif /* CONFIG_MEMORY_FAILURE && CONFIG_FS_DAX */
> +
> +static int
> +xfs_dax_notify_ddev_failure(
> +       struct xfs_mount        *mp,
> +       xfs_daddr_t             daddr,
> +       xfs_daddr_t             bblen,
> +       int                     mf_flags)
> +{
> +       struct xfs_trans        *tp = NULL;
> +       struct xfs_btree_cur    *cur = NULL;
> +       struct xfs_buf          *agf_bp = NULL;
> +       struct failure_info     notify;
> +       int                     error = 0;
> +       xfs_fsblock_t           fsbno = XFS_DADDR_TO_FSB(mp, daddr);
> +       xfs_agnumber_t          agno = XFS_FSB_TO_AGNO(mp, fsbno);
> +       xfs_fsblock_t           end_fsbno = XFS_DADDR_TO_FSB(mp, daddr + bblen);
> +       xfs_agnumber_t          end_agno = XFS_FSB_TO_AGNO(mp, end_fsbno);
> +
> +       /*
> +        * Once a file is found by rmap, we take the intersection of two ranges:
> +        * notification range and file extent range, to make sure we won't go
> +        * out of scope.
> +        */
> +       notify.mf_flags = mf_flags;
> +       notify.startblock = XFS_FSB_TO_AGBNO(mp, fsbno);
> +       notify.blockcount = XFS_BB_TO_FSB(mp, bblen);
> +
> +       error = xfs_trans_alloc_empty(mp, &tp);
> +       if (error)
> +               return error;
> +
> +       for (; agno <= end_agno; agno++) {
> +               struct xfs_rmap_irec    ri_low = { };
> +               struct xfs_rmap_irec    ri_high;
> +
> +               error = xfs_alloc_read_agf(mp, tp, agno, 0, &agf_bp);
> +               if (error)
> +                       break;
> +
> +               cur = xfs_rmapbt_init_cursor(mp, tp, agf_bp, agf_bp->b_pag);
> +
> +               /*
> +                * Set the rmap range from ri_low to ri_high, which represents
> +                * a [start, end] where we looking for the files or metadata.
> +                * The part of range out of a AG will be ignored.  So, it's fine
> +                * to set ri_low to "startblock" in all loops.  When it reaches
> +                * the last AG, set the ri_high to "endblock" to make sure we
> +                * actually end at the end.
> +                */
> +               memset(&ri_high, 0xFF, sizeof(ri_high));
> +               ri_low.rm_startblock = XFS_FSB_TO_AGBNO(mp, fsbno);
> +               if (agno == end_agno)
> +                       ri_high.rm_startblock = XFS_FSB_TO_AGBNO(mp, end_fsbno);
> +
> +               error = xfs_rmap_query_range(cur, &ri_low, &ri_high,
> +                               xfs_dax_failure_fn, &notify);
> +               xfs_btree_del_cursor(cur, error);
> +               xfs_trans_brelse(tp, agf_bp);
> +               if (error)
> +                       break;
> +
> +               fsbno = XFS_AGB_TO_FSB(mp, agno + 1, 0);
> +       }
> +
> +       xfs_trans_cancel(tp);
> +       return error;
> +}
> +
> +static int
> +xfs_dax_notify_failure(
> +       struct dax_device       *dax_dev,
> +       u64                     offset,
> +       u64                     len,
> +       int                     mf_flags)
> +{
> +       struct xfs_mount        *mp = dax_get_holder(dax_dev);
> +
> +       if (mp->m_rtdev_targp && mp->m_rtdev_targp->bt_daxdev == dax_dev) {
> +               xfs_warn(mp,
> +                        "notify_failure() not supported on realtime device!");
> +               return -EOPNOTSUPP;
> +       }
> +
> +       if (mp->m_logdev_targp && mp->m_logdev_targp->bt_daxdev == dax_dev &&
> +           mp->m_logdev_targp != mp->m_ddev_targp) {
> +               xfs_err(mp, "ondisk log corrupt, shutting down fs!");
> +               xfs_force_shutdown(mp, SHUTDOWN_CORRUPT_ONDISK);
> +               return -EFSCORRUPTED;
> +       }
> +
> +       if (!xfs_has_rmapbt(mp)) {
> +               xfs_warn(mp, "notify_failure() needs rmapbt enabled!");

Doesn't this need to be resolved at mount time?

> +               return -EOPNOTSUPP;
> +       }
> +
> +       if (offset < mp->m_ddev_targp->bt_dax_part_off ||
> +           ((offset + len) > mp->m_ddev_targp->bt_bdev->bd_nr_sectors <<
> +                               SECTOR_SHIFT)) {

With the removal of partition support bt_dax_part_off can never be
non-zero and the offset / len validation should be done against the
boundaries of the dax device in terms of physical page offset and
nr_pages.

> +               xfs_warn(mp, "notify_failure() goes out of the scope.");
> +               return -ENXIO;
> +       }
> +
> +       offset -= mp->m_ddev_targp->bt_dax_part_off;
> +       return xfs_dax_notify_ddev_failure(mp, BTOBB(offset), BTOBB(len),
> +                       mf_flags);

Same here, all offset adjustment code can be dropped because failure
notification should be disabled at mount time if the mount point is
not associated with a whole disk device.

> +}
> +
> +const struct dax_holder_operations xfs_dax_holder_operations = {
> +       .notify_failure         = xfs_dax_notify_failure,
> +};
> diff --git a/fs/xfs/xfs_notify_failure.h b/fs/xfs/xfs_notify_failure.h
> new file mode 100644
> index 000000000000..f40cb315e7ce
> --- /dev/null
> +++ b/fs/xfs/xfs_notify_failure.h
> @@ -0,0 +1,10 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2021 Fujitsu.  All Rights Reserved.
> + */
> +#ifndef __XFS_NOTIFY_FAILURE_H__
> +#define __XFS_NOTIFY_FAILURE_H__
> +
> +extern const struct dax_holder_operations xfs_dax_holder_operations;
> +
> +#endif  /* __XFS_NOTIFY_FAILURE_H__ */
> --
> 2.34.1
>
>
>
