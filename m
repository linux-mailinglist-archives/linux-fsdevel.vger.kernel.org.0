Return-Path: <linux-fsdevel+bounces-36887-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9D3C9EA796
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2024 06:14:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6941C282C5D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2024 05:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7132221DB9;
	Tue, 10 Dec 2024 05:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UMP9qpqw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52109168BE
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Dec 2024 05:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733807687; cv=none; b=e6pKEwJGrCHb9FsGORkZzGzikknpQSwk7qfSCQv/VpzKNAnn1NWDICsbMhs1CdH2Ze3hJ2XIIeNTVV4U4hZaFLwQpeQMu6lAAYkX7LF0hE44kCILK+EaC0ZEI4c+4oCLZp7NOWPTv6/AhNXRe/QVH+VhfkH1d6fxeMKZZ+hjU34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733807687; c=relaxed/simple;
	bh=z59J8wQ2PwaogEQp7QG/JbDFe9mJg4lcH0DfP37yzHs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dZqNXhLzSMS2aZe7Fd1U/RpK2wmTpyWJTy620CrTmFv/6o223ddAALM2LOXOupRxzT+lWQZKuHZvwLk/OmeasO/X5MbvXXRYiGbHTXdf5+o9EwjrhT9HMiOoyKSSKG1988zfmWatqjLwPRGiTqBPScptPBPuYg/xSjE+KoNBBqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UMP9qpqw; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-46769b34cbfso20900911cf.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Dec 2024 21:14:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733807684; x=1734412484; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E1l1vsu6BgPpACJc3XjdJq3ESVl6fF0TL1KBSvIbWzo=;
        b=UMP9qpqw1+t/EKchLbPORX/a2wor0SFe7hb/ZOlglsW5TrJzCO0s4vXdzvKKSddVIq
         x+b7rRLiPaF1MhFoQiuSDXP1fOIovHalMcglOrjaOoFFL5gWvIiLPMYLVSPCCyNXeJhc
         MB+m0UESmlLAMIFkSK3uKERKle0eWDy7VaA6T3emDah8qM2eKoHf1JJEZp//EB9vKJy0
         48w5H+Yv4LHW7f1UiqGrvX/kLzZN0ejEmKCn6i6DSkbvMUYh+pMNuI1TNJBa47YMaqvo
         E1euOtozZqVvVbFYnJ4dUeJuxVFe1oxriXSZfStI1HHFPQcDG9b//jP0QcI1UmVywZkz
         HmBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733807684; x=1734412484;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E1l1vsu6BgPpACJc3XjdJq3ESVl6fF0TL1KBSvIbWzo=;
        b=i30I+sQkf5Vjslt/06gcirfxF8qrSugfc30/2a6SICsYDS6IXsvy5KQI2kyqIJ+1VF
         +82YZillr9cKyAgLRcciZLFraaBbjBM1/gSRRWG10IpNVqB0eUS11TAfDf5VYmk0lrfw
         a1VOYnciFp/JGC5h3v0FUQmIa8qdd75jNy0+jFXRI+OjjH4y0SqZr5bfcqe4pVXjj6kA
         puRbIrOZ/Lcl92wBDDIxXOdjgUqNn2luqD98pjvu3s4sfhxRCk1SWAdIElO2ZivGy5eY
         ebPcPcVL3Xx7iqHqQvIqU4rgomWZmLh3Ebf2WEa5jV2+yakZEmRqg4gMVyanOiKpA98f
         eXpw==
X-Forwarded-Encrypted: i=1; AJvYcCU0M4iYh6M3WZqcLJBfGM4tdyThSO1b2Olcub3St70aJr8Me3tiS//vknip1I/pay3vIFdOJRRKzsSXhb1h@vger.kernel.org
X-Gm-Message-State: AOJu0YwKDzxnNxRgJ409EVAqpI3XS0C/N+biRzmRL8cPjEkRWy7gQVFS
	dVr9LetcDbNW+kGDJzO/QjCAPA8IsbYIdCO2qkZ+ZfKjMUsK2Ht+hnA0lxV6O7H5TM1jPrCcBFC
	CQEyJC9RB2MVNavWgSXoCN8omPoA=
