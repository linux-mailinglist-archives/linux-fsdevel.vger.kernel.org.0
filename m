Return-Path: <linux-fsdevel+bounces-39456-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D374FA14789
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jan 2025 02:26:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 494DB3A908C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jan 2025 01:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFC422EAF7;
	Fri, 17 Jan 2025 01:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z4/2Hv6L"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9580D17555;
	Fri, 17 Jan 2025 01:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737077205; cv=none; b=FGrOtc/l9gcER/cC5dnhT8Zqc1lEDH3JV0ioYBXgF6ug4QfzIi+4qq9wIRwAl6j6esU8600UDH/8sHWVZ6iInhMFutXvWrfL+feJV3KtD0gDJPw/jMBGoHiTy+IxOZg7A0/b1AKkS9tTzZSAHMyUtIB+//jiEwHGC8VJzKfCPr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737077205; c=relaxed/simple;
	bh=9NThEYNxhiYcLIVy5qODMRoB8m67/QbJP8vHo0eTnY4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SpLr+moZ2K367RvqgQaUtzKGHMCN/x9JZOw4Hi8kJSdMeIGpXbbTZO9eBrxQ3/bGdJvnqtA5VWZ8nScgYQu6ZIctKfwOgEUJ+9tMTIKEJ4uIPbtokeo5sMYTnrKXqHzpxQJn9IXJ4K8lyptw1RVzV2i6W1yU+un78bQUDVi+wHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z4/2Hv6L; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4679ea3b13bso14437331cf.1;
        Thu, 16 Jan 2025 17:26:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737077202; x=1737682002; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gALz7mXxoKdIZFOV6NyeMTR3SzGIb8L+pdqiIHFBMno=;
        b=Z4/2Hv6LSzy1ZaR20MVz+qG0kGH0wCUCkaaSFmTYQ+62KyNu0udRQqi1qL2I85F/Qn
         4s+irpu6MPi0WDOGHejCyKlNeVFaTAmR9wImpOJQ+tfe2jD1aD+OoI/CtPBgiyrD93UV
         BBhYFMozip+cchHycAlVYcpV7gPWBAiJ2DtyNQgIVpaGUsdARUCpm9ZK5XAcOnEnKrHN
         SS3rvLU1GcLdh8bZVlTOIhBNSPb0Lu+xPkzgIBC/uQctxAQvMixisg32b2mhNfQMJVEt
         UvG0ZHAQYAGfurofuFCCI8kLKXuMA/goIUETPMjbFmrQIP43G512TfTAQw5s33bE5A0W
         iDWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737077202; x=1737682002;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gALz7mXxoKdIZFOV6NyeMTR3SzGIb8L+pdqiIHFBMno=;
        b=aYUynucM6IXCnOQU7tDYCqqL7CB2CFmUXcMI5xqQ+L5JCtC0omJZOdrqmo+7yNT2Vy
         DGowB4xxiK7SXk5MhGTt7nfLp5XLFuiXUKpCD8F1VryVAkNU74t7AWexQIBKpOam6tq7
         C+8Pu5An3h/c8NhPIccTAfsrCvSgR0XHgi7ymPwZrzRad+do2JT6x25MkFmaWmF0WRsk
         qUC7+d5sSL6kAElswcxq/dWbGgzGbbOtR++tyGedvOe9kfzfd8jrvH2lUbs9fzYoK1u0
         N74StB6TexbScQbd81EL4Et9Gi+vNDX+SMtKAQQNm+H8UQossfen+q6BVedUARZMK/u+
         4liQ==
X-Forwarded-Encrypted: i=1; AJvYcCUSVsBWWLGVrznBXTb0P7E63GlIkWN7HHWz8cRfd284uE5nMB3BG0x4cNj8NBDh4OW6GeSvgrfU@vger.kernel.org, AJvYcCUWQAGHhpbZx9vSnrpCEpLUwPxjaNptNcgJNUgJ7adNKa+Tz2AwHR/qGYV+gADuKPrh3RMiB39AIm6Kv4PEeg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxaq5GDoUx+zNeky4yn6DlILFrLLoyGedZW0/xECWI9bFwWRUtX
	nxWz8vG7kcJTYWqlE66mvxoeIUyS0ARqgZnVwgNpIOY5ITgJQG5loNpeKcRMoe4j3OYgcAJJcji
	KNuNO11mL/E/tMlaiUkFwPGR0o9g=
