Return-Path: <linux-fsdevel+bounces-58038-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA12BB283AE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Aug 2025 18:17:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16693AE064E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Aug 2025 16:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABE9029A9E9;
	Fri, 15 Aug 2025 16:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="it8z+eOT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94B2F219EB
	for <linux-fsdevel@vger.kernel.org>; Fri, 15 Aug 2025 16:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755274621; cv=none; b=ECuxTLvZETEz4hIySjx0cY02BrBOOM3oGiSN67elcDt98P1Td6ZJyVgIN8+X9q4xW0p8BOVcZXTI2WTgZ9DFq7BOjrFgUBolNnGTQPw3rHPYZIUT5iqZ133RG+SR2BfOuLgJN5t9m/v4sfkrLQGimIAj+E74qj3UufErAoPYkrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755274621; c=relaxed/simple;
	bh=EbXH8eBncAZ7u9jAo+VyZ1nwr8mLrJHAzWoQ9/7Ft88=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TzMotmfvAGPXccorUZkRfEDsQnVmQ2g6JIGXG9v6mc5WJNagC2UdDULhraQv8jKwMLozzNrqEsZ5yZ/1JA4icnilGMAEamxu091LhQtm83V75q54vv7R0F4GlI56/ndGla1Ax4V2p6Bk1djpCtK2KkoyMGREmiV1Fs3XCfq8OLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=it8z+eOT; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4b109c4af9eso18518811cf.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 Aug 2025 09:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755274618; x=1755879418; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zp5ARNm0Kb3OVppR7XpDwIuE+JauAwExBKb7u+Bnkx8=;
        b=it8z+eOTVRjqHfsAcnki/M0CT/6hbMkULgwZFlnVlAqRSw/G1cGYzYfiNAGMHBTyUC
         LuQIYJTZzC6aWLNS8ui3SlRjzGmovCw0Bed+IoBeeoDTUE9uxz8/159AtQI/u4PMbRpE
         qqmt7QJmrQ76zCYDPVLZn67KXeIS1B4WKv/3b+fHjzU9WbdAZqfSGaQ7jxHxcAFDL5Bn
         ZruPq/56AZpTzvntTXhopq/ZwALPQIRRdfz/cmeje0jhZruwwDkGAvlaNX7YHpcbN92S
         NoPHxAcWWcNz4MNzcBOxtLRmKwevXExcdx0vxizSkr5TbvmBt2HGzT1ZeOo4ptpZBSJ4
         LFtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755274618; x=1755879418;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zp5ARNm0Kb3OVppR7XpDwIuE+JauAwExBKb7u+Bnkx8=;
        b=e/1DQG1rnNwe4mQyWavowOQ3OaGGuq7Xc8veNa+c5Wi/8NlTVXNW80wPuhZW/TBZ+p
         8Zf5pDNl7Rk0GTHDYdWdDHfxiB0gCt9sWelTI5VtLJqjjSACuSDVw80JApBdW3pSQOWT
         EGzpeIWb7ccvlUSpb1bazHj+2OwUkwjaR+lkm1vVxjkVaFjkuASlIQPf7nLxdOQ8O+/z
         VOOAd32qMABhbRpRSrs4uyYQsQsDE5jgizxDf/pI5krvqgv9Q61ebnPbbV+Ic78v50ml
         OfDLBqZUYLR2nKJLDAQogrc6P98z3qC7eOLd6ctHHbhK/KawhLkCDITAeRaHr/xbbxSG
         UKhQ==
X-Forwarded-Encrypted: i=1; AJvYcCXKpxmwmVT6Y9t9fUNvL1Kc3i9sdD0C0hd3/t0vUnflZNz5JwkSs4tIYzfCeCujfSqaHNNEF59Ni/CZxkuk@vger.kernel.org
X-Gm-Message-State: AOJu0Yxkec+qqwxx5sTIdhTRi0iQ/eenWsHNa/ONyvg9jhNLLKK6LwpQ
	0Axsjse41b4cbvdDugFJchlmD7m6v4EZ7hvHS4CY6lXAcnuNio936cPAjP/zrIcwJJ3faQ4u6cl
	xJcwQD1/MdTcHnBd8bcusu1ZYd2vIyAA=
X-Gm-Gg: ASbGncvtt3XgMMhwU7g9Hsx2QuSLu6EYSSBFthQ5KZUGcPJjALFhAu5tyG5s2mTBncO
	z9VV4c6/V+Ct9L8QUgYZmSZ0oSjrKwB3ZnEt+sXKoxNVZn4VryQlT/Me+L/4XqHdcBhGSLtJhor
	9Ij6jpT/DYcQzxZKmoGdc0m1KhDY+LwofBfYwdx22sKoAq1pEKoeoGpMGgHHcTU5ETDblYqINQF
	MBlG499
X-Google-Smtp-Source: AGHT+IHHDgFog+tpaDn1EqR9Cg/0B0IKEYDeDaM64/qdLnTFwNuXN3mWawxLWzqrnTi4T1gaqsDDFfWxTV6Z8FoXSdo=
X-Received: by 2002:ac8:7f8d:0:b0:4b0:6ffc:e0d2 with SMTP id
 d75a77b69052e-4b11e295226mr37378921cf.44.1755274618102; Fri, 15 Aug 2025
 09:16:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250811204008.3269665-1-joannelkoong@gmail.com> <6bd47f03-8638-4460-9349-deebd1184b45@linux.alibaba.com>
