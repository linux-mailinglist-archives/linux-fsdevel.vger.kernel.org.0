Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75B094952EA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jan 2022 18:10:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347556AbiATRKa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Jan 2022 12:10:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236190AbiATRKa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Jan 2022 12:10:30 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A3BEC061574;
        Thu, 20 Jan 2022 09:10:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C885CB81DB6;
        Thu, 20 Jan 2022 17:10:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95112C340E3;
        Thu, 20 Jan 2022 17:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642698627;
        bh=9PrP2YPwXIw91H36sa+ARSocJ1Cu1ipD8VSQgbT6nsA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bhOy/kkCPk22TFeoPt2RuBI8RgWYvZQ4Q+WFtZjvDyGcYQVZUpqdG5f0VUgm48K0h
         MAJ5Td5mQTsGy6R0nKSPKNAuHmiQRFPMWGOJK0pWRMbGTYMDpHnksDXZGhe+pFPQ2d
         2bRQbwL3T+pLDBMnj01EyoieNkhV45F1Lhh+r8UZIrzDKk3rGWTMRZ8eBzL1W/BOxs
         K4eeC/S6bq53oHhxE60pa3B/MiQmgmzr/9Z4AzvnfHWnNqy5BEjJG3IXdYfiP2Cr91
         RQPzfu7rc3eq7EC08CEIDJzpjFAiTI8wtD7IcmJ6LCNRyIcL3jl6mSk+xkPhQS/8FW
         ZcRex+d8Jee8A==
Date:   Thu, 20 Jan 2022 09:10:27 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Eric Biggers <ebiggers@kernel.org>, linux-fscrypt@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
        Dave Chinner <david@fromorbit.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
Subject: Re: [PATCH v10 0/5] add support for direct I/O with fscrypt using
 blk-crypto
Message-ID: <20220120171027.GL13540@magnolia>
References: <20220120071215.123274-1-ebiggers@kernel.org>
 <YekdnxpeunTGfXqX@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YekdnxpeunTGfXqX@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 20, 2022 at 12:30:23AM -0800, Christoph Hellwig wrote:
> On Wed, Jan 19, 2022 at 11:12:10PM -0800, Eric Biggers wrote:
> > 
> > Given the above, as far as I know the only remaining objection to this
> > patchset would be that DIO constraints aren't sufficiently discoverable
> > by userspace.  Now, to put this in context, this is a longstanding issue
> > with all Linux filesystems, except XFS which has XFS_IOC_DIOINFO.  It's
> > not specific to this feature, and it doesn't actually seem to be too
> > important in practice; many other filesystem features place constraints
> > on DIO, and f2fs even *only* allows fully FS block size aligned DIO.
> > (And for better or worse, many systems using fscrypt already have
> > out-of-tree patches that enable DIO support, and people don't seem to
> > have trouble with the FS block size alignment requirement.)
> 
> It might make sense to use this as an opportunity to implement
> XFS_IOC_DIOINFO for ext4 and f2fs.

Hmm.  A potential problem with DIOINFO is that it doesn't explicitly
list the /file/ position alignment requirement:

struct dioattr {
	__u32		d_mem;		/* data buffer memory alignment */
	__u32		d_miniosz;	/* min xfer size		*/
	__u32		d_maxiosz;	/* max xfer size		*/
};

Since I /think/ fscrypt requires that directio writes be aligned to file
block size, right?

> > I plan to propose a new generic ioctl to address the issue of DIO
> > constraints being insufficiently discoverable.  But until then, I'm

Which is what I suspect Eric meant by this sentence. :)

> > wondering if people are willing to consider this patchset again, or
> > whether it is considered blocked by this issue alone.  (And if this
> > patchset is still unacceptable, would it be acceptable with f2fs support
> > only, given that f2fs *already* only allows FS block size aligned DIO?)
> 
> I think the patchset looks fine, but I'd really love to have a way for
> the alignment restrictions to be discoverable from the start.

I agree.  The mechanics of the patchset look ok to me, but it's very
unfortunate that there's no way for userspace programs to ask the kernel
about the directio geometry for a file.

Ever since we added reflink to XFS I've wanted to add a way to tell
userspace that direct writes to a reflink(able) file will be much more
efficient if they can align the io request to 1 fs block instead of 1
sector.

How about something like this:

struct dioattr2 {
	__u32		d_mem;		/* data buffer memory alignment */
	__u32		d_miniosz;	/* min xfer size		*/
	__u32		d_maxiosz;	/* max xfer size		*/

	/* file range must be aligned to this value */
	__u32		d_min_fpos;

	/* for optimal performance, align file range to this */
	__u32		d_opt_fpos;

	__u32		d_padding[11];
};

--D
