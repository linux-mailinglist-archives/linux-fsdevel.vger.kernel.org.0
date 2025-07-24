Return-Path: <linux-fsdevel+bounces-55967-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0660BB1117A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Jul 2025 21:14:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 121921794D4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Jul 2025 19:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78D592EA462;
	Thu, 24 Jul 2025 19:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aJq1br8H"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42FAB274B3C;
	Thu, 24 Jul 2025 19:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753384465; cv=none; b=kq9SkJuxwtSjh+dvUHNBZ3O+I6s7QX6GYL0lVGkbEGJDIrsenukawxMqx5cl8kyjX7JsqiawxiC+YYRK1hKpF7Yd0lRgDrYQ/ddVNhJuONWGJbs4z7DpTTWjFJ2rhtAoWkcNRkkWfr0AX6PdPmf+xJ7hHkkS52gD999+ojWSae8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753384465; c=relaxed/simple;
	bh=9JY7p80c86n6GjRiruyjjExy0MOzgPy1y+oe7BuOM1I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PrGWy6z6b3ny1MmRTWEGXhzun5YBjQGt9FYP1B1o3XgnR5otb8v3Saoy7h098BmQuERbEQK3W4nhgY67n7BWwik43ZMtPTPNigC+SgmBIVgy4zmJgB5+cy6eMLhw9DFlH2UVlSneN1Z8HLedIK1CKreOwY2xf6IQrJB9YV/11WA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aJq1br8H; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4abc006bcadso17142071cf.0;
        Thu, 24 Jul 2025 12:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753384463; x=1753989263; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2jOSnyBDxczFG/IHSIdGMkE63XZ2hP+zlYXbjMuUNLc=;
        b=aJq1br8HeFmH4qOa3iZ/UnttxtHLSTMkn4llPcmfZFh8+UfUdHPVwDGnT4hH8SMyh6
         0ZsjvKv8wcXUyMZ5azjvvqkHjRW8IPZPyt7QBbZM4manHDsML70yAuDd9d8Tb4wVuYbZ
         YgC9lcuPzyT2Ittj5HBGAb9HHNiRH6EwSwSJ9OpZhIXiiPoxzxq47Qdr55pM4Fr6vBKZ
         GtOD9iiOwglFRULV97Org+5WmM0aA3hqvfWbZqlEWGpQRNQcIo02OVeCbhxv098vf2H6
         Ipu9hHPeoAVwBdR8bgM8d/9QVp0YDI8EBp3ULykiJohN603WHH5zpIsU2j4sYw8sTFrd
         /IVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753384463; x=1753989263;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2jOSnyBDxczFG/IHSIdGMkE63XZ2hP+zlYXbjMuUNLc=;
        b=QY8gL1z3TC2JyKFGbzCRKffApoYmIYQdei+tWcFJTam374Acv87ftgEfXOZCxERRan
         eLKjUxlH9H4P/O5qsUmHRaUTWigok2f8eBt+uYFQMxPIIywJQFl1w/j1GxuSXUwGyO5X
         LFuVSF+PKBNI7eQrniNniU8zSLCGRbMhai1Igif+CaomZW2xE+V1gagdlt5fmV2UKrl8
         QHL2tev8UyeEB45pK/xA/IK5Xy6zyyMwq8bM9kokbAyCP5LfVc6iVh6rc2xGIgOjd7MV
         tpCpEuqwuBWVXLY+kiN+5Lm+qglquFo8CXVQh4JAnWbwvMu0djkZgW2hJIr/2d6sQ3dW
         HBeA==
X-Forwarded-Encrypted: i=1; AJvYcCVvRIS9RgTCIXKFryfYc5uOfVPK/AGpRV+XFfPRkDekGootYxbl8zRtS9QErmBvAdAOh9THmEozctC/mKjF@vger.kernel.org, AJvYcCWZRJRgBHZ5w8R7d7TWbiYolY+euhhgN9TZ78FLPKD51bUKIqCfyWXvFtCgI/PsJ5F3GfTiXs8bEq3mYYLU@vger.kernel.org, AJvYcCXhxVYAtRdcbJRTp1IsDxRjYmDuG3uj/D1OrKYCC1YqyieNKJqhgtTuaJBremKotOkHN7aLcpmIMhKN@vger.kernel.org
X-Gm-Message-State: AOJu0Ywkz04Hhe9Ue8tXPWrFR3I74GF0gQUWhE/3mgXcFU7RaJ93O7aT
	sBBJ/FfUrf2BxHLwxYPJr/mwQPmH+ZZcND2NC3T2nQoW6mgxOTWKwmrQj66a+m3o28OCOJylg90
	TSxMov2qVX3psSgM9i3SaZQtFQ5UEsJI=
