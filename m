Return-Path: <linux-fsdevel+bounces-56294-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 895B4B155E9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Jul 2025 01:23:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4D213A9ABF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Jul 2025 23:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6669328643C;
	Tue, 29 Jul 2025 23:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uy7teFOC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF763242928;
	Tue, 29 Jul 2025 23:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753831396; cv=none; b=f9pdO/AlCiVO5RC/53NoiFyissd53vZ5TzxVcFCn6pEQ9ZRzo365fNMfUvxhgVRQw0Shz9O93yuBw8AXspb/0U2VEhudxV8DQXy1Iprd43US4F9UTQlUrraePEj8VcZk0Wr3CHfidDKxy/ia7I7OtPgIo9ODScfDkpo5SUHsx9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753831396; c=relaxed/simple;
	bh=4RTGUumNKOAZA/D5SGTs46kzKJKTDRA5GCcFHPFC+nA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TZV4tqE/R8d+hnT776MgH89UfeIGo+ZYflt88b0Jo2I7v/D1K5njzeszq/w4Y4x18hVPNhCL2sP2V7CGH/f9YhMmskEGW2wWsOgO4CWGvf5xnf4k7WiNemkGtarHKtznlGF0KgIQIX5Mcz9IhvT53Q5h8rA2mza9iV8u+bYgkjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uy7teFOC; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7e6696eb422so83449385a.1;
        Tue, 29 Jul 2025 16:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753831394; x=1754436194; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nLCHBLlT8kr1qwfWL1Hf165HeFFIejpV1F59uXG+lCE=;
        b=Uy7teFOCL9ep24uoJFnGJsGb68Kdsy8WkoKCQBJdS5EfMW5602tGF8MXLikeeU2Zbj
         wn8WiRSuB0rLUWmlZDqqeC/sF5SDfT1nARt+Zpdri1QZdKkEBfwDLTfeJUK0xsZKJyts
         M5SikWGxIzrQL+hg8/N7p/uRMVsd8DyNbYk7bPEJBzbM6EGkCJoAIPWypYkdNL2imWSA
         liB9mQVlYHTqkkSE5qgaF+kcGYX18kEAR3ZhxBWDfJwPzJmAGnaur7b3r+jixsQ5AEBl
         BLgbGJF6a3Wal+fC1jlH1yh6M7bvBWAOTO+85kQ4iZ58F3hZww+mlQj+hplJ/pvmwr+R
         R+lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753831394; x=1754436194;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nLCHBLlT8kr1qwfWL1Hf165HeFFIejpV1F59uXG+lCE=;
        b=dNfuxfDO27Gh5Nr/Gvf5LT4ufDJuFRc1iP5sW0CPOIYMcmCKB2SL9wc4ijC9X13Epf
         +r5YedT1ObVdNWmdRBrLfFT4RVND+CxWioB7T7Wwl/fQMysV4xL0pak47vRUxBWCl3NY
         Csv7kr+ZOIG6VLSl0ugqMyAb06/fv2ebRHgb50LmObeQaSewnsvEpYezArS67/2UiMNq
         Z5bG9rFMq14lO5bwbs88+PQKT6vJEGtaZ5T3gzwfisDkGrjd7/PkwJ5ZN4NDsKWuBYiC
         Sb8yMrOb/SnotfqojfoLqbrtlezqdSzWiIznTmesE6O84EDSzRNyLZ647z08PlMRYmHj
         3o9g==
X-Forwarded-Encrypted: i=1; AJvYcCVt1oICOghHfYkzU4INEarllnmbXSAWsFQbqiHYQZBr+7B6ZhwtOqSIPC5aTPAJyivJOlDeK8KxuTnm@vger.kernel.org, AJvYcCWCndNmx/pj5p/3KpAx6/WsRjmRslnWP8ScW/8Ntz7Fjd4U4mSmDLDOMaNaRLJ6SnIgpMJOC41QnbpFZZ2R@vger.kernel.org, AJvYcCXzLgJ7+QCwkO6kf81ylr70damyCJpAOfgrimqfUb9sY+X8Um+P0S9UL6opNSMOsy2i5fNndD55SEuPjk8Z@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8Nj/b7nK6AeKs6LNb795TiaZ6vdFci4uC+0NMcn21uou2Feem
	RChLLeG7rmBCHthuwN67E2qhwWaU0z7giZbSSIED+6oHvG0gAz7Z2Y3c3rbIFtmfplEE6lLcoEr
	VcoMCzUuRWNKihvu/+04ppie7pql/MrM=
