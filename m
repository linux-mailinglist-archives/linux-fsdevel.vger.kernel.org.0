Return-Path: <linux-fsdevel+bounces-56150-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E33D6B14154
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Jul 2025 19:44:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56C6D1894D28
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Jul 2025 17:44:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15432275AE9;
	Mon, 28 Jul 2025 17:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k03IEOti"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB0C42741CB;
	Mon, 28 Jul 2025 17:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753724657; cv=none; b=jU5cBFqe6sxw/OaXMTe/stoYfDOmijc8EBIBpTOdy7hbsbLkuzN0bI+exnBFbKCPtFcyHSI2wvjHR50F+ymHOI/1uInk3jcTBuFhl3WtsIT1GmUJt4bfDFyt910W3A5VnDKz9a6z2qKxgcgujJkD0fK22ln115n8YPnd9w/aQm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753724657; c=relaxed/simple;
	bh=myGplgNPnuSBD9zdlw6Nm6KJEWtu9mFVbOvE5vk4288=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W0A55z9BR7EE38DoQq3mpmArnu1T5Iw2L38uK9jQ947htFBybY0YC3JclGPjuyF8w9W38DJHK0jNlZA3zKmpYsxpBqg4jHpinffexeHDNO9CkX/Tkdc3qY4GixUmqqL3idHCwkSgdSomPgwCgCaeygawwy5mPNKpS/DSNOOQdy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k03IEOti; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4ab8403b6daso50360571cf.2;
        Mon, 28 Jul 2025 10:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753724653; x=1754329453; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WaNs6TAtiLS9Zn84sgyHz2QFRjPypF9PY+lV+Xzno3c=;
        b=k03IEOtibm6YenDXjEJEH5/CFeaw6M0iKpr22wzhITiFqdoqIAJSc1mfix9spj/D3E
         CfNHHhjUinYIv4i5q8TSIuaL5m+BZZA/6ZPmgZT7GTT7AX40Lw1w0sHMq1hYQt1caxGb
         t9RJOeRnhW80D4ofdZcMZLmVvU0e5DLOmoDn2DjKeIRv3OcH3W98qAR1ahxJ2jsP7lxj
         mbSqdOw+EiTv2vBe3vwGysH8kZtT1CBbUpnV5WM1QPwNqz13BgcOZyGYqTzidoUlKzur
         INmpo4J1B+44L1xurpRsNRuweYdloVE5pjERdGCYybGQcs+BG4cZl4Dxajg5xU0yHvRd
         Nw5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753724653; x=1754329453;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WaNs6TAtiLS9Zn84sgyHz2QFRjPypF9PY+lV+Xzno3c=;
        b=OGmPFFXIq7RKA4CLSQjNtC46i5F9uIU+tCmjKUiE4PnXUDvSSyauo+Cnt6bymXYlf6
         ZgTpErGwG5mCX/9vBO5oPzt3Bs53d87H6cK5fBtHmPzX119swbnzCy4W+VaIw+0nH+30
         fp1q55Tn6c581TMl7yd/OpiHKq20m0j1QWVpxsndaV3F0vxIWn0JavMn/z24QxX1A9FV
         VEc/qByAQeigMmOlissNRXez/iuDSwJtsQN7FyO50KvMCGF4FZVMqPbVS4dcw4bUnats
         2eTXDiDxgU3D/7UzrSrHmAr3fIlXabo0jpxy7BAdcTpzO2raIEk6PY4MUgtC0d9Zqdvs
         0v0Q==
X-Forwarded-Encrypted: i=1; AJvYcCVwG9hijFoCeA3QNZY9ybx5SwlMIFie9n/gqvUIwWzF20KVYA4U+t4aFR8H7joYIgQw10Hh8CQGRAoZ8lbh@vger.kernel.org, AJvYcCW011cnfqPlSd9sQXIsFi+Dl/m07cdSV8qcYaXycQtbU9FegHIWQovse7KFJjWYS6XLWUgd/nfj1NZ6@vger.kernel.org, AJvYcCXFQ84cVUodsBw4TwYy23vfaYHMaSUUVAPEMQFxP1VI5IkH7vN7MNIaf8wVtqKsU45y75Ka/V+0ZUyOVkTC@vger.kernel.org
X-Gm-Message-State: AOJu0YyC8xz5VDc+IWacZv3K5vQ9c/lugQoXO1nyg1f88FiOGWPiWCzw
	jlx8rjeF0BRhszNjOIiFcWhQcWq1UJvCx8VVOktEDZlmJF0nhneWS4C4Rix6UIJ7vSDm11XXP96
	A7mH4L/FNzdlkvIF5ZCP9DiH3xnccZ+k=
