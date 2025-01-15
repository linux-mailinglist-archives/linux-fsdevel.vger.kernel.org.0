Return-Path: <linux-fsdevel+bounces-39316-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C884A12A40
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 18:54:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C9B07A3AFD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 17:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44CDD1CFEB2;
	Wed, 15 Jan 2025 17:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k3CIxzaM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAEB9155C96;
	Wed, 15 Jan 2025 17:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736963601; cv=none; b=O4qQT85lXcQIw/yX4lh4YNMVNHtbDzMPCqExtUpYc9mgJnCXMVfPIdeiHNWtE8IGgtPWCswq9G3xNcp0GK+z6QC5yAf5J5Md7Ld5lojRfv79nYt07iLSty8KtC4LZ79vcDdUJPPiOkGusvlL1zxAqLrB0E4lNybiTOWGRn654+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736963601; c=relaxed/simple;
	bh=rsWMNhPDIpEE2bEC3a3KZ3VHisVYyvYotvkljz+C0/A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sQKhCucG58rSbrlYHEdX5eug+NDhAeGItYMsuNfUjrwWYMOw5ckEXavnnRtnnS13U36hVy2Zj5jrSdodKPs68X3BYn/CJordg2NRpfTveGdKwBqzST9vv49E0kCtf0LGHWrSuLAqwUUoDXPvo0v9hWWE1I3AJwQSgHBaqmmJMoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k3CIxzaM; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-467a6ecaa54so693731cf.0;
        Wed, 15 Jan 2025 09:53:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736963598; x=1737568398; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QxBhmlbb3NqmfO5hIp21TMTAyT6RZ8qBzW1rgk3/8d0=;
        b=k3CIxzaMaDJXye2YQjCKvrLK463okYab/p7/4NP2oiCk8zhfYgwrl9E6dU6xdJHJjS
         0GHEUuWNCloosbpghc2d3QaMqwdLC08jErx6+t3ba4G505XHjx9x3iR52GVy/cguMgrd
         iypRlw3+DdDvKoQEca7WsktJLeD7wfVrZl5GZPGsEFOduZbopJZIMsekhMUl6vRH1eua
         6UeoQ6dLChKRWVomtzJNIYgnaSwbAtiTT06foOstbSajxW3q9w72u0ckm9KKya4AyB7w
         PtdCvvW2FcjEId7fbKgcsAWRiSw0giiErTvB0LNJmGbKayslfsS8oj5JYnivRQt6h2wC
         eD9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736963598; x=1737568398;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QxBhmlbb3NqmfO5hIp21TMTAyT6RZ8qBzW1rgk3/8d0=;
        b=KeWXc2Osna7/MOeJlki3ZlTAD+EGdH0zvi2fbzJ2zLe6ziMu6maPw+oO3C5vkOMfup
         xSUjsjNEF3NHRe1PVyjx2am/Hiewk2k2uQT9VG2OimNRgtp/TUZPvrYpJD7cf4PR5v6M
         sJLWK9L2WKEa3h0Metxw3USLNsPjfgcY2nV8CLmhcDugLpRXCfTsVakTuPtnkJuEJ6jr
         wk8dNAnaUWWGGO0eKFbr4yBbFOe8nX1/+H8n+whtjVzCdqtr8yhXeP1SLUKFlwRCe7AJ
         eLVB3eCMYSTP+ajD5xyZj+658miBoxPP7DtaEzvJcJXgfE7Nxh+0zLWNOTY7XvEj0wGy
         +Ayg==
X-Forwarded-Encrypted: i=1; AJvYcCUGmuzzIeIxVdgohbdeUzAaBDqOuXscjDLbcTD2FOfwAVD8l/Tc+rNFyf7GkS05jfSLTd9ghOYKzJBMrHw7@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/zAR8AswSdupaYwi1XZygg554Djk+mOMWYidC9uaAuMaC55I7
	5YmRbw69q9G6ogUkvbDV5djGZZEUE212hJHhjL46vSO8AO3BVNB6/AG9tYRo8ZPSduNPRuL7NwK
	DRTTcKjDygcsFFukYA2br2nGm1Y4=
X-Gm-Gg: ASbGncvfX8r7+AmPNe0i4dyWamyd/kasFBnxrcqw+wZCN3/s7uqPMJZQF7CLvC4fzlz
	xjhx/KX0RKnhsk6uK7wlBSk62t21SSx2gAfiWpCnKOE6Nch6TPfrw5A==
X-Google-Smtp-Source: AGHT+IGmoOgg1Rtx5ws4QiZadgUm6YuT50WGAezRWLf8zAKVGuogy4bSm29FNdjzxCaiLnXyXWofNNTYJfSomSZ/zuU=
X-Received: by 2002:ac8:7fd6:0:b0:466:9ab3:c2d0 with SMTP id
 d75a77b69052e-46c7108c35amr423317891cf.44.1736963597617; Wed, 15 Jan 2025
 09:53:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241227193311.1799626-1-joannelkoong@gmail.com>
 <20241227193311.1799626-2-joannelkoong@gmail.com> <20250112041624.xzenih232klygwvw@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
