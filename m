Return-Path: <linux-fsdevel+bounces-70412-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88B9DC99AC3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 02 Dec 2025 01:47:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA1AE3A5320
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Dec 2025 00:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AD1012DDA1;
	Tue,  2 Dec 2025 00:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="paoB0yff"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E66731FD4
	for <linux-fsdevel@vger.kernel.org>; Tue,  2 Dec 2025 00:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764636452; cv=none; b=t0gUT1hn6RCfXXlqAEyDX9KQQ+9yGVCINRsfxf1F8gdUHlsgjO75HcJsSrxwhdpUvHFe6YyN6GG0+MENPgp7Kfl7rbgIEuoKQvKRwNQs4ya+AAjk7t6Ji9OlKbPSXTHpQj6cvx1RqkbHxaR+6dpeDK/x7YTkB50kmEGfEPc6pqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764636452; c=relaxed/simple;
	bh=PkIuNNc2EKZIO25rdLE3EzT3RYF1FagQEdx9khsy5rw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q53VVROBIcVaZFRRl22T7GueQseQwrFNU3MXE7g/1ggB8uIXXf0WDi2ZfafPnU+Yq3AieWOMA3lFE2Qgp6T0m6AnYVMuOajo5GdJatilMZyF/LOt44EYmAR15akJDHoP3iZkgal0IgDEDSRI6MxIM/9xYU0o0gRHGpjgo2+bG3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=paoB0yff; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65CFAC4CEF1
	for <linux-fsdevel@vger.kernel.org>; Tue,  2 Dec 2025 00:47:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764636451;
	bh=PkIuNNc2EKZIO25rdLE3EzT3RYF1FagQEdx9khsy5rw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=paoB0yffxSIYxqx9bWGRTkLBp9MB3u6ajTbmzkVFC+GN3h0lnlc5s2oAaWRLf1soF
	 A28WPpdKzWW5kALacOzJ13vuTCuMgwIYzFCgLsNFtHXKjeFk5exTkU695wYnPuvkUL
	 a8gSrfyVrhcpNEtfjfa0YM9eTFeZ+84A38mafQfSPk5AM7lEcz8fs/H0e7WIx+NdqC
	 Vh/2jHYqc2xnGL8JGbIiwewZcjSyilUGiuexX6w3/nP4TMhCvGjp6eoZcVVgMACrOC
	 0gRwnMDeoNJ4sCB7Y2nzTRoujfqPoN0wc8iICvgAq5G9G/WFfaAFf8I/XwilZuYHxo
	 wPJeDA6FLOqfw==
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6406f3dcc66so8465408a12.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 Dec 2025 16:47:31 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUXQYWFp1YnfOqQGbkHS/+juR8UiRzjBQ0OZlRTgdXBPqsJXzYkkVeoJasoQOQXD1vL7vmYhsbnDPEWrpBO@vger.kernel.org
X-Gm-Message-State: AOJu0YzGCSu+NBLoTPEwjlQ385BhYAiejqWccVBNiPCoOEqCNtzpJJnz
	fD6PcHxud/mjDIJ0qWsfSOeUlFOsUn2zmHEK22lLc6TJQTyCeflCiosN9DFUQZGOL/CaBoad/wE
	TBRJ3KnCKYeBcWN2qFqFXV/jMfIAq5Ow=
X-Google-Smtp-Source: AGHT+IGCcsgblkTBuTj8+vKcojL9omyRyNafKJ1r+AWjcOv3EkUI3VHd7seer0OUtXWYwnoz0KUzHmubttkkJRiXxY0=
X-Received: by 2002:a05:6402:274f:b0:645:cd64:31c5 with SMTP id
 4fb4d7f45d1cf-645cd6431f3mr27115404a12.26.1764636449990; Mon, 01 Dec 2025
 16:47:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251127045944.26009-1-linkinjeon@kernel.org> <20251127045944.26009-7-linkinjeon@kernel.org>
 <aS1FVIfE0Ntgbr5I@infradead.org>