X-Gm-Gg: ASbGncuNazCKbwR4zvogWqGVlpEVuszR5TlJw0bM1HnIYBZHvxBg3zEpJYDwyY6NE96
	Q257NmBRc0iOS+dMI19Sf07q+ztp5efnO66H5SuzPswjy5bqjJ0fNQrYDOYI58Gsk78/pKrmDZm
	H1PrZtSQcJzpUD7Drhv61Db2J8PtUKQ0Y4nkkX9ZzgYgtOb/JXWxv8807LoLB/iC4CtCDyCfZFh
	mKMkbgrKHPCKo8V0Q==
X-Google-Smtp-Source: AGHT+IGte50fwChvEi9kJQNzD68kbG1EMNvci8he6MVBVKPQmFhf/9CW//FXjrAlW6QX8pLJYLCknnZzhpsStOhCE6k=
X-Received: by 2002:ac8:5a44:0:b0:4ab:6c75:620 with SMTP id
 d75a77b69052e-4ae8ef62b14mr151522531cf.1.1753724652975; Mon, 28 Jul 2025
 10:44:12 -0700 (PDT)
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
 <CAJnrk1ZYR=hM5k90H57tOv=fe6F-r8dO+f3wNuCT_w3j8YNYNQ@mail.gmail.com> <20250728171425.GR2672029@frogsfrogsfrogs>
In-Reply-To: <20250728171425.GR2672029@frogsfrogsfrogs>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Mon, 28 Jul 2025 10:44:01 -0700
X-Gm-Features: Ac12FXwC8Bb-k9tFwYfIA8TgFEpNMPte-Anh_9X52L95AlRm8wPx7oIuVouRTN8
Message-ID: <CAJnrk1bBesBijYRD1Wf_01OSBykJ0VzwFZKZFev0wPn9wYc98Q@mail.gmail.com>
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

On Mon, Jul 28, 2025 at 10:14=E2=80=AFAM Darrick J. Wong <djwong@kernel.org=
> wrote:
>
> On Fri, Jul 25, 2025 at 06:16:15PM -0700, Joanne Koong wrote:
> > On Thu, Jul 24, 2025 at 12:14=E2=80=AFPM Joanne Koong <joannelkoong@gma=
il.com> wrote:
> > >
> > > On Wed, Jul 23, 2025 at 3:37=E2=80=AFPM Joanne Koong <joannelkoong@gm=
ail.com> wrote:
> > > >
> > > > On Wed, Jul 23, 2025 at 2:20=E2=80=AFPM Darrick J. Wong <djwong@ker=
nel.org> wrote:
> > > > >
> > > > > On Wed, Jul 23, 2025 at 11:42:42AM -0700, Joanne Koong wrote:
> > > > > > On Wed, Jul 23, 2025 at 7:46=E2=80=AFAM Darrick J. Wong <djwong=
@kernel.org> wrote:
> > > > > > >
> > > > > > > [cc Joanne]
> > > > > > >
> > > > > > > On Wed, Jul 23, 2025 at 05:14:28PM +0530, Naresh Kamboju wrot=
e:
> > > > > > > > Regressions found while running LTP msync04 tests on qemu-a=
rm64 running
> > > > > > > > Linux next-20250721, next-20250722 and next-20250723 with 1=
6K and 64K
> > > > > > > > page size enabled builds.
> > > > > > > >
> > > > > > > > CONFIG_ARM64_64K_PAGES=3Dy ( kernel warning as below )
> > > > > > > > CONFIG_ARM64_16K_PAGES=3Dy ( kernel warning as below )
> > > > > > > >
> > > > > > > > No warning noticed with 4K page size.
> > > > > > > > CONFIG_ARM64_4K_PAGES=3Dy works as expected
> > > > > > >
> > > > > > > You might want to cc Joanne since she's been working on large=
 folio
