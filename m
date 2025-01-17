Return-Path: <linux-fsdevel+bounces-39556-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 41440A158ED
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jan 2025 22:19:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62794164D42
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jan 2025 21:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 457111AA795;
	Fri, 17 Jan 2025 21:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rth+JRIM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C68E9187550;
	Fri, 17 Jan 2025 21:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737148750; cv=none; b=e76NpdH4cP5wR25pIxFhcP/22+6Z66m8rnGZcNtVLGPMWXs4sVSqaemJQq2YjOXkAClo6lWe1j9L4igMJ8fJPm9Ywpe8lBaKbaVsyBqhM2ebIwq8WlrRRcZ7uO/Rdo0pFCb5kldpQQib4+KOUJ8ik/LKlp/v9X1n8ib5/HKI5W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737148750; c=relaxed/simple;
	bh=ZjG1ecvw3yr39ZKdfPxR2CJ8pA6219/pN9cTofqJaHM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p4tD2q8CoHuiWb+umGC3MI32GuwWjdxQ26xIR+twOtbX2OKZuCRPmsfikau9AJ25d3ZK6tddx8uVODml/G4rwKLTwRXxWeimKt1Gb7ODxe4OlN0EM0iOBDe5tkEwFjoXoePX6udiWJqHKx34euTtSLIRU4LD4NKMfF+JZOc4dv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rth+JRIM; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6dd1962a75bso23457146d6.3;
        Fri, 17 Jan 2025 13:19:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737148745; x=1737753545; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vhLQ5XPFkDLtkhG2oUZVHcO6UCI0ATzbV1WvfKBf1SM=;
        b=Rth+JRIME92T15a464/HNm6MJahUgdA1FNOHxQbI0q1v7CMahwnoFKgTLV1m6mGQxt
         tGH8n0Gcj14tWMWd5JqwB2/g7OSfnZE35x8JDG3O63J+JWKuJ8cKOFztUGPtqvevBriy
         ZNlRAMUZ+SaUmDVYn5q/QsFAYV8+IBgNl2H3CoUA7ZbqXmZLGB7ahTY+SXuL7YgJx0fW
         4v6QdbQxDnJrFglLyWLS9MFo2Yrhbyq4sWM67yKS2Y1BNZX2BweVEjk2H9a2/ydjBFvV
         tJxho8xakOkmvlZI55x+q1pemtzDgjhb8tVzGvPt+eBaoNSXv4v6+HfhD8TumW7lXbuz
         VLIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737148745; x=1737753545;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vhLQ5XPFkDLtkhG2oUZVHcO6UCI0ATzbV1WvfKBf1SM=;
        b=jfZpaIonR6f5iGDTZQ33XxGNGaHU0r3v6+/ENOHv7tblSQ6S1E5903BVc529hzwlp2
         NKcLIUpxSaH4MxFIz0+Yi/IeYCgw50gNt7pMjOuUSLNu/dYyI4UopNp15JWIAjDY0FtR
         GRa79S8gMQ4Mf6s/IfF2vMjlmG7r7L6yhXMB4vXHg6s8Gkd/8PE7O0+WqINimXpWKxZ6
         3uc4xX3G37l67PIunIMESzUwrx4vjQzOUI3CstkUuJJGmdcU3hBLI+wBJYZZUOz2MO+V
         ETgLJ0UOxW4xAq2+0M+toe/34FIeucrePptNmCsOKOZd7kYyhAW+lYis6/T3gscR4Uww
         +Kug==
X-Forwarded-Encrypted: i=1; AJvYcCVS3fODHcReKXRqoV/Kl24n0XKgzjaK93KFVw5AwDop5rCMyZORQvGav+KAYToCGxz7OzkneMWR@vger.kernel.org, AJvYcCWbrdxj48qSVAEdVC/Ld1Cq09yIeY0TrfJ5GFxF64cf88Yxv+uQ64+5vHZeSX0NlVw9IisaYZk4wz48nEUN2g==@vger.kernel.org
X-Gm-Message-State: AOJu0YwwlWbwOCw19NDl3ETSE+ysIjB/Fez+ddLi+prcRNxLdadpzh72
	axD6yX4+GP1xtvu0KfIFtpUcMVmt78TWhRhiSkglUG+d4KXWVmAJFxeMSH55S6tMAA+jGlx4DsL
	eFEO0sXM1kl+tfGJM0aUMxEhSISl9Ad6F
