Return-Path: <linux-fsdevel+bounces-40818-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92F7EA27CF1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 21:54:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 459011885917
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 20:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D442E21A432;
	Tue,  4 Feb 2025 20:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hsAtfFeG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D7619E83E;
	Tue,  4 Feb 2025 20:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738702485; cv=none; b=L94KQAw+ksUzDfMBRhrBPSy4NPgZh9R1fcIFI1OJPjDi2XgksGZliWZINwwHlyQeRcZScR5kGBASdSHslR30kR2pQoLf1fnanmWMKnPN0gZyseQ79G+PCcGybk3SYlKSThWoCWueqAh/ezZUh38Y4KhGQt8Ea8QNlF9gXFuCqjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738702485; c=relaxed/simple;
	bh=LbaKGIxZ5Lk9tk2lyFHAqcJ1LYr8y+4ojj6wkCb/LZs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HMYAo5MP00CwAZ855x+LJ+UsgDCtc/vMYCDUzYqZYC1GhlWY8921f+JHNMnQh+Q5EDMmLoRIjI7+LctlEVYvBN03hPQAmMJ1Z71DYnRrULCLrMWBoEEoEIoRq/tSKu6w8ihpU/BYFGOTwDXxlewFgsuN8uWSIQjyefuY5gRhQwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hsAtfFeG; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-53e389d8dc7so6019763e87.0;
        Tue, 04 Feb 2025 12:54:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738702481; x=1739307281; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p87g+lwP0D9PBNYzNfr4k0//n62le703ASsZ3eKF7W8=;
        b=hsAtfFeGyJ0FkCxQ1HcOpoZZhXEsfv/irjoyUJQuuzEzPidLNzFF2QU/eheN82hifR
         l5NZohPhB/ZUZDSl5U55c9/BIh7Qb4RzTfWWUAw/ZtOgN5RI0NGehak938vz+xebl6Qt
         0l+YYbfYhp4oNFd7aOb+ucPUioPvrDZeAyuLt4biYJkdO+OPBjmr9yyr2MZ6a8QaMdoq
         pwPCWsJ4K6yhxGC9J6c/N5/cPgbw9/0SVREefGz2UhUJc9OGq7Hp/duwv6jbKlIpeeu0
         rvq0n5kMjbFMlth64Ax88FotCmIr8LNAtfK96VFtAZ15KLkh4yslbyvAmCtnBytcbtAI
         ZwNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738702481; x=1739307281;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p87g+lwP0D9PBNYzNfr4k0//n62le703ASsZ3eKF7W8=;
        b=O2KIHw1p9CHFcbvrzGlh7p84R9OTdoNJM5Y45g9Fg2cUygSITUlEnmchNhZJeFCza9
         UWLS9Ls9JVyhV7kHAZbsHdfZHkVO6Tv9x5/S5ThrSeI+rmhRVYPWyZF0YIrMHgCD4yJb
         vm7/5yMuFmWDEN7ChyILlXuGFEi1KsELbVSl3JQVpCPtYTakSmoC1cgvSmedAW3TO3Hx
         xPJ8gK++0Ityns8IlPo4lExbFR3epBFfHW3Qr0I0VFWJLBSUYTFBar3N9FlBAg8320+G
         ePE6T94QHxLDwFNcQYMeOG0T2Vkm4A8M8+bJFFKAgMGjjUagFMAqAQBIh90Njgsjn62d
         +j5A==
X-Forwarded-Encrypted: i=1; AJvYcCVixfiXhqV6R7e6w9poMqpexZ3hrqpCcoPiatx7BwcZJPFCHMF+yPQx/I5U9uth8nFqStvMf84+ODgQl2ZB@vger.kernel.org
X-Gm-Message-State: AOJu0YzDgYhb35R6u09ogoDGx9EWxEstcSH6K1ngZS1lSeB97yRXOeus
	ihGK3CFEeH9EM51SnzfgbQ8ApckxEJTuoO8yYbU2x9zIkF0TvrTCoxOsGpLlBbaS1UYNf2qZTtN
	NZwCOEAQcZujff6GiIc4eT39OgCI=
