Return-Path: <linux-fsdevel+bounces-54187-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95115AFBE21
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jul 2025 00:07:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 656C8425417
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 22:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7341D28A40D;
	Mon,  7 Jul 2025 22:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g2FW0UPi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 409D11DACA1
	for <linux-fsdevel@vger.kernel.org>; Mon,  7 Jul 2025 22:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751926057; cv=none; b=iWoEzGjBe/H7NBUPEFrEt0lI/Wdi62E1082xy51IxSPp3kjNgXS0LlVMHGEvyoY3rr/p1I3gTUHiPGKn5zkzFLHmaU85gLSXMDY9gu5dF3G+redjyObuMLc/b99oD8CnXs9MOcTaxm7gVlJ/7HEnb9lkRgvO7ZdGmLFFdpH0OMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751926057; c=relaxed/simple;
	bh=dCioVVR3aJQNQybpjRR6n6FprbBIc/lqZJarTIG4YUw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aML0hXAD5Lk8SyLzzZqZX372gk/YDLrLQLd1Wz4WoQixxMdhychjbtO8eQBU2WKkTwF2+6XsfsoQjKODk8p93+Z2y6MfAkeuG2GxqaEsgsqNLeJGOtYJmkbLSN23fSZmdPwfOq1rcl6tjgn7l7R2+OQbhngWFvHCYKbedwAWcZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g2FW0UPi; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7d5df741f71so331338585a.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 07 Jul 2025 15:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751926055; x=1752530855; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uX8s+b6D55RJccXTOzRNFyRaAJF+IshWj+rQr6tbgMQ=;
        b=g2FW0UPiZzMH8F+Y5/t92RswtauPem7Upy/XOj4No3lN+zV848PXcUE6n5Vwb+qzzq
         007tDfnMmbo/0/PPVglGy409e7duwImJpZModR2pMChh83IWcTm0hYtjANBkhfxlNIhS
         +DgyYO47z5lnaUYRuCCNf+Ex0lmZxGv2bAw84w8JbyqajmpUk8TRlwL0EnjEK5gPVRQY
         H3Vb5THf5QX8Mr43wfHRVJiguINgj8rKSgzkiTw4UHaUQn6ZBdVax3MDHROCy/eCjIXv
         TmSg4DXTZx1FfIK7KIF+OPlnM0NCnIdiylfZTqZGXTLkBVfaoBvKizkUw6DKX0l6TG1s
         fPAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751926055; x=1752530855;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uX8s+b6D55RJccXTOzRNFyRaAJF+IshWj+rQr6tbgMQ=;
        b=Aip2SRc8a9MNEgJiiyYKVOpaPzN8jchcqqUexpYTU7FCYWX44hVxzZFJ5cwsb5Nu4O
         weLvFCEzjNJqHk+uUtZqKKZX+gfg0OiCybttt+vPM5UxEaOnUcAWqvPMTHRZUMZemQai
         Tiip6g0QXF0OoyPCTMqoLiMdFjiXVmWkvleZsjn3TUZ4E/DBlf4NhzOefx3zFBsyER3k
         Zwys9HLO2hb/ETZXbzTp+4oSDgy9gaeAhwxFbJKMkFF+3fAUUGT7t0JApP+UtuDsQQvj
         OMEqykQgoiTS0E63pIXtLS0vZqjiDPE6YtbI20EkCXUBgkcN347WTpp8a5XI4T3slVr+
         w8NQ==
X-Forwarded-Encrypted: i=1; AJvYcCUxCwiXyl5+Eqt5GFlIs+hU9f8uhsVsCZKEWjaFbPnCkTb07xaoHRxx3Q3DbomqRALX84J/IUoJPQWcAI4K@vger.kernel.org
X-Gm-Message-State: AOJu0YzjLarqZNAxknKh/V0mopXVU7SOe33c0SU4SLdEC7qfYJbeZlbz
	ajk5xMXTzTNgo2wunoS1xSa8D+RFNdsqw84dqVN38NA4wlJs2bsMN9PW7jPMUpee8My+GZkyzuI
	hPZI0srqVd1dcd3SG1V/6Q2smJabICJQ=
