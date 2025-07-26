Return-Path: <linux-fsdevel+bounces-56059-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 57925B12862
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Jul 2025 03:16:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80C67547B73
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Jul 2025 01:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 005361A76BB;
	Sat, 26 Jul 2025 01:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ixhg8k/W"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E6FA15E8B;
	Sat, 26 Jul 2025 01:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753492590; cv=none; b=akOVZV95YQsOaYNWNXlrYu+5BQmmMwKLDp+AlUtWVLsVSQdRk2JZe3RbPR9iFNwG6DhmeJQkwAZV+6sE/9xRbM4CC5jiekW+8JvODtaudmx4IZYb+5G6yYkSCjwcq0SpFwc0giCaIL8edFMLxitT9pAQg6oXSu9C4ikYPVVCNpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753492590; c=relaxed/simple;
	bh=A+DLYEBZHjbPEKb4Gqj5iMUWPXTPgnHHysYdeCmeeIM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QX4She0ir/cOXbIP9Lpil+rdOSTZ8klawRIaIF3CImpq5H0Pjf6LGgLRNb1wQ2Vh7zkD4eBT1p+1iEhxmMR18AqBe3z08ajsA86aeF68KzTnVwqBmvBbvUofnU7iHt/l3pyYGkD/m3nREjxdNK57A55arkgKepvHT+lYS+pO03g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ixhg8k/W; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4ab6416496dso32255791cf.1;
        Fri, 25 Jul 2025 18:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753492587; x=1754097387; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+3wL90PTGk/ln0g+DfvE2KqqysVDgICkM8ai1CipU4s=;
        b=Ixhg8k/W/HLFN/fPQiRdeu/MrqCV0EmGFcJIeEGwkWs/hOa6WFmofURa+Rj9UQVVfZ
         9PkeCAAK4awutmoZXDs4AGOE/mUhZiETNVbcB8A5AZcvbIkxhngH84mbKTByql7dHg85
         q1QPEcIo4qrhbP5zd9pMcjpednnKU4mhMiFy5wpEcwQWAJ05oCXI9RA5pq/RUtUvj/J1
         QaUcQPzq71FbDj15uUC1lwXjs4Znv3wn/AroY/KJ/EoQGPjASY4Ud1zoqTAfdIil+OcF
         PbLn2DsHMehinakTE1CWFgN0/ZcRdiydx/2lmXD58KkDhfbt3hNljfQ6djNsvFBfSTjQ
         z8rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753492587; x=1754097387;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+3wL90PTGk/ln0g+DfvE2KqqysVDgICkM8ai1CipU4s=;
        b=HKL8rg0Oar7vMYq0Pz3jZTkKUsON2kTWUTMKpdtRzYcatw8dveP+loyPEUjoQrq3cJ
         tyJOhsWn5Zxc53yPvNzlc+LDAh1NW8d7hvVGE4WdQ62ewRJuDizeAEsp5vzWOOTB06+e
         V2zfQzBGkaUd8j93wqT1HkZVdoL78EqjMc7K8VG6Q2CQQ2e9WSMu/cE4fbNoyTz3m79A
         s8apj29aXz2IIjnI9jHYdwpA/X55PjcfjB+WPVV9mHnFTpCOIfCLGQSrvWrPWXJ6r6HU
         OYRQb1WuxIDizgRLKVdxkoCVclDtHPthTXtLZBcZHmyixHJ2uS4m3WYu1axaqp5p0pgA
         dhzg==