X-Gm-Gg: ASbGnctSv0kInTm22gCLiKf1r+m2z/rqpvdQu44lqQK4t7qAiXCH0N+vEdD8iqil330
	pHIeTi+duDuKhs8VqEeDmKQaMeLXFxJf3hoGm+IZLy6DC3ahNBBMILzkr1wDF0ubmF0uosf00BA
	==
X-Google-Smtp-Source: AGHT+IGOxBtv0RA3eC4ClYqHczWkU2FDb2ou4bP3JrNOIjWtubDSMBZJOvbXdkuMZIeCmbXsMt/ndk4cniH9j77KUG4=
X-Received: by 2002:a05:6512:3f14:b0:540:3579:db34 with SMTP id
 2adb3069b0e04-544059fcfeemr57194e87.2.1738702481006; Tue, 04 Feb 2025
 12:54:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250121215641.1764359-1-joannelkoong@gmail.com>
 <20250121215641.1764359-2-joannelkoong@gmail.com> <20250202142518.r3xvf7mvfo2nhb7t@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <CAJnrk1YwBJQnFwYBcO50Xy2dA6df_SqQsHdpLux4wa-Yw5rXdg@mail.gmail.com> <20250204170541.hmk6guovolh5ohbx@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
In-Reply-To: <20250204170541.hmk6guovolh5ohbx@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 4 Feb 2025 12:54:24 -0800
X-Gm-Features: AWEUYZn6NG4WBbF7zN4rp-ZmEUn2nBTuQLwNsn6cebcmL8a1gPSO_jpmjN3_540
Message-ID: <CAJnrk1ap-tw3KVdByBY2-c0oDAA4XE8FkRx8qoE6ughjdzVJew@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] fsx: support reads/writes from buffers backed by hugepages
To: Zorro Lang <zlang@redhat.com>
Cc: fstests@vger.kernel.org, linux-fsdevel@vger.kernel.org, bfoster@redhat.com, 
	djwong@kernel.org, nirjhar@linux.ibm.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 4, 2025 at 9:05=E2=80=AFAM Zorro Lang <zlang@redhat.com> wrote:
>
> On Mon, Feb 03, 2025 at 10:04:04AM -0800, Joanne Koong wrote:
> > On Sun, Feb 2, 2025 at 6:25=E2=80=AFAM Zorro Lang <zlang@redhat.com> wr=
ote:
> > >
> > > On Tue, Jan 21, 2025 at 01:56:40PM -0800, Joanne Koong wrote:
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
> > > > Reviewed-by: Darrick J. Wong <djwong@kernel.org>
> > > > ---
> > >
> > > Those two test cases fail on old system which doesn't support
> > > MADV_COLLAPSE:
> > >
> > >    fsx -N 10000 -l 500000 -h
> > >   -fsx -N 10000 -o 8192 -l 500000 -h
> > >   -fsx -N 10000 -o 128000 -l 500000 -h
> > >   +MADV_COLLAPSE not supported. Can't support -h
> > >
> > > and
> > >
> > >    fsx -N 10000 -l 500000 -r PSIZE -t BSIZE -w BSIZE -Z -R -W -h
> > >   -fsx -N 10000 -o 8192 -l 500000 -r PSIZE -t BSIZE -w BSIZE -Z -R -W=
 -h
