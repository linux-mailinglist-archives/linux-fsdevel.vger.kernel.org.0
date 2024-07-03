Return-Path: <linux-fsdevel+bounces-23073-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CB75592698F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jul 2024 22:28:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 702A9B26922
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jul 2024 20:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D466C18FDAF;
	Wed,  3 Jul 2024 20:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SjQMok/C"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3DE1136678
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Jul 2024 20:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720038507; cv=none; b=Cm4UOsptkyigFQIQGwQVuF7ZcN02SJm36FQJ0V1w/5abhQwXRr7C6q+VJvRRB5UfEysL6d/1XPSXjVyJnSDNbbvYvLiGOXL3awATnxPQw3Oe+vqEacYbAoaScErqZD3Mm4SDazol5PbwkDlpqnJV+2ZhVsIg2/N2AUbLHZ2IRw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720038507; c=relaxed/simple;
	bh=s7AtimaS6jMMahD1pzxlZEqZ4jVn7nHIiM4uzKQY7t4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kXWRyK6S/mXIO2mbXi1XixPxxVbH6mZyRZhfhdg8Vk/WgRuDb5ED8kXKmuZX8Q3AVyEVHH5w6OC8v1I93VYvACVF6Qi4reIzsOSLK5DkxorOZnf4QT6qkNNPS30XCUNcgB4vk+raUwuwsat/Gvoh21GtGuzTjBOtb9puXZ3jgr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SjQMok/C; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e035f4e3473so5373291276.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Jul 2024 13:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720038505; x=1720643305; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Oo/nUq0r8e0jO0IPvW8yEZ28K5aTjGY3cpsCyFkFWI=;
        b=SjQMok/CeZaVOPW/3Fr4y+Anix7iCKCQIJwxoL9Q1cAJ2X/H7S/6xIfdlTj+Nbx4eD
         EwjVbImBVivE54WtEmoSt5UcB4faZ0xwG8s7RtklPB9lW/kbyFQrVCnIJ+MlckD9uneQ
         HrTuFefrhdURzOK3HLR90u1RbSt6JUF5xUiYKdcq8uL/i9CXR8vm7v0u3PIj16ukguAT
         ryeUJBHdM5At/3BvoShYNW1WXi9ZGtLG0VgM4wTeDm3+sgQp5jDuCnaWv55vYGueBdeE
         AO9Hb+ajE+upfxsCiJ5lRas5DiiCKx5Klf+AW6277/N5hjIafwSuikMmBMJOqlYupOGf
         n25Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720038505; x=1720643305;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/Oo/nUq0r8e0jO0IPvW8yEZ28K5aTjGY3cpsCyFkFWI=;
        b=p33QhDPLFrthaEreQzTZQFqizKNXnziU/RyuMCzyY1TuFD0Kcwt5K2ls3/WGkBRpNd
         CRWo7HcUhdqCwCCYzK03UaWEKy3Hx/nSt5hiF1sTTgZZEemo/olsZJkW1O3kRD4plidD
         7N6H4wWLoN4ZPUZamBX5q9dKLrevec1RaPJJF/SKe6dGOv8t9gGlIghVIae0+oppahqz
         uoSNXn66BOT1gHgCa+L6nlOIdPcs0ahptf97My/JhEQJu+KUnr8/ZIDOvUFvS0sKDs+/
         8Dm5hZJl2EeVECB6cwfdLZKACQUdaMZJD2htiMal+4N+2WfWCV7H/szUbvMIX5GRpeLx
         b+ww==
X-Forwarded-Encrypted: i=1; AJvYcCX57O2psC2xRPqxr3wYOcnjgrarCJPEnz4sRbLSvZu5oq30qzk39n9N71sKZwbq824H/MRMfGxsSiSmCUeXnpU00ewKwi4T9sYW23D56w==
X-Gm-Message-State: AOJu0YygjSnHK3tntsHY1uZ2pbAkdMvrAY5+TXy7m1UJPSTwwTKv2UgR
	eWTsLCRpS2Byiwd0NZumokQ1zd5GoT2aVHnYp2ny+Z8QRcEMhiF6ucUQvY5D6B//X2RnQgx+C08
	2Q4aVLSW1YKTyX1Hc6msu3c1Iub4=
X-Google-Smtp-Source: AGHT+IFlQS/7fv8dB11RzAX+OvhD9StiYuW1F1cckhYjeQ9Eej5oz7x/gI54grA2dpeHSboHDVVuduRsTDr1WUTv3rQ=
X-Received: by 2002:a25:acc1:0:b0:dff:bfc:1643 with SMTP id
 3f1490d57ef6-e036ec4db31mr15355338276.49.1720038504726; Wed, 03 Jul 2024
 13:28:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240702163108.616342-1-bschubert@ddn.com> <20240703151549.GC734942@perftesting>
 <e6a58319-e6b1-40dc-81b8-11bd3641a9ca@fastmail.fm> <20240703173017.GB736953@perftesting>
 <CAJnrk1bYf85ipt2Hf1id-OBOzaASOeegOxnn3vGtUxYHNp3xHg@mail.gmail.com> <03aba951-1cab-4a40-a980-6ac3d52b2c91@ddn.com>
