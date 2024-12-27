Return-Path: <linux-fsdevel+bounces-38169-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A463E9FD77F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Dec 2024 20:23:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35F7F1881EA9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Dec 2024 19:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A4A61F8AF0;
	Fri, 27 Dec 2024 19:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hB7Gbn3x"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C051F8696;
	Fri, 27 Dec 2024 19:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735327359; cv=none; b=UPz4NLzAVb6LK4/D6v8O4DdWhlRx1RJVwjUQ+O6K6O2OQh4nOkru2U8t+t0n6hPw1Bz0fYwQBwoyhZ1mwhsKibpn0G0aEmPKpJPsgXWVf6Bxn/s6dlgDZqLpx4wfSEQM+hTn8vYLCDjoszefuoIwAVZiIjjLZOkQagaG7+MtD50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735327359; c=relaxed/simple;
	bh=S6P4uZIH9g89HiqdbMuIkYs+4UVREsKQMP3cOFptgok=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ineA4dWY7BrwrNvgnmWoqv04ye/pZ9r9EcpYNnVLmAj40G8iE6B2AWDol/PW3NaL9TeuRvLKk98qId5584lzeiQW4Vcr42mLB7LzyikaE2FR9Kt6rkaJEKi7Rjs5J29ThxoDG1Mx/3Y/03ikWFR+OJ2S2hotIeY992QvuQZUf0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hB7Gbn3x; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-467bc28277eso61550081cf.1;
        Fri, 27 Dec 2024 11:22:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735327357; x=1735932157; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d/jp2hIJbiM4+b/F0Gm5bDv2NQZ7BfwwBc4eO2WuGmc=;
        b=hB7Gbn3x89d0flTgjBDK3pg/JMcHhqo3ml67tdu+JL3OcH707a27hZa2IAJtSkWVXD
         KDhHrouczCybkmouCy+tAjeKK8dx8ZRLvi0QyRcG+/uIQxq72GYoNLLqfqFo2bi93YWr
         4JwSfw4VzsOgLDr9gSd5db9dDLFCn/I5JToPYpLRO8tOs7lGlcx2FNue66jCWirpPDFA
         SMzUaWXHI+Y7AwXSsCr+EUeO0FkXal8n017Gy2A0KsuFaRP5iNPBWSFE8cnKJWgpZFLb
         A+6mvtlQXEc06pf7YUaFOTGWCD4nnGHnERz0Zb+Nz1XW3pE0DdIm0lvB7SXT6fmUuY6K
         VuqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735327357; x=1735932157;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d/jp2hIJbiM4+b/F0Gm5bDv2NQZ7BfwwBc4eO2WuGmc=;
        b=H8nkKm6FIc/cMxKojjgzcrrPag16HjY07+F/1TtIlQl4LtIjO9bJAJRDB145J6YEvF
         MsKMsMyztYAZ9OoI3iPBzHdHW/8+s/gpnDwD4m+cSehzv/N/4YHKNg2rh9CqShVpxdXl
         RiIks/7JPTyuRxkiYz/NhXkX1+vS71esVZIkAm5AFPBmSnWR95LSIRRIY5KcWm5kAe6e
         L+B2neAN/J/xFdPH0OwZI1a1B5DDgtn379s11+2d2uZpcYeJpeKWGYO6b9EOBZZCDZg4
         DRLYFJPZ6CfddaBOdl0fnF/kPCe5LLdBzOhrx3zTCIXuXhY8gn5JD3wHaBsi1EV/0Q67
         68bw==
X-Forwarded-Encrypted: i=1; AJvYcCWktqShEQaqu3rbZJRt7A8IL8gJTFf0s2oAcWddGgfwmMq/WgTSkaQMylUcSiqNlHQFDLPesIojU1FpiqDL@vger.kernel.org
X-Gm-Message-State: AOJu0YyhaAivxQGLiHgT5uGznC0xubhK5HqY2Us0jOPGyliJ/lr8uTic
	yVyK1mE/JrmxhjKD0KsZzB8QvEcCMdkMhF+eQTGJq7fZsEwe0HVNvpDWKX2g6FYYfLjNZzejyue
	5q4G77frJS1AHUgM02ZpBeqeYJLA=
