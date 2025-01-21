Return-Path: <linux-fsdevel+bounces-39800-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 771B8A1877F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jan 2025 22:51:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABC901615F3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jan 2025 21:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C42B51F868C;
	Tue, 21 Jan 2025 21:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f8Umma9M"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D0711B85C5;
	Tue, 21 Jan 2025 21:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737496254; cv=none; b=Cg0F7RoB1k8OYXF4mdTr/dVX4oQiis/EQQbA91aDiIh1ii9ZdWneOJPCwJ8EhD6aPYPzLu7RmM/ZLg4BkQvzMm/yNeHR8C02THOstjNq3aOMsWgoykRsODjdlLD09kz1jd5EAFa84f1gwBqxiOQ88x74zOqxwFh2og82JdoyBFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737496254; c=relaxed/simple;
	bh=gky7iobCYT9Wn0S0WyZR7GOedaSJClP3bB7sLe/+FQs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z7J2IQwFa1BToXRadKmgE9fvwvNBQPCMCFFzPInccC3N8eyFM/sFjubFRhAg+VijpfU0lafOOZo/8/WBQAm+fKzm69054KhOfkmOSLJrX2sKvOkxM1hIPSuPDIqJndvz+JgAjH5Z/3xPrCHXRT8VShT9eiw7oSQ1QCJNQTASOc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f8Umma9M; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6dce7263beaso55630146d6.3;
        Tue, 21 Jan 2025 13:50:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737496251; x=1738101051; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6BdGZUBK50zU3Op0FjauNvbMjwAEUW58/YPkyPzQ+4Y=;
        b=f8Umma9MCsGg9HFKNVs5xxWAMYiPk9nORiKmeEMCBNne/uqr9cM7JyDZgm1BnzVAFj
         Kt0Mjhum4GopdQ5XjzQIHBcLIuVmY5D4Jpyg823fNk/ykNVTJF8RgCc14Gi+WTf9tF46
         BwSOYwvZnkuKTI0bO+O+r/JTUPs070g2IBWGaL/0DXtCBdQrjIKsd+cUkfiiSZ94aLVG
         ka/k20gld72oR/dQA/ITsrR9C1dVf4afTwAOjfShlKBBDU79Fs4t5p0oHM5Y741A3L1j
         sTMBUz4iFU7na7+CXq+DJAcm2jm2avEqePG0Fqy92K0qSKpbxz8LRviPMwKHIEZS1i0r
         F1PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737496251; x=1738101051;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6BdGZUBK50zU3Op0FjauNvbMjwAEUW58/YPkyPzQ+4Y=;
        b=cvqPCguFsCjlugh6eeSUoT+YOx8bbMZVG4pKeY9CQVTPE2525i65gbBqXr75swYajp
         jE6E26r4UELo4ID8rSzNEjoXzFFgxyv7EXqqLIo/tsy4gY4HcBb3aM9EpaQDG8aQ4cWJ
         I0iyTK2wWs2aBb2fZlwVifghnjwNT3hjMmQna9jb/Jd9isoUkI0LVHDsG9iBefAo3p0r
         vliXFQgD62PX+MAHfXeR858tsfjXgZa+dG2LeQsAgepwvge+CJdV3sCmJ3WrBsw4F0SY
         xJp9EwfJdHiyvYmZeeDGr+hNNuO+5ED30TeLwrQasrdJHmq1jLCTom9Zg0JtiGTWyzEt
         2zGQ==
X-Forwarded-Encrypted: i=1; AJvYcCUSpVUKKOG/np+U0tL/7mnMWLKqCi51vwykS+pLQywsX8OToZVmBWxWEefeyKoH1d929Vg2OCOAb8Hb6kJZ@vger.kernel.org
X-Gm-Message-State: AOJu0YwJJSkeWpCUO43D0NaZG0bsVrV+FiTO4PHMAVfKYpT2nkegtVbZ
	V59o/SFW+1/4ei7jI4H/Dazum/NiX5jGZTtdFzReWZxPTz2TqLv+KO6yy5U9l6k1fI/RRIQSwUy
	N4k1z1h9zzWOzUbkX+20q2eUmtgI=
X-Gm-Gg: ASbGncuyIkqCo3WR5i7CrDfKAevGrC+4QFTj0aDj507S/X9fHpUwkbQOuT2Qc25zUOJ
	HQptD9hALVsYvBEmJUHYWeD7kcJ4vUS6Cs8dLWwLfj4NnjYHqvav2