> > > > > > > support in fuse.
> > > > > > >
> > > > > > > > First seen on the tag next-20250721.
> > > > > > > > Good: next-20250718
> > > > > > > > Bad:  next-20250721 to next-20250723
> > > > > >
> > > > > > Thanks for the report. Is there a link to the script that mount=
s the
> > > > > > fuse server for these tests? I'm curious whether this was mount=
ed as a
> > > > > > fuseblk filesystem.
> > > > > >
> > > > > > > >
> > > > > > > > Regression Analysis:
> > > > > > > > - New regression? Yes
> > > > > > > > - Reproducibility? Yes
> > > > > > > >
> > > > > > > > Test regression: next-20250721 arm64 16K and 64K page size =
WARNING fs
> > > > > > > > fuse file.c at fuse_iomap_writeback_range
> > > > > > > >
> > > > > > > > Reported-by: Linux Kernel Functional Testing <lkft@linaro.o=
rg>
> > > > > > > >
> > > > > > > > ## Test log
> > > > > > > > ------------[ cut here ]------------
> > > > > > > > [  343.828105] WARNING: fs/fuse/file.c:2146 at
> > > > > > > > fuse_iomap_writeback_range+0x478/0x558 [fuse], CPU#0: msync=
04/4190
> > > > > > >
> > > > > > >         WARN_ON_ONCE(len & (PAGE_SIZE - 1));
> > > > > > >
> > > > > > > /me speculates that this might be triggered by an attempt to =
write back
> > > > > > > some 4k fsblock within a 16/64k base page?
> > > > > > >
> > > > > >
> > > > > > I think this can happen on 4k base pages as well actually. On t=
he
> > > > > > iomap side, the length passed is always block-aligned and in fu=
se, we
> > > > > > set blkbits to be PAGE_SHIFT so theoretically block-aligned is =
always
> > > > > > page-aligned, but I missed that if it's a "fuseblk" filesystem,=
 that
> > > > > > isn't true and the blocksize is initialized to a default size o=
f 512
> > > > > > or whatever block size is passed in when it's mounted.
> > > > >
> > > > > <nod> I think you're correct.
> > > > >
> > > > > > I'll send out a patch to remove this line. It doesn't make any
> > > > > > difference for fuse_iomap_writeback_range() logic whether len i=
s
> > > > > > page-aligned or not; I had added it as a sanity-check against s=
ketchy
> > > > > > ranges.
> > > > > >
> > > > > > Also, I just noticed that apparently the blocksize can change
> > > > > > dynamically for an inode in fuse through getattr replies from t=
he
> > > > > > server (see fuse_change_attributes_common()). This is a problem=
 since