X-Gm-Gg: ASbGncuJF+ZHrqlvz4ifsAHyZ2te8CPCJhFpol4qSGXW1AfV/b1GHBFWUdsUxeWCKn4
	jNifDimA1KLc5+SvKY9LohJLhvtpB55nj5S/UCyhQOokUoXvMJm14Uw==
X-Google-Smtp-Source: AGHT+IEiGXSoXvdcSDSgveRTqi7Hd+LTuHlmh6i4V5m2RoOsoGG5T/gv2pLOrN4sFBxO8UGf+WpS/zXGmpUOE0g8lmg=
X-Received: by 2002:ac8:7dd6:0:b0:467:4f9a:6511 with SMTP id
 d75a77b69052e-46a4a9006f7mr454154411cf.30.1735327356816; Fri, 27 Dec 2024
 11:22:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241218210122.3809198-1-joannelkoong@gmail.com>
 <20241218210122.3809198-2-joannelkoong@gmail.com> <Z2QtyaryQtBZZw7q@bfoster>
 <CAJnrk1ZfvyrP=8qKyHFzVte_G1q85bVtmKb4KRwJCe_cYHBmxg@mail.gmail.com> <Z2Val8PjhcfBdBFK@bfoster>
In-Reply-To: <Z2Val8PjhcfBdBFK@bfoster>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Fri, 27 Dec 2024 11:22:26 -0800
Message-ID: <CAJnrk1aFrj-yEWyLFPzYdfUZWr-SsY5eW8F76Lt5VOs+s8efEQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] fsx: support reads/writes from buffers backed by hugepages
To: Brian Foster <bfoster@redhat.com>
Cc: fstests@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 20, 2024 at 3:50=E2=80=AFAM Brian Foster <bfoster@redhat.com> w=
rote:
>
> On Thu, Dec 19, 2024 at 02:34:01PM -0800, Joanne Koong wrote:
> > On Thu, Dec 19, 2024 at 6:27=E2=80=AFAM Brian Foster <bfoster@redhat.co=
m> wrote:
> > >
> > > On Wed, Dec 18, 2024 at 01:01:21PM -0800, Joanne Koong wrote:
> > > > Add support for reads/writes from buffers backed by hugepages.
> > > > This can be enabled through the '-h' flag. This flag should only be=
 used
> > > > on systems where THP capabilities are enabled.
> > > >
> > > > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > > > ---
> > >
> > > Firstly, thanks for taking the time to add this. This seems like a ni=
ce
> > > idea. It might be nice to have an extra sentence or two in the commit
> > > log on the purpose/motivation. For example, has this been used to det=
ect
> > > a certain class of problem?
> >
> > Hi Brian,
> >
> > Thanks for reviewing this. That's a good idea - I'll include the
> > sentence from the cover letter to this commit message as well: "This
> > is motivated by a recent bug that was due to faulty handling for
> > userspace buffers backed by hugepages."
> >
>
> Thanks. Got a link or anything, for my own curiosity?
>
> Also, I presume the followup fstest is a reproducer?
>
> > >
> > > A few other quick comments below...
> > >
> > > >  ltp/fsx.c | 100 +++++++++++++++++++++++++++++++++++++++++++++++++-=
----
> > > >  1 file changed, 92 insertions(+), 8 deletions(-)
> > > >
> > > > diff --git a/ltp/fsx.c b/ltp/fsx.c
> > > > index 41933354..3656fd9f 100644
> > > > --- a/ltp/fsx.c
> > > > +++ b/ltp/fsx.c
> > > > @@ -190,6 +190,7 @@ int       o_direct;                       /* -Z=
 */