> > >   -fsx -N 10000 -o 128000 -l 500000 -r PSIZE -t BSIZE -w BSIZE -Z -R =
-W -h
> > >   +mapped writes DISABLED
> > >   +MADV_COLLAPSE not supported. Can't support -h
> > >
> > > I'm wondering ...
> > >
> > > >  ltp/fsx.c | 166 +++++++++++++++++++++++++++++++++++++++++++++++++-=
----
> > > >  1 file changed, 153 insertions(+), 13 deletions(-)
> > > >
> > > > diff --git a/ltp/fsx.c b/ltp/fsx.c
> > > > index 41933354..3be383c6 100644
> > > > --- a/ltp/fsx.c
> > > > +++ b/ltp/fsx.c
> > > > @@ -190,6 +190,16 @@ int      o_direct;                       /* -Z=
 */
> > > > +
> > > >  static struct option longopts[] =3D {
> > > >       {"replay-ops", required_argument, 0, 256},
> > > >       {"record-ops", optional_argument, 0, 255},
> > > > @@ -2883,7 +3023,7 @@ main(int argc, char **argv)
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
> > > > @@ -2916,6 +3056,14 @@ main(int argc, char **argv)
> > > >               case 'g':
> > > >                       filldata =3D *optarg;
> > > >                       break;
> > > > +             case 'h':
> > > > +#ifndef MADV_COLLAPSE
> > > > +                     fprintf(stderr, "MADV_COLLAPSE not supported.=
 "
> > > > +                             "Can't support -h\n");
> > > > +                     exit(86);
> > > > +#endif
> > > > +                     hugepages =3D 1;
> > > > +                     break;
> > >
> > > ...
> > > if we could change this part to:
> > >
> > > #ifdef MADV_COLLAPSE
> > >         hugepages =3D 1;
> > > #endif
> > >         break;
> > >
> > > to avoid the test failures on old systems.
> > >
> > > Or any better ideas from you :)
> >
> > Hi Zorro,
> >
> > It looks like MADV_COLLAPSE was introduced in kernel version 6.1. What
> > do you think about skipping generic/758 and generic/759 if the kernel
> > version is older than 6.1? That to me seems more preferable than the
> > paste above, as the paste above would execute the test as if it did
> > test hugepages when in reality it didn't, which would be misleading.
>
> Hi Joanne,
>
> Sorry I'm still on my holiday, reply a bit late and hastily. At first,
> your patch has been merged, the merged case numbers are g/759 and g/760,
> you can rebase to latest for-next branch and write new fix patch :)

Hi Zorro,

No worries at all. Thanks for your work on this.

>
> Then, you're right, above code change is bit rough;) Maybe there's a way
> to _notrun if MADV_COLLAPSE isn't supported?

I'll (or Darrick if we go with his solution) make sure to submit a fix
for this so that it doesn't break the older systems.

Thanks,
Joanne

>
> Thanks,
> Zorro
>
> >
> >
> > Thanks,
> > Joanne
> >
> > >
> > > Thanks,
> > > Zorro
> > >
> > > >               case 'i':
> > > >                       integrity =3D 1;
> > > >                       logdev =3D strdup(optarg);
> > > > @@ -3229,15 +3377,7 @@ main(int argc, char **argv)
> > > >                       exit(95);
> > > >               }
> > > >       }
> > > > -     original_buf =3D (char *) malloc(maxfilelen);
> > > > -     for (i =3D 0; i < maxfilelen; i++)
> > > > -             original_buf[i] =3D random() % 256;
> > > > -     good_buf =3D (char *) malloc(maxfilelen + writebdy);
> > > > -     good_buf =3D round_ptr_up(good_buf, writebdy, 0);
> > > > -     memset(good_buf, '\0', maxfilelen);
> > > > -     temp_buf =3D (char *) malloc(maxoplen + readbdy);
> > > > -     temp_buf =3D round_ptr_up(temp_buf, readbdy, 0);
> > > > -     memset(temp_buf, '\0', maxoplen);
> > > > +     init_buffers();
> > > >       if (lite) {     /* zero entire existing file */
> > > >               ssize_t written;
> > > >
> > > > --
> > > > 2.47.1
> > > >
> > >
> >
>

