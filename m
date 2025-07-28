Return-Path: <linux-fsdevel+bounces-56189-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62A16B143D8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Jul 2025 23:28:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C3307A2FC3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Jul 2025 21:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 340EB274B5E;
	Mon, 28 Jul 2025 21:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="efkjSl/q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA631A23B1;
	Mon, 28 Jul 2025 21:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753738125; cv=none; b=h5e7Kcws1I+QbCEgZYOMeZ41rS5Q8OWdCuvT9J2niIZY7hqjbyrBM4m04faRI0BC8SPT6FZrd03hY7ktzRSWdeugGK3BmtIhBvo0Bd8agSzeIzrR+RgYEg5r5C0kJ4r5n3H6fJ19sapxKovDbnYQYZjPf4wDYvuNxDlFl+K3858=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753738125; c=relaxed/simple;
	bh=M/aLteMkrNtiwafECTmZoASotlRq1iFLXJsowkn8eCI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YOGGp5fPRLTyCRC7zamF6KAnpsFWBR9ZOD5L3kKtlfGmajtSFrA7z/VAZWSbbcozThu/m2gcLKVfSIVL1v5eWqt205jzQ/tICFcql2AE7brf7GQEvfbGs3dK5t+dsEZpp+r0rFY48fyb7s7FRnjPyVt/iABKpfK43gBmtdLbdcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=efkjSl/q; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4abc0a296f5so65578031cf.0;
        Mon, 28 Jul 2025 14:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753738122; x=1754342922; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZneXYaFQqRFzc5Typc3+x1A+h4NqvmfdYJJXUBl9f5k=;
        b=efkjSl/q5LydX8S4e9g1XqNj7Iq2FgUmtAn73f8Kv7+6jwLtNCN0eXDpsQbWV3pGm/
         85UcijqPxxDr+vKhFvT3GV13fUn7hE49TMXRQJBTlNY2L6sySCV9ME71yr5CBdy1ECJY
         1js9J89IZoc6mrBZ2qhS3mS/oT68Nq0rC+SkRuwQ1dG2EMc+qWmig9GOxkCxlgLoUc08
         otTL+xUTyxImaLlnO4EHQQUNP+I1KbbLq6SkIskZdEyqyEdPL4Rkz28IIQ7GZoc+pgxx
         R3MoNYRBn4F86ZS+SuCxIeemKSLA8bZJVhzS6B3V3HVIJvC3NUp0f/e13tbWhJRmbtsL
         Oh1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753738122; x=1754342922;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZneXYaFQqRFzc5Typc3+x1A+h4NqvmfdYJJXUBl9f5k=;
        b=mosvmH9Yfpiwo5KnZ2aJqx9p1ZTIKDcteQrpQq60lfxvH3gRKFXXCwQgVjOKVu/Vx2
         iQkfQi8zP+ufuU9UuMK9hFoGWDPnkcnmndJfXZhvCeOD8WiesAum8iIriC188niVuYv0
         tAx18WgcIMB0F3Z/wsI7iZXD4Zig8oW+peqwTfqgkgwFS9ZwnaPDicS/9GLkmsTkohwQ
         QMLFqGep2PCjtZTUqQi47KdbEm2wln6NFXgCQu/l1zfiB1Dnstqeq8jNkg/A4czARU8I
         cLL2trHNPxu8mYA4qMyJqHFG830s1GtkVqLi63k+LOHm6gLZk7SLIR8M98XP3UQMlXs0
         yKKQ==
X-Forwarded-Encrypted: i=1; AJvYcCU9vakLK6XWqgLW+rmkzY5Davv/FmbIYLG0UTAmBe+89Xsnd3pq8O3GIsx+NB72WK0KJ43qhJhulDcG@vger.kernel.org, AJvYcCUxEwg+0zXfQaUktdBKOzm8oaaQfVc5qTMt3KXGAhXoVRMps5Uqg7/lKkddaKW8Ad1i8bbuUUXDg+ITMClm@vger.kernel.org, AJvYcCXT+kXT2yfM1qYaHV8oMRxkEVYLf+a8ep2KgjPbP7y7CZqjrBtGLiFIyU/IpYbL+GfHpCCPPgE/He7Q6/nY@vger.kernel.org
X-Gm-Message-State: AOJu0YwIlrdXlIVlvcle+yqO8ekjLYZINWvxzRmYf/RsqvfMGNoGhEEP
	6xeUu0I+WT+H6+f/10vEWoEGBCvwGvU57wnfbADnHV9nutUP3zptS3OWxbg7z8aX3lkjZXmouMa
	So2nMGiTTf/X3HMxve6FAq5WcTOMABM0=
