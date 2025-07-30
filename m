Return-Path: <linux-fsdevel+bounces-56364-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F318CB16925
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Jul 2025 00:54:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDFC34E80D8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Jul 2025 22:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE473235048;
	Wed, 30 Jul 2025 22:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LCtpMEMX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B9A61F8BA6;
	Wed, 30 Jul 2025 22:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753916070; cv=none; b=OENtfA7L07EZt/SDeuEQVbcLlMSh71y8WNz/nzVgjsZGNdFNLtVLLWvxsC2z38B9CP4ce3dwZDT4v5vH8TWaR/Gmam+BoUf1BHL68dOYwQTyXchW4+tdmIgRSvKdHynhpn+PrtoswCIs3Jyz18hsmRJKRQZ21QhwR2ZfSqUBoYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753916070; c=relaxed/simple;
	bh=PyQbiQOpQfAQnsQo79jnw5m1Q8Vu67NeZTAEjmFJT2k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MFk5+f+YPXjvzMDpJAkT88uqe0N1Id85MVMDqtWJGkjVAR017Uvb8Z0GSjSYUerRLEFOJi+WGHrFAw+AbJ0kS/aa0bx8RR7Ok0yEj0oZ/3xQxtaOkJkSYUUMBY1k0NMHQDSN5HU/YEPEqT4zkFPSCH0Q9augmryz3LHjIkGJYfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LCtpMEMX; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4ab3802455eso3833071cf.2;
        Wed, 30 Jul 2025 15:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753916067; x=1754520867; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t7x2O+/3mlZ+l6d/dEpYOvhMfX3zDYsyk28CoMvKB+w=;
        b=LCtpMEMXYysWBSwK5IrRXc9ygBJk74A30Cafp0jV0vRiNUqbGzR/hG/HDSqDkO0iVA
         T7cP5UV4ftc7RftYajfGbwpjzZ9HgbWpFv7y20CUIOT/JUfc4pzhT9gE2N46yiMyORRJ
         jMrGmX5CHHRYzMMJscSKyriTO+rL1Ae1bPzgnw2lEkhghOslvs2NzGzL4GJaOfoKU9vi
         c8btrxZcorhGL3wJVcS4ZxKoJyQ9GtFrt3WewCiyMn5Trj0TrFwq3VS3HmaQxI8hUG0L
         wa8pfvAJO/CfYpITu69wwgM2ksWfTPLGpHGde9gDNKyvRH/3HApJ0iIuCzxtVUS1CH4T
         ngAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753916067; x=1754520867;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t7x2O+/3mlZ+l6d/dEpYOvhMfX3zDYsyk28CoMvKB+w=;
        b=VMIeS59WpHAVyZ6dUnmnITilgoQoVBYCwepBLdO0Ka6SMFxd708oBTK+TzbQv34dzu
         PMvZFt6z4Zcng0DPfyQwf4i9yLWC9xPUZnWszAOhpXMWWeI5jtdu6px7qu8LcYrRF5MN
         LiaSCpkRUXcoYPZGqIjt6MLSrNSCu33lVqdc5FwXKYv6q+6UUZ6yNrKD0D+qcPrL9SEV
         IcPdCfjL1uftLjD1foEYhuQcCRgS0BkRMWGdeTNdIZZUoEkbaql70pD/GG0SKcERPkOG
         Om1b7ieAdlX7aSdmX3Dt0DDA134SrcEt/to8cmCysFhQuvp5VALOxniB8jjXYGJoyjlK
         Jbfw==
X-Forwarded-Encrypted: i=1; AJvYcCVUKtxiDn4df0ho50EcBqPlrnyaCwYYmd2gzSO3QUM6hQxPT/gFAsLatTM7cnsqnZq7pSHfJO1uZGj+@vger.kernel.org, AJvYcCVzth0x7FtkXmL2ka+4DMufgPjtRygBSw1VT6WRvL/Cr6sZ2sEI21jILYeGclaMPcSA8Dihiy1S2kj3B1W/@vger.kernel.org, AJvYcCX1qlMhYqDrKfr2FwIHRzPtJ0590YWcNHr0TF+fiwF7+6gtbp5S/gHjSSc8MWU9hfudUnVfKXdVbj8Ar26N@vger.kernel.org
X-Gm-Message-State: AOJu0YyIjBzX0aRhJLZUtvGwCQXcXxlmepMWrNB9uoOgso11lrbH1n3T
	M3jTZrGldOHE1B4YCHXXHaY7d21D09yEL+ELKaT4raaN8IeH0gCnBDOdnfifIJqoxt5JqH34C4Q
	VzWLLp0baP5XGL/LmW38wxiU5c6uxYRI=