X-Gm-Gg: ASbGncveybLogdXitlF+xqq7RwNuuvB+UX+5Lz4BiTBjoixyLw2QtXCP3h5k5/9mFnl
	b96kD7L1aYisUNRFAVN9WWCIjeB6o0bp8bBVfvRnZ625FVLCqmrT93RFCbJ9Gg0wLPBEHW3y+Ji
	kB4eFHGEpm+rLO4YkVD+JAgKTmyTLws6GvNnX0quKBnxZ22rYHBdsZKmNVS18v447xBD9wYOlF9
	12gVp0=
X-Google-Smtp-Source: AGHT+IFJb4kJK59OvtokgBzcf/xJK83WSxzBfMWJdNK1zG9Dt8FahWVfuWIetpiD0xccbKxb2dLsp4OyZ6ZM8mq5rTI=
X-Received: by 2002:a05:620a:17a7:b0:7e3:30a2:a587 with SMTP id
 af79cd13be357-7e66f39dc6emr179230085a.46.1753831393351; Tue, 29 Jul 2025
 16:23:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250723144637.GW2672070@frogsfrogsfrogs> <CAJnrk1Z7wcB8uKWcrAuRAZ8B-f8SKnOuwtEr-=cHa+ApR_sgXQ@mail.gmail.com>
 <20250723212020.GY2672070@frogsfrogsfrogs> <CAJnrk1bFWRTGnpNhW_9MwSYZw3qPnPXZBeiwtPSrMhCvb9C3qg@mail.gmail.com>
 <CAJnrk1byTVJtuOyAyZSVYrusjhA-bW6pxBOQQopgHHbD3cDUHw@mail.gmail.com>
 <CAJnrk1ZYR=hM5k90H57tOv=fe6F-r8dO+f3wNuCT_w3j8YNYNQ@mail.gmail.com>
 <20250728171425.GR2672029@frogsfrogsfrogs> <CAJnrk1bBesBijYRD1Wf_01OSBykJ0VzwFZKZFev0wPn9wYc98Q@mail.gmail.com>
 <20250728191117.GE2672070@frogsfrogsfrogs> <CAJnrk1bTgTcb4aUWqczXEH+7+SWQAdppxYbSAPNCVY6xXb-=hQ@mail.gmail.com>
 <20250729202151.GD2672049@frogsfrogsfrogs>
In-Reply-To: <20250729202151.GD2672049@frogsfrogsfrogs>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 29 Jul 2025 16:23:02 -0700
X-Gm-Features: Ac12FXzyf_vgF9nA8f151edxRSI_p4fYvQqpIGPGZutBnTpexeeeoNE0jtOrlGo
Message-ID: <CAJnrk1ZXN40WEwKXn7ycy2topGTvxFh_UfsM_vwhM+0CtTsJKQ@mail.gmail.com>
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

On Tue, Jul 29, 2025 at 1:21=E2=80=AFPM Darrick J. Wong <djwong@kernel.org>=
 wrote:
>
> On Mon, Jul 28, 2025 at 02:28:31PM -0700, Joanne Koong wrote:
> > On Mon, Jul 28, 2025 at 12:11=E2=80=AFPM Darrick J. Wong <djwong@kernel=
.org> wrote:
> > >
> > > On Mon, Jul 28, 2025 at 10:44:01AM -0700, Joanne Koong wrote:
> > > > On Mon, Jul 28, 2025 at 10:14=E2=80=AFAM Darrick J. Wong <djwong@ke=
rnel.org> wrote:
> > > > >
> > > > > On Fri, Jul 25, 2025 at 06:16:15PM -0700, Joanne Koong wrote:
> > > > > > On Thu, Jul 24, 2025 at 12:14=E2=80=AFPM Joanne Koong <joannelk=
oong@gmail.com> wrote:
> > > > > > >
> > > > > > > On Wed, Jul 23, 2025 at 3:37=E2=80=AFPM Joanne Koong <joannel=
koong@gmail.com> wrote:
> > > > > > > >
> > > > > > > > On Wed, Jul 23, 2025 at 2:20=E2=80=AFPM Darrick J. Wong <dj=
wong@kernel.org> wrote:
> > > > > > > > >
> > > > > > > > > On Wed, Jul 23, 2025 at 11:42:42AM -0700, Joanne Koong wr=
ote:
> > > > > > > > > > On Wed, Jul 23, 2025 at 7:46=E2=80=AFAM Darrick J. Wong=
 <djwong@kernel.org> wrote:
> > > > > > > > > > >
> > > > > > > > > > > [cc Joanne]
> > > > > > > > > > >
> > > > > > > > > > > On Wed, Jul 23, 2025 at 05:14:28PM +0530, Naresh Kamb=
oju wrote:
> > > > > > > > > > > > Test regression: next-20250721 arm64 16K and 64K pa=
ge size WARNING fs
> > > > > > > > > > > > fuse file.c at fuse_iomap_writeback_range
> > > > > > > > > > > >
> > > > > > > > > > > > Reported-by: Linux Kernel Functional Testing <lkft@=
linaro.org>
> > > > > > > > > > > >
> > > > > > > > > > > > ## Test log
> > > > > > > > > > > > ------------[ cut here ]------------
> > > > > > > > > > > > [  343.828105] WARNING: fs/fuse/file.c:2146 at
> > > > > > > > > > > > fuse_iomap_writeback_range+0x478/0x558 [fuse], CPU#=
0: msync04/4190
> > > > > > > > > > >
> > > > > > > > > > >         WARN_ON_ONCE(len & (PAGE_SIZE - 1));
> > > > > > > > > > >
> > > > > > > > > > > /me speculates that this might be triggered by an att=
empt to write back
> > > > > > > > > > > some 4k fsblock within a 16/64k base page?
> > > > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > I think this can happen on 4k base pages as well actual=
ly. On the
> > > > > > > > > > iomap side, the length passed is always block-aligned a=
nd in fuse, we
> > > > > > > > > > set blkbits to be PAGE_SHIFT so theoretically block-ali=
gned is always
> > > > > > > > > > page-aligned, but I missed that if it's a "fuseblk" fil=
esystem, that
> > > > > > > > > > isn't true and the blocksize is initialized to a defaul=
t size of 512
> > > > > > > > > > or whatever block size is passed in when it's mounted.
> > > > > > > > >
> > > > > > > > > <nod> I think you're correct.
> > > > > > > > >
> > > > > > > > > > I'll send out a patch to remove this line. It doesn't m=
ake any
> > > > > > > > > > difference for fuse_iomap_writeback_range() logic wheth=
er len is
> > > > > > > > > > page-aligned or not; I had added it as a sanity-check a=
gainst sketchy
> > > > > > > > > > ranges.
> > > > > > > > > >
> > > > > > > > > > Also, I just noticed that apparently the blocksize can =
change
> > > > > > > > > > dynamically for an inode in fuse through getattr replie=
s from the
> > > > > > > > > > server (see fuse_change_attributes_common()). This is a=
 problem since
