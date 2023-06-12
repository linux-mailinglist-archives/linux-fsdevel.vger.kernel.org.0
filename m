Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E3EA72C496
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jun 2023 14:41:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235343AbjFLMlJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jun 2023 08:41:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232439AbjFLMk6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jun 2023 08:40:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B2068F
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Jun 2023 05:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686573617;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A+ImmXLKf49OKnDdEZB9LgjLhN4EC6KQC77CCn0lW2c=;
        b=gTlgCMjhBG9Dc57OpKtDVjzrBO7G2Ti/KrBsm2hRzb7WbmMBv4pZKe6NPL2coXHyt8jnA/
        Dvl1Drf6cLTyCot7J6Ylj7pnqj1I+B6HRMXJ3vsBrQOi0VprG7qeVOYqRhm0XVcZcyAdhR
        LkHGloukZFVnTE7M4QhuuRLaxhHdwT8=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-302-kSMlO9kxN4SLKAhzSO25ag-1; Mon, 12 Jun 2023 08:40:16 -0400
X-MC-Unique: kSMlO9kxN4SLKAhzSO25ag-1
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-1b3bb3dd181so8763185ad.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Jun 2023 05:40:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686573615; x=1689165615;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A+ImmXLKf49OKnDdEZB9LgjLhN4EC6KQC77CCn0lW2c=;
        b=dXiefLSox5+/Gs4xl8xmUKOvOq7c6BQsKAkqOLdaTvdY/Uxmh9WWlcEfLvSmjwx4H2
         JTVORKDeWAbJw14iIrCVn/i0C0TunhubObgiwH5KiKfWt/gp9gBaZnrGHC8PidUtSt9I
         j0MJW7fotXcTirBL4NYRWO97tSl8cbb/s7ja8sMY0q0zHdUbnX4AWV831LrWk/8X254o
         XSGMhZBR37AuYu+rf4jhPNDTNY6035HyOZvRi05gW5dICkmCBrdMDi6LhA2psnH6aeFs
         i/NDL/lsVpsO1b8Ce9sv/34N+d7YaBgCpEXacp3nHixYIk6RAtl2x0wrwIQZyVX4oD7Q
         wv8A==
X-Gm-Message-State: AC+VfDxnelTIB27evMNO7P2NC8Sxc40ituwsFNd5IsgSC6NeuV4b255S
        emFBhWqR/7GfRcUcDrqsN9TR6n/mAYCQivJ8Cmw+zHboq3+p7RdrNj+MtmGQmq8i1Iat9MYdnnG
        FiyQf4hoIHuFQm59zDhkxsdQFSynZ4aevgXne9U28Ug==
X-Received: by 2002:a17:903:41c2:b0:1b3:db60:d268 with SMTP id u2-20020a17090341c200b001b3db60d268mr718655ple.30.1686573615191;
        Mon, 12 Jun 2023 05:40:15 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7KtgGzBLJ7m6zA6Movger1MTREPts9Nuq8UZYBbKBsKXyZOvwdbdDz1ZM0ZZnZZS4Rg+LYn4d8HXpHfmIzY8k=
X-Received: by 2002:a17:903:41c2:b0:1b3:db60:d268 with SMTP id
 u2-20020a17090341c200b001b3db60d268mr718633ple.30.1686573614854; Mon, 12 Jun
 2023 05:40:14 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1686395560.git.ritesh.list@gmail.com> <606c3279db7cc189dd3cd94d162a056c23b67514.1686395560.git.ritesh.list@gmail.com>
In-Reply-To: <606c3279db7cc189dd3cd94d162a056c23b67514.1686395560.git.ritesh.list@gmail.com>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Mon, 12 Jun 2023 14:40:03 +0200
Message-ID: <CAHc6FU7Hv71ujeb9oEVOD+bpddMMT0KY+KKUp881Am15u-OVvg@mail.gmail.com>
Subject: Re: [PATCHv9 3/6] iomap: Add some uptodate state handling helpers for
 ifs state bitmap
