Return-Path: <linux-fsdevel+bounces-56147-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B93D3B14110
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Jul 2025 19:14:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B108189B085
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Jul 2025 17:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC96B275AE8;
	Mon, 28 Jul 2025 17:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sjgNLLpH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D5771B412A;
	Mon, 28 Jul 2025 17:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753722866; cv=none; b=DAI3424CqoQi5bTFLIQ+WfENGJCAA57kYh25KtGO+i8dLBz+sSYMtwHOf94AnTt8CBifC3ILHEKZOV4LA2Ju40DLqy778kcF+JH2x2eeSLfv/84kJh3oG0Kg/5mUYuHJHYNvPxHyc0gE/zKg0phPmyZFVFcp4WtV5WmcwL4cNU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753722866; c=relaxed/simple;
	bh=ShS6WZQge780shaKIIz7KkjUpx+cF0xBwdgZKYy9OdI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qxyIp+KgeEqfeZRpSTimZ/PH6S5izwvE7oo1qCf940LqnZX8vu5H9iO839g204Wzhm++6WZKwfWB5Yw8MW/PI6LGbMRqIcJv8BLh4V/KrXKRwuDOZJGamzMBmDl6bnE9OxW59kBb3Iu1r4pSyuu63RdsewyqmXRjD1Q4hn/yOXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sjgNLLpH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4FE4C4CEF7;
	Mon, 28 Jul 2025 17:14:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753722865;
	bh=ShS6WZQge780shaKIIz7KkjUpx+cF0xBwdgZKYy9OdI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sjgNLLpH6URyHHPD/ay/v4Krp41qbfpFo1HGb6ethrvAEU3dKj0Z3H+UQaO/vZUpN
	 c7PtAFK4Ozux7kcSJIodKzHjPZMIeC7SG5mZoxG6M9HrOR1aA4OuCEhk9TYxZfV/cC
	 BKAN0sfMT4Zmxpep6xH92usKWGcJOoMz9UwRuSbZlgofRX1csq76jAWTPbLYeH3vbm
	 6JvzdvOp5f5aKBTHAgwolC/ZVS44Xw+kp7BEysDLwwCkO03UZznK+DKcZrrM6KNupS
	 vbsYEKY+aaOxjhQtFOBIywOFDridM8SJlFSwdizBH0phYTtVseRQDsgW5Ex1CmH7Au
	 Io7pc9+ohXafQ==
Date: Mon, 28 Jul 2025 10:14:25 -0700
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
Message-ID: <20250728171425.GR2672029@frogsfrogsfrogs>
References: <CA+G9fYs5AdVM-T2Tf3LciNCwLZEHetcnSkHsjZajVwwpM2HmJw@mail.gmail.com>
 <20250723144637.GW2672070@frogsfrogsfrogs>
 <CAJnrk1Z7wcB8uKWcrAuRAZ8B-f8SKnOuwtEr-=cHa+ApR_sgXQ@mail.gmail.com>
 <20250723212020.GY2672070@frogsfrogsfrogs>
 <CAJnrk1bFWRTGnpNhW_9MwSYZw3qPnPXZBeiwtPSrMhCvb9C3qg@mail.gmail.com>
 <CAJnrk1byTVJtuOyAyZSVYrusjhA-bW6pxBOQQopgHHbD3cDUHw@mail.gmail.com>
 <CAJnrk1ZYR=hM5k90H57tOv=fe6F-r8dO+f3wNuCT_w3j8YNYNQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJnrk1ZYR=hM5k90H57tOv=fe6F-r8dO+f3wNuCT_w3j8YNYNQ@mail.gmail.com>

