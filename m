Return-Path: <linux-fsdevel+bounces-53648-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51C00AF595F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 15:37:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7375A4A32D2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 13:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EDC327B4F5;
	Wed,  2 Jul 2025 13:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gyw9m9lt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5238746447
	for <linux-fsdevel@vger.kernel.org>; Wed,  2 Jul 2025 13:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751463198; cv=none; b=MiPSwoCS+pFUehd+nIQcX5T4Z0TjjFXi+TspAHgp+1TERaFGbRRv+rVOWnrnMd9VwD8wXBgkJ58CUn8MH8udDkoAbO2vE0iCQJR8TNlzWZEOScYkz6KA81UcDJ6mF2BB1zwEVYNrlgYdZUlplcYRHmHx4eLPwRp9zKQbWv+gWlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751463198; c=relaxed/simple;
	bh=IRSlXMTxUou3pXHZeESN8vnW2dfHI0wzGqYW1C597zw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AHlIQgCZqOlpXYLiSdfIYE3muNjerz0jkU7wq1gMt0V513QtNdWrIuKsES1BPflmuCdl7A9zZepxtDfLb5zhTrG6sXKfMzCUwfeJakGYbFmhWlHIQuKwK6YvxMuNy+1RaBEwpqY3TuGNg2SHkJlvIGItcrr2UTXwItcjGFBXEDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gyw9m9lt; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6099d89a19cso8581655a12.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 02 Jul 2025 06:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751463195; x=1752067995; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bectf/D22VWWPZAfEh4+nFWQ4omjvl+p23s3RtUxMKs=;
        b=gyw9m9ltO8FvKviFk3k5QsepO/A1AmyQnhKVmbEc8KPKQFJIhUKFJEBKeCdXQBIiBx
         yVsUesHhkM7CSczg9yvMZbqJSc4vqSf5iWPMQ0xfX/HF9FjpCKGhDd/LRgwe9P3gUxtK
         b67Fw3C1gGIGilEHXfXJhPjitwPBrLbC1Zc1UgvbmwWrYWK3Jjz56cWVVQSK1qH2ycBk
         nV/YWRRt3ae8A3ezQ75AK5/tCW4Tf1vwdRt4Y2VSP7pOrpKy2oJj0JDt9ViVc5wCTcs2
         zv2NFGyjZV9+6qL+ZMSRZ0adPUts70N3hkDrqlIhB9+koFSYN/LFizNjs4zsS+2V7Pqv
         35MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751463195; x=1752067995;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bectf/D22VWWPZAfEh4+nFWQ4omjvl+p23s3RtUxMKs=;
        b=MEp2sD2g2lKuZfSkcr2M5fw7FNEFtiPlpz62W5xo8g+qjWaDle5nWvZEiqISBmu7dl
         0yGCBJasNJt23RrX0oJPGzuhuJh3IhxBysxJvpte0cd+Oz83xEK11csfQLKCTKJpJtoe
         muM7dZKzqHdqVlV/+ZPdhFBOu3KKvV+xecpl0s3b1NTiMghE5z+wOtkIyerynxVt1I9I
         28u8tfQFtZmVDLI6RHZ9/gl/DExVL0/kKEdbFdcpXIbaHU6vGRDxH4Lf0c+cHUsZNYzD
         hYDIFVbLIYgphBEYzD4KhToBjA8b55Y7uEOu/1l1LWxikbwvirQMZtYDDpIsxxR1Uix3
         3ZHw==
X-Gm-Message-State: AOJu0YzJxU85bcL+1GrFhKN8lTHx3B24hQfKMmQ3wkCFoJizQwuEhWxi
	FCvYwwxSoAHFrG1OYXNEOHCYATpQssslTkhnZUTWBYZcGnJd4bKIcSG2vesdiwKXbuNusjV5pU2
	j/tTnW5+bysxMPqz/IvayKJDHkTOWUV4=
