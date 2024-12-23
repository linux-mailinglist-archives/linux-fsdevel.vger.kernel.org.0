Return-Path: <linux-fsdevel+bounces-38075-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B9269FB5F8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Dec 2024 22:07:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 037AA188343C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Dec 2024 21:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35DCD1CCEF0;
	Mon, 23 Dec 2024 21:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VQ39urhB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE59BEAC5;
	Mon, 23 Dec 2024 21:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734988043; cv=none; b=IiMu+3sDuwnswcMILnZUpagaHfJa+bSFQaAWEofCevOY1mWrs37J9jZjdMAZJOvvYzy2O2oK07fTgzTUDS9FOGa8gIG0Qb3MDBX0HgTGF60XYc7XUgEadPN8RH9Y7GR/ZfjbQ+Pm1GqGfRh4YmVdw0EarnqdHK1CRV3QSaL/ZLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734988043; c=relaxed/simple;
	bh=iXGK/sZCSjC5YEnRXClmdVleYV5R/IkauPzggppk8OA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aumw3ntDbdeY0YS0H9n9++lxQ91Vvpt1or+/pJhtmiOOx6S7QE2322dfid+3pJWYO6+4ydTuypz4mrwnwlb9IDAoyHoQvJhJc0y8XAy960X7ClZ+yYj/cX6IIlgWe1eFVmS9cp0V0DzWZ7Fl7Ne/zQEVjG8KTGscPECwYjyCPtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VQ39urhB; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-467a6781bc8so33416841cf.2;
        Mon, 23 Dec 2024 13:07:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734988041; x=1735592841; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mbG7EW8RdoDSh5eDEY/pLfIpnTN++jH16mhn0Cp4PUQ=;
        b=VQ39urhBIE6hSeSQxIMT+KvP8tntQU1Yp2nuQ9t9OPa10zi9Jq37kzV4sPLRP7Ix+7
         PgndpfzXT/ds9C2/nnf75/Ph+zMqz51TKUCLvHjsf1zzKZfqIMhiGWhMoWv1oNb3CzF3
         CxhKwnfbEdW+dqH5K/jphqJ4hZB6EnBPaycro0mGXsuDHp4s/RA+615IJmWgO2ywBuJ4
         1xyozhT45QRtETvkVdh+/ZRsz8sRqFxGUcmGRn/jG5PG3Yo+4M8skmS8dYG4qy3xGAAm
         /JJz6GjyAMnicaCQox2Fw1PHnHOLENHa18p28Ad0oFpuQeLkkojpeMQr2kQA5/Qd/PC6
         vcFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734988041; x=1735592841;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mbG7EW8RdoDSh5eDEY/pLfIpnTN++jH16mhn0Cp4PUQ=;
        b=V85B9BEpTFhJ4EMszb8WFkJEYpGqRevwiqe866jPxHxKHD3ML5cw5mS+raPEKYJBMS
         gG6VoVD28wLZqSBtPPLFCz1ZgAYy4msEbhy7yRh1HU25W6g5g8/KIy3rmn/o0RlyFf7H
         W10dzk8IuxtlE9rmmSXbyA3rPwAb5mkG2IkEpwz1+zMQIIQfmr23BqYxzm6euywRbtmE
         rp1EhcUYcm+pe3ZYG2JvizkhPGCivPou/piCwBa0aCRlDjiC6jt5pRr9Orf3J4M4QGKj
         v9JuKx75cG6r0u3Wei+D3vagD6hJU7oh1B2OoiPti8OuJezcfU2fqgO5NOXbsUjdf7R9
         qKnA==
X-Forwarded-Encrypted: i=1; AJvYcCXpmYOFMA3lMOIstA3gNc7Gy/ZIZvfOeRaaSYJRjPDa4UQIsi17ZK0I70izcD4mB12bMPGOXGRqOUY1PCHI@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7cr81kbtq4GR0rWdoyjfLZw+9gQkxI9IblD/HEaVsnD9hCUF+
	Cq5fx6LQ506ULP77ix3KAogJk4pSQkG7eQH0sKxn4IRcj+g7gIKrXRnaF1HbFBZwBLmFfQhmdNK
	3PdxeYgQTtfx3ZhbzMpTjcTz2uJqSSg==
X-Gm-Gg: ASbGncuav9vIZq//0GrF1SoUECBA0gkPDnOi2/OTw17vUnQokLb0yaghqjjrSuMdH4v
	D/6CdJWPjPHBMbtpIFyZIbl4Yb/XElNkUuNWDYfDCRMwK3PvUJkcGmw==
X-Google-Smtp-Source: AGHT+IHbmH24XKi1YXznDzoKfm0Pi/PfR+SsLGk8WH5nPxXosa3RZWOnBmx9xm4buqbIiH3uGfYgrxCL7PyyI5nwIOI=
X-Received: by 2002:a05:622a:1829:b0:466:94d8:926c with SMTP id
 d75a77b69052e-46a4a8cad82mr239799081cf.13.1734988040771; Mon, 23 Dec 2024
 13:07:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241218210122.3809198-1-joannelkoong@gmail.com>
 <20241218210122.3809198-2-joannelkoong@gmail.com> <c74087b50970bf953c78c8756e41d25df28637b1.camel@linux.ibm.com>
