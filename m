Return-Path: <linux-fsdevel+bounces-52655-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDA5BAE58A7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 02:35:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6972C4C13B7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 00:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A8F770823;
	Tue, 24 Jun 2025 00:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jPjUoj0i"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD3D2AEED
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Jun 2025 00:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750725351; cv=none; b=Zu1cykc8x303/DGXnstt91jK53Gy1oTxpDHRPaHpNkwtbx9d8JD+GEmfQMqigYC+RwBEDw3r6Ghppzw3eYCCOfIJzGBfE7pgYoZGqyjQnp+hUdBag789xxkzoCnCdRH9D4d+G1RVQ7bvrwYIC7MEXRWBNlVZX7viqVtG2V2Er4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750725351; c=relaxed/simple;
	bh=a+yD7Nf+P3MutO8qFhVKNK7UTYR+yyJmcQQlPeOEGm4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=knIx2nzePBOZLjGYIUPxoHJghBgpguM2QHmuXzT1Y3WdzDC+qxVS+1bB6NNbKdJn+BOcJqzA3FkT7jzTi7yBmFpQSyc9pSJcsud94bmkKaAbFW0ofJJXv8UqCFjWA3sDj+0WcUe3eYysuSVg0DUcuDZ08sJSSHBMCZTAK3iSMv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jPjUoj0i; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4a6f6d07bb5so55237681cf.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Jun 2025 17:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750725349; x=1751330149; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LA7XQFWJGbz7w6oUt8u56g5W6BIHkKXsZ/iBb6fKbuU=;
        b=jPjUoj0iHqReR0s1ZQ/ShYNwsxlcYFqjenjCErNKToy3syq/lsPXj/FMSv0rx78k2V
         AqUO6yqm+PDlUpBph5uOkqPMSFdteO9JRhsJAUiQULFhxq3BZm96935h4WUhvyHf1ilT
         HhQEg4AK1YqaSdDmqin19+4vau+8nfIqsCl1f1cuuqFu2mZLn0AyWZLSK+M94QLzi1Ni
         uDkW4RRzA2vmcTFUO4R/QtAbvjEiW4rUv6hJ97lrN32RM9Hv03L4KwbTiZZ53p6Ya4aJ
         +quebTFSIDEMR1O5qDMNblqL6JCDmiejXA1tuBq0VhC8+HdVVLxolNcduYW0zIT8MIdi
         fSXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750725349; x=1751330149;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LA7XQFWJGbz7w6oUt8u56g5W6BIHkKXsZ/iBb6fKbuU=;
        b=nRvQAseP39swuWnA61t2fLwDN4o9G2dnSQ3p2iEMaOHWHiTNmoQ6v4J0bvPBqpES6W
         1DrWIjPaLM1xDig0bAn9CDbO3M6Zmps3a3thOUwuCQlumCJwr00S12iEjY80ppir5J2/
         AHYsNyxucdL4R0f0YxYvb5ruxUEZJQQsMc9LwK+IUKixDMmUv3ENoK3rkHyo7HNVaeZm
         4PjMwDTiSYTBzZXh3fynI7UY85+X+lrc2gqh6WR7wh8mU16aPWh5elnOwKOfZCmBsuvF
         +Sju/9XCHzoy1t2nPyASzwnWSMurAciwxdsjcIte+z5kQKgcVI8JV9dmTzONtK4QdXKa
         7EYA==
X-Forwarded-Encrypted: i=1; AJvYcCXTxgmFK/m1jj/TQS2pe5/JkC03YVqdY6SP6lxa74KQ95jAeg6OEp9Qr7+z+SypJLxSjBZj83r1Uj0RG93j@vger.kernel.org
X-Gm-Message-State: AOJu0YwKD36wNDGZLUdJwE2T3ly0MN9nzjQxuZ0hjkdH9/2R/BuCfb11
	2VgL30v0wir9dd6eCvx3/0UJGTkqQJ13HYmbw43g5xL+juzQlrB/U4Bejvv/DSZKgJveJMAiG7B
	410M5VJzuHImK+kz2dA/us/3FR01FF3U=