X-Gm-Gg: ASbGncvM+yE8i1mYuCpchD7sqwnvFUxmK4nGCHqAxRc5sonnct1XRsnYMNzjNPuL/pq
	xZ0NbU0FPGkwDtFSy7Kqfbbc9/66dVwkHzuiANrrCAufgFV0xHJNZ
X-Google-Smtp-Source: AGHT+IGSZYTkXgOc22b3IOMx8DIfcZjpgIgo2oZwW9rlNP+jiMVKbQAdy7KjH407uNVV2AVhgWr8NN6UtThVCb3txlU=
X-Received: by 2002:a05:6214:c8b:b0:6d8:a8e1:b57b with SMTP id
 6a1803df08f44-6e1b220c591mr71511006d6.36.1737148745446; Fri, 17 Jan 2025
 13:19:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250115183107.3124743-1-joannelkoong@gmail.com>
 <20250115183107.3124743-2-joannelkoong@gmail.com> <20250115213713.GE3557695@frogsfrogsfrogs>
 <CAJnrk1YXa++SrifrCfXf7WPQF34V20cet3+x+7wVuDf9CPoR7w@mail.gmail.com>
 <20250116005919.GK3557553@frogsfrogsfrogs> <Z4kBYq0K919C9k4M@bfoster>
 <CAJnrk1ZO9jp6PUtz2iz2k=yRfbH+_w_0BZREHcrBuRo3pYiVPg@mail.gmail.com> <Z4pavNG_GKxPSRBy@bfoster>
In-Reply-To: <Z4pavNG_GKxPSRBy@bfoster>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Fri, 17 Jan 2025 13:18:54 -0800
X-Gm-Features: AbW1kvYHRysQaXz0QrWEkwQ6UDwsgQ6zfazwUcy7npdCwqD2gKxgwKcw0R3gA08
Message-ID: <CAJnrk1YjQkkYcRjOMg=t2QduO0TERsm5b96SKyZFisw7sjR8VA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] fsx: support reads/writes from buffers backed by hugepages
To: Brian Foster <bfoster@redhat.com>
Cc: "Darrick J. Wong" <djwong@kernel.org>, fstests@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, nirjhar@linux.ibm.com, zlang@redhat.com, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 17, 2025 at 5:25=E2=80=AFAM Brian Foster <bfoster@redhat.com> w=
rote:
>
> On Thu, Jan 16, 2025 at 05:26:31PM -0800, Joanne Koong wrote:
> > On Thu, Jan 16, 2025 at 4:51=E2=80=AFAM Brian Foster <bfoster@redhat.co=
m> wrote:
> > >
> > > On Wed, Jan 15, 2025 at 04:59:19PM -0800, Darrick J. Wong wrote:
> > > > On Wed, Jan 15, 2025 at 04:47:30PM -0800, Joanne Koong wrote:
> > > > > On Wed, Jan 15, 2025 at 1:37=E2=80=AFPM Darrick J. Wong <djwong@k=
ernel.org> wrote:
> > > > > >
> > > > > > On Wed, Jan 15, 2025 at 10:31:06AM -0800, Joanne Koong wrote:
> > > > > > > Add support for reads/writes from buffers backed by hugepages=
.
> > > > > > > This can be enabled through the '-h' flag. This flag should o=
nly be used
> > > > > > > on systems where THP capabilities are enabled.
> > > > > > >
> > > > > > > This is motivated by a recent bug that was due to faulty hand=
ling of
> > > > > > > userspace buffers backed by hugepages. This patch is a mitiga=
tion
> > > > > > > against problems like this in the future.
> > > > > > >
> > > > > > > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > > > > > > Reviewed-by: Brian Foster <bfoster@redhat.com>
> > > > > > > ---
> > > > > > >  ltp/fsx.c | 119 ++++++++++++++++++++++++++++++++++++++++++++=
+++++-----
> > > > > > >  1 file changed, 108 insertions(+), 11 deletions(-)
> > > > > > >
> > > > > > > diff --git a/ltp/fsx.c b/ltp/fsx.c
> > > > > > > index 41933354..8d3a2e2c 100644
> > > > > > > --- a/ltp/fsx.c
> > > > > > > +++ b/ltp/fsx.c
> > > > > > > @@ -190,6 +190,7 @@ int       o_direct;                      =
 /* -Z */