X-Gm-Gg: ASbGncvivsdHMTbtjoLyEhuNu1lmSyL8G+4euIWZ3zlnOT/PYSlDASxHxoynUYLNTuE
	P9HlU+u2AYTfmQkl4h+167T5iHDPOu8SMVfjBMbq8QiSn1k2BfjAiEBK+NraXbxgCpxAeCB17Pv
	ztsmVdQFHEov+OJ6wnexPVjfnA3nnfeGUUrHpAGCrh636fsvFBakz+05mmYojFEZo+UvLAu1bEB
	JY9RUg=
X-Google-Smtp-Source: AGHT+IGpshBgXQ7U+MDDP9pZt9MZQFWNWDud5gzczcYQsSqnHcLkucfw/67HUIu/F7G55XnBhEoxT9W/2r5VX/Q4DKA=
X-Received: by 2002:a05:622a:a30f:b0:4ae:cc2b:77ce with SMTP id
 d75a77b69052e-4aecc2b839bmr18026601cf.60.1753738122289; Mon, 28 Jul 2025
 14:28:42 -0700 (PDT)
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
 <CAJnrk1ZYR=hM5k90H57tOv=fe6F-r8dO+f3wNuCT_w3j8YNYNQ@mail.gmail.com>
 <20250728171425.GR2672029@frogsfrogsfrogs> <CAJnrk1bBesBijYRD1Wf_01OSBykJ0VzwFZKZFev0wPn9wYc98Q@mail.gmail.com>
 <20250728191117.GE2672070@frogsfrogsfrogs>
In-Reply-To: <20250728191117.GE2672070@frogsfrogsfrogs>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Mon, 28 Jul 2025 14:28:31 -0700
X-Gm-Features: Ac12FXwQypfcuflR6PeoeGonrJscLSoGlm7JYS7bzfTRsF2cl4KDjPb0EDDvOeo
Message-ID: <CAJnrk1bTgTcb4aUWqczXEH+7+SWQAdppxYbSAPNCVY6xXb-=hQ@mail.gmail.com>
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

On Mon, Jul 28, 2025 at 12:11=E2=80=AFPM Darrick J. Wong <djwong@kernel.org=
> wrote:
>
> On Mon, Jul 28, 2025 at 10:44:01AM -0700, Joanne Koong wrote:
> > On Mon, Jul 28, 2025 at 10:14=E2=80=AFAM Darrick J. Wong <djwong@kernel=
.org> wrote:
> > >
> > > On Fri, Jul 25, 2025 at 06:16:15PM -0700, Joanne Koong wrote:
> > > > On Thu, Jul 24, 2025 at 12:14=E2=80=AFPM Joanne Koong <joannelkoong=
@gmail.com> wrote:
> > > > >
> > > > > On Wed, Jul 23, 2025 at 3:37=E2=80=AFPM Joanne Koong <joannelkoon=
g@gmail.com> wrote:
> > > > > >
> > > > > > On Wed, Jul 23, 2025 at 2:20=E2=80=AFPM Darrick J. Wong <djwong=
@kernel.org> wrote:
> > > > > > >
> > > > > > > On Wed, Jul 23, 2025 at 11:42:42AM -0700, Joanne Koong wrote:
> > > > > > > > On Wed, Jul 23, 2025 at 7:46=E2=80=AFAM Darrick J. Wong <dj=
wong@kernel.org> wrote:
> > > > > > > > >
> > > > > > > > > [cc Joanne]
> > > > > > > > >
> > > > > > > > > On Wed, Jul 23, 2025 at 05:14:28PM +0530, Naresh Kamboju =
wrote:
> > > > > > > > > > Test regression: next-20250721 arm64 16K and 64K page s=
ize WARNING fs
> > > > > > > > > > fuse file.c at fuse_iomap_writeback_range
> > > > > > > > > >
> > > > > > > > > > Reported-by: Linux Kernel Functional Testing <lkft@lina=
ro.org>
> > > > > > > > > >
> > > > > > > > > > ## Test log
> > > > > > > > > > ------------[ cut here ]------------
> > > > > > > > > > [  343.828105] WARNING: fs/fuse/file.c:2146 at
> > > > > > > > > > fuse_iomap_writeback_range+0x478/0x558 [fuse], CPU#0: m=
sync04/4190
> > > > > > > > >
> > > > > > > > >         WARN_ON_ONCE(len & (PAGE_SIZE - 1));
> > > > > > > > >
> > > > > > > > > /me speculates that this might be triggered by an attempt=
 to write back
