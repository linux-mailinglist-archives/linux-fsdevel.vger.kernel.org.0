Return-Path: <linux-fsdevel+bounces-29141-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC1D597653F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2024 11:11:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE8BC2819D6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2024 09:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4BE7192B73;
	Thu, 12 Sep 2024 09:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fNq5XvuJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF0B1A28D;
	Thu, 12 Sep 2024 09:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726132261; cv=none; b=p8dB5V9TNZhgqBSRv1mK0bY7Al2GuA4kqchJqlugjd9BFz53GflcmMNTU0Jqyu4nbQE/d3pOQCWUNeYvvGC3RD3nMm33JZMdHpI9/z9ZoAi5L12ZwwYAK6CtIklxkVMmL4Nsp2v+/+dqAkPmmoRzJdYstpqJpwJDONu3vFQfxjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726132261; c=relaxed/simple;
	bh=vVoRduz3PXSsMxaTDnIe2sii3a9ZIDw8uNpP9dsyQdY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gWnhCr7naGdbnSkFTOTlpoDJO7CzqgMLqMun1/yKiPny0Eso7RN4zd/b8SStDbmanRZ16fsxiRoTe7V6Tq+Qh2roNB2lsabx0ssESc0GRnqPDDAqO7prwZbyPh8KG92oWqOHahrvupiwyXM/qK2afy03TQBrC1dNdyJnBX7SyDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fNq5XvuJ; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2f751a2a29fso277781fa.0;
        Thu, 12 Sep 2024 02:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726132257; x=1726737057; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=01YKGFk3SAfDDky5pSAjdfHBUg1pbqc31tmiJcxwToI=;
        b=fNq5XvuJI/4hwm7hwuM9MsVeshlRDUZJWsZTew3CK3uxsIog8JkvrXC2FiEbhj0StL
         wegyhyNIA2eBFdfFejYuSuiGrwocGv7RhOiMlxN4HhtdfBejTDNFwIhg+oTdhpp+C4VF
         ohl5zoy6EccQ1TPLOVcL6LxqdlPQWaHIQB5y6hua32YaCQpTdJD2VJVW5FGZy+Tvq9BI
         sWI6elZRMQPuTnMnybb71U7SBFlFLTqYA1U7lcqt5OtzhNNXSqi+5baPHySpgDa/n454
         DUjllviwerdru/vkM2sZI+vuRluXOt3f4vPFZu/dv6vC60AeNxFBPRF9an23RkMiuB40
         6Aow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726132257; x=1726737057;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=01YKGFk3SAfDDky5pSAjdfHBUg1pbqc31tmiJcxwToI=;
        b=eQwJThMzIRgG9CnBuE7wasGtEoUZt1uYh4/2FvUsNHcbknSauCZg6hxHQUIC6cZsL/
         zaq6ry8W5nuoL4gvY8Zu0ypLiBl2uiwq407FE+53QyCBjRhTJ9KjYcN4kSyjX0iZjZGi
         xsqKU0I35+aJeTwVXvbX9I8UkFya1QFJNQFs410MdeCMGS4jJhTpg+wqGpBEfo8O++uF
         V61Jbux8J6XOQspqDMP7ph/uIGvyk4g715WZ0C+m1wiO8zY/X8OlKkNuHEYzqNUa3BeU
         dzU6HBppGkxwVt/ikmDbg/ZhcR4P9hCTrMnpYSDl8zdUobI3oKkcS8DKo8YbvaasJBbH
         HaAQ==
X-Forwarded-Encrypted: i=1; AJvYcCXWSZ5wN8gsz6cVSIdOOik1GZK47LAA3T1gU4fzj2+DZ5E9utB5PtvLZDhuZpUSadc6HiXAaTKv7GrH@vger.kernel.org, AJvYcCXz4Md+L8dtUXL2zGZB5xRdF5pExBmfajFcy2BdZPBoOLQU4Mzxsn9fpMirYof/ABA2Hojd5KTQl6JpkVSPrQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzTiQRDPcwC1ACGRyXEn/TN4f/vt+nvMNu/j3JEXepuwrXv2ytv
	f+66KesHqAwv+1IofLZPVHCn3xhBYgEYDa0NW+ObE3eBYRwwu52jDZJaC3adfWTNXJZJKByhbgD
	Myrh1Y2la2m8+lIJf40D3xt2ANxo=
X-Google-Smtp-Source: AGHT+IEaDE9RBD9ZYnJ7bsAsDRA963ducZoLE7UHz6PDCFEYiUE2+BPwa+c6lnjWu5TmyhmUfk2+pjZXh1eFQmlw47U=
X-Received: by 2002:a2e:a98a:0:b0:2ef:29fc:f950 with SMTP id
 38308e7fff4ca-2f787dcd2f8mr3540351fa.6.1726132256376; Thu, 12 Sep 2024
 02:10:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240823082237.713543-1-zhaoyang.huang@unisoc.com>
 <20240903022902.GP9627@mit.edu> <CAGWkznEv+F1A878Nw0=di02DHyKxWCvK0B=93o1xjXK6nUyQ3Q@mail.gmail.com>
 <20240903120840.GD424729@mit.edu> <CAGWkznFu1GTB41Vx1_Ews=rNw-Pm-=ACxg=GjVdw46nrpVdO3g@mail.gmail.com>
 <20240904024445.GR9627@mit.edu> <CAGWkznFGDJsyMUhn5Y8DPmhba9h4GNkX_CaqEMev4z23xa-s6g@mail.gmail.com>
 <20240912084119.j3oqfikuavymctlm@quack3>