X-Gm-Gg: ASbGncvbMTyG85acHbkH7wHYOLps6iB9rCb9Vth3Po2pgeMXNyFoR4NVcJs26LV7Ph3
	IZBwPdQ5lGjOHsZNdpbVMrvfgFFIxslRIsCVym+bZaq8jLXtBQ2IS5eoSZekSG0qNiZMv1EOqld
	8ApHbsZg57Fiqs7ERpp1UGKx1cWS88uqmT9Jds88Ac8jB3CalHSpdw2fa7MMXz3nGv42eNbE84q
	Bb47sE=
X-Google-Smtp-Source: AGHT+IGm06QE4HAxdtDrbkTCJlc3WBllGjE2CLQfWltUi2scOuGwGhLY9rcqQVvFXqhFOXNUBQN8GPgnjRiXL0ZxnAk=
X-Received: by 2002:a05:622a:2486:b0:4ab:db27:4775 with SMTP id
 d75a77b69052e-4ae6e0370b9mr94057441cf.54.1753384462745; Thu, 24 Jul 2025
 12:14:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+G9fYs5AdVM-T2Tf3LciNCwLZEHetcnSkHsjZajVwwpM2HmJw@mail.gmail.com>
 <20250723144637.GW2672070@frogsfrogsfrogs> <CAJnrk1Z7wcB8uKWcrAuRAZ8B-f8SKnOuwtEr-=cHa+ApR_sgXQ@mail.gmail.com>
 <20250723212020.GY2672070@frogsfrogsfrogs> <CAJnrk1bFWRTGnpNhW_9MwSYZw3qPnPXZBeiwtPSrMhCvb9C3qg@mail.gmail.com>
In-Reply-To: <CAJnrk1bFWRTGnpNhW_9MwSYZw3qPnPXZBeiwtPSrMhCvb9C3qg@mail.gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Thu, 24 Jul 2025 12:14:10 -0700
X-Gm-Features: Ac12FXzB5jWOM2jLEHuea3HtXx8QVU4kwGFHqdvioSKikDPZlGiijO3gRX8BQys
Message-ID: <CAJnrk1byTVJtuOyAyZSVYrusjhA-bW6pxBOQQopgHHbD3cDUHw@mail.gmail.com>
Subject: Re: next-20250721 arm64 16K and 64K page size WARNING fs fuse file.c
 at fuse_iomap_writeback_range
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Naresh Kamboju <naresh.kamboju@linaro.org>, linux-fsdevel@vger.kernel.org, 
	linux-mm <linux-mm@kvack.org>, linux-xfs@vger.kernel.org, 
	open list <linux-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org, 
	Linux Regressions <regressions@lists.linux.dev>, Miklos Szeredi <miklos@szeredi.hu>, Jan Kara <jack@suse.cz>, 
	Andrew Morton <akpm@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <liam.howlett@oracle.com>, 
	Arnd Bergmann <arnd@arndb.de>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Anders Roxell <anders.roxell@linaro.org>, Ben Copeland <benjamin.copeland@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 23, 2025 at 3:37=E2=80=AFPM Joanne Koong <joannelkoong@gmail.co=
m> wrote:
>
> On Wed, Jul 23, 2025 at 2:20=E2=80=AFPM Darrick J. Wong <djwong@kernel.or=
g> wrote:
> >
> > On Wed, Jul 23, 2025 at 11:42:42AM -0700, Joanne Koong wrote:
> > > On Wed, Jul 23, 2025 at 7:46=E2=80=AFAM Darrick J. Wong <djwong@kerne=
l.org> wrote:
> > > >
> > > > [cc Joanne]
> > > >
> > > > On Wed, Jul 23, 2025 at 05:14:28PM +0530, Naresh Kamboju wrote:
> > > > > Regressions found while running LTP msync04 tests on qemu-arm64 r=
unning
> > > > > Linux next-20250721, next-20250722 and next-20250723 with 16K and=
 64K
