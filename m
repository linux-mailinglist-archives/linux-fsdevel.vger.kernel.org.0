Return-Path: <linux-fsdevel+bounces-56297-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E55C0B15612
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Jul 2025 01:40:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C8E018A4E3D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Jul 2025 23:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2300D28750C;
	Tue, 29 Jul 2025 23:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D09OQGIo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7465219D8BC;
	Tue, 29 Jul 2025 23:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753832419; cv=none; b=GlBLRZ15rXd78DyXMWIApfoBpyHAyrWtf8VdNhNeQ+gEFvVWSRTr04wnKEqOL98cVt1b4kDZvkvX4G0uJpEbuDglmhc+PoUZYs3iYW7c1Qsj2Wk66OiBeGheNAkl/Q5L9GN+Y9T0/C6AggYxPsEru1JeQTfDmxbDc+7KEKTBz+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753832419; c=relaxed/simple;
	bh=QJvZ/DWMY2juDn3s7KAoBKuZkL+cj5uJe/VuNyacz9M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NFLHVdpoTcLreQc+NUZGbz8ulCtqfhjAmqQM3TpfBp5I6oVnlEe5f0SRUVaxO5diOkYQ3Zju/7dviOE5kVO3//cNuzqPmRblCYq3KAuYsl7dAJ75LVG9DpUwOdM025YTsplDhkU4R+tRQBgnkZQSk5k+HQxnAX3tzOY9kxyX7T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D09OQGIo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED3B9C4CEEF;
	Tue, 29 Jul 2025 23:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753832419;
	bh=QJvZ/DWMY2juDn3s7KAoBKuZkL+cj5uJe/VuNyacz9M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D09OQGIoRTsHHVXs43Q4Pdq+wn4QnMXxcDM9rp3ukTqJFDT/IDq/MTOc2L8LHDNdN
	 pfYtBHsWg8SvNUu7UZGThhgFE+DdwLigWMROrBT3WAuXQAn52V6bRV9EEvaOsxlkC1
	 dX/6hrnh5uadD+kERcdBQttxRZwtfMfp0xK0QRTvG08jrPaaq4c1yTO/btzQmvcqYU
	 UE5cvKAd1885rzvBilKWZQrvfLMzkc4O04+9ESDrcbt6WOXwTEerN4xvTp2hyXLZw/
	 X0Aw8bf5b9Wf2TrplHx2XKMhSs2RJp0EmO+aOzH4bGL7HaJY+23+sKq8QQZo7JxMK1
	 LsXWI2nMmCvyg==
Date: Tue, 29 Jul 2025 16:40:18 -0700
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
Message-ID: <20250729234018.GW2672029@frogsfrogsfrogs>
References: <20250723212020.GY2672070@frogsfrogsfrogs>
 <CAJnrk1bFWRTGnpNhW_9MwSYZw3qPnPXZBeiwtPSrMhCvb9C3qg@mail.gmail.com>
 <CAJnrk1byTVJtuOyAyZSVYrusjhA-bW6pxBOQQopgHHbD3cDUHw@mail.gmail.com>
 <CAJnrk1ZYR=hM5k90H57tOv=fe6F-r8dO+f3wNuCT_w3j8YNYNQ@mail.gmail.com>
 <20250728171425.GR2672029@frogsfrogsfrogs>
 <CAJnrk1bBesBijYRD1Wf_01OSBykJ0VzwFZKZFev0wPn9wYc98Q@mail.gmail.com>
 <20250728191117.GE2672070@frogsfrogsfrogs>
 <CAJnrk1bTgTcb4aUWqczXEH+7+SWQAdppxYbSAPNCVY6xXb-=hQ@mail.gmail.com>
 <20250729202151.GD2672049@frogsfrogsfrogs>
 <CAJnrk1ZXN40WEwKXn7ycy2topGTvxFh_UfsM_vwhM+0CtTsJKQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJnrk1ZXN40WEwKXn7ycy2topGTvxFh_UfsM_vwhM+0CtTsJKQ@mail.gmail.com>

On Tue, Jul 29, 2025 at 04:23:02PM -0700, Joanne Koong wrote:
> On Tue, Jul 29, 2025 at 1:21 PM Darrick J. Wong <djwong@kernel.org> wrote:
> >
> > On Mon, Jul 28, 2025 at 02:28:31PM -0700, Joanne Koong wrote:
> > > On Mon, Jul 28, 2025 at 12:11 PM Darrick J. Wong <djwong@kernel.org> wrote:
> > > >
> > > > On Mon, Jul 28, 2025 at 10:44:01AM -0700, Joanne Koong wrote:
> > > > > On Mon, Jul 28, 2025 at 10:14 AM Darrick J. Wong <djwong@kernel.org> wrote:
> > > > > >
> > > > > > On Fri, Jul 25, 2025 at 06:16:15PM -0700, Joanne Koong wrote:
> > > > > > > On Thu, Jul 24, 2025 at 12:14 PM Joanne Koong <joannelkoong@gmail.com> wrote:
> > > > > > > >
> > > > > > > > On Wed, Jul 23, 2025 at 3:37 PM Joanne Koong <joannelkoong@gmail.com> wrote:
> > > > > > > > >
> > > > > > > > > On Wed, Jul 23, 2025 at 2:20 PM Darrick J. Wong <djwong@kernel.org> wrote:
> > > > > > > > > >
> > > > > > > > > > On Wed, Jul 23, 2025 at 11:42:42AM -0700, Joanne Koong wrote:
> > > > > > > > > > > On Wed, Jul 23, 2025 at 7:46 AM Darrick J. Wong <djwong@kernel.org> wrote:
> > > > > > > > > > > >
> > > > > > > > > > > > [cc Joanne]
> > > > > > > > > > > >
> > > > > > > > > > > > On Wed, Jul 23, 2025 at 05:14:28PM +0530, Naresh Kamboju wrote:
> > > > > > > > > > > > > Test regression: next-20250721 arm64 16K and 64K page size WARNING fs
> > > > > > > > > > > > > fuse file.c at fuse_iomap_writeback_range
> > > > > > > > > > > > >
> > > > > > > > > > > > > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> > > > > > > > > > > > >
> > > > > > > > > > > > > ## Test log
> > > > > > > > > > > > > ------------[ cut here ]------------
> > > > > > > > > > > > > [  343.828105] WARNING: fs/fuse/file.c:2146 at
> > > > > > > > > > > > > fuse_iomap_writeback_range+0x478/0x558 [fuse], CPU#0: msync04/4190
> > > > > > > > > > > >
> > > > > > > > > > > >         WARN_ON_ONCE(len & (PAGE_SIZE - 1));
> > > > > > > > > > > >
> > > > > > > > > > > > /me speculates that this might be triggered by an attempt to write back
> > > > > > > > > > > > some 4k fsblock within a 16/64k base page?
> > > > > > > > > > > >
> > > > > > > > > > >
> > > > > > > > > > > I think this can happen on 4k base pages as well actually. On the
> > > > > > > > > > > iomap side, the length passed is always block-aligned and in fuse, we
> > > > > > > > > > > set blkbits to be PAGE_SHIFT so theoretically block-aligned is always
> > > > > > > > > > > page-aligned, but I missed that if it's a "fuseblk" filesystem, that
> > > > > > > > > > > isn't true and the blocksize is initialized to a default size of 512
> > > > > > > > > > > or whatever block size is passed in when it's mounted.
> > > > > > > > > >
> > > > > > > > > > <nod> I think you're correct.
> > > > > > > > > >
> > > > > > > > > > > I'll send out a patch to remove this line. It doesn't make any
> > > > > > > > > > > difference for fuse_iomap_writeback_range() logic whether len is
> > > > > > > > > > > page-aligned or not; I had added it as a sanity-check against sketchy
> > > > > > > > > > > ranges.
> > > > > > > > > > >
> > > > > > > > > > > Also, I just noticed that apparently the blocksize can change
> > > > > > > > > > > dynamically for an inode in fuse through getattr replies from the
> > > > > > > > > > > server (see fuse_change_attributes_common()). This is a problem since
> > > > > > > > > > > the iomap uses inode->i_blkbits for reading/writing to the bitmap. I
> > > > > > > > > > > think we will have to cache the inode blkbits in the iomap_folio_state
> > > > > > > > > > > struct unfortunately :( I'll think about this some more and send out a
> > > > > > > > > > > patch for this.
> > > > > > > > > >
> > > > > > > > > > From my understanding of the iomap code, it's possible to do that if you
> > > > > > > > > > flush and unmap the entire pagecache (whilst holding i_rwsem and
> > > > > > > > > > mmap_invalidate_lock) before you change i_blkbits.  Nobody *does* this
> > > > > > > > > > so I have no idea if it actually works, however.  Note that even I don't
> > > > > > > > > > implement the flush and unmap bit; I just scream loudly and do nothing:
> > > > > > > > >
> > > > > > > > > lol! i wish I could scream loudly and do nothing too for my case.
> > > > > > > > >
> > > > > > > > > AFAICT, I think I just need to flush and unmap that file and can leave
> > > > > > > > > the rest of the files/folios in the pagecache as is? But then if the
> > > > > > > > > file has active refcounts on it or has been pinned into memory, can I
> > > > > > > > > still unmap and remove it from the page cache? I see the
> > > > > > > > > invalidate_inode_pages2() function but my understanding is that the
> > > > > > > > > page still stays in the cache if it has has active references, and if
> > > > > > > > > the page gets mmaped and there's a page fault on it, it'll end up
> > > > > > > > > using the preexisting old page in the page cache.
> > > > > > > >
> > > > > > > > Never mind, I was mistaken about this. Johannes confirmed that even if
> > > > > > > > there's active refcounts on the folio, it'll still get removed from
> > > > > > > > the page cache after unmapping and the page cache reference will get
> > > > > > > > dropped.
> > > > > > > >
> > > > > > > > I think I can just do what you suggested and call
> > > > > > > > filemap_invalidate_inode() in fuse_change_attributes_common() then if
> > > > > > > > the inode blksize gets changed. Thanks for the suggestion!
> > > > > > > >
> > > > > > >
> > > > > > > Thinking about this some more, I don't think this works after all
> > > > > > > because the writeback + page cache removal and inode blkbits update
> > > > > > > needs to be atomic, else after we write back and remove the pages from
> > > > > > > the page cache, a write could be issued right before we update the
> > > > > > > inode blkbits. I don't think we can hold the inode lock the whole time
> > > > > > > for it either since writeback could be intensive. (also btw, I
> > > > > > > realized in hindsight that invalidate_inode_pages2_range() would have
> > > > > > > been the better function to call instead of
> > > > > > > filemap_invalidate_inode()).
> > > > > > >
> > > > > > > > >
> > > > > > > > > I don't think I really need to have it removed from the page cache so
> > > > > > > > > much as just have the ifs state for all the folios in the file freed
> > > > > > > > > (after flushing the file) so that it can start over with a new ifs.
> > > > > > > > > Ideally we could just flush the file, then iterate through all the
> > > > > > > > > folios in the mapping in order of ascending index, and kfree their
> > > > > > > > > ->private, but I'm not seeing how we can prevent the case of new
> > > > > > > > > writes / a new ifs getting allocated for folios at previous indexes
> > > > > > > > > while we're trying to do the iteration/kfreeing.
> > > > > > > > >
> > > > > > >
> > > > > > > Going back to this idea, I think this can work. I realized we don't
> > > > > > > need to flush the file, it's enough to free the ifs, then update the
> > > > > > > inode->i_blkbits, then reallocate the ifs (which will now use the
> > > > > > > updated blkbits size), and if we hold the inode lock throughout, that
> > > > > > > prevents any concurrent writes.
> > > > > > > Something like:
> > > > > > >      inode_lock(inode);
> > > > > > >      XA_STATE(xas, &mapping->i_pages, 0);
> > > > > > >      xa_lock_irq(&mapping->i_pages);
> > > > > > >      xas_for_each_marked(&xas, folio, ULONG_MAX, PAGECACHE_TAG_DIRTY) {
> > > > > > >           folio_lock(folio);
> > > > > > >           if (folio_test_dirty(folio)) {
> > > > > > >                   folio_wait_writeback(folio);
> > > > > > >                   kfree(folio->private);
> > > > > > >           }
> > > >
> > > > Heh, I didn't even see this chunk, distracted as I am today. :/
> > > >
> > > > So this doesn't actually /initiate/ writeback, it just waits
> > > > (potentially for a long time) for someone else to come along and do it.
> > > > That might not be what you want since the blocksize change will appear
> > > > to stall while nothing else is going on in the system.
> > >
> > > I thought if the folio isn't under writeback then
> > > folio_wait_writeback() just returns immediately as a no-op.
> > > I don't think we need/want to initiate writeback, I think we only need
> > > to ensure that if it is already under writeback, that writeback
> > > finishes while it uses the old i_blksize so nothing gets corrupted. As
> > > I understand it (but maybe I'm misjudging this), holding the inode
> > > lock and then initiating writeback is too much given that writeback
> > > can take a long time (eg if the fuse server writes the data over some
> > > network).
> > >
> > > >
> > > > Also, unless you're going to put this in buffered-io.c, it's not
> > > > desirable for a piece of code to free something it didn't allocate.
> > > > IOWs, I don't think it's a good idea for *fuse* to go messing with a
> > > > folio->private that iomap set.
> > >
> > > Okay, good point. I agree. I was hoping to have this not bleed into
> > > the iomap library but maybe there's no getting around that in a good
> > > way.
> >
> > <shrug> Any other filesystem that has mutable file block size is going
> > to need something to enact a change.
> >
> > > >
> > > > > > >           folio_unlock(folio);
> > > > > > >      }
> > > > > > >     inode->i_blkbits = new_blkbits_size;
> > > > > >
> > > > > > The trouble is, you also have to resize the iomap_folio_state objects
> > > > > > attached to each folio if you change i_blkbits...
> > > > >
> > > > > I think the iomap_folio_state objects automatically get resized here,
> > > > > no? We first kfree the folio->private which kfrees the entire ifs,
> > > >
> > > > Err, right, it does free the ifs and recreate it later if necessary.
> > > >
> > > > > then we change inode->i_blkbits to the new size, then when we call
> > > > > folio_mark_dirty(), it'll create the new ifs which creates a new folio
> > > > > state object using the new/updated i_blkbits size
> > > > >
> > > > > >
> > > > > > >     xas_set(&xas, 0);
> > > > > > >     xas_for_each_marked(&xas, folio, ULONG_MAX, PAGECACHE_TAG_DIRTY) {
> > > > > > >           folio_lock(folio);
> > > > > > >           if (folio_test_dirty(folio) && !folio_test_writeback(folio))
> > > > > > >                  folio_mark_dirty(folio);
> > > > > >
> > > > > > ...because iomap_dirty_folio doesn't know how to reallocate the folio
> > > > > > state object in response to i_blkbits having changed.
> > > >
> > > > Also, what about clean folios that have an ifs?  You'd still need to
> > > > handle the ifs's attached to those.
> > >
> > > Ah you're right, there could be clean folios there too that have an
> > > ifs. I think in the above logic, if we iterate through all
> > > mapping->i_pages (not just PAGECACHE_TAG_DIRTY marked ones) and move
> > > the kfree to after the "if (folio_test_dirty(folio))" block, then it
> > > addresses that case. eg something like this:
> > >
> > >      inode_lock(inode);
> > >      XA_STATE(xas, &mapping->i_pages, 0);
> > >      xa_lock_irq(&mapping->i_pages);
> > >      xas_for_each(&xas, folio, ULONG_MAX) {
> > >           folio_lock(folio);
> > >           if (folio_test_dirty(folio))
> > >                   folio_wait_writeback(folio);
> > >           kfree(folio->private);
> > >           folio_unlock(folio);
> > >      }
> > >     inode->i_blkbits = new_blkbits;
> > >     xas_set(&xas, 0);
> > >     xas_for_each_marked(&xas, folio, ULONG_MAX, PAGECACHE_TAG_DIRTY) {
> > >           folio_lock(folio);
> > >           if (folio_test_dirty(folio) && !folio_test_writeback(folio))
> > >                  folio_mark_dirty(folio);
> > >           folio_unlock(folio);
> > >     }
> > >     xa_unlock_irq(&mapping->i_pages);
> > >     inode_unlock(inode);
> > >
> > >
> > > >
> > > > So I guess if you wanted iomap to handle a blocksize change, you could
> > > > do something like:
> > > >
> > > > iomap_change_file_blocksize(inode, new_blkbits) {
> > > >         inode_lock()
> > > >         filemap_invalidate_lock()
> > > >
> > > >         inode_dio_wait()
> > > >         filemap_write_and_wait()
> > > >         if (new_blkbits > mapping_min_folio_order()) {
> > > >                 truncate_pagecache()
> > > >                 inode->i_blkbits = new_blkbits;
> > > >         } else {
> > > >                 inode->i_blkbits = new_blkbits;
> > > >                 xas_for_each(...) {
> > > >                         <create new ifs>
> > > >                         <translate uptodate/dirty state to new ifs>
> > > >                         <swap ifs>
> > > >                         <free old ifs>
> > > >                 }
> > > >         }
> > > >
> > > >         filemap_invalidate_unlock()
> > > >         inode_unlock()
> > > > }
> > >
> > > Do you prefer this logic to the one above that walks through
> > > &mapping->i_pages? If so, then I'll go with this way.
> >
> > Yes.  iomap should not be tightly bound to the pagecache's xarray; I
> > don't even really like the xas_for_each that I suggested above.
> 
> Okay, sounds good.
> 
> >
> > > The part I'm unsure about is that this logic seems more disruptive (eg
> > > initiating writeback while holding the inode lock and doing work for
> > > unmapping/page cache removal) than the other approach, but I guess
> > > this is also rare enough that it doesn't matter much.
> >
> > I hope it's rare enough that doing truncate_pagecache unconditionally
> > won't be seen as a huge burden.
> >
> > iomap_change_file_blocksize(inode, new_blkbits) {
> >         inode_dio_wait()
> >         filemap_write_and_wait()
> >         truncate_pagecache()
> >
> >         inode->i_blkbits = new_blkbits;
> > }
> >
> > fuse_file_change_blocksize(inode, new_blkbits) {
> >         inode_lock()
> >         filemap_invalidate_lock()
> >
> >         iomap_change_file_blocksize(inode, new_blkbits);
> >
> >         filemap_invalidate_unlock()
> >         inode_unlock()
> > }
> >
> > Though my question remains -- is there a fuse filesystem that changes
> > the blocksize at runtime such that we can test this??
> 
> There's not one currently but I was planning to hack up the libfuse
> passthrough_hp server to test the change.

Heh, ok.

I guess I could also hack up fuse2fs to change its own blocksize
randomly to see how many programs that pisses off. :)

(Not right now though, gotta prepare for fossy tomorrow...)

--D

> >
> > --D
> >
> > > Thanks,
> > > Joanne
> > >
> > > >
> > > > --D
> > > >
> > > > > > --D
> > > > > >
> > > > > > >           folio_unlock(folio);
> > > > > > >     }
> > > > > > >     xa_unlock_irq(&mapping->i_pages);
> > > > > > >     inode_unlock(inode);
> > > > > > >
> > > > > > >
> > > > > > > I think this is the only approach that doesn't require changes to iomap.
> > > > > > >
> > > > > > > I'm going to think about this some more next week and will try to send
> > > > > > > out a patch for this then.
> > > > > > >
> > > > > > >
> > > > > > > Thanks,
> > > > > > > Joanne
> > > > > > >
> > > > > > > > > >
> > > > > > > > > > void fuse_iomap_set_i_blkbits(struct inode *inode, u8 new_blkbits)
> > > > > > > > > > {
> > > > > > > > > >         trace_fuse_iomap_set_i_blkbits(inode, new_blkbits);
> > > > > > > > > >
> > > > > > > > > >         if (inode->i_blkbits == new_blkbits)
> > > > > > > > > >                 return;
> > > > > > > > > >
> > > > > > > > > >         if (!S_ISREG(inode->i_mode))
> > > > > > > > > >                 goto set_it;
> > > > > > > > > >
> > > > > > > > > >         /*
> > > > > > > > > >          * iomap attaches per-block state to each folio, so we cannot allow
> > > > > > > > > >          * the file block size to change if there's anything in the page cache.
> > > > > > > > > >          * In theory, fuse servers should never be doing this.
> > > > > > > > > >          */
> > > > > > > > > >         if (inode->i_mapping->nrpages > 0) {
> > > > > > > > > >                 WARN_ON(inode->i_blkbits != new_blkbits &&
> > > > > > > > > >                         inode->i_mapping->nrpages > 0);
> > > > > > > > > >                 return;
> > > > > > > > > >         }
> > > > > > > > > >
> > > > > > > > > > set_it:
> > > > > > > > > >         inode->i_blkbits = new_blkbits;
> > > > > > > > > > }
> > > > > > > > > >
> > > > > > > > > > https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/commit/?h=fuse-iomap-attrs&id=da9b25d994c1140aae2f5ebf10e54d0872f5c884
> > > > > > > > > >
> > > > > > > > > > --D
> > > > > > > > > >
> > > > > > > > > > >
> > > > > > > > > > > Thanks,
> > > > > > > > > > > Joanne
> > > > > > > > > > >
> > > > > > >
> > >
> 

