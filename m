Return-Path: <linux-fsdevel+bounces-39559-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BAEAFA15931
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jan 2025 22:49:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AE361889587
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jan 2025 21:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD2131AB525;
	Fri, 17 Jan 2025 21:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W8rH3WsQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69952198851;
	Fri, 17 Jan 2025 21:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737150543; cv=none; b=Ktv9F8iiaQSssw28cmKgoe4y0VSYyZSdFXGOe5oHU5XrDyuhkvxc0orWzL5DfV0fwOi1gNff3W2hvE7hmgH3rSbnjeItallFa0UMWdtBygdYLNoQtpnMlK5CwirZji8cf0zHoB3T05ynmbQWfLzWYfPxK4g2a8PYcGVhL5l3FHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737150543; c=relaxed/simple;
	bh=4jigLSEJFVbD/a2hmMrUeiv4rXTXbwNmjKc1DlE6G6g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m0fNyk9ofao7+IH9G10WLEO8w4T4nBDzwYf+S5qcy3PAc+yZ5FtQLMuLlXjikAyWio6RRo4KBiBc5qaUug5vvwHWujecEh/57X/fJft/S9upC26HJQjr+kDiK28g2+eAjVtTh6ymzeGOb8MIzqFrfRQ7MJ+9xk1va8k0px9AVUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W8rH3WsQ; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7b6ea711805so339948785a.1;
        Fri, 17 Jan 2025 13:49:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737150540; x=1737755340; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1cSY+xHpYD0e3UHKbkzRCl3028L18KOMw8aTJSfyAPc=;
        b=W8rH3WsQhZqJuDiLt6/b7CsI+gFIdDyql26GZf18AGptYjRgtuXrmC4j93hhcWJ3MN
         lgyGscK8edruDhmUvhFOSsffsRxFApy1BvDV1epIzHDff3jL+VWOZkQOcgRSOrMuwpPH
         2UOkxyCQRFhAycFm8b+fR33cGJInnZijpcVV6tI3e+yGgt5WfWWlccaFFIN7QqrhT0B5
         IJRLmBwvW5qToapL8TiuwIXwX5zNO+T+iKh9K+Zb8mpjwZm81oDs2Ry9YM4OtMhh3eLH
         0IkavuLeZTSmXh2jUnbm7QEnedy/E5bKD2Vu59wmo5gFodwJI3fFPoROcqgvT5sYjuoE
         jQ3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737150540; x=1737755340;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1cSY+xHpYD0e3UHKbkzRCl3028L18KOMw8aTJSfyAPc=;
        b=mN03Pipc8z51S82IuHlRyn4V2cRGAcxEtDc6UjQ36gN+pUbVz0mg1aqLyWKEPug1Dj
         ZZUsPYi2nkwk98I+/TUU58EB3/oxM4Z2lTqRLxaNndmPk9vYx70wFqoUljEd5lGdSYQQ
         pSBb+aM5QiIP5NZZ74sEaa4cdsL7e/TbLx5z3ijkgZ6JGG6LF0VoBnVcAS7uGGwc8fup
         nehgGavVYTvouY7us4nQDg/s2giza4F0/FrTOArc0a5PGPkh5wyb2qI8LROx5jU7GHAx
         qBDdVHotHdw43qCtGNVSz5oT50fr79sVHjTBfzJtC5nyPA7RYccxM5OI9secgt6V9sR8
         ZuqA==
X-Forwarded-Encrypted: i=1; AJvYcCXLPv2ZcNOZMiW+2c4CC01WKRyFVksmhmUMcCCv2slyKNE41cJCrYOUMZ1D/AL73V/AN7r5n2/CT1oIDPTj@vger.kernel.org
X-Gm-Message-State: AOJu0Yztv05BTdpyvi99nT/o66Sj1GpD15yYIVVg8NG9JkWCUtHagV6E
	2qMV72N7sG7Sh2GHIRgF4kC8lS94jva3ApgOnFmoYwejlkP463hA93UdoNUMyys3hZPmt9wttQk
	49w+k4WZ5qa9o2xgnmBWzuuL3U00=
X-Gm-Gg: ASbGnctsOg6AkdhTxVxa+NDpw5wy1FhjNhf8WKtZk6/4O0jjPaMeszpHj3rCaFlfqBi
	EDP/sgtNZrbCEfzf3EixOb5zEpH8MKT+k/h1cAIh4e48Td0NZ652Zj/3vbpjZZqAtew==
