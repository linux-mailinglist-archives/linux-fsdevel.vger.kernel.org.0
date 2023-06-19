Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 154FA735722
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jun 2023 14:45:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231127AbjFSMpg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Jun 2023 08:45:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbjFSMpc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Jun 2023 08:45:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F45A10D3
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 Jun 2023 05:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687178632;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tctZ2YVll1/tO5XL0A/4LcmsjUzakbtnGpHnGs/0bWc=;
        b=PtXdFi5AmMC7M5X2y7QbbhzOBSas+EkhzrO9whbh8eD2EGIHGcYnC3w5jzj/PE8hqM2f6r
        tzm1PWOTzFEQuyjgYl53+WB//xJKn490Md3egJpW9mZ8uj0fgVltMfLZdndc6vQR9Kfp+j
        jKviz3ZH46LoKxeOit7KGkoZWT1QTnE=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-79-ANFTOJhSM_2LLGlkWZHuyg-1; Mon, 19 Jun 2023 08:43:50 -0400
X-MC-Unique: ANFTOJhSM_2LLGlkWZHuyg-1
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-1b52e2517b1so12540775ad.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 Jun 2023 05:43:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687178629; x=1689770629;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tctZ2YVll1/tO5XL0A/4LcmsjUzakbtnGpHnGs/0bWc=;
        b=bI1S/xpWlkIdMzlup6mmKKKBUY91Y2B+51FhEQS3kl99/mDaW8cgLqJE4cml/HlkIx
         +3dzgM3ne3LDq+AIijjcgJIQ68HADhIdlnaxBLNNnCS9i8fY4IzKbrrflS385XTNjO4X
         6/3L9UkWbYotzyMc7FPa4Ptq/eXqTesJ2Y+36tp4yJ+auGfD56g9MhMpmGGIHdsxKV+o
         Oz3+eDGvXz8VURcwxq1TQqCSSuwxWAjdIEN3p3iqu5BdThAUcz7mFAWSa+tWOmBV0EVB
         2yI5xMwZDDY1dTpk1Hh5kOsxqXqXvI3xtwLjKU0ZRjkx7MUCj2E1FXF33p+L8Hr48AmQ
         QXRg==
X-Gm-Message-State: AC+VfDzWY0hO6HVv6q5wGBLIrsZf/SjKUgROicAyAFwjDBtbh4d6Sbd5
        s53PdawdxDERctxwjidmHu34LT20eVhVm4nSP5YWh+C2/o3+8Q8rOMHho+N44M+c0hJHWuLvuBS
        qdhxIUxhgYND6IasCBfUSlXTx8MG/uxL/M63KZnUWkQ==
X-Received: by 2002:a17:902:e544:b0:1b6:7236:76c9 with SMTP id n4-20020a170902e54400b001b6723676c9mr620951plf.64.1687178629486;
        Mon, 19 Jun 2023 05:43:49 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5k9E9cgdTDbmMcmHL8At8jkC1kxGg1ZjSs5eMelatSXHKW4WhrzSzxgdMokAs+Q/KO0IhdEyN7fGLkEOe0BNw=
X-Received: by 2002:a17:902:e544:b0:1b6:7236:76c9 with SMTP id
 n4-20020a170902e54400b001b6723676c9mr620925plf.64.1687178629010; Mon, 19 Jun
 2023 05:43:49 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1687140389.git.ritesh.list@gmail.com> <6db62a08dda3a348303e2262454837149c2afe2a.1687140389.git.ritesh.list@gmail.com>
In-Reply-To: <6db62a08dda3a348303e2262454837149c2afe2a.1687140389.git.ritesh.list@gmail.com>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Mon, 19 Jun 2023 14:43:37 +0200
Message-ID: <CAHc6FU70U9HXe3=THWO6K5uzvz7c0BH38K0GytUbZdgiXMfh+Q@mail.gmail.com>
Subject: Re: [PATCHv10 8/8] iomap: Add per-block dirty state tracking to
 improve performance
