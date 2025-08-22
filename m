Return-Path: <linux-fsdevel+bounces-58865-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 471CAB32564
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Aug 2025 01:22:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70E521CE258C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 23:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F29F2877D2;
	Fri, 22 Aug 2025 23:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mqv6QTdC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F7DE1BC4E
	for <linux-fsdevel@vger.kernel.org>; Fri, 22 Aug 2025 23:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755904858; cv=none; b=i2NIsuHVGucESKfvOZthEBN1Jo6Yu1TwfkuKiA8yPT23jlpi/RTDyAlAw1jKzNsLJ3eCcV1G+XZwjHc4W9rqiOQOUoFD6itXiy23DYont+LUsHWcy4LGOxXjJoo0XGnWV+VjI+1Ud6BNFnMdtTEnIJW7N4J5469O+eo7slt1HSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755904858; c=relaxed/simple;
	bh=7J5fYsTgLsgead2/A8+gAwzfnlftOXE6YLd2tr4goiQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PqsQlIgD/ra8JROux/7VToVehVsV0FiL26bIi+1WDVbSvViYpSpN5v5XDTSMQzyEcccACFVJa1s9p94m7maNbX0CrmuAtlUJIK95fCumYBN+cYarQLF9Kv1BaaQyAMl1fy3XfFNMXbdoPEr4Vg1niVFlf9YM/HqgyLjVmFmIwHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mqv6QTdC; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4b109c6b9fcso28372191cf.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Aug 2025 16:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755904855; x=1756509655; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5sh6IXcuBHAVTh39jo2RRgKkLW87v0FUt1zqpSwM4a0=;
        b=Mqv6QTdCAxQeH8ezvD+EWh9fnu0FX8gKcNXmChzZQ89yERE8REFxUXXrsv3fhQJOKb
         qO9yjxHwTkhH2cVh5573eaogvZAm2EfWgLyqBL0LvamnXN8+qbFeXhM3qk8iOF0dU+c4
         XhOuJVybdNuOPClvk3BM7OQRetigsELdKTaAnTqCKMMqBbnfIBCB/Snc+NnNPh6TtCOF
         RJA/4a5/N2oPe/0wkEc7ItAH+Z8Bst8bGEg8wFLLwfVs/d5b1D6K6X29dAoROaFnVIO+
         Toutis/+gVrsJx5f55r4f0TdW9NK5p/wQR13o3zNKQg1UKNL2HMSlFwhgamcUfmjr/Tb
         PRJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755904855; x=1756509655;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5sh6IXcuBHAVTh39jo2RRgKkLW87v0FUt1zqpSwM4a0=;
        b=ISrqca4fMLbK9CStzkiQIpi6tLEiaFOcKqFRZ6avp9X+buESLbXNNTJvMGpb6wMIqw
         nAYUGJ3EAkmqHBiJ8Bt8HTuK1eLRrTmq30GPX5rttfjXdX9yhNIJFDLzR2e3XX9KT7My
         hx73FiXcUYfvZTF4R462L1lGCLP/QGoG21aAnZkCatzCFFNZm/7Eb/oegFclIoA16gFn
         ayVHqifhrXoSfDv8IIlkpiYYbMVaMrdEvIDdX3hF3TJ5HuYFmleWjO/Fqqjl7yM0lrPo
         NUoJkTDwg3L9n5i5YPEtqsNknahiONFU0B07LOl+51v6SbRZJM0wNDaxEeOMFolciy7B
         G4BQ==
X-Forwarded-Encrypted: i=1; AJvYcCWwNy15sHbqsWWyBza9/sBIHsq9PykSvScCMlWNoPu+mH+fPQUjP+xnjqlEGcbDWTbC/5PSrUmkKrGy11vf@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3D2ZibY71gWYr/X3AfaW5PRc0DZtNGQLk+cx6+jmrv8pq6+t/
	4ZpqE9fOV8U+utz72jnAAgqG/36eSGMSpt+ZekuqxGYJt28HR0RYR/LA2BqNr+92ARwSAC7LJt5
	k21oO6U4RSuhRw9w8bqNcRhFr5Q29v+M=
X-Gm-Gg: ASbGncuimwbdmZZ6axbM05kJsapDKi8A+tEP/VqSZ88sbbL8uHQoNLgwr2zh2IPsuK8
	SAX7X/x4AjsVg7ZvB7uv/hJugQh5d9d+5Wx7/pqVcHqXhd0UDaxJKsJhZwrKyfjMkDfALdE9vpD
	S0mWl/35LRH2tMz5iUrwDUgNHopDjM4RZDJMoUj7TEGBw+ACg6i3jYwjweYmPQPzVgSJ9LjOCF0
	vzndaXv