X-Forwarded-Encrypted: i=1; AJvYcCWOUUwxwW3Ot4AKBTl1OK4n27jl2dGgB0kZa2YLWjcYuXo5gZ6v0tZY1VlEkUofE5wDinWJ/FoopOt/kpPY@vger.kernel.org, AJvYcCWeul/aqFshR0ZNZQ/TRvw10j4LVURz62RZ84l2mPSOTsTAC731OfcMd/oRRIxdxQiZTElFINx8DLRW@vger.kernel.org, AJvYcCXb/4Ka8bFyNh8ddBwCmaQp3ab7sfm6kWldDhtR5pHOkZ+DIlDYmBFAY+AmcfYxI4h53R1kKWaVa6ueYHH3@vger.kernel.org
X-Gm-Message-State: AOJu0YzBKo3F9a8S6QNGaeEKwGfP57FyOPDYW+egg3u5HDTIZu8q3Kgl
	KwctbV81tDxKbJoypLFMKDj9hgj34gDhRpteydN+x0sdC6ctBJTLrMJF5uGCl8ufHeh0qF6E1iV
	d24sXhAA/c278peykWkSt8LvryaOcvX4=
X-Gm-Gg: ASbGncutrFZw1cjugxRjgxcSk1Vrw2L6wu47DT9E7K1xIJcYlzxS0E+yLX4XKnHkReo
	pFEJNdHmUd3fzeRomf2eAviX9udxz3XyLenYC+t6Dl9XQwI4IpLYbKE+xhtJKlPmHHJ3NOhFPE6
	cRDgJI/Cgg3e3SdgK1ubqDt+a692pMWl6I1/+0Ep7iv4PzCd+qyWvtH3quLDfQijaLCZjgHhGh/
	VXKn00=
X-Google-Smtp-Source: AGHT+IHA6MAWvCAFknvGjN01kW0YSiAmTWDknlm+9zgfPFOgXpK3YgxcKpk7P+6ZJn0jP1CHQ4ztram7FXEAQAYa4gg=
X-Received: by 2002:a05:622a:34a:b0:494:a2b8:88f0 with SMTP id
 d75a77b69052e-4ae8f012526mr46072551cf.33.1753492586365; Fri, 25 Jul 2025
 18:16:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+G9fYs5AdVM-T2Tf3LciNCwLZEHetcnSkHsjZajVwwpM2HmJw@mail.gmail.com>
 <20250723144637.GW2672070@frogsfrogsfrogs> <CAJnrk1Z7wcB8uKWcrAuRAZ8B-f8SKnOuwtEr-=cHa+ApR_sgXQ@mail.gmail.com>
 <20250723212020.GY2672070@frogsfrogsfrogs> <CAJnrk1bFWRTGnpNhW_9MwSYZw3qPnPXZBeiwtPSrMhCvb9C3qg@mail.gmail.com>
 <CAJnrk1byTVJtuOyAyZSVYrusjhA-bW6pxBOQQopgHHbD3cDUHw@mail.gmail.com>
In-Reply-To: <CAJnrk1byTVJtuOyAyZSVYrusjhA-bW6pxBOQQopgHHbD3cDUHw@mail.gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Fri, 25 Jul 2025 18:16:15 -0700
X-Gm-Features: Ac12FXzimnd_vsyILA4Tel0YjqyEWWgthWY0MmY0akKuYlWvyLQqpBlaOUBO320
Message-ID: <CAJnrk1ZYR=hM5k90H57tOv=fe6F-r8dO+f3wNuCT_w3j8YNYNQ@mail.gmail.com>
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

On Thu, Jul 24, 2025 at 12:14=E2=80=AFPM Joanne Koong <joannelkoong@gmail.c=
om> wrote:
>
> On Wed, Jul 23, 2025 at 3:37=E2=80=AFPM Joanne Koong <joannelkoong@gmail.=
com> wrote:
> >
> > On Wed, Jul 23, 2025 at 2:20=E2=80=AFPM Darrick J. Wong <djwong@kernel.=
org> wrote:
> > >
> > > On Wed, Jul 23, 2025 at 11:42:42AM -0700, Joanne Koong wrote:
> > > > On Wed, Jul 23, 2025 at 7:46=E2=80=AFAM Darrick J. Wong <djwong@ker=
nel.org> wrote:
> > > > >
> > > > > [cc Joanne]
> > > > >
> > > > > On Wed, Jul 23, 2025 at 05:14:28PM +0530, Naresh Kamboju wrote:
> > > > > > Regressions found while running LTP msync04 tests on qemu-arm64=
 running
