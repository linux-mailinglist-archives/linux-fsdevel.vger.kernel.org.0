Return-Path: <linux-fsdevel+bounces-8268-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE98B831E8C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jan 2024 18:40:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 855451F226F2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jan 2024 17:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8B5A2D610;
	Thu, 18 Jan 2024 17:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PNzyOt15"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE362D600;
	Thu, 18 Jan 2024 17:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705599603; cv=none; b=eLkoVhl71ebZv67KFK4JuudCcj9p2tOpidmLKf5XGEWZ3mVO3mijYIwLhnx7hHVCByrNogkdrBkIEGAj3uEhqBvWhovIudveOnQgPc1krO1aInG0ODirNSVuL3S3OKC9j/LH8eSKzPDHJxqLppyGdDvmpB2TWRCpnvZSsZzB4Pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705599603; c=relaxed/simple;
	bh=8L+YmHvYij4VY/Oe4mtPd+Y5x3BdD8KOqkQPtQQDVQ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HxLnIidl2wUtV+Fg+rL3lv5DJ1bZNoYXNzpwECKsqN5laXsnV+q58G35zmVGlCN4E5lBXdy5f0k3cQlKcdxF9bU7i1EN7UvYdjCrDGyHRLyljUiqd2BQQSs5Ez8+F1foa1zQRTzyPoGh8OyhXei+wBFCQv5f9mwiZ4xJg3ZMHwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PNzyOt15; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D32BC433C7;
	Thu, 18 Jan 2024 17:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705599602;
	bh=8L+YmHvYij4VY/Oe4mtPd+Y5x3BdD8KOqkQPtQQDVQ0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PNzyOt15pqhREQvg1zqLozy3Rb+XjH/DWFk6Bddfp28F1mLlxAR5PF1wzOgWg2Fnn
	 4A90ozGHKepZBaFnBo6bCsrAvxF2ZR1aGLLiSUyjtF3M4nYgjbaWNKIhwEPvnnMArk
	 yAggh6UqIvJtDE7z+fNmcQBLxrxUongkG7vt36Z1hOEsPwGKtNv3Q0pP4YRtH+wT/g
	 j7zT5cctWt9h5J+3tzaL4S+2fjgduRIjMT8xo7nmA3/l0yfLLZZOtTU7goqZ3/w+ln
	 DWeB0YKTg04tuXFtLoyadsQC/b6ltbqET4nRPKyZU3ic5YNktT1I2SPkijRaxZxgOM
	 pZ41dQKbpTEbw==
Date: Thu, 18 Jan 2024 18:39:57 +0100
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>
Cc: Dave Chinner <david@fromorbit.com>, Jens Axboe <axboe@kernel.dk>, 
	"Darrick J. Wong" <djwong@kernel.org>, linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH DRAFT RFC 34/34] buffer: port block device access to
 files and get rid of bd_inode access
Message-ID: <20240118-gemustert-aalen-ee71d0c69826@brauner>
References: <20240103-vfs-bdev-file-v1-0-6c8ee55fb6ef@kernel.org>
 <20240103-vfs-bdev-file-v1-34-6c8ee55fb6ef@kernel.org>
 <ZZuNgqLNimnMBTIC@dread.disaster.area>
 <20240117161500.bibuljso32a2a26y@quack3>
 <20240117162423.GA3849@lst.de>
 <20240117163336.glysm6rzsrbjatjt@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240117163336.glysm6rzsrbjatjt@quack3>

On Wed, Jan 17, 2024 at 05:33:36PM +0100, Jan Kara wrote:
> On Wed 17-01-24 17:24:23, Christoph Hellwig wrote:
> > On Wed, Jan 17, 2024 at 05:15:00PM +0100, Jan Kara wrote:
> > > > >  	iomap->bdev = bdev;
> > > > > +	BUG_ON(true /* TODO(brauner): This is the only place where we don't go from inode->i_sb->s_f_bdev for obvious reasons. Thoughts? */);
> > > > 
> > > > Maybe block devices should have their own struct file created when the
> > > > block device is instantiated and torn down when the block device is
> > > > trashed?
> > > 
> > > OK, but is there a problem with I_BDEV() which is currently used in
> > > blkdev_iomap_begin()?
> > 
> > Well, blkdev_iomap_begin is always called on the the actual bdev fs
> > inode that is allocated together with the bdev itself.  So we'll always
> > be able to get to it using container_of variants.
> 
> Yes, that was exactly my point.

So my point is that if we want to have all code pass a file and we have
code in fs/buffer.c like iomap_to_bh():

iomap_to_bh(struct inode *inode, sector_t block, struct buffer_head *bh,
        loff_t offset = block << inode->i_blkbits;

        bh->b_bdev = iomap->bdev;
+       bh->f_b_bdev = iomap->f_bdev;

While that works for every single filesystem that uses block devices
because they stash them somewhere (like s_bdev_file) it doesn't work for
the bdev filesystem itself. So if the bdev filesystem calls into helpers
that expect e.g., buffer_head->s_f_bdev to have been initialized from
iomap->f_bdev this wouldn't work.

So if we want to remove b_bdev from struct buffer_head and fully rely on
f_b_bdev - and similar in iomap - then we need a story for the bdev fs
itself. And I wasn't clear on what that would be. Dave's suggestion
would obviously work iirc. Maybe you're poking my nose at something very
obvious and I don't see it yet?

Fyi, I had planned to leave that patch out of the next revision anyway
because I can merge the generic part without it as it stands on its own.