X-Gm-Gg: ASbGncsYu3eA2FsXeveV2xwroxCpoCormt16kvRkcjrBkd/KceBXeosEBLUKOukmxdw
	wXwrRKVRPVzpFTobteA6vzJz75UhewYJO4kjfjMY=
X-Google-Smtp-Source: AGHT+IGxeKaWIXloOiUCq7i4mHEOLSlurk6/uNQQaDGDE+e+eEm4T4s+yQC91DD0WMvUdPtWgyy4bqnTCUVba2h8q1s=
X-Received: by 2002:a05:622a:94:b0:466:a3bf:41a7 with SMTP id
 d75a77b69052e-46e12bbeea2mr13251171cf.51.1737077202350; Thu, 16 Jan 2025
 17:26:42 -0800 (PST)
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
In-Reply-To: <Z4kBYq0K919C9k4M@bfoster>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Thu, 16 Jan 2025 17:26:31 -0800
X-Gm-Features: AbW1kvZzQp9avCnkZmmUT82Ib2zlqMPN5r2HvLdY1s-6sqoIP5vjHb7rsjTN-ws
Message-ID: <CAJnrk1ZO9jp6PUtz2iz2k=yRfbH+_w_0BZREHcrBuRo3pYiVPg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] fsx: support reads/writes from buffers backed by hugepages
To: Brian Foster <bfoster@redhat.com>
Cc: "Darrick J. Wong" <djwong@kernel.org>, fstests@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, nirjhar@linux.ibm.com, zlang@redhat.com, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 16, 2025 at 4:51=E2=80=AFAM Brian Foster <bfoster@redhat.com> w=
rote:
>
> On Wed, Jan 15, 2025 at 04:59:19PM -0800, Darrick J. Wong wrote:
> > On Wed, Jan 15, 2025 at 04:47:30PM -0800, Joanne Koong wrote:
> > > On Wed, Jan 15, 2025 at 1:37=E2=80=AFPM Darrick J. Wong <djwong@kerne=
l.org> wrote:
> > > >
> > > > On Wed, Jan 15, 2025 at 10:31:06AM -0800, Joanne Koong wrote:
> > > > > Add support for reads/writes from buffers backed by hugepages.
> > > > > This can be enabled through the '-h' flag. This flag should only =
be used
> > > > > on systems where THP capabilities are enabled.
> > > > >
> > > > > This is motivated by a recent bug that was due to faulty handling=
 of
