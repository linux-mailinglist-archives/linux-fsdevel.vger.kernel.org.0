Return-Path: <linux-fsdevel+bounces-55906-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 26AADB0FC12
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 23:20:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E85BF1AA70A3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 21:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73CB026CE36;
	Wed, 23 Jul 2025 21:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zo86CDvs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C363A2E630;
	Wed, 23 Jul 2025 21:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753305622; cv=none; b=eMssmvKyiA70yZopoLWPBVj2MS54ce0NBpE93vryJhATebnhu2K4TIjz3bCIzMgo85nd97etKorkn9DF8PTrWNmO0OFhaijZyIyLWVAhjQqK79XKQs+b44lxBMk/14EaPrBMTEWVHh06hjQB3XbjXDsepjLwkKnymJtkNZEU9+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753305622; c=relaxed/simple;
	bh=PWUwu4UTdrQzcA+D0xFyDent9rCL8sKD8yGhG/7mhvM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OZBmdx/oYeeDCCudtqSzl7s3IUH/Pq/EiZCzUXrQ5My1u7TZL2sC6Qk4MJszMWmCT9yEJzuTkFoNfBKXHGUBgi8M2O2t6chsa75CTrAX5+WC6pD0lj9H4zQqr/rshCin/Pxg5mjf1cZOpwMYFiFusqwOTBYE/O9YV7Gbzgw5WHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zo86CDvs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EBE6C4CEE7;
	Wed, 23 Jul 2025 21:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753305622;
	bh=PWUwu4UTdrQzcA+D0xFyDent9rCL8sKD8yGhG/7mhvM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Zo86CDvs5a3gnDvZN0A1QBPKKEwFF8aVsiRgdi4b86voL3YOwmIy3DDwSMCtsaBBC
	 glrqcnF26NWXKBiKcpthzcAyLv0hvoKZ8mdtMBuzoIMC5rJRpwwXYs9jOOgaUo9Bgf
	 sN53k//ZBriBvTSfcTYR9WNdEy41oh/fjwe3Bd+KCxakiYVSZlV22e4JKaNcQ4pUG+
	 Q21jFtf6ToXzw+cKqyHmkNESP39EmpeM63Bx5WQ2q333zyME/ahmWpf3Pgl4GjaWJn
	 lnXVOp+emuIBECjfQ+pA5pBHl1rqN4YeaaeP5OTLn7GEIS5NVqw/2z26A/Bo4Dx8b9
	 3eMLIPSB7WlDw==
Date: Wed, 23 Jul 2025 14:20:20 -0700
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
Message-ID: <20250723212020.GY2672070@frogsfrogsfrogs>
References: <CA+G9fYs5AdVM-T2Tf3LciNCwLZEHetcnSkHsjZajVwwpM2HmJw@mail.gmail.com>
 <20250723144637.GW2672070@frogsfrogsfrogs>
 <CAJnrk1Z7wcB8uKWcrAuRAZ8B-f8SKnOuwtEr-=cHa+ApR_sgXQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJnrk1Z7wcB8uKWcrAuRAZ8B-f8SKnOuwtEr-=cHa+ApR_sgXQ@mail.gmail.com>

On Wed, Jul 23, 2025 at 11:42:42AM -0700, Joanne Koong wrote:
> On Wed, Jul 23, 2025 at 7:46 AM Darrick J. Wong <djwong@kernel.org> wrote:
> >
> > [cc Joanne]
> >
> > On Wed, Jul 23, 2025 at 05:14:28PM +0530, Naresh Kamboju wrote:
> > > Regressions found while running LTP msync04 tests on qemu-arm64 running
> > > Linux next-20250721, next-20250722 and next-20250723 with 16K and 64K
> > > page size enabled builds.
> > >
> > > CONFIG_ARM64_64K_PAGES=y ( kernel warning as below )
> > > CONFIG_ARM64_16K_PAGES=y ( kernel warning as below )
> > >
> > > No warning noticed with 4K page size.
> > > CONFIG_ARM64_4K_PAGES=y works as expected
> >
> > You might want to cc Joanne since she's been working on large folio
> > support in fuse.
> >
> > > First seen on the tag next-20250721.
> > > Good: next-20250718
> > > Bad:  next-20250721 to next-20250723
> 
> Thanks for the report. Is there a link to the script that mounts the
> fuse server for these tests? I'm curious whether this was mounted as a
> fuseblk filesystem.
> 
> > >
> > > Regression Analysis:
> > > - New regression? Yes
> > > - Reproducibility? Yes
> > >
> > > Test regression: next-20250721 arm64 16K and 64K page size WARNING fs
> > > fuse file.c at fuse_iomap_writeback_range
> > >
> > > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> > >
> > > ## Test log
> > > ------------[ cut here ]------------
> > > [  343.828105] WARNING: fs/fuse/file.c:2146 at
> > > fuse_iomap_writeback_range+0x478/0x558 [fuse], CPU#0: msync04/4190
> >
> >         WARN_ON_ONCE(len & (PAGE_SIZE - 1));
> >
> > /me speculates that this might be triggered by an attempt to write back
> > some 4k fsblock within a 16/64k base page?
> >
> 
> I think this can happen on 4k base pages as well actually. On the
> iomap side, the length passed is always block-aligned and in fuse, we
> set blkbits to be PAGE_SHIFT so theoretically block-aligned is always
> page-aligned, but I missed that if it's a "fuseblk" filesystem, that
> isn't true and the blocksize is initialized to a default size of 512
> or whatever block size is passed in when it's mounted.

<nod> I think you're correct.

> I'll send out a patch to remove this line. It doesn't make any
> difference for fuse_iomap_writeback_range() logic whether len is
> page-aligned or not; I had added it as a sanity-check against sketchy
> ranges.
> 
> Also, I just noticed that apparently the blocksize can change
> dynamically for an inode in fuse through getattr replies from the
> server (see fuse_change_attributes_common()). This is a problem since
> the iomap uses inode->i_blkbits for reading/writing to the bitmap. I
> think we will have to cache the inode blkbits in the iomap_folio_state
> struct unfortunately :( I'll think about this some more and send out a
> patch for this.

From my understanding of the iomap code, it's possible to do that if you
flush and unmap the entire pagecache (whilst holding i_rwsem and
mmap_invalidate_lock) before you change i_blkbits.  Nobody *does* this
so I have no idea if it actually works, however.  Note that even I don't
implement the flush and unmap bit; I just scream loudly and do nothing:

void fuse_iomap_set_i_blkbits(struct inode *inode, u8 new_blkbits)
{
	trace_fuse_iomap_set_i_blkbits(inode, new_blkbits);

	if (inode->i_blkbits == new_blkbits)
		return;

	if (!S_ISREG(inode->i_mode))
		goto set_it;

	/*
	 * iomap attaches per-block state to each folio, so we cannot allow
	 * the file block size to change if there's anything in the page cache.
	 * In theory, fuse servers should never be doing this.
	 */
	if (inode->i_mapping->nrpages > 0) {
		WARN_ON(inode->i_blkbits != new_blkbits &&
			inode->i_mapping->nrpages > 0);
		return;
	}

set_it:
	inode->i_blkbits = new_blkbits;
}

https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/commit/?h=fuse-iomap-attrs&id=da9b25d994c1140aae2f5ebf10e54d0872f5c884

--D

> 
> Thanks,
> Joanne
> 
> > --D
> >
> > > [  343.830969] Modules linked in: btrfs blake2b_generic xor xor_neon
> > > raid6_pq zstd_compress sm3_ce sha3_ce drm fuse backlight ip_tables
> > > x_tables
> > > [  343.833830] CPU: 0 UID: 0 PID: 4190 Comm: msync04 Not tainted
> > > 6.16.0-rc7-next-20250723 #1 PREEMPT
> > > [  343.834736] Hardware name: linux,dummy-virt (DT)
> > > [  343.835788] pstate: 03402009 (nzcv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
> > > [  343.836455] pc : fuse_iomap_writeback_range+0x478/0x558 fuse
> > > [  343.837294] lr : iomap_writeback_folio (fs/iomap/buffered-io.c:1586
> > > fs/iomap/buffered-io.c:1710)
> > > [  343.838178] sp : ffff80008b26f8d0
> > > [  343.838668] x29: ffff80008b26f8d0 x28: fff00000e7f8c800 x27: 0000000000000000
> > > [  343.839391] x26: fff00000d4b30000 x25: 0000000000000000 x24: 0000000000000000
> > > [  343.840305] x23: 0000000000000000 x22: fffffc1fc0334200 x21: 0000000000001000
> > > [  343.840928] x20: ffff80008b26fa00 x19: 0000000000000000 x18: 0000000000000000
> > > [  343.841782] x17: 0000000000000000 x16: ffffb8d3b90c67c8 x15: 0000000000000000
> > > [  343.842565] x14: ffffb8d3ba91e340 x13: 0000ffff8ff3ffff x12: 0000000000000000
> > > [  343.843002] x11: 1ffe000004b74a21 x10: fff0000025ba510c x9 : ffffb8d3b90c6308
> > > [  343.843962] x8 : ffff80008b26f788 x7 : ffffb8d365830b90 x6 : ffffb8d3bb6c9000
> > > [  343.844718] x5 : 0000000000000000 x4 : 000000000000000a x3 : 0000000000001000
> > > [  343.845333] x2 : fff00000c0b5ecc0 x1 : 000000000000ffff x0 : 0bfffe000000400b
> > > [  343.846323] Call trace:
> > > [  343.846767] fuse_iomap_writeback_range+0x478/0x558 fuse (P)
> > > [  343.847288] iomap_writeback_folio (fs/iomap/buffered-io.c:1586
> > > fs/iomap/buffered-io.c:1710)
> > > [  343.847930] iomap_writepages (fs/iomap/buffered-io.c:1762)
> > > [  343.848494] fuse_writepages+0xa0/0xe8 fuse
> > > [  343.849112] do_writepages (mm/page-writeback.c:2634)
> > > [  343.849614] filemap_fdatawrite_wbc (mm/filemap.c:386 mm/filemap.c:376)
> > > [  343.850202] __filemap_fdatawrite_range (mm/filemap.c:420)
> > > [  343.850791] file_write_and_wait_range (mm/filemap.c:794)
> > > [  343.851108] fuse_fsync+0x6c/0x138 fuse
> > > [  343.851688] vfs_fsync_range (fs/sync.c:188)
> > > [  343.852002] __arm64_sys_msync (mm/msync.c:96 mm/msync.c:32 mm/msync.c:32)
> > > [  343.852197] invoke_syscall.constprop.0
> > > (arch/arm64/include/asm/syscall.h:61 arch/arm64/kernel/syscall.c:54)
> > > [  343.852914] do_el0_svc (include/linux/thread_info.h:135
> > > (discriminator 2) arch/arm64/kernel/syscall.c:140 (discriminator 2)
> > > arch/arm64/kernel/syscall.c:151 (discriminator 2))
> > > [  343.853389] el0_svc (arch/arm64/include/asm/irqflags.h:82
> > > (discriminator 1) arch/arm64/include/asm/irqflags.h:123 (discriminator
> > > 1) arch/arm64/include/asm/irqflags.h:136 (discriminator 1)
> > > arch/arm64/kernel/entry-common.c:169 (discriminator 1)
> > > arch/arm64/kernel/entry-common.c:182 (discriminator 1)
> > > arch/arm64/kernel/entry-common.c:880 (discriminator 1))
> > > [  343.853829] el0t_64_sync_handler (arch/arm64/kernel/entry-common.c:899)
> > > [  343.854350] el0t_64_sync (arch/arm64/kernel/entry.S:596)
> > > [  343.854652] ---[ end trace 0000000000000000 ]---
> > >
> > >
> > >
> > > ## Source
> > > * Git tree: https://kernel.googlesource.com/pub/scm/linux/kernel/git/next/linux-next.git
> > > * Project: https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20250723/
> > > * Git sha: a933d3dc1968fcfb0ab72879ec304b1971ed1b9a
> > > * Git describe: 6.16.0-rc7-next-20250723
> > > * kernel version: next-20250723
> > > * Architectures: arm64
> > > * Toolchains: gcc-13
> > > * Kconfigs: defconfig + CONFIG_ARM64_64K_PAGES=y
> > > * Kconfigs: defconfig + CONFIG_ARM64_16K_PAGES=y
> > >
> > > ## Test
> > > * Test log 1: https://qa-reports.linaro.org/api/testruns/29227309/log_file/
> > > * Test log 2: https://qa-reports.linaro.org/api/testruns/29227074/log_file/
> > > * Test run: https://regressions.linaro.org/lkft/linux-next-master/next-20250723/testruns/1713367/
> > > * Test history:
> > > https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20250723/testrun/29227309/suite/log-parser-test/test/exception-warning-fsfusefile-at-fuse_iomap_writeback_range/history/
> > > * Test plan: https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/tests/30G3hpJVVdXkZKnB15v1qoQOL03
> > > * Build link: https://storage.tuxsuite.com/public/linaro/lkft/builds/30G3dvSFyHHQ3E8CvKH7tjU98I6/
> > > * Kernel config:
> > > https://storage.tuxsuite.com/public/linaro/lkft/builds/30G3dvSFyHHQ3E8CvKH7tjU98I6/config
> > >
> > > --
> > > Linaro LKFT
> > > https://lkft.linaro.org