In-Reply-To: <20250112041624.xzenih232klygwvw@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 15 Jan 2025 09:53:06 -0800
X-Gm-Features: AbW1kvbLSf0VzrmecAd8o8rfZyvxZUoKFQSwjrv--pKNhrTop2ksjwHrTOvImuI
Message-ID: <CAJnrk1YABnxcHqcZ8G9S834N1VJJcxfgQim7SGhH=ajpXBeUug@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] fsx: support reads/writes from buffers backed by hugepages
To: Zorro Lang <zlang@redhat.com>
Cc: fstests@vger.kernel.org, linux-fsdevel@vger.kernel.org, bfoster@redhat.com, 
	djwong@kernel.org, nirjhar@linux.ibm.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 11, 2025 at 8:16=E2=80=AFPM Zorro Lang <zlang@redhat.com> wrote=
:
>
> On Fri, Dec 27, 2024 at 11:33:10AM -0800, Joanne Koong wrote:
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
> > ---
> >  ltp/fsx.c | 108 ++++++++++++++++++++++++++++++++++++++++++++++++------
> >  1 file changed, 97 insertions(+), 11 deletions(-)
> >
>
> [snip]
>
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
> Hi Joanne,
>
> Sorry I have to drop this patchset from the "upcoming" release v2025.01.1=
2. Due to
> it cause a regression build error on older system, e.g. RHEL-9:
>
>     [CC]    fsx
>  fsx.c: In function 'init_hugepages_buf':
>  fsx.c:2935:36: error: 'MADV_COLLAPSE' undeclared (first use in this func=
tion); did you mean 'MADV_COLD'?
>   2935 |         if (madvise(buf, buf_size, MADV_COLLAPSE)) {
>        |                                    ^~~~~~~~~~~~~
>        |                                    MADV_COLD
>  fsx.c:2935:36: note: each undeclared identifier is reported only once fo=
r each function it appears in
>  gmake[4]: *** [Makefile:51: fsx] Error 1
>  gmake[4]: *** Waiting for unfinished jobs....
>  gmake[3]: *** [include/buildrules:30: ltp] Error 2
>
> It might cause xfstests totally can't be used on downstream systems, so i=
t can't
> catch up the release of this weekend. Sorry about that, let's try to have=
 it
> in next release :)

Hi Zorro,

Thanks for the update. I'll submit a v3 of this patch that gates this
function behind #ifdef MADV_COLLAPSE, and hopefully that should fix
this issue.


Thanks,
Joanne

>
> Thanks,
> Zorro
>
>
> > +             prterr("madvise collapse for buf");
> > +             free(buf);
> > +             return NULL;
> > +     }
> > +
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
> > +                     exit(100);
> > +             }
> > +             good_buf =3D init_hugepages_buf(maxfilelen, hugepage_size=
, writebdy);
> > +             if (!good_buf) {
> > +                     prterr("init_hugepages_buf failed for good_buf");
> > +                     exit(101);
> > +             }
> > +
> > +             temp_buf =3D init_hugepages_buf(maxoplen, hugepage_size, =
readbdy);
> > +             if (!temp_buf) {
> > +                     prterr("init_hugepages_buf failed for temp_buf");
> > +                     exit(101);
> > +             }
> > +     } else {
> > +             unsigned long good_buf_len =3D maxfilelen + writebdy;
> > +             unsigned long temp_buf_len =3D maxoplen + readbdy;
> > +
> > +             good_buf =3D (char *) malloc(good_buf_len);
> > +             memset(good_buf, '\0', good_buf_len);
> > +             temp_buf =3D (char *) malloc(temp_buf_len);
> > +             memset(temp_buf, '\0', temp_buf_len);
> > +     }
> > +     good_buf =3D round_ptr_up(good_buf, writebdy, 0);
> > +     temp_buf =3D round_ptr_up(temp_buf, readbdy, 0);
> > +}
> > +
> >  static struct option longopts[] =3D {
> >       {"replay-ops", required_argument, 0, 256},
> >       {"record-ops", optional_argument, 0, 255},
> > @@ -2883,7 +2974,7 @@ main(int argc, char **argv)
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
> > @@ -2916,6 +3007,9 @@ main(int argc, char **argv)
> >               case 'g':
> >                       filldata =3D *optarg;
> >                       break;
> > +             case 'h':
> > +                     hugepages =3D 1;
> > +                     break;
> >               case 'i':
> >                       integrity =3D 1;
> >                       logdev =3D strdup(optarg);
> > @@ -3229,15 +3323,7 @@ main(int argc, char **argv)
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
>