X-Gm-Gg: ASbGncsnyWNnATgLtuSQVkhdJF1tzJGINYi4y2YEGNrVzlPnWXvYUMtwUvR4Fu4woQM
	YD4Qm9BNHhEB094ZaJu+/X6BODdE0kH/0Sky2lzMgjiJrImqd9VgFJ5wNdWTiLa+3u0CXKtuozY
	sFeNOxmVo7dijudpilb5jb6G0TdfrvNGfsoef9PCfwbbM=
X-Google-Smtp-Source: AGHT+IFLiJjDZuzI68SGSqrskLO59BY3Po35MyhOTOW5vOo5kTvmXs5vU0ZSAbfpmUuJ2kCwHDEUYZR7OFI8iH/qu6M=
X-Received: by 2002:ac8:6f0b:0:b0:4a5:a447:679f with SMTP id
 d75a77b69052e-4a77a1c727bmr257092661cf.22.1750725348787; Mon, 23 Jun 2025
 17:35:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250614000114.910380-1-joannelkoong@gmail.com> <aE1VvnDfZj0oJMMv@bfoster>
In-Reply-To: <aE1VvnDfZj0oJMMv@bfoster>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Mon, 23 Jun 2025 17:35:38 -0700
X-Gm-Features: AX0GCFvLjjgxvTKmasE1UJtLHJsB6Ay5Jm8LaPVjb-mvccAoyf8I-HNHQsdU_4M
Message-ID: <CAJnrk1aUqLeas5n4qo7VpVn-+tgRZfBTSyhFR95TxXOzMDjKVA@mail.gmail.com>
Subject: Re: [PATCH] fuse: fix fuse_fill_write_pages() upper bound calculation
To: Brian Foster <bfoster@redhat.com>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, 
	Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 14, 2025 at 3:54=E2=80=AFAM Brian Foster <bfoster@redhat.com> w=
rote:
>
> On Fri, Jun 13, 2025 at 05:01:14PM -0700, Joanne Koong wrote:
> > This fixes a bug in commit 63c69ad3d18a ("fuse: refactor
> > fuse_fill_write_pages()") where max_pages << PAGE_SHIFT is mistakenly
> > used as the calculation for the max_pages upper limit but there's the
> > possibility that copy_folio_from_iter_atomic() may copy over bytes
> > from the iov_iter that are less than the full length of the folio,
> > which would lead to exceeding max_pages.
> >
> > This commit fixes it by adding a 'ap->num_folios < max_folios' check.
> >
> > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > Fixes: 63c69ad3d18a ("fuse: refactor fuse_fill_write_pages()")
> > Reported-by: Brian Foster <bfoster@redhat.com>
> > Closes: https://lore.kernel.org/linux-fsdevel/aEq4haEQScwHIWK6@bfoster/
> > ---
>
> This resolves the problem for me as well. Thanks again..
>
> Tested-by: Brian Foster <bfoster@redhat.com>
>
> >  fs/fuse/file.c | 5 ++---
> >  1 file changed, 2 insertions(+), 3 deletions(-)
> >
> > diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> > index 3d0b33be3824..a05a589dc701 100644
> > --- a/fs/fuse/file.c
> > +++ b/fs/fuse/file.c
> > @@ -1147,7 +1147,7 @@ static ssize_t fuse_send_write_pages(struct fuse_=
io_args *ia,
> >  static ssize_t fuse_fill_write_pages(struct fuse_io_args *ia,
> >                                    struct address_space *mapping,
> >                                    struct iov_iter *ii, loff_t pos,
> > -                                  unsigned int max_pages)
> > +                                  unsigned int max_folios)
> >  {
> >       struct fuse_args_pages *ap =3D &ia->ap;
> >       struct fuse_conn *fc =3D get_fuse_conn(mapping->host);
> > @@ -1157,12 +1157,11 @@ static ssize_t fuse_fill_write_pages(struct fus=
e_io_args *ia,
> >       int err =3D 0;
> >
> >       num =3D min(iov_iter_count(ii), fc->max_write);
> > -     num =3D min(num, max_pages << PAGE_SHIFT);
> >
> >       ap->args.in_pages =3D true;
> >       ap->descs[0].offset =3D offset;
> >
> > -     while (num) {
> > +     while (num && ap->num_folios < max_folios) {
> >               size_t tmp;
> >               struct folio *folio;
> >               pgoff_t index =3D pos >> PAGE_SHIFT;
> > --
> > 2.47.1
> >
>

Miklos or Christian, could this fix be added to the next release candidate?


Thanks,
Joanne