On Fri, Jul 25, 2025 at 06:16:15PM -0700, Joanne Koong wrote:
> On Thu, Jul 24, 2025 at 12:14 PM Joanne Koong <joannelkoong@gmail.com> wrote:
> >
> > On Wed, Jul 23, 2025 at 3:37 PM Joanne Koong <joannelkoong@gmail.com> wrote:
> > >
> > > On Wed, Jul 23, 2025 at 2:20 PM Darrick J. Wong <djwong@kernel.org> wrote:
> > > >
> > > > On Wed, Jul 23, 2025 at 11:42:42AM -0700, Joanne Koong wrote:
> > > > > On Wed, Jul 23, 2025 at 7:46 AM Darrick J. Wong <djwong@kernel.org> wrote:
> > > > > >
> > > > > > [cc Joanne]
> > > > > >
> > > > > > On Wed, Jul 23, 2025 at 05:14:28PM +0530, Naresh Kamboju wrote:
> > > > > > > Regressions found while running LTP msync04 tests on qemu-arm64 running
> > > > > > > Linux next-20250721, next-20250722 and next-20250723 with 16K and 64K
> > > > > > > page size enabled builds.
> > > > > > >
> > > > > > > CONFIG_ARM64_64K_PAGES=y ( kernel warning as below )
> > > > > > > CONFIG_ARM64_16K_PAGES=y ( kernel warning as below )
> > > > > > >
> > > > > > > No warning noticed with 4K page size.
> > > > > > > CONFIG_ARM64_4K_PAGES=y works as expected
> > > > > >
> > > > > > You might want to cc Joanne since she's been working on large folio
> > > > > > support in fuse.
> > > > > >
> > > > > > > First seen on the tag next-20250721.
> > > > > > > Good: next-20250718
> > > > > > > Bad:  next-20250721 to next-20250723
> > > > >
> > > > > Thanks for the report. Is there a link to the script that mounts the
> > > > > fuse server for these tests? I'm curious whether this was mounted as a
> > > > > fuseblk filesystem.
> > > > >
> > > > > > >
> > > > > > > Regression Analysis:
> > > > > > > - New regression? Yes
> > > > > > > - Reproducibility? Yes
> > > > > > >
> > > > > > > Test regression: next-20250721 arm64 16K and 64K page size WARNING fs
> > > > > > > fuse file.c at fuse_iomap_writeback_range
> > > > > > >
> > > > > > > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> > > > > > >
> > > > > > > ## Test log
> > > > > > > ------------[ cut here ]------------
> > > > > > > [  343.828105] WARNING: fs/fuse/file.c:2146 at
> > > > > > > fuse_iomap_writeback_range+0x478/0x558 [fuse], CPU#0: msync04/4190
> > > > > >
> > > > > >         WARN_ON_ONCE(len & (PAGE_SIZE - 1));
> > > > > >
> > > > > > /me speculates that this might be triggered by an attempt to write back
> > > > > > some 4k fsblock within a 16/64k base page?
> > > > > >
> > > > >
> > > > > I think this can happen on 4k base pages as well actually. On the
> > > > > iomap side, the length passed is always block-aligned and in fuse, we
> > > > > set blkbits to be PAGE_SHIFT so theoretically block-aligned is always
> > > > > page-aligned, but I missed that if it's a "fuseblk" filesystem, that
> > > > > isn't true and the blocksize is initialized to a default size of 512
> > > > > or whatever block size is passed in when it's mounted.
> > > >
> > > > <nod> I think you're correct.
> > > >
> > > > > I'll send out a patch to remove this line. It doesn't make any
> > > > > difference for fuse_iomap_writeback_range() logic whether len is
> > > > > page-aligned or not; I had added it as a sanity-check against sketchy
> > > > > ranges.
> > > > >
> > > > > Also, I just noticed that apparently the blocksize can change
> > > > > dynamically for an inode in fuse through getattr replies from the
> > > > > server (see fuse_change_attributes_common()). This is a problem since
> > > > > the iomap uses inode->i_blkbits for reading/writing to the bitmap. I
> > > > > think we will have to cache the inode blkbits in the iomap_folio_state
> > > > > struct unfortunately :( I'll think about this some more and send out a
> > > > > patch for this.
> > > >
> > > > From my understanding of the iomap code, it's possible to do that if you
> > > > flush and unmap the entire pagecache (whilst holding i_rwsem and
> > > > mmap_invalidate_lock) before you change i_blkbits.  Nobody *does* this
> > > > so I have no idea if it actually works, however.  Note that even I don't
> > > > implement the flush and unmap bit; I just scream loudly and do nothing:
> > >
> > > lol! i wish I could scream loudly and do nothing too for my case.
> > >
> > > AFAICT, I think I just need to flush and unmap that file and can leave
> > > the rest of the files/folios in the pagecache as is? But then if the
> > > file has active refcounts on it or has been pinned into memory, can I
> > > still unmap and remove it from the page cache? I see the
> > > invalidate_inode_pages2() function but my understanding is that the
> > > page still stays in the cache if it has has active references, and if
> > > the page gets mmaped and there's a page fault on it, it'll end up
> > > using the preexisting old page in the page cache.
> >
> > Never mind, I was mistaken about this. Johannes confirmed that even if
> > there's active refcounts on the folio, it'll still get removed from
> > the page cache after unmapping and the page cache reference will get
> > dropped.
> >
> > I think I can just do what you suggested and call
> > filemap_invalidate_inode() in fuse_change_attributes_common() then if
> > the inode blksize gets changed. Thanks for the suggestion!
> >
> 
> Thinking about this some more, I don't think this works after all
> because the writeback + page cache removal and inode blkbits update
> needs to be atomic, else after we write back and remove the pages from
> the page cache, a write could be issued right before we update the
> inode blkbits. I don't think we can hold the inode lock the whole time
> for it either since writeback could be intensive. (also btw, I
> realized in hindsight that invalidate_inode_pages2_range() would have
> been the better function to call instead of
> filemap_invalidate_inode()).
> 
> > >
> > > I don't think I really need to have it removed from the page cache so
> > > much as just have the ifs state for all the folios in the file freed
> > > (after flushing the file) so that it can start over with a new ifs.
> > > Ideally we could just flush the file, then iterate through all the
> > > folios in the mapping in order of ascending index, and kfree their
> > > ->private, but I'm not seeing how we can prevent the case of new
> > > writes / a new ifs getting allocated for folios at previous indexes
> > > while we're trying to do the iteration/kfreeing.
> > >
> 
> Going back to this idea, I think this can work. I realized we don't
> need to flush the file, it's enough to free the ifs, then update the
> inode->i_blkbits, then reallocate the ifs (which will now use the
> updated blkbits size), and if we hold the inode lock throughout, that
> prevents any concurrent writes.
> Something like:
>      inode_lock(inode);
>      XA_STATE(xas, &mapping->i_pages, 0);
>      xa_lock_irq(&mapping->i_pages);
>      xas_for_each_marked(&xas, folio, ULONG_MAX, PAGECACHE_TAG_DIRTY) {
>           folio_lock(folio);
>           if (folio_test_dirty(folio)) {
>                   folio_wait_writeback(folio);
>                   kfree(folio->private);
>           }
>           folio_unlock(folio);
>      }
>     inode->i_blkbits = new_blkbits_size;

The trouble is, you also have to resize the iomap_folio_state objects
attached to each folio if you change i_blkbits...

>     xas_set(&xas, 0);
>     xas_for_each_marked(&xas, folio, ULONG_MAX, PAGECACHE_TAG_DIRTY) {
>           folio_lock(folio);
>           if (folio_test_dirty(folio) && !folio_test_writeback(folio))
>                  folio_mark_dirty(folio);

...because iomap_dirty_folio doesn't know how to reallocate the folio
state object in response to i_blkbits having changed.

--D

>           folio_unlock(folio);
>     }
>     xa_unlock_irq(&mapping->i_pages);
>     inode_unlock(inode);
> 
> 
> I think this is the only approach that doesn't require changes to iomap.
> 
> I'm going to think about this some more next week and will try to send
> out a patch for this then.
> 
> 
> Thanks,
> Joanne
> 
> > > >
> > > > void fuse_iomap_set_i_blkbits(struct inode *inode, u8 new_blkbits)
> > > > {
> > > >         trace_fuse_iomap_set_i_blkbits(inode, new_blkbits);
> > > >
> > > >         if (inode->i_blkbits == new_blkbits)
> > > >                 return;
> > > >
> > > >         if (!S_ISREG(inode->i_mode))
> > > >                 goto set_it;
> > > >
> > > >         /*
> > > >          * iomap attaches per-block state to each folio, so we cannot allow
> > > >          * the file block size to change if there's anything in the page cache.
> > > >          * In theory, fuse servers should never be doing this.
> > > >          */
> > > >         if (inode->i_mapping->nrpages > 0) {
> > > >                 WARN_ON(inode->i_blkbits != new_blkbits &&
> > > >                         inode->i_mapping->nrpages > 0);
> > > >                 return;
> > > >         }
> > > >
> > > > set_it:
> > > >         inode->i_blkbits = new_blkbits;
> > > > }
> > > >
> > > > https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/commit/?h=fuse-iomap-attrs&id=da9b25d994c1140aae2f5ebf10e54d0872f5c884
> > > >
> > > > --D
> > > >
> > > > >
> > > > > Thanks,
> > > > > Joanne
> > > > >
> 