To:     "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Brian Foster <bfoster@redhat.com>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jun 10, 2023 at 1:39=E2=80=AFPM Ritesh Harjani (IBM)
<ritesh.list@gmail.com> wrote:
> This patch adds two of the helper routines iomap_ifs_is_fully_uptodate()
> and iomap_ifs_is_block_uptodate() for managing uptodate state of
> ifs state bitmap.
>
> In later patches ifs state bitmap array will also handle dirty state of a=
ll
> blocks of a folio. Hence this patch adds some helper routines for handlin=
g
> uptodate state of the ifs state bitmap.
>
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> ---
>  fs/iomap/buffered-io.c | 28 ++++++++++++++++++++--------
>  1 file changed, 20 insertions(+), 8 deletions(-)
>
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index e237f2b786bc..206808f6e818 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -43,6 +43,20 @@ static inline struct iomap_folio_state *iomap_get_ifs(=
struct folio *folio)
>
>  static struct bio_set iomap_ioend_bioset;
>
> +static inline bool iomap_ifs_is_fully_uptodate(struct folio *folio,
> +                                              struct iomap_folio_state *=
ifs)
> +{
> +       struct inode *inode =3D folio->mapping->host;
> +
> +       return bitmap_full(ifs->state, i_blocks_per_folio(inode, folio));

This should be written as something like:

unsigned int blks_per_folio =3D i_blocks_per_folio(inode, folio);
return bitmap_full(ifs->state + IOMAP_ST_UPTODATE * blks_per_folio,
blks_per_folio);

> +}
> +
> +static inline bool iomap_ifs_is_block_uptodate(struct iomap_folio_state =
*ifs,
> +                                              unsigned int block)
> +{
> +       return test_bit(block, ifs->state);

This function should be called iomap_ifs_block_is_uptodate(), and
probably be written as follows, passing in the folio as well (this
will optimize out, anyway):

struct inode *inode =3D folio->mapping->host;
unsigned int blks_per_folio =3D i_blocks_per_folio(inode, folio);
return test_bit(block, ifs->state + IOMAP_ST_UPTODATE * blks_per_folio);

> +}
> +
>  static void iomap_ifs_set_range_uptodate(struct folio *folio,
>                 struct iomap_folio_state *ifs, size_t off, size_t len)
>  {
> @@ -54,7 +68,7 @@ static void iomap_ifs_set_range_uptodate(struct folio *=
folio,
>
>         spin_lock_irqsave(&ifs->state_lock, flags);
>         bitmap_set(ifs->state, first_blk, nr_blks);
> -       if (bitmap_full(ifs->state, i_blocks_per_folio(inode, folio)))
> +       if (iomap_ifs_is_fully_uptodate(folio, ifs))
>                 folio_mark_uptodate(folio);
>         spin_unlock_irqrestore(&ifs->state_lock, flags);
>  }
> @@ -99,14 +113,12 @@ static struct iomap_folio_state *iomap_ifs_alloc(str=
uct inode *inode,
>  static void iomap_ifs_free(struct folio *folio)
>  {
>         struct iomap_folio_state *ifs =3D folio_detach_private(folio);
> -       struct inode *inode =3D folio->mapping->host;
> -       unsigned int nr_blocks =3D i_blocks_per_folio(inode, folio);
>
>         if (!ifs)
>                 return;
>         WARN_ON_ONCE(atomic_read(&ifs->read_bytes_pending));
>         WARN_ON_ONCE(atomic_read(&ifs->write_bytes_pending));
> -       WARN_ON_ONCE(bitmap_full(ifs->state, nr_blocks) !=3D
> +       WARN_ON_ONCE(iomap_ifs_is_fully_uptodate(folio, ifs) !=3D
>                         folio_test_uptodate(folio));
>         kfree(ifs);
>  }
> @@ -137,7 +149,7 @@ static void iomap_adjust_read_range(struct inode *ino=
de, struct folio *folio,
>
>                 /* move forward for each leading block marked uptodate */
>                 for (i =3D first; i <=3D last; i++) {
> -                       if (!test_bit(i, ifs->state))
> +                       if (!iomap_ifs_is_block_uptodate(ifs, i))
>                                 break;
>                         *pos +=3D block_size;
>                         poff +=3D block_size;
> @@ -147,7 +159,7 @@ static void iomap_adjust_read_range(struct inode *ino=
de, struct folio *folio,
>
>                 /* truncate len if we find any trailing uptodate block(s)=
 */
>                 for ( ; i <=3D last; i++) {
> -                       if (test_bit(i, ifs->state)) {
> +                       if (iomap_ifs_is_block_uptodate(ifs, i)) {
>                                 plen -=3D (last - i + 1) * block_size;
>                                 last =3D i - 1;
>                                 break;
> @@ -451,7 +463,7 @@ bool iomap_is_partially_uptodate(struct folio *folio,=
 size_t from, size_t count)
>         last =3D (from + count - 1) >> inode->i_blkbits;
>
>         for (i =3D first; i <=3D last; i++)
> -               if (!test_bit(i, ifs->state))
> +               if (!iomap_ifs_is_block_uptodate(ifs, i))
>                         return false;
>         return true;
>  }
> @@ -1627,7 +1639,7 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc=
,
>          * invalid, grab a new one.
>          */
>         for (i =3D 0; i < nblocks && pos < end_pos; i++, pos +=3D len) {
> -               if (ifs && !test_bit(i, ifs->state))
> +               if (ifs && !iomap_ifs_is_block_uptodate(ifs, i))
>                         continue;
>
>                 error =3D wpc->ops->map_blocks(wpc, inode, pos);
> --
> 2.40.1
>

Thanks,
Andreas