X-Gm-Gg: ASbGncu77Mc5RheLaOrJzwNvvXjqy2bF9lOfCCjkQJa4xfFggrWuBD/dwWTLPLWS6JX
	cpwnjpbIvKhfcM1BdbivTnH3vubtenk2ho9y0jO94udXihr7dqZ4bnTN9F2XQo4uxTYskhS1faG
	dMdL7xFkuhL4GK2XBZ1JNiX74eAXNVGsEx41S1pQyliDtEeS7SpEPGmvzMlgp27lNMFQSjEwzyB
	3tbi56pCdf3eQg9gg==
X-Google-Smtp-Source: AGHT+IE3gTZ85BCBwLQ0fCe6kQ6ib21Oo5WSfpehSS1BBczqmefHEgbEcmysVIEVfQKV/+OP8jG24Ai+6x/al/9/eqk=
X-Received: by 2002:ac8:580d:0:b0:4ab:667e:93f1 with SMTP id
 d75a77b69052e-4aedbc4b8aamr92091181cf.48.1753916066703; Wed, 30 Jul 2025
 15:54:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250723212020.GY2672070@frogsfrogsfrogs> <CAJnrk1bFWRTGnpNhW_9MwSYZw3qPnPXZBeiwtPSrMhCvb9C3qg@mail.gmail.com>
 <CAJnrk1byTVJtuOyAyZSVYrusjhA-bW6pxBOQQopgHHbD3cDUHw@mail.gmail.com>
 <CAJnrk1ZYR=hM5k90H57tOv=fe6F-r8dO+f3wNuCT_w3j8YNYNQ@mail.gmail.com>
 <20250728171425.GR2672029@frogsfrogsfrogs> <CAJnrk1bBesBijYRD1Wf_01OSBykJ0VzwFZKZFev0wPn9wYc98Q@mail.gmail.com>
 <20250728191117.GE2672070@frogsfrogsfrogs> <CAJnrk1bTgTcb4aUWqczXEH+7+SWQAdppxYbSAPNCVY6xXb-=hQ@mail.gmail.com>
 <20250729202151.GD2672049@frogsfrogsfrogs> <CAJnrk1ZXN40WEwKXn7ycy2topGTvxFh_UfsM_vwhM+0CtTsJKQ@mail.gmail.com>
 <20250729234018.GW2672029@frogsfrogsfrogs>
In-Reply-To: <20250729234018.GW2672029@frogsfrogsfrogs>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 30 Jul 2025 15:54:15 -0700
X-Gm-Features: Ac12FXzGxWFWHF6oVrKTFLWe0DFHviK4ZwZ4SMKMH5xLKbAvpddy60UsHkq8GcU
Message-ID: <CAJnrk1b691Z3=_V0dU2Vb2qbiQd+0JUMj1ABDMip6vzzGZAf3w@mail.gmail.com>
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

On Tue, Jul 29, 2025 at 4:40=E2=80=AFPM Darrick J. Wong <djwong@kernel.org>=
 wrote:
>
> On Tue, Jul 29, 2025 at 04:23:02PM -0700, Joanne Koong wrote:
> > On Tue, Jul 29, 2025 at 1:21=E2=80=AFPM Darrick J. Wong <djwong@kernel.=
org> wrote:
> > >
> > > On Mon, Jul 28, 2025 at 02:28:31PM -0700, Joanne Koong wrote:
> > > > On Mon, Jul 28, 2025 at 12:11=E2=80=AFPM Darrick J. Wong <djwong@ke=
rnel.org> wrote:
> > > > >
> > > > > On Mon, Jul 28, 2025 at 10:44:01AM -0700, Joanne Koong wrote:
> > > > > > On Mon, Jul 28, 2025 at 10:14=E2=80=AFAM Darrick J. Wong <djwon=
g@kernel.org> wrote:
> > > > > > >
> > > > > > > On Fri, Jul 25, 2025 at 06:16:15PM -0700, Joanne Koong wrote:
> > > > > > > > On Thu, Jul 24, 2025 at 12:14=E2=80=AFPM Joanne Koong <joan=
nelkoong@gmail.com> wrote:
> > > > > > > > >
> > > > > > > > > On Wed, Jul 23, 2025 at 3:37=E2=80=AFPM Joanne Koong <joa=
nnelkoong@gmail.com> wrote:
> > > > > > > > > >
> > > > > > > > > > On Wed, Jul 23, 2025 at 2:20=E2=80=AFPM Darrick J. Wong=
 <djwong@kernel.org> wrote:
> > > > > > > > > > >
> > > > > > > > > > > On Wed, Jul 23, 2025 at 11:42:42AM -0700, Joanne Koon=
g wrote:
> > > > > > > > > > > > On Wed, Jul 23, 2025 at 7:46=E2=80=AFAM Darrick J. =
Wong <djwong@kernel.org> wrote:
> > > > > > > > > > > > >
> > > > > > > > > > > > > [cc Joanne]
> > > > > > > > > > > > >
> > > > > > > > > > > > > On Wed, Jul 23, 2025 at 05:14:28PM +0530, Naresh =
Kamboju wrote:
> > > > > > > > > > > > > > Test regression: next-20250721 arm64 16K and 64=
K page size WARNING fs
> > > > > > > > > > > > > > fuse file.c at fuse_iomap_writeback_range
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > Reported-by: Linux Kernel Functional Testing <l=
kft@linaro.org>
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > ## Test log
> > > > > > > > > > > > > > ------------[ cut here ]------------
> > > > > > > > > > > > > > [  343.828105] WARNING: fs/fuse/file.c:2146 at
> > > > > > > > > > > > > > fuse_iomap_writeback_range+0x478/0x558 [fuse], =
CPU#0: msync04/4190
> > > > > > > > > > > > >
> > > > > > > > > > > > >         WARN_ON_ONCE(len & (PAGE_SIZE - 1));
> > > > > > > > > > > > >
> > > > > > > > > > > > > /me speculates that this might be triggered by an=
 attempt to write back
> > > > > > > > > > > > > some 4k fsblock within a 16/64k base page?
> > > > > > > > > > > > >
> > > > > > > > > > > >
> > > > > > > > > > > > I think this can happen on 4k base pages as well ac=
tually. On the
> > > > > > > > > > > > iomap side, the length passed is always block-align=
ed and in fuse, we
> > > > > > > > > > > > set blkbits to be PAGE_SHIFT so theoretically block=
-aligned is always
> > > > > > > > > > > > page-aligned, but I missed that if it's a "fuseblk"=
 filesystem, that
> > > > > > > > > > > > isn't true and the blocksize is initialized to a de=
fault size of 512
> > > > > > > > > > > > or whatever block size is passed in when it's mount=
ed.
> > > > > > > > > > >
> > > > > > > > > > > <nod> I think you're correct.
> > > > > > > > > > >
> > > > > > > > > > > > I'll send out a patch to remove this line. It doesn=
't make any
> > > > > > > > > > > > difference for fuse_iomap_writeback_range() logic w=
hether len is
> > > > > > > > > > > > page-aligned or not; I had added it as a sanity-che=
ck against sketchy
> > > > > > > > > > > > ranges.
> > > > > > > > > > > >
> > > > > > > > > > > > Also, I just noticed that apparently the blocksize =
can change
> > > > > > > > > > > > dynamically for an inode in fuse through getattr re=
plies from the
> > > > > > > > > > > > server (see fuse_change_attributes_common()). This =
is a problem since
> > > > > > > > > > > > the iomap uses inode->i_blkbits for reading/writing=
 to the bitmap. I
