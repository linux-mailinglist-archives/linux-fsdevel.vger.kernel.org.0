Return-Path: <linux-fsdevel+bounces-10942-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05B6984F4D5
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 12:50:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B620928D50D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 11:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C60D2E84A;
	Fri,  9 Feb 2024 11:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VmNA8lMA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C572929CF8
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 Feb 2024 11:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707479422; cv=none; b=MlbJEWRA9pkU+S/DzRLc5NszPF9LN6bW1mUS1dpbib1tFrm49vlJhOcEIc4rmQa1VzH5+jSAHTBpDAXovVebO9qEoc1oi3cxunLF9aPTYDhG4k8pv8uPg7dv4LldReDFlMUjmnil7iEQyfsatqNhZIrCRpUBs7Ui05PTCBP+6rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707479422; c=relaxed/simple;
	bh=gAvd7U/OnwLZlOS9bnzYjNQ7Bialnhg1WBrsJ13XsmY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YqD42LmGg23DNH4ZMiuvOVpUuROK07HzVks1NV4BjlyWqZbLnV/ff0aLJafyI3/1HHOwAv73ISLYFl4MYlCeDpih42HeunT8RUWgzMCeX2lNR+tc2Gu7kfRuwJ8ZjmNvaotMVag5AF1roEsgoR8GHH4YIAyhN7hM+R6XNQXgMWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VmNA8lMA; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3bbb4806f67so523768b6e.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 09 Feb 2024 03:50:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707479417; x=1708084217; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/bKD5h6wGnGHn/ulblxf6l0v/ICTEl3Xld2zF9z/GjQ=;
        b=VmNA8lMA19OqygZrJ/k9wnNFJpv0jP0MBF/710bL2JB0Ch4jLqcEmxdP8xw8DKXNJ1
         FzCWsoc1XanAFZ7IomJrp6g8QaIBav54kVE2B6cqNU/uU9hPrYFH3wbPLrs3ndPD+o/C
         0TcME0E1W5sp5GqX40Cb33M8vFqst+ozKsMXlSzAarBC8O7Hh9R7W0KucNzeaLbjRGfB
         jFim63/r6ilRhnRcLAGfpVOGJURJKhvP/cJG2iYzrQHIEue9cTYy2++qHer50AnYtUp+
         6Iqn3AnIhdx52Du2RpiqPSVhvFsdMZTC+YeSih1oeutJmBxLO4deqkSXGg1l7cvnkkRL
         HdLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707479417; x=1708084217;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/bKD5h6wGnGHn/ulblxf6l0v/ICTEl3Xld2zF9z/GjQ=;
        b=fXt7ry0k7UliprFLm0wqJ1nuigNKwQiQ6Uy33uLE77AU0s8rGnz+bDTYaw692JFJMM
         0Bg06kpYJHmAcLQOs8AknhDHmfmpMOCDnM1EFQ/kNU4bWuhEvVFfZNdRZjhnQn3zgpAN
         JEywHUv0YqDbIsu8DDbgohx3TEiUrVnqhOT9OZ9uQXbUq6zl4tfA3MJiYOFGrFHUvv6I
         PtAZFHvq8kIVi9XZSKgrkGbe4QeT2cuxtlPI4aHyabeAz264JQhtj1gTpiQ9SFB3gCQv
         EdmS5A/HS+7/LVBBgSZH50oANELzGqUaRN+UwCPcXDtVWnuXjNflLwq2X2XbKT+8Z9em
         hYKA==
X-Forwarded-Encrypted: i=1; AJvYcCWTqeGo2BMqKkQn0eNk/HARU/87UIqf910LlzFQ7bgKJrpBOsDrJMj0vjnnSJCjMyYyTuvWUXuABXhCVrl4+cHGFCiOgSSdn6lZVripew==
X-Gm-Message-State: AOJu0YxZaHBeSMUI3oDkmYxGc0GPAR9EVmjb3XVFgCFNf34cWpVbKfTc
	erwbSDNs2UfMElwhDkihvPs3ceBrwfUZ35x9DmLlAsORHAyrQZgeN5+1fGveLQ1LFKSx3FSPdde
	BZBNiHO98MJl1brSgi3fiI3lwDLk=
X-Google-Smtp-Source: AGHT+IG/ZeU2MYihWiVUAzDEBIp4sSx3olDS2wkVEiaJHAy1vFyU0q0dAMwCRoVgUjz/ZdnSdkWkoXMJJjjs2+ZslaA=
X-Received: by 2002:a05:6808:1986:b0:3bf:b977:33ed with SMTP id
 bj6-20020a056808198600b003bfb97733edmr1413538oib.45.1707479416800; Fri, 09
 Feb 2024 03:50:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240208170603.2078871-1-amir73il@gmail.com> <20240208170603.2078871-9-amir73il@gmail.com>
 <CAJfpeguUBet0zCdESe7dasC7YpCEC816CMMRF_s1UYmgU=Ja=w@mail.gmail.com>
 <CAOQ4uxhBuSQmku70oydUxZmfACuvEqUUvtVcTSJGYOWHj5hvRg@mail.gmail.com> <CAJfpeguR5Gt+vcyduE+PT+8BmTOJgv+KnpoSueHVbBgFdMNfGQ@mail.gmail.com>
In-Reply-To: <CAJfpeguR5Gt+vcyduE+PT+8BmTOJgv+KnpoSueHVbBgFdMNfGQ@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 9 Feb 2024 13:50:05 +0200
Message-ID: <CAOQ4uxjb5NhQ0k4QZgAmkp==Lj6_KurZEMFwtH5O3-uUDJggUw@mail.gmail.com>
Subject: Re: [PATCH v3 8/9] fuse: introduce inode io modes
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Bernd Schubert <bernd.schubert@fastmail.fm>, linux-fsdevel@vger.kernel.org, 
	Bernd Schubert <bschubert@ddn.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 9, 2024 at 12:56=E2=80=AFPM Miklos Szeredi <miklos@szeredi.hu> =
wrote:
>
> On Fri, 9 Feb 2024 at 11:35, Amir Goldstein <amir73il@gmail.com> wrote:
>
> > No reason apart from "symmetry" with the other io mode FOPEN flags.
> > I will use an internal flag.
>
> Okay.
>
> Other ff->open_flags are set at open time and never changed.
> FOPEN_CACHE_IO doesn't fit into that pattern.
>
> > I added io_open to fix a bug in an earlier version where fuse_file_rele=
ase()
> > was called on the error path after fuse_file_io_open() failed.
> >
> > The simple change would be to replace FOPEN_CACHE_IO flag
> > with ff->io_cache_opened bit.
>
> Right.
>
> >
> > I assume you meant to change ff->io_opened to an enum:
> > { FUSE_IO_NONE, FUSE_IO_CACHE, FUSE_IO_DIRECT,
> >   FUSE_IO_PASSTHROUGH }
> >
> > Is that what you mean?
>
> I just meant ff->io_cache_opened is only set when the cache counter
> needs decrementing.  The logic is simpler and is trivially right.
>

Ok. but I'll leave it named io_opened because with fuse passthrough
io_opened means either positive or negative refcount:

void fuse_file_io_release(struct fuse_file *ff, struct inode *inode)
{
        if (!ff->io_opened)
                return;

        /*
         * Last caching file close allows passthrough open of inode and
         * Last passthrough file close allows caching open of inode.
         */
        if (ff->open_flags & FOPEN_PASSTHROUGH)
                fuse_file_uncached_io_end(inode);
        else
                fuse_file_cached_io_end(inode);

        ff->io_opened =3D false;
}

Thanks,
Amir.