X-Gm-Gg: ASbGncsMROJnMwm1BjkHLbl6znMh5ezS5OGIKxk+4oxoQQaoz3yuxUvo6bZnfzcnbml
	Zze9e7iGwi/49BfTMJw/GsZjszW/PgMzdI796tYyraIxHILkAQvhWH63AnhjihkViKzs9vGFQG8
	SJLVGTKZbUR0lzYMoQRx+RSnZFKbwouSGtEuNUxQmA5lw=
X-Google-Smtp-Source: AGHT+IEstMuGQyTTMfVbhUdyutAwS7WE57yFFty5p+jwGSonQ6JoJ5DUrnNzFxNRDT9kQwvLOa+Q0AyA94VPWYrSOGk=
X-Received: by 2002:a17:907:7b8c:b0:ae0:c534:2cea with SMTP id
 a640c23a62f3a-ae3c2cab545mr261866266b.50.1751463194203; Wed, 02 Jul 2025
 06:33:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+AidNeR+_SZPQjD37JcibOoQEwtDEYz6bBef1O3PfboS0BJtw@mail.gmail.com>
 <CAJfpegsdhqnxCmQfQzGRP=zbkuNofExcqoCi5dMk4jAFc14EoQ@mail.gmail.com>
In-Reply-To: <CAJfpegsdhqnxCmQfQzGRP=zbkuNofExcqoCi5dMk4jAFc14EoQ@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 2 Jul 2025 15:33:03 +0200
X-Gm-Features: Ac12FXzrNxl1hxfM6lHTCCKi6txY7TVNov0fDq9e0Poxx6Nv7m8z2AyIX2Gspjs
Message-ID: <CAOQ4uxi6QN6Mc+A0wrEUW5tWiGhGYF=ov9+q=O1Me8joDpBjQw@mail.gmail.com>
Subject: Re: Query regarding FUSE passthrough not using kernel page cache thus
 causing performance regression
To: Miklos Szeredi <miklos@szeredi.hu>, Ashmeen Kaur <ashmeen@google.com>
Cc: linux-fsdevel@vger.kernel.org, Manish Katiyar <mkatiyar@google.com>, 
	GCSFuse dev email group <gcs-fuse-dev@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 2, 2025 at 2:59=E2=80=AFPM Miklos Szeredi <miklos@szeredi.hu> w=
rote:
>
> On Wed, 2 Jul 2025 at 14:27, Ashmeen Kaur <ashmeen@google.com> wrote:
> >
> > Hello Team,
> >
> > I have been experimenting with the FUSE
> > passthrough(https://docs.kernel.org/filesystems/fuse-passthrough.html)
> > feature. I have a question regarding its interaction with the kernel
> > page cache.
> >
> > During my evaluation, I observed a performance degradation when using
> > passthrough. My understanding is that the I/O on the passthrough
> > backing file descriptor bypasses the kernel page cache and goes
> > directly to disk.
>
> Passthrough opens the backing file with the same flags as the fuse
> file was opened.  If it had O_DIRECT, then the backing file will be
> opened with O_DIRECT.
>
> If your fuse server implementation removed O_DIRECT from the open
> flags before opening the backing file, then this can indeed be a
> regression.   Otherwise there is probably some other issue.

I am confused by this statement about O_DIRECT.
I don't think that it was implied that O_DIRECT was used in this test.

The statement: "My understanding is that the I/O on the passthrough
backing file descriptor bypasses the kernel page cache and goes
directly to disk."

Is not accurate.

The accurate statement is:

"I/O on the passthrough backing file descriptor bypasses the
 *FUSE* page cache and goes directly to *the backing file*."
NOT *directly to disk.

So if you are doing passthrough to XFS file for example,
and the application is doing buffered read, you get buffered
read from XFS and utilize the page cache of XFS.

That's the reason for disallowing FOPEN_KEEP_CACHE
because the FUSE page cache is not utilized.

So the main questions are which backing filesystem are
you doing passthrough to? and which mode is the test
opening the file?

Thanks,
Amir.

