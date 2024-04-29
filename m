Return-Path: <linux-fsdevel+bounces-18185-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C703D8B62BD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 21:43:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F958282A74
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 19:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AB4813B587;
	Mon, 29 Apr 2024 19:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZyNqMME5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F6FE839FD;
	Mon, 29 Apr 2024 19:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714419796; cv=none; b=dIdDmGqFgyJIXP+AwefkyP+lPev4riiE7eMQPWhVO+s+AtDhNQW33v+dOVOfYX230H/GCrwe0WaJisyUqr7Z0+SUA3waFs7o+/J5AY59ZaSUNy/g2TnvjIwmt2XC+XXiB3jOzWeNUFNwemvYSQsbjVgocTvcEgvUWscEhX8HPBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714419796; c=relaxed/simple;
	bh=tl/009IYwx2qJeQv9fMSvqg/ZQzt/JznC46sdr2iiQY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W/wSl0lSZ1fjaqlZhvW1MA7G5V1zpLXLwrGphdLTmdFDM4b6HyM5n+29+7g7MWVQgkXXI6p52dAx38RroHEHidWxjd7h4RC+dkqorSiuk4sgXYU7ebvBO/dKdyPOlVyyy/IdiwF+dnqoryekYStv1DseJIBJXGRTHUsEN3oJ/J0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZyNqMME5; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-7d5db134badso207468539f.2;
        Mon, 29 Apr 2024 12:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714419794; x=1715024594; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1bXEsZemPTapFUBYJYdGYyaTl1e47CcMr+klkQDxtP0=;
        b=ZyNqMME5v22JYWEbj0OwI94B4urPdR6H/AgW9l4boWiZIc6CkFPJAnZLyGzQ+I7Dgu
         P9SGrHhMqIwKAaa2nyEMxc4kqmUSNMNnwgnLV524quIdtdPj2PRH3ihHKp1wwJuZgw31
         ZPQsrrVzHxqr1vGBV/9LQPX3lRLl/IQBBFcgh0WDchH1hlHTJQW80qqY/RX7QXQ21P2c
         ISAbs90c7L24E7tIsC6VRCLVQlCtONGBfEmV2tdxo6nDhJ63JYjlPTdEFdeMgMC3tbOo
         wSmJ/yMfdgCmOqOhZpHn0vpm/gF7npu1x1T/hrStaPrqvlTzOdivNaq61EpR3pAtv/Ix
         kMYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714419794; x=1715024594;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1bXEsZemPTapFUBYJYdGYyaTl1e47CcMr+klkQDxtP0=;
        b=wwDCKA7XQNgrwZox10cjgaD+YTY5hkL3HnfieezqR22qfoIeHUvO+Sbo8PFMEo7OJm
         KoFQ1bQtVh9v2RdXxhOfs9FWZBx5blsjDpzPT54DcCzt2xDQQQnVozZyoZ3X1Fjgaqs7
         5Nsw5Qeo5ne86RSWjQwR25T2OIJip/utgDzrQOhJqTcV0afXZoHdFn73E1+QSlTR5LQr
         j0H03v6m11d4Toa0QrMpjNf1u+iTT0j16yYPVZ+v2uDxLRy3CcgJBnDOH1eGWaIuEx0x
         6L2GcLHJ4ALsoZFr6eVGr4Xgbr4f3a71yU1SvxnY8wv2QJHScJ1DtTzio0BGYJe6SIYZ
         axDQ==
X-Forwarded-Encrypted: i=1; AJvYcCXIwuIuaHCFeXgwMJFT5JftFcp8Vh6H4hdGCl3dpEIuych+4COspB/lmLHwxPup4ckD5K8t2PDOVzBdBYrC6251g8Du51IFEAt22pXWAv1nxqg4QcC7l+KMmRGtkjg5pmNqXCt59PS2LSdeiw==
X-Gm-Message-State: AOJu0YxXkqxT1LJug1FHe4NXQx4nkfsP/mNaUtA/J26RkWcVYjt3LY5U
	1RYUgVuYk35K7J1BB2QHLnYowN1Jg8jv423y9jh9htzBsFf6/9bX3nGuf08ClYnIubo6Iv8jDiv
	FvS2Y6W4g35mplibYj1MvhNotWEs=
X-Google-Smtp-Source: AGHT+IFBsfccKTIUgtY7jo7PWKUIF+Yl965BP3mgAmUMrz8teYaaYNi1DQEwU5Tw7VSl4uBZm/ij82Dtt9Mrt6sMoI0=
X-Received: by 2002:a5d:9642:0:b0:7d3:4ef3:e6c1 with SMTP id
 d2-20020a5d9642000000b007d34ef3e6c1mr13521809ios.10.1714419794363; Mon, 29
 Apr 2024 12:43:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240429190500.30979-1-ryncsn@gmail.com> <20240429191138.34123-1-ryncsn@gmail.com>
 <Zi_zLQqpJ6PRX7HD@casper.infradead.org>