X-Gm-Gg: ASbGncthzO08h89i7QbV9vxaovYxcsO+3f9xoJnvgwEVlhna/jP0N+K16BSBOCcmsSO
	8sKj16HBzV68HSlM/adTHPJOSzIMGJSBRUU1TPip2HaP1L8UkbcQ=
X-Google-Smtp-Source: AGHT+IF97o58M1fIgKbWqslR2VyXrecX1eL5DPHya0OoPobaV33MmdIX07GKGV30Jlw/o/QLCVdXmgowTBG76G3g66M=
X-Received: by 2002:ac8:5d4c:0:b0:467:6486:beea with SMTP id
 d75a77b69052e-4677200995cmr55772531cf.38.1733807684071; Mon, 09 Dec 2024
 21:14:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <p3iss6hssbvtdutnwmuddvdadubrhfkdoosgmbewvo674f7f3y@cwnwffjqltzw>
 <cb2ceebc-529e-4ed1-89fa-208c263f24fd@tnxip.de> <Z1T09X8l3H5Wnxbv@casper.infradead.org>
 <68a165ea-e58a-40ef-923b-43dfd85ccd68@tnxip.de> <2143b747-f4af-4f61-9c3e-a950ab9020cf@tnxip.de>
 <20241209144948.GE2840216@perftesting> <Z1cMjlWfehN6ssRb@casper.infradead.org>
 <20241209154850.GA2843669@perftesting> <4707aea6-addb-4dc3-96f7-691d2e94ab25@tnxip.de>
 <CAJnrk1apXjQw7LEgSTmjt1xywzjp=+QMfYva4k1x=H0q2S6mag@mail.gmail.com> <CAJnrk1YfeNNpt2puwaMRcpDefMVg1AhjYNY4ZsKNqr85=WLXDg@mail.gmail.com>
In-Reply-To: <CAJnrk1YfeNNpt2puwaMRcpDefMVg1AhjYNY4ZsKNqr85=WLXDg@mail.gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Mon, 9 Dec 2024 21:14:33 -0800
Message-ID: <CAJnrk1aF-_N6aBHbuWz0e+z=B4cH3GjZZ60yHRPbctMMG6Ukxw@mail.gmail.com>
Subject: Re: silent data corruption in fuse in rc1
To: =?UTF-8?Q?Malte_Schr=C3=B6der?= <malte.schroeder@tnxip.de>
Cc: Josef Bacik <josef@toxicpanda.com>, Matthew Wilcox <willy@infradead.org>, 
	Kent Overstreet <kent.overstreet@linux.dev>, Miklos Szeredi <mszeredi@redhat.com>, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 9, 2024 at 11:52=E2=80=AFAM Joanne Koong <joannelkoong@gmail.co=
m> wrote:
>
> On Mon, Dec 9, 2024 at 10:47=E2=80=AFAM Joanne Koong <joannelkoong@gmail.=
com> wrote:
> >
> > On Mon, Dec 9, 2024 at 9:07=E2=80=AFAM Malte Schr=C3=B6der <malte.schro=
eder@tnxip.de> wrote:
> > >
> > > On 09/12/2024 16:48, Josef Bacik wrote:
> > > > On Mon, Dec 09, 2024 at 03:28:14PM +0000, Matthew Wilcox wrote:
> > > >> On Mon, Dec 09, 2024 at 09:49:48AM -0500, Josef Bacik wrote:
> > > >>>> Ha! This time I bisected from f03b296e8b51 to d1dfb5f52ffc. I en=
ded up
> > > >>>> with 3b97c3652d91 as the culprit.
> > > >>> Willy, I've looked at this code and it does indeed look like a 1:=
1 conversion,
> > > >>> EXCEPT I'm fuzzy about how how this works with large folios.  Pre=
viously, if we
> > > >>> got a hugepage in, we'd get each individual struct page back for =
the whole range
> > > >>> of the hugepage, so if for example we had a 2M hugepage, we'd fil=
l in the
> > > >>> ->offset for each "middle" struct page as 0, since obviously we'r=
e consuming
> > > >>> PAGE_SIZE chunks at a time.
> > > >>>
> > > >>> But now we're doing this
> > > >>>
> > > >>>     for (i =3D 0; i < nfolios; i++)
> > > >>>             ap->folios[i + ap->num_folios] =3D page_folio(pages[i=
]);
> > > >>>
> > > >>> So if userspace handed us a 2M hugepage, page_folio() on each of =
the
> > > >>> intermediary struct page's would return the same folio, correct? =
 So we'd end up
