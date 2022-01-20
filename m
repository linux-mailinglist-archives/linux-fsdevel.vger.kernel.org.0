Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6912495678
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jan 2022 23:48:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378117AbiATWs6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Jan 2022 17:48:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347411AbiATWs5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Jan 2022 17:48:57 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 285B8C061574;
        Thu, 20 Jan 2022 14:48:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E231CB81E88;
        Thu, 20 Jan 2022 22:48:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44B20C340E0;
        Thu, 20 Jan 2022 22:48:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642718934;
        bh=R2iHnMQoN78/8C8ZNGY75u8Jki974eki9FfAL/hTqOY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=n77d2NNiMJcXQpEvyxAHtn+/C0DDdnVmN7s8HZlcyGGcZjb46P7bzWCKn7Xwe26HR
         x2TzhtJAvq0zwaHfs7NCI2Clhz6zp9cL1Yke5OnV6I62amkJ4qTzIrMJo7J/kzbGqv
         /ySSgqb+zN2Iv7LvIcfUFZz3Tpux2Pty9KiagvByWB8Cfn7IOt6ivAIUhOZhL5Mh6+
         ct8YrBTiKgmVWKtUcEf8Ntbj1aaFywP/t8XTm+w4yPU/C8YWwy9qfW0BxtNbPOcZ8Z
         NaPbCzEK9fY2Bz5aDAFgOqC6Hxd/v1W2zpj9CgNLZ1KICOYEJk4L4ypF6sdtwEdn38
         8mf1AuIJTTDrQ==
Date:   Thu, 20 Jan 2022 14:48:52 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-xfs@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
Subject: Re: [PATCH v10 0/5] add support for direct I/O with fscrypt using
 blk-crypto
Message-ID: <Yenm1Ipx87JAlyXg@sol.localdomain>
References: <20220120071215.123274-1-ebiggers@kernel.org>
 <YekdnxpeunTGfXqX@infradead.org>
 <20220120171027.GL13540@magnolia>
 <YenIcshA706d/ziV@sol.localdomain>
 <20220120210027.GQ13540@magnolia>
 <20220120220414.GH59729@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220120220414.GH59729@dread.disaster.area>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 21, 2022 at 09:04:14AM +1100, Dave Chinner wrote:
> On Thu, Jan 20, 2022 at 01:00:27PM -0800, Darrick J. Wong wrote:
> > On Thu, Jan 20, 2022 at 12:39:14PM -0800, Eric Biggers wrote:
> > > On Thu, Jan 20, 2022 at 09:10:27AM -0800, Darrick J. Wong wrote:
> > > > On Thu, Jan 20, 2022 at 12:30:23AM -0800, Christoph Hellwig wrote:
> > > > > On Wed, Jan 19, 2022 at 11:12:10PM -0800, Eric Biggers wrote:
> > > > > > 
> > > > > > Given the above, as far as I know the only remaining objection to this
> > > > > > patchset would be that DIO constraints aren't sufficiently discoverable
> > > > > > by userspace.  Now, to put this in context, this is a longstanding issue
> > > > > > with all Linux filesystems, except XFS which has XFS_IOC_DIOINFO.  It's
> > > > > > not specific to this feature, and it doesn't actually seem to be too
> > > > > > important in practice; many other filesystem features place constraints
> > > > > > on DIO, and f2fs even *only* allows fully FS block size aligned DIO.
> > > > > > (And for better or worse, many systems using fscrypt already have
> > > > > > out-of-tree patches that enable DIO support, and people don't seem to
> > > > > > have trouble with the FS block size alignment requirement.)
> > > > > 
> > > > > It might make sense to use this as an opportunity to implement
> > > > > XFS_IOC_DIOINFO for ext4 and f2fs.
> > > > 
> > > > Hmm.  A potential problem with DIOINFO is that it doesn't explicitly
> > > > list the /file/ position alignment requirement:
> > > > 
> > > > struct dioattr {
> > > > 	__u32		d_mem;		/* data buffer memory alignment */
> > > > 	__u32		d_miniosz;	/* min xfer size		*/
> > > > 	__u32		d_maxiosz;	/* max xfer size		*/
> > > > };
> > > 
> > > Well, the comment above struct dioattr says:
> > > 
> > > 	/*
> > > 	 * Direct I/O attribute record used with XFS_IOC_DIOINFO
> > > 	 * d_miniosz is the min xfer size, xfer size multiple and file seek offset
> > > 	 * alignment.
> > > 	 */
> > > 
> > > So d_miniosz serves that purpose already.
> > > 
> > > > 
> > > > Since I /think/ fscrypt requires that directio writes be aligned to file
> > > > block size, right?
> > > 
> > > The file position must be a multiple of the filesystem block size, yes.
> > > Likewise for the "minimum xfer size" and "xfer size multiple", and the "data
> > > buffer memory alignment" for that matter.  So I think XFS_IOC_DIOINFO would be
> > > good enough for the fscrypt direct I/O case.
> > 
> > Oh, ok then.  In that case, just hoist XFS_IOC_DIOINFO to the VFS and
> > add a couple of implementations for ext4 and f2fs, and I think that'll
> > be enough to get the fscrypt patchset moving again.
> 
> On the contrary, I'd much prefer to see this information added to
> statx(). The file offset alignment info is a property of the current
> file (e.g. XFS can have different per-file requirements depending on
> whether the file data is hosted on the data or RT device, etc) and
> so it's not a fixed property of the filesystem.
> 
> statx() was designed to be extended with per-file property
> information, and we already have stuff like filesystem block size in
> that syscall. Hence I would much prefer that we extend it with the
> DIO properties we need to support rather than "create" a new VFS
> ioctl to extract this information. We already have statx(), so let's
> use it for what it was intended for.
> 

I assumed that XFS_IOC_DIOINFO *was* per-file.  XFS's *implementation* of it
looks at the filesystem only, but that would be the expected implementation if
the DIO constraints don't currently vary between different files in XFS.

If DIO constraints do in fact already vary between different files in XFS, is
this just a bug in the XFS implementation of XFS_IOC_DIOINFO?  Or was
XFS_IOC_DIOINFO only ever intended to report per-filesystem state?  If the
latter, then yes, that would mean it wouldn't really be suitable to reuse to
start reporting per-file state.  (Per-file state is required for encrypted
files.  It's also required for other filesystem features; e.g., files that use
compression or fs-verity don't support direct I/O at all.)

- Eric
