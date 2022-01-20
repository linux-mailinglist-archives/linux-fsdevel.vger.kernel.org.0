Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 385504955B9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jan 2022 22:00:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377727AbiATVAd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Jan 2022 16:00:33 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:48280 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347149AbiATVAa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Jan 2022 16:00:30 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 400DAB81E5B;
        Thu, 20 Jan 2022 21:00:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0F31C340E0;
        Thu, 20 Jan 2022 21:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642712428;
        bh=Sgn6vsiQaVTZl6FA2Bi6v2vMumeBHvXQ8WnUp3/OgOQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Rg3DWs5KzBBcatjdrT34CEMOazOi9A8JaCoVRLZDvRuX6uUX4LDihsBfpqnhGACwl
         mQLMV34CpRp6JgYQYU7oc8ZvkXFlU98cUhrfsyxCO3aBZplrE4JLcxYjp4X2zouMD3
         a4iHIGG0S+HYkf4bJxKU/LwG2k9Z+r4GRYbpZQnHts0hmDLKtEj7dn5Yg6JQC8jYSF
         9s6uhJa5exrDusE53neADlAA1qMvq2PTuiBnYrkBDgrSRiIVaSuRDqHpqPSSvAv6YT
         rzHDLupGZd3WwwUNnWYYQ7TfYZaszzj3iKB6iAztLjBX6WklwqP0O0mc7x2TYX1AMS
         gnCMv9pVePpTQ==
Date:   Thu, 20 Jan 2022 13:00:27 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-xfs@vger.kernel.org, Dave Chinner <david@fromorbit.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
Subject: Re: [PATCH v10 0/5] add support for direct I/O with fscrypt using
 blk-crypto
Message-ID: <20220120210027.GQ13540@magnolia>
References: <20220120071215.123274-1-ebiggers@kernel.org>
 <YekdnxpeunTGfXqX@infradead.org>
 <20220120171027.GL13540@magnolia>
 <YenIcshA706d/ziV@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YenIcshA706d/ziV@sol.localdomain>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 20, 2022 at 12:39:14PM -0800, Eric Biggers wrote:
> On Thu, Jan 20, 2022 at 09:10:27AM -0800, Darrick J. Wong wrote:
> > On Thu, Jan 20, 2022 at 12:30:23AM -0800, Christoph Hellwig wrote:
> > > On Wed, Jan 19, 2022 at 11:12:10PM -0800, Eric Biggers wrote:
> > > > 
> > > > Given the above, as far as I know the only remaining objection to this
> > > > patchset would be that DIO constraints aren't sufficiently discoverable
> > > > by userspace.  Now, to put this in context, this is a longstanding issue
> > > > with all Linux filesystems, except XFS which has XFS_IOC_DIOINFO.  It's
> > > > not specific to this feature, and it doesn't actually seem to be too
> > > > important in practice; many other filesystem features place constraints
> > > > on DIO, and f2fs even *only* allows fully FS block size aligned DIO.
> > > > (And for better or worse, many systems using fscrypt already have
> > > > out-of-tree patches that enable DIO support, and people don't seem to
> > > > have trouble with the FS block size alignment requirement.)
> > > 
> > > It might make sense to use this as an opportunity to implement
> > > XFS_IOC_DIOINFO for ext4 and f2fs.
> > 
> > Hmm.  A potential problem with DIOINFO is that it doesn't explicitly
> > list the /file/ position alignment requirement:
> > 
> > struct dioattr {
> > 	__u32		d_mem;		/* data buffer memory alignment */
> > 	__u32		d_miniosz;	/* min xfer size		*/
> > 	__u32		d_maxiosz;	/* max xfer size		*/
> > };
> 
> Well, the comment above struct dioattr says:
> 
> 	/*
> 	 * Direct I/O attribute record used with XFS_IOC_DIOINFO
> 	 * d_miniosz is the min xfer size, xfer size multiple and file seek offset
> 	 * alignment.
> 	 */
> 
> So d_miniosz serves that purpose already.
> 
> > 
> > Since I /think/ fscrypt requires that directio writes be aligned to file
> > block size, right?
> 
> The file position must be a multiple of the filesystem block size, yes.
> Likewise for the "minimum xfer size" and "xfer size multiple", and the "data
> buffer memory alignment" for that matter.  So I think XFS_IOC_DIOINFO would be
> good enough for the fscrypt direct I/O case.

Oh, ok then.  In that case, just hoist XFS_IOC_DIOINFO to the VFS and
add a couple of implementations for ext4 and f2fs, and I think that'll
be enough to get the fscrypt patchset moving again.

> The real question is whether there are any direct I/O implementations where
> XFS_IOC_DIOINFO would *not* be good enough, for example due to "xfer size
> multiple" != "file seek offset alignment" being allowed.  In that case we would
> need to define a new ioctl that is more general (like the one you described
> below) rather than simply uplifting XFS_IOC_DIOINFO.

I don't think there are any currently, but if anyone ever redesigns
DIOINFO we might as well make all those pieces explicit.

> More general is nice, but it's not helpful if no one will actually use the extra
> information.  So we need to figure out what is actually useful.

<nod> Clearly I haven't wanted d_opt_fpos badly enough to propose
revving the ioctl. ;)

--D

> 
> > How about something like this:
> > 
> > struct dioattr2 {
> > 	__u32		d_mem;		/* data buffer memory alignment */
> > 	__u32		d_miniosz;	/* min xfer size		*/
> > 	__u32		d_maxiosz;	/* max xfer size		*/
> > 
> > 	/* file range must be aligned to this value */
> > 	__u32		d_min_fpos;
> > 
> > 	/* for optimal performance, align file range to this */
> > 	__u32		d_opt_fpos;
> > 
> > 	__u32		d_padding[11];
> > };
> > 
> 
> - Eric
