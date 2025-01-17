Return-Path: <linux-fsdevel+bounces-39454-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 444B6A1473C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jan 2025 02:04:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0A40188D47A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jan 2025 01:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E4EE17555;
	Fri, 17 Jan 2025 01:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V7GiTQax"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1DBB25A64F;
	Fri, 17 Jan 2025 01:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737075835; cv=none; b=drigIy3+LqIfiJRoExzOUloS8bq77d/EfSTFXmx2Dr2iEgFkm41GvZlaOdmQZ8BzEg8EvxmQArinDV7qsKEAK8d0a3tx9Nz18u3m1I37I94szixSsxqA86GENCUW8U1d/UGZzCdV0JJQRBepWGjmu2MktI4Df+7i30y9l7O358c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737075835; c=relaxed/simple;
	bh=rYwPBwWIXVqUelSauZCKCAgUp+AHNmn2az6E8KRUC+0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oz5eako5NAq8jMaoJGTxZ1ocHaN7ZKIVpB0r9aqgK/iSb0wIc/RO5JCokRqrjUEJ77vZ1JCjkBhyXf8FwYsVnjV6kIZabNeAbaCsaYiRWqm557ODQn/jZzyuchGc6VQreePcps5K5dDHp44BV1LioV1OsZX3a+t3zc2mnxWgo68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V7GiTQax; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-46defafbdafso18489191cf.0;
        Thu, 16 Jan 2025 17:03:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737075832; x=1737680632; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BWTn2hIqOedJTkStLOdCs7NFe2va4E3NluJ3a3sdVf8=;
        b=V7GiTQaxegjr8b//68cm0JgY+VWB+1Xc3lm7hCwH8flYhNABkTO6fIS+dOUjfzuPNc
         FIcXJDgW5YmGcmd+DWrZpiac2zL10Xyb1Ik/71IEIfAFKDz2JBd17Yu1Urao7HiK7+P0
         fx0akfYowGouY2LXa7BWrF38JxX38bfE+pPHBg1UbuP2ruEre7LYs2x3MIRmwLH/SvsJ
         2TureAICnNLN7RrwCE1MlQ6+r7xUD/eOv/GsNR4wActXCF/WV6wgJlc4Tr0BtvLpTSkr
         Vn0mI2VtT7NW2pfuE0oVNmNptgO7G7gx03bcYH51nfCvT9noJoxhNddUtGc0liDiV1zD
         llhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737075832; x=1737680632;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BWTn2hIqOedJTkStLOdCs7NFe2va4E3NluJ3a3sdVf8=;
        b=Fnqxu/j+bA82gvh1/NYHS8X1CiWGKdP6naGeIPkd8byKP68MFzHAuP3UA/mmrqO5KF
         SsFDIw3xn4Ca2HTppuzIs3cTlIoaho+Yr18ZDu9Me8RZT0CKZ4m1L6PK+tkrrVxIfnah
         NAcok/suJh15iscZXAA1pV/e8spGaPJ2nvy0BZ28nHSJfGYdZR27jDWs2rC3WKSlu6m+
         11r6Z6BTsZHo0dhprC2p+/1EoEughdSteBpZ6O7HpYEJgwSff8gI4Xzmx74apUJthyO9
         6Jt5pz6ueXocF8mGwJ6Ieb8Jb5Bm4qyC6yZbiakx7i21A+FbJ7D28CRu7azh1qHM2iiK
         0A2g==
X-Forwarded-Encrypted: i=1; AJvYcCV12bJD4KBpVVIjE2lDS9ZepX2PE8fnBj1W69+G1R4DS7XDdckRh7Lv4NYhJK8AbiZJ7xi9YdNJldjPtmFo@vger.kernel.org
X-Gm-Message-State: AOJu0YxtRB8jzeWS9O/Jb8NvPO8y3s2J8je/tOiIJydIq3jgV1IV6tRo
	e4l4PlC72AO6NAlsojEEaErs6Vu+ZQhYNh+vtGiJnfdnZvO0P2uLmVbA+rRu7jKQHRrTxpnsNXs
	YY/ipljI8tq1sx7b4Dgh3W9QWOCg=
