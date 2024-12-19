Return-Path: <linux-fsdevel+bounces-37883-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F75C9F87EC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2024 23:34:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5A6D7A1749
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2024 22:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B2CD1DC9B4;
	Thu, 19 Dec 2024 22:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ezl8Pcbi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2381886337;
	Thu, 19 Dec 2024 22:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734647654; cv=none; b=F+3raC34N2o1jLxPZ40HM/i5gDQZGYnvIC7cwQ2fRkzNwbtstNJOUUpjSX/w3QOXD2BgwZ7XAcKT2lTO4P7UTiOkdHMaH4cfH/RWEJJozYpoJpPEBPE8pgcjV3vN7NgNQStReLXFihjPxiAHEW+PPnq9dxyL0WgUwO40xu3QW08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734647654; c=relaxed/simple;
	bh=qxS55oO27rKPnOfhteHz+D3RnOslvXFFsJ2ttK8g0rI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MSPrSqCHX4m1PsKs3lqb7rBZelE9KAb6pHWI7w5VYyeqnleCesXnQnNq/4TnlG2yJAOrb+EIx72vxF/fEQCWFUZUXGAa4KFHd+s/bHpzvaCuEMNXEChRQG8aC2n3bblghj2Ju9Q+XnTn4moojMRnTyw+c7SUYhaqecoDj3TIVMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ezl8Pcbi; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-467a37a2a53so14560151cf.2;
        Thu, 19 Dec 2024 14:34:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734647652; x=1735252452; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u9XI++Qd5/FsAHM/VtpJpu0/P901WHIBleQv+lOHczw=;
        b=ezl8PcbietyAWfNtsegQX1/c/QO+M1Sl90NnLS4+g1BMhI4bFenSS/kzPwvxFbKt1i
         vH6epLT4ELdUz+VkSuEsPvipTS2Za6pmjSBN8qka9fbfp2YzuIrB+iJMdtJ/7qbQumv2
         cY7Vpu9N77rE75k6mL/a9DEAF/LuPS4MdhoSECs8far+0XiqgklOqd9/GjvqHzNdgjNz
         Lcja2fbwBvcCASaorocX3UYwnQjDkdJeNttRJTgBDQT72qveloVrgzcfjOjvtCIFUBJ8
         CoZeJn/qPiGBhfHR4bNrW8dB8q4h9AbXKq/NESlkdC74QLtJHPsOFovRO/+xXRWNIK7t
         albA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734647652; x=1735252452;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u9XI++Qd5/FsAHM/VtpJpu0/P901WHIBleQv+lOHczw=;
        b=qO6rHCtQTLPQiVnwOrOl9owNSSuCOIDfVSMCJawFu8RE6wqPqdPnvU/xLSSM5B7M/o
         3QvXtHxEx0+vKHHIr6m9qkI+0+2TXQ5rqae5IgM6SJuLAy6hYSz1dvYEhmzF3a6vkFN1
         A5xORne7O68xDkNn/Lgaotz3GoySabRJyEHAczzLj0JFOXcgRTG4yIbI8EjVZMMRW2Gb
         gTfFzi8LLPBOmCxDsPYGJPEsWpx71/H3vLVLmfcek+ZDUDmI4/U1A/YM99SmyuYTlSQc
         FZg01HIubf13Ma3PNlkHbTKR9lnUYLWPxHzcda0EqVU5yE7BIaDj08n4V12P2jLbmlnz
         qyOA==
X-Forwarded-Encrypted: i=1; AJvYcCU+kUx8UgFeKJrxIgab4HNUUmrStt42QrPf1bPp3DAexFoAKU6UVxYLuHSug2KnPYYA+9NzT17qtp/oi638@vger.kernel.org
X-Gm-Message-State: AOJu0YxJGqbO9Ao5oDfOy7DqPIO8oBkSQlOjT0kZet3xC1ibKBezENMm
	9z9HLLAUAkNR8VDhUTgcysMdZFXlK04Q77Zj4mdPokI1H5+ikFB/a8X+U9HidrPJINv6FgLz3JW
	FTRHNFRy3jypqmXwIGbidZUMZ1+Uzgfdl