> > > > > > >  int  aio =3D 0;
> > > > > > >  int  uring =3D 0;
> > > > > > >  int  mark_nr =3D 0;
> > > > > > > +int  hugepages =3D 0;                  /* -h flag */
> > > > > > >
> > > > > > >  int page_size;
> > > > > > >  int page_mask;
> > > > > > > @@ -2471,7 +2472,7 @@ void
> > > > > > >  usage(void)
> > > > > > >  {
> > > > > > >       fprintf(stdout, "usage: %s",
> > > > > > > -             "fsx [-dfknqxyzBEFHIJKLORWXZ0]\n\
> > > > > > > +             "fsx [-dfhknqxyzBEFHIJKLORWXZ0]\n\
> > > > > > >          [-b opnum] [-c Prob] [-g filldata] [-i logdev] [-j l=
ogid]\n\
> > > > > > >          [-l flen] [-m start:end] [-o oplen] [-p progressinte=
rval]\n\
> > > > > > >          [-r readbdy] [-s style] [-t truncbdy] [-w writebdy]\=
n\
> > > > > > > @@ -2484,6 +2485,7 @@ usage(void)
> > > > > > >       -e: pollute post-eof on size changes (default 0)\n\
> > > > > > >       -f: flush and invalidate cache after I/O\n\
> > > > > > >       -g X: write character X instead of random generated dat=
a\n\
> > > > > > > +     -h hugepages: use buffers backed by hugepages for reads=
/writes\n\
> > > > > >
> > > > > > If this requires MADV_COLLAPSE, then perhaps the help text shou=
ldn't
> > > > > > describe the switch if the support wasn't compiled in?
> > > > > >
> > > > > > e.g.
> > > > > >
> > > > > >         -g X: write character X instead of random generated dat=
a\n"
> > > > > > #ifdef MADV_COLLAPSE
> > > > > > "       -h hugepages: use buffers backed by hugepages for reads=
/writes\n"
> > > > > > #endif
> > > > > > "       -i logdev: do integrity testing, logdev is the dm log w=
rites device\n\
> > > > > >
> > > > > > (assuming I got the preprocessor and string construction goo ri=
ght; I
> > > > > > might be a few cards short of a deck due to zombie attack earli=
er)
> > > > >
> > > > > Sounds great, I'll #ifdef out the help text -h line. Hope you fee=
l better.
> > > > > >
> > > > > > >       -i logdev: do integrity testing, logdev is the dm log w=
rites device\n\
> > > > > > >       -j logid: prefix debug log messsages with this id\n\
> > > > > > >       -k: do not truncate existing file and use its size as u=
pper bound on file size\n\
> > > > > [...]
> > > > > > > +}
> > > > > > > +
> > > > > > > +#ifdef MADV_COLLAPSE
> > > > > > > +static void *
> > > > > > > +init_hugepages_buf(unsigned len, int hugepage_size, int alig=
nment)
> > > > > > > +{
> > > > > > > +     void *buf;
> > > > > > > +     long buf_size =3D roundup(len, hugepage_size) + alignme=
nt;
> > > > > > > +
> > > > > > > +     if (posix_memalign(&buf, hugepage_size, buf_size)) {
> > > > > > > +             prterr("posix_memalign for buf");
> > > > > > > +             return NULL;
> > > > > > > +     }
> > > > > > > +     memset(buf, '\0', buf_size);
> > > > > > > +     if (madvise(buf, buf_size, MADV_COLLAPSE)) {
> > > > > >
> > > > > > If the fsx runs for a long period of time, will it be necessary=
 to call
> > > > > > MADV_COLLAPSE periodically to ensure that reclaim doesn't break=
 up the
> > > > > > hugepage?
> > > > > >
> > > > >
> > > > > imo, I don't think so. My understanding is that this would be a r=
are
> > > > > edge case that happens when the system is constrained on memory, =
in
> > > > > which case subsequent calls to MADV_COLLAPSE would most likely fa=
il
> > > > > anyways.
> > > >
> > > > Hrmmm... well I /do/ like to run memory constrained VMs to prod rec=
laim
> > > > into stressing the filesystem more.  But I guess there's no good wa=
y for
> > > > fsx to know that something happened to it.  Unless there's some eve=
n
> > > > goofier way to force a hugepage, like shmem/hugetlbfs (ugh!) :)
> > > >
> > > > Will have to ponder hugepage renewasl -- maybe we should madvise ev=
ery
> > > > few thousand fsxops just to be careful?
> > > >
> > >
> > > I wonder.. is there test value in doing collapses to the target file =
as
> > > well, either as a standalone map/madvise command or a random thing
> > > hitched onto preexisting commands? If so, I could see how something l=
ike
> > > that could potentially lift the current init time only approach into
> > > something that occurs with frequency, which then could at the same ti=
me
> > > (again maybe randomly) reinvoke for internal buffers as well.
> >
> > My understanding is that if a filesystem has support enabled for large
> > folios, then doing large writes/reads (which I believe is currently
> > supported in fsx via the -o flag) will already automatically test the
> > functionality of how the filesystem handles hugepages. I don't think
> > this would be different from what doing a collapse on the target file
> > would do.
> >
>
> Ah, that is a good point. So maybe not that useful to have something
> that would hook into writes. OTOH, fsx does a lot of random ops in the
> general case. I wonder how likely it is to sustain large folios in a
> typical long running test and whether explicit madvise calls thrown into
> the mix would make any difference at all.

I think this would run into the same case where if there's enough
severe memory constraint to where reclaim has to break up hugepages in
the page cache, then explicit madvise calls to collapse these pages
back together would most likely fail.

>
> I suppose there may also be an argument that doing collapses provides
> more test coverage than purely doing larger folio allocations at write
> time..? I don't know the code well enough to say whether there is any
> value there. FWIW, what I think is more interesting from the fsx side is
> the oddball sequences of operations that it can create to uncover
> similarly odd problems. IOW, in theory if we had a randomish "collapse
> target range before next operation," would that effectively provide more
> coverage with how the various supported ops interact with large folios
> over current behavior?

I  don't think collapses would have any effect on test coverage. For
filesystems that don't support hugepages, the collapse would fail and
for filesystems that do support hugepages, the folio would already be
a hugepage and the collapse would be a no-op.


Thanks,
Joanne

>
> But anyways, this is all nebulous and strikes me more as maybe something
> interesting to play with as a potential future enhancement more than
> anything. BTW, is there any good way to measure use of large folios in
> general and/or on a particular file? I.e., collapse/split stats or some
> such thing..? Thanks.
>
> Brian
>
> >
> > Thanks,
> > Joanne
> >
> > >
> > > All that said, this is new functionality and IIUC provides functional
> > > test coverage for a valid issue. IMO, it would be nice to get this
> > > merged as a baseline feature and explore these sort of enhancements a=
s
> > > followon work. Just my .02.
> > >
> > > Brian
> > >
> > > > --D
> > > >
> > > > >
> > > > > Thanks,
> > > > > Joanne
> > > > >
> > > > > > > +             prterr("madvise collapse for buf");
> > > > > > > +             free(buf);
> > > > > > > +             return NULL;
> > > > > > > +     }
> > > > > > > +
> > > > > > > +     return buf;
> > > > > > > +}
> > > > > > > +#else
> > > > > > > +static void *
> > > > > > > +init_hugepages_buf(unsigned len, int hugepage_size, int alig=
nment)
> > > > > > > +{
> > > > > > > +     return NULL;
> > > > > > > +}
> > > > > > > +#endif
> > > > > > > +
> > > > > > > +static void
> > > > > > > +init_buffers(void)
> > > > > > > +{
> > > > > > > +     int i;
> > > > > > > +
> > > > > > > +     original_buf =3D (char *) malloc(maxfilelen);
> > > > > > > +     for (i =3D 0; i < maxfilelen; i++)
> > > > > > > +             original_buf[i] =3D random() % 256;
> > > > > > > +     if (hugepages) {
> > > > > > > +             long hugepage_size =3D get_hugepage_size();
> > > > > > > +             if (hugepage_size =3D=3D -1) {
> > > > > > > +                     prterr("get_hugepage_size()");
> > > > > > > +                     exit(102);
> > > > > > > +             }
> > > > > > > +             good_buf =3D init_hugepages_buf(maxfilelen, hug=
epage_size, writebdy);
> > > > > > > +             if (!good_buf) {
> > > > > > > +                     prterr("init_hugepages_buf failed for g=
ood_buf");
> > > > > > > +                     exit(103);
> > > > > > > +             }
> > > > > > > +
> > > > > > > +             temp_buf =3D init_hugepages_buf(maxoplen, hugep=
age_size, readbdy);
> > > > > > > +             if (!temp_buf) {
> > > > > > > +                     prterr("init_hugepages_buf failed for t=
emp_buf");
> > > > > > > +                     exit(103);
> > > > > > > +             }
> > > > > > > +     } else {
> > > > > > > +             unsigned long good_buf_len =3D maxfilelen + wri=
tebdy;
> > > > > > > +             unsigned long temp_buf_len =3D maxoplen + readb=
dy;
> > > > > > > +
> > > > > > > +             good_buf =3D calloc(1, good_buf_len);
> > > > > > > +             temp_buf =3D calloc(1, temp_buf_len);
> > > > > > > +     }
> > > > > > > +     good_buf =3D round_ptr_up(good_buf, writebdy, 0);
> > > > > > > +     temp_buf =3D round_ptr_up(temp_buf, readbdy, 0);
> > > > > > > +}
> > > > > > > +
> > > > > > >  static struct option longopts[] =3D {
> > > > > > >       {"replay-ops", required_argument, 0, 256},
> > > > > > >       {"record-ops", optional_argument, 0, 255},
> > > > > > > @@ -2883,7 +2980,7 @@ main(int argc, char **argv)
> > > > > > >       setvbuf(stdout, (char *)0, _IOLBF, 0); /* line buffered=
 stdout */
> > > > > > >
> > > > > > >       while ((ch =3D getopt_long(argc, argv,
> > > > > > > -                              "0b:c:de:fg:i:j:kl:m:no:p:qr:s=
:t:uw:xyABD:EFJKHzCILN:OP:RS:UWXZ",
> > > > > > > +                              "0b:c:de:fg:hi:j:kl:m:no:p:qr:=
s:t:uw:xyABD:EFJKHzCILN:OP:RS:UWXZ",
> > > > > > >                                longopts, NULL)) !=3D EOF)
> > > > > > >               switch (ch) {
> > > > > > >               case 'b':
> > > > > > > @@ -2916,6 +3013,14 @@ main(int argc, char **argv)
> > > > > > >               case 'g':
> > > > > > >                       filldata =3D *optarg;
> > > > > > >                       break;
> > > > > > > +             case 'h':
> > > > > > > +                     #ifndef MADV_COLLAPSE
> > > > > >
> > > > > > Preprocessor directives should start at column 0, like most of =
the rest
> > > > > > of fstests.
> > > > > >
> > > > > > --D
> > > > > >
> > > >
> > >
> >
>