X-Google-Smtp-Source: AGHT+IEqgzwqM1Dm48aZvM/u5rgQ1F70joaYYuEMM6bmvEmrHzltHetOUMndi34lRlvuBHL/QTWKYc4sQu2NUf1C3T4=
X-Received: by 2002:ad4:5fcd:0:b0:6d8:812e:1fd0 with SMTP id
 6a1803df08f44-6e1b217a34dmr298999706d6.15.1737496251373; Tue, 21 Jan 2025
 13:50:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250118004759.2772065-1-joannelkoong@gmail.com>
 <20250118004759.2772065-2-joannelkoong@gmail.com> <20250118201720.GK3557695@frogsfrogsfrogs>
In-Reply-To: <20250118201720.GK3557695@frogsfrogsfrogs>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 21 Jan 2025 13:50:40 -0800
X-Gm-Features: AbW1kvaGrAwVqkHFuueItcxYvMqXJ9_8RI-WugYrnGnFl1CtuGwoJP-PVPDKeI4
Message-ID: <CAJnrk1YfiZkCM9es3SP7G8KKoSzKR7BexW2vbzXxwHStHyXLYw@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] fsx: support reads/writes from buffers backed by hugepages
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: fstests@vger.kernel.org, linux-fsdevel@vger.kernel.org, bfoster@redhat.com, 
	nirjhar@linux.ibm.com, zlang@redhat.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 18, 2025 at 12:17=E2=80=AFPM Darrick J. Wong <djwong@kernel.org=