> > > >>> with the wrong offsets for our fuse request, because they should =
be based from
> > > >>> the start of the folio, correct?
> > > >> I think you're 100% right.  We could put in some nice asserts to c=
heck
> > > >> this is what's happening, but it does seem like a rather incautiou=
s
> > > >> conversion.  Yes, all folios _in the page cache_ for fuse are smal=
l, but
> > > >> that's not guaranteed to be the case for folios found in userspace=
 for
> > > >> directio.  At least the comment is wrong, and I'd suggest the code=
 is too.
> > > > Ok cool, Malte can you try the attached only compile tested patch a=
nd see if the
> > > > problem goes away?  Thanks,
> > > >
> > > > Josef
> > > >
> > > > diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> > > > index 88d0946b5bc9..c4b93ead99a5 100644
> > > > --- a/fs/fuse/file.c
> > > > +++ b/fs/fuse/file.c
> > > > @@ -1562,9 +1562,19 @@ static int fuse_get_user_pages(struct fuse_a=
rgs_pages *ap, struct iov_iter *ii,
> > > >               nfolios =3D DIV_ROUND_UP(ret, PAGE_SIZE);
> > > >
> > > >               ap->descs[ap->num_folios].offset =3D start;
> > > > -             fuse_folio_descs_length_init(ap->descs, ap->num_folio=
s, nfolios);
> > > > -             for (i =3D 0; i < nfolios; i++)
> > > > -                     ap->folios[i + ap->num_folios] =3D page_folio=
(pages[i]);
> > > > +             for (i =3D 0; i < nfolios; i++) {
> > > > +                     struct folio *folio =3D page_folio(pages[i]);
> > > > +                     unsigned int offset =3D start +
> > > > +                             (folio_page_idx(folio, pages[i]) << P=
AGE_SHIFT);
> > > > +                     unsigned int len =3D min_t(unsigned int, ret,=
 folio_size(folio) - offset);
> > > > +
> > > > +                     len =3D min_t(unsigned int, len, PAGE_SIZE);
> > > > +
> > > > +                     ap->descs[ap->num_folios + i].offset =3D offs=
et;
> > > > +                     ap->descs[ap->num_folios + i].length =3D len;
> > > > +                     ap->folios[i + ap->num_folios] =3D folio;
> > > > +                     start =3D 0;
> > > > +             }
> > > >
> > > >               ap->num_folios +=3D nfolios;
> > > >               ap->descs[ap->num_folios - 1].length -=3D
> > >
> > > The problem persists with this patch.
> > >
>
> Malte, could you try Josef's patch except with that last line
> "ap->descs[ap->num_pages - 1].length  -=3D (PAGE_SIZE - ret) &
> (PAGE_SIZE - 1);" also removed? I think we need that line removed as
> well since that does a "-=3D" instead of a "=3D" and
> ap->descs[ap->num_folios - 1].length gets set inside the for loop.
>
> In the meantime, I'll try to get a local repro running on fsx so that
> you don't have to keep testing out repos for us.

I was able to repro this locally by doing:

-- start libfuse server --
sudo ./libfuse/build/example/passthrough_hp --direct-io ~/src ~/fuse_mount

-- patch + compile this (rough / ugly-for-now) code snippet --
diff --git a/ltp/fsx.c b/ltp/fsx.c
index 777ba0de..9f040bc4 100644
--- a/ltp/fsx.c
+++ b/ltp/fsx.c
@@ -1049,7 +1049,8 @@ dowrite(unsigned offset, unsigned size)
        }
 }