In-Reply-To: <Zi_zLQqpJ6PRX7HD@casper.infradead.org>
From: Kairui Song <ryncsn@gmail.com>
Date: Tue, 30 Apr 2024 03:42:54 +0800
Message-ID: <CAMgjq7A+W9g8Bng22+iROgdq_Khz=v2Mj70VNAH2Q9ckK50AKQ@mail.gmail.com>
Subject: Re: [PATCH v3 08/12] nfs: drop usage of folio_file_pos
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	"Huang, Ying" <ying.huang@intel.com>, Chris Li <chrisl@kernel.org>, 
	Barry Song <v-songbaohua@oppo.com>, Ryan Roberts <ryan.roberts@arm.com>, Neil Brown <neilb@suse.de>, 
	Minchan Kim <minchan@kernel.org>, Hugh Dickins <hughd@google.com>, 
	David Hildenbrand <david@redhat.com>, Yosry Ahmed <yosryahmed@google.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 30, 2024 at 3:21=E2=80=AFAM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Tue, Apr 30, 2024 at 03:11:34AM +0800, Kairui Song wrote:
> > +++ b/fs/nfs/file.c
> > @@ -588,7 +588,7 @@ static vm_fault_t nfs_vm_page_mkwrite(struct vm_fau=
lt *vmf)
> >
> >       dfprintk(PAGECACHE, "NFS: vm_page_mkwrite(%pD2(%lu), offset %lld)=
\n",
> >                filp, filp->f_mapping->host->i_ino,
> > -              (long long)folio_file_pos(folio));
> > +              (long long)folio_pos(folio));
>
> Yes, we can't call page_mkwrite() on a swapcache page.
>
> > +++ b/fs/nfs/nfstrace.h
> > @@ -960,7 +960,7 @@ DECLARE_EVENT_CLASS(nfs_folio_event,
> >                       __entry->fileid =3D nfsi->fileid;
> >                       __entry->fhandle =3D nfs_fhandle_hash(&nfsi->fh);
> >                       __entry->version =3D inode_peek_iversion_raw(inod=
e);
> > -                     __entry->offset =3D folio_file_pos(folio);
> > +                     __entry->offset =3D folio_pos(folio);
> >                       __entry->count =3D nfs_folio_length(folio);
> >               ),
> >
> > @@ -1008,7 +1008,7 @@ DECLARE_EVENT_CLASS(nfs_folio_event_done,
> >                       __entry->fileid =3D nfsi->fileid;
> >                       __entry->fhandle =3D nfs_fhandle_hash(&nfsi->fh);
> >                       __entry->version =3D inode_peek_iversion_raw(inod=
e);
> > -                     __entry->offset =3D folio_file_pos(folio);
> > +                     __entry->offset =3D folio_pos(folio);
>
> These two I don't know about.

I can add a more detailed call chain for this in the commit message to
make it look more convincing.

> > +++ b/fs/nfs/write.c
> > @@ -281,7 +281,7 @@ static void nfs_grow_file(struct folio *folio, unsi=
gned int offset,
> >       end_index =3D ((i_size - 1) >> folio_shift(folio)) << folio_order=
(folio);
> >       if (i_size > 0 && folio_index(folio) < end_index)
> >               goto out;
> > -     end =3D folio_file_pos(folio) + (loff_t)offset + (loff_t)count;
> > +     end =3D folio_pos(folio) + (loff_t)offset + (loff_t)count;
>
> This one concerns me.  Are we sure we can't call nfs_grow_file()
> for a swapfile?

Right, I did a audit of the code, all callers of nfs_grow_file are listed b=
elow:
.write_end -> nfs_write_end -> nfs_update_folio -> nfs_writepage_setup
-> nfs_grow_file
.page_mkwrite -> nfs_vm_page_mkwrite -> nfs_update_folio ->
nfs_writepage_setup -> nfs_grow_file

>
> > @@ -2073,7 +2073,7 @@ int nfs_wb_folio_cancel(struct inode *inode, stru=
ct folio *folio)
> >   */
> >  int nfs_wb_folio(struct inode *inode, struct folio *folio)
> >  {
> > -     loff_t range_start =3D folio_file_pos(folio);
> > +     loff_t range_start =3D folio_pos(folio);
> >       loff_t range_end =3D range_start + (loff_t)folio_size(folio) - 1;
>
> Likewise here.  Are we absolutely certain that swap I/O can't call this
> function?

Similar above:
.release_folio -> nfs_release_folio -> nfs_wb_folio
.launder_folio -> nfs_launder_folio -> nfs_wb_folio
.write_begin -> nfs_write_begin -> nfs_read_folio -> nfs_wb_folio
.read_folio -> nfs_read_folio -> nfs_wb_folio
nfs_update_folio (listed above) -> nfs_writepage_setup ->
nfs_setup_write_request -> nfs_try_to_update_request -> nfs_wb_folio--
.write_begin -> nfs_write_begin -> nfs_flush_incompatible -> nfs_wb_folio
.page_mkwrite -> nfs_vm_page_mkwrite -> nfs_flush_incompatible -> nfs_wb_fo=
lio

And nothing from the swap mapping side can call into fs, except
swap_rw, none of the helpers are called by that.