In-Reply-To: <6bd47f03-8638-4460-9349-deebd1184b45@linux.alibaba.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Fri, 15 Aug 2025 09:16:46 -0700
X-Gm-Features: Ac12FXyLZACn_LKnx2ZLSKfdhTbIpxSWUi44lM_LSfs4YlN83ePNTFsWNjp64os
Message-ID: <CAJnrk1b1twpme35YVgvzKj8Hq8E9DXpAi+Jb8=pQCpXQrkSaFA@mail.gmail.com>
Subject: Re: [PATCH] fuse: enable large folios (if writeback cache is unused)
To: Jingbo Xu <jefflexu@linux.alibaba.com>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, 
	bernd.schubert@fastmail.fm, willy@infradead.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 15, 2025 at 4:01=E2=80=AFAM Jingbo Xu <jefflexu@linux.alibaba.c=
om> wrote:
>
>
>
> On 8/12/25 4:40 AM, Joanne Koong wrote:
> > Large folios are only enabled if the writeback cache isn't on.
> > (Strictlimiting needs to be turned off if the writeback cache is used i=
n
> > conjunction with large folios, else this tanks performance.)
> >
> > Benchmarks showed noticeable improvements for writes (both sequential
> > and random). There were no performance differences seen for random read=
s
> > or direct IO. For sequential reads, there was no performance difference
> > seen for the first read (which populates the page cache) but subsequent
> > sequential reads showed a huge speedup.
> >
> > Benchmarks were run using fio on the passthrough_hp fuse server:
> > ~/libfuse/build/example/passthrough_hp ~/libfuse ~/fuse_mnt --nopassthr=
ough --nocache
> >
> > run fio in ~/fuse_mnt:
> > fio --name=3Dtest --ioengine=3Dsync --rw=3Dwrite --bs=3D1M --size=3D5G =
--numjobs=3D2 --ramp_time=3D30 --group_reporting=3D1
> >
> > Results (tested on bs=3D256K, 1M, 5M) showed roughly a 15-20% increase =
in
> > write throughput and for sequential reads after the page cache has
> > already been populated, there was a ~800% speedup seen.
> >
> > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > ---
> >  fs/fuse/file.c | 18 ++++++++++++++++--
> >  1 file changed, 16 insertions(+), 2 deletions(-)
> >
> > diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> > index adc4aa6810f5..2e7aae294c9e 100644
> > --- a/fs/fuse/file.c
> > +++ b/fs/fuse/file.c
> > @@ -1167,9 +1167,10 @@ static ssize_t fuse_fill_write_pages(struct fuse=
_io_args *ia,
> >               pgoff_t index =3D pos >> PAGE_SHIFT;
> >               unsigned int bytes;
> >               unsigned int folio_offset;
> > +             fgf_t fgp =3D FGP_WRITEBEGIN | fgf_set_order(num);
> >
> >   again:
> > -             folio =3D __filemap_get_folio(mapping, index, FGP_WRITEBE=
GIN,
> > +             folio =3D __filemap_get_folio(mapping, index, fgp,
> >                                           mapping_gfp_mask(mapping));
> >               if (IS_ERR(folio)) {
> >                       err =3D PTR_ERR(folio);
> > @@ -3155,11 +3156,24 @@ void fuse_init_file_inode(struct inode *inode, =
unsigned int flags)
> >  {
> >       struct fuse_inode *fi =3D get_fuse_inode(inode);
> >       struct fuse_conn *fc =3D get_fuse_conn(inode);
> > +     unsigned int max_pages, max_order;
> >
> >       inode->i_fop =3D &fuse_file_operations;
> >       inode->i_data.a_ops =3D &fuse_file_aops;
> > -     if (fc->writeback_cache)
> > +     if (fc->writeback_cache) {
> >               mapping_set_writeback_may_deadlock_on_reclaim(&inode->i_d=
ata);
> > +     } else {
> > +             /*
> > +              * Large folios are only enabled if the writeback cache i=
sn't on.
> > +              * If the writeback cache is on, large folios should only=
 be
> > +              * enabled in conjunction with strictlimiting turned off,=
 else
> > +              * performance tanks.
> > +              */
> > +             max_pages =3D min(min(fc->max_write, fc->max_read) >> PAG=
E_SHIFT,
> > +                             fc->max_pages);
> > +             max_order =3D ilog2(max_pages);
> > +             mapping_set_folio_order_range(inode->i_mapping, 0, max_or=
der);
> > +     }
>
> JFYI fc->max_read shall also be honored when calculating max_order,
> otherwise the following warning in fuse_readahead() may be triggered.
>
Hi Jingbo,

I think fc->max_read gets honored in the "min(fc->max_write,
fc->max_read)" part of the max_pages calculation above.

Thanks,
Joanne
>                         /*
>                          * Large folios belonging to fuse will never
>                          * have more pages than max_pages.
>                          */
>                          WARN_ON(!pages);
>
>
> --
> Thanks,
> Jingbo
>

