Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C24C495574
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jan 2022 21:39:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377656AbiATUjS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Jan 2022 15:39:18 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:39686 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229701AbiATUjS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Jan 2022 15:39:18 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B045D61834;
        Thu, 20 Jan 2022 20:39:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9512C340E0;
        Thu, 20 Jan 2022 20:39:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642711156;
        bh=xHyJV2OF1Wme9jGp3aO4nKBDG16B8D+4M9ewndf2eJc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mXLj0tywklYTXnw6izq3AIlPI96bKEb6CLyl+fLbQESaYmG1kISbixIyFAv/S46Yt
         c3w5LXM0tWf7J4YyUpYmBMvJfRLefA1hgMgn0qeGwsxM2fMFZcmVdHiBwREeqoh+Bj
         U5cKYdGF1Zwo5HRRQ/D6nYOFBwCGrr26BzMfnPtcGXUP+Wv4ZGHpTCuuhQ2JBijA4h
         4aoYP4S5J+7wdukl7VBSaO/CKCgyDxK0dy/8QciVjrp0hOtcXOMuN3kyj1aD3vBBZn
         oy6iTnANsohSdKfd13BW8GoWBfQ63urh/ZWj8SglSPCOw4zdk3yK2mi4cq2SLUmDAU
         LHZ1eZC58PDsg==
Date:   Thu, 20 Jan 2022 12:39:14 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-xfs@vger.kernel.org, Dave Chinner <david@fromorbit.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
Subject: Re: [PATCH v10 0/5] add support for direct I/O with fscrypt using
 blk-crypto
Message-ID: <YenIcshA706d/ziV@sol.localdomain>
References: <20220120071215.123274-1-ebiggers@kernel.org>
 <YekdnxpeunTGfXqX@infradead.org>
 <20220120171027.GL13540@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220120171027.GL13540@magnolia>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 20, 2022 at 09:10:27AM -0800, Darrick J. Wong wrote:
> On Thu, Jan 20, 2022 at 12:30:23AM -0800, Christoph Hellwig wrote:
> > On Wed, Jan 19, 2022 at 11:12:10PM -0800, Eric Biggers wrote:
> > > 
> > > Given the above, as far as I know the only remaining objection to this
> > > patchset would be that DIO constraints aren't sufficiently discoverable
> > > by userspace.  Now, to put this in context, this is a longstanding issue
> > > with all Linux filesystems, except XFS which has XFS_IOC_DIOINFO.  It's
> > > not specific to this feature, and it doesn't actually seem to be too
> > > important in practice; many other filesystem features place constraints
> > > on DIO, and f2fs even *only* allows fully FS block size aligned DIO.
> > > (And for better or worse, many systems using fscrypt already have
> > > out-of-tree patches that enable DIO support, and people don't seem to
> > > have trouble with the FS block size alignment requirement.)
> > 
> > It might make sense to use this as an opportunity to implement
> > XFS_IOC_DIOINFO for ext4 and f2fs.
> 
> Hmm.  A potential problem with DIOINFO is that it doesn't explicitly
> list the /file/ position alignment requirement:
> 
> struct dioattr {
> 	__u32		d_mem;		/* data buffer memory alignment */
> 	__u32		d_miniosz;	/* min xfer size		*/
> 	__u32		d_maxiosz;	/* max xfer size		*/
> };

Well, the comment above struct dioattr says:

	/*
	 * Direct I/O attribute record used with XFS_IOC_DIOINFO
	 * d_miniosz is the min xfer size, xfer size multiple and file seek offset
	 * alignment.
	 */

So d_miniosz serves that purpose already.

> 
> Since I /think/ fscrypt requires that directio writes be aligned to file
> block size, right?

The file position must be a multiple of the filesystem block size, yes.
Likewise for the "minimum xfer size" and "xfer size multiple", and the "data
buffer memory alignment" for that matter.  So I think XFS_IOC_DIOINFO would be
good enough for the fscrypt direct I/O case.

The real question is whether there are any direct I/O implementations where
XFS_IOC_DIOINFO would *not* be good enough, for example due to "xfer size
multiple" != "file seek offset alignment" being allowed.  In that case we would
need to define a new ioctl that is more general (like the one you described
below) rather than simply uplifting XFS_IOC_DIOINFO.

More general is nice, but it's not helpful if no one will actually use the extra
information.  So we need to figure out what is actually useful.

> How about something like this:
> 
> struct dioattr2 {
> 	__u32		d_mem;		/* data buffer memory alignment */
> 	__u32		d_miniosz;	/* min xfer size		*/
> 	__u32		d_maxiosz;	/* max xfer size		*/
> 
> 	/* file range must be aligned to this value */
> 	__u32		d_min_fpos;
> 
> 	/* for optimal performance, align file range to this */
> 	__u32		d_opt_fpos;
> 
> 	__u32		d_padding[11];
> };
> 

- Eric