X-Google-Smtp-Source: AGHT+IGehqz+qgc08Xs+YcOkmGwrUy5qnS9rSdL99LHlB32v780kpomgNOcSXYPk2NxdUlswHHM85BCB9iIqMOXXNU8=
X-Received: by 2002:a05:622a:1b14:b0:4b1:aed:7480 with SMTP id
 d75a77b69052e-4b2aaa401ddmr51256831cf.23.1755904854960; Fri, 22 Aug 2025
 16:20:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250707234606.2300149-1-joannelkoong@gmail.com>
 <20250707234606.2300149-3-joannelkoong@gmail.com> <CGME20250822214238eucas1p16934a3c0a9575e6044b61e11f3635af0@eucas1p1.samsung.com>
 <a91010a8-e715-4f3d-9e22-e4c34efc0408@samsung.com> <2acaa457-2c9f-4285-8403-2896a152f929@samsung.com>
In-Reply-To: <2acaa457-2c9f-4285-8403-2896a152f929@samsung.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Fri, 22 Aug 2025 16:20:44 -0700
X-Gm-Features: Ac12FXwS07sm5a02yhNB9fOsIW7cbSN95w93gPogkIo9eiP3evKdHTcMTXPf8kc
Message-ID: <CAJnrk1agKVGUr6jVapjHBaYJHrkV8zcmDVKr6k0mUu+n=iUqxA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] mm: remove BDI_CAP_WRITEBACK_ACCT
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, david@redhat.com, 
	willy@infradead.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 22, 2025 at 2:42=E2=80=AFPM Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
