Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF406485A89
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jan 2022 22:17:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244395AbiAEVRu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Jan 2022 16:17:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244377AbiAEVRt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Jan 2022 16:17:49 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF947C061212
        for <linux-fsdevel@vger.kernel.org>; Wed,  5 Jan 2022 13:17:48 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id s1so294660pga.5
        for <linux-fsdevel@vger.kernel.org>; Wed, 05 Jan 2022 13:17:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ncCC9L0WeEGzChuvJR0/68WabesH5+cAdTHSnuR8eYQ=;
        b=fRuWCBZ33gONpGtMPl8wsjLgCQiQy7Wmiy3X1oq/2DBXxwzbc4JDSM+0dbA2bKYlRV
         Jq/bdCQ6RUtk4h7PVQuIl80f7fC6jXCldD9VSMLz9HFNzNZTHc1lfTZtw3zL8aem+raD
         PTrMTA9G9XJj0okCXm8iQlPaEceCAnAllllMDBzrdP4NrPOc30RmhB9ceW6DJjO0feeG
         hgtQNE4oIj03MDPpj9yEQi3mi4VsbDUmbwHNCxgs2AXWAyUFoPKzAN89Oe/pSF+YfQ3f
         1SjTD/MJrDfctrNx4II3BgN9/kWH6/zdeK9hrvd725mro2a3Qha4nanF0fk3yOsUSYNY
         2Ezg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ncCC9L0WeEGzChuvJR0/68WabesH5+cAdTHSnuR8eYQ=;
        b=WDZ28ZAT38PtfTGWUZVqRIVgPUQ//UPZxENgCgWTDvFZ4au2d5LZKoE/Hn0Ypvhb/b
         pEml/+LcDfKuqTFokSP/YI+PSX+LmNGdc93pk4LTbv52gUIMoskj7wuwDL+MTk6GRWcN
         U+cI+pm+qeXm+cWKS5P0xIfnoOU5D3F9Qf10ZhexU+sIu0yYvQ04NR2/XdGTT9BQIR1l
         iPFw4pH3Ulkft7jVMu0/IdK6XyKCkabJQmxWYdBPkTgK44EsMoYFzRvPB5GsLZvzazjD
         5N0piqvmz+3oXdKJ2mhkhQ7DPK0nknDy5PunnOBV9cXBTVksO5KmY0eqZugK7L7PrJsO
         BLdw==
X-Gm-Message-State: AOAM530v/92Jc92Wo8yPXFWR+Fg+EcF0lLqD0hQvRbz7GxWIBlSiFI+C
        3S3mODb3eK0coeVLjDENfcgc9ORoz+Kr1yd8R4QP4G+74EY=
X-Google-Smtp-Source: ABdhPJxgli9znNEolSNy97di7dIxA0jaBSFzjSHHHebIOCoYgJOYK/Ii+cU9k3sIosh4ktBtiagjcEUcU+NH0sLpGo0=
X-Received: by 2002:a63:ab01:: with SMTP id p1mr1770235pgf.437.1641417468262;
 Wed, 05 Jan 2022 13:17:48 -0800 (PST)
MIME-Version: 1.0
References: <20211226143439.3985960-1-ruansy.fnst@fujitsu.com>
 <20211226143439.3985960-10-ruansy.fnst@fujitsu.com> <20220105185334.GD398655@magnolia>
