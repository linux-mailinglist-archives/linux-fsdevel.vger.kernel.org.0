Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF9841009D0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Nov 2019 17:55:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726704AbfKRQzC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Nov 2019 11:55:02 -0500
Received: from mail-ua1-f68.google.com ([209.85.222.68]:45084 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726472AbfKRQzC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Nov 2019 11:55:02 -0500
Received: by mail-ua1-f68.google.com with SMTP id w10so3012714uar.12;
        Mon, 18 Nov 2019 08:55:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=bzIlMCv3LElQB4bScxaVvXG38tWIxsN9TLR8mgn6D/s=;
        b=kAkUh0wRyHle2fOSYrw+pZyCUJdpRY0eMmGEAvSHKbZQrFI+zAyQIZoOUi+q2gtJy7
         Akb5kSCFhdh9VSGepFdFh0E420wZQQnb0sh5ogUAycJ2mWCTBHndMlePGqqjHVADyCkg
         TlVWT1I7VheOAfqwBYyoUpLxK2sUL/g79Jnk1DQZ7m/NsMIDT6o89q7dlSYpy84BGyEI
         DXOVe9WrzxXxI7RK0Ct4lS/DCSPhYcF4pXQm6B3GBKaEqO33M3RqTPO4kyzLU4mKGtA8
         uSPCTrs9HBANTLMDRGaVyhW6zwZPdk5nG7gB3SnegSNbMoQiYyZ1DrMESZHFooZltX3u
         4EtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=bzIlMCv3LElQB4bScxaVvXG38tWIxsN9TLR8mgn6D/s=;
        b=mefj0DxEWWOrU905bVxPfVD3y7xVlv+jFVWnheMm+u3ZmjGMlf2zl2WeSxwyFzu+Uu
         SJO/1s3B005qRKKdyJo6MOSzvI/BpLGAggGyeyF3xeb9xgqZ5mo7WAax+rq2Dz+/i+0d
         5gj7yghK31egfKfMZkUpN4uYl54ZPNmMw+ANPwp39rpzWUnD5LXTPOQlYKItCt58twsX
         4/bVUV6sj414Hep0utkg6p+HC9hjEGQdhAXu/QBfGNlGZItT7PYUjJpJUfHao73BTrjU
         vllUZLZoBApCKmIHHC/B0pAZfDwc/RatCp1wKE/aKpJArH9+fsLlAbOcPbRTvlLgXZNg
         nnng==
X-Gm-Message-State: APjAAAVkixgxabjZIec4VVgUbbMtz9MRGyeKF8faQeiTbLAMEFgEg2hT
        rUwBbbB1yRN/B/wVGvVobFa27KqDtZLLMLk/bc4CcH/E
X-Google-Smtp-Source: APXvYqyEAAlxZdFWsCi88sKL56ytsX82MpmbDniaMnsJFpH1MFbRNXn8h3grhTKknxvtieLmhTBUCp4sDsP08KQVaJI=
X-Received: by 2002:a9f:350f:: with SMTP id o15mr18024797uao.123.1574096100421;
 Mon, 18 Nov 2019 08:55:00 -0800 (PST)
MIME-Version: 1.0
References: <20191115161700.12305-1-rgoldwyn@suse.de> <20191115161700.12305-5-rgoldwyn@suse.de>
In-Reply-To: <20191115161700.12305-5-rgoldwyn@suse.de>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Mon, 18 Nov 2019 16:54:49 +0000
Message-ID: <CAL3q7H6Vwz9uu=JDD_ZFHkNsP4dMnCyqy2qCGH67nTNgL0Pa1w@mail.gmail.com>
Subject: Re: [PATCH 4/7] btrfs: Use iomap_dio_rw() for direct I/O
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Goldwyn Rodrigues <rgoldwyn@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 15, 2019 at 4:19 PM Goldwyn Rodrigues <rgoldwyn@suse.de> wrote:
>
> From: Goldwyn Rodrigues <rgoldwyn@suse.com>
>
> This is the main patch to switch call from
> __blockdev_direct_IO() to iomap_dio_rw(). In this patch:
>
> Removed buffer_head references
> Removed inode_dio_begin() and inode_dio_end() functions since
> they are called in iomap_dio_rw().
> Renamed btrfs_get_blocks_direct() to direct_iomap_begin() and
> used it as iomap_begin()
> address_space.direct_IO now is a noop since direct_IO is called
> from __btrfs_write_direct().
>
> Removed flags parameter used for __blockdev_direct_IO(). iomap is
> capable of direct I/O reads from a hole, so we don't need to
> return -ENOENT.
>
> Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
> ---
>  fs/btrfs/ctree.h |   1 +
>  fs/btrfs/file.c  |   2 +-
>  fs/btrfs/inode.c | 105 ++++++++++++++++++-------------------------------=
------
>  3 files changed, 36 insertions(+), 72 deletions(-)
>
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index fe2b8765d9e6..cde8423673fc 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -2903,6 +2903,7 @@ int btrfs_writepage_cow_fixup(struct page *page, u6=
4 start, u64 end);
>  void btrfs_writepage_endio_finish_ordered(struct page *page, u64 start,
>                                           u64 end, int uptodate);
>  extern const struct dentry_operations btrfs_dentry_operations;
> +ssize_t btrfs_direct_IO(struct kiocb *iocb, struct iov_iter *iter);
>
>  /* ioctl.c */
>  long btrfs_ioctl(struct file *file, unsigned int cmd, unsigned long arg)=
;
> diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
> index eede9dcbb4b6..d47da00fa61e 100644
> --- a/fs/btrfs/file.c
> +++ b/fs/btrfs/file.c
> @@ -1835,7 +1835,7 @@ static ssize_t __btrfs_direct_write(struct kiocb *i=
ocb, struct iov_iter *from)
>         loff_t endbyte;
>         int err;
>
> -       written =3D generic_file_direct_write(iocb, from);
> +       written =3D btrfs_direct_IO(iocb, from);
>
>         if (written < 0 || !iov_iter_count(from))
>                 return written;
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index c6dc4dd16cf7..e2e4dfb7a568 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -8,6 +8,7 @@
>  #include <linux/buffer_head.h>
>  #include <linux/file.h>
>  #include <linux/fs.h>
> +#include <linux/iomap.h>
>  #include <linux/pagemap.h>
>  #include <linux/highmem.h>
>  #include <linux/time.h>
> @@ -7619,28 +7620,7 @@ static struct extent_map *create_io_em(struct inod=
e *inode, u64 start, u64 len,
>  }
>
>
> -static int btrfs_get_blocks_direct_read(struct extent_map *em,
> -                                       struct buffer_head *bh_result,
> -                                       struct inode *inode,
> -                                       u64 start, u64 len)
> -{
> -       if (em->block_start =3D=3D EXTENT_MAP_HOLE ||
> -                       test_bit(EXTENT_FLAG_PREALLOC, &em->flags))
> -               return -ENOENT;
> -
> -       len =3D min(len, em->len - (start - em->start));
> -
> -       bh_result->b_blocknr =3D (em->block_start + (start - em->start)) =
>>
> -               inode->i_blkbits;
> -       bh_result->b_size =3D len;
> -       bh_result->b_bdev =3D em->bdev;
> -       set_buffer_mapped(bh_result);
> -
> -       return 0;
> -}
> -
>  static int btrfs_get_blocks_direct_write(struct extent_map **map,
> -                                        struct buffer_head *bh_result,
>                                          struct inode *inode,
>                                          struct btrfs_dio_data *dio_data,
>                                          u64 start, u64 len)
> @@ -7702,7 +7682,6 @@ static int btrfs_get_blocks_direct_write(struct ext=
ent_map **map,
>         }
>
>         /* this will cow the extent */
> -       len =3D bh_result->b_size;
>         free_extent_map(em);
>         *map =3D em =3D btrfs_new_extent_direct(inode, start, len);
>         if (IS_ERR(em)) {
> @@ -7713,15 +7692,6 @@ static int btrfs_get_blocks_direct_write(struct ex=
tent_map **map,
>         len =3D min(len, em->len - (start - em->start));
>
>  skip_cow:
> -       bh_result->b_blocknr =3D (em->block_start + (start - em->start)) =
>>
> -               inode->i_blkbits;
> -       bh_result->b_size =3D len;
> -       bh_result->b_bdev =3D em->bdev;
> -       set_buffer_mapped(bh_result);
> -
> -       if (!test_bit(EXTENT_FLAG_PREALLOC, &em->flags))
> -               set_buffer_new(bh_result);
> -
>         /*
>          * Need to update the i_size under the extent lock so buffered
>          * readers will get the updated i_size when we unlock.
> @@ -7737,17 +7707,18 @@ static int btrfs_get_blocks_direct_write(struct e=
xtent_map **map,
>         return ret;
>  }
>
> -static int btrfs_get_blocks_direct(struct inode *inode, sector_t iblock,
> -                                  struct buffer_head *bh_result, int cre=
ate)
> +static int direct_iomap_begin(struct inode *inode, loff_t start,
> +               loff_t length, unsigned flags, struct iomap *iomap,
> +               struct iomap *srcmap)
>  {
>         struct btrfs_fs_info *fs_info =3D btrfs_sb(inode->i_sb);
>         struct extent_map *em;
>         struct extent_state *cached_state =3D NULL;
>         struct btrfs_dio_data *dio_data =3D NULL;
> -       u64 start =3D iblock << inode->i_blkbits;
>         u64 lockstart, lockend;
> -       u64 len =3D bh_result->b_size;
> +       int create =3D flags & IOMAP_WRITE;
>         int ret =3D 0;
> +       u64 len =3D length;
>
>         if (!create)
>                 len =3D min_t(u64, len, fs_info->sectorsize);
> @@ -7803,7 +7774,7 @@ static int btrfs_get_blocks_direct(struct inode *in=
ode, sector_t iblock,
>         }
>
>         if (create) {
> -               ret =3D btrfs_get_blocks_direct_write(&em, bh_result, ino=
de,
> +               ret =3D btrfs_get_blocks_direct_write(&em, inode,
>                                                     dio_data, start, len)=
;
>                 if (ret < 0)
>                         goto unlock_err;
> @@ -7811,19 +7782,13 @@ static int btrfs_get_blocks_direct(struct inode *=
inode, sector_t iblock,
>                 unlock_extent_cached(&BTRFS_I(inode)->io_tree, lockstart,
>                                      lockend, &cached_state);
>         } else {
> -               ret =3D btrfs_get_blocks_direct_read(em, bh_result, inode=
,
> -                                                  start, len);
> -               /* Can be negative only if we read from a hole */
> -               if (ret < 0) {
> -                       ret =3D 0;
> -                       free_extent_map(em);
> -                       goto unlock_err;
> -               }
> +
> +               len =3D min(len, em->len - (start - em->start));
>                 /*
>                  * We need to unlock only the end area that we aren't usi=
ng.
>                  * The rest is going to be unlocked by the endio routine.
>                  */
> -               lockstart =3D start + bh_result->b_size;
> +               lockstart =3D start + len;
>                 if (lockstart < lockend) {
>                         unlock_extent_cached(&BTRFS_I(inode)->io_tree,
>                                              lockstart, lockend, &cached_=
state);
> @@ -7832,6 +7797,18 @@ static int btrfs_get_blocks_direct(struct inode *i=
node, sector_t iblock,
>                 }
>         }
>
> +       if ((em->block_start =3D=3D EXTENT_MAP_HOLE) ||
> +           (test_bit(EXTENT_FLAG_PREALLOC, &em->flags) && !create)) {
> +               iomap->addr =3D IOMAP_NULL_ADDR;
> +               iomap->type =3D IOMAP_HOLE;
> +       } else {
> +               iomap->addr =3D em->block_start - (start - em->start);
> +               iomap->type =3D IOMAP_MAPPED;
> +       }
> +       iomap->offset =3D start;
> +       iomap->bdev =3D em->bdev;
> +       iomap->length =3D min(len, em->len - (start - em->start));
> +
>         free_extent_map(em);
>
>         return 0;
> @@ -8199,9 +8176,8 @@ static void btrfs_endio_direct_read(struct bio *bio=
)
>         kfree(dip);
>
>         dio_bio->bi_status =3D err;
> -       dio_end_io(dio_bio);
> +       bio_endio(dio_bio);
>         btrfs_io_bio_free_csum(io_bio);
> -       bio_put(bio);
>  }
>
>  static void __endio_write_update_ordered(struct inode *inode,
> @@ -8263,8 +8239,7 @@ static void btrfs_endio_direct_write(struct bio *bi=
o)
>         kfree(dip);
>
>         dio_bio->bi_status =3D bio->bi_status;
> -       dio_end_io(dio_bio);
> -       bio_put(bio);
> +       bio_endio(dio_bio);
>  }
>
>  static blk_status_t btrfs_submit_bio_start_direct_io(void *private_data,
> @@ -8568,7 +8543,7 @@ static void btrfs_submit_direct(struct bio *dio_bio=
, struct inode *inode,
>                 /*
>                  * The end io callbacks free our dip, do the final put on=
 bio
>                  * and all the cleanup and final put for dio_bio (through
> -                * dio_end_io()).
> +                * end_io()).
>                  */
>                 dip =3D NULL;
>                 bio =3D NULL;
> @@ -8587,7 +8562,7 @@ static void btrfs_submit_direct(struct bio *dio_bio=
, struct inode *inode,
>                  * Releases and cleans up our dio_bio, no need to bio_put=
()
>                  * nor bio_endio()/bio_io_error() against dio_bio.
>                  */
> -               dio_end_io(dio_bio);
> +               bio_endio(dio_bio);

The comment above also needs to be updated. It explicitly mentions
there's no need to call bio_endio(), but now the code it's calling
that function.

>         }
>         if (bio)
>                 bio_put(bio);
> @@ -8627,7 +8602,11 @@ static ssize_t check_direct_IO(struct btrfs_fs_inf=
o *fs_info,
>         return retval;
>  }
>
> -static ssize_t btrfs_direct_IO(struct kiocb *iocb, struct iov_iter *iter=
)
> +static const struct iomap_ops dio_iomap_ops =3D {
> +       .iomap_begin            =3D direct_iomap_begin,
> +};
> +
> +ssize_t btrfs_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
>  {
>         struct file *file =3D iocb->ki_filp;
>         struct inode *inode =3D file->f_mapping->host;
> @@ -8637,14 +8616,11 @@ static ssize_t btrfs_direct_IO(struct kiocb *iocb=
, struct iov_iter *iter)
>         loff_t offset =3D iocb->ki_pos;
>         size_t count =3D 0;
>         int flags =3D 0;
> -       bool wakeup =3D true;
> -       bool relock =3D false;
>         ssize_t ret;
>
>         if (check_direct_IO(fs_info, iter, offset))
>                 return 0;
>
> -       inode_dio_begin(inode);
>
>         /*
>          * The generic stuff only does filemap_write_and_wait_range, whic=
h
> @@ -8664,11 +8640,7 @@ static ssize_t btrfs_direct_IO(struct kiocb *iocb,=
 struct iov_iter *iter)
>                  * the isize, but it is protected by i_mutex. So we can
>                  * not unlock the i_mutex at this case.
>                  */
> -               if (offset + count <=3D inode->i_size) {
> -                       dio_data.overwrite =3D 1;
> -                       inode_unlock(inode);
> -                       relock =3D true;

I'm not familiar with iomap, but a quick grep at iomap/*.c (5.4-rc7)
reveals no call to inode_unlock().
So this change is throwing away the optimization done by commit [1],
which makes a lot of sense and when it landed I observed as well that
it made a great difference (as expected).
Correct me if I'm wrong, but that optimization is now gone isn't it?
So concurrent direct IO writes to a file, that don't expand the
inode's i_size and operate on non-overlapping ranges, will now be
completely serialized.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/comm=
it/?id=3D38851cc19adbfa1def2b47106d8050a80e0a3673

Thanks


> -               } else if (iocb->ki_flags & IOCB_NOWAIT) {
> +               if (iocb->ki_flags & IOCB_NOWAIT) {
>                         ret =3D -EAGAIN;
>                         goto out;
>                 }
> @@ -8690,15 +8662,11 @@ static ssize_t btrfs_direct_IO(struct kiocb *iocb=
, struct iov_iter *iter)
>                 down_read(&BTRFS_I(inode)->dio_sem);
>         } else if (test_bit(BTRFS_INODE_READDIO_NEED_LOCK,
>                                      &BTRFS_I(inode)->runtime_flags)) {
> -               inode_dio_end(inode);
>                 flags =3D DIO_LOCKING | DIO_SKIP_HOLES;
> -               wakeup =3D false;
>         }
>
> -       ret =3D __blockdev_direct_IO(iocb, inode,
> -                                  fs_info->fs_devices->latest_bdev,
> -                                  iter, btrfs_get_blocks_direct, NULL,
> -                                  btrfs_submit_direct, flags);
> +       ret =3D iomap_dio_rw(iocb, iter, &dio_iomap_ops, NULL, is_sync_ki=
ocb(iocb));
> +
>         if (iov_iter_rw(iter) =3D=3D WRITE) {
>                 up_read(&BTRFS_I(inode)->dio_sem);
>                 current->journal_info =3D NULL;
> @@ -8725,11 +8693,6 @@ static ssize_t btrfs_direct_IO(struct kiocb *iocb,=
 struct iov_iter *iter)
>                 btrfs_delalloc_release_extents(BTRFS_I(inode), count);
>         }
>  out:
> -       if (wakeup)
> -               inode_dio_end(inode);
> -       if (relock)
> -               inode_lock(inode);
> -
>         extent_changeset_free(data_reserved);
>         return ret;
>  }
> --
> 2.16.4
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