> > > > > > the iomap uses inode->i_blkbits for reading/writing to the bitm=
ap. I
> > > > > > think we will have to cache the inode blkbits in the iomap_foli=
o_state
> > > > > > struct unfortunately :( I'll think about this some more and sen=
d out a
> > > > > > patch for this.
> > > > >
> > > > > From my understanding of the iomap code, it's possible to do that=
 if you
> > > > > flush and unmap the entire pagecache (whilst holding i_rwsem and
> > > > > mmap_invalidate_lock) before you change i_blkbits.  Nobody *does*=
 this
> > > > > so I have no idea if it actually works, however.  Note that even =
I don't
> > > > > implement the flush and unmap bit; I just scream loudly and do no=
thing:
> > > >
> > > > lol! i wish I could scream loudly and do nothing too for my case.
> > > >
> > > > AFAICT, I think I just need to flush and unmap that file and can le=
ave
> > > > the rest of the files/folios in the pagecache as is? But then if th=
e
> > > > file has active refcounts on it or has been pinned into memory, can=
 I
> > > > still unmap and remove it from the page cache? I see the
> > > > invalidate_inode_pages2() function but my understanding is that the
> > > > page still stays in the cache if it has has active references, and =
if
> > > > the page gets mmaped and there's a page fault on it, it'll end up
> > > > using the preexisting old page in the page cache.
> > >
> > > Never mind, I was mistaken about this. Johannes confirmed that even i=
f
> > > there's active refcounts on the folio, it'll still get removed from
> > > the page cache after unmapping and the page cache reference will get
> > > dropped.
> > >
> > > I think I can just do what you suggested and call
> > > filemap_invalidate_inode() in fuse_change_attributes_common() then if
> > > the inode blksize gets changed. Thanks for the suggestion!
> > >
> >
> > Thinking about this some more, I don't think this works after all
> > because the writeback + page cache removal and inode blkbits update
> > needs to be atomic, else after we write back and remove the pages from
> > the page cache, a write could be issued right before we update the
> > inode blkbits. I don't think we can hold the inode lock the whole time
> > for it either since writeback could be intensive. (also btw, I
> > realized in hindsight that invalidate_inode_pages2_range() would have
> > been the better function to call instead of
> > filemap_invalidate_inode()).
> >
> > > >
> > > > I don't think I really need to have it removed from the page cache =
so
> > > > much as just have the ifs state for all the folios in the file free=
d
> > > > (after flushing the file) so that it can start over with a new ifs.
> > > > Ideally we could just flush the file, then iterate through all the
> > > > folios in the mapping in order of ascending index, and kfree their
> > > > ->private, but I'm not seeing how we can prevent the case of new
> > > > writes / a new ifs getting allocated for folios at previous indexes
> > > > while we're trying to do the iteration/kfreeing.
> > > >
> >
> > Going back to this idea, I think this can work. I realized we don't
> > need to flush the file, it's enough to free the ifs, then update the
> > inode->i_blkbits, then reallocate the ifs (which will now use the
> > updated blkbits size), and if we hold the inode lock throughout, that
> > prevents any concurrent writes.
> > Something like:
> >      inode_lock(inode);
> >      XA_STATE(xas, &mapping->i_pages, 0);
> >      xa_lock_irq(&mapping->i_pages);
> >      xas_for_each_marked(&xas, folio, ULONG_MAX, PAGECACHE_TAG_DIRTY) {
> >           folio_lock(folio);
> >           if (folio_test_dirty(folio)) {
> >                   folio_wait_writeback(folio);
> >                   kfree(folio->private);
> >           }
> >           folio_unlock(folio);
> >      }
> >     inode->i_blkbits =3D new_blkbits_size;
>
> The trouble is, you also have to resize the iomap_folio_state objects
> attached to each folio if you change i_blkbits...

I think the iomap_folio_state objects automatically get resized here,
no? We first kfree the folio->private which kfrees the entire ifs,
then we change inode->i_blkbits to the new size, then when we call
folio_mark_dirty(), it'll create the new ifs which creates a new folio
state object using the new/updated i_blkbits size

>
> >     xas_set(&xas, 0);
> >     xas_for_each_marked(&xas, folio, ULONG_MAX, PAGECACHE_TAG_DIRTY) {
> >           folio_lock(folio);
> >           if (folio_test_dirty(folio) && !folio_test_writeback(folio))
> >                  folio_mark_dirty(folio);
>
> ...because iomap_dirty_folio doesn't know how to reallocate the folio
> state object in response to i_blkbits having changed.
>
> --D
>
> >           folio_unlock(folio);
> >     }
> >     xa_unlock_irq(&mapping->i_pages);
> >     inode_unlock(inode);
> >
> >
> > I think this is the only approach that doesn't require changes to iomap=
.
> >
> > I'm going to think about this some more next week and will try to send
> > out a patch for this then.
> >
> >
> > Thanks,
> > Joanne
> >
> > > > >
> > > > > void fuse_iomap_set_i_blkbits(struct inode *inode, u8 new_blkbits=
)
> > > > > {
> > > > >         trace_fuse_iomap_set_i_blkbits(inode, new_blkbits);
> > > > >
> > > > >         if (inode->i_blkbits =3D=3D new_blkbits)
> > > > >                 return;
> > > > >
> > > > >         if (!S_ISREG(inode->i_mode))
> > > > >                 goto set_it;
> > > > >
> > > > >         /*
> > > > >          * iomap attaches per-block state to each folio, so we ca=
nnot allow
> > > > >          * the file block size to change if there's anything in t=
he page cache.
> > > > >          * In theory, fuse servers should never be doing this.
> > > > >          */
> > > > >         if (inode->i_mapping->nrpages > 0) {
> > > > >                 WARN_ON(inode->i_blkbits !=3D new_blkbits &&
> > > > >                         inode->i_mapping->nrpages > 0);
> > > > >                 return;
> > > > >         }
> > > > >
> > > > > set_it:
> > > > >         inode->i_blkbits =3D new_blkbits;
> > > > > }
> > > > >
> > > > > https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.=
git/commit/?h=3Dfuse-iomap-attrs&id=3Dda9b25d994c1140aae2f5ebf10e54d0872f5c=
884
> > > > >
> > > > > --D
> > > > >
> > > > > >
> > > > > > Thanks,
> > > > > > Joanne
> > > > > >
> >