X-Gm-Gg: ASbGncsP6bPZCz3Dv0YyJdcS3VNDXhsc2rjuBesfnDFXuzfgRk8bG8jnkT+XERQ551a
	2ThwEVrP1wCFv/twvL2O2o+Qr958BaDWFNM0tuYfJcu1rvKFrh8Yc6WANUqOKIRltaODmEX/TRz
	WHpaGvvpQG8RPu1sBkVwcx/1iTvvsEqVCbyKKBlM2lXqfne+ztJVF4pg/FPFU=
X-Google-Smtp-Source: AGHT+IGiydGMX6t1tb8qEr7lcthgvrxGpYjUhXpTdXMhksGsIsnYUNGVNSPSOznTI+HO/5L1QaeQPkGeedfPBJ7yZLg=
X-Received: by 2002:a05:622a:2cd:b0:4a6:f8aa:3a15 with SMTP id
 d75a77b69052e-4a9ca1a12ddmr41650601cf.30.1751926054870; Mon, 07 Jul 2025
 15:07:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250703192459.3381327-1-willy@infradead.org> <20250703192459.3381327-2-willy@infradead.org>
In-Reply-To: <20250703192459.3381327-2-willy@infradead.org>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Mon, 7 Jul 2025 15:07:24 -0700
X-Gm-Features: Ac12FXymwBCF6bL4AS11jp7BN1THAKMeFje-LH1Kb_FfJEUL8cHkduY_ES2kMn0
Message-ID: <CAJnrk1a09oCC_jGRsfX2XfV3zWdRQmDREMTBt61u6y0jQ9=jRw@mail.gmail.com>
Subject: Re: [PATCH 1/1] fuse: Use filemap_invalidate_pages()
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 3, 2025 at 12:25=E2=80=AFPM Matthew Wilcox (Oracle)
<willy@infradead.org> wrote:
>
> FUSE relies on invalidate_inode_pages2() / invalidate_inode_pages2_range(=
)
> doing writeback by calling fuse_launder_folio().  While this works, it
> is inefficient as each page is written back and waited for individually.
> Far better to call filemap_invalidate_pages() which will do a bulk write
> first, then remove the page cache.

This logic makes sense to me but what about the case where writeback
errors out? With invalidate_inode_pages2() /
invalidate_inode_pages2_range(), the pages still get unmapped, but
with filemap_invalidate_pages(), this will return an error without
unmapping. AFAICT, I think we would still want the unmapping to be
done if there's an error in writeback.

I'm a bit confused about the difference between "each page is written
back and waited for individually" vs bulk write. AFAICT, with the bulk
write, which calls ->writepages(), in fuse this will still write each
page/folio individually through write_cache_pages() and AFAICT, each
page/folio is also waited for individually in
__filemap_fdatawait_range(). With doing the bulk write, I wonder if
this sometimes could be more inefficient than doing the writeback only
after it's been unmapped, eg if there's writes after the
filemap_invalidate_pages() writeback, we'd end up doing 2 writebacks.