In-Reply-To: <20220105185334.GD398655@magnolia>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 5 Jan 2022 13:17:37 -0800
Message-ID: <CAPcyv4jYOvK57LqGzvZwyHo=4sEKmdAV1jgCzDw5eeCySPGS6w@mail.gmail.com>
Subject: Re: [PATCH v9 09/10] xfs: Implement ->notify_failure() for XFS
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Shiyang Ruan <ruansy.fnst@fujitsu.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        Linux MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        david <david@fromorbit.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jane Chu <jane.chu@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 5, 2022 at 10:53 AM Darrick J. Wong <djwong@kernel.org> wrote:
>
> On Sun, Dec 26, 2021 at 10:34:38PM +0800, Shiyang Ruan wrote:
> > Introduce xfs_notify_failure.c to handle failure related works, such as
> > implement ->notify_failure(), register/unregister dax holder in xfs, and
> > so on.
> >
> > If the rmap feature of XFS enabled, we can query it to find files and
> > metadata which are associated with the corrupt data.  For now all we do
> > is kill processes with that file mapped into their address spaces, but
> > future patches could actually do something about corrupt metadata.
> >
> > After that, the memory failure needs to notify the processes who are
> > using those files.
> >
> > Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
> > ---
> >  fs/xfs/Makefile             |   1 +
> >  fs/xfs/xfs_buf.c            |  15 +++
> >  fs/xfs/xfs_fsops.c          |   3 +
> >  fs/xfs/xfs_mount.h          |   1 +
> >  fs/xfs/xfs_notify_failure.c | 189 ++++++++++++++++++++++++++++++++++++
> >  fs/xfs/xfs_notify_failure.h |  10 ++
> >  6 files changed, 219 insertions(+)
> >  create mode 100644 fs/xfs/xfs_notify_failure.c
> >  create mode 100644 fs/xfs/xfs_notify_failure.h
> >
> > diff --git a/fs/xfs/Makefile b/fs/xfs/Makefile
> > index 04611a1068b4..389970b3e13b 100644
> > --- a/fs/xfs/Makefile
> > +++ b/fs/xfs/Makefile
> > @@ -84,6 +84,7 @@ xfs-y                               += xfs_aops.o \
> >                                  xfs_message.o \
> >                                  xfs_mount.o \
> >                                  xfs_mru_cache.o \
> > +                                xfs_notify_failure.o \
> >                                  xfs_pwork.o \
> >                                  xfs_reflink.o \
> >                                  xfs_stats.o \
> > diff --git a/fs/xfs/xfs_buf.c b/fs/xfs/xfs_buf.c
> > index bbb0fbd34e64..d0df7604fa9e 100644
> > --- a/fs/xfs/xfs_buf.c
> > +++ b/fs/xfs/xfs_buf.c
> > @@ -19,6 +19,7 @@
> >  #include "xfs_errortag.h"
> >  #include "xfs_error.h"
> >  #include "xfs_ag.h"
> > +#include "xfs_notify_failure.h"
> >
> >  static struct kmem_cache *xfs_buf_cache;
> >
> > @@ -1892,6 +1893,8 @@ xfs_free_buftarg(
> >       list_lru_destroy(&btp->bt_lru);
> >
> >       blkdev_issue_flush(btp->bt_bdev);
> > +     if (btp->bt_daxdev)
> > +             dax_unregister_holder(btp->bt_daxdev);
> >       fs_put_dax(btp->bt_daxdev);
> >
> >       kmem_free(btp);
> > @@ -1946,6 +1949,18 @@ xfs_alloc_buftarg(
> >       btp->bt_dev =  bdev->bd_dev;
> >       btp->bt_bdev = bdev;
> >       btp->bt_daxdev = fs_dax_get_by_bdev(bdev, &btp->bt_dax_part_off);
> > +     if (btp->bt_daxdev) {
> > +             dax_write_lock(btp->bt_daxdev);
> > +             if (dax_get_holder(btp->bt_daxdev)) {
> > +                     dax_write_unlock(btp->bt_daxdev);
> > +                     xfs_err(mp, "DAX device already in use?!");
> > +                     goto error_free;
> > +             }
> > +
> > +             dax_register_holder(btp->bt_daxdev, mp,
> > +                             &xfs_dax_holder_operations);
> > +             dax_write_unlock(btp->bt_daxdev);
> > +     }
> >
> >       /*
> >        * Buffer IO error rate limiting. Limit it to no more than 10 messages
> > diff --git a/fs/xfs/xfs_fsops.c b/fs/xfs/xfs_fsops.c
> > index 33e26690a8c4..d4d36c5bef11 100644
> > --- a/fs/xfs/xfs_fsops.c
> > +++ b/fs/xfs/xfs_fsops.c
> > @@ -542,6 +542,9 @@ xfs_do_force_shutdown(
> >       } else if (flags & SHUTDOWN_CORRUPT_INCORE) {
> >               tag = XFS_PTAG_SHUTDOWN_CORRUPT;
> >               why = "Corruption of in-memory data";
> > +     } else if (flags & SHUTDOWN_CORRUPT_ONDISK) {
> > +             tag = XFS_PTAG_SHUTDOWN_CORRUPT;
> > +             why = "Corruption of on-disk metadata";
> >       } else {
> >               tag = XFS_PTAG_SHUTDOWN_IOERROR;
> >               why = "Metadata I/O Error";
> > diff --git a/fs/xfs/xfs_mount.h b/fs/xfs/xfs_mount.h
> > index 00720a02e761..47ff4ac53c4c 100644
> > --- a/fs/xfs/xfs_mount.h
> > +++ b/fs/xfs/xfs_mount.h
> > @@ -435,6 +435,7 @@ void xfs_do_force_shutdown(struct xfs_mount *mp, int flags, char *fname,
> >  #define SHUTDOWN_LOG_IO_ERROR        0x0002  /* write attempt to the log failed */
> >  #define SHUTDOWN_FORCE_UMOUNT        0x0004  /* shutdown from a forced unmount */
> >  #define SHUTDOWN_CORRUPT_INCORE      0x0008  /* corrupt in-memory data structures */
> > +#define SHUTDOWN_CORRUPT_ONDISK      0x0010  /* corrupt metadata on device */
> >
> >  #define XFS_SHUTDOWN_STRINGS \
> >       { SHUTDOWN_META_IO_ERROR,       "metadata_io" }, \
> > diff --git a/fs/xfs/xfs_notify_failure.c b/fs/xfs/xfs_notify_failure.c
> > new file mode 100644
> > index 000000000000..a87bd08365f4
> > --- /dev/null
> > +++ b/fs/xfs/xfs_notify_failure.c
> > @@ -0,0 +1,189 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (c) 2021 Fujitsu.  All Rights Reserved.
> > + */
> > +
> > +#include "xfs.h"
> > +#include "xfs_shared.h"
> > +#include "xfs_format.h"
> > +#include "xfs_log_format.h"
> > +#include "xfs_trans_resv.h"
> > +#include "xfs_mount.h"
> > +#include "xfs_alloc.h"
> > +#include "xfs_bit.h"
> > +#include "xfs_btree.h"
> > +#include "xfs_inode.h"
> > +#include "xfs_icache.h"
> > +#include "xfs_rmap.h"
> > +#include "xfs_rmap_btree.h"
> > +#include "xfs_rtalloc.h"
> > +#include "xfs_trans.h"
> > +
> > +#include <linux/mm.h>
> > +#include <linux/dax.h>
> > +
> > +struct failure_info {
> > +     xfs_agblock_t           startblock;
> > +     xfs_filblks_t           blockcount;
> > +     int                     mf_flags;
>
> Why is blockcount a 64-bit quantity, when the failure information is
> dealt with on a per-AG basis?  I think "xfs_extlen_t blockcount" should
> be large enough here.  (I'll get back to this further down.)
>
> > +};
> > +
> > +static pgoff_t
> > +xfs_failure_pgoff(
> > +     struct xfs_mount                *mp,
> > +     const struct xfs_rmap_irec      *rec,
> > +     const struct failure_info       *notify)
> > +{
> > +     uint64_t pos = rec->rm_offset;
>
> Nit: indenting ^^^^^ here.
>
> > +
> > +     if (notify->startblock > rec->rm_startblock)
> > +             pos += XFS_FSB_TO_B(mp,
> > +                             notify->startblock - rec->rm_startblock);
> > +     return pos >> PAGE_SHIFT;
> > +}
> > +
> > +static unsigned long
> > +xfs_failure_pgcnt(
> > +     struct xfs_mount                *mp,
> > +     const struct xfs_rmap_irec      *rec,
> > +     const struct failure_info       *notify)
> > +{
> > +     xfs_agblock_t start_rec = rec->rm_startblock;
> > +     xfs_agblock_t end_rec = rec->rm_startblock + rec->rm_blockcount;
> > +     xfs_agblock_t start_notify = notify->startblock;
> > +     xfs_agblock_t end_notify = notify->startblock + notify->blockcount;
> > +     xfs_agblock_t start_cross = max(start_rec, start_notify);
> > +     xfs_agblock_t end_cross = min(end_rec, end_notify);
>
> Indenting and rather more local variables than we need?
>
> static unsigned long
> xfs_failure_pgcnt(
>         struct xfs_mount                *mp,
>         const struct xfs_rmap_irec      *rec,
>         const struct failure_info       *notify)
> {
>         xfs_agblock_t                   end_rec;
>         xfs_agblock_t                   end_notify;
>         xfs_agblock_t                   start_cross;
>         xfs_agblock_t                   end_cross;
>
>         start_cross = max(rec->rm_startblock, notify->startblock);
>
>         end_rec = rec->rm_startblock + rec->rm_blockcount;
>         end_notify = notify->startblock + notify->blockcount;
>         end_cross = min(end_rec, end_notify);
>
>         return XFS_FSB_TO_B(mp, end_cross - start_cross) >> PAGE_SHIFT;
> }
>
> > +
> > +     return XFS_FSB_TO_B(mp, end_cross - start_cross) >> PAGE_SHIFT;
> > +}
> > +
> > +static int
> > +xfs_dax_failure_fn(
> > +     struct xfs_btree_cur            *cur,
> > +     const struct xfs_rmap_irec      *rec,
> > +     void                            *data)
> > +{
> > +     struct xfs_mount                *mp = cur->bc_mp;
> > +     struct xfs_inode                *ip;
> > +     struct address_space            *mapping;
> > +     struct failure_info             *notify = data;
> > +     int                             error = 0;
> > +
> > +     if (XFS_RMAP_NON_INODE_OWNER(rec->rm_owner) ||
> > +         (rec->rm_flags & (XFS_RMAP_ATTR_FORK | XFS_RMAP_BMBT_BLOCK))) {
> > +             /* TODO check and try to fix metadata */
> > +             xfs_force_shutdown(mp, SHUTDOWN_CORRUPT_ONDISK);
> > +             return -EFSCORRUPTED;
> > +     }
> > +
> > +     /* Get files that incore, filter out others that are not in use. */
> > +     error = xfs_iget(mp, cur->bc_tp, rec->rm_owner, XFS_IGET_INCORE,
> > +                      0, &ip);
> > +     /* Continue the rmap query if the inode isn't incore */
> > +     if (error == -ENODATA)
> > +             return 0;
> > +     if (error)
> > +             return error;
> > +
> > +     mapping = VFS_I(ip)->i_mapping;
> > +     if (IS_ENABLED(CONFIG_MEMORY_FAILURE)) {
>
> Is there a situation where we can receive media failure notices from DAX
> but CONFIG_MEMORY_FAILURE is not enabled?  (I think the answer is yes?)

Good catch, yes, I was planning to reuse this notification
infrastructure for the "whoops you ripped out your CXL card that was
being used with FSDAX" case. Although, if someone builds the kernel
with CONFIG_MEMORY_FAILURE=n then I think a lack of notification for
that case is to be expected? Perhaps CONFIG_FSDAX should just depend
on CONFIG_MEMORY_FAILURE when that "hot remove" failure case is added.
For now, CONFIG_MEMORY_FAILURE is the only source of errors.

>
> > +             pgoff_t off = xfs_failure_pgoff(mp, rec, notify);
> > +             unsigned long cnt = xfs_failure_pgcnt(mp, rec, notify);
> > +
> > +             error = mf_dax_kill_procs(mapping, off, cnt, notify->mf_flags);
> > +     }
>
> If so, then we ought to do /something/ besides silently dropping the
> error, right?  Even if that something is rudely shutting down the fs,
> like we do for attr/bmbt mappings above?
>
> What I'm getting at is that I think this function should be:
>
> #if IS_ENABLED(CONFIG_MEMORY_FAILURE)
> static int
> xfs_dax_failure_fn(
>         struct xfs_btree_cur            *cur,
>         const struct xfs_rmap_irec      *rec,
>         void                            *data)
> {
>         /* shut down if attr/bmbt record like above */
>
>         error = xfs_iget(...);
>         if (error == -ENODATA)
>                 return 0;
>         if (error)
>                 return error;
>
>         off = xfs_failure_pgoff(mp, rec, notify);
>         cnt = xfs_failure_pgcnt(mp, rec, notify);
>
>         error = mf_dax_kill_procs(mapping, off, cnt, notify->mf_flags);
>         xfs_irele(ip);
>         return error;
> }
> #else
> static int
> xfs_dax_failure_fn(
>         struct xfs_btree_cur            *cur,
>         const struct xfs_rmap_irec      *rec,
>         void                            *data)
> {
>         /* No other option besides shutting down the fs. */
>         xfs_force_shutdown(mp, SHUTDOWN_CORRUPT_ONDISK);
>         return -EFSCORRUPTED;
> }
> #endif /* CONFIG_MEMORY_FAILURE */

Oh, yeah that makes sense to me.