In-Reply-To: <c74087b50970bf953c78c8756e41d25df28637b1.camel@linux.ibm.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Mon, 23 Dec 2024 13:07:09 -0800
Message-ID: <CAJnrk1ad0KPYkLmW3sXimrJ52LL_quoxAYX6WUZ9jKnMTUa8-A@mail.gmail.com>
Subject: Re: [PATCH 1/2] fsx: support reads/writes from buffers backed by hugepages
To: Nirjhar Roy <nirjhar@linux.ibm.com>
Cc: fstests@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 19, 2024 at 11:47=E2=80=AFPM Nirjhar Roy <nirjhar@linux.ibm.com=
> wrote:
>
> On Wed, 2024-12-18 at 13:01 -0800, Joanne Koong wrote:
> > Add support for reads/writes from buffers backed by hugepages.
> > This can be enabled through the '-h' flag. This flag should only be
> > used
> > on systems where THP capabilities are enabled.
> >
> > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > ---
> >  ltp/fsx.c | 100 +++++++++++++++++++++++++++++++++++++++++++++++++---
> > --
> >  1 file changed, 92 insertions(+), 8 deletions(-)
> >
> > diff --git a/ltp/fsx.c b/ltp/fsx.c
> > index 41933354..3656fd9f 100644
> > --- a/ltp/fsx.c
> > +++ b/ltp/fsx.c
> > @@ -190,6 +190,7 @@ int       o_direct;                       /* -Z */
> > +static long
> > +get_hugepage_size(void)
> > +{
> > +     const char *str =3D "Hugepagesize:";
> > +     long hugepage_size =3D -1;
> > +     char buffer[64];
> > +     FILE *file;
> > +
> > +     file =3D fopen("/proc/meminfo", "r");
> > +     if (!file) {
> > +             prterr("get_hugepage_size: fopen /proc/meminfo");
> > +             return -1;
> > +     }
> > +     while (fgets(buffer, sizeof(buffer), file)) {
> > +             if (strncmp(buffer, str, strlen(str)) =3D=3D 0) {
> Extremely minor: Since str is a fixed string, why not calculate the
> length outside the loop and not re-use strlen(str) multiple times?

Thinking about this some more, maybe it'd be best to define it as
const char str[] =3D "Hugepagesize:" as an array of chars and use sizeof
which would be at compile-time instead of runtime.
I'll do this for v2.

> > +                     sscanf(buffer + strlen(str), "%ld",
> > &hugepage_size);
> > +                     break;
> > +             }
> > +     }
> > +     fclose(file);
> > +     if (hugepage_size =3D=3D -1) {
> > +             prterr("get_hugepage_size: failed to find "
> > +                     "hugepage size in /proc/meminfo\n");
> > +             return -1;
> > +     }
> > +
> > +     /* convert from KiB to bytes  */
> > +     return hugepage_size * 1024;
> Minor: << 10 might be faster instead of '*' ?

Will do for v2.

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
> > +     if (madvise(buf, buf_size, MADV_COLLAPSE)) {
> > +             prterr("madvise collapse for buf");
> > +             free(buf);
> > +             return NULL;
> > +     }
> > +
> > +     return buf;
> > +}
> > +
> >  static struct option longopts[] =3D {
> >       {"replay-ops", required_argument, 0, 256},
> >       {"record-ops", optional_argument, 0, 255},
> > @@ -2883,7 +2935,7 @@ main(int argc, char **argv)
> >       setvbuf(stdout, (char *)0, _IOLBF, 0); /* line buffered stdout
> > */
> >
> >       while ((ch =3D getopt_long(argc, argv,
> > -                              "0b:c:de:fg:i:j:kl:m:no:p:qr:s:t:uw:xy
> > ABD:EFJKHzCILN:OP:RS:UWXZ",
> > +                              "0b:c:de:fg:hi:j:kl:m:no:p:qr:s:t:uw:x
> > yABD:EFJKHzCILN:OP:RS:UWXZ",
> >                                longopts, NULL)) !=3D EOF)
> >               switch (ch) {
> >               case 'b':
> > @@ -2916,6 +2968,9 @@ main(int argc, char **argv)
> >               case 'g':
> >                       filldata =3D *optarg;
> >                       break;
> > +             case 'h':
> > +                     hugepages =3D 1;
> > +                     break;
> >               case 'i':
> >                       integrity =3D 1;
> >                       logdev =3D strdup(optarg);
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
> > +                     prt("ignoring write alignment (since -h is
> > enabled)");
> > +
> > +             if (readbdy !=3D 1 && readbdy !=3D hugepage_size)
> > +                     prt("ignoring read alignment (since -h is
> > enabled)");
> > +
> > +             good_buf =3D init_hugepages_buf(maxfilelen,
> > hugepage_size);
> > +             if (!good_buf) {
> > +                     prterr("init_hugepages_buf failed for
> > good_buf");
> > +                     exit(100);
> > +             }
> > +
> > +             temp_buf =3D init_hugepages_buf(maxoplen, hugepage_size);
> > +             if (!temp_buf) {
> > +                     prterr("init_hugepages_buf failed for
> > temp_buf");
> > +                     exit(101);
> > +             }
> > +     } else {
> > +             good_buf =3D (char *) malloc(maxfilelen + writebdy);
> > +             good_buf =3D round_ptr_up(good_buf, writebdy, 0);
> Not sure if it would matter but aren't we seeing a small memory leak
> here since good_buf's original will be lost after rounding up?

This is inherited from the original code but AFAICT, it relies on the
memory being cleaned up at exit time (eg free() is never called on
good_buf and temp_buf either).


Thanks,
Joanne

> > +             memset(good_buf, '\0', maxfilelen);
> > +
> > +             temp_buf =3D (char *) malloc(maxoplen + readbdy);
> > +             temp_buf =3D round_ptr_up(temp_buf, readbdy, 0);
> > +             memset(temp_buf, '\0', maxoplen);
> > +     }
> >       if (lite) {     /* zero entire existing file */
> >               ssize_t written;
> >
>

