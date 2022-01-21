Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F006495861
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jan 2022 03:36:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348449AbiAUCgI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Jan 2022 21:36:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244394AbiAUCgI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Jan 2022 21:36:08 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEEBFC061574;
        Thu, 20 Jan 2022 18:36:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 55A02B81D84;
        Fri, 21 Jan 2022 02:36:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEF61C340E0;
        Fri, 21 Jan 2022 02:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642732564;
        bh=7WwbHgXEEmyGk8VsUc9soyxxvD8Rd4CVOIzfWVbGxgg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TJWHvQOYkvpukFEO29VsctzeUshaTt9r4j2tPBeTNRkhlOAXQFmschOiLFwTw6Vgu
         kC1CNn/nzXp7xSsldL30IPcWqUdgLtC1WKXtNmnG11pqmtpicA1Hs++8V/A012/q7x
         4mPI8QRzywjj+HqybFxooxhslpzJjRRCyU3i5ec7nJwO/9wPnVvvOmpe9SQDa/dkM7
         6rE7wpJ6XE3K4YGGCFPBxob2vexcsDcGHAPAAmhcnrY8Q5+rPbXfAIaqLMpL1a3PWT
         I0CXVQab1nmPAnsYio6Mnl6xT1TdoYFeBAUlqZdOlZCK6LiWewa1WyG/oOjDmSxpES
         btPl9CCCv+54w==
Date:   Thu, 20 Jan 2022 18:36:03 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Eric Biggers <ebiggers@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-xfs@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
Subject: Re: [PATCH v10 0/5] add support for direct I/O with fscrypt using
 blk-crypto
Message-ID: <20220121023603.GH13563@magnolia>
References: <20220120071215.123274-1-ebiggers@kernel.org>
 <YekdnxpeunTGfXqX@infradead.org>
 <20220120171027.GL13540@magnolia>
 <YenIcshA706d/ziV@sol.localdomain>
 <20220120210027.GQ13540@magnolia>
 <20220120220414.GH59729@dread.disaster.area>
 <Yenm1Ipx87JAlyXg@sol.localdomain>
 <20220120235755.GI59729@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220120235755.GI59729@dread.disaster.area>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 21, 2022 at 10:57:55AM +1100, Dave Chinner wrote:
> On Thu, Jan 20, 2022 at 02:48:52PM -0800, Eric Biggers wrote:
> > On Fri, Jan 21, 2022 at 09:04:14AM +1100, Dave Chinner wrote:
> > > On Thu, Jan 20, 2022 at 01:00:27PM -0800, Darrick J. Wong wrote:
> > > > On Thu, Jan 20, 2022 at 12:39:14PM -0800, Eric Biggers wrote:
> > > > > On Thu, Jan 20, 2022 at 09:10:27AM -0800, Darrick J. Wong wrote:
> > > > > > On Thu, Jan 20, 2022 at 12:30:23AM -0800, Christoph Hellwig wrote:
> > > > > > > On Wed, Jan 19, 2022 at 11:12:10PM -0800, Eric Biggers wrote:
> > > > > > > > 
> > > > > > > > Given the above, as far as I know the only remaining objection to this
> > > > > > > > patchset would be that DIO constraints aren't sufficiently discoverable
> > > > > > > > by userspace.  Now, to put this in context, this is a longstanding issue
> > > > > > > > with all Linux filesystems, except XFS which has XFS_IOC_DIOINFO.  It's
> > > > > > > > not specific to this feature, and it doesn't actually seem to be too
> > > > > > > > important in practice; many other filesystem features place constraints
> > > > > > > > on DIO, and f2fs even *only* allows fully FS block size aligned DIO.
> > > > > > > > (And for better or worse, many systems using fscrypt already have
> > > > > > > > out-of-tree patches that enable DIO support, and people don't seem to
> > > > > > > > have trouble with the FS block size alignment requirement.)
> > > > > > > 
> > > > > > > It might make sense to use this as an opportunity to implement
> > > > > > > XFS_IOC_DIOINFO for ext4 and f2fs.
> > > > > > 
> > > > > > Hmm.  A potential problem with DIOINFO is that it doesn't explicitly
> > > > > > list the /file/ position alignment requirement:
> > > > > > 
> > > > > > struct dioattr {
> > > > > > 	__u32		d_mem;		/* data buffer memory alignment */
> > > > > > 	__u32		d_miniosz;	/* min xfer size		*/
> > > > > > 	__u32		d_maxiosz;	/* max xfer size		*/
> > > > > > };
> > > > > 
> > > > > Well, the comment above struct dioattr says:
> > > > > 
> > > > > 	/*
> > > > > 	 * Direct I/O attribute record used with XFS_IOC_DIOINFO
> > > > > 	 * d_miniosz is the min xfer size, xfer size multiple and file seek offset
> > > > > 	 * alignment.
> > > > > 	 */
> > > > > 
> > > > > So d_miniosz serves that purpose already.
> > > > > 
> > > > > > 
> > > > > > Since I /think/ fscrypt requires that directio writes be aligned to file
> > > > > > block size, right?
> > > > > 
> > > > > The file position must be a multiple of the filesystem block size, yes.
> > > > > Likewise for the "minimum xfer size" and "xfer size multiple", and the "data
> > > > > buffer memory alignment" for that matter.  So I think XFS_IOC_DIOINFO would be
> > > > > good enough for the fscrypt direct I/O case.
> > > > 
> > > > Oh, ok then.  In that case, just hoist XFS_IOC_DIOINFO to the VFS and
> > > > add a couple of implementations for ext4 and f2fs, and I think that'll
> > > > be enough to get the fscrypt patchset moving again.
> > > 
> > > On the contrary, I'd much prefer to see this information added to
> > > statx(). The file offset alignment info is a property of the current
> > > file (e.g. XFS can have different per-file requirements depending on
> > > whether the file data is hosted on the data or RT device, etc) and
> > > so it's not a fixed property of the filesystem.
> > > 
> > > statx() was designed to be extended with per-file property
> > > information, and we already have stuff like filesystem block size in
> > > that syscall. Hence I would much prefer that we extend it with the
> > > DIO properties we need to support rather than "create" a new VFS
> > > ioctl to extract this information. We already have statx(), so let's
> > > use it for what it was intended for.

