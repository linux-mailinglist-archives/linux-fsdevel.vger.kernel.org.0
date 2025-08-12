Return-Path: <linux-fsdevel+bounces-57534-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95365B22E29
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 18:49:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C08FE1A22462
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 16:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3037D2FAC14;
	Tue, 12 Aug 2025 16:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eoOo8v+2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88F0D2FA0E9;
	Tue, 12 Aug 2025 16:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755016924; cv=none; b=rtuDQluA3IcaBGnYpgxjEcPIZqLrWZlVJLukpRaQn7qPeYxIonKwI0c6pzNO5Ybv1UYkW9o/u87wEgtac4j6iZBYP8PmCvR0JWg5d6gJtT4szxTEpaH9pUKdItfPB87FzoU6q7uSG03P8c4IfIPQPxK0NfpWKN3oKC3PwZV/yBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755016924; c=relaxed/simple;
	bh=mzeTskEbEv7YIcxRJY9FVg7Fco/f7MknV0O2iutifog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qj3+wbxMNgTFXCcnhBdMc5T/QfrazqH8kY9272RKfmP274767Lf7yxqead1lUhESwYxHsHiY3eJ7T/qNyH1vlGjhBeqsBEM4pO43dYWX8Sm9AlmD2w2kRjzdHmg+jLlIFXEHBtEDEawbF9nSf9BydqfXqxn27sdgdUoLbHTm0og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eoOo8v+2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4E06C4CEF1;
	Tue, 12 Aug 2025 16:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755016924;
	bh=mzeTskEbEv7YIcxRJY9FVg7Fco/f7MknV0O2iutifog=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eoOo8v+2E5wziv0D9SyjwLUhVX9f/4Wk2PTv8EK4MlEestFfQO3LBc4TmGcKQ4u7y
	 IG/cewrpW0IsVu0zN1kgHt+2MoHRWn6tMYHWO2p/Ph/vXZiJloPht485aC8Uza/5Zn
	 Vn0I8/KJ1eag5J7bSv1VKSSbnqE0CI1k/DMuRVI/PFrh7hzlOIp7iG8DEVtP1nuyWu
	 z7/ifw1Nmr2Z+IYEyrWSrE49d+jaXhBpIDi8DQASdQjH5yqaAKIppfMjCvqdYdWdVg
	 SXa637LGgC2dU30zJCYBT29+11KNamk50/X2eBl+zNdRrBHCbTrVPBynXm88KJ/BRD
	 nUSP1YBQ4NEBQ==
Date: Tue, 12 Aug 2025 09:42:03 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Naresh Kamboju <naresh.kamboju@linaro.org>,
	linux-fsdevel@vger.kernel.org, linux-mm <linux-mm@kvack.org>,
	linux-xfs@vger.kernel.org, open list <linux-kernel@vger.kernel.org>,
	lkft-triage@lists.linaro.org,
	Linux Regressions <regressions@lists.linux.dev>,
	Miklos Szeredi <miklos@szeredi.hu>, Jan Kara <jack@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <liam.howlett@oracle.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Anders Roxell <anders.roxell@linaro.org>,
	Ben Copeland <benjamin.copeland@linaro.org>
Subject: Re: next-20250721 arm64 16K and 64K page size WARNING fs fuse file.c
 at fuse_iomap_writeback_range
Message-ID: <20250812164203.GG7942@frogsfrogsfrogs>
References: <20250728171425.GR2672029@frogsfrogsfrogs>
 <CAJnrk1bBesBijYRD1Wf_01OSBykJ0VzwFZKZFev0wPn9wYc98Q@mail.gmail.com>
 <20250728191117.GE2672070@frogsfrogsfrogs>
 <CAJnrk1bTgTcb4aUWqczXEH+7+SWQAdppxYbSAPNCVY6xXb-=hQ@mail.gmail.com>
 <20250729202151.GD2672049@frogsfrogsfrogs>
 <CAJnrk1ZXN40WEwKXn7ycy2topGTvxFh_UfsM_vwhM+0CtTsJKQ@mail.gmail.com>
 <20250729234018.GW2672029@frogsfrogsfrogs>
 <CAJnrk1b691Z3=_V0dU2Vb2qbiQd+0JUMj1ABDMip6vzzGZAf3w@mail.gmail.com>
 <20250731175528.GM2672070@frogsfrogsfrogs>
 <CAJnrk1bqpDbRaszZJR3B7Cjr5AcXNrw8nd-JjBqKvGkgmDxSbg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJnrk1bqpDbRaszZJR3B7Cjr5AcXNrw8nd-JjBqKvGkgmDxSbg@mail.gmail.com>

On Thu, Jul 31, 2025 at 01:48:15PM -0700, Joanne Koong wrote:
> On Thu, Jul 31, 2025 at 10:55 AM Darrick J. Wong <djwong@kernel.org> wrote:
> >
> > On Wed, Jul 30, 2025 at 03:54:15PM -0700, Joanne Koong wrote:
> > > On Tue, Jul 29, 2025 at 4:40 PM Darrick J. Wong <djwong@kernel.org> wrote:
> > > >
> > > > On Tue, Jul 29, 2025 at 04:23:02PM -0700, Joanne Koong wrote:
> > > > > On Tue, Jul 29, 2025 at 1:21 PM Darrick J. Wong <djwong@kernel.org> wrote:
> > > > > >
> > > > > > On Mon, Jul 28, 2025 at 02:28:31PM -0700, Joanne Koong wrote:
> > > > > > > On Mon, Jul 28, 2025 at 12:11 PM Darrick J. Wong <djwong@kernel.org> wrote:
> > > > > > > >
> > > > > > > > On Mon, Jul 28, 2025 at 10:44:01AM -0700, Joanne Koong wrote:
> > > > > > > > > On Mon, Jul 28, 2025 at 10:14 AM Darrick J. Wong <djwong@kernel.org> wrote:
> > > > > > > > > >
> > > > > > > > > > On Fri, Jul 25, 2025 at 06:16:15PM -0700, Joanne Koong wrote:
> > > > > > > > > > > On Thu, Jul 24, 2025 at 12:14 PM Joanne Koong <joannelkoong@gmail.com> wrote:
> > > > > > > > > > > >
> > > > > > > > > > > > On Wed, Jul 23, 2025 at 3:37 PM Joanne Koong <joannelkoong@gmail.com> wrote:
> > > > > > > > > > > > >
> > > > > > > > > > > > > On Wed, Jul 23, 2025 at 2:20 PM Darrick J. Wong <djwong@kernel.org> wrote:
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > On Wed, Jul 23, 2025 at 11:42:42AM -0700, Joanne Koong wrote:
> > > > > > > > > > > > > > > On Wed, Jul 23, 2025 at 7:46 AM Darrick J. Wong <djwong@kernel.org> wrote:
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > [cc Joanne]
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > On Wed, Jul 23, 2025 at 05:14:28PM +0530, Naresh Kamboju wrote:
> > > > > > > > > > > > > > > > > Test regression: next-20250721 arm64 16K and 64K page size WARNING fs
> > > > > > > > > > > > > > > > > fuse file.c at fuse_iomap_writeback_range
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > ## Test log
> > > > > > > > > > > > > > > > > ------------[ cut here ]------------
> > > > > > > > > > > > > > > > > [  343.828105] WARNING: fs/fuse/file.c:2146 at
> > > > > > > > > > > > > > > > > fuse_iomap_writeback_range+0x478/0x558 [fuse], CPU#0: msync04/4190
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > >         WARN_ON_ONCE(len & (PAGE_SIZE - 1));
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > /me speculates that this might be triggered by an attempt to write back
> > > > > > > > > > > > > > > > some 4k fsblock within a 16/64k base page?
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > I think this can happen on 4k base pages as well actually. On the
> > > > > > > > > > > > > > > iomap side, the length passed is always block-aligned and in fuse, we
> > > > > > > > > > > > > > > set blkbits to be PAGE_SHIFT so theoretically block-aligned is always
> > > > > > > > > > > > > > > page-aligned, but I missed that if it's a "fuseblk" filesystem, that
> > > > > > > > > > > > > > > isn't true and the blocksize is initialized to a default size of 512
> > > > > > > > > > > > > > > or whatever block size is passed in when it's mounted.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > <nod> I think you're correct.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > > I'll send out a patch to remove this line. It doesn't make any
> > > > > > > > > > > > > > > difference for fuse_iomap_writeback_range() logic whether len is
> > > > > > > > > > > > > > > page-aligned or not; I had added it as a sanity-check against sketchy
> > > > > > > > > > > > > > > ranges.
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > Also, I just noticed that apparently the blocksize can change
> > > > > > > > > > > > > > > dynamically for an inode in fuse through getattr replies from the
> > > > > > > > > > > > > > > server (see fuse_change_attributes_common()). This is a problem since
> > > > > > > > > > > > > > > the iomap uses inode->i_blkbits for reading/writing to the bitmap. I
> > > > > > > > > > > > > > > think we will have to cache the inode blkbits in the iomap_folio_state
> > > > > > > > > > > > > > > struct unfortunately :( I'll think about this some more and send out a
> > > > > > > > > > > > > > > patch for this.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > From my understanding of the iomap code, it's possible to do that if you
> > > > > > > > > > > > > > flush and unmap the entire pagecache (whilst holding i_rwsem and
> > > > > > > > > > > > > > mmap_invalidate_lock) before you change i_blkbits.  Nobody *does* this
> > > > > > > > > > > > > > so I have no idea if it actually works, however.  Note that even I don't
> > > > > > > > > > > > > > implement the flush and unmap bit; I just scream loudly and do nothing:
> > > > > > > > > > > > >
> > > > > > > > > > > > > lol! i wish I could scream loudly and do nothing too for my case.
> > > > > > > > > > > > >
> > > > > > > > > > > > > AFAICT, I think I just need to flush and unmap that file and can leave
> > > > > > > > > > > > > the rest of the files/folios in the pagecache as is? But then if the
> > > > > > > > > > > > > file has active refcounts on it or has been pinned into memory, can I
> > > > > > > > > > > > > still unmap and remove it from the page cache? I see the
> > > > > > > > > > > > > invalidate_inode_pages2() function but my understanding is that the
> > > > > > > > > > > > > page still stays in the cache if it has has active references, and if
> > > > > > > > > > > > > the page gets mmaped and there's a page fault on it, it'll end up
> > > > > > > > > > > > > using the preexisting old page in the page cache.
> > > > > > > > > > > >
> > > > > > > > > > > > Never mind, I was mistaken about this. Johannes confirmed that even if
> > > > > > > > > > > > there's active refcounts on the folio, it'll still get removed from
> > > > > > > > > > > > the page cache after unmapping and the page cache reference will get
> > > > > > > > > > > > dropped.
> > > > > > > > > > > >
> > > > > > > > > > > > I think I can just do what you suggested and call
> > > > > > > > > > > > filemap_invalidate_inode() in fuse_change_attributes_common() then if
> > > > > > > > > > > > the inode blksize gets changed. Thanks for the suggestion!
> > > > > > > > > > > >
> > > > > > > > > > >
> > > > > > > > > > > Thinking about this some more, I don't think this works after all
> > > > > > > > > > > because the writeback + page cache removal and inode blkbits update
> > > > > > > > > > > needs to be atomic, else after we write back and remove the pages from
> > > > > > > > > > > the page cache, a write could be issued right before we update the
> > > > > > > > > > > inode blkbits. I don't think we can hold the inode lock the whole time
> > > > > > > > > > > for it either since writeback could be intensive. (also btw, I
> > > > > > > > > > > realized in hindsight that invalidate_inode_pages2_range() would have
> > > > > > > > > > > been the better function to call instead of
> > > > > > > > > > > filemap_invalidate_inode()).
> > > > > > > > > > >
> > > > > > > > > > > > >
> > > > > > > > > > > > > I don't think I really need to have it removed from the page cache so
> > > > > > > > > > > > > much as just have the ifs state for all the folios in the file freed
> > > > > > > > > > > > > (after flushing the file) so that it can start over with a new ifs.
> > > > > > > > > > > > > Ideally we could just flush the file, then iterate through all the
> > > > > > > > > > > > > folios in the mapping in order of ascending index, and kfree their
> > > > > > > > > > > > > ->private, but I'm not seeing how we can prevent the case of new
> > > > > > > > > > > > > writes / a new ifs getting allocated for folios at previous indexes
> > > > > > > > > > > > > while we're trying to do the iteration/kfreeing.
> > > > > > > > > > > > >
> > > > > > > > > > >
> > > > > > > > > > > Going back to this idea, I think this can work. I realized we don't
> > > > > > > > > > > need to flush the file, it's enough to free the ifs, then update the
> > > > > > > > > > > inode->i_blkbits, then reallocate the ifs (which will now use the
> > > > > > > > > > > updated blkbits size), and if we hold the inode lock throughout, that
> > > > > > > > > > > prevents any concurrent writes.
> > > > > > > > > > > Something like:
> > > > > > > > > > >      inode_lock(inode);
> > > > > > > > > > >      XA_STATE(xas, &mapping->i_pages, 0);
> > > > > > > > > > >      xa_lock_irq(&mapping->i_pages);
> > > > > > > > > > >      xas_for_each_marked(&xas, folio, ULONG_MAX, PAGECACHE_TAG_DIRTY) {
> > > > > > > > > > >           folio_lock(folio);
> > > > > > > > > > >           if (folio_test_dirty(folio)) {
> > > > > > > > > > >                   folio_wait_writeback(folio);
> > > > > > > > > > >                   kfree(folio->private);
> > > > > > > > > > >           }
> > > > > > > >
> > > > > > > > Heh, I didn't even see this chunk, distracted as I am today. :/
> > > > > > > >
> > > > > > > > So this doesn't actually /initiate/ writeback, it just waits
> > > > > > > > (potentially for a long time) for someone else to come along and do it.
> > > > > > > > That might not be what you want since the blocksize change will appear
> > > > > > > > to stall while nothing else is going on in the system.
> > > > > > >
> > > > > > > I thought if the folio isn't under writeback then
> > > > > > > folio_wait_writeback() just returns immediately as a no-op.
> > > > > > > I don't think we need/want to initiate writeback, I think we only need
> > > > > > > to ensure that if it is already under writeback, that writeback
> > > > > > > finishes while it uses the old i_blksize so nothing gets corrupted. As
> > > > > > > I understand it (but maybe I'm misjudging this), holding the inode
> > > > > > > lock and then initiating writeback is too much given that writeback
> > > > > > > can take a long time (eg if the fuse server writes the data over some
> > > > > > > network).
> > > > > > >
> > > > > > > >
> > > > > > > > Also, unless you're going to put this in buffered-io.c, it's not
> > > > > > > > desirable for a piece of code to free something it didn't allocate.
> > > > > > > > IOWs, I don't think it's a good idea for *fuse* to go messing with a
> > > > > > > > folio->private that iomap set.
> > > > > > >
> > > > > > > Okay, good point. I agree. I was hoping to have this not bleed into
> > > > > > > the iomap library but maybe there's no getting around that in a good
> > > > > > > way.
> > > > > >
> > > > > > <shrug> Any other filesystem that has mutable file block size is going
> > > > > > to need something to enact a change.
> > > > > >
> > > > > > > >
> > > > > > > > > > >           folio_unlock(folio);
> > > > > > > > > > >      }
> > > > > > > > > > >     inode->i_blkbits = new_blkbits_size;
> > > > > > > > > >
> > > > > > > > > > The trouble is, you also have to resize the iomap_folio_state objects
> > > > > > > > > > attached to each folio if you change i_blkbits...
> > > > > > > > >
> > > > > > > > > I think the iomap_folio_state objects automatically get resized here,
> > > > > > > > > no? We first kfree the folio->private which kfrees the entire ifs,
> > > > > > > >
> > > > > > > > Err, right, it does free the ifs and recreate it later if necessary.
> > > > > > > >
> > > > > > > > > then we change inode->i_blkbits to the new size, then when we call
> > > > > > > > > folio_mark_dirty(), it'll create the new ifs which creates a new folio
> > > > > > > > > state object using the new/updated i_blkbits size
> > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > >     xas_set(&xas, 0);
> > > > > > > > > > >     xas_for_each_marked(&xas, folio, ULONG_MAX, PAGECACHE_TAG_DIRTY) {
> > > > > > > > > > >           folio_lock(folio);
> > > > > > > > > > >           if (folio_test_dirty(folio) && !folio_test_writeback(folio))
> > > > > > > > > > >                  folio_mark_dirty(folio);
> > > > > > > > > >
> > > > > > > > > > ...because iomap_dirty_folio doesn't know how to reallocate the folio
> > > > > > > > > > state object in response to i_blkbits having changed.
> > > > > > > >
> > > > > > > > Also, what about clean folios that have an ifs?  You'd still need to
> > > > > > > > handle the ifs's attached to those.
> > > > > > >
> > > > > > > Ah you're right, there could be clean folios there too that have an
> > > > > > > ifs. I think in the above logic, if we iterate through all
> > > > > > > mapping->i_pages (not just PAGECACHE_TAG_DIRTY marked ones) and move
> > > > > > > the kfree to after the "if (folio_test_dirty(folio))" block, then it
> > > > > > > addresses that case. eg something like this:
> > > > > > >
> > > > > > >      inode_lock(inode);
> > > > > > >      XA_STATE(xas, &mapping->i_pages, 0);
> > > > > > >      xa_lock_irq(&mapping->i_pages);
> > > > > > >      xas_for_each(&xas, folio, ULONG_MAX) {
> > > > > > >           folio_lock(folio);
> > > > > > >           if (folio_test_dirty(folio))
> > > > > > >                   folio_wait_writeback(folio);
> > > > > > >           kfree(folio->private);
> > > > > > >           folio_unlock(folio);
> > > > > > >      }
> > > > > > >     inode->i_blkbits = new_blkbits;
> > > > > > >     xas_set(&xas, 0);
> > > > > > >     xas_for_each_marked(&xas, folio, ULONG_MAX, PAGECACHE_TAG_DIRTY) {
> > > > > > >           folio_lock(folio);
> > > > > > >           if (folio_test_dirty(folio) && !folio_test_writeback(folio))
> > > > > > >                  folio_mark_dirty(folio);
> > > > > > >           folio_unlock(folio);
> > > > > > >     }
> > > > > > >     xa_unlock_irq(&mapping->i_pages);
> > > > > > >     inode_unlock(inode);
> > > > > > >
> > > > > > >
> > > > > > > >
> > > > > > > > So I guess if you wanted iomap to handle a blocksize change, you could
> > > > > > > > do something like:
> > > > > > > >
> > > > > > > > iomap_change_file_blocksize(inode, new_blkbits) {
> > > > > > > >         inode_lock()
> > > > > > > >         filemap_invalidate_lock()
> > > > > > > >
> > > > > > > >         inode_dio_wait()
> > > > > > > >         filemap_write_and_wait()
> > > > > > > >         if (new_blkbits > mapping_min_folio_order()) {
> > > > > > > >                 truncate_pagecache()
> > > > > > > >                 inode->i_blkbits = new_blkbits;
> > > > > > > >         } else {
> > > > > > > >                 inode->i_blkbits = new_blkbits;
> > > > > > > >                 xas_for_each(...) {
> > > > > > > >                         <create new ifs>
> > > > > > > >                         <translate uptodate/dirty state to new ifs>
> > > > > > > >                         <swap ifs>
> > > > > > > >                         <free old ifs>
> > > > > > > >                 }
> > > > > > > >         }
> > > > > > > >
> > > > > > > >         filemap_invalidate_unlock()
> > > > > > > >         inode_unlock()
> > > > > > > > }
> > > > > > >
> > > > > > > Do you prefer this logic to the one above that walks through
> > > > > > > &mapping->i_pages? If so, then I'll go with this way.
> > > > > >
> > > > > > Yes.  iomap should not be tightly bound to the pagecache's xarray; I
> > > > > > don't even really like the xas_for_each that I suggested above.
> > > > >
> > > > > Okay, sounds good.
> > > > >
> > > > > >
> > > > > > > The part I'm unsure about is that this logic seems more disruptive (eg
> > > > > > > initiating writeback while holding the inode lock and doing work for
> > > > > > > unmapping/page cache removal) than the other approach, but I guess
> > > > > > > this is also rare enough that it doesn't matter much.
> > > > > >
> > > > > > I hope it's rare enough that doing truncate_pagecache unconditionally
> > > > > > won't be seen as a huge burden.
> > > > > >
> > > > > > iomap_change_file_blocksize(inode, new_blkbits) {
> > > > > >         inode_dio_wait()
> > > > > >         filemap_write_and_wait()
> > > > > >         truncate_pagecache()
> > > > > >
> > > > > >         inode->i_blkbits = new_blkbits;
> > > > > > }
> > > > > >
> > > > > > fuse_file_change_blocksize(inode, new_blkbits) {
> > > > > >         inode_lock()
> > > > > >         filemap_invalidate_lock()
> > > > > >
> > > > > >         iomap_change_file_blocksize(inode, new_blkbits);
> > > > > >
> > > > > >         filemap_invalidate_unlock()
> > > > > >         inode_unlock()
> > > > > > }
> > > > > >
> > > > > > Though my question remains -- is there a fuse filesystem that changes
> > > > > > the blocksize at runtime such that we can test this??
> > > > >
> > > > > There's not one currently but I was planning to hack up the libfuse
> > > > > passthrough_hp server to test the change.
> > > >
> > > > Heh, ok.
> > > >
> > > > I guess I could also hack up fuse2fs to change its own blocksize
> > > > randomly to see how many programs that pisses off. :)
> > > >
> > > > (Not right now though, gotta prepare for fossy tomorrow...)
> > > >
> > >
> > > What I've been using as a helpful sanity-check so far has been running
> > > fstests generic/750 after adding this line to libfuse:
> > >
> > > +++ b/lib/fuse_lowlevel.c
> > > @@ -547,6 +547,8 @@ int fuse_reply_attr(fuse_req_t req, const struct stat *attr,
> > >         arg.attr_valid_nsec = calc_timeout_nsec(attr_timeout);
> > >         convert_stat(attr, &arg.attr);
> > > +       arg.attr.blksize = 4096;
> > >         return send_reply_ok(req, &arg, size);
> > >
> > > and modifying the kernel side logic in fuse_change_attributes_common()
> > > to unconditionally execute the page cache removal logic if
> > > attr->blksize != 0.
> > >
> > >
> > > While running this however, I discovered another problem :/ we can't
> > > grab the inode lock here in the fuse path because the vfs layer that
> > > calls into this logic may already be holding the inode lock (eg the
> > > stack traces I was seeing included path_openat()  ->
> > > inode_permission() -> fuse_permission() which then fetches the
> > > blksize, and the vfs rename path), while there are other call paths
> > > that may not be holding the lock already.
> >
> > Oh nooooo heisenlocking.  Which paths do not hold i_rwsem?
> 
> A path I was seeing that doesn't hold the inode lock was
> 
> [ 19.738097] Call Trace:
> [ 19.738468] inode_permission+0xea/0x190
> [ 19.738790] may_open+0x6e/0x150
> [ 19.739053] path_openat+0x4cf/0x1120
> [ 19.739341] ? generic_fillattr+0x49/0x130
> [ 19.739711] do_filp_open+0xc1/0x170
> [ 19.740064] ? kmem_cache_alloc_noprof+0x11b/0x380
> [ 19.740458] ? __check_object_size+0x22a/0x2c0
> [ 19.740834] ? alloc_fd+0xea/0x1b0
> [ 19.741125] do_sys_openat2+0x71/0xd0
> [ 19.741435] __x64_sys_openat+0x56/0xa0
> [ 19.741754] do_syscall_64+0x50/0x1c0
> [ 19.742068] entry_SYSCALL_64_after_hwframe+0x76/0x7e
> 
> and a path that does hold the inode lock:
> 
> [   42.176858]  inode_permission+0xea/0x190
> [   42.177372]  path_openat+0xd34/0x1120
> [   42.177838]  do_filp_open+0xc1/0x170
> [   42.178381]  ? kmem_cache_alloc_noprof+0x11b/0x380
> [   42.178970]  ? __check_object_size+0x22a/0x2c0
> [   42.179525]  ? alloc_fd+0xea/0x1b0
> [   42.179955]  do_sys_openat2+0x71/0xd0
> [   42.180417]  __x64_sys_creat+0x4c/0x70
> [   42.180868]  do_syscall_64+0x50/0x1c0

Heh, yep, exactly where I feared it would be. :(

> 
> >
> > > I don't really see a good solution here. The simplest one imo would be
> > > to cache "u8 blkbits" in the iomap_folio_state struct - are you okay
> > > with that or do you think there's a better solution here?
> >
> > 1. Don't support changing the blocksize, complain loudly if anyone does,
> > and only then implement it.  Writeback cache is a fairly new feature so
> > the impact should be low, right? ;)
> >
> > [there is no 2 :D]
> 
> I think technically the writeback cache was added in 2014 but I don't
> think anyone changes the blocksize so I'm happy to go with this
> approach if you/Miklos think it's fine :D I'll send out a patch for
> this then. Thanks for all the discussion on this!

<nod> I'll go look at that thread.

(still recovering after fossy...)

--D

> >
> > --D
> >
> > >
> > > Thanks,
> > > Joanne
> > >
> > > > --D
> > > >
> > > > > >
> > > > > > --D
> > > > > >
> > > > > > > Thanks,
> > > > > > > Joanne
> > > > > > >
> > > > > > > >
> > > > > > > > --D
> > > > > > > >
> > > > > > > > > > --D
> > > > > > > > > >
> > > > > > > > > > >           folio_unlock(folio);
> > > > > > > > > > >     }
> > > > > > > > > > >     xa_unlock_irq(&mapping->i_pages);
> > > > > > > > > > >     inode_unlock(inode);
> > > > > > > > > > >
> > > > > > > > > > >
> > > > > > > > > > > I think this is the only approach that doesn't require changes to iomap.
> > > > > > > > > > >
> > > > > > > > > > > I'm going to think about this some more next week and will try to send
> > > > > > > > > > > out a patch for this then.
> > > > > > > > > > >
> > > > > > > > > > >
> > > > > > > > > > > Thanks,
> > > > > > > > > > > Joanne
> > > > > > > > > > >
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > void fuse_iomap_set_i_blkbits(struct inode *inode, u8 new_blkbits)
> > > > > > > > > > > > > > {
> > > > > > > > > > > > > >         trace_fuse_iomap_set_i_blkbits(inode, new_blkbits);
> > > > > > > > > > > > > >
> > > > > > > > > > > > > >         if (inode->i_blkbits == new_blkbits)
> > > > > > > > > > > > > >                 return;
> > > > > > > > > > > > > >
> > > > > > > > > > > > > >         if (!S_ISREG(inode->i_mode))
> > > > > > > > > > > > > >                 goto set_it;
> > > > > > > > > > > > > >
> > > > > > > > > > > > > >         /*
> > > > > > > > > > > > > >          * iomap attaches per-block state to each folio, so we cannot allow
> > > > > > > > > > > > > >          * the file block size to change if there's anything in the page cache.
> > > > > > > > > > > > > >          * In theory, fuse servers should never be doing this.
> > > > > > > > > > > > > >          */
> > > > > > > > > > > > > >         if (inode->i_mapping->nrpages > 0) {
> > > > > > > > > > > > > >                 WARN_ON(inode->i_blkbits != new_blkbits &&
> > > > > > > > > > > > > >                         inode->i_mapping->nrpages > 0);
> > > > > > > > > > > > > >                 return;
> > > > > > > > > > > > > >         }
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > set_it:
> > > > > > > > > > > > > >         inode->i_blkbits = new_blkbits;
> > > > > > > > > > > > > > }
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/commit/?h=fuse-iomap-attrs&id=da9b25d994c1140aae2f5ebf10e54d0872f5c884
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > --D
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > Thanks,
> > > > > > > > > > > > > > > Joanne
> > > > > > > > > > > > > > >
> > > > > > > > > > >
> > > > > > >
> > > > >
> 