In-Reply-To: <aS1FVIfE0Ntgbr5I@infradead.org>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Tue, 2 Dec 2025 09:47:17 +0900
X-Gmail-Original-Message-ID: <CAKYAXd9YW_UL2uA8anoVCw+a818y5dwtn3xAJJQc=_p32GA=Zw@mail.gmail.com>
X-Gm-Features: AWmQ_bnp21922VrBtZetb79W5fPhgBiTSIx22FC6BnNbpB4_U978ycypfW6h1Nk
Message-ID: <CAKYAXd9YW_UL2uA8anoVCw+a818y5dwtn3xAJJQc=_p32GA=Zw@mail.gmail.com>
Subject: Re: [PATCH v2 06/11] ntfsplus: add iomap and address space operations
To: Christoph Hellwig <hch@infradead.org>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, hch@lst.de, tytso@mit.edu, 
	willy@infradead.org, jack@suse.cz, djwong@kernel.org, josef@toxicpanda.com, 
	sandeen@sandeen.net, rgoldwyn@suse.com, xiang@kernel.org, dsterba@suse.com, 
	pali@kernel.org, ebiggers@kernel.org, neil@brown.name, amir73il@gmail.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	iamjoonsoo.kim@lge.com, cheol.lee@lge.com, jay.sim@lge.com, gunho.lee@lge.com, 
	Hyunchul Lee <hyc.lee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 1, 2025 at 4:35=E2=80=AFPM Christoph Hellwig <hch@infradead.org=
