Return-Path: <linux-fsdevel+bounces-40643-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 562DDA261EC
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2025 19:04:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 041A51883A5B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2025 18:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFD9820AF75;
	Mon,  3 Feb 2025 18:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J6WrwgWv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E231D5176;
	Mon,  3 Feb 2025 18:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738605860; cv=none; b=VloM3r+MvQT6BU74JvpbBdLMWbgENSaeyKzGepiqSrzJl/6VCaInebknX/soN6qITfugMNQIYskkJUSeKS7j82xgqBPQyhsNwzE9Uwz2oyo5HZm9Jcvgy319SoTuioIy/peYFZqTLBsx6yFOqjDzXh4MSymzDK+mBlIrclfDaJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738605860; c=relaxed/simple;
	bh=W6NdVcdLdqDwqWQJ1NJUozjwaXdnG1e9O7OFgGcaKQM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nr+nV7XAbZ0BiL2wFRWxzuJ4wTJFFNDu0LCmfyyh+oL+no2Lq0An3lkQk8f50Hw4d9eemQJmhoBfx8zzHM34Nhlhey92g1iN0cx8fPCGp0jydnlYDccBPUzWRowXIGpHHIF2wbTaIlFBVxR+bLrxTglwmWHU1C178rz86dTd7II=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J6WrwgWv; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-467918c35easo71766821cf.2;
        Mon, 03 Feb 2025 10:04:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738605855; x=1739210655; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2JHnSC75jWq9w6TVZKupow+pmQKlf6+bz1/ibfakmuM=;
        b=J6WrwgWvE2D7O/e7N5esv6ZQ7LhiIMCv6IYvS4MuDom9bBXWjFzDM8Yn+06+8lovI9
         UriSQV39I3t0PlHf3E749ws07UQtWbEMyTYGjgs/bB6rKVk02bq6eqsRzlvP9llk5qNx
         W2K6wkTVMIw+0Y0Jm9afRQ2XzOSon+werZ7sSVdgY5ZGb6389pBtQ4etiH7TsrH7dGE1
         YwqE25Rd498PEPunc5Y7lj+vcG6v1Tvy3CyM7GFkSNeVhgYhlaPJGbrim3Ey5m+R/CLh
         brOei7D5y0EglS+dPKrNLawQSSSGX2xAK7Ks8LqxZORiG6TYox7bYnERgDpCKzMU5qnd
         IcKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738605855; x=1739210655;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2JHnSC75jWq9w6TVZKupow+pmQKlf6+bz1/ibfakmuM=;
        b=VqX2Nx48clScM7WhFBV3Obtu1o+RYOC/8o5kBdXKtinwguk8Cam7izdaxPTFvWoBQ5
         txxrGqARowckE6yVqV5OZ2FBV4taHcQpWQZLzy1aeFoD0p+0NPXFP/VzeFz/b9IesEbz
         DjFI5Lsjmp9ktTalS09Yh2wdgIpgXiRR7w2QaKjcVgv6/abe0dz5N3fSPAlFa/a45BK4
         n9rju0MaGqEjP1EIqgwxk+zbyPbfHlYX2mV6Yz2GAVfNJTsWcm107RwHPBdtzqQKMeWW
         BClhvEbagJUVsxTVC3uD1+sWDpVMnXPngKi7DndwbyX0PI+d/VQcXoRQknOMLsl1uVYf
         qd9Q==
X-Forwarded-Encrypted: i=1; AJvYcCWkclZE95/mby1EhRqSWmkZ6Y8t3Di9YTU6G1yI5MZW2adxVEPNpd48AvpNDMZV6o6fK+k+ombgo7RXGJVI@vger.kernel.org
X-Gm-Message-State: AOJu0Yyh+QDzT2BnepFyDtHR3v3xdunELBJag7N0eLtcMXz+8MXKtnEZ
	aQmsQBmYIhrafcX7zRc5Qv24UQyjW8dWSlPb+zOlDprSI2QhylSTXvDFZVhUfCwAETkUSqj0DT+
	mJKf0m4jywpsOTDrjUzxPK+dUlrg=