> > > > > userspace buffers backed by hugepages. This patch is a mitigation
> > > > > against problems like this in the future.
> > > > >
> > > > > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > > > > Reviewed-by: Brian Foster <bfoster@redhat.com>
> > > > > ---
> > > > >  ltp/fsx.c | 119 ++++++++++++++++++++++++++++++++++++++++++++++++=
+-----
> > > > >  1 file changed, 108 insertions(+), 11 deletions(-)
> > > > >
> > > > > diff --git a/ltp/fsx.c b/ltp/fsx.c
> > > > > index 41933354..8d3a2e2c 100644
> > > > > --- a/ltp/fsx.c
> > > > > +++ b/ltp/fsx.c
> > > > > @@ -190,6 +190,7 @@ int       o_direct;                       /* =
-Z */
> > > > >  int  aio =3D 0;
> > > > >  int  uring =3D 0;
> > > > >  int  mark_nr =3D 0;
> > > > > +int  hugepages =3D 0;                  /* -h flag */
> > > > >
> > > > >  int page_size;
> > > > >  int page_mask;
> > > > > @@ -2471,7 +2472,7 @@ void
> > > > >  usage(void)
> > > > >  {
> > > > >       fprintf(stdout, "usage: %s",
> > > > > -             "fsx [-dfknqxyzBEFHIJKLORWXZ0]\n\
> > > > > +             "fsx [-dfhknqxyzBEFHIJKLORWXZ0]\n\
> > > > >          [-b opnum] [-c Prob] [-g filldata] [-i logdev] [-j logid=
]\n\
> > > > >          [-l flen] [-m start:end] [-o oplen] [-p progressinterval=
]\n\
> > > > >          [-r readbdy] [-s style] [-t truncbdy] [-w writebdy]\n\
> > > > > @@ -2484,6 +2485,7 @@ usage(void)
> > > > >       -e: pollute post-eof on size changes (default 0)\n\
> > > > >       -f: flush and invalidate cache after I/O\n\
> > > > >       -g X: write character X instead of random generated data\n\
> > > > > +     -h hugepages: use buffers backed by hugepages for reads/wri=
tes\n\
> > > >
> > > > If this requires MADV_COLLAPSE, then perhaps the help text shouldn'=
t
> > > > describe the switch if the support wasn't compiled in?
> > > >
> > > > e.g.
> > > >
> > > >         -g X: write character X instead of random generated data\n"
> > > > #ifdef MADV_COLLAPSE
> > > > "       -h hugepages: use buffers backed by hugepages for reads/wri=
tes\n"
> > > > #endif
> > > > "       -i logdev: do integrity testing, logdev is the dm log write=
s device\n\
> > > >
> > > > (assuming I got the preprocessor and string construction goo right;=
 I
> > > > might be a few cards short of a deck due to zombie attack earlier)
> > >
> > > Sounds great, I'll #ifdef out the help text -h line. Hope you feel be=
tter.
> > > >
> > > > >       -i logdev: do integrity testing, logdev is the dm log write=
s device\n\
> > > > >       -j logid: prefix debug log messsages with this id\n\
> > > > >       -k: do not truncate existing file and use its size as upper=
 bound on file size\n\
> > > [...]
> > > > > +}
> > > > > +
> > > > > +#ifdef MADV_COLLAPSE
> > > > > +static void *
> > > > > +init_hugepages_buf(unsigned len, int hugepage_size, int alignmen=
t)
> > > > > +{
> > > > > +     void *buf;
> > > > > +     long buf_size =3D roundup(len, hugepage_size) + alignment;
> > > > > +
> > > > > +     if (posix_memalign(&buf, hugepage_size, buf_size)) {
> > > > > +             prterr("posix_memalign for buf");
> > > > > +             return NULL;
> > > > > +     }
> > > > > +     memset(buf, '\0', buf_size);
> > > > > +     if (madvise(buf, buf_size, MADV_COLLAPSE)) {
> > > >
> > > > If the fsx runs for a long period of time, will it be necessary to =
call
> > > > MADV_COLLAPSE periodically to ensure that reclaim doesn't break up =
the
> > > > hugepage?
> > > >
> > >
> > > imo, I don't think so. My understanding is that this would be a rare
> > > edge case that happens when the system is constrained on memory, in
> > > which case subsequent calls to MADV_COLLAPSE would most likely fail
> > > anyways.
> >
> > Hrmmm... well I /do/ like to run memory constrained VMs to prod reclaim
> > into stressing the filesystem more.  But I guess there's no good way fo=
r
> > fsx to know that something happened to it.  Unless there's some even
> > goofier way to force a hugepage, like shmem/hugetlbfs (ugh!) :)
> >
> > Will have to ponder hugepage renewasl -- maybe we should madvise every
> > few thousand fsxops just to be careful?
> >
>
> I wonder.. is there test value in doing collapses to the target file as
> well, either as a standalone map/madvise command or a random thing
> hitched onto preexisting commands? If so, I could see how something like
> that could potentially lift the current init time only approach into
> something that occurs with frequency, which then could at the same time
> (again maybe randomly) reinvoke for internal buffers as well.

My understanding is that if a filesystem has support enabled for large
folios, then doing large writes/reads (which I believe is currently
supported in fsx via the -o flag) will already automatically test the
functionality of how the filesystem handles hugepages. I don't think
this would be different from what doing a collapse on the target file
would do.


Thanks,
Joanne

>
> All that said, this is new functionality and IIUC provides functional
> test coverage for a valid issue. IMO, it would be nice to get this
> merged as a baseline feature and explore these sort of enhancements as
> followon work. Just my .02.
>
> Brian
>
> > --D
> >
> > >
> > > Thanks,
> > > Joanne
> > >
> > > > > +             prterr("madvise collapse for buf");
> > > > > +             free(buf);
> > > > > +             return NULL;
> > > > > +     }
> > > > > +
> > > > > +     return buf;
> > > > > +}
> > > > > +#else
> > > > > +static void *
> > > > > +init_hugepages_buf(unsigned len, int hugepage_size, int alignmen=
t)
> > > > > +{
> > > > > +     return NULL;
> > > > > +}
> > > > > +#endif
> > > > > +
> > > > > +static void
> > > > > +init_buffers(void)
> > > > > +{
> > > > > +     int i;
> > > > > +
> > > > > +     original_buf =3D (char *) malloc(maxfilelen);
> > > > > +     for (i =3D 0; i < maxfilelen; i++)
> > > > > +             original_buf[i] =3D random() % 256;
> > > > > +     if (hugepages) {
> > > > > +             long hugepage_size =3D get_hugepage_size();
> > > > > +             if (hugepage_size =3D=3D -1) {
> > > > > +                     prterr("get_hugepage_size()");
> > > > > +                     exit(102);
> > > > > +             }
> > > > > +             good_buf =3D init_hugepages_buf(maxfilelen, hugepag=
e_size, writebdy);
> > > > > +             if (!good_buf) {
> > > > > +                     prterr("init_hugepages_buf failed for good_=
buf");
> > > > > +                     exit(103);
> > > > > +             }
> > > > > +
> > > > > +             temp_buf =3D init_hugepages_buf(maxoplen, hugepage_=
size, readbdy);
> > > > > +             if (!temp_buf) {
> > > > > +                     prterr("init_hugepages_buf failed for temp_=
buf");
> > > > > +                     exit(103);
> > > > > +             }
> > > > > +     } else {
> > > > > +             unsigned long good_buf_len =3D maxfilelen + writebd=
y;
> > > > > +             unsigned long temp_buf_len =3D maxoplen + readbdy;
> > > > > +
> > > > > +             good_buf =3D calloc(1, good_buf_len);
> > > > > +             temp_buf =3D calloc(1, temp_buf_len);
> > > > > +     }
> > > > > +     good_buf =3D round_ptr_up(good_buf, writebdy, 0);
> > > > > +     temp_buf =3D round_ptr_up(temp_buf, readbdy, 0);
> > > > > +}
> > > > > +
> > > > >  static struct option longopts[] =3D {
> > > > >       {"replay-ops", required_argument, 0, 256},
> > > > >       {"record-ops", optional_argument, 0, 255},
> > > > > @@ -2883,7 +2980,7 @@ main(int argc, char **argv)
> > > > >       setvbuf(stdout, (char *)0, _IOLBF, 0); /* line buffered std=
out */
> > > > >
> > > > >       while ((ch =3D getopt_long(argc, argv,
> > > > > -                              "0b:c:de:fg:i:j:kl:m:no:p:qr:s:t:u=
w:xyABD:EFJKHzCILN:OP:RS:UWXZ",
> > > > > +                              "0b:c:de:fg:hi:j:kl:m:no:p:qr:s:t:=
uw:xyABD:EFJKHzCILN:OP:RS:UWXZ",
> > > > >                                longopts, NULL)) !=3D EOF)
> > > > >               switch (ch) {
> > > > >               case 'b':
> > > > > @@ -2916,6 +3013,14 @@ main(int argc, char **argv)
> > > > >               case 'g':
> > > > >                       filldata =3D *optarg;
> > > > >                       break;
> > > > > +             case 'h':
> > > > > +                     #ifndef MADV_COLLAPSE
> > > >
> > > > Preprocessor directives should start at column 0, like most of the =
rest
> > > > of fstests.
> > > >
> > > > --D
> > > >
> >
>