> > > > > > > > > > > > think we will have to cache the inode blkbits in th=
e iomap_folio_state
> > > > > > > > > > > > struct unfortunately :( I'll think about this some =
more and send out a
> > > > > > > > > > > > patch for this.
> > > > > > > > > > >
> > > > > > > > > > > From my understanding of the iomap code, it's possibl=
e to do that if you
> > > > > > > > > > > flush and unmap the entire pagecache (whilst holding =
i_rwsem and
> > > > > > > > > > > mmap_invalidate_lock) before you change i_blkbits.  N=
obody *does* this
> > > > > > > > > > > so I have no idea if it actually works, however.  Not=
e that even I don't
> > > > > > > > > > > implement the flush and unmap bit; I just scream loud=
ly and do nothing:
> > > > > > > > > >
> > > > > > > > > > lol! i wish I could scream loudly and do nothing too fo=
r my case.
> > > > > > > > > >
> > > > > > > > > > AFAICT, I think I just need to flush and unmap that fil=
e and can leave
> > > > > > > > > > the rest of the files/folios in the pagecache as is? Bu=
t then if the
> > > > > > > > > > file has active refcounts on it or has been pinned into=
 memory, can I
> > > > > > > > > > still unmap and remove it from the page cache? I see th=
e
> > > > > > > > > > invalidate_inode_pages2() function but my understanding=
 is that the
> > > > > > > > > > page still stays in the cache if it has has active refe=
rences, and if
> > > > > > > > > > the page gets mmaped and there's a page fault on it, it=
'll end up
> > > > > > > > > > using the preexisting old page in the page cache.
> > > > > > > > >
> > > > > > > > > Never mind, I was mistaken about this. Johannes confirmed=
 that even if
> > > > > > > > > there's active refcounts on the folio, it'll still get re=
moved from
> > > > > > > > > the page cache after unmapping and the page cache referen=
ce will get
> > > > > > > > > dropped.
> > > > > > > > >
> > > > > > > > > I think I can just do what you suggested and call
> > > > > > > > > filemap_invalidate_inode() in fuse_change_attributes_comm=
on() then if
> > > > > > > > > the inode blksize gets changed. Thanks for the suggestion=
!
> > > > > > > > >
> > > > > > > >
> > > > > > > > Thinking about this some more, I don't think this works aft=
er all
> > > > > > > > because the writeback + page cache removal and inode blkbit=
s update
> > > > > > > > needs to be atomic, else after we write back and remove the=
 pages from
> > > > > > > > the page cache, a write could be issued right before we upd=
ate the
> > > > > > > > inode blkbits. I don't think we can hold the inode lock the=
 whole time
> > > > > > > > for it either since writeback could be intensive. (also btw=
, I
> > > > > > > > realized in hindsight that invalidate_inode_pages2_range() =
would have
> > > > > > > > been the better function to call instead of
> > > > > > > > filemap_invalidate_inode()).
> > > > > > > >
> > > > > > > > > >
> > > > > > > > > > I don't think I really need to have it removed from the=
 page cache so
> > > > > > > > > > much as just have the ifs state for all the folios in t=
he file freed
> > > > > > > > > > (after flushing the file) so that it can start over wit=
h a new ifs.
> > > > > > > > > > Ideally we could just flush the file, then iterate thro=
ugh all the
> > > > > > > > > > folios in the mapping in order of ascending index, and =
kfree their
> > > > > > > > > > ->private, but I'm not seeing how we can prevent the ca=
se of new
> > > > > > > > > > writes / a new ifs getting allocated for folios at prev=
ious indexes
> > > > > > > > > > while we're trying to do the iteration/kfreeing.
> > > > > > > > > >
> > > > > > > >
> > > > > > > > Going back to this idea, I think this can work. I realized =
we don't
> > > > > > > > need to flush the file, it's enough to free the ifs, then u=
pdate the
> > > > > > > > inode->i_blkbits, then reallocate the ifs (which will now u=
se the
> > > > > > > > updated blkbits size), and if we hold the inode lock throug=
hout, that
> > > > > > > > prevents any concurrent writes.
> > > > > > > > Something like:
> > > > > > > >      inode_lock(inode);
> > > > > > > >      XA_STATE(xas, &mapping->i_pages, 0);
> > > > > > > >      xa_lock_irq(&mapping->i_pages);
> > > > > > > >      xas_for_each_marked(&xas, folio, ULONG_MAX, PAGECACHE_=
TAG_DIRTY) {
> > > > > > > >           folio_lock(folio);
> > > > > > > >           if (folio_test_dirty(folio)) {
> > > > > > > >                   folio_wait_writeback(folio);
> > > > > > > >                   kfree(folio->private);
> > > > > > > >           }
> > > > >
> > > > > Heh, I didn't even see this chunk, distracted as I am today. :/
> > > > >
> > > > > So this doesn't actually /initiate/ writeback, it just waits
> > > > > (potentially for a long time) for someone else to come along and =
do it.
> > > > > That might not be what you want since the blocksize change will a=
ppear
> > > > > to stall while nothing else is going on in the system.
> > > >
> > > > I thought if the folio isn't under writeback then
> > > > folio_wait_writeback() just returns immediately as a no-op.
> > > > I don't think we need/want to initiate writeback, I think we only n=
eed
> > > > to ensure that if it is already under writeback, that writeback
> > > > finishes while it uses the old i_blksize so nothing gets corrupted.=
 As
> > > > I understand it (but maybe I'm misjudging this), holding the inode
> > > > lock and then initiating writeback is too much given that writeback
> > > > can take a long time (eg if the fuse server writes the data over so=
me
> > > > network).
> > > >
> > > > >
> > > > > Also, unless you're going to put this in buffered-io.c, it's not
> > > > > desirable for a piece of code to free something it didn't allocat=
e.
> > > > > IOWs, I don't think it's a good idea for *fuse* to go messing wit=
h a
> > > > > folio->private that iomap set.
> > > >
> > > > Okay, good point. I agree. I was hoping to have this not bleed into
> > > > the iomap library but maybe there's no getting around that in a goo=
d
> > > > way.
> > >
> > > <shrug> Any other filesystem that has mutable file block size is goin=
g
> > > to need something to enact a change.
> > >
> > > > >
> > > > > > > >           folio_unlock(folio);
> > > > > > > >      }
> > > > > > > >     inode->i_blkbits =3D new_blkbits_size;
> > > > > > >
> > > > > > > The trouble is, you also have to resize the iomap_folio_state=
 objects
> > > > > > > attached to each folio if you change i_blkbits...
> > > > > >
> > > > > > I think the iomap_folio_state objects automatically get resized=
 here,
> > > > > > no? We first kfree the folio->private which kfrees the entire i=
fs,
> > > > >
> > > > > Err, right, it does free the ifs and recreate it later if necessa=
ry.
> > > > >
> > > > > > then we change inode->i_blkbits to the new size, then when we c=
all
> > > > > > folio_mark_dirty(), it'll create the new ifs which creates a ne=
w folio
> > > > > > state object using the new/updated i_blkbits size
> > > > > >
> > > > > > >
> > > > > > > >     xas_set(&xas, 0);
> > > > > > > >     xas_for_each_marked(&xas, folio, ULONG_MAX, PAGECACHE_T=
AG_DIRTY) {
> > > > > > > >           folio_lock(folio);
> > > > > > > >           if (folio_test_dirty(folio) && !folio_test_writeb=
ack(folio))
> > > > > > > >                  folio_mark_dirty(folio);
> > > > > > >
> > > > > > > ...because iomap_dirty_folio doesn't know how to reallocate t=
he folio
> > > > > > > state object in response to i_blkbits having changed.
> > > > >
> > > > > Also, what about clean folios that have an ifs?  You'd still need=
 to
> > > > > handle the ifs's attached to those.
> > > >
> > > > Ah you're right, there could be clean folios there too that have an
> > > > ifs. I think in the above logic, if we iterate through all
> > > > mapping->i_pages (not just PAGECACHE_TAG_DIRTY marked ones) and mov=
e
> > > > the kfree to after the "if (folio_test_dirty(folio))" block, then i=
t
> > > > addresses that case. eg something like this:
> > > >
> > > >      inode_lock(inode);
> > > >      XA_STATE(xas, &mapping->i_pages, 0);
> > > >      xa_lock_irq(&mapping->i_pages);
> > > >      xas_for_each(&xas, folio, ULONG_MAX) {
> > > >           folio_lock(folio);
> > > >           if (folio_test_dirty(folio))
> > > >                   folio_wait_writeback(folio);
> > > >           kfree(folio->private);
> > > >           folio_unlock(folio);
> > > >      }
> > > >     inode->i_blkbits =3D new_blkbits;
> > > >     xas_set(&xas, 0);
> > > >     xas_for_each_marked(&xas, folio, ULONG_MAX, PAGECACHE_TAG_DIRTY=
) {
> > > >           folio_lock(folio);
> > > >           if (folio_test_dirty(folio) && !folio_test_writeback(foli=
o))
> > > >                  folio_mark_dirty(folio);
> > > >           folio_unlock(folio);
> > > >     }
> > > >     xa_unlock_irq(&mapping->i_pages);
> > > >     inode_unlock(inode);
> > > >
> > > >
> > > > >
> > > > > So I guess if you wanted iomap to handle a blocksize change, you =
could
> > > > > do something like:
> > > > >
> > > > > iomap_change_file_blocksize(inode, new_blkbits) {
> > > > >         inode_lock()
> > > > >         filemap_invalidate_lock()
> > > > >
> > > > >         inode_dio_wait()
> > > > >         filemap_write_and_wait()
> > > > >         if (new_blkbits > mapping_min_folio_order()) {
> > > > >                 truncate_pagecache()
> > > > >                 inode->i_blkbits =3D new_blkbits;
> > > > >         } else {
> > > > >                 inode->i_blkbits =3D new_blkbits;
> > > > >                 xas_for_each(...) {
> > > > >                         <create new ifs>
> > > > >                         <translate uptodate/dirty state to new if=
s>
> > > > >                         <swap ifs>
> > > > >                         <free old ifs>
> > > > >                 }
> > > > >         }
> > > > >
> > > > >         filemap_invalidate_unlock()
> > > > >         inode_unlock()
> > > > > }
> > > >
> > > > Do you prefer this logic to the one above that walks through
> > > > &mapping->i_pages? If so, then I'll go with this way.
> > >
> > > Yes.  iomap should not be tightly bound to the pagecache's xarray; I
> > > don't even really like the xas_for_each that I suggested above.
> >
> > Okay, sounds good.
> >
> > >
> > > > The part I'm unsure about is that this logic seems more disruptive =
(eg
> > > > initiating writeback while holding the inode lock and doing work fo=
r
> > > > unmapping/page cache removal) than the other approach, but I guess
> > > > this is also rare enough that it doesn't matter much.
> > >
> > > I hope it's rare enough that doing truncate_pagecache unconditionally
> > > won't be seen as a huge burden.
> > >
> > > iomap_change_file_blocksize(inode, new_blkbits) {
> > >         inode_dio_wait()
> > >         filemap_write_and_wait()
> > >         truncate_pagecache()
> > >
> > >         inode->i_blkbits =3D new_blkbits;
> > > }
> > >
> > > fuse_file_change_blocksize(inode, new_blkbits) {
> > >         inode_lock()
> > >         filemap_invalidate_lock()
> > >
> > >         iomap_change_file_blocksize(inode, new_blkbits);
> > >
> > >         filemap_invalidate_unlock()
> > >         inode_unlock()
> > > }
> > >
> > > Though my question remains -- is there a fuse filesystem that changes
> > > the blocksize at runtime such that we can test this??
> >
> > There's not one currently but I was planning to hack up the libfuse
> > passthrough_hp server to test the change.
>
> Heh, ok.
>
> I guess I could also hack up fuse2fs to change its own blocksize
> randomly to see how many programs that pisses off. :)
>
> (Not right now though, gotta prepare for fossy tomorrow...)
>

What I've been using as a helpful sanity-check so far has been running
fstests generic/750 after adding this line to libfuse:

+++ b/lib/fuse_lowlevel.c
@@ -547,6 +547,8 @@ int fuse_reply_attr(fuse_req_t req, const struct stat *=
attr,
        arg.attr_valid_nsec =3D calc_timeout_nsec(attr_timeout);
        convert_stat(attr, &arg.attr);
+       arg.attr.blksize =3D 4096;
        return send_reply_ok(req, &arg, size);

and modifying the kernel side logic in fuse_change_attributes_common()
to unconditionally execute the page cache removal logic if
attr->blksize !=3D 0.


While running this however, I discovered another problem :/ we can't
grab the inode lock here in the fuse path because the vfs layer that
calls into this logic may already be holding the inode lock (eg the
stack traces I was seeing included path_openat()  ->
inode_permission() -> fuse_permission() which then fetches the
blksize, and the vfs rename path), while there are other call paths
that may not be holding the lock already.

I don't really see a good solution here. The simplest one imo would be
to cache "u8 blkbits" in the iomap_folio_state struct - are you okay
with that or do you think there's a better solution here?


Thanks,
Joanne

> --D
>
> > >
> > > --D
> > >
> > > > Thanks,
> > > > Joanne
> > > >
> > > > >
> > > > > --D
> > > > >
> > > > > > > --D
> > > > > > >
> > > > > > > >           folio_unlock(folio);
> > > > > > > >     }
> > > > > > > >     xa_unlock_irq(&mapping->i_pages);
> > > > > > > >     inode_unlock(inode);
> > > > > > > >
> > > > > > > >
> > > > > > > > I think this is the only approach that doesn't require chan=
ges to iomap.
> > > > > > > >
> > > > > > > > I'm going to think about this some more next week and will =
try to send
> > > > > > > > out a patch for this then.
> > > > > > > >
> > > > > > > >
> > > > > > > > Thanks,
> > > > > > > > Joanne
> > > > > > > >
> > > > > > > > > > >
> > > > > > > > > > > void fuse_iomap_set_i_blkbits(struct inode *inode, u8=
 new_blkbits)
> > > > > > > > > > > {
> > > > > > > > > > >         trace_fuse_iomap_set_i_blkbits(inode, new_blk=
bits);
> > > > > > > > > > >
> > > > > > > > > > >         if (inode->i_blkbits =3D=3D new_blkbits)
> > > > > > > > > > >                 return;
> > > > > > > > > > >
> > > > > > > > > > >         if (!S_ISREG(inode->i_mode))
> > > > > > > > > > >                 goto set_it;
> > > > > > > > > > >
> > > > > > > > > > >         /*
> > > > > > > > > > >          * iomap attaches per-block state to each fol=
io, so we cannot allow
> > > > > > > > > > >          * the file block size to change if there's a=
nything in the page cache.
> > > > > > > > > > >          * In theory, fuse servers should never be do=
ing this.
> > > > > > > > > > >          */
> > > > > > > > > > >         if (inode->i_mapping->nrpages > 0) {
> > > > > > > > > > >                 WARN_ON(inode->i_blkbits !=3D new_blk=
bits &&
> > > > > > > > > > >                         inode->i_mapping->nrpages > 0=
);
> > > > > > > > > > >                 return;
> > > > > > > > > > >         }
> > > > > > > > > > >
> > > > > > > > > > > set_it:
> > > > > > > > > > >         inode->i_blkbits =3D new_blkbits;
> > > > > > > > > > > }
> > > > > > > > > > >
> > > > > > > > > > > https://git.kernel.org/pub/scm/linux/kernel/git/djwon=
g/xfs-linux.git/commit/?h=3Dfuse-iomap-attrs&id=3Dda9b25d994c1140aae2f5ebf1=
0e54d0872f5c884
> > > > > > > > > > >
> > > > > > > > > > > --D
> > > > > > > > > > >
> > > > > > > > > > > >
> > > > > > > > > > > > Thanks,
> > > > > > > > > > > > Joanne
> > > > > > > > > > > >
> > > > > > > >
> > > >
> >