X-Gm-Gg: ASbGncvo3dV1KTMuUpH1KPbWdzG0o5LZqZXZdPT10XS4TbS2R1g7RT/esmVOYPPypM+
	YcEOsyVKP/68t1FTLIHfj306RXRHbGXaZQvyICj4=
X-Google-Smtp-Source: AGHT+IGSdjSYG7wHcVlBNdexoUiQoZFJy3ZtW/5Rw28kqOxa6PVg/sQswm2nnrAWy25p3I/dBwh/C9SYbkWqdpcMW40=
X-Received: by 2002:a05:622a:1a29:b0:467:6cce:44ba with SMTP id
 d75a77b69052e-46a4a976beemr12161851cf.43.1734647651953; Thu, 19 Dec 2024
 14:34:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241218210122.3809198-1-joannelkoong@gmail.com>
 <20241218210122.3809198-2-joannelkoong@gmail.com> <Z2QtyaryQtBZZw7q@bfoster>
In-Reply-To: <Z2QtyaryQtBZZw7q@bfoster>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Thu, 19 Dec 2024 14:34:01 -0800
Message-ID: <CAJnrk1ZfvyrP=8qKyHFzVte_G1q85bVtmKb4KRwJCe_cYHBmxg@mail.gmail.com>
Subject: Re: [PATCH 1/2] fsx: support reads/writes from buffers backed by hugepages
To: Brian Foster <bfoster@redhat.com>
Cc: fstests@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 19, 2024 at 6:27=E2=80=AFAM Brian Foster <bfoster@redhat.com> w=
rote:
>
> On Wed, Dec 18, 2024 at 01:01:21PM -0800, Joanne Koong wrote:
> > Add support for reads/writes from buffers backed by hugepages.
> > This can be enabled through the '-h' flag. This flag should only be use=
d
> > on systems where THP capabilities are enabled.
> >
> > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > ---
>
> Firstly, thanks for taking the time to add this. This seems like a nice
> idea. It might be nice to have an extra sentence or two in the commit
> log on the purpose/motivation. For example, has this been used to detect
> a certain class of problem?

Hi Brian,

Thanks for reviewing this. That's a good idea - I'll include the
sentence from the cover letter to this commit message as well: "This
is motivated by a recent bug that was due to faulty handling for
userspace buffers backed by hugepages."