> > > > > page size enabled builds.
> > > > >
> > > > > CONFIG_ARM64_64K_PAGES=3Dy ( kernel warning as below )
> > > > > CONFIG_ARM64_16K_PAGES=3Dy ( kernel warning as below )
> > > > >
> > > > > No warning noticed with 4K page size.
> > > > > CONFIG_ARM64_4K_PAGES=3Dy works as expected
> > > >
> > > > You might want to cc Joanne since she's been working on large folio
> > > > support in fuse.
> > > >
> > > > > First seen on the tag next-20250721.
> > > > > Good: next-20250718
> > > > > Bad:  next-20250721 to next-20250723
> > >
> > > Thanks for the report. Is there a link to the script that mounts the
> > > fuse server for these tests? I'm curious whether this was mounted as =
a
> > > fuseblk filesystem.
> > >
> > > > >
> > > > > Regression Analysis:
> > > > > - New regression? Yes
> > > > > - Reproducibility? Yes
> > > > >
> > > > > Test regression: next-20250721 arm64 16K and 64K page size WARNIN=
G fs
> > > > > fuse file.c at fuse_iomap_writeback_range
> > > > >
> > > > > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> > > > >
> > > > > ## Test log
> > > > > ------------[ cut here ]------------
> > > > > [  343.828105] WARNING: fs/fuse/file.c:2146 at
> > > > > fuse_iomap_writeback_range+0x478/0x558 [fuse], CPU#0: msync04/419=
0
> > > >
> > > >         WARN_ON_ONCE(len & (PAGE_SIZE - 1));
> > > >
> > > > /me speculates that this might be triggered by an attempt to write =
back
> > > > some 4k fsblock within a 16/64k base page?
> > > >
> > >
> > > I think this can happen on 4k base pages as well actually. On the
> > > iomap side, the length passed is always block-aligned and in fuse, we
> > > set blkbits to be PAGE_SHIFT so theoretically block-aligned is always
> > > page-aligned, but I missed that if it's a "fuseblk" filesystem, that
> > > isn't true and the blocksize is initialized to a default size of 512
> > > or whatever block size is passed in when it's mounted.
> >
> > <nod> I think you're correct.
> >
> > > I'll send out a patch to remove this line. It doesn't make any
> > > difference for fuse_iomap_writeback_range() logic whether len is
> > > page-aligned or not; I had added it as a sanity-check against sketchy
> > > ranges.
> > >
> > > Also, I just noticed that apparently the blocksize can change
> > > dynamically for an inode in fuse through getattr replies from the
> > > server (see fuse_change_attributes_common()). This is a problem since
> > > the iomap uses inode->i_blkbits for reading/writing to the bitmap. I
> > > think we will have to cache the inode blkbits in the iomap_folio_stat=
e
> > > struct unfortunately :( I'll think about this some more and send out =
a
> > > patch for this.
> >
> > From my understanding of the iomap code, it's possible to do that if yo=
u
> > flush and unmap the entire pagecache (whilst holding i_rwsem and
> > mmap_invalidate_lock) before you change i_blkbits.  Nobody *does* this
> > so I have no idea if it actually works, however.  Note that even I don'=
t
> > implement the flush and unmap bit; I just scream loudly and do nothing:
>
> lol! i wish I could scream loudly and do nothing too for my case.
>
> AFAICT, I think I just need to flush and unmap that file and can leave
> the rest of the files/folios in the pagecache as is? But then if the
> file has active refcounts on it or has been pinned into memory, can I
> still unmap and remove it from the page cache? I see the
> invalidate_inode_pages2() function but my understanding is that the
> page still stays in the cache if it has has active references, and if
> the page gets mmaped and there's a page fault on it, it'll end up
> using the preexisting old page in the page cache.

Never mind, I was mistaken about this. Johannes confirmed that even if
there's active refcounts on the folio, it'll still get removed from
the page cache after unmapping and the page cache reference will get
dropped.

I think I can just do what you suggested and call
filemap_invalidate_inode() in fuse_change_attributes_common() then if
the inode blksize gets changed. Thanks for the suggestion!

>
> I don't think I really need to have it removed from the page cache so
> much as just have the ifs state for all the folios in the file freed
> (after flushing the file) so that it can start over with a new ifs.
> Ideally we could just flush the file, then iterate through all the
> folios in the mapping in order of ascending index, and kfree their
> ->private, but I'm not seeing how we can prevent the case of new
> writes / a new ifs getting allocated for folios at previous indexes
> while we're trying to do the iteration/kfreeing.
>
> >
> > void fuse_iomap_set_i_blkbits(struct inode *inode, u8 new_blkbits)
> > {
> >         trace_fuse_iomap_set_i_blkbits(inode, new_blkbits);
> >
> >         if (inode->i_blkbits =3D=3D new_blkbits)
> >                 return;
> >
> >         if (!S_ISREG(inode->i_mode))
> >                 goto set_it;
> >
> >         /*
> >          * iomap attaches per-block state to each folio, so we cannot a=
llow
> >          * the file block size to change if there's anything in the pag=
e cache.
> >          * In theory, fuse servers should never be doing this.
> >          */
> >         if (inode->i_mapping->nrpages > 0) {
> >                 WARN_ON(inode->i_blkbits !=3D new_blkbits &&
> >                         inode->i_mapping->nrpages > 0);
> >                 return;
> >         }
> >
> > set_it:
> >         inode->i_blkbits =3D new_blkbits;
> > }
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/co=
mmit/?h=3Dfuse-iomap-attrs&id=3Dda9b25d994c1140aae2f5ebf10e54d0872f5c884
> >
> > --D
> >
> > >
> > > Thanks,
> > > Joanne
> > >

