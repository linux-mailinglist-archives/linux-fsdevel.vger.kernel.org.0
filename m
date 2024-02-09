Return-Path: <linux-fsdevel+bounces-10910-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B75B84F381
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 11:35:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12950283768
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 10:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 155811CD2E;
	Fri,  9 Feb 2024 10:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LKIXU0m2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1966A4C7C
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 Feb 2024 10:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707474944; cv=none; b=kyFyPSPAFSJ/eISS1nB3ANwnZ7Vpx3ClX1Z9SgudS+6EDIqigku32ypGR7hnfE+mUNe6mrAdHtdIlP7ZJ0SD5wnfOdm7pte9HxRHIwgpQCM0IBMAd+AFcQ1tq+T7oKjSREiwRngPlw5Wn4Lepa/DvbLpDhWDw5kO/dKpfI1KRnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707474944; c=relaxed/simple;
	bh=9mtl4ItgmrNLfMJ0rmotGs9p4TeueREpzK4bidd3EUE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OxJcqzJyXNTM6itaX8aMbxarEhDtjYyUintRvlSJs3CdoeXfgJopaZtF/+TLO+VESAXgdHP4WBTa16pMQX3sLOoCLwUYO1OZZOHI3HHVTQCetl5ZFcudyyqVqIh97ru5bYbUSFPjevHH5f9yaA/OJvZ/9Hoeyv8QcvqkDEfje2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LKIXU0m2; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-42c424b74faso2928631cf.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 09 Feb 2024 02:35:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707474942; x=1708079742; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5BEpWodwEMB4kT3ZRpFwQCWCYq5nRGXHpVqyvcUqSM8=;
        b=LKIXU0m2d7QY7/qifOfL4giPyPWMkSSfyikI7I91VhT+u02ToHoSASUX5RpQGyhw04
         rwFWtnUrKAKZos0oh/uhwe2TKlLuDyviL/KXvIeANpX2U7aZwT9MxTGFqDeknhTcgcOT
         Ku45QFjLYwJExMXS8raEyuz72OX4KnvsaaEbsKrARS5ewV+keUCXpMPK1RocBhRG3JVc
         2EGJ+QOSzNzhiACmt8y8rLDAhIISQa5U995K/7wKG0DeEW9W9A6gcC1ry1qj3+BRrsG7
         BQ7bHUYJL6z1k6WFJLrD6bbHqO+fa9J5ZmsPRcfXW+32LsGlDpIDyhJ6CMUYMo1r3gsl
         Dy1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707474942; x=1708079742;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5BEpWodwEMB4kT3ZRpFwQCWCYq5nRGXHpVqyvcUqSM8=;
        b=n2CHM96az+PvfHWdYhkr5UGJjvGDaoWQypVppcjjpSsAfQZqeenMI18MkvrB7JsLVF
         izxyBa0b8Uo+LdUXB1DBlRVS9zkr/tG77yWMmyPaz+EdAZgGZtIecW2A7lGyL+DejXlG
         76aP1VxxCWstY32v3w2YY/9ipJYzfQdcNvPv4wEJMPnjzL0lflZ5GS7lapPetAq7m2MR
         ICChRsucUTycoywKgDTDJyxxAprmElIUY85iffcCev0EqhvAeWjzmuDoADVYBXwMfKae
         UCKGpBpyFqNTWeI2soVXiSX7omwI9a9vBqTqCO71K5JK0vETYf6IrFPuotjFIgdDFWit
         E9Qg==
X-Forwarded-Encrypted: i=1; AJvYcCWzuB60kouOkO+kcq6tHku9NME+VRq+XdkifnqqJ4do/zn/p+QtmbL4Vj0cj5QrsxYavoFEJU8BhAiiIgzpvhHgNFh8b3DhQ1U4lxZaBw==
X-Gm-Message-State: AOJu0YwNtAnpTkn4Y9Cx9xNxadM83XU7fFkZ+9r7r5y0rmkuSHV02S30
	13gwxGMjwBpT3uXkgpFUfZvSmwCz0cEdNC4WCO+htdSsffTNSagcY7H8d6T8gQ/xknlfhKZKAzb
	YgJn6DFiXMXpH4AcRYCRam2bhguk=
X-Google-Smtp-Source: AGHT+IF9x4un1eufYd8B7zRNsel2nx8lm/a3zf1EEYS2bJwekRDowfuIctNl3sifuetKvd3aHYGMs2wRr8JlaVSYB/g=
X-Received: by 2002:ac8:5cc7:0:b0:42c:2d67:b7d6 with SMTP id
 s7-20020ac85cc7000000b0042c2d67b7d6mr1341569qta.66.1707474941909; Fri, 09 Feb
 2024 02:35:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240208170603.2078871-1-amir73il@gmail.com> <20240208170603.2078871-9-amir73il@gmail.com>
 <CAJfpeguUBet0zCdESe7dasC7YpCEC816CMMRF_s1UYmgU=Ja=w@mail.gmail.com>
In-Reply-To: <CAJfpeguUBet0zCdESe7dasC7YpCEC816CMMRF_s1UYmgU=Ja=w@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 9 Feb 2024 12:35:30 +0200
Message-ID: <CAOQ4uxhBuSQmku70oydUxZmfACuvEqUUvtVcTSJGYOWHj5hvRg@mail.gmail.com>
Subject: Re: [PATCH v3 8/9] fuse: introduce inode io modes
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Bernd Schubert <bernd.schubert@fastmail.fm>, linux-fsdevel@vger.kernel.org, 
	Bernd Schubert <bschubert@ddn.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 9, 2024 at 12:21=E2=80=AFPM Miklos Szeredi <miklos@szeredi.hu> =
wrote:
>
> On Thu, 8 Feb 2024 at 18:09, Amir Goldstein <amir73il@gmail.com> wrote:
>
> > We use an internal FOPEN_CACHE_IO flag to mark a file that was open in
> > caching mode. This flag can not be set by the server.
> >
> > direct_io mmap uses page cache, so first mmap will mark the file as
> > FOPEN_DIRECT_IO|FOPEN_CACHE_IO (i.e. mixed mode) and inode will enter
> > the caching io mode.
>
> I think using FOPEN_CACHE_IO for this is wrong.  Why not just an internal=
 flag?
>

No reason apart from "symmetry" with the other io mode FOPEN flags.
I will use an internal flag.

> > +/* No more pending io and no new io possible to inode via open/mmapped=
 file */
> > +void fuse_file_io_release(struct fuse_file *ff, struct inode *inode)
> > +{
> > +       if (!ff->io_opened)
> > +               return;
> > +
> > +       /* Last caching file close exits caching inode io mode */
> > +       if (ff->open_flags & FOPEN_CACHE_IO)
> > +               fuse_file_cached_io_end(inode);
>
> The above is the only place where io_opened is checked without a
> WARN_ON.   So can't this be incorporated into the flag indicating
> whether caching is on?

I added io_open to fix a bug in an earlier version where fuse_file_release(=
)
was called on the error path after fuse_file_io_open() failed.

The simple change would be to replace FOPEN_CACHE_IO flag
with ff->io_cache_opened bit.

I assume you meant to change ff->io_opened to an enum:
{ FUSE_IO_NONE, FUSE_IO_CACHE, FUSE_IO_DIRECT,
  FUSE_IO_PASSTHROUGH }

Is that what you mean?

Thanks,
Amir.