X-Gm-Gg: ASbGnct7TPSwoG1PoQzku3zZ03XE5D2IXt+6jRSjzXSMKrCNJsqvAuvTL5bDyUxQyLw
	8If37Wno1xQEwKKTn1U4exPAc6+Gr6HX+F20xmfM=
X-Google-Smtp-Source: AGHT+IEbqeIv2jG7FV9kyk09fzj6AzxO9SgggQixsUsvWEIp17Mi4ed2RUJtjtKAkKfdkh2kzpbl/Jox5R1dUEXK9dw=
X-Received: by 2002:a05:622a:593:b0:46c:716f:d76 with SMTP id
 d75a77b69052e-46e12a54b3cmr12219361cf.12.1737075832502; Thu, 16 Jan 2025
 17:03:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250115183107.3124743-1-joannelkoong@gmail.com>
 <20250115183107.3124743-2-joannelkoong@gmail.com> <20250115213713.GE3557695@frogsfrogsfrogs>
 <CAJnrk1YXa++SrifrCfXf7WPQF34V20cet3+x+7wVuDf9CPoR7w@mail.gmail.com> <20250116005919.GK3557553@frogsfrogsfrogs>
In-Reply-To: <20250116005919.GK3557553@frogsfrogsfrogs>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Thu, 16 Jan 2025 17:03:41 -0800
X-Gm-Features: AbW1kvYHGRLoGZlz8qZfoZWjbEX0ksm_vHOD16Mh18NCTHv4a1Q3a6ODLir8k2E
Message-ID: <CAJnrk1ZpjnAL26x7KdX_33bgX7YdJN1hnPmn6zAgM38p4uBopw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] fsx: support reads/writes from buffers backed by hugepages
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: fstests@vger.kernel.org, linux-fsdevel@vger.kernel.org, bfoster@redhat.com, 
	nirjhar@linux.ibm.com, zlang@redhat.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 15, 2025 at 4:59=E2=80=AFPM Darrick J. Wong <djwong@kernel.org>=
 wrote:
>
> On Wed, Jan 15, 2025 at 04:47:30PM -0800, Joanne Koong wrote:
> > On Wed, Jan 15, 2025 at 1:37=E2=80=AFPM Darrick J. Wong <djwong@kernel.=
org> wrote:
> > >
> > > On Wed, Jan 15, 2025 at 10:31:06AM -0800, Joanne Koong wrote:
> > > > Add support for reads/writes from buffers backed by hugepages.
> > > > This can be enabled through the '-h' flag. This flag should only be=
 used
> > > > on systems where THP capabilities are enabled.
> > > >
> > > > This is motivated by a recent bug that was due to faulty handling o=
f
> > > > userspace buffers backed by hugepages. This patch is a mitigation
> > > > against problems like this in the future.
> > > >
> > > > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > > > Reviewed-by: Brian Foster <bfoster@redhat.com>
> > > > ---
> > > >  ltp/fsx.c | 119 +++++++++++++++++++++++++++++++++++++++++++++++++-=
----
> > > >  1 file changed, 108 insertions(+), 11 deletions(-)
> > > >
> > > > diff --git a/ltp/fsx.c b/ltp/fsx.c
> > > > index 41933354..8d3a2e2c 100644
> > > > --- a/ltp/fsx.c
> > > > +++ b/ltp/fsx.c
> > > > @@ -190,6 +190,7 @@ int       o_direct;                       /* -Z=
 */
