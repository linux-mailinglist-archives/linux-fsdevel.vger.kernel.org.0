Return-Path: <linux-fsdevel+bounces-39345-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E612AA1302B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2025 01:47:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E8AD16547C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2025 00:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DA3E171D2;
	Thu, 16 Jan 2025 00:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WDXtdqFX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5769A50;
	Thu, 16 Jan 2025 00:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736988464; cv=none; b=t7ZxHpsGKZ1WJkIAKi254lvkcn1GuFMTUdcqFonbEv2cxoBOIFjk06izdmCjzlGW+UNxjx3Wlr5hEXRTzQyMnvuMhfPcCZwSka/3YH6Zz7/MAtaJ2q8tUzpG5+D71i6Nu2o6SWn8m/PLszxV7SyEy07zu5PN0SITWkf63lqx/1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736988464; c=relaxed/simple;
	bh=iliA/Dvg+JaMF47ZvNJpDvPHksC5QcZ2zDhUlkPey3U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=belqem4DItPbMd9DxqyCQaxAOoB69xBTaelow+ZlO2DD8ZQYTgJFR3uCfpKjMhSwVfqJlb5UuKVop+rFMw/BiPbMu/ZO4yo0gomC4z/nJQirju3+c3uMv+1rs4GMw/ZuSqK3RkpQqfFGAy4Z7B5KrMua4l8D95+x3nhbkMRMVNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WDXtdqFX; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4678cce3d60so4397551cf.2;
        Wed, 15 Jan 2025 16:47:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736988461; x=1737593261; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i3OwErW9YnKnsdSwdaHEMLPYPbapkD+iAJBf0OUq5gw=;
        b=WDXtdqFXMyXGShu8NaXKn0sY285urc0vPC8shpsnCcPHSLhxFGpnN+xtUy4I2oK2gr
         gurj0YY3YgkxWFQUgaBQiS+FUCgcTPeROMRxMN9EEB8LW4vqkhIVKuGF1pz1FqU9kUtN
         10ITlor/dD7Jhe7I5E4YYUfRASOTxUneWzOf8DndlvRp5nFtPMM4Y8hfTw/TRpvTHv6M
         ERGtPT5H72aPIRRNQs79mmZznOc7MLO+JpJfpOOu+GtQ4wzdk5BrvxAtq5EMCET3bJPs
         V97fDu9cY91curAalE3i4nM43SG9FZ7AVWlEhvlYrKawOreMEJZBrTPydlDEd3RInJGS
         cRkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736988461; x=1737593261;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i3OwErW9YnKnsdSwdaHEMLPYPbapkD+iAJBf0OUq5gw=;
        b=VjltmAt+mDwWRcOF3AZzzE8qMe51e1EzDW46HLtSnwSdN7p1yjKM73lu+1DRY3EcOu
         kV+oxDsiXoD6RDUj5u7zwTIu35Ia+YtauYNivNvApFRJ7u2bDDKff+XwjyR251Lr5V62
         sNks5LeGwxx1syiVSsepwivJMzIxmPq87KTau9pRUlINqv8moGC9ygfkCYP6glzkENEG
         /V8J8Of5nCCc9GIlXBgLRXG472o2Von00yX2n1s51PuCU0t2rQ0aIyZKSBrcFPNAenmc
         U4jG4TtOCjOfWYrxGXDG/A+ivV1Lvzqh9NCVIYVXSQbOWEijfzTNTnveQYkRmhkPbY8F
         mS4w==
X-Forwarded-Encrypted: i=1; AJvYcCVSihPJvB9y/kxRsL1E2+Z7QyX9spYxh+tZv8yNd0rOxMK6RqzGS3hVRo8oPdGjL9wQNnwFf+52zsiyTPHh@vger.kernel.org
X-Gm-Message-State: AOJu0YzP7M9yBd83djzglNKd7aBO79RMThNB/ILUrjpI3aXAFzGmuJW4
	SBj1rBT2pHD9chwZuzpX+TvPk9MGjAKuiQSSsvrJBCPaoxlDTqPiN6tTH2ve5QjBjxkD62JHmmd
	I3KitxbjtxuKpCYU20JWtSBp370I=
X-Gm-Gg: ASbGncsggzm/93OuVsD5kMHwSRD1XpaL6X7zmzLFjW22Zq7yFLW/9PcJc6CftpVUeuZ
	h4PQwRdPVtyTlJeqz7fmQnzF3+ObcWY3/kqfeRmlswGc2MUXIFWgsZg==