To:     "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        "Darrick J . Wong" <djwong@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        Brian Foster <bfoster@redhat.com>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>,
        Aravinda Herle <araherle@in.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 19, 2023 at 4:29=E2=80=AFAM Ritesh Harjani (IBM)
<ritesh.list@gmail.com> wrote:
> When filesystem blocksize is less than folio size (either with
> mapping_large_folio_support() or with blocksize < pagesize) and when the
> folio is uptodate in pagecache, then even a byte write can cause
> an entire folio to be written to disk during writeback. This happens
> because we currently don't have a mechanism to track per-block dirty
> state within struct iomap_folio_state. We currently only track uptodate
> state.
>
> This patch implements support for tracking per-block dirty state in
> iomap_folio_state->state bitmap. This should help improve the filesystem
> write performance and help reduce write amplification.
>
> Performance testing of below fio workload reveals ~16x performance
> improvement using nvme with XFS (4k blocksize) on Power (64K pagesize)
> FIO reported write bw scores improved from around ~28 MBps to ~452 MBps.
>
> 1. <test_randwrite.fio>
> [global]
>         ioengine=3Dpsync
>         rw=3Drandwrite
>         overwrite=3D1
>         pre_read=3D1
>         direct=3D0
>         bs=3D4k
>         size=3D1G
>         dir=3D./
>         numjobs=3D8
>         fdatasync=3D1
>         runtime=3D60
>         iodepth=3D64
>         group_reporting=3D1
>
> [fio-run]
>
> 2. Also our internal performance team reported that this patch improves
>    their database workload performance by around ~83% (with XFS on Power)
>
> Reported-by: Aravinda Herle <araherle@in.ibm.com>
> Reported-by: Brian Foster <bfoster@redhat.com>
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> ---
>  fs/gfs2/aops.c         |   2 +-
>  fs/iomap/buffered-io.c | 189 ++++++++++++++++++++++++++++++++++++-----
>  fs/xfs/xfs_aops.c      |   2 +-
>  fs/zonefs/file.c       |   2 +-
>  include/linux/iomap.h  |   1 +
>  5 files changed, 171 insertions(+), 25 deletions(-)
>
> diff --git a/fs/gfs2/aops.c b/fs/gfs2/aops.c
> index a5f4be6b9213..75efec3c3b71 100644
> --- a/fs/gfs2/aops.c
> +++ b/fs/gfs2/aops.c
> @@ -746,7 +746,7 @@ static const struct address_space_operations gfs2_aop=
s =3D {
>         .writepages =3D gfs2_writepages,
>         .read_folio =3D gfs2_read_folio,
>         .readahead =3D gfs2_readahead,
> -       .dirty_folio =3D filemap_dirty_folio,
> +       .dirty_folio =3D iomap_dirty_folio,
>         .release_folio =3D iomap_release_folio,
>         .invalidate_folio =3D iomap_invalidate_folio,
>         .bmap =3D gfs2_bmap,
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 391d918ddd22..50f5840bb5f9 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -25,7 +25,7 @@
>
>  typedef int (*iomap_punch_t)(struct inode *inode, loff_t offset, loff_t =
length);
>  /*
> - * Structure allocated for each folio to track per-block uptodate state
> + * Structure allocated for each folio to track per-block uptodate, dirty=
 state
>   * and I/O completions.
>   */
>  struct iomap_folio_state {
> @@ -35,31 +35,55 @@ struct iomap_folio_state {
>         unsigned long           state[];
>  };
>
> +enum iomap_block_state {
> +       IOMAP_ST_UPTODATE,
> +       IOMAP_ST_DIRTY,
> +
> +       IOMAP_ST_MAX,
> +};
> +
> +static void ifs_calc_range(struct folio *folio, size_t off, size_t len,
> +               enum iomap_block_state state, unsigned int *first_blkp,
> +               unsigned int *nr_blksp)
> +{
> +       struct inode *inode =3D folio->mapping->host;
> +       unsigned int blks_per_folio =3D i_blocks_per_folio(inode, folio);
> +       unsigned int first =3D off >> inode->i_blkbits;
> +       unsigned int last =3D (off + len - 1) >> inode->i_blkbits;
> +
> +       *first_blkp =3D first + (state * blks_per_folio);
> +       *nr_blksp =3D last - first + 1;
> +}
> +
>  static struct bio_set iomap_ioend_bioset;
>
>  static inline bool ifs_is_fully_uptodate(struct folio *folio,
>                                                struct iomap_folio_state *=
ifs)
>  {
>         struct inode *inode =3D folio->mapping->host;
> +       unsigned int blks_per_folio =3D i_blocks_per_folio(inode, folio);
> +       unsigned int nr_blks =3D (IOMAP_ST_UPTODATE + 1) * blks_per_folio=
;

This nr_blks calculation doesn't make sense.

> -       return bitmap_full(ifs->state, i_blocks_per_folio(inode, folio));
> +       return bitmap_full(ifs->state, nr_blks);

Could you please change this to:

BUILD_BUG_ON(IOMAP_ST_UPTODATE !=3D 0);
return bitmap_full(ifs->state, blks_per_folio);

Also, I'm seeing that the value of i_blocks_per_folio() is assigned to
local variables with various names in several places (blks_per_folio,
nr_blocks, nblocks). Maybe this could be made consistent.

>  }
>
> -static inline bool ifs_block_is_uptodate(struct iomap_folio_state *ifs,
> -                                    blks_per_folio          unsigned int=
 block)blks_per_folio
> +static inline bool ifs_block_is_uptodate(struct folio *folio,
> +               struct iomap_folio_state *ifs, unsigned int block)
>  {
> -       return test_bit(block, ifs->state);
> +       struct inode *inode =3D folio->mapping->host;
> +       unsigned int blks_per_folio =3D i_blocks_per_folio(inode, folio);
> +
> +       return test_bit(block + IOMAP_ST_UPTODATE * blks_per_folio, ifs->=
state);
>  }
>
>  static void ifs_set_range_uptodate(struct folio *folio,
>                 struct iomap_folio_state *ifs, size_t off, size_t len)
>  {
> -       struct inode *inode =3D folio->mapping->host;
> -       unsigned int first_blk =3D off >> inode->i_blkbits;
> -       unsigned int last_blk =3D (off + len - 1) >> inode->i_blkbits;
> -       unsigned int nr_blks =3D last_blk - first_blk + 1;
> +       unsigned int first_blk, nr_blks;
>         unsigned long flags;
>
> +       ifs_calc_range(folio, off, len, IOMAP_ST_UPTODATE, &first_blk,
> +                            &nr_blks);
>         spin_lock_irqsave(&ifs->state_lock, flags);
>         bitmap_set(ifs->state, first_blk, nr_blks);
>         if (ifs_is_fully_uptodate(folio, ifs))
> @@ -78,6 +102,55 @@ static void iomap_set_range_uptodate(struct folio *fo=
lio, size_t off,
>                 folio_mark_uptodate(folio);
>  }
>
> +static inline bool ifs_block_is_dirty(struct folio *folio,
> +               struct iomap_folio_state *ifs, int block)
> +{
> +       struct inode *inode =3D folio->mapping->host;
> +       unsigned int blks_per_folio =3D i_blocks_per_folio(inode, folio);
> +
> +       return test_bit(block + IOMAP_ST_DIRTY * blks_per_folio, ifs->sta=
te);
> +}
> +
> +static void ifs_clear_range_dirty(struct folio *folio,
> +               struct iomap_folio_state *ifs, size_t off, size_t len)
> +{
> +       unsigned int first_blk, nr_blks;
> +       unsigned long flags;
> +
> +       ifs_calc_range(folio, off, len, IOMAP_ST_DIRTY, &first_blk, &nr_b=
lks);
> +       spin_lock_irqsave(&ifs->state_lock, flags);
> +       bitmap_clear(ifs->state, first_blk, nr_blks);
> +       spin_unlock_irqrestore(&ifs->state_lock, flags);
> +}
> +
> +static void iomap_clear_range_dirty(struct folio *folio, size_t off, siz=
e_t len)
> +{
> +       struct iomap_folio_state *ifs =3D folio->private;
> +
> +       if (ifs)
> +               ifs_clear_range_dirty(folio, ifs, off, len);
> +}
> +
> +static void ifs_set_range_dirty(struct folio *folio,
> +               struct iomap_folio_state *ifs, size_t off, size_t len)
> +{
> +       unsigned int first_blk, nr_blks;
> +       unsigned long flags;
> +
> +       ifs_calc_range(folio, off, len, IOMAP_ST_DIRTY, &first_blk, &nr_b=
lks);
> +       spin_lock_irqsave(&ifs->state_lock, flags);
> +       bitmap_set(ifs->state, first_blk, nr_blks);
> +       spin_unlock_irqrestore(&ifs->state_lock, flags);
> +}
> +
> +static void iomap_set_range_dirty(struct folio *folio, size_t off, size_=
t len)
> +{
> +       struct iomap_folio_state *ifs =3D folio->private;
> +
> +       if (ifs)
> +               ifs_set_range_dirty(folio, ifs, off, len);
> +}
> +
>  static struct iomap_folio_state *ifs_alloc(struct inode *inode,
>                 struct folio *folio, unsigned int flags)
>  {
> @@ -93,14 +166,24 @@ static struct iomap_folio_state *ifs_alloc(struct in=
ode *inode,
>         else
>                 gfp =3D GFP_NOFS | __GFP_NOFAIL;
>
> -       ifs =3D kzalloc(struct_size(ifs, state, BITS_TO_LONGS(nr_blocks))=
,
> -                     gfp);
> -       if (ifs) {
> -               spin_lock_init(&ifs->state_lock);
> -               if (folio_test_uptodate(folio))
> -                       bitmap_fill(ifs->state, nr_blocks);
> -               folio_attach_private(folio, ifs);
> -       }
> +       /*
> +        * ifs->state tracks two sets of state flags when the
> +        * filesystem block size is smaller than the folio size.
> +        * The first state tracks per-block uptodate and the
> +        * second tracks per-block dirty state.
> +        */
> +       ifs =3D kzalloc(struct_size(ifs, state,
> +                     BITS_TO_LONGS(IOMAP_ST_MAX * nr_blocks)), gfp);
> +       if (!ifs)
> +               return ifs;
> +
> +       spin_lock_init(&ifs->state_lock);
> +       if (folio_test_uptodate(folio))
> +               bitmap_set(ifs->state, 0, nr_blocks);
> +       if (folio_test_dirty(folio))
> +               bitmap_set(ifs->state, nr_blocks, nr_blocks);
> +       folio_attach_private(folio, ifs);
> +
>         return ifs;
>  }
>
> @@ -143,7 +226,7 @@ static void iomap_adjust_read_range(struct inode *ino=
de, struct folio *folio,
>
>                 /* move forward for each leading block marked uptodate */
>                 for (i =3D first; i <=3D last; i++) {
> -                       if (!ifs_block_is_uptodate(ifs, i))
> +                       if (!ifs_block_is_uptodate(folio, ifs, i))
>                                 break;
>                         *pos +=3D block_size;
>                         poff +=3D block_size;
> @@ -153,7 +236,7 @@ static void iomap_adjust_read_range(struct inode *ino=
de, struct folio *folio,
>
>                 /* truncate len if we find any trailing uptodate block(s)=
 */
>                 for ( ; i <=3D last; i++) {
> -                       if (ifs_block_is_uptodate(ifs, i)) {
> +                       if (ifs_block_is_uptodate(folio, ifs, i)) {
>                                 plen -=3D (last - i + 1) * block_size;
>                                 last =3D i - 1;
>                                 break;
> @@ -457,7 +540,7 @@ bool iomap_is_partially_uptodate(struct folio *folio,=
 size_t from, size_t count)
>         last =3D (from + count - 1) >> inode->i_blkbits;
>
>         for (i =3D first; i <=3D last; i++)
> -               if (!ifs_block_is_uptodate(ifs, i))
> +               if (!ifs_block_is_uptodate(folio, ifs, i))
>                         return false;
>         return true;
>  }
> @@ -523,6 +606,17 @@ void iomap_invalidate_folio(struct folio *folio, siz=
e_t offset, size_t len)
>  }
>  EXPORT_SYMBOL_GPL(iomap_invalidate_folio);
>
> +bool iomap_dirty_folio(struct address_space *mapping, struct folio *foli=
o)
> +{
> +       struct inode *inode =3D mapping->host;
> +       size_t len =3D folio_size(folio);
> +
> +       ifs_alloc(inode, folio, 0);
> +       iomap_set_range_dirty(folio, 0, len);
> +       return filemap_dirty_folio(mapping, folio);
> +}
> +EXPORT_SYMBOL_GPL(iomap_dirty_folio);
> +
>  static void
>  iomap_write_failed(struct inode *inode, loff_t pos, unsigned len)
>  {
> @@ -727,6 +821,7 @@ static size_t __iomap_write_end(struct inode *inode, =
loff_t pos, size_t len,
>         if (unlikely(copied < len && !folio_test_uptodate(folio)))
>                 return 0;
>         iomap_set_range_uptodate(folio, offset_in_folio(folio, pos), len)=
;
> +       iomap_set_range_dirty(folio, offset_in_folio(folio, pos), copied)=
;
>         filemap_dirty_folio(inode->i_mapping, folio);
>         return copied;
>  }
> @@ -891,6 +986,43 @@ iomap_file_buffered_write(struct kiocb *iocb, struct=
 iov_iter *i,
>  }
>  EXPORT_SYMBOL_GPL(iomap_file_buffered_write);
>
> +static int iomap_write_delalloc_ifs_punch(struct inode *inode,
> +               struct folio *folio, loff_t start_byte, loff_t end_byte,
> +               iomap_punch_t punch)
> +{
> +       unsigned int first_blk, last_blk, i;
> +       loff_t last_byte;
> +       u8 blkbits =3D inode->i_blkbits;
> +       struct iomap_folio_state *ifs;
> +       int ret =3D 0;
> +
> +       /*
> +        * When we have per-block dirty tracking, there can be
> +        * blocks within a folio which are marked uptodate
> +        * but not dirty. In that case it is necessary to punch
> +        * out such blocks to avoid leaking any delalloc blocks.
> +        */
> +       ifs =3D folio->private;
> +       if (!ifs)
> +               return ret;
> +
> +       last_byte =3D min_t(loff_t, end_byte - 1,
> +                       folio_pos(folio) + folio_size(folio) - 1);
> +       first_blk =3D offset_in_folio(folio, start_byte) >> blkbits;
> +       last_blk =3D offset_in_folio(folio, last_byte) >> blkbits;
> +       for (i =3D first_blk; i <=3D last_blk; i++) {
> +               if (!ifs_block_is_dirty(folio, ifs, i)) {
> +                       ret =3D punch(inode, folio_pos(folio) + (i << blk=
bits),
> +                                   1 << blkbits);
> +                       if (ret)
> +                               return ret;
> +               }
> +       }
> +
> +       return ret;
> +}
> +
> +
>  static int iomap_write_delalloc_punch(struct inode *inode, struct folio =
*folio,
>                 loff_t *punch_start_byte, loff_t start_byte, loff_t end_b=
yte,
>                 iomap_punch_t punch)
> @@ -907,6 +1039,13 @@ static int iomap_write_delalloc_punch(struct inode =
*inode, struct folio *folio,
>                 if (ret)
>                         return ret;
>         }
> +
> +       /* Punch non-dirty blocks within folio */
> +       ret =3D iomap_write_delalloc_ifs_punch(inode, folio, start_byte,
> +                       end_byte, punch);
> +       if (ret)
> +               return ret;
> +
>         /*
>          * Make sure the next punch start is correctly bound to
>          * the end of this data range, not the end of the folio.
> @@ -1637,7 +1776,7 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc=
,
>                 struct writeback_control *wbc, struct inode *inode,
>                 struct folio *folio, u64 end_pos)
>  {
> -       struct iomap_folio_state *ifs =3D ifs_alloc(inode, folio, 0);
> +       struct iomap_folio_state *ifs =3D folio->private;
>         struct iomap_ioend *ioend, *next;
>         unsigned len =3D i_blocksize(inode);
>         unsigned nblocks =3D i_blocks_per_folio(inode, folio);
> @@ -1645,6 +1784,11 @@ iomap_writepage_map(struct iomap_writepage_ctx *wp=
c,
>         int error =3D 0, count =3D 0, i;
>         LIST_HEAD(submit_list);
>
> +       if (!ifs && nblocks > 1) {
> +               ifs =3D ifs_alloc(inode, folio, 0);
> +               iomap_set_range_dirty(folio, 0, folio_size(folio));
> +       }
> +
>         WARN_ON_ONCE(ifs && atomic_read(&ifs->write_bytes_pending) !=3D 0=
);
>
>         /*
> @@ -1653,7 +1797,7 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc=
,
>          * invalid, grab a new one.
>          */
>         for (i =3D 0; i < nblocks && pos < end_pos; i++, pos +=3D len) {
> -               if (ifs && !ifs_block_is_uptodate(ifs, i))
> +               if (ifs && !ifs_block_is_dirty(folio, ifs, i))
>                         continue;
>
>                 error =3D wpc->ops->map_blocks(wpc, inode, pos);
> @@ -1697,6 +1841,7 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc=
,
>                 }
>         }
>
> +       iomap_clear_range_dirty(folio, 0, end_pos - folio_pos(folio));
>         folio_start_writeback(folio);
>         folio_unlock(folio);
>
> diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
> index 451942fb38ec..2fca4b4e7fd8 100644
> --- a/fs/xfs/xfs_aops.c
> +++ b/fs/xfs/xfs_aops.c
> @@ -578,7 +578,7 @@ const struct address_space_operations xfs_address_spa=
ce_operations =3D {
>         .read_folio             =3D xfs_vm_read_folio,
>         .readahead              =3D xfs_vm_readahead,
>         .writepages             =3D xfs_vm_writepages,
> -       .dirty_folio            =3D filemap_dirty_folio,
> +       .dirty_folio            =3D iomap_dirty_folio,
>         .release_folio          =3D iomap_release_folio,
>         .invalidate_folio       =3D iomap_invalidate_folio,
>         .bmap                   =3D xfs_vm_bmap,
> diff --git a/fs/zonefs/file.c b/fs/zonefs/file.c
> index 132f01d3461f..e508c8e97372 100644
> --- a/fs/zonefs/file.c
> +++ b/fs/zonefs/file.c
> @@ -175,7 +175,7 @@ const struct address_space_operations zonefs_file_aop=
s =3D {
>         .read_folio             =3D zonefs_read_folio,
>         .readahead              =3D zonefs_readahead,
>         .writepages             =3D zonefs_writepages,
> -       .dirty_folio            =3D filemap_dirty_folio,
> +       .dirty_folio            =3D iomap_dirty_folio,
>         .release_folio          =3D iomap_release_folio,
>         .invalidate_folio       =3D iomap_invalidate_folio,
>         .migrate_folio          =3D filemap_migrate_folio,
> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> index e2b836c2e119..eb9335c46bf3 100644
> --- a/include/linux/iomap.h
> +++ b/include/linux/iomap.h
> @@ -264,6 +264,7 @@ bool iomap_is_partially_uptodate(struct folio *, size=
_t from, size_t count);
>  struct folio *iomap_get_folio(struct iomap_iter *iter, loff_t pos);
>  bool iomap_release_folio(struct folio *folio, gfp_t gfp_flags);
>  void iomap_invalidate_folio(struct folio *folio, size_t offset, size_t l=
en);
> +bool iomap_dirty_folio(struct address_space *mapping, struct folio *foli=
o);
>  int iomap_file_unshare(struct inode *inode, loff_t pos, loff_t len,
>                 const struct iomap_ops *ops);
>  int iomap_zero_range(struct inode *inode, loff_t pos, loff_t len,
> --
> 2.40.1
>

Thanks,
Andreas

