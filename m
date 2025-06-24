Return-Path: <linux-fsdevel+bounces-52815-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF95FAE71B7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 23:52:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEF9C3B4D5E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 21:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D5B025B1D8;
	Tue, 24 Jun 2025 21:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CfWI5l4A"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2342D258CF8;
	Tue, 24 Jun 2025 21:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750801961; cv=none; b=BWNaRcE7IC1urmqGjaDb/mAM+3KtuR88luV4ri33QMlKPE/cKwGOY+tJNHEj5oH13wVBhY7kFS74qb39RLvR8oXxpmmJ+idGaeNyZwB3e7LcylYM3VWHtccMQ481pLXfua0MUF2tKnmTOYV3m83t8ReYic29PtZ8MWjOa/zQkK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750801961; c=relaxed/simple;
	bh=sC6wgHO9eH3gbsuq2AvQ1YiNFJHZ09MzLzk7cPXCjXs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ccWY7H9SJJW0GxzdeysEkvFYYL+8+ymr/uovz17/GCPJ3crKi1HJVMb7ysa0/IRK9oR2XJBDt8iE09HTQopamQSX0vmEkhMOO32kDstRQ18HIQcjWP64e/Iv1+hffNgzshKBZjSf/+MrkO6LKi6A1ujHUU4CyBWBhkdtQ5SU0Bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CfWI5l4A; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4a44b3526e6so11433871cf.0;
        Tue, 24 Jun 2025 14:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750801959; x=1751406759; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ltCO+pg+j7mpPUg7UdU9LwNKVjQTEPshXqjMTkedVoM=;
        b=CfWI5l4ANj4mokp2O5+ES9U4qmn0JTKoltGXK0eWcyObOHap3aIe9Lyn5gKr4pSrRf
         /pPc9rc1FZdUOjAQMMOL3rn93jT+FQbhi3mA0HWhrdMjax0iwY7xbvEQA36sjE0s7aR+
         k3SYuuBYxIkPaiRAOdIC9m0Rza5jzraUEIukr5xFr3JcCnBh3XvkIzb434EaYRvu4sS5
         W5XpLm5lzGFlWduQJloRjFbVH3aneAEWwXcyEzQ2/O/qiJiLeTenlo60Xc6M+pVkUWKT
         DWU2N3KgZnwH+O6NGxZ86lxUN5NHj8m3lOsHM0wH1I2sdrQ4MxABpMK/0BPVgyzEm2Jf
         n4jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750801959; x=1751406759;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ltCO+pg+j7mpPUg7UdU9LwNKVjQTEPshXqjMTkedVoM=;
        b=nmaQPlofYp7zaxeMS1dX5KWfeuyiUYhOOCe9oJPSwtM1Z00WeoQwRXTt1qCWx3/RiG
         kKR5U9cm+W4kDjjSk90wcRrKLw3IdTwumc9rabuODJs0DPP/zYjsccBtmjx39pD6DwWI
         eXQRNsBeqRv+H5Dywg2Y3aD5rbCH+iB3CgU9yDjQFDc2Q5drkL7LNEaM50TNeV7gsdaG
         y7Iuevs1hwvk/upV+aY5VxDQU0Y9Y1ylPVPdikyRR+Eurrdol5zHd6ZTztoTvBhGir4/
         WHX46CoK3B4lAMJCM6EyFyZmAkMdTa1bje8j5cTNTZaY426EoivLwnMaF2S1I5a7eEP8
         XNvw==
X-Forwarded-Encrypted: i=1; AJvYcCVsW51+efiBy1SP4nthUrLSi/kPRWcNSANoVhTCKHQsbJW80N5gu5tBF2yD5HlHY46/bmfNYVJpge5h@vger.kernel.org, AJvYcCWMvtxIlUPWlx15f1SJDqtcNxGBUZtyO/PYbsBa0NGNXmDiSDxxVHqiSBEWcVGAVNIQLeicX599riuseA==@vger.kernel.org, AJvYcCXAnVnNwSviLXVEI0ZS1oHPWpQTkAJWYtXplSfiU1u51Wf9kRiR6fpIhs697pKa9/21W2G6tDbv495c@vger.kernel.org
X-Gm-Message-State: AOJu0YwI0KpMaaS4rGHOyZJyzvVghqkV0r6Ii9UQWeM04swS9nXIUP1i
	cq2DUUTtkIXFAnfREreHdCYzdoD6Z3xrvRU/ChWDnTOIqW8qn9sMSWj3ub7OLc8lOcF1zN2yplB
	9jWluACq2rjDsL3C3z5mAdOreSbeotdM=