> > > > > > > > > some 4k fsblock within a 16/64k base page?
> > > > > > > > >
> > > > > > > >
> > > > > > > > I think this can happen on 4k base pages as well actually. =
On the
> > > > > > > > iomap side, the length passed is always block-aligned and i=
n fuse, we
> > > > > > > > set blkbits to be PAGE_SHIFT so theoretically block-aligned=
 is always
> > > > > > > > page-aligned, but I missed that if it's a "fuseblk" filesys=
tem, that
> > > > > > > > isn't true and the blocksize is initialized to a default si=
ze of 512
> > > > > > > > or whatever block size is passed in when it's mounted.
> > > > > > >
> > > > > > > <nod> I think you're correct.
> > > > > > >
> > > > > > > > I'll send out a patch to remove this line. It doesn't make =
any
> > > > > > > > difference for fuse_iomap_writeback_range() logic whether l=
en is
> > > > > > > > page-aligned or not; I had added it as a sanity-check again=
st sketchy
> > > > > > > > ranges.
> > > > > > > >
> > > > > > > > Also, I just noticed that apparently the blocksize can chan=
ge
> > > > > > > > dynamically for an inode in fuse through getattr replies fr=
om the
> > > > > > > > server (see fuse_change_attributes_common()). This is a pro=
blem since
> > > > > > > > the iomap uses inode->i_blkbits for reading/writing to the =
bitmap. I
> > > > > > > > think we will have to cache the inode blkbits in the iomap_=
folio_state
> > > > > > > > struct unfortunately :( I'll think about this some more and=
 send out a
> > > > > > > > patch for this.
> > > > > > >
> > > > > > > From my understanding of the iomap code, it's possible to do =
that if you
> > > > > > > flush and unmap the entire pagecache (whilst holding i_rwsem =
and
> > > > > > > mmap_invalidate_lock) before you change i_blkbits.  Nobody *d=
oes* this
> > > > > > > so I have no idea if it actually works, however.  Note that e=
ven I don't
> > > > > > > implement the flush and unmap bit; I just scream loudly and d=
o nothing:
> > > > > >
> > > > > > lol! i wish I could scream loudly and do nothing too for my cas=
e.
> > > > > >
> > > > > > AFAICT, I think I just need to flush and unmap that file and ca=
n leave
> > > > > > the rest of the files/folios in the pagecache as is? But then i=
f the
> > > > > > file has active refcounts on it or has been pinned into memory,=
 can I
> > > > > > still unmap and remove it from the page cache? I see the
> > > > > > invalidate_inode_pages2() function but my understanding is that=
 the
> > > > > > page still stays in the cache if it has has active references, =
and if
> > > > > > the page gets mmaped and there's a page fault on it, it'll end =
up
> > > > > > using the preexisting old page in the page cache.
> > > > >
> > > > > Never mind, I was mistaken about this. Johannes confirmed that ev=
en if
> > > > > there's active refcounts on the folio, it'll still get removed fr=
om
> > > > > the page cache after unmapping and the page cache reference will =
get
> > > > > dropped.
> > > > >
> > > > > I think I can just do what you suggested and call
> > > > > filemap_invalidate_inode() in fuse_change_attributes_common() the=
n if
> > > > > the inode blksize gets changed. Thanks for the suggestion!
> > > > >
> > > >
> > > > Thinking about this some more, I don't think this works after all
> > > > because the writeback + page cache removal and inode blkbits update
> > > > needs to be atomic, else after we write back and remove the pages f=
rom
> > > > the page cache, a write could be issued right before we update the
> > > > inode blkbits. I don't think we can hold the inode lock the whole t=
ime
> > > > for it either since writeback could be intensive. (also btw, I
> > > > realized in hindsight that invalidate_inode_pages2_range() would ha=
ve
> > > > been the better function to call instead of
> > > > filemap_invalidate_inode()).
> > > >
> > > > > >
> > > > > > I don't think I really need to have it removed from the page ca=
che so
> > > > > > much as just have the ifs state for all the folios in the file =
freed
> > > > > > (after flushing the file) so that it can start over with a new =
ifs.
> > > > > > Ideally we could just flush the file, then iterate through all =
the
> > > > > > folios in the mapping in order of ascending index, and kfree th=
eir
> > > > > > ->private, but I'm not seeing how we can prevent the case of ne=
w
> > > > > > writes / a new ifs getting allocated for folios at previous ind=
exes
> > > > > > while we're trying to do the iteration/kfreeing.
> > > > > >
> > > >
> > > > Going back to this idea, I think this can work. I realized we don't
> > > > need to flush the file, it's enough to free the ifs, then update th=
e
> > > > inode->i_blkbits, then reallocate the ifs (which will now use the
> > > > updated blkbits size), and if we hold the inode lock throughout, th=
at
> > > > prevents any concurrent writes.
> > > > Something like:
> > > >      inode_lock(inode);
> > > >      XA_STATE(xas, &mapping->i_pages, 0);
> > > >      xa_lock_irq(&mapping->i_pages);
> > > >      xas_for_each_marked(&xas, folio, ULONG_MAX, PAGECACHE_TAG_DIRT=
Y) {
> > > >           folio_lock(folio);
> > > >           if (folio_test_dirty(folio)) {
> > > >                   folio_wait_writeback(folio);
> > > >                   kfree(folio->private);
> > > >           }
>
> Heh, I didn't even see this chunk, distracted as I am today. :/
>
> So this doesn't actually /initiate/ writeback, it just waits
> (potentially for a long time) for someone else to come along and do it.
> That might not be what you want since the blocksize change will appear
> to stall while nothing else is going on in the system.

I thought if the folio isn't under writeback then
folio_wait_writeback() just returns immediately as a no-op.
I don't think we need/want to initiate writeback, I think we only need
to ensure that if it is already under writeback, that writeback
finishes while it uses the old i_blksize so nothing gets corrupted. As
I understand it (but maybe I'm misjudging this), holding the inode
lock and then initiating writeback is too much given that writeback
can take a long time (eg if the fuse server writes the data over some
network).

>
> Also, unless you're going to put this in buffered-io.c, it's not
> desirable for a piece of code to free something it didn't allocate.
> IOWs, I don't think it's a good idea for *fuse* to go messing with a
> folio->private that iomap set.

Okay, good point. I agree. I was hoping to have this not bleed into
the iomap library but maybe there's no getting around that in a good
way.

>
> > > >           folio_unlock(folio);
> > > >      }
> > > >     inode->i_blkbits =3D new_blkbits_size;
> > >
> > > The trouble is, you also have to resize the iomap_folio_state objects
> > > attached to each folio if you change i_blkbits...
> >
> > I think the iomap_folio_state objects automatically get resized here,
> > no? We first kfree the folio->private which kfrees the entire ifs,
>
> Err, right, it does free the ifs and recreate it later if necessary.
>
> > then we change inode->i_blkbits to the new size, then when we call
> > folio_mark_dirty(), it'll create the new ifs which creates a new folio
> > state object using the new/updated i_blkbits size
> >
> > >
> > > >     xas_set(&xas, 0);
> > > >     xas_for_each_marked(&xas, folio, ULONG_MAX, PAGECACHE_TAG_DIRTY=
) {
> > > >           folio_lock(folio);
> > > >           if (folio_test_dirty(folio) && !folio_test_writeback(foli=
o))
> > > >                  folio_mark_dirty(folio);
> > >
> > > ...because iomap_dirty_folio doesn't know how to reallocate the folio
> > > state object in response to i_blkbits having changed.
>
> Also, what about clean folios that have an ifs?  You'd still need to
> handle the ifs's attached to those.

Ah you're right, there could be clean folios there too that have an
ifs. I think in the above logic, if we iterate through all
mapping->i_pages (not just PAGECACHE_TAG_DIRTY marked ones) and move
the kfree to after the "if (folio_test_dirty(folio))" block, then it
addresses that case. eg something like this:

     inode_lock(inode);
     XA_STATE(xas, &mapping->i_pages, 0);
     xa_lock_irq(&mapping->i_pages);
     xas_for_each(&xas, folio, ULONG_MAX) {
          folio_lock(folio);
          if (folio_test_dirty(folio))
                  folio_wait_writeback(folio);
          kfree(folio->private);
          folio_unlock(folio);
     }
    inode->i_blkbits =3D new_blkbits;
    xas_set(&xas, 0);
    xas_for_each_marked(&xas, folio, ULONG_MAX, PAGECACHE_TAG_DIRTY) {
          folio_lock(folio);
          if (folio_test_dirty(folio) && !folio_test_writeback(folio))
                 folio_mark_dirty(folio);
          folio_unlock(folio);
    }
    xa_unlock_irq(&mapping->i_pages);
    inode_unlock(inode);


>
> So I guess if you wanted iomap to handle a blocksize change, you could
> do something like:
>
> iomap_change_file_blocksize(inode, new_blkbits) {
>         inode_lock()
>         filemap_invalidate_lock()
>
>         inode_dio_wait()
>         filemap_write_and_wait()
>         if (new_blkbits > mapping_min_folio_order()) {
>                 truncate_pagecache()
>                 inode->i_blkbits =3D new_blkbits;
>         } else {
>                 inode->i_blkbits =3D new_blkbits;
>                 xas_for_each(...) {
>                         <create new ifs>
>                         <translate uptodate/dirty state to new ifs>
>                         <swap ifs>
>                         <free old ifs>
>                 }
>         }
>
>         filemap_invalidate_unlock()
>         inode_unlock()
> }

Do you prefer this logic to the one above that walks through
&mapping->i_pages? If so, then I'll go with this way.
The part I'm unsure about is that this logic seems more disruptive (eg
initiating writeback while holding the inode lock and doing work for
unmapping/page cache removal) than the other approach, but I guess
this is also rare enough that it doesn't matter much.


Thanks,
Joanne

>
> --D
>
> > > --D
> > >
> > > >           folio_unlock(folio);
> > > >     }
> > > >     xa_unlock_irq(&mapping->i_pages);
> > > >     inode_unlock(inode);
> > > >
> > > >
> > > > I think this is the only approach that doesn't require changes to i=
omap.
> > > >
> > > > I'm going to think about this some more next week and will try to s=
end
> > > > out a patch for this then.
> > > >
> > > >
> > > > Thanks,
> > > > Joanne
> > > >
> > > > > > >
> > > > > > > void fuse_iomap_set_i_blkbits(struct inode *inode, u8 new_blk=
bits)
> > > > > > > {
> > > > > > >         trace_fuse_iomap_set_i_blkbits(inode, new_blkbits);
> > > > > > >
> > > > > > >         if (inode->i_blkbits =3D=3D new_blkbits)
> > > > > > >                 return;
> > > > > > >
> > > > > > >         if (!S_ISREG(inode->i_mode))
> > > > > > >                 goto set_it;
> > > > > > >
> > > > > > >         /*
> > > > > > >          * iomap attaches per-block state to each folio, so w=
e cannot allow
> > > > > > >          * the file block size to change if there's anything =
in the page cache.
> > > > > > >          * In theory, fuse servers should never be doing this=
.
> > > > > > >          */
> > > > > > >         if (inode->i_mapping->nrpages > 0) {
> > > > > > >                 WARN_ON(inode->i_blkbits !=3D new_blkbits &&
> > > > > > >                         inode->i_mapping->nrpages > 0);
> > > > > > >                 return;
> > > > > > >         }
> > > > > > >
> > > > > > > set_it:
> > > > > > >         inode->i_blkbits =3D new_blkbits;
> > > > > > > }
> > > > > > >
> > > > > > > https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-li=
nux.git/commit/?h=3Dfuse-iomap-attrs&id=3Dda9b25d994c1140aae2f5ebf10e54d087=
2f5c884
> > > > > > >
> > > > > > > --D
> > > > > > >
> > > > > > > >
> > > > > > > > Thanks,
> > > > > > > > Joanne
> > > > > > > >
> > > >