> wrote:
>
> On Fri, Jan 17, 2025 at 04:47:58PM -0800, Joanne Koong wrote:
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
> >  ltp/fsx.c | 165 +++++++++++++++++++++++++++++++++++++++++++++++++-----
> >  1 file changed, 152 insertions(+), 13 deletions(-)
> >
> > diff --git a/ltp/fsx.c b/ltp/fsx.c
> > index 41933354..1513755f 100644
> > --- a/ltp/fsx.c
> > +++ b/ltp/fsx.c
> > @@ -2833,11 +2846,40 @@ __test_fallocate(int mode, const char *mode_str=
)
> >  #endif
> >  }
> >
> > +/*
> > + * Reclaim may break up hugepages, so do a best-effort collapse every =
once in
> > + * a while.
> > + */
> > +static void
> > +collapse_hugepages(void)
> > +{
> > +#ifdef MADV_COLLAPSE
> > +     int interval =3D 1 << 14; /* 16k */
> > +     int ret;
> > +
> > +     if (numops && (numops & (interval - 1)) =3D=3D 0) {
>
> I wonder if this could be collapsed to:
>
>         /* re-collapse every 16k fsxops after we start */
>         if (!numops || (numops & ((1U << 14) - 1)))
>                 return;
>
>         ret =3D madvise(...);
>
> But my guess is that the compiler is smart enough to realize that
> interval never changes and fold it into the test expression?
>
> <shrug> Not that passionate either way. :)

Sounds good, I will change it to this and fix the indentation below for v5.

Thanks,
Joanne

>
> > +             ret =3D madvise(hugepages_info.orig_good_buf,
> > +                           hugepages_info.good_buf_size, MADV_COLLAPSE=
);
> > +             if (ret)
> > +                     prt("collapsing hugepages for good_buf failed (nu=
mops=3D%llu): %s\n",
> > +                          numops, strerror(errno));
> > +             ret =3D madvise(hugepages_info.orig_temp_buf,
> > +                           hugepages_info.temp_buf_size, MADV_COLLAPSE=
);
> > +             if (ret)
> > +                     prt("collapsing hugepages for temp_buf failed (nu=
mops=3D%llu): %s\n",
> > +                          numops, strerror(errno));
> > +     }
> > +#endif
> > +}
> > +
> >  bool
> >  keep_running(void)
> >  {
> >       int ret;
> >
> > +     if (hugepages)
> > +             collapse_hugepages();
> > +
> >       if (deadline.tv_nsec) {
> >               struct timespec now;
> >
> > @@ -2856,6 +2898,103 @@ keep_running(void)
> >       return numops-- !=3D 0;
> >  }
> >
> > +static long
> > +get_hugepage_size(void)
> > +{
> > +     const char str[] =3D "Hugepagesize:";
> > +     size_t str_len =3D  sizeof(str) - 1;
> > +     unsigned int hugepage_size =3D 0;
> > +     char buffer[64];
> > +     FILE *file;
> > +
> > +     file =3D fopen("/proc/meminfo", "r");
> > +     if (!file) {
> > +             prterr("get_hugepage_size: fopen /proc/meminfo");
> > +             return -1;
> > +     }
> > +     while (fgets(buffer, sizeof(buffer), file)) {
> > +             if (strncmp(buffer, str, str_len) =3D=3D 0) {
> > +                     sscanf(buffer + str_len, "%u", &hugepage_size);
> > +                     break;
> > +             }
> > +     }
> > +     fclose(file);
> > +     if (!hugepage_size) {
> > +             prterr("get_hugepage_size: failed to find "
> > +                     "hugepage size in /proc/meminfo\n");
> > +             return -1;
> > +     }
> > +
> > +     /* convert from KiB to bytes */
> > +     return hugepage_size << 10;
> > +}
> > +
> > +static void *
> > +init_hugepages_buf(unsigned len, int hugepage_size, int alignment, lon=
g *buf_size)
> > +{
> > +     void *buf =3D NULL;
> > +#ifdef MADV_COLLAPSE
> > +     int ret;
> > +     long size =3D roundup(len, hugepage_size) + alignment;
> > +
> > +     ret =3D posix_memalign(&buf, hugepage_size, size);
> > +     if (ret) {
> > +             prterr("posix_memalign for buf");
> > +             return NULL;
> > +     }
> > +     memset(buf, '\0', size);
> > +     ret =3D madvise(buf, size, MADV_COLLAPSE);
> > +     if (ret) {
> > +             prterr("madvise collapse for buf");
> > +             free(buf);
> > +             return NULL;
> > +     }
> > +
> > +     *buf_size =3D size;
> > +#endif
> > +     return buf;
> > +}
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
, writebdy,
> > +                                           &hugepages_info.good_buf_si=
ze);
> > +             if (!good_buf) {
> > +                     prterr("init_hugepages_buf failed for good_buf");
> > +                     exit(103);
> > +             }
> > +             hugepages_info.orig_good_buf =3D good_buf;
> > +
> > +             temp_buf =3D init_hugepages_buf(maxoplen, hugepage_size, =
readbdy,
> > +                                           &hugepages_info.temp_buf_si=
ze);
> > +             if (!temp_buf) {
> > +                     prterr("init_hugepages_buf failed for temp_buf");
> > +                     exit(103);
> > +             }
> > +             hugepages_info.orig_temp_buf =3D temp_buf;
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
> > @@ -2883,7 +3022,7 @@ main(int argc, char **argv)
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
> > @@ -2916,6 +3055,14 @@ main(int argc, char **argv)
> >               case 'g':
> >                       filldata =3D *optarg;
> >                       break;
> > +             case 'h':
> > +#ifndef MADV_COLLAPSE
> > +                             fprintf(stderr, "MADV_COLLAPSE not suppor=
ted. "
> > +                                     "Can't support -h\n");
> > +                             exit(86);
>
> Excessive indenting here.
>
> With those fixed up,
> Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
>
> --D
>
> > +#endif
> > +                     hugepages =3D 1;
> > +                     break;
> >               case 'i':
> >                       integrity =3D 1;
> >                       logdev =3D strdup(optarg);
> > @@ -3229,15 +3376,7 @@ main(int argc, char **argv)
> >                       exit(95);
> >               }
> >       }
> > -     original_buf =3D (char *) malloc(maxfilelen);
> > -     for (i =3D 0; i < maxfilelen; i++)
> > -             original_buf[i] =3D random() % 256;
> > -     good_buf =3D (char *) malloc(maxfilelen + writebdy);
> > -     good_buf =3D round_ptr_up(good_buf, writebdy, 0);
> > -     memset(good_buf, '\0', maxfilelen);
> > -     temp_buf =3D (char *) malloc(maxoplen + readbdy);
> > -     temp_buf =3D round_ptr_up(temp_buf, readbdy, 0);
> > -     memset(temp_buf, '\0', maxoplen);
> > +     init_buffers();
> >       if (lite) {     /* zero entire existing file */
> >               ssize_t written;
> >
> > --
> > 2.47.1
> >
> >