>
> On 22.08.2025 13:01, Marek Szyprowski wrote:
> > On 08.07.2025 01:46, Joanne Koong wrote:
> >> There are no users of BDI_CAP_WRITEBACK_ACCT now that fuse doesn't do
> >> its own writeback accounting. This commit removes
> >> BDI_CAP_WRITEBACK_ACCT.
> >>
> >> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> >> Acked-by: David Hildenbrand <david@redhat.com>
> >
> > This patch landed recently in linux-next as commit 167f21a81a9c ("mm:
> > remove BDI_CAP_WRITEBACK_ACCT"). In my tests I found that it triggers
> > the ./include/linux/backing-dev.h:239 warning. Reverting $subject on
> > top of current linux-next fixes/hides this issue. Here is a detailed lo=
g:
> >
> > ------------[ cut here ]------------
> > WARNING: ./include/linux/backing-dev.h:239 at
> > __folio_start_writeback+0x25a/0x26a, CPU#1: swapper/0/1
> > Modules linked in:
> > CPU: 1 UID: 0 PID: 1 Comm: swapper/0 Not tainted
> > 6.17.0-rc2-next-20250822 #10852 NONE
> > Hardware name: StarFive VisionFive 2 v1.2A (DT)
> > epc : __folio_start_writeback+0x25a/0x26a
> >  ra : __folio_start_writeback+0x258/0x26a
> >
> > [<ffffffff80202222>] __folio_start_writeback+0x25a/0x26a
> > [<ffffffff802f3260>] __block_write_full_folio+0x124/0x39c
> > [<ffffffff802f4b6e>] block_write_full_folio+0x8a/0xbc
> > [<ffffffff804dbf42>] blkdev_writepages+0x3e/0x8a
> > [<ffffffff802030fa>] do_writepages+0x78/0x11a
> > [<ffffffff801f2e0e>] filemap_fdatawrite_wbc+0x4a/0x62
> > [<ffffffff801f6d66>] __filemap_fdatawrite_range+0x52/0x78
> > [<ffffffff801f6fdc>] filemap_write_and_wait_range+0x40/0x68
> > [<ffffffff804dacae>] set_blocksize+0xd8/0x152
> > [<ffffffff804dae18>] sb_min_blocksize+0x44/0xce
> > [<ffffffff803a0c7a>] ext4_fill_super+0x182/0x2914
> > [<ffffffff802a72e6>] get_tree_bdev_flags+0xf0/0x168
> > [<ffffffff802a736c>] get_tree_bdev+0xe/0x16
> > [<ffffffff8039a09e>] ext4_get_tree+0x14/0x1c
> > [<ffffffff802a5062>] vfs_get_tree+0x1a/0xa4
> > [<ffffffff802d17d4>] path_mount+0x23a/0x8ae
> > [<ffffffff80c20cd4>] init_mount+0x4e/0x86
> > [<ffffffff80c01622>] do_mount_root+0xe0/0x166
> > [<ffffffff80c01814>] mount_root_generic+0x11e/0x2d6
> > [<ffffffff80c02746>] initrd_load+0xf8/0x2b6
> > [<ffffffff80c01d38>] prepare_namespace+0x150/0x258
> > [<ffffffff80c01310>] kernel_init_freeable+0x2f2/0x316
> > [<ffffffff80b6d896>] kernel_init+0x1e/0x13a
> > [<ffffffff80012288>] ret_from_fork_kernel+0x14/0x208
> > [<ffffffff80b79392>] ret_from_fork_kernel_asm+0x16/0x18
> > irq event stamp: 159263
> > hardirqs last  enabled at (159263): [<ffffffff805e7e4a>]
> > percpu_counter_add_batch+0xa6/0xda
> > hardirqs last disabled at (159262): [<ffffffff805e7e40>]
> > percpu_counter_add_batch+0x9c/0xda
> > softirqs last  enabled at (159248): [<ffffffff8002e972>]
> > handle_softirqs+0x3ca/0x462
> > softirqs last disabled at (159241): [<ffffffff8002eb72>]
> > __irq_exit_rcu+0xe2/0x10c
> > ---[ end trace 0000000000000000 ]---
>
> I've played a bit with the code modified by the $subject patch and it
> looks that the following change fixes the issue, although I didn't
> analyze exactly where struct bdi_writeback is being modified:

Hi Marek,

Thank you for the report and analysis.

The comment in the warning you linked to
(./include/linux/backing-dev.h:239) says:
"The caller [of inode_to_wb()] must be holding either @inode->i_lock,
the i_pages lock, or the associated wb's list_lock". (This was added
in commit aaa2cacf8184 "writeback: add lockdep annotation to
inode_to_wb()").

The original code before my change set "wb =3D inode_to_wb(inode);" only
after the inode->i_mapping->i_pages.xa_lock was held, so your patch
below which reverts it back to this behavior, fixes the lockdep
warning. That looks correct to me. Thanks for the fix.


>
> diff --git a/mm/page-writeback.c b/mm/page-writeback.c
> index 99e80bdb3084..3887ac2e6475 100644
> --- a/mm/page-writeback.c
> +++ b/mm/page-writeback.c
> @@ -2984,7 +2984,7 @@ bool __folio_end_writeback(struct folio *folio)
>
>          if (mapping && mapping_use_writeback_tags(mapping)) {
>                  struct inode *inode =3D mapping->host;
> -               struct bdi_writeback *wb =3D inode_to_wb(inode);
> +               struct bdi_writeback *wb;
>                  unsigned long flags;
>
>                  xa_lock_irqsave(&mapping->i_pages, flags);
> @@ -2992,6 +2992,7 @@ bool __folio_end_writeback(struct folio *folio)
>                  __xa_clear_mark(&mapping->i_pages, folio_index(folio),
>                                          PAGECACHE_TAG_WRITEBACK);
>
> +               wb =3D inode_to_wb(inode);
>                  wb_stat_mod(wb, WB_WRITEBACK, -nr);
>                  __wb_writeout_add(wb, nr);
>                  if (!mapping_tagged(mapping, PAGECACHE_TAG_WRITEBACK)) {
> @@ -3024,7 +3025,7 @@ void __folio_start_writeback(struct folio *folio,
> bool keep_write)
>          if (mapping && mapping_use_writeback_tags(mapping)) {
>                  XA_STATE(xas, &mapping->i_pages, folio_index(folio));
>                  struct inode *inode =3D mapping->host;
> -               struct bdi_writeback *wb =3D inode_to_wb(inode);
> +               struct bdi_writeback *wb;
>                  unsigned long flags;
>                  bool on_wblist;
>
> @@ -3035,6 +3036,7 @@ void __folio_start_writeback(struct folio *folio,
> bool keep_write)
>                  on_wblist =3D mapping_tagged(mapping,
> PAGECACHE_TAG_WRITEBACK);
>
>                  xas_set_mark(&xas, PAGECACHE_TAG_WRITEBACK);
> +               wb =3D inode_to_wb(inode);
>                  wb_stat_mod(wb, WB_WRITEBACK, nr);
>                  if (!on_wblist) {
>                          wb_inode_writeback_start(wb);
>
>
> > ...
>
> Best regards
> --
> Marek Szyprowski, PhD
> Samsung R&D Institute Poland
>