-
+#define TWO_MIB (1 << 21)  // 2 MiB in bytes

 void
 domapwrite(unsigned offset, unsigned size)
 {
@@ -1057,6 +1058,8 @@ domapwrite(unsigned offset, unsigned size)
        unsigned map_size;
        off_t    cur_filesize;
        char    *p;
+       int ret;
+       unsigned size_2mib_aligned;

        offset -=3D offset % writebdy;
        if (size =3D=3D 0) {
@@ -1101,6 +1104,41 @@ domapwrite(unsigned offset, unsigned size)
        pg_offset =3D offset & PAGE_MASK;
        map_size  =3D pg_offset + size;

+       size_2mib_aligned =3D (size + TWO_MIB - 1) & ~(TWO_MIB - 1);
+       void *placeholder_map =3D mmap(NULL, size_2mib_aligned * 2, PROT_NO=
NE,
+                            MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+       if (!placeholder_map) {
+               prterr("domapwrite: placeholder map");
+               exit(202);
+       }
+
+       /* align address to nearest 2 MiB */
+       void *aligned_address =3D
+               (void *)(((uintptr_t)placeholder_map + TWO_MIB - 1) &
~(TWO_MIB - 1));
+
+       void *map =3D mmap(aligned_address, size_2mib_aligned, PROT_READ
| PROT_WRITE,
+                         MAP_PRIVATE | MAP_ANONYMOUS | MAP_FIXED |
MAP_POPULATE, -1, 0);
+
+       ret =3D madvise(map, size_2mib_aligned, MADV_COLLAPSE);
+       if (ret) {
+               prterr("domapwrite: madvise collapse");
+               exit(203);
+       }
+
+       memcpy(map, good_buf + offset, size);
+
+       if (lseek(fd, offset, SEEK_SET) =3D=3D -1) {
+               prterr("domapwrite: lseek");
+               exit(204);
+       }
+
+       ret =3D write(fd, map, size);
+       if (ret =3D=3D -1) {
+               prterr("domapwrite: write");
+               exit(205);
+       }
+
+       /*
        if ((p =3D (char *)mmap(0, map_size, PROT_READ | PROT_WRITE,
                              MAP_FILE | MAP_SHARED, fd,
                              (off_t)(offset - pg_offset))) =3D=3D (char *)=
-1) {
@@ -1119,6 +1157,15 @@ domapwrite(unsigned offset, unsigned size)
                prterr("domapwrite: munmap");
                report_failure(204);
        }
+       */
+       if (munmap(map, size_2mib_aligned) !=3D 0) {
+               prterr("domapwrite: munmap map");
+               report_failure(206);
+       }
+       if (munmap(placeholder_map, size_2mib_aligned * 2) !=3D 0) {
+               prterr("domapwrite: munmap placeholder_map");
+               report_failure(207);
+       }
 }

-- run fsx test --
sudo ./fsx -b 3 ~/fuse_mount/example.txt -N 5000

On the offending commit 3b97c3652, I'm seeing:
[user]$ sudo ./fsx -b 3 ~/fuse_mount/example.txt -N 5000
Will begin at operation 3
Seed set to 1
...
READ BAD DATA: offset =3D 0x1925f, size =3D 0xf7a3, fname =3D
/home/user/fuse_mount/example.txt
OFFSET      GOOD    BAD     RANGE
0x1e43f     0x4b4a  0x114a  0x0
operation# (mod 256) for the bad data may be 74
0x1e441     0xa64a  0xeb4a  0x1
operation# (mod 256) for the bad data may be 74
0x1e443     0x264a  0xe44a  0x2
operation# (mod 256) for the bad data may be 74
0x1e445     0x254a  0x9e4a  0x3
...
Correct content saved for comparison
(maybe hexdump "/home/user/fuse_mount/example.txt" vs
"/home/user/fuse_mount/example.txt.fsxgood")


I tested Josef's patch with the "ap->descs[ap->num_pages - 1].length
-=3D (PAGE_SIZE - ret) & (PAGE_SIZE - 1);" line removed and it fixed the
issue:

[user]$ sudo ./fsx -b 3 ~/fuse_mount/example.txt -N 5000
Will begin at operation 3
Seed set to 1
...
copying to largest ever: 0x3e19b
copying to largest ever: 0x3e343
fallocating to largest ever: 0x40000
All 5000 operations completed A-OK!


Malte, would you mind double-checking whether this fixes the issue
you're seeing on your end?


Thanks,
Joanne

>
> Thanks,
> Joanne
> >
> > Catching up on this thread now. I'll investigate this today.
> >
> > >
> > > /Malte
> > >