> > > >  int  aio =3D 0;
> > > > +}
> > > > +
> > > > +static void *
> > > > +init_hugepages_buf(unsigned len, long hugepage_size)
> > > > +{
> > > > +     void *buf;
> > > > +     long buf_size =3D roundup(len, hugepage_size);
> > > > +
> > > > +     if (posix_memalign(&buf, hugepage_size, buf_size)) {
> > > > +             prterr("posix_memalign for buf");
> > > > +             return NULL;
> > > > +     }
> > > > +     memset(buf, '\0', len);
> > >
> > > I'm assuming it doesn't matter, but did you want to use buf_size here=
 to
> > > clear the whole buffer?
> >
> > I only saw buf being used up to len in the rest of the code so I
> > didn't think it was necessary, but I also don't feel strongly about
> > this and am happy to change this to clear the entire buffer if
> > preferred.
> >
>
> Yeah.. at first it looked like a bug to me, then I realized the same
> thing later. I suspect it might be wise to just clear it entirely to
> avoid any future landmines, but that could just be my internal bias
> talking too. No big deal either way.
>
> > >
> > > > +     if (madvise(buf, buf_size, MADV_COLLAPSE)) {
> > > > +             prterr("madvise collapse for buf");
> > > > +             free(buf);
> > > > +             return NULL;
> > > > +     }
> > > > +
> > > > +     return buf;
> > > > +}
> > > > @@ -3232,12 +3287,41 @@ main(int argc, char **argv)
> > > >       original_buf =3D (char *) malloc(maxfilelen);
> > > >       for (i =3D 0; i < maxfilelen; i++)
> > > >               original_buf[i] =3D random() % 256;
> > > > -     good_buf =3D (char *) malloc(maxfilelen + writebdy);
> > > > -     good_buf =3D round_ptr_up(good_buf, writebdy, 0);
> > > > -     memset(good_buf, '\0', maxfilelen);
> > > > -     temp_buf =3D (char *) malloc(maxoplen + readbdy);
> > > > -     temp_buf =3D round_ptr_up(temp_buf, readbdy, 0);
> > > > -     memset(temp_buf, '\0', maxoplen);
> > > > +     if (hugepages) {
> > > > +             long hugepage_size;
> > > > +
> > > > +             hugepage_size =3D get_hugepage_size();
> > > > +             if (hugepage_size =3D=3D -1) {
> > > > +                     prterr("get_hugepage_size()");
> > > > +                     exit(99);
> > > > +             }
> > > > +
> > > > +             if (writebdy !=3D 1 && writebdy !=3D hugepage_size)
> > > > +                     prt("ignoring write alignment (since -h is en=
abled)");
> > > > +
> > > > +             if (readbdy !=3D 1 && readbdy !=3D hugepage_size)
> > > > +                     prt("ignoring read alignment (since -h is ena=
bled)");
> > >
> > > I'm a little unclear on what these warnings mean. The alignments are
> > > still used in the read/write paths afaics. The non-huge mode seems to
> > > only really care about the max size of the buffers in this code.
> > >
> > > If your test doesn't actually use read/write alignments and the goal =
is
> > > just to keep things simple, perhaps it would be cleaner to add someth=
ing
> > > like an if (hugepages && (writebdy !=3D 1 || readbdy !=3D 1)) check a=
fter
> > > option processing and exit out as an unsupported combination..?
> >
> > My understanding of the 'writebdy' and 'readbdy' options are that
> > they're for making reads/writes aligned to the passed-in value, which
> > depends on the starting address of the buffer being aligned to that
> > value as well. However for hugepages buffers, they must be aligned to
> > the system hugepage size (eg 2 MiB) or the madvise(... MADV_COLLAPSE)
> > call will fail. As such, it is not guaranteed that the requested
> > alignment will actually be abided by. For that reason, I thought it'd
> > be useful to print this out to the user so they know requested
> > alignments will be ignored, but it didn't seem severe enough of an
> > issue to error out and exit altogether. But maybe it'd be less
> > confusing for the user if this instead does just error out if the
> > alignment isn't a multiple of the hugepage size.
> >
>
> Ahh, I see. I missed the round_ptr_up() adjustments. That makes more
> sense now.

For v2, I'll be integrating writebdy and readbdy into the hugepages
buffers. I mistakenly thought that "madvise(, ... MADV_COLLAPSE)"
requires a buffer size that is aligned to the hugepage size, but
AFAICT, it only requires that the buffer size is at least as large as
the hugepage size.

>
> IMO it would be a little cleaner to just bail out earlier as such. But
> either way, I suppose if you could add a small comment with this
> alignment context you've explained above with the error checks then that
> is good enough for me. Thanks!
>
> Brian
>
> > >
> > > BTW, it might also be nice to factor out this whole section of buffer
> > > initialization code (including original_buf) into an init_buffers() o=
r
> > > some such. That could be done as a prep patch, but just a suggestion
> > > either way.
> >
> > Good idea - i'll do this refactoring for v2.
> >
> >
> > Thanks,
> > Joanne
> > >
> > > Brian
> > >
> > > > +
> > > > --
> > > > 2.47.1
> > > >
> > > >
> > >
> >
>