Eh, ok.  Let's do that instead.

> > > 
> > 
> > I assumed that XFS_IOC_DIOINFO *was* per-file.  XFS's *implementation* of it
> > looks at the filesystem only,
> 
> You've got that wrong.
> 
>         case XFS_IOC_DIOINFO: {
> >>>>>>          struct xfs_buftarg      *target = xfs_inode_buftarg(ip);
>                 struct dioattr          da;
> 
>                 da.d_mem =  da.d_miniosz = target->bt_logical_sectorsize;
> 
> xfs_inode_buftarg() is determining which block device the inode is
> storing it's data on, so the returned dioattr values can be
> different for different inodes in the filesystem...
> 
> It's always been that way since the early Irix days - XFS RT devices
> could have very different IO constraints than the data device and
> DIO had to conform to the hardware limits underlying the filesystem.
> Hence the dioattr information has -always- been per-inode
> information.
> 
> > (Per-file state is required for encrypted
> > files.  It's also required for other filesystem features; e.g., files that use
> > compression or fs-verity don't support direct I/O at all.)
> 
> Which is exactly why is should be a property of statx(), rather than
> try to re-use a ~30 year old filesystem specific API from a
> different OS that was never intended to indicate things like "DIO
> not supported on this file at all"....

Heh.  You mean like ALLOCSP?  Ok ok point taken.

> We've been bitten many times by this "lift a rarely used filesystem
> specific ioctl to the VFS because it exists" method of API
> promotion. It almost always ends up in us discovering further down
> the track that there's something wrong with the API, it doesn't
> quite do what we need, we have to extend it anyway, or it's just
> plain borken, etc. And then we have to create a new, fit for purpose
> API anyway, and there's two VFS APIs we have to maintain forever
> instead of just one...
> 
> Can we learn from past mistakes this time instead of repeating them
> yet again?

Sure.  How's this?  I couldn't think of a real case of directio
requiring different alignments for pos and bytecount, so the only real
addition here is the alignment requirements for best performance.

struct statx {
...
	/* 0x90 */
	__u64	stx_mnt_id;

	/* Memory buffer alignment required for directio, in bytes. */
	__u32	stx_dio_mem_align;

	/* File range alignment required for directio, in bytes. */
	__u32	stx_dio_fpos_align_min;

	/* 0xa0 */

	/* File range alignment needed for best performance, in bytes. */
	__u32	stx_dio_fpos_align_opt;

	/* Maximum size of a directio request, in bytes. */
	__u32	stx_dio_max_iosize;

	__u64	__spare3[11];	/* Spare space for future expansion */
	/* 0x100 */
};

Along with:

#define STATX_DIRECTIO	0x00001000U	/* Want/got directio geometry */

How about that?

--D

> 
> Cheers,
> 
> Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