X-Google-Smtp-Source: AGHT+IG/iEfB/hAVzTXLR6ZZcOkTCheBGj3tT6nhBHRY67b/uj3CGohWmlWvkZcpVI3jAtGHfBhq/35tetGoeFV8P7U=
X-Received: by 2002:ac8:5916:0:b0:467:5457:c380 with SMTP id
 d75a77b69052e-46c710a5a4cmr530470551cf.52.1736988461545; Wed, 15 Jan 2025
 16:47:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250115183107.3124743-1-joannelkoong@gmail.com>
 <20250115183107.3124743-2-joannelkoong@gmail.com> <20250115213713.GE3557695@frogsfrogsfrogs>
In-Reply-To: <20250115213713.GE3557695@frogsfrogsfrogs>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 15 Jan 2025 16:47:30 -0800
X-Gm-Features: AbW1kvbnPk2A1dKSC2lFot01LDx6K2e8766XimCXN-TLYKSrSnNvNN1uBCQR37g
Message-ID: <CAJnrk1YXa++SrifrCfXf7WPQF34V20cet3+x+7wVuDf9CPoR7w@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] fsx: support reads/writes from buffers backed by hugepages
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: fstests@vger.kernel.org, linux-fsdevel@vger.kernel.org, bfoster@redhat.com, 
	nirjhar@linux.ibm.com, zlang@redhat.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 15, 2025 at 1:37=E2=80=AFPM Darrick J. Wong <djwong@kernel.org>=
 wrote:
