Return-Path: <linux-fsdevel+bounces-8180-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A00A830AFB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jan 2024 17:24:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D66A1C2088D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jan 2024 16:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E92D224D2;
	Wed, 17 Jan 2024 16:24:30 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3F0E224C0;
	Wed, 17 Jan 2024 16:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705508669; cv=none; b=DuB5Ud9cCjXlj2cFNZYATk4+GydhW9jxVwN77ZiJqVbWTK2XCU4FHq+6sov91lgc+cu+cNq4GFaCUP0E6yHQS2zyhTqbr260AnI1EwrXiDCdaaEej8GY84sP2UOp4g5qYHUzsKYboO8iI5vPLXh5uzaRXuujlA4dzeseBj0YMNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705508669; c=relaxed/simple;
	bh=AhAqjPRBUkWh+WRs5zkD/a0Ftwh2rzm7NdC8V+mLlNU=;
	h=Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 User-Agent; b=VwUEOmz/li7yO9HfExq5g2RPE+ZoGikcPRLjimklnQcM5dIGLNUBfphmN5Yt1CJwXdrEnn/f+5RhrxUvqVYdOPJAiwwRQoC+JqLkac4pN2vszDTSWMz58/vocYg5f8tQPYqljfmI7rl4o15PTPKBv4SKZFVhDo8E8ekHvwLrVBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id BD63F68C7B; Wed, 17 Jan 2024 17:24:23 +0100 (CET)
Date: Wed, 17 Jan 2024 17:24:23 +0100
From: Christoph Hellwig <hch@lst.de>
To: Jan Kara <jack@suse.cz>
Cc: Dave Chinner <david@fromorbit.com>,
	Christian Brauner <brauner@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	"Darrick J. Wong" <djwong@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH DRAFT RFC 34/34] buffer: port block device access to
 files and get rid of bd_inode access
Message-ID: <20240117162423.GA3849@lst.de>
References: <20240103-vfs-bdev-file-v1-0-6c8ee55fb6ef@kernel.org> <20240103-vfs-bdev-file-v1-34-6c8ee55fb6ef@kernel.org> <ZZuNgqLNimnMBTIC@dread.disaster.area> <20240117161500.bibuljso32a2a26y@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240117161500.bibuljso32a2a26y@quack3>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Jan 17, 2024 at 05:15:00PM +0100, Jan Kara wrote:
> > >  	iomap->bdev = bdev;
> > > +	BUG_ON(true /* TODO(brauner): This is the only place where we don't go from inode->i_sb->s_f_bdev for obvious reasons. Thoughts? */);
> > 
> > Maybe block devices should have their own struct file created when the
> > block device is instantiated and torn down when the block device is
> > trashed?
> 
> OK, but is there a problem with I_BDEV() which is currently used in
> blkdev_iomap_begin()?

Well, blkdev_iomap_begin is always called on the the actual bdev fs
inode that is allocated together with the bdev itself.  So we'll always
be able to get to it using container_of variants.


