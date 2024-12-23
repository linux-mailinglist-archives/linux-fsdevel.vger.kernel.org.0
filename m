Return-Path: <linux-fsdevel+bounces-38074-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BE209FB5F5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Dec 2024 22:00:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6633B18829F4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Dec 2024 21:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F38E11D61A1;
	Mon, 23 Dec 2024 20:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U/zwbIax"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A897AEAC5;
	Mon, 23 Dec 2024 20:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734987592; cv=none; b=TgAIayCS0R5n/OJQkPqd5JTpZtD35ZIRVjykMcarWRqL1QkUWuv3dMEyP7Lqsn1ihLwX9BAEDgn8hw7SRQbxQ2an6NfR1Wro4lGZLNj2KJewGv8SeCY7/NS2pz5TNcHcHsh9VUkw5RYRwwzp8byN/hpdv2Sm0HVTd3qzgb47yqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734987592; c=relaxed/simple;
	bh=6DzUNSDR4MFQ1m4BgY9sdCnqb05d3UfvBE18WCC0fNk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AazAg103VRxhznjvQcXgZFoTYBvU3gxGqDxkrmszY1/OTLKb8/HWHj7+MTeMF+6U+L69kMbNE3EvXM6AwfW2HeU+2fHWDcq80VWFv4SCS3hvCTkZKXvnCcbcvDQWgmQ3ru3tUS9bBYLkG0eNOVo9dzbzLvzsP809ApkAbELNZeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U/zwbIax; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-46769b34cbfso67372701cf.0;
        Mon, 23 Dec 2024 12:59:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734987589; x=1735592389; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xlxsa+8WfiG4R/Sxww8VlrmPqknPG7UbhHsKyTXYsCY=;
        b=U/zwbIaxgafmhRgtxiJWYQJ33+yEbqthEJoHQRtA76ydSmxuoS7D+2RsnQchsLOqN5
         2x5hoPc2M4yulYg9UrmxlZ2LCWY62GToeAovk1QqPS7nn5ZERacBVR+vRjID+UkYEws8
         ni7SmPbZtg0AHSAd2uB4MY/lYdLFViA2iElhLFJUFMy+HB0lXX4QM+z5dbuKGQWjtyeF
         UnS9j+2Ijv9CdBxrhMX3VUbiobcGh9I/m6c012ioNV0KnWeGqIGSSEjsUA/RDc7bkuYB
         Ks7VNxiztl7Boonen5TZbwOKCnBQSbi917Sm38hCN7TpQ3O77q7vjRiorAs3LCQS3h8C
         n49g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734987589; x=1735592389;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xlxsa+8WfiG4R/Sxww8VlrmPqknPG7UbhHsKyTXYsCY=;
        b=gG73aWiYO8X1WZpoL3ZyPfzCRkknNN1kNXext6JnsGCbKgImFKlnGygoGyviEHqXJ/
         kaPY4qXEhsjx2c259MFdHklrea+U2PUpE/8rQZAbS7g1iwzX6w2pLuOpmUvRhj9DAeeX
         hC5g41/fUt1Yg5VZaBHPmYzsyTzaFhNgPfAHhPmRFzwKuyu1Jb9hv5072Dmsx3u/C4+9
         kCRwR1dq+seO9Db9/1n8BIg5LGEX1UtHneomP1Dh57Oyr6DxVR/8TKNhLxwPIjLvaWxY
         BS8kfgIQ1rl4Bdtk2WOMpFVo3DG3ZUqdpuzoEguAhcH0tyB6HhXrkyuU2sLOqBxT7gGJ
         +egg==
X-Forwarded-Encrypted: i=1; AJvYcCW0s4qiH+6UKJBt5WT9Bblaa70n+DXGKH8T5EHDiZ8KEuH8KDPRr7Eayg0FQi8l+CPZopJfby/SFNDurNNA@vger.kernel.org
X-Gm-Message-State: AOJu0YwksigvuACgkn6ecwwY1AH7fmJ93w2yHEjqdx18otnsMhyMBYxg
	MmulqHgs4aacSpPfrXYtA1335Vq0q+/NFlHpfGrgtdydFXOjsgguXVMFyoRbuIq6pxYp3YycksM
	nh1MM2kdEeGJ7UTxbYZHtLwSn5IY=
X-Gm-Gg: ASbGncv6NG47DWjkES1E1ctvtCQa0dBi7yxxWIsknYU3OwfiZhTHloZaNqyvYoQiaqt
	zPiB7WxG4g1Zd9z+yJFZuqPFGez52rt1b0vZ4jn5qxxgd0EjH1qcI1Q==
X-Google-Smtp-Source: AGHT+IHTf3GcCkzwU48RYtWJcP64lT1nUkDpxIIyOdenAoOQP3jEdtK/Rir+yQercq1nzB2L8vxx9yZ6s7nvCN6xeWg=
X-Received: by 2002:a05:622a:14cd:b0:467:4802:e6a1 with SMTP id
 d75a77b69052e-46a4a9a3e94mr227732791cf.48.1734987589330; Mon, 23 Dec 2024
 12:59:49 -0800 (PST)
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
Date: Mon, 23 Dec 2024 12:59:38 -0800
Message-ID: <CAJnrk1ad9Sx7VKLubNMFC9ybEpLfTNy3BV2NXFmd-ECK+X17yg@mail.gmail.com>
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

This is the link to the bug and the ensuing discussion:
https://lore.kernel.org/linux-fsdevel/p3iss6hssbvtdutnwmuddvdadubrhfkdoosgm=
bewvo674f7f3y@cwnwffjqltzw/
. The tldr is that even if a filesystem does not support hugepages, it
could still encounter hugepages in the direct io case for large folios
backing userspace buffers. I missed this in commit 3b97c3652d91, which
resulted in incorrect data being forwarded in fuse. There's currently
no fstest checking against hugepages-backed userspace buffers, so this
patchset is a followup for this case and would have caught the bug.

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

Sounds great, I'll clear it entirely in v2.

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
>
> IMO it would be a little cleaner to just bail out earlier as such. But
> either way, I suppose if you could add a small comment with this
> alignment context you've explained above with the error checks then that
> is good enough for me. Thanks!
>

Sounds great, will do for v2.


Thanks,
Joanne

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
> > > > +             good_buf =3D init_hugepages_buf(maxfilelen, hugepage_=
size);
> > > > +             if (!good_buf) {
> > > > +                     prterr("init_hugepages_buf failed for good_bu=
f");
> > > > +                     exit(100);
> > > > +             }
> > > > +
> > > > +             temp_buf =3D init_hugepages_buf(maxoplen, hugepage_si=
ze);
> > > > +             if (!temp_buf) {
> > > > +                     prterr("init_hugepages_buf failed for temp_bu=
f");
> > > > +                     exit(101);
> > > > +             }
> > > > +     } else {
> > > > +             good_buf =3D (char *) malloc(maxfilelen + writebdy);
> > > > +             good_buf =3D round_ptr_up(good_buf, writebdy, 0);
> > > > +             memset(good_buf, '\0', maxfilelen);
> > > > +
> > > > +             temp_buf =3D (char *) malloc(maxoplen + readbdy);
> > > > +             temp_buf =3D round_ptr_up(temp_buf, readbdy, 0);
> > > > +             memset(temp_buf, '\0', maxoplen);
> > > > +     }
> > > >       if (lite) {     /* zero entire existing file */
> > > >               ssize_t written;
> > > >
> > > > --
> > > > 2.47.1
> > > >
> > > >
> > >
> >
>