X-Google-Smtp-Source: AGHT+IEnkAwLMhE46nI6LTNP/yl2KMV9RDkVAr999qZK2UysD6UabgUUKoOJclk30OP4S0FuturT/hpEchrITEO/04A=
X-Received: by 2002:a05:620a:2627:b0:7b6:d4a2:f11f with SMTP id
 af79cd13be357-7be63157d1fmr699256685a.0.1737150540088; Fri, 17 Jan 2025
 13:49:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250115183107.3124743-1-joannelkoong@gmail.com>
 <20250115183107.3124743-2-joannelkoong@gmail.com> <20250115213713.GE3557695@frogsfrogsfrogs>
 <CAJnrk1YXa++SrifrCfXf7WPQF34V20cet3+x+7wVuDf9CPoR7w@mail.gmail.com>
 <20250116005919.GK3557553@frogsfrogsfrogs> <CAJnrk1ZpjnAL26x7KdX_33bgX7YdJN1hnPmn6zAgM38p4uBopw@mail.gmail.com>
 <20250117015724.GL3557553@frogsfrogsfrogs>
In-Reply-To: <20250117015724.GL3557553@frogsfrogsfrogs>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Fri, 17 Jan 2025 13:48:49 -0800
X-Gm-Features: AbW1kvaaPRnHN8Kv54Yiyl29WSjQchMpl9NSwfZKMLCxmMR0HE8BHUZEQVDkEgI
Message-ID: <CAJnrk1ZuTKCvVUTWs2rQgg2OXtbJp+Ggcsg_A0Q093R8U=1=8Q@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] fsx: support reads/writes from buffers backed by hugepages
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: fstests@vger.kernel.org, linux-fsdevel@vger.kernel.org, bfoster@redhat.com, 
	nirjhar@linux.ibm.com, zlang@redhat.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 16, 2025 at 5:57=E2=80=AFPM Darrick J. Wong <djwong@kernel.org>=
 wrote:
>
> On Thu, Jan 16, 2025 at 05:03:41PM -0800, Joanne Koong wrote:
> > On Wed, Jan 15, 2025 at 4:59=E2=80=AFPM Darrick J. Wong <djwong@kernel.=
org> wrote:
> > >
> > > On Wed, Jan 15, 2025 at 04:47:30PM -0800, Joanne Koong wrote:
> > > > On Wed, Jan 15, 2025 at 1:37=E2=80=AFPM Darrick J. Wong <djwong@ker=
nel.org> wrote:
> > > > >
> > > > > On Wed, Jan 15, 2025 at 10:31:06AM -0800, Joanne Koong wrote:
> > > > > > Add support for reads/writes from buffers backed by hugepages.
> > > > > > This can be enabled through the '-h' flag. This flag should onl=
y be used
> > > > > > on systems where THP capabilities are enabled.
> > > > > >
> > > > > > This is motivated by a recent bug that was due to faulty handli=
ng of
> > > > > > userspace buffers backed by hugepages. This patch is a mitigati=
on
> > > > > > against problems like this in the future.
> > > > > >
> > > > > > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > > > > > Reviewed-by: Brian Foster <bfoster@redhat.com>
> > > > > > ---
> > > > > >  ltp/fsx.c | 119 ++++++++++++++++++++++++++++++++++++++++++++++=
+++-----
> > > > > >  1 file changed, 108 insertions(+), 11 deletions(-)
> > > > > >
> > > > > > diff --git a/ltp/fsx.c b/ltp/fsx.c
> > > > > > index 41933354..8d3a2e2c 100644
> > > > > > --- a/ltp/fsx.c
> > > > > > +++ b/ltp/fsx.c
> > > > > > @@ -190,6 +190,7 @@ int       o_direct;                       /=
* -Z */
> > > > > >  int  aio =3D 0;
> > > > > >  int  uring =3D 0;
> > > > > >  int  mark_nr =3D 0;
> > > > > > +int  hugepages =3D 0;                  /* -h flag */
> > > > > >
> > > > > >  int page_size;
> > > > > >  int page_mask;
> > > > > > @@ -2471,7 +2472,7 @@ void
> > > > > >  usage(void)
> > > > > >  {
> > > > > >       fprintf(stdout, "usage: %s",
> > > > > > -             "fsx [-dfknqxyzBEFHIJKLORWXZ0]\n\
> > > > > > +             "fsx [-dfhknqxyzBEFHIJKLORWXZ0]\n\
> > > > > >          [-b opnum] [-c Prob] [-g filldata] [-i logdev] [-j log=
id]\n\
> > > > > >          [-l flen] [-m start:end] [-o oplen] [-p progressinterv=
al]\n\
> > > > > >          [-r readbdy] [-s style] [-t truncbdy] [-w writebdy]\n\
> > > > > > @@ -2484,6 +2485,7 @@ usage(void)
> > > > > >       -e: pollute post-eof on size changes (default 0)\n\
> > > > > >       -f: flush and invalidate cache after I/O\n\
> > > > > >       -g X: write character X instead of random generated data\=
n\
> > > > > > +     -h hugepages: use buffers backed by hugepages for reads/w=
rites\n\
> > > > >
> > > > > If this requires MADV_COLLAPSE, then perhaps the help text should=
n't
> > > > > describe the switch if the support wasn't compiled in?
> > > > >
> > > > > e.g.
> > > > >
> > > > >         -g X: write character X instead of random generated data\=
n"
> > > > > #ifdef MADV_COLLAPSE
> > > > > "       -h hugepages: use buffers backed by hugepages for reads/w=
rites\n"
> > > > > #endif
> > > > > "       -i logdev: do integrity testing, logdev is the dm log wri=
tes device\n\
> > > > >
> > > > > (assuming I got the preprocessor and string construction goo righ=
t; I
> > > > > might be a few cards short of a deck due to zombie attack earlier=
)
> > > >
> > > > Sounds great, I'll #ifdef out the help text -h line. Hope you feel =
better.
> > > > >
> > > > > >       -i logdev: do integrity testing, logdev is the dm log wri=
tes device\n\
> > > > > >       -j logid: prefix debug log messsages with this id\n\
> > > > > >       -k: do not truncate existing file and use its size as upp=
er bound on file size\n\
> > > > [...]
> > > > > > +}
> > > > > > +
> > > > > > +#ifdef MADV_COLLAPSE
> > > > > > +static void *
> > > > > > +init_hugepages_buf(unsigned len, int hugepage_size, int alignm=
ent)
> > > > > > +{
> > > > > > +     void *buf;
> > > > > > +     long buf_size =3D roundup(len, hugepage_size) + alignment=
;
> > > > > > +
> > > > > > +     if (posix_memalign(&buf, hugepage_size, buf_size)) {
> > > > > > +             prterr("posix_memalign for buf");
> > > > > > +             return NULL;
> > > > > > +     }
> > > > > > +     memset(buf, '\0', buf_size);
> > > > > > +     if (madvise(buf, buf_size, MADV_COLLAPSE)) {
> > > > >
> > > > > If the fsx runs for a long period of time, will it be necessary t=
o call
> > > > > MADV_COLLAPSE periodically to ensure that reclaim doesn't break u=
p the
> > > > > hugepage?
> > > > >
> > > >
> > > > imo, I don't think so. My understanding is that this would be a rar=
e
> > > > edge case that happens when the system is constrained on memory, in
> > > > which case subsequent calls to MADV_COLLAPSE would most likely fail
> > > > anyways.
> > >
> > > Hrmmm... well I /do/ like to run memory constrained VMs to prod recla=
im
> > > into stressing the filesystem more.  But I guess there's no good way =
for
> > > fsx to know that something happened to it.  Unless there's some even
> > > goofier way to force a hugepage, like shmem/hugetlbfs (ugh!) :)
> >
> > I can't think of a better way to force a hugepage either. I believe
> > shmem and hugetlbfs would both require root privileges to do so, and
> > if i'm not mistaken, shmem hugepages are still subject to being broken
> > up by reclaim.
> >
> > >
> > > Will have to ponder hugepage renewasl -- maybe we should madvise ever=
y
> > > few thousand fsxops just to be careful?
> >
> > I can add this in, but on memory constrained VMs, would this be
> > effective? To me, it seems like in the majority of cases, subsequent
>
> They're not /so/ memory constrained that the initial collapsed page is
> likely to get split/reclaimed before your regression test finishes...
>
> > attempts at collapsing the broken pages back into a hugepage would
> > fail due to memory still being constrained. In which case, I guess
> > we'd exit the test altogether?
>
> ...but I was starting to wonder if this is something we'd actually want
> in a long soak test, just in case there are weird effects on the system
> after fsx has been running for a few days?
>
> >                                It kind of seems to me like if the user
> > wants to test out hugepages functionality of their filesystem, then
> > the onus is on them to run the test in an environment that can
> > adequately and consistently support hugepages.
>
> I guess the hard part about analyzing that is is that long soak tests
> aren't usually supposed to die on account of memory fragmentation.
> Hence me wondering if there's an "easy" way to get one huge page and not
> let it go.

For a long soak situation, I think the periodic collapses every few
thousands ops makes sense. Where the "-h" flag is interpreted as
best-effort (eg the test still continues on even if the subsequent
collapses fail instead of exiting the test altogether, we just make a
best effort at collapsing). I'll add this change to v4.


Thanks,
Joanne

>
> Anyway don't let my blathering hold this up; I think once you fix the
> help text and the #ifdef indenting around exit(86) this patch is good to
> go.
>
> --D
>
> >
> > Thanks,
> > Joanne
> >
> > >
> > > --D
> > >
> > > >
> > > > Thanks,
> > > > Joanne
> > > >
> > > > > > +             prterr("madvise collapse for buf");
> > > > > > +             free(buf);
> > > > > > +             return NULL;
> > > > > > +     }
> > > > > > +
> > > > > > +     return buf;
> > > > > > +}
> > > > > > +#else
> > > > > > +static void *
> > > > > > +init_hugepages_buf(unsigned len, int hugepage_size, int alignm=
ent)
> > > > > > +{
> > > > > > +     return NULL;
> > > > > > +}
> > > > > > +#endif
> > > > > > +
> > > > > > +static void
> > > > > > +init_buffers(void)
> > > > > > +{
> > > > > > +     int i;
> > > > > > +
> > > > > > +     original_buf =3D (char *) malloc(maxfilelen);
> > > > > > +     for (i =3D 0; i < maxfilelen; i++)
> > > > > > +             original_buf[i] =3D random() % 256;
> > > > > > +     if (hugepages) {
> > > > > > +             long hugepage_size =3D get_hugepage_size();
> > > > > > +             if (hugepage_size =3D=3D -1) {
> > > > > > +                     prterr("get_hugepage_size()");
> > > > > > +                     exit(102);
> > > > > > +             }
> > > > > > +             good_buf =3D init_hugepages_buf(maxfilelen, hugep=
age_size, writebdy);
> > > > > > +             if (!good_buf) {
> > > > > > +                     prterr("init_hugepages_buf failed for goo=
d_buf");
> > > > > > +                     exit(103);
> > > > > > +             }
> > > > > > +
> > > > > > +             temp_buf =3D init_hugepages_buf(maxoplen, hugepag=
e_size, readbdy);
> > > > > > +             if (!temp_buf) {
> > > > > > +                     prterr("init_hugepages_buf failed for tem=
p_buf");
> > > > > > +                     exit(103);
> > > > > > +             }
> > > > > > +     } else {
> > > > > > +             unsigned long good_buf_len =3D maxfilelen + write=
bdy;
> > > > > > +             unsigned long temp_buf_len =3D maxoplen + readbdy=
;
> > > > > > +
> > > > > > +             good_buf =3D calloc(1, good_buf_len);
> > > > > > +             temp_buf =3D calloc(1, temp_buf_len);
> > > > > > +     }
> > > > > > +     good_buf =3D round_ptr_up(good_buf, writebdy, 0);
> > > > > > +     temp_buf =3D round_ptr_up(temp_buf, readbdy, 0);
> > > > > > +}
> > > > > > +
> > > > > >  static struct option longopts[] =3D {
> > > > > >       {"replay-ops", required_argument, 0, 256},
> > > > > >       {"record-ops", optional_argument, 0, 255},
> > > > > > @@ -2883,7 +2980,7 @@ main(int argc, char **argv)
> > > > > >       setvbuf(stdout, (char *)0, _IOLBF, 0); /* line buffered s=
tdout */
> > > > > >
> > > > > >       while ((ch =3D getopt_long(argc, argv,
> > > > > > -                              "0b:c:de:fg:i:j:kl:m:no:p:qr:s:t=
:uw:xyABD:EFJKHzCILN:OP:RS:UWXZ",
> > > > > > +                              "0b:c:de:fg:hi:j:kl:m:no:p:qr:s:=
t:uw:xyABD:EFJKHzCILN:OP:RS:UWXZ",
> > > > > >                                longopts, NULL)) !=3D EOF)
> > > > > >               switch (ch) {
> > > > > >               case 'b':
> > > > > > @@ -2916,6 +3013,14 @@ main(int argc, char **argv)
> > > > > >               case 'g':
> > > > > >                       filldata =3D *optarg;
> > > > > >                       break;
> > > > > > +             case 'h':
> > > > > > +                     #ifndef MADV_COLLAPSE
> > > > >
> > > > > Preprocessor directives should start at column 0, like most of th=
e rest
> > > > > of fstests.
> > > > >
> > > > > --D
> > > > >