X-Gm-Gg: ASbGncsqBPNFm8Br1eZTaJblU0pGb1O7/NYEF7u5XzxmDjmOyzItVV/w+nr4gbZuITf
	WSYvyrYTJ9hEIcxJTRVdQMg+mVb5fTwfOUnFiDiVryKxmojahDGvMiFK7ikKSHG3iGjl69+gz/t
	vp0cavB+2omDzK
X-Google-Smtp-Source: AGHT+IHS/pUm9IyK0C2RuYggM6ccrxfoEXo0nxb3JldG2s+PubzYOguZBo/wFgFirEc9wmlU6Q33IDmdWaD91Sdc9RQ=
X-Received: by 2002:ac8:7fc8:0:b0:46c:7646:4a1e with SMTP id
 d75a77b69052e-46fd0a77c67mr414627191cf.13.1738605854853; Mon, 03 Feb 2025
 10:04:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250121215641.1764359-1-joannelkoong@gmail.com>
 <20250121215641.1764359-2-joannelkoong@gmail.com> <20250202142518.r3xvf7mvfo2nhb7t@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
In-Reply-To: <20250202142518.r3xvf7mvfo2nhb7t@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Mon, 3 Feb 2025 10:04:04 -0800
X-Gm-Features: AWEUYZncDlgRFaUDPt774945w2cYLO2ibPMgkob6RLCfVpX8GWLIZRSYzkbl0BM
Message-ID: <CAJnrk1YwBJQnFwYBcO50Xy2dA6df_SqQsHdpLux4wa-Yw5rXdg@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] fsx: support reads/writes from buffers backed by hugepages
To: Zorro Lang <zlang@redhat.com>
Cc: fstests@vger.kernel.org, linux-fsdevel@vger.kernel.org, bfoster@redhat.com, 
	djwong@kernel.org, nirjhar@linux.ibm.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 2, 2025 at 6:25=E2=80=AFAM Zorro Lang <zlang@redhat.com> wrote:
>
> On Tue, Jan 21, 2025 at 01:56:40PM -0800, Joanne Koong wrote:
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
> > Reviewed-by: Darrick J. Wong <djwong@kernel.org>
> > ---
>
> Those two test cases fail on old system which doesn't support
> MADV_COLLAPSE:
>
>    fsx -N 10000 -l 500000 -h
>   -fsx -N 10000 -o 8192 -l 500000 -h
>   -fsx -N 10000 -o 128000 -l 500000 -h
>   +MADV_COLLAPSE not supported. Can't support -h
>
> and
>
>    fsx -N 10000 -l 500000 -r PSIZE -t BSIZE -w BSIZE -Z -R -W -h
>   -fsx -N 10000 -o 8192 -l 500000 -r PSIZE -t BSIZE -w BSIZE -Z -R -W -h
>   -fsx -N 10000 -o 128000 -l 500000 -r PSIZE -t BSIZE -w BSIZE -Z -R -W -=
h
>   +mapped writes DISABLED
>   +MADV_COLLAPSE not supported. Can't support -h
>
> I'm wondering ...
>
> >  ltp/fsx.c | 166 +++++++++++++++++++++++++++++++++++++++++++++++++-----
> >  1 file changed, 153 insertions(+), 13 deletions(-)
> >
> > diff --git a/ltp/fsx.c b/ltp/fsx.c
> > index 41933354..3be383c6 100644
> > --- a/ltp/fsx.c
> > +++ b/ltp/fsx.c
> > @@ -190,6 +190,16 @@ int      o_direct;                       /* -Z */
> >  int  aio =3D 0;
> >  int  uring =3D 0;
> >  int  mark_nr =3D 0;
> > +int  hugepages =3D 0;                  /* -h flag */
> > +
> > +/* Stores info needed to periodically collapse hugepages */
> > +struct hugepages_collapse_info {
> > +     void *orig_good_buf;
> > +     long good_buf_size;
> > +     void *orig_temp_buf;
> > +     long temp_buf_size;
> > +};
> > +struct hugepages_collapse_info hugepages_info;
> >
> >  int page_size;
> >  int page_mask;
> > @@ -2471,7 +2481,7 @@ void
> >  usage(void)
> >  {
> >       fprintf(stdout, "usage: %s",
> > -             "fsx [-dfknqxyzBEFHIJKLORWXZ0]\n\
> > +             "fsx [-dfhknqxyzBEFHIJKLORWXZ0]\n\
> >          [-b opnum] [-c Prob] [-g filldata] [-i logdev] [-j logid]\n\
> >          [-l flen] [-m start:end] [-o oplen] [-p progressinterval]\n\
> >          [-r readbdy] [-s style] [-t truncbdy] [-w writebdy]\n\
> > @@ -2483,8 +2493,11 @@ usage(void)
> >       -d: debug output for all operations\n\
> >       -e: pollute post-eof on size changes (default 0)\n\
> >       -f: flush and invalidate cache after I/O\n\
> > -     -g X: write character X instead of random generated data\n\
> > -     -i logdev: do integrity testing, logdev is the dm log writes devi=
ce\n\
> > +     -g X: write character X instead of random generated data\n"
> > +#ifdef MADV_COLLAPSE
> > +"    -h hugepages: use buffers backed by hugepages for reads/writes\n"
> > +#endif
> > +"    -i logdev: do integrity testing, logdev is the dm log writes devi=
ce\n\
> >       -j logid: prefix debug log messsages with this id\n\
> >       -k: do not truncate existing file and use its size as upper bound=
 on file size\n\
> >       -l flen: the upper bound on file size (default 262144)\n\
> > @@ -2833,11 +2846,41 @@ __test_fallocate(int mode, const char *mode_str=
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
> > +     int ret;
> > +
> > +     /* re-collapse every 16k fsxops after we start */
> > +     if (!numops || (numops & ((1U << 14) - 1)))
> > +             return;
> > +
> > +     ret =3D madvise(hugepages_info.orig_good_buf,
> > +                   hugepages_info.good_buf_size, MADV_COLLAPSE);
> > +     if (ret)
> > +             prt("collapsing hugepages for good_buf failed (numops=3D%=
llu): %s\n",
> > +                  numops, strerror(errno));
> > +     ret =3D madvise(hugepages_info.orig_temp_buf,
> > +                   hugepages_info.temp_buf_size, MADV_COLLAPSE);
> > +     if (ret)
> > +             prt("collapsing hugepages for temp_buf failed (numops=3D%=
llu): %s\n",
> > +                  numops, strerror(errno));
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
> > @@ -2856,6 +2899,103 @@ keep_running(void)
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
> > @@ -2883,7 +3023,7 @@ main(int argc, char **argv)
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
> > @@ -2916,6 +3056,14 @@ main(int argc, char **argv)
> >               case 'g':
> >                       filldata =3D *optarg;
> >                       break;
> > +             case 'h':
> > +#ifndef MADV_COLLAPSE
> > +                     fprintf(stderr, "MADV_COLLAPSE not supported. "
> > +                             "Can't support -h\n");
> > +                     exit(86);
> > +#endif
> > +                     hugepages =3D 1;
> > +                     break;
>
> ...
> if we could change this part to:
>
> #ifdef MADV_COLLAPSE
>         hugepages =3D 1;
> #endif
>         break;
>
> to avoid the test failures on old systems.
>
> Or any better ideas from you :)

Hi Zorro,

It looks like MADV_COLLAPSE was introduced in kernel version 6.1. What
do you think about skipping generic/758 and generic/759 if the kernel
version is older than 6.1? That to me seems more preferable than the
paste above, as the paste above would execute the test as if it did
test hugepages when in reality it didn't, which would be misleading.


Thanks,
Joanne

>
> Thanks,
> Zorro
>
> >               case 'i':
> >                       integrity =3D 1;
> >                       logdev =3D strdup(optarg);
> > @@ -3229,15 +3377,7 @@ main(int argc, char **argv)
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
>

