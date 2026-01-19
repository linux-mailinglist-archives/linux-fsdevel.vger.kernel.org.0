Return-Path: <linux-fsdevel+bounces-74378-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4353BD39F70
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 08:12:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F324A3057E97
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 07:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 032C92DB7A3;
	Mon, 19 Jan 2026 07:10:49 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53C9A2C326F;
	Mon, 19 Jan 2026 07:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768806648; cv=none; b=iss4rRIAulw2iqFsu6aSKBVNL8jV6CY2DLnAcP9GYECPl51lCbYLUvEZBM2WtWW4/AxhP0Dthb6Bhy3hsszaURdO5mSL2M1FbuEopPyED5Lgt6BpSc9LgMRzd06ZiY0fdmELi1aidrOZtKRhMVvEd196lSzqFVoE9hm4L/2hUWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768806648; c=relaxed/simple;
	bh=eBLzqg4bbnQwRZNqYfJgHXVoFuIswpvWUpNbXsoFh5A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NsS87TF2V5xOT9zx6Da2ryudv9tsnMd2dUjL5cYzwZCQ7d1O8TBR6uJIVaUHPAZFpaD85kFBNhutK03rkz6XY+MGbUEJryUon3N3UCdO/7J6XGCAqUZcOs9u6l2tVEZBeOvhKGuWwX22G2Ly8R1iwpzffWb2lXMWzNZHqSiFkKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id C12A4227AA8; Mon, 19 Jan 2026 08:10:39 +0100 (CET)
Date: Mon, 19 Jan 2026 08:10:38 +0100
From: Christoph Hellwig <hch@lst.de>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, viro@zeniv.linux.org.uk,
	brauner@kernel.org, tytso@mit.edu, willy@infradead.org,
	jack@suse.cz, djwong@kernel.org, josef@toxicpanda.com,
	sandeen@sandeen.net, rgoldwyn@suse.com, xiang@kernel.org,
	dsterba@suse.com, pali@kernel.org, ebiggers@kernel.org,
	neil@brown.name, amir73il@gmail.com, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, iamjoonsoo.kim@lge.com,
	cheol.lee@lge.com, jay.sim@lge.com, gunho.lee@lge.com,
	Hyunchul Lee <hyc.lee@gmail.com>
Subject: Re: [PATCH v5 06/14] ntfs: update file operations
Message-ID: <20260119071038.GC1480@lst.de>
References: <20260111140345.3866-1-linkinjeon@kernel.org> <20260111140345.3866-7-linkinjeon@kernel.org> <20260116085359.GD15119@lst.de> <CAKYAXd_RoJi5HqQV2NPvmkOTrx9AbSbuCmi=BKieENcLVW0FZg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKYAXd_RoJi5HqQV2NPvmkOTrx9AbSbuCmi=BKieENcLVW0FZg@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Sun, Jan 18, 2026 at 01:56:55PM +0900, Namjae Jeon wrote:
> > Talking about helpers, why does iomap_seek_hole/iomap_seek_data
> > not work for ntfs?
>
> Regarding iomap_seek_hole/iomap_seek_data, the default iomap
> implementation treats IOMAP_UNWRITTEN extents as holes unless they
> have dirty pages in the page cache. However, in ntfs iomap begin, the
> region between initialized_size and i_size (EOF) is mapped as
> IOMAP_UNWRITTEN. Since NTFS requires any pre-allocated regions before
> initialized_size to be physically zeroed, NTFS must treat all
> pre-allocated regions as DATA.

What do you need IOMAP_UNWRITTEN for in that case?  If the blocks have
been zeroed on-disk, they are IOMAP_MAPPED by the usual iomap standards.
If you need special treatement, it might be worth adding a separate
IOMAP_PREZEROED with clearly defined semantics instead of overloading
IOMAP_UNWRITTEN.

> 
> >
> > > +             file_accessed(iocb->ki_filp);
> > > +             ret = iomap_dio_rw(iocb, to, &ntfs_read_iomap_ops, NULL, IOMAP_DIO_PARTIAL,
> >
> > Why do you need IOMAP_DIO_PARTIAL?  That's mostly a workaround
> > for "interesting" locking in btrfs and gfs2.  If ntfs has similar
> > issues, it would be helpful to add a comment here.  Also maybe fix
> > the overly long line.
> Regarding the use of IOMAP_DIO_PARTIAL, I was not aware that it was a
> workaround for specific locking issues in some filesystems. I
> incorrectly assumed it was a flag to enable partial success when a DIO
> request exceeds the actual data length. I will remove this flags and
> fix it.

It only does short I/O for -EFAULT, which only happens if the nofault
flag on the iov_iter is set.  See the big comment in
btrfs_direct_write where that field is set about the explanation.

> > What is the reason to do the expansion here instead of in the iomap_begin
> > handler when we know we are committed to write to range?
> We can probably move it to iomap_begin(). Let me check it.

If it works better here that's also fine, just document it as it looks
a bit unusual.  Handling the cleanup on failures might be a bit easier
if it is done in the iomap loop, though.