In-Reply-To: <03aba951-1cab-4a40-a980-6ac3d52b2c91@ddn.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 3 Jul 2024 13:28:13 -0700
Message-ID: <CAJnrk1a2_qDkEYSCCSOf-jpumLZv5neAgSwW6XGA__eTjBfBCw@mail.gmail.com>
Subject: Re: [PATCH] fuse: Allow to align reads/writes
To: Bernd Schubert <bschubert@ddn.com>
Cc: Josef Bacik <josef@toxicpanda.com>, Bernd Schubert <bernd.schubert@fastmail.fm>, 
	"miklos@szeredi.hu" <miklos@szeredi.hu>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 3, 2024 at 11:08=E2=80=AFAM Bernd Schubert <bschubert@ddn.com> =
wrote:
>
> On 7/3/24 19:49, Joanne Koong wrote:
> > On Wed, Jul 3, 2024 at 10:30=E2=80=AFAM Josef Bacik <josef@toxicpanda.c=
om> wrote:
> >>
> >> On Wed, Jul 03, 2024 at 05:58:20PM +0200, Bernd Schubert wrote:
> >>>
> >>>
> >>> On 7/3/24 17:15, Josef Bacik wrote:
> >>>> On Tue, Jul 02, 2024 at 06:31:08PM +0200, Bernd Schubert wrote:
> >>>>> Read/writes IOs should be page aligned as fuse server
> >>>>> might need to copy data to another buffer otherwise in
> >>>>> order to fulfill network or device storage requirements.
> >>>>>
> >>>>> Simple reproducer is with libfuse, example/passthrough*
> >>>>> and opening a file with O_DIRECT - without this change
> >>>>> writing to that file failed with -EINVAL if the underlying
> >>>>> file system was using ext4 (for passthrough_hp the
> >>>>> 'passthrough' feature has to be disabled).
> >>>>>
> >>>>> Given this needs server side changes as new feature flag is
> >>>>> introduced.
> >>>>>
> >>>>> Disadvantage of aligned writes is that server side needs
> >>>>> needs another splice syscall (when splice is used) to seek
> >>>>> over the unaligned area - i.e. syscall and memory copy overhead.
> >>>>>
> >>>>> Signed-off-by: Bernd Schubert <bschubert@ddn.com>
> >>>>>
> >>>>> ---
> >>>>> From implementation point of view 'struct fuse_in_arg' /
> >>>>> 'struct fuse_arg' gets another parameter 'align_size', which has to
> >>>>> be set by fuse_write_args_fill. For all other fuse operations this
> >>>>> parameter has to be 0, which is guranteed by the existing
> >>>>> initialization via FUSE_ARGS and C99 style
> >>>>> initialization { .size =3D 0, .value =3D NULL }, i.e. other members=
 are
> >>>>> zero.
> >>>>> Another choice would have been to extend fuse_write_in to
> >>>>> PAGE_SIZE - sizeof(fuse_in_header), but then would be an
> >>>>> arch/PAGE_SIZE depending struct size and would also require
> >>>>> lots of stack usage.
> >>>>
> >>>> Can I see the libfuse side of this?  I'm confused why we need the al=
ign_size at
> >>>> all?  Is it enough to just say that this connection is aligned, nego=
tiate what
> >>>> the alignment is up front, and then avoid sending it along on every =
write?
> >>>
> >>> Sure, I had forgotten to post it
> >>> https://github.com/bsbernd/libfuse/commit/89049d066efade047a72bcd1af8=
ad68061b11e7c
> >>>
> >>> We could also just act on fc->align_writes / FUSE_ALIGN_WRITES and al=
ways use
> >>> sizeof(struct fuse_in_header) + sizeof(struct fuse_write_in) in libfu=
se and would
> >>> avoid to send it inside of fuse_write_in. We still need to add it to =
struct fuse_in_arg,
> >>> unless you want to check the request type within fuse_copy_args().
> >>
> >> I think I like this approach better, at the very least it allows us to=
 use the
> >> padding for other silly things in the future.
> >>
> >
> > This approach seems cleaner to me as well.
> > I also like the idea of having callers pass in whether alignment
> > should be done or not to fuse_copy_args() instead of adding
> > "align_writes" to struct fuse_in_arg.
>
> There is no caller for FUSE_WRITE for fuse_copy_args(), but it is called
> from fuse_dev_do_read for all request types. I'm going to add in request
> parsing within fuse_copy_args, I can't decide myself which of both
> versions I like less.

Sorry I should have clarified better :) By callers, I meant callers to
fuse_copy_args(). I'm still getting up to speed with the fuse code but
it looks like it gets called by both fuse_dev_do_read and
fuse_dev_do_write (through copy_out_args() -> fuse_copy_args()). The
cleanest solution to me seems like to pass in from those callers
whether the request should be page-aligned after the headers or not,
instead of doing the request parsing within fuse_copy_args() itself. I
think if we do the request parsing within fuse_copy_args() then we
would also need to have some way to differentiate between FUSE_WRITE
requests from the dev_do_read vs dev_do_write side (since, as I
understand it, writes only needs to be aligned for dev_do_read write
requests).

Thanks,
Joanne

>
> Thanks,
> Bernd
>

