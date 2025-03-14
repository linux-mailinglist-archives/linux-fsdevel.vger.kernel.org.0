Return-Path: <linux-fsdevel+bounces-44036-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E38BA616D1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Mar 2025 17:53:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E04F03BB50A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Mar 2025 16:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6C082040A4;
	Fri, 14 Mar 2025 16:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MyoQ0uiB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3784118B494;
	Fri, 14 Mar 2025 16:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741971181; cv=none; b=Fd0Ssg4NHu6amqlrXW/CybJk0O6g8yOJBaOsWFSVv9CLIT8i7LlOU65Xjs1VMLAUcpOeMpH4TkfDuDRWOXl41Ff20aD+DE7EHKc+CKHWvjhYn2fouca0C2CHi9pQzuzaCtkjL0a+X0dwUzMxmn7VD+gfmt4B0onTMjEdoRMjJOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741971181; c=relaxed/simple;
	bh=GgvNtudod6MsiKhII9sHkQgjx23EQwv8yeDBHX7lU28=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rYqquATn0WOyBdYsYVz3HvfXYq6C+d8ARHBO06S6fga+fukWnISgTXIWBWzqlC2EOq687JU9kKkda2o1ZMsl2fEEluEVhd+glN7xxC92zbIFutHDcyLp4Xtl048bBRW9Vbc2KtSuyJf/ouSPTEdOLO5GN5cNvUJQ/+XAaiZ2cTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MyoQ0uiB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BEC7C4CEE3;
	Fri, 14 Mar 2025 16:53:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741971180;
	bh=GgvNtudod6MsiKhII9sHkQgjx23EQwv8yeDBHX7lU28=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MyoQ0uiBkIltzLC74gkKBirnrR+rCzb1Aq40afi0VqiBeYlLyfvcg2HFGKhpo49+F
	 zVMS0w7qJaidSNSdZG42U1glyidLpbE2cqvCnz/XrKXY1B57NF9aOmHxZQzcgTjoyJ
	 g8AkyP11XHKejz4/FUzisntNsS0pZlXwuNLvSCoCSWUrXyfwq9vy4LmyrFiRGJvH1q
	 PjiT61JX6tqASGi3nQUO82hCJut8mIW5t0ux/AKn/9WW/7FHcZ3fLQBQRITjKXsbw/
	 /WpB1ETPavZAFeecEDhAJ9TMxvc+y7/WwjfOvXZB0S+Tp+nI9eBRPCyHKQdKE7gdQO
	 XANnX52FaFFOg==
Date: Fri, 14 Mar 2025 09:53:00 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Christoph Hellwig <hch@lst.de>, Kanchan Joshi <joshi.k@samsung.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
	Qu Wenruo <wqu@suse.com>, Goldwyn Rodrigues <rgoldwyn@suse.com>,
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: Re: [PATCH 3/7] iomap: add bioset in iomap_read_folio_ops for
 filesystems to use own bioset
Message-ID: <20250314165300.GF2803730@frogsfrogsfrogs>
References: <20250203094322.1809766-1-hch@lst.de>
 <20250203094322.1809766-4-hch@lst.de>
 <Z9Ljd-AwJGnk7f2D@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9Ljd-AwJGnk7f2D@casper.infradead.org>

On Thu, Mar 13, 2025 at 01:53:59PM +0000, Matthew Wilcox wrote:
> On Mon, Feb 03, 2025 at 10:43:07AM +0100, Christoph Hellwig wrote:
> > Allocate the bio from the bioset provided in iomap_read_folio_ops.
> > If no bioset is provided, fs_bio_set is used which is the standard
> > bioset for filesystems.
> 
> It feels weird to have an 'ops' that contains a bioset rather than a
> function pointer.  Is there a better name we could be using?  ctx seems
> wrong because it's not a per-op struct.

"profile" is the closest I can come up with, and that feels wrong to me.
There's at least some precedent in fs-land for ops structs that have
non-function pointer fields such as magic numbers, descriptive names,
or crc block offsets.

--D

> 
> > +++ b/include/linux/iomap.h
> > @@ -311,6 +311,12 @@ struct iomap_read_folio_ops {
> >  	 */
> >  	void (*submit_io)(struct inode *inode, struct bio *bio,
> >  			  loff_t file_offset);
> > +
> > +	/*
> > +	 * Optional, allows filesystem to specify own bio_set, so new bio's
> > +	 * can be allocated from the provided bio_set.
> > +	 */
> > +	struct bio_set *bio_set;
> >  };
> 