>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  fs/fuse/dax.c   | 16 ++++------------
>  fs/fuse/dir.c   | 12 +++++++-----
>  fs/fuse/file.c  | 16 +++++-----------
>  fs/fuse/inode.c | 17 +++++------------
>  4 files changed, 21 insertions(+), 40 deletions(-)
>
> diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
> index 2d817d7cab26..0151343d8393 100644
> --- a/fs/fuse/dir.c
> +++ b/fs/fuse/dir.c
> @@ -718,7 +718,8 @@ static int fuse_create_open(struct mnt_idmap *idmap, =
struct inode *dir,
>                 if (fm->fc->atomic_o_trunc && trunc)
>                         truncate_pagecache(inode, 0);
>                 else if (!(ff->open_flags & FOPEN_KEEP_CACHE))
> -                       invalidate_inode_pages2(inode->i_mapping);
> +                       filemap_invalidate_pages(inode->i_mapping, 0,
> +                                       OFFSET_MAX, false);

nit (here and below): in fuse, the line break spacing for args is
aligned to be right underneath the first arg

>
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index 2b04a142b493..eaa659c08132 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -1566,7 +1567,8 @@ ssize_t fuse_direct_io(struct fuse_io_priv *io, str=
uct iov_iter *iter,
>                 return -ENOMEM;
>
>         if (fopen_direct_io && fc->direct_io_allow_mmap) {
> -               res =3D filemap_write_and_wait_range(mapping, pos, pos + =
count - 1);
> +               res =3D filemap_invalidate_pages(mapping, pos, (pos + cou=
nt - 1),

nit: don't need the parentheses around pos + count - 1

> +                               false);
>                 if (res) {
>                         fuse_io_free(ia);
>                         return res;
> @@ -1580,14 +1582,6 @@ ssize_t fuse_direct_io(struct fuse_io_priv *io, st=
ruct iov_iter *iter,
>                         inode_unlock(inode);
>         }
>
> -       if (fopen_direct_io && write) {
> -               res =3D invalidate_inode_pages2_range(mapping, idx_from, =
idx_to);
> -               if (res) {
> -                       fuse_io_free(ia);
> -                       return res;
> -               }
> -       }

I'm having trouble understanding why we can get rid of this logic
here. Is this because we now do filemap_invalidate_pages() for the "if
(fopen_direct_io && fc->direct_io_allow_mmap)" part above? AFAIS if
fc->direct_io_allow_mmap is false and we're handling a write, we still
need to call invalidate_inode_pages2_range()/filemap_invalidate_pages()
here, no?

> -
>         io->should_dirty =3D !write && user_backed_iter(iter);
>         while (count) {
>                 ssize_t nres;
> @@ -2358,7 +2352,7 @@ static int fuse_file_mmap(struct file *file, struct=
 vm_area_struct *vma)
>                 if ((vma->vm_flags & VM_MAYSHARE) && !fc->direct_io_allow=
_mmap)
>                         return -ENODEV;
>
> -               invalidate_inode_pages2(file->f_mapping);
> +               filemap_invalidate_pages(file->f_mapping, 0, OFFSET_MAX, =
false);
>
>                 if (!(vma->vm_flags & VM_MAYSHARE)) {
>                         /* MAP_PRIVATE */
> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> index ecb869e895ab..905b192fa12e 100644
> --- a/fs/fuse/inode.c
> +++ b/fs/fuse/inode.c
> @@ -559,8 +560,6 @@ int fuse_reverse_inval_inode(struct fuse_conn *fc, u6=
4 nodeid,
>  {
>         struct fuse_inode *fi;
>         struct inode *inode;
> -       pgoff_t pg_start;
> -       pgoff_t pg_end;
>
>         inode =3D fuse_ilookup(fc, nodeid, NULL);
>         if (!inode)
> @@ -573,15 +572,9 @@ int fuse_reverse_inval_inode(struct fuse_conn *fc, u=
64 nodeid,
>
>         fuse_invalidate_attr(inode);
>         forget_all_cached_acls(inode);
> -       if (offset >=3D 0) {
> -               pg_start =3D offset >> PAGE_SHIFT;
> -               if (len <=3D 0)
> -                       pg_end =3D -1;

Should we preserve this len <=3D 0 logic? The len value comes from the
server. If they pass in -1, that means they want the entire file
invalidated.


Thanks,
Joanne

> -               else
> -                       pg_end =3D (offset + len - 1) >> PAGE_SHIFT;
> -               invalidate_inode_pages2_range(inode->i_mapping,
> -                                             pg_start, pg_end);
> -       }
> +       if (offset >=3D 0)
> +               filemap_invalidate_pages(inode->i_mapping, offset,
> +                               offset + len - 1, false);
>         iput(inode);
>         return 0;
>  }
> --
> 2.47.2
>