> wrote:
>
> > +#include "ntfs_iomap.h"
> > +
> > +static s64 ntfs_convert_page_index_into_lcn(struct ntfs_volume *vol, s=
truct ntfs_inode *ni,
> > +             unsigned long page_index)
> > +{
> > +     sector_t iblock;
> > +     s64 vcn;
> > +     s64 lcn;
> > +     unsigned char blocksize_bits =3D vol->sb->s_blocksize_bits;
> > +
> > +     iblock =3D (s64)page_index << (PAGE_SHIFT - blocksize_bits);
> > +     vcn =3D (s64)iblock << blocksize_bits >> vol->cluster_size_bits;
>
> I've seen this calculate in quite a few places, should there be a
> generic helper for it?
Okay. I will add it.
>
> > +struct bio *ntfs_setup_bio(struct ntfs_volume *vol, blk_opf_t opf, s64=
 lcn,
> > +             unsigned int pg_ofs)
> > +{
> > +     struct bio *bio;
> > +
> > +     bio =3D bio_alloc(vol->sb->s_bdev, 1, opf, GFP_NOIO);
> > +     if (!bio)
> > +             return NULL;
>
> bio_alloc never returns NULL if it can sleep.
Okay.
>
> > +     bio->bi_iter.bi_sector =3D ((lcn << vol->cluster_size_bits) + pg_=
ofs) >>
> > +             vol->sb->s_blocksize_bits;
>
> With a helper to calculate the sector the ntfs_setup_bio helper becomes
> somewhat questionable.
Okay, I will check it.
>
> > +static int ntfs_read_folio(struct file *file, struct folio *folio)
> > +{
> > +     loff_t i_size;
> > +     struct inode *vi;
> > +     struct ntfs_inode *ni;
> > +
> > +     vi =3D folio->mapping->host;
> > +     i_size =3D i_size_read(vi);
> > +     /* Is the page fully outside i_size? (truncate in progress) */
> > +     if (unlikely(folio->index >=3D (i_size + PAGE_SIZE - 1) >>
> > +                     PAGE_SHIFT)) {
> > +             folio_zero_segment(folio, 0, PAGE_SIZE);
> > +             ntfs_debug("Read outside i_size - truncated?");
> > +             folio_mark_uptodate(folio);
> > +             folio_unlock(folio);
> > +             return 0;
> > +     }
>
> iomap should be taking care of this, why do you need the extra
> handling?
This is a leftover from old ntfs, so I will remove it.
>
> > +     /*
> > +      * This can potentially happen because we clear PageUptodate() du=
ring
> > +      * ntfs_writepage() of MstProtected() attributes.
> > +      */
> > +     if (folio_test_uptodate(folio)) {
> > +             folio_unlock(folio);
> > +             return 0;
> > +     }
>
> Clearing the folio uptodate flag sounds fairly dangerous, why is that
> done?
This is a leftover from old ntfs, I will check it.
>
> > +static int ntfs_write_mft_block(struct ntfs_inode *ni, struct folio *f=
olio,
> > +             struct writeback_control *wbc)
>
> Just a very high-level comment here with no immediate action needed:
> Is there a reall good reason to use the page cache for metadata?
> Our experience with XFS is that a dedicated buffer cache is not only
> much easier to use, but also allows for much better caching.
Nothing special reason, It was to use existing ones instead of new,
complex implementations. NTFS metadata is treated as a file, and
handling it via the folio(page) API allows the driver to easily gain
performance benefits, such as readahead.
>
> > +static void ntfs_readahead(struct readahead_control *rac)
> > +{
> > +     struct address_space *mapping =3D rac->mapping;
> > +     struct inode *inode =3D mapping->host;
> > +     struct ntfs_inode *ni =3D NTFS_I(inode);
> > +
> > +     if (!NInoNonResident(ni) || NInoCompressed(ni)) {
> > +             /* No readahead for resident and compressed. */
> > +             return;
> > +     }
> > +
> > +     if (NInoMstProtected(ni) &&
> > +         (ni->mft_no =3D=3D FILE_MFT || ni->mft_no =3D=3D FILE_MFTMirr=
))
> > +             return;
>
> Can you comment on why readahead is skipped here?
Okay, I will add it.
>
> > +/**
> > + * ntfs_compressed_aops - address space operations for compressed inod=
es
> > + */
> > +const struct address_space_operations ntfs_compressed_aops =3D {
>
> From code in other patches is looks like ntfs never switches between
> compressed and non-compressed for live inodes?  In that case the
> separate aops should be fine, as switching between them at runtime
> would involve races.  Is the compression policy per-directory?
Non-compressed files can actually be switched to compressed files and
vice versa via setxattr at runtime. I will check the race handling
around aop switching again. And the compression policy is per-file,
not per-directory.
>
> > +             kaddr =3D kmap_local_folio(folio, 0);
> > +             offset =3D (loff_t)idx << PAGE_SHIFT;
> > +             to =3D min_t(u32, end - offset, PAGE_SIZE);
> > +
> > +             memcpy(buf + buf_off, kaddr + from, to);
> > +             buf_off +=3D to;
> > +             kunmap_local(kaddr);
> > +             folio_put(folio);
> > +     }
>
> Would this be a candidate for memcpy_from_folio?
Right, I will change it.
>
> > +             kaddr =3D kmap_local_folio(folio, 0);
> > +             offset =3D (loff_t)idx << PAGE_SHIFT;
> > +             to =3D min_t(u32, end - offset, PAGE_SIZE);
> > +
> > +             memcpy(kaddr + from, buf + buf_off, to);
> > +             buf_off +=3D to;
> > +             kunmap_local(kaddr);
> > +             folio_mark_uptodate(folio);
> > +             folio_mark_dirty(folio);
>
> And memcpy_to_folio?
Okay, I will change it.
>
> > +++ b/fs/ntfsplus/ntfs_iomap.c
>
> Any reason for the ntfs_ prefix here?
No reason, I will change it to iomap.c
>
> > +static void ntfs_iomap_put_folio(struct inode *inode, loff_t pos,
> > +             unsigned int len, struct folio *folio)
> > +{
>
> This seems to basically be entirely about extra zeroing.  Can you
> explain why this is needed in a comment?
Okay, I will add a comment for this.
>
> > +static int ntfs_read_iomap_begin(struct inode *inode, loff_t offset, l=
off_t length,
> > +             unsigned int flags, struct iomap *iomap, struct iomap *sr=
cmap)
> > +{
> > +     struct ntfs_inode *base_ni, *ni =3D NTFS_I(inode);
> > +     struct ntfs_attr_search_ctx *ctx;
> > +     loff_t i_size;
> > +     u32 attr_len;
> > +     int err =3D 0;
> > +     char *kattr;
> > +     struct page *ipage;
> > +
> > +     if (NInoNonResident(ni)) {
>
> Can you split the resident and non-resident cases into separate
> helpers to keep this easier to follow?
> easier to follow?
Okay. I will.
>
> > +     ipage =3D alloc_page(__GFP_NOWARN | __GFP_IO | __GFP_ZERO);
> > +     if (!ipage) {
> > +             err =3D -ENOMEM;
> > +             goto out;
> > +     }
> > +
> > +     memcpy(page_address(ipage), kattr, attr_len);
>
> Is there a reason for this being a page allocation vs a kmalloc
> sized to the inline data?
No reason, I will change it to kmalloc sized.
>
> > +static int ntfs_buffered_zeroed_clusters(struct inode *vi, s64 vcn)
>
> I think this should be ntfs_buffered_zero_clusters as it
> performans the action?
Okay. I will change it.
>
> Also curious why this can't use the existing iomap zeroing helper?
I will check it.
>
> > +int ntfs_zeroed_clusters(struct inode *vi, s64 lcn, s64 num)
>
> ntfs_zero_clusters
Okay.
>
> Again curious why we need special zeroing code in the file system.
To prevent reading garbage data after a new cluster allocation, we
must zero out the cluster. The cluster size can be up to 2MB, I will
check if that's possible through iomap.
>
> > +     if (NInoNonResident(ni)) {
>
> Another case for splitting the resident/non-resident code instead
> of having a giant conditional block that just returns.
Okay. Thanks for your review!
>