>
> A few other quick comments below...
>
> >  ltp/fsx.c | 100 +++++++++++++++++++++++++++++++++++++++++++++++++-----
> >  1 file changed, 92 insertions(+), 8 deletions(-)
> >
> > diff --git a/ltp/fsx.c b/ltp/fsx.c
> > index 41933354..3656fd9f 100644
> > --- a/ltp/fsx.c
> > +++ b/ltp/fsx.c
> > @@ -190,6 +190,7 @@ int       o_direct;                       /* -Z */
> >  int  aio =3D 0;
> > +}
> > +
> > +static void *
> > +init_hugepages_buf(unsigned len, long hugepage_size)
> > +{
> > +     void *buf;
> > +     long buf_size =3D roundup(len, hugepage_size);
> > +
> > +     if (posix_memalign(&buf, hugepage_size, buf_size)) {
> > +             prterr("posix_memalign for buf");
> > +             return NULL;
> > +     }
> > +     memset(buf, '\0', len);
>
> I'm assuming it doesn't matter, but did you want to use buf_size here to
> clear the whole buffer?

I only saw buf being used up to len in the rest of the code so I
didn't think it was necessary, but I also don't feel strongly about
this and am happy to change this to clear the entire buffer if
preferred.

>
> > +     if (madvise(buf, buf_size, MADV_COLLAPSE)) {
> > +             prterr("madvise collapse for buf");
> > +             free(buf);
> > +             return NULL;
> > +     }
> > +
> > +     return buf;
> > +}
> > @@ -3232,12 +3287,41 @@ main(int argc, char **argv)
> >       original_buf =3D (char *) malloc(maxfilelen);
> >       for (i =3D 0; i < maxfilelen; i++)
> >               original_buf[i] =3D random() % 256;
> > -     good_buf =3D (char *) malloc(maxfilelen + writebdy);
> > -     good_buf =3D round_ptr_up(good_buf, writebdy, 0);
> > -     memset(good_buf, '\0', maxfilelen);
> > -     temp_buf =3D (char *) malloc(maxoplen + readbdy);
> > -     temp_buf =3D round_ptr_up(temp_buf, readbdy, 0);
> > -     memset(temp_buf, '\0', maxoplen);
> > +     if (hugepages) {
> > +             long hugepage_size;
> > +
> > +             hugepage_size =3D get_hugepage_size();
> > +             if (hugepage_size =3D=3D -1) {
> > +                     prterr("get_hugepage_size()");
> > +                     exit(99);
> > +             }
> > +
> > +             if (writebdy !=3D 1 && writebdy !=3D hugepage_size)
> > +                     prt("ignoring write alignment (since -h is enable=
d)");
> > +
> > +             if (readbdy !=3D 1 && readbdy !=3D hugepage_size)
> > +                     prt("ignoring read alignment (since -h is enabled=
)");
>
> I'm a little unclear on what these warnings mean. The alignments are
> still used in the read/write paths afaics. The non-huge mode seems to
> only really care about the max size of the buffers in this code.
>
> If your test doesn't actually use read/write alignments and the goal is
> just to keep things simple, perhaps it would be cleaner to add something
> like an if (hugepages && (writebdy !=3D 1 || readbdy !=3D 1)) check after
> option processing and exit out as an unsupported combination..?

My understanding of the 'writebdy' and 'readbdy' options are that
they're for making reads/writes aligned to the passed-in value, which
depends on the starting address of the buffer being aligned to that
value as well. However for hugepages buffers, they must be aligned to
the system hugepage size (eg 2 MiB) or the madvise(... MADV_COLLAPSE)
call will fail. As such, it is not guaranteed that the requested
alignment will actually be abided by. For that reason, I thought it'd
be useful to print this out to the user so they know requested
alignments will be ignored, but it didn't seem severe enough of an
issue to error out and exit altogether. But maybe it'd be less
confusing for the user if this instead does just error out if the
alignment isn't a multiple of the hugepage size.

>
> BTW, it might also be nice to factor out this whole section of buffer
> initialization code (including original_buf) into an init_buffers() or
> some such. That could be done as a prep patch, but just a suggestion
> either way.

Good idea - i'll do this refactoring for v2.


Thanks,
Joanne
>
> Brian
>
> > +
> > +             good_buf =3D init_hugepages_buf(maxfilelen, hugepage_size=
);
> > +             if (!good_buf) {
> > +                     prterr("init_hugepages_buf failed for good_buf");
> > +                     exit(100);
> > +             }
> > +
> > +             temp_buf =3D init_hugepages_buf(maxoplen, hugepage_size);
> > +             if (!temp_buf) {
> > +                     prterr("init_hugepages_buf failed for temp_buf");
> > +                     exit(101);
> > +             }
> > +     } else {
> > +             good_buf =3D (char *) malloc(maxfilelen + writebdy);
> > +             good_buf =3D round_ptr_up(good_buf, writebdy, 0);
> > +             memset(good_buf, '\0', maxfilelen);
> > +
> > +             temp_buf =3D (char *) malloc(maxoplen + readbdy);
> > +             temp_buf =3D round_ptr_up(temp_buf, readbdy, 0);
> > +             memset(temp_buf, '\0', maxoplen);
> > +     }
> >       if (lite) {     /* zero entire existing file */
> >               ssize_t written;
> >
> > --
> > 2.47.1
> >
> >
>