> > > > > > > > > > the iomap uses inode->i_blkbits for reading/writing to =
the bitmap. I
> > > > > > > > > > think we will have to cache the inode blkbits in the io=
map_folio_state
> > > > > > > > > > struct unfortunately :( I'll think about this some more=
 and send out a
> > > > > > > > > > patch for this.
> > > > > > > > >
> > > > > > > > > From my understanding of the iomap code, it's possible to=
 do that if you
> > > > > > > > > flush and unmap the entire pagecache (whilst holding i_rw=
sem and
> > > > > > > > > mmap_invalidate_lock) before you change i_blkbits.  Nobod=
y *does* this
> > > > > > > > > so I have no idea if it actually works, however.  Note th=
at even I don't
> > > > > > > > > implement the flush and unmap bit; I just scream loudly a=
nd do nothing:
> > > > > > > >
> > > > > > > > lol! i wish I could scream loudly and do nothing too for my=
 case.
> > > > > > > >
> > > > > > > > AFAICT, I think I just need to flush and unmap that file an=
d can leave
> > > > > > > > the rest of the files/folios in the pagecache as is? But th=
en if the
> > > > > > > > file has active refcounts on it or has been pinned into mem=
ory, can I
> > > > > > > > still unmap and remove it from the page cache? I see the
> > > > > > > > invalidate_inode_pages2() function but my understanding is =
that the
> > > > > > > > page still stays in the cache if it has has active referenc=
es, and if
> > > > > > > > the page gets mmaped and there's a page fault on it, it'll =
end up
> > > > > > > > using the preexisting old page in the page cache.
> > > > > > >
> > > > > > > Never mind, I was mistaken about this. Johannes confirmed tha=
t even if
> > > > > > > there's active refcounts on the folio, it'll still get remove=
d from
> > > > > > > the page cache after unmapping and the page cache reference w=
ill get
> > > > > > > dropped.
> > > > > > >
> > > > > > > I think I can just do what you suggested and call
> > > > > > > filemap_invalidate_inode() in fuse_change_attributes_common()=
 then if
> > > > > > > the inode blksize gets changed. Thanks for the suggestion!
> > > > > > >
> > > > > >
> > > > > > Thinking about this some more, I don't think this works after a=
ll
> > > > > > because the writeback + page cache removal and inode blkbits up=
date
> > > > > > needs to be atomic, else after we write back and remove the pag=
es from
> > > > > > the page cache, a write could be issued right before we update =
the
> > > > > > inode blkbits. I don't think we can hold the inode lock the who=
le time
> > > > > > for it either since writeback could be intensive. (also btw, I
> > > > > > realized in hindsight that invalidate_inode_pages2_range() woul=
d have
> > > > > > been the better function to call instead of
> > > > > > filemap_invalidate_inode()).
> > > > > >
> > > > > > > >
> > > > > > > > I don't think I really need to have it removed from the pag=
e cache so
> > > > > > > > much as just have the ifs state for all the folios in the f=
ile freed
> > > > > > > > (after flushing the file) so that it can start over with a =
new ifs.
> > > > > > > > Ideally we could just flush the file, then iterate through =
all the
> > > > > > > > folios in the mapping in order of ascending index, and kfre=
e their
> > > > > > > > ->private, but I'm not seeing how we can prevent the case o=
f new
> > > > > > > > writes / a new ifs getting allocated for folios at previous=
 indexes
> > > > > > > > while we're trying to do the iteration/kfreeing.
> > > > > > > >
> > > > > >
> > > > > > Going back to this idea, I think this can work. I realized we d=
on't
> > > > > > need to flush the file, it's enough to free the ifs, then updat=
e the
> > > > > > inode->i_blkbits, then reallocate the ifs (which will now use t=
he
> > > > > > updated blkbits size), and if we hold the inode lock throughout=
, that
> > > > > > prevents any concurrent writes.
> > > > > > Something like:
> > > > > >      inode_lock(inode);
> > > > > >      XA_STATE(xas, &mapping->i_pages, 0);
> > > > > >      xa_lock_irq(&mapping->i_pages);
> > > > > >      xas_for_each_marked(&xas, folio, ULONG_MAX, PAGECACHE_TAG_=
DIRTY) {
> > > > > >           folio_lock(folio);
> > > > > >           if (folio_test_dirty(folio)) {
> > > > > >                   folio_wait_writeback(folio);
> > > > > >                   kfree(folio->private);
> > > > > >           }
> > >
> > > Heh, I didn't even see this chunk, distracted as I am today. :/
> > >
> > > So this doesn't actually /initiate/ writeback, it just waits
> > > (potentially for a long time) for someone else to come along and do i=
t.
> > > That might not be what you want since the blocksize change will appea=
r
> > > to stall while nothing else is going on in the system.
> >
> > I thought if the folio isn't under writeback then
> > folio_wait_writeback() just returns immediately as a no-op.
> > I don't think we need/want to initiate writeback, I think we only need
> > to ensure that if it is already under writeback, that writeback
> > finishes while it uses the old i_blksize so nothing gets corrupted. As
> > I understand it (but maybe I'm misjudging this), holding the inode
> > lock and then initiating writeback is too much given that writeback
> > can take a long time (eg if the fuse server writes the data over some
> > network).
> >
> > >
> > > Also, unless you're going to put this in buffered-io.c, it's not
> > > desirable for a piece of code to free something it didn't allocate.
> > > IOWs, I don't think it's a good idea for *fuse* to go messing with a
> > > folio->private that iomap set.
> >
> > Okay, good point. I agree. I was hoping to have this not bleed into
> > the iomap library but maybe there's no getting around that in a good
> > way.
>
> <shrug> Any other filesystem that has mutable file block size is going
> to need something to enact a change.
>
> > >
> > > > > >           folio_unlock(folio);
> > > > > >      }
> > > > > >     inode->i_blkbits =3D new_blkbits_size;
> > > > >
> > > > > The trouble is, you also have to resize the iomap_folio_state obj=
ects
> > > > > attached to each folio if you change i_blkbits...
> > > >
> > > > I think the iomap_folio_state objects automatically get resized her=
e,
> > > > no? We first kfree the folio->private which kfrees the entire ifs,
> > >
> > > Err, right, it does free the ifs and recreate it later if necessary.
> > >
> > > > then we change inode->i_blkbits to the new size, then when we call
> > > > folio_mark_dirty(), it'll create the new ifs which creates a new fo=
lio
> > > > state object using the new/updated i_blkbits size
> > > >
> > > > >
> > > > > >     xas_set(&xas, 0);
> > > > > >     xas_for_each_marked(&xas, folio, ULONG_MAX, PAGECACHE_TAG_D=
IRTY) {
> > > > > >           folio_lock(folio);
> > > > > >           if (folio_test_dirty(folio) && !folio_test_writeback(=
folio))
> > > > > >                  folio_mark_dirty(folio);
> > > > >
> > > > > ...because iomap_dirty_folio doesn't know how to reallocate the f=
olio
> > > > > state object in response to i_blkbits having changed.
> > >
> > > Also, what about clean folios that have an ifs?  You'd still need to
> > > handle the ifs's attached to those.
> >
> > Ah you're right, there could be clean folios there too that have an
> > ifs. I think in the above logic, if we iterate through all
> > mapping->i_pages (not just PAGECACHE_TAG_DIRTY marked ones) and move
> > the kfree to after the "if (folio_test_dirty(folio))" block, then it
> > addresses that case. eg something like this:
> >
> >      inode_lock(inode);
> >      XA_STATE(xas, &mapping->i_pages, 0);
> >      xa_lock_irq(&mapping->i_pages);
> >      xas_for_each(&xas, folio, ULONG_MAX) {
> >           folio_lock(folio);
> >           if (folio_test_dirty(folio))
> >                   folio_wait_writeback(folio);
> >           kfree(folio->private);
> >           folio_unlock(folio);
> >      }
> >     inode->i_blkbits =3D new_blkbits;
> >     xas_set(&xas, 0);
> >     xas_for_each_marked(&xas, folio, ULONG_MAX, PAGECACHE_TAG_DIRTY) {
> >           folio_lock(folio);
> >           if (folio_test_dirty(folio) && !folio_test_writeback(folio))
> >                  folio_mark_dirty(folio);
> >           folio_unlock(folio);
> >     }
> >     xa_unlock_irq(&mapping->i_pages);
> >     inode_unlock(inode);
> >
> >
> > >
> > > So I guess if you wanted iomap to handle a blocksize change, you coul=
d
> > > do something like:
> > >
> > > iomap_change_file_blocksize(inode, new_blkbits) {
> > >         inode_lock()
> > >         filemap_invalidate_lock()
> > >
> > >         inode_dio_wait()
> > >         filemap_write_and_wait()
> > >         if (new_blkbits > mapping_min_folio_order()) {
> > >                 truncate_pagecache()
> > >                 inode->i_blkbits =3D new_blkbits;
> > >         } else {
> > >                 inode->i_blkbits =3D new_blkbits;
> > >                 xas_for_each(...) {
> > >                         <create new ifs>
> > >                         <translate uptodate/dirty state to new ifs>
> > >                         <swap ifs>
> > >                         <free old ifs>
> > >                 }
> > >         }
> > >
> > >         filemap_invalidate_unlock()
> > >         inode_unlock()
> > > }
> >
> > Do you prefer this logic to the one above that walks through
> > &mapping->i_pages? If so, then I'll go with this way.
>
> Yes.  iomap should not be tightly bound to the pagecache's xarray; I
> don't even really like the xas_for_each that I suggested above.

Okay, sounds good.

>
> > The part I'm unsure about is that this logic seems more disruptive (eg
> > initiating writeback while holding the inode lock and doing work for
> > unmapping/page cache removal) than the other approach, but I guess
> > this is also rare enough that it doesn't matter much.
>
> I hope it's rare enough that doing truncate_pagecache unconditionally
> won't be seen as a huge burden.
>
> iomap_change_file_blocksize(inode, new_blkbits) {
>         inode_dio_wait()
>         filemap_write_and_wait()
>         truncate_pagecache()
>
>         inode->i_blkbits =3D new_blkbits;
> }
>
> fuse_file_change_blocksize(inode, new_blkbits) {
>         inode_lock()
>         filemap_invalidate_lock()
>
>         iomap_change_file_blocksize(inode, new_blkbits);
>
>         filemap_invalidate_unlock()
>         inode_unlock()
> }
>
> Though my question remains -- is there a fuse filesystem that changes
> the blocksize at runtime such that we can test this??

There's not one currently but I was planning to hack up the libfuse
passthrough_hp server to test the change.

>
> --D
>
> > Thanks,
> > Joanne
> >
> > >
> > > --D
> > >
> > > > > --D
> > > > >
> > > > > >           folio_unlock(folio);
> > > > > >     }
> > > > > >     xa_unlock_irq(&mapping->i_pages);
> > > > > >     inode_unlock(inode);
> > > > > >
> > > > > >
> > > > > > I think this is the only approach that doesn't require changes =
to iomap.
> > > > > >
> > > > > > I'm going to think about this some more next week and will try =
to send
> > > > > > out a patch for this then.
> > > > > >
> > > > > >
> > > > > > Thanks,
> > > > > > Joanne
> > > > > >
> > > > > > > > >
> > > > > > > > > void fuse_iomap_set_i_blkbits(struct inode *inode, u8 new=
_blkbits)
> > > > > > > > > {
> > > > > > > > >         trace_fuse_iomap_set_i_blkbits(inode, new_blkbits=
);
> > > > > > > > >
> > > > > > > > >         if (inode->i_blkbits =3D=3D new_blkbits)
> > > > > > > > >                 return;
> > > > > > > > >
> > > > > > > > >         if (!S_ISREG(inode->i_mode))
> > > > > > > > >                 goto set_it;
> > > > > > > > >
> > > > > > > > >         /*
> > > > > > > > >          * iomap attaches per-block state to each folio, =
so we cannot allow
> > > > > > > > >          * the file block size to change if there's anyth=
ing in the page cache.
> > > > > > > > >          * In theory, fuse servers should never be doing =
this.
> > > > > > > > >          */
> > > > > > > > >         if (inode->i_mapping->nrpages > 0) {
> > > > > > > > >                 WARN_ON(inode->i_blkbits !=3D new_blkbits=
 &&
> > > > > > > > >                         inode->i_mapping->nrpages > 0);
> > > > > > > > >                 return;
> > > > > > > > >         }
> > > > > > > > >
> > > > > > > > > set_it:
> > > > > > > > >         inode->i_blkbits =3D new_blkbits;
> > > > > > > > > }
> > > > > > > > >
> > > > > > > > > https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xf=
s-linux.git/commit/?h=3Dfuse-iomap-attrs&id=3Dda9b25d994c1140aae2f5ebf10e54=
d0872f5c884
> > > > > > > > >
> > > > > > > > > --D
> > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > Thanks,
> > > > > > > > > > Joanne
> > > > > > > > > >
> > > > > >
> >