>
> On Wed, Jan 15, 2025 at 10:31:06AM -0800, Joanne Koong wrote:
> > Add support for reads/writes from buffers backed by hugepages.
> > This can be enabled through the '-h' flag. This flag should only be use=
d
> > on systems where THP capabilities are enabled.
> >
> > This is motivated by a recent bug that was due to faulty handling of
> > userspace buffers backed by hugepages. This patch is a mitigation
> > against problems like this in the future.
> >
> > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > Reviewed-by: Brian Foster <bfoster@redhat.com>
> > ---
> >  ltp/fsx.c | 119 +++++++++++++++++++++++++++++++++++++++++++++++++-----
> >  1 file changed, 108 insertions(+), 11 deletions(-)
> >
> > diff --git a/ltp/fsx.c b/ltp/fsx.c
> > index 41933354..8d3a2e2c 100644
> > --- a/ltp/fsx.c
> > +++ b/ltp/fsx.c
> > @@ -190,6 +190,7 @@ int       o_direct;                       /* -Z */
> >  int  aio =3D 0;
> >  int  uring =3D 0;
> >  int  mark_nr =3D 0;
> > +int  hugepages =3D 0;                  /* -h flag */
> >
> >  int page_size;
> >  int page_mask;
> > @@ -2471,7 +2472,7 @@ void
> >  usage(void)
> >  {
> >       fprintf(stdout, "usage: %s",
> > -             "fsx [-dfknqxyzBEFHIJKLORWXZ0]\n\
> > +             "fsx [-dfhknqxyzBEFHIJKLORWXZ0]\n\
> >          [-b opnum] [-c Prob] [-g filldata] [-i logdev] [-j logid]\n\
> >          [-l flen] [-m start:end] [-o oplen] [-p progressinterval]\n\
> >          [-r readbdy] [-s style] [-t truncbdy] [-w writebdy]\n\
> > @@ -2484,6 +2485,7 @@ usage(void)
> >       -e: pollute post-eof on size changes (default 0)\n\
> >       -f: flush and invalidate cache after I/O\n\
> >       -g X: write character X instead of random generated data\n\
> > +     -h hugepages: use buffers backed by hugepages for reads/writes\n\
>
> If this requires MADV_COLLAPSE, then perhaps the help text shouldn't
> describe the switch if the support wasn't compiled in?
>
> e.g.
>
>         -g X: write character X instead of random generated data\n"
> #ifdef MADV_COLLAPSE
> "       -h hugepages: use buffers backed by hugepages for reads/writes\n"
> #endif
> "       -i logdev: do integrity testing, logdev is the dm log writes devi=
ce\n\
>
> (assuming I got the preprocessor and string construction goo right; I
> might be a few cards short of a deck due to zombie attack earlier)

Sounds great, I'll #ifdef out the help text -h line. Hope you feel better.
>
> >       -i logdev: do integrity testing, logdev is the dm log writes devi=
ce\n\
> >       -j logid: prefix debug log messsages with this id\n\
> >       -k: do not truncate existing file and use its size as upper bound=
 on file size\n\
[...]
> > +}
> > +
> > +#ifdef MADV_COLLAPSE
> > +static void *
> > +init_hugepages_buf(unsigned len, int hugepage_size, int alignment)
> > +{
> > +     void *buf;
> > +     long buf_size =3D roundup(len, hugepage_size) + alignment;
> > +
> > +     if (posix_memalign(&buf, hugepage_size, buf_size)) {
> > +             prterr("posix_memalign for buf");
> > +             return NULL;
> > +     }
> > +     memset(buf, '\0', buf_size);
> > +     if (madvise(buf, buf_size, MADV_COLLAPSE)) {
>
> If the fsx runs for a long period of time, will it be necessary to call
> MADV_COLLAPSE periodically to ensure that reclaim doesn't break up the
> hugepage?
>

imo, I don't think so. My understanding is that this would be a rare
edge case that happens when the system is constrained on memory, in
which case subsequent calls to MADV_COLLAPSE would most likely fail
anyways.


Thanks,
Joanne

> > +             prterr("madvise collapse for buf");
> > +             free(buf);
> > +             return NULL;
> > +     }
> > +
> > +     return buf;
> > +}
> > +#else
> > +static void *
> > +init_hugepages_buf(unsigned len, int hugepage_size, int alignment)
> > +{
> > +     return NULL;
> > +}
> > +#endif
> > +
> > +static void
> > +init_buffers(void)
> > +{
> > +     int i;
> > +
> > +     original_buf =3D (char *) malloc(maxfilelen);
> > +     for (i =3D 0; i < maxfilelen; i++)
> > +             original_buf[i] =3D random() % 256;
> > +     if (hugepages) {
> > +             long hugepage_size =3D get_hugepage_size();
> > +             if (hugepage_size =3D=3D -1) {
> > +                     prterr("get_hugepage_size()");
> > +                     exit(102);
> > +             }
> > +             good_buf =3D init_hugepages_buf(maxfilelen, hugepage_size=
, writebdy);
> > +             if (!good_buf) {
> > +                     prterr("init_hugepages_buf failed for good_buf");
> > +                     exit(103);
> > +             }
> > +
> > +             temp_buf =3D init_hugepages_buf(maxoplen, hugepage_size, =
readbdy);
> > +             if (!temp_buf) {
> > +                     prterr("init_hugepages_buf failed for temp_buf");
> > +                     exit(103);
> > +             }
> > +     } else {
> > +             unsigned long good_buf_len =3D maxfilelen + writebdy;
> > +             unsigned long temp_buf_len =3D maxoplen + readbdy;
> > +
> > +             good_buf =3D calloc(1, good_buf_len);
> > +             temp_buf =3D calloc(1, temp_buf_len);
> > +     }
> > +     good_buf =3D round_ptr_up(good_buf, writebdy, 0);
> > +     temp_buf =3D round_ptr_up(temp_buf, readbdy, 0);
> > +}
> > +
> >  static struct option longopts[] =3D {
> >       {"replay-ops", required_argument, 0, 256},
> >       {"record-ops", optional_argument, 0, 255},
> > @@ -2883,7 +2980,7 @@ main(int argc, char **argv)
> >       setvbuf(stdout, (char *)0, _IOLBF, 0); /* line buffered stdout */
> >
> >       while ((ch =3D getopt_long(argc, argv,
> > -                              "0b:c:de:fg:i:j:kl:m:no:p:qr:s:t:uw:xyAB=
D:EFJKHzCILN:OP:RS:UWXZ",
> > +                              "0b:c:de:fg:hi:j:kl:m:no:p:qr:s:t:uw:xyA=
BD:EFJKHzCILN:OP:RS:UWXZ",
> >                                longopts, NULL)) !=3D EOF)
> >               switch (ch) {
> >               case 'b':
> > @@ -2916,6 +3013,14 @@ main(int argc, char **argv)
> >               case 'g':
> >                       filldata =3D *optarg;
> >                       break;
> > +             case 'h':
> > +                     #ifndef MADV_COLLAPSE
>
> Preprocessor directives should start at column 0, like most of the rest
> of fstests.
>
> --D
>