> > > >  int  aio =3D 0;
> > > >  int  uring =3D 0;
> > > >  int  mark_nr =3D 0;
> > > > +int  hugepages =3D 0;                  /* -h flag */
> > > >
> > > >  int page_size;
> > > >  int page_mask;
> > > > @@ -2471,7 +2472,7 @@ void
> > > >  usage(void)
> > > >  {
> > > >       fprintf(stdout, "usage: %s",
> > > > -             "fsx [-dfknqxyzBEFHIJKLORWXZ0]\n\
> > > > +             "fsx [-dfhknqxyzBEFHIJKLORWXZ0]\n\
> > > >          [-b opnum] [-c Prob] [-g filldata] [-i logdev] [-j logid]\=
n\
> > > >          [-l flen] [-m start:end] [-o oplen] [-p progressinterval]\=
n\
> > > >          [-r readbdy] [-s style] [-t truncbdy] [-w writebdy]\n\
> > > > @@ -2484,6 +2485,7 @@ usage(void)
> > > >       -e: pollute post-eof on size changes (default 0)\n\
> > > >       -f: flush and invalidate cache after I/O\n\
> > > >       -g X: write character X instead of random generated data\n\
> > > > +     -h hugepages: use buffers backed by hugepages for reads/write=
s\n\
> > >
> > > If this requires MADV_COLLAPSE, then perhaps the help text shouldn't
> > > describe the switch if the support wasn't compiled in?
> > >
> > > e.g.
> > >
> > >         -g X: write character X instead of random generated data\n"
> > > #ifdef MADV_COLLAPSE
> > > "       -h hugepages: use buffers backed by hugepages for reads/write=
s\n"
> > > #endif
> > > "       -i logdev: do integrity testing, logdev is the dm log writes =
device\n\
> > >
> > > (assuming I got the preprocessor and string construction goo right; I
> > > might be a few cards short of a deck due to zombie attack earlier)
> >
> > Sounds great, I'll #ifdef out the help text -h line. Hope you feel bett=
er.
> > >
> > > >       -i logdev: do integrity testing, logdev is the dm log writes =
device\n\
> > > >       -j logid: prefix debug log messsages with this id\n\
> > > >       -k: do not truncate existing file and use its size as upper b=
ound on file size\n\
> > [...]
> > > > +}
> > > > +
> > > > +#ifdef MADV_COLLAPSE
> > > > +static void *
> > > > +init_hugepages_buf(unsigned len, int hugepage_size, int alignment)
> > > > +{
> > > > +     void *buf;
> > > > +     long buf_size =3D roundup(len, hugepage_size) + alignment;
> > > > +
> > > > +     if (posix_memalign(&buf, hugepage_size, buf_size)) {
> > > > +             prterr("posix_memalign for buf");
> > > > +             return NULL;
> > > > +     }
> > > > +     memset(buf, '\0', buf_size);
> > > > +     if (madvise(buf, buf_size, MADV_COLLAPSE)) {
> > >
> > > If the fsx runs for a long period of time, will it be necessary to ca=
ll
> > > MADV_COLLAPSE periodically to ensure that reclaim doesn't break up th=
e
> > > hugepage?
> > >
> >
> > imo, I don't think so. My understanding is that this would be a rare
> > edge case that happens when the system is constrained on memory, in
> > which case subsequent calls to MADV_COLLAPSE would most likely fail
> > anyways.
>
> Hrmmm... well I /do/ like to run memory constrained VMs to prod reclaim
> into stressing the filesystem more.  But I guess there's no good way for
> fsx to know that something happened to it.  Unless there's some even
> goofier way to force a hugepage, like shmem/hugetlbfs (ugh!) :)

I can't think of a better way to force a hugepage either. I believe
shmem and hugetlbfs would both require root privileges to do so, and
if i'm not mistaken, shmem hugepages are still subject to being broken
up by reclaim.

>
> Will have to ponder hugepage renewasl -- maybe we should madvise every
> few thousand fsxops just to be careful?

I can add this in, but on memory constrained VMs, would this be
effective? To me, it seems like in the majority of cases, subsequent
attempts at collapsing the broken pages back into a hugepage would
fail due to memory still being constrained. In which case, I guess
we'd exit the test altogether? It kind of seems to me like if the user
wants to test out hugepages functionality of their filesystem, then
the onus is on them to run the test in an environment that can
adequately and consistently support hugepages.

Thanks,
Joanne

>
> --D
>
> >
> > Thanks,
> > Joanne
> >
> > > > +             prterr("madvise collapse for buf");
> > > > +             free(buf);
> > > > +             return NULL;
> > > > +     }
> > > > +
> > > > +     return buf;
> > > > +}
> > > > +#else
> > > > +static void *
> > > > +init_hugepages_buf(unsigned len, int hugepage_size, int alignment)
> > > > +{
> > > > +     return NULL;
> > > > +}
> > > > +#endif
> > > > +
> > > > +static void
> > > > +init_buffers(void)
> > > > +{
> > > > +     int i;
> > > > +
> > > > +     original_buf =3D (char *) malloc(maxfilelen);
> > > > +     for (i =3D 0; i < maxfilelen; i++)
> > > > +             original_buf[i] =3D random() % 256;
> > > > +     if (hugepages) {
> > > > +             long hugepage_size =3D get_hugepage_size();
> > > > +             if (hugepage_size =3D=3D -1) {
> > > > +                     prterr("get_hugepage_size()");
> > > > +                     exit(102);
> > > > +             }
> > > > +             good_buf =3D init_hugepages_buf(maxfilelen, hugepage_=
size, writebdy);
> > > > +             if (!good_buf) {
> > > > +                     prterr("init_hugepages_buf failed for good_bu=
f");
> > > > +                     exit(103);
> > > > +             }
> > > > +
> > > > +             temp_buf =3D init_hugepages_buf(maxoplen, hugepage_si=
ze, readbdy);
> > > > +             if (!temp_buf) {
> > > > +                     prterr("init_hugepages_buf failed for temp_bu=
f");
> > > > +                     exit(103);
> > > > +             }
> > > > +     } else {
> > > > +             unsigned long good_buf_len =3D maxfilelen + writebdy;
> > > > +             unsigned long temp_buf_len =3D maxoplen + readbdy;
> > > > +
> > > > +             good_buf =3D calloc(1, good_buf_len);
> > > > +             temp_buf =3D calloc(1, temp_buf_len);
> > > > +     }
> > > > +     good_buf =3D round_ptr_up(good_buf, writebdy, 0);
> > > > +     temp_buf =3D round_ptr_up(temp_buf, readbdy, 0);
> > > > +}
> > > > +
> > > >  static struct option longopts[] =3D {
> > > >       {"replay-ops", required_argument, 0, 256},
> > > >       {"record-ops", optional_argument, 0, 255},
> > > > @@ -2883,7 +2980,7 @@ main(int argc, char **argv)
> > > >       setvbuf(stdout, (char *)0, _IOLBF, 0); /* line buffered stdou=
t */
> > > >
> > > >       while ((ch =3D getopt_long(argc, argv,
> > > > -                              "0b:c:de:fg:i:j:kl:m:no:p:qr:s:t:uw:=
xyABD:EFJKHzCILN:OP:RS:UWXZ",
> > > > +                              "0b:c:de:fg:hi:j:kl:m:no:p:qr:s:t:uw=
:xyABD:EFJKHzCILN:OP:RS:UWXZ",
> > > >                                longopts, NULL)) !=3D EOF)
> > > >               switch (ch) {
> > > >               case 'b':
> > > > @@ -2916,6 +3013,14 @@ main(int argc, char **argv)
> > > >               case 'g':
> > > >                       filldata =3D *optarg;
> > > >                       break;
> > > > +             case 'h':
> > > > +                     #ifndef MADV_COLLAPSE
> > >
> > > Preprocessor directives should start at column 0, like most of the re=
st
> > > of fstests.
> > >
> > > --D
> > >

