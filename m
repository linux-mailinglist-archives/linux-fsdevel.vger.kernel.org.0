Return-Path: <linux-fsdevel+bounces-73602-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F3EBFD1C910
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 06:19:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7BDEF3048BB7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 04:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7E8932B997;
	Wed, 14 Jan 2026 04:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Z1hVU+SL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3370314A61;
	Wed, 14 Jan 2026 04:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768366208; cv=none; b=EczAl0qwSfBn7iwjAh9pO1wixFJvhe1zuh+oEr3c1Mqr8vwzgzk+2XJez3vob8BlUL/eKPKPpA7c/3uEMMQ7N9+pUAfaCVAhJVLQdcGxjOQNWBV6l+0Ne75bT8qFvH/rNcm/+ycLG7lC+QOdxqJAX/jENmCLWZI70nsK8DbANWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768366208; c=relaxed/simple;
	bh=zV4f8H5Axw5y7PX5oxaqR32N7N6x1IHRZCt4jHST8rM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XtgIz8QKmXKPSk7EW+9uYjTJ6037hVFyTv43tcXnsjev8W2qsjBIAadW9FjxYkNXcPSmFpI0UUU6MyAoaQ7Ep2njc90riG7e/m0VXfdVowagvcX6Zj1SmTVp84WYiUWJ3VbKekTxK0xFs4z2GLVssHpySdA6wEiMfGqG9kVi44s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Z1hVU+SL; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=IP+nt6hD0O0/EB/beIlzLBVMr0+7HCcw1mvVyCPM45Q=; b=Z1hVU+SLBG8v7sqGjxR4xeQ465
	hc5v85RX/6rCGtnSrQMmEqmVEyKWmM4r3vF3AMUSbHCDU7CtEP3vRKm2HX/RY5hN5EQ30WZeG40aP
	DnOdqEecPyxP3Rk0DmGeXAi3aq+zbfoSdl+HmdvqiahuWuWhsebbk2tnFOgf07wA82krGjC34YxZW
	3mcpKVrhEJ8R31k1uESVNM58sfp3Y8iEgIAxgCIyxFIbdSUVhlgriXxPhY3/Mlj65E+Fd4wiX9cK/
	0bgbMprLAYZIrh9gCBbPcLFdKVGVt9nL+dfKE6LieLD4FhxzhmhlbHoWFh7q77WKAi0tW9Oilr9UW
	lGz8ZMng==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vfspK-00000005hRc-3fQF;
	Wed, 14 Jan 2026 04:49:50 +0000
Date: Wed, 14 Jan 2026 04:49:50 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Christoph Hellwig <hch@lst.de>
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Andrey Albershteyn <aalbersh@redhat.com>, fsverity@lists.linux.dev,
	linux-xfs@vger.kernel.org, ebiggers@kernel.org,
	linux-fsdevel@vger.kernel.org, aalbersh@kernel.org,
	david@fromorbit.com
Subject: Re: [PATCH v2 4/22] iomap: allow iomap_file_buffered_write() take
 iocb without file
Message-ID: <aWcgbov1FmPTO2LD@casper.infradead.org>
References: <cover.1768229271.patch-series@thinky>
 <kibhid6bipmrndfn774tlbm6wcitya5qydhjws3n6tnjvbd4a3@bui63p535b3q>
 <20260112222215.GJ15551@frogsfrogsfrogs>
 <20260113081535.GC30809@lst.de>
 <aWZ2RL3oBQGUmLvF@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aWZ2RL3oBQGUmLvF@casper.infradead.org>

On Tue, Jan 13, 2026 at 04:43:48PM +0000, Matthew Wilcox wrote:
> On Tue, Jan 13, 2026 at 09:15:35AM +0100, Christoph Hellwig wrote:
> > On Mon, Jan 12, 2026 at 02:22:15PM -0800, Darrick J. Wong wrote:
> > > > +		iter.inode = iocb->ki_filp->f_mapping->host;
> > > > +	} else {
> > > > +		iter.inode = (struct inode *)private;
> > > 
> > > @private is for the filesystem implementation to access, not the generic
> > > iomap code.  If this is intended for fsverity, then shouldn't merkle
> > > tree construction be the only time that fsverity writes to the file?
> > > And shouldn't fsverity therefore have access to the struct file?
> > 
> > It's not passed down, but I think it could easily.
> 
> willy@deadly:~/kernel/linux$ git grep ki_filp |grep file_inode | wc
>     109     575    7766
> willy@deadly:~/kernel/linux$ git grep ki_filp |wc
>     367    1920   23371
> 
> I think there's a pretty strong argument for adding ki_inode to
> struct kiocb.  What do you think?

Regardless of this, I think it's an architectural mistake to not have
struct file available for reading fsverity metadata.  We do have it in
fsverity_ioctl_read_metadata but we don't have it in verify_bh().

But reading the merkel tree block from the verify_bh() completion handler
is bad for performance anyway.  We should submit the metadata reads at
the same time we submit the data reads.  And there, we would have the
struct file.

If we ever have ambitions to support merkel trees on network filesystems,
we'll need to figure out some way to pass the struct file in, so maybe
we should just bite the bullet and do this now?

