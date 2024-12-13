Return-Path: <linux-fsdevel+bounces-37264-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25FAB9F03E7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 05:50:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1904116A0C2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 04:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FCB816EB76;
	Fri, 13 Dec 2024 04:50:38 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC0363D;
	Fri, 13 Dec 2024 04:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734065438; cv=none; b=ngoBE/3zNpS47gvqf6pQ8jVK/1SKnjGiFyw7NWRwlC+Cy9ak2Z7Eba3eqjUIZt5xHpj1nc9nCYSJqqx7iU59T2tDIlq7/DbEAChcym/6S64SJitHYi3k5qanCfUq59PSRzeAflkPMdyIH2AA2BD3XGbeQA3E8wdO/xdjeaDKKRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734065438; c=relaxed/simple;
	bh=lJBmq1Osd4wHwFS0x6g/24foZUyQvb6cjPRsBe4nhW0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ha8/bJyln0vHQ6qIVntngBZHE60GCiH9K6W/wL3SvBjgAMgbIc3Sks0i8DQ7WdzJrse3+T9Lm8devQmGruR7/1PZMF5njvxQJ1eUokAaIcjqLHYM4gYbcH70a+upAPqfMd5im3VLHDr0LDO/bExbd/VuSz9U6i9Sdo5/wByxujQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id BBF1368BEB; Fri, 13 Dec 2024 05:50:32 +0100 (CET)
Date: Fri, 13 Dec 2024 05:50:32 +0100
From: Christoph Hellwig <hch@lst.de>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Christian Brauner <brauner@kernel.org>,
	Carlos Maiolino <cem@kernel.org>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 4/8] iomap: split bios to zone append limits in the
 submission handlers
Message-ID: <20241213045032.GD5281@lst.de>
References: <20241211085420.1380396-1-hch@lst.de> <20241211085420.1380396-5-hch@lst.de> <20241212195149.GH6678@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241212195149.GH6678@frogsfrogsfrogs>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Dec 12, 2024 at 11:51:49AM -0800, Darrick J. Wong wrote:
> > +struct iomap_ioend *iomap_split_ioend(struct iomap_ioend *ioend, bool is_append,
> 
> Can you determine is_append from (ioend->io_flags & ZONE_APPEND)?

That would require us to add that flag first :)  As we don't really
need that as persistent per-iomap that it's probably not worth it.

> Also it's not clear to me what the initial and output state of
> *alloc_len is supposed to be?  I guess you set it to the number of bytes
> the @ioend covers?

It gets set to the number of blocks that the allocator could find,
and iomap_split_ioend decrements the amount of that it used for the
ioend returned, which is min(*alloc_len, max_zone_append_sectors) for
sequential zones, or *alloc_len for conventional zones.

> > +++ b/include/linux/iomap.h
> > @@ -354,6 +354,9 @@ struct iomap_ioend {
> >  	struct list_head	io_list;	/* next ioend in chain */
> >  	u16			io_flags;	/* IOMAP_IOEND_* */
> >  	struct inode		*io_inode;	/* file being written to */
> > +	atomic_t		io_remaining;	/* completetion defer count */
> > +	int			io_error;	/* stashed away status */
> > +	struct iomap_ioend	*io_parent;	/* parent for completions */
> 
> I guess this means ioends can chain together, sort of like how bios can
> when you split them?

Exactly.