X-Gm-Gg: ASbGncvB1PCI/DzE0UBSjmmnBDSG6NjJILUGMvBSqnBPZhxWiT7AAmPJ3SVZoNjs4vQ
	n3uMVS9yTUYwYiUjaReQN8satIJrlzWw4sJwdYDmHgITODx16P/nLZ+6rWqzQXN/fGkuOmqngFo
	PgJ+0vH+4i4Ssrv15TcWuaDKuYqaowlzaRNYPkxTsXnMA0ZfrlMzXYwVIfPe3YxQscrHDEdA==
X-Google-Smtp-Source: AGHT+IEIQcJlanYBWh+8JVVLaoapTGSrgVkcezH2Jd6X25FPNZsLIeGIDE4Mxrm30rGzbSOgcFfRB0zEa0wED6oydcY=
X-Received: by 2002:a05:622a:18a7:b0:4a7:bf73:c5fb with SMTP id
 d75a77b69052e-4a7c06da56fmr14930661cf.22.1750801958965; Tue, 24 Jun 2025
 14:52:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250624022135.832899-1-joannelkoong@gmail.com>
 <20250624022135.832899-13-joannelkoong@gmail.com> <CAJfpegt-O3fm9y4=NGWJUqgDOxtTkDBfjPnbDjjLbeuFNhUsUg@mail.gmail.com>
In-Reply-To: <CAJfpegt-O3fm9y4=NGWJUqgDOxtTkDBfjPnbDjjLbeuFNhUsUg@mail.gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 24 Jun 2025 14:52:27 -0700
X-Gm-Features: AX0GCFuoxidmV2DONKGBu8GGbT28tUoZhYdBBWC_-QHWqMqDdAas9tv1y3pzzhg
Message-ID: <CAJnrk1Yh957g9Brs1YA3AXnGxaAkHvp9Eummpx8sJtbr4JZJMQ@mail.gmail.com>
Subject: Re: [PATCH v3 12/16] fuse: use iomap for buffered writes
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org, hch@lst.de, brauner@kernel.org, 
	djwong@kernel.org, anuj20.g@samsung.com, linux-xfs@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-block@vger.kernel.org, gfs2@lists.linux.dev, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 24, 2025 at 3:07=E2=80=AFAM Miklos Szeredi <miklos@szeredi.hu> =
wrote:
>
> On Tue, 24 Jun 2025 at 04:23, Joanne Koong <joannelkoong@gmail.com> wrote=
:
>
> >  static ssize_t fuse_cache_write_iter(struct kiocb *iocb, struct iov_it=
er *from)
> >  {
> >         struct file *file =3D iocb->ki_filp;
> > @@ -1384,6 +1418,7 @@ static ssize_t fuse_cache_write_iter(struct kiocb=
 *iocb, struct iov_iter *from)
> >         struct inode *inode =3D mapping->host;
> >         ssize_t err, count;
> >         struct fuse_conn *fc =3D get_fuse_conn(inode);
> > +       bool writeback =3D false;
> >
> >         if (fc->writeback_cache) {
> >                 /* Update size (EOF optimization) and mode (SUID cleari=
ng) */
> > @@ -1397,8 +1432,7 @@ static ssize_t fuse_cache_write_iter(struct kiocb=
 *iocb, struct iov_iter *from)
> >                                                 file_inode(file))) {
> >                         goto writethrough;
> >                 }
> > -
> > -               return generic_file_write_iter(iocb, from);
> > +               writeback =3D true;
>
> Doing this in the else branch makes the writethrough label (which is
> wrong now) unnecessary.

Hi Miklos,

That's a great point, I'll get rid of the writethrough label in v4.


Thanks,
Joanne

>
> Thanks,
> Miklos