In-Reply-To: <20240912084119.j3oqfikuavymctlm@quack3>
From: Zhaoyang Huang <huangzhaoyang@gmail.com>
Date: Thu, 12 Sep 2024 17:10:44 +0800
Message-ID: <CAGWkznG7_=zjKZBO-sj=79F3a3tgZuXqCXbvddDDG2Atv5043g@mail.gmail.com>
Subject: Re: [RFC PATCHv2 1/1] fs: ext4: Don't use CMA for buffer_head
To: Jan Kara <jack@suse.cz>
Cc: "Theodore Ts'o" <tytso@mit.edu>, "zhaoyang.huang" <zhaoyang.huang@unisoc.com>, 
	Andreas Dilger <adilger.kernel@dilger.ca>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, 
	steve.kang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 12, 2024 at 4:41=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> On Wed 04-09-24 14:56:29, Zhaoyang Huang wrote:
> > On Wed, Sep 4, 2024 at 10:44=E2=80=AFAM Theodore Ts'o <tytso@mit.edu> w=
rote:
> > > On Wed, Sep 04, 2024 at 08:49:10AM +0800, Zhaoyang Huang wrote:
> > > > >
> > > > > After all, using GFP_MOVEABLE memory seems to mean that the buffe=
r
> > > > > cache might get thrashed a lot by having a lot of cached disk buf=
fers
> > > > > getting ejected from memory to try to make room for some contiguo=
us
> > > > > frame buffer memory, which means extra I/O overhead.  So what's t=
he
> > > > > upside of using GFP_MOVEABLE for the buffer cache?
> > > >
> > > > To my understanding, NO. using GFP_MOVEABLE memory doesn't introduc=
e
> > > > extra IO as they just be migrated to free pages instead of ejected
> > > > directly when they are the target memory area. In terms of reclaimi=
ng,
> > > > all migrate types of page blocks possess the same position.
> > >
> > > Where is that being done?  I don't see any evidence of this kind of
> > > migration in fs/buffer.c.
> > The journaled pages which carry jh->bh are treated as file pages
> > during isolation of a range of PFNs in the callstack below[1]. The bh
> > will be migrated via each aops's migrate_folio and performs what you
> > described below such as copy the content and reattach the bh to a new
> > page. In terms of the journal enabled ext4 partition, the inode is a
> > blockdev inode which applies buffer_migrate_folio_norefs as its
> > migrate_folio[2].
> >
> > [1]
> > cma_alloc/alloc_contig_range
> >     __alloc_contig_migrate_range
> >         migrate_pages
> >             migrate_folio_move
> >                 move_to_new_folio
> >
> > mapping->aops->migrate_folio(buffer_migrate_folio_norefs->__buffer_migr=
ate_folio)
> >
> > [2]
> > static int __buffer_migrate_folio(struct address_space *mapping,
> >                 struct folio *dst, struct folio *src, enum migrate_mode=
 mode,
> >                 bool check_refs)
> > {
> > ...
> >         if (check_refs) {
> >                 bool busy;
> >                 bool invalidated =3D false;
> >
> > recheck_buffers:
> >                 busy =3D false;
> >                 spin_lock(&mapping->i_private_lock);
> >                 bh =3D head;
> >                 do {
> >                         if (atomic_read(&bh->b_count)) {
> >           //My case failed here as bh is referred by a journal head.
> >                                 busy =3D true;
> >                                 break;
> >                         }
> >                         bh =3D bh->b_this_page;
> >                 } while (bh !=3D head);
>
> Correct. Currently pages with journal heads attached cannot be migrated
> mostly out of pure caution that the generic code isn't sure what's
> happening with them. As I wrote in [1] we could make pages with jhs on
> checkpoint list only migratable as for them the buffer lock is enough to
> stop anybody from touching the bh data. Bhs which are part of a running /
> committing transaction are not realistically migratable but then these
> states are more shortlived so it shouldn't be a big problem.
By observing from our test case, the jh remains there for a long time
when journal->j_free is bigger than j_max_transaction_buffers which
failed cma_alloc. So you think this is rare or abnormal?

[6] j_free & j_max_transaction_buffers
crash_arm64_v8.0.4++> struct
journal_t.j_free,j_max_transaction_buffers 0xffffff80e70f3000 -x
  j_free =3D 0x3f1,
  j_max_transaction_buffers =3D 0x100,

>
> > > > > Just curious, because in general I'm blessed by not having to use=
 CMA
> > > > > in the first place (not having I/O devices too primitive so they =
can't
> > > > > do scatter-gather :-).  So I don't tend to use CMA, and obviously=
 I'm
> > > > > missing some of the design considerations behind CMA.  I thought =
in
> > > > > general CMA tends to used in early boot to allocate things like f=
rame
> > > > > buffers, and after that CMA doesn't tend to get used at all?  Tha=
t's
> > > > > clearly not the case for you, apparently?
> > > >
> > > > Yes. CMA is designed for contiguous physical memory and has been us=
ed
> > > > via cma_alloc during the whole lifetime especially on the system
> > > > without SMMU, such as DRM driver. In terms of MIGRATE_MOVABLE page
> > > > blocks, they also could have compaction path retry for many times
> > > > which is common during high-order alloc_pages.
> > >
> > > But then what's the point of using CMA-eligible memory for the buffer
> > > cache, as opposed to just always using !__GFP_MOVEABLE for all buffer
> > > cache allocations?  After all, that's what is being proposed for
> > > ext4's ext4_getblk().  What's the downside of avoiding the use of
> > > CMA-eligible memory for ext4's buffer cache?  Why not do this for
> > > *all* buffers in the buffer cache?
> > Since migration which arised from alloc_pages or cma_alloc always
> > happens, we need appropriate users over MOVABLE pages. AFAIU, buffer
> > cache pages under regular files are the best candidate for migration
> > as we just need to modify page cache and PTE. Actually, all FSs apply
> > GFP_MOVABLE on their regular files via the below functions.
> >
> > new_inode
> >     alloc_inode
> >         inode_init_always(struct super_block *sb, struct inode *inode)
> >         {
> >          ...
> >             mapping_set_gfp_mask(mapping, GFP_HIGHUSER_MOVABLE);
>
> Here you speak about data page cache pages. Indeed they can be allocated
> from CMA area. But when Ted speaks about "buffer cache" he specifically
> means page cache of the block device inode and there I can see:
>
> struct block_device *bdev_alloc(struct gendisk *disk, u8 partno)
> {
> ...
>         mapping_set_gfp_mask(&inode->i_data, GFP_USER);
> ...
> }
>
> so at this point I'm confused how come you can see block device pages in
> CMA area. Are you using data=3Djournal mode of ext4 in your setup by any
> chance? That would explain it but then that is a horrible idea as well...
The page of 'fffffffe01a51c00'[1] which has bh attached comes from
creating bitmap_blk by ext4_getblk->sb_getblk within process[2] where
the gfpmask has GFP_MOVABLE. IMO, GFP_USER is used for regular file
pages under the super_block but not available for metadata, right?

[1]
crash_arm64_v8.0.4++> kmem -p|grep
ffffff808f0aa150(sb->s_bdev->bd_inode->i_mapping)
fffffffe01a51c00  e9470000 ffffff808f0aa150        3  2 8000000008020
lru,private //within CMA area
fffffffe03d189c0 174627000 ffffff808f0aa150        4  2
2004000000008020 lru,private
fffffffe03d88e00 176238000 ffffff808f0aa150      3f9  2
2008000000008020 lru,private
fffffffe03d88e40 176239000 ffffff808f0aa150        6  2
2008000000008020 lru,private
fffffffe03d88e80 17623a000 ffffff808f0aa150        5  2
2008000000008020 lru,private
fffffffe03d88ec0 17623b000 ffffff808f0aa150        1  2
2008000000008020 lru,private
fffffffe03d88f00 17623c000 ffffff808f0aa150        0  2
2008000000008020 lru,private
fffffffe040e6540 183995000 ffffff808f0aa150      3f4  2
2004000000008020 lru,private

[2]
02148 < 4> [   14.133703] [08-11 18:38:25.133] __find_get_block+0x29c/0x634
02149 < 4> [   14.133711] [08-11 18:38:25.133] __getblk_gfp+0xa8/0x290
0214A < 4> [   14.133716] [08-11 18:38:25.133] ext4_read_inode_bitmap+0xa0/=
0x6c4
0214B < 4> [   14.133725] [08-11 18:38:25.133] __ext4_new_inode+0x34c/0x10d=
4
0214C < 4> [   14.133730] [08-11 18:38:25.133] ext4_create+0xdc/0x1cc
0214D < 4> [   14.133737] [08-11 18:38:25.133] path_openat+0x4fc/0xc84
0214E < 4> [   14.133745] [08-11 18:38:25.133] do_filp_open+0xc0/0x16c
0214F < 4> [   14.133751] [08-11 18:38:25.133] do_sys_openat2+0x8c/0xf8
02150 < 4> [   14.133758] [08-11 18:38:25.133] __arm64_sys_openat+0x78/0xa4
02151 < 4> [   14.133764] [08-11 18:38:25.133] invoke_syscall+0x60/0x11c
02152 < 4> [   14.133771] [08-11 18:38:25.133] el0_svc_common+0xb4/0xe8
02153 < 4> [   14.133777] [08-11 18:38:25.133] do_el0_svc+0x24/0x30
02154 < 4> [   14.133783] [08-11 18:38:25.133] el0_svc+0x3c/0x70

>
>                                                                 Honza
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR

