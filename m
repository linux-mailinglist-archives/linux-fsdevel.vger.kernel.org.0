Return-Path: <linux-fsdevel+bounces-56154-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD716B14226
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Jul 2025 20:44:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DB8C3B7D50
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Jul 2025 18:43:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03F3A277036;
	Mon, 28 Jul 2025 18:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PGonoDtf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 575C5275865;
	Mon, 28 Jul 2025 18:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753728226; cv=none; b=V2Erkn6FJSlzMUtha8X+eM14dsL9ili3mYrIiQfbPpEvONoCP27Ru8PkDsVgMxyt0Ge9202sSICtY6Ck44vYd2fY64q9OnKdhCcWg9HcMnNcXKKMu60Lt80zh/mJ/jE9b0zzU9LPrBUAcblUsrEq0M/Uc5QnCSyeWz449OVjs2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753728226; c=relaxed/simple;
	bh=Xf2hz7TOpHiqBdd1wuMT/dAEUrQ8nRBxTAfDXorLxU8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HyJuCpbpWF7d5nVyK9bTIhBlhXcOY2D69fv55y/qSW4oCQdpxHX1iPCQw9ToxI0Ti1hekmN3wSbhHTv0G3TZ2wGuojXoV/zbryUi8OlVHMuXVVDM8AMfrEoqWTy9Dd3ZjdD72z5ydUyjHonFPXAua5Bo9CVQUTxxG3muqpdn6qE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PGonoDtf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D73DBC4CEE7;
	Mon, 28 Jul 2025 18:43:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753728225;
	bh=Xf2hz7TOpHiqBdd1wuMT/dAEUrQ8nRBxTAfDXorLxU8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PGonoDtfZcvl4wAegtfBny9SfyLgEdPZ27t2cNxooJOOn3HuA8bv503WJHRlBWw0/
	 eRHqrzV0jjMHylmDZZNHQmabfShEAPIMCTA+6v1TbNYHmXM5mwc5veRqJOkB9SFatm
	 QgmCQSwmGMSi8qzCSGVdY0s4VM0QW8NWHY4pcn8hrkYlXjTlhvl+KRJFmH0zOQTjB+
	 L4nkGlTuiKbMhtS04JXLwE5XksrSz631g+p6/m+cxUPSNQ6fRCEWFJEVcqadPsa5qg
	 UOmtGppTOwPpVOmC5RhDP0mOrG+qsh2uqkcn2cW7wOipOny757apZjWhLb4uHEWnKM
	 gFFSo9qi/pHyA==
Date: Mon, 28 Jul 2025 11:43:45 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Matthew Wilcox <willy@infradead.org>,
	Naresh Kamboju <naresh.kamboju@linaro.org>,
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
Message-ID: <20250728184345.GD2672070@frogsfrogsfrogs>
References: <CA+G9fYs5AdVM-T2Tf3LciNCwLZEHetcnSkHsjZajVwwpM2HmJw@mail.gmail.com>
 <20250723144637.GW2672070@frogsfrogsfrogs>
 <CAJnrk1Z7wcB8uKWcrAuRAZ8B-f8SKnOuwtEr-=cHa+ApR_sgXQ@mail.gmail.com>
 <20250723212020.GY2672070@frogsfrogsfrogs>
 <CAJnrk1bFWRTGnpNhW_9MwSYZw3qPnPXZBeiwtPSrMhCvb9C3qg@mail.gmail.com>
 <CAJnrk1byTVJtuOyAyZSVYrusjhA-bW6pxBOQQopgHHbD3cDUHw@mail.gmail.com>
 <CAJnrk1ZYR=hM5k90H57tOv=fe6F-r8dO+f3wNuCT_w3j8YNYNQ@mail.gmail.com>
 <aIe0ouF9tsuIO58_@casper.infradead.org>
 <CAJnrk1aXvVf7jaK9_2PamK5X+1b+crT+kmn8vktv0nxqCtcW8g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJnrk1aXvVf7jaK9_2PamK5X+1b+crT+kmn8vktv0nxqCtcW8g@mail.gmail.com>

On Mon, Jul 28, 2025 at 10:55:42AM -0700, Joanne Koong wrote:
> On Mon, Jul 28, 2025 at 10:34 AM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Fri, Jul 25, 2025 at 06:16:15PM -0700, Joanne Koong wrote:
> > > > > > > Also, I just noticed that apparently the blocksize can change
> > > > > > > dynamically for an inode in fuse through getattr replies from the
> > > > > > > server (see fuse_change_attributes_common()). This is a problem since
> > > > > > > the iomap uses inode->i_blkbits for reading/writing to the bitmap. I
> > > > > > > think we will have to cache the inode blkbits in the iomap_folio_state
> > > > > > > struct unfortunately :( I'll think about this some more and send out a
> > > > > > > patch for this.
> >
> > Does this actually happen in practice, once you've started _using_ the
> > block device?  Rather than all this complicated stuff to invalidate the

For most block device filesystems?  No.  And as far as I can tell, none
of the filesystems actually support changing i_blkbits on the fly; I
think only block devices can do that:

$ git grep 'i_blkbits\s=\s'
block/bdev.c:150:       BD_INODE(bdev)->i_blkbits = blksize_bits(bsize);
block/bdev.c:209:               inode->i_blkbits = blksize_bits(size);
fs/ceph/inode.c:81:     inode->i_blkbits = CEPH_FSCRYPT_BLOCK_SHIFT;
fs/ceph/inode.c:1071:           inode->i_blkbits = CEPH_FSCRYPT_BLOCK_SHIFT;
fs/ceph/inode.c:1076:           inode->i_blkbits = CEPH_BLOCK_SHIFT;
fs/ceph/inode.c:1180:           inode->i_blkbits = PAGE_SHIFT;
fs/direct-io.c:612:     unsigned int i_blkbits = sdio->blkbits + sdio->blkfactor;
fs/direct-io.c:908:     const unsigned i_blkbits = blkbits + sdio->blkfactor;
fs/direct-io.c:1110:    unsigned i_blkbits = READ_ONCE(inode->i_blkbits);
fs/erofs/fscache.c:527: inode->i_blkbits = EROFS_SB(sb)->blkszbits;
fs/fuse/file_iomap.c:2327:      inode->i_blkbits = new_blkbits;
fs/fuse/inode.c:304:            inode->i_blkbits = new_blkbits;
fs/inode.c:234: inode->i_blkbits = sb->s_blocksize_bits;
fs/libfs.c:1761:        inode->i_blkbits = PAGE_SHIFT;
fs/ocfs2/aops.c:2123:   unsigned int i_blkbits = inode->i_sb->s_blocksize_bits;
fs/orangefs/orangefs-utils.c:320:                       inode->i_blkbits = ffs(new_op->downcall.resp.getattr.
fs/smb/client/cifsfs.c:411:     cifs_inode->netfs.inode.i_blkbits = 14;  /* 2**14 = CIFS_MAX_MSGSIZE */
fs/stack.c:72:  dest->i_blkbits = src->i_blkbits;
fs/vboxsf/utils.c:123:  inode->i_blkbits = 12;

> > page cache based on the fuse server telling us something, maybe just
> > declare the server to be misbehaving and shut the whole filesystem down?
> >
> 
> I don't think this case is likely at all but I guess one scenario
> where the server might want to change the block size midway through is
> if they send the data to some network filesystem on the backend and if
> that backend shuts down or is at full capacity for whatever reason and
> they need to migrate to another backend that uses a different block
> size then I guess this would be useful for that.

Maybe, but it would still be pretty extraordinary to change the block
size on an open file -- any program that tries to do its IO in blocks
(i.e. not a byte stream) has already stat'd the file and will be very
confused.

> fuse currently does allow the block size to be changed dynamically so
> I'm not sure if we can change that behavior without breaking backwards
> compatibility.

<nod> For fuse+iomap I'm not going to allow it initially if there's
anything in the pagecache ... but I could be talked into it.

--D