> > > > > > Linux next-20250721, next-20250722 and next-20250723 with 16K a=
nd 64K
> > > > > > page size enabled builds.
> > > > > >
> > > > > > CONFIG_ARM64_64K_PAGES=3Dy ( kernel warning as below )
> > > > > > CONFIG_ARM64_16K_PAGES=3Dy ( kernel warning as below )
> > > > > >
> > > > > > No warning noticed with 4K page size.
> > > > > > CONFIG_ARM64_4K_PAGES=3Dy works as expected
> > > > >
> > > > > You might want to cc Joanne since she's been working on large fol=
io
> > > > > support in fuse.
> > > > >
> > > > > > First seen on the tag next-20250721.
> > > > > > Good: next-20250718
> > > > > > Bad:  next-20250721 to next-20250723
> > > >
> > > > Thanks for the report. Is there a link to the script that mounts th=
e
> > > > fuse server for these tests? I'm curious whether this was mounted a=
s a
> > > > fuseblk filesystem.
> > > >
> > > > > >
> > > > > > Regression Analysis:
> > > > > > - New regression? Yes
> > > > > > - Reproducibility? Yes
> > > > > >
> > > > > > Test regression: next-20250721 arm64 16K and 64K page size WARN=
ING fs
> > > > > > fuse file.c at fuse_iomap_writeback_range
> > > > > >
> > > > > > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> > > > > >
> > > > > > ## Test log
> > > > > > ------------[ cut here ]------------
> > > > > > [  343.828105] WARNING: fs/fuse/file.c:2146 at
> > > > > > fuse_iomap_writeback_range+0x478/0x558 [fuse], CPU#0: msync04/4=
190
> > > > >
> > > > >         WARN_ON_ONCE(len & (PAGE_SIZE - 1));
> > > > >
> > > > > /me speculates that this might be triggered by an attempt to writ=
e back
> > > > > some 4k fsblock within a 16/64k base page?
> > > > >
> > > >
> > > > I think this can happen on 4k base pages as well actually. On the
> > > > iomap side, the length passed is always block-aligned and in fuse, =
we
> > > > set blkbits to be PAGE_SHIFT so theoretically block-aligned is alwa=
ys
> > > > page-aligned, but I missed that if it's a "fuseblk" filesystem, tha=
t
> > > > isn't true and the blocksize is initialized to a default size of 51=
2
> > > > or whatever block size is passed in when it's mounted.
> > >
> > > <nod> I think you're correct.
> > >
> > > > I'll send out a patch to remove this line. It doesn't make any
> > > > difference for fuse_iomap_writeback_range() logic whether len is
> > > > page-aligned or not; I had added it as a sanity-check against sketc=
hy
> > > > ranges.
> > > >
> > > > Also, I just noticed that apparently the blocksize can change
> > > > dynamically for an inode in fuse through getattr replies from the
> > > > server (see fuse_change_attributes_common()). This is a problem sin=
ce
> > > > the iomap uses inode->i_blkbits for reading/writing to the bitmap. =
I
> > > > think we will have to cache the inode blkbits in the iomap_folio_st=
ate
> > > > struct unfortunately :( I'll think about this some more and send ou=
t a
> > > > patch for this.
> > >
> > > From my understanding of the iomap code, it's possible to do that if =
you
> > > flush and unmap the entire pagecache (whilst holding i_rwsem and
> > > mmap_invalidate_lock) before you change i_blkbits.  Nobody *does* thi=
s
> > > so I have no idea if it actually works, however.  Note that even I do=
n't
> > > implement the flush and unmap bit; I just scream loudly and do nothin=
g:
> >
> > lol! i wish I could scream loudly and do nothing too for my case.
> >
> > AFAICT, I think I just need to flush and unmap that file and can leave
> > the rest of the files/folios in the pagecache as is? But then if the
> > file has active refcounts on it or has been pinned into memory, can I
> > still unmap and remove it from the page cache? I see the
> > invalidate_inode_pages2() function but my understanding is that the
> > page still stays in the cache if it has has active references, and if
> > the page gets mmaped and there's a page fault on it, it'll end up
> > using the preexisting old page in the page cache.
>
> Never mind, I was mistaken about this. Johannes confirmed that even if
> there's active refcounts on the folio, it'll still get removed from
> the page cache after unmapping and the page cache reference will get
> dropped.
>
> I think I can just do what you suggested and call
> filemap_invalidate_inode() in fuse_change_attributes_common() then if
> the inode blksize gets changed. Thanks for the suggestion!
>

Thinking about this some more, I don't think this works after all
because the writeback + page cache removal and inode blkbits update
needs to be atomic, else after we write back and remove the pages from
the page cache, a write could be issued right before we update the
inode blkbits. I don't think we can hold the inode lock the whole time
for it either since writeback could be intensive. (also btw, I
realized in hindsight that invalidate_inode_pages2_range() would have
been the better function to call instead of
filemap_invalidate_inode()).

> >
> > I don't think I really need to have it removed from the page cache so
> > much as just have the ifs state for all the folios in the file freed
> > (after flushing the file) so that it can start over with a new ifs.
> > Ideally we could just flush the file, then iterate through all the
> > folios in the mapping in order of ascending index, and kfree their
> > ->private, but I'm not seeing how we can prevent the case of new
> > writes / a new ifs getting allocated for folios at previous indexes
> > while we're trying to do the iteration/kfreeing.
> >

Going back to this idea, I think this can work. I realized we don't
need to flush the file, it's enough to free the ifs, then update the
inode->i_blkbits, then reallocate the ifs (which will now use the
updated blkbits size), and if we hold the inode lock throughout, that
prevents any concurrent writes.
Something like:
     inode_lock(inode);
     XA_STATE(xas, &mapping->i_pages, 0);
     xa_lock_irq(&mapping->i_pages);
     xas_for_each_marked(&xas, folio, ULONG_MAX, PAGECACHE_TAG_DIRTY) {
          folio_lock(folio);
          if (folio_test_dirty(folio)) {
                  folio_wait_writeback(folio);
                  kfree(folio->private);
          }
          folio_unlock(folio);
     }
    inode->i_blkbits =3D new_blkbits_size;
    xas_set(&xas, 0);
    xas_for_each_marked(&xas, folio, ULONG_MAX, PAGECACHE_TAG_DIRTY) {
          folio_lock(folio);
          if (folio_test_dirty(folio) && !folio_test_writeback(folio))
                 folio_mark_dirty(folio);
          folio_unlock(folio);
    }
    xa_unlock_irq(&mapping->i_pages);
    inode_unlock(inode);


I think this is the only approach that doesn't require changes to iomap.

I'm going to think about this some more next week and will try to send
out a patch for this then.


Thanks,
Joanne

> > >
> > > void fuse_iomap_set_i_blkbits(struct inode *inode, u8 new_blkbits)
> > > {
> > >         trace_fuse_iomap_set_i_blkbits(inode, new_blkbits);
> > >
> > >         if (inode->i_blkbits =3D=3D new_blkbits)
> > >                 return;
> > >
> > >         if (!S_ISREG(inode->i_mode))
> > >                 goto set_it;
> > >
> > >         /*
> > >          * iomap attaches per-block state to each folio, so we cannot=
 allow
> > >          * the file block size to change if there's anything in the p=
age cache.
> > >          * In theory, fuse servers should never be doing this.
> > >          */
> > >         if (inode->i_mapping->nrpages > 0) {
> > >                 WARN_ON(inode->i_blkbits !=3D new_blkbits &&
> > >                         inode->i_mapping->nrpages > 0);
> > >                 return;
> > >         }
> > >
> > > set_it:
> > >         inode->i_blkbits =3D new_blkbits;
> > > }
> > >
> > > https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/=
commit/?h=3Dfuse-iomap-attrs&id=3Dda9b25d994c1140aae2f5ebf10e54d0872f5c884
> > >
> > > --D
> > >
> > > >
> > > > Thanks,
> > > > Joanne
> > > >

