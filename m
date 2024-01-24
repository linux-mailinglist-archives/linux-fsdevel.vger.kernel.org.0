Return-Path: <linux-fsdevel+bounces-8818-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EF4483B3EA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 22:28:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37E3E282486
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 21:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E33F81353F5;
	Wed, 24 Jan 2024 21:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dIaQRd+e"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B6D1353E8;
	Wed, 24 Jan 2024 21:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706131692; cv=none; b=qLfkKgWNPaO3n+wuxsFkfhdALqG74Yit1tHLecdvSnaArOAjIHeZZsmSjLVXWD1mPB/WHd4a7YCp84+N6roUCsSxeDBx0LNImQfp19cOQ/tzCrp+7qLOEa7IyU8OwGBSXo5fKPoG+mEZfVZx+Hp8W9YCsTPai14HZQbNTEQAuU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706131692; c=relaxed/simple;
	bh=UX1UXmZWt37nkOf4mR3wodCc43qU62lzxUpnPIZNuz0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MSfxhupbTBtIf1XigRMH/JcWlQ+iLDR7l0i1rPMVRBT02vM85wgMPU7rIS8e7faCd1mzECM8KUYBWqUymKMkvKGlbcO3qrP9e194ty62vjwxBH9bIPw2wyHcT7JEQ+5oYXB6Z7wixQdIM6XW9Q4s8/X3/5MffIqoWUGv26t+tUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=dIaQRd+e; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=1SpAV+QcIr7SS1AHHKV0ativcTA0Jo6hkPow9b937bc=; b=dIaQRd+efHofPQiPt7r6wctxee
	H/UWZ+5LkGM3iLpgmEigP03OfZFg+NEJpAcZAF+jcv1b2JQJ0+BnjrbZDmc5IUPGd0eWvjqYh3GKQ
	QKSDGvvbJYV806PzenzEhGDonVYV11xUy9MTCDppt0eCn48FHkphf57tKGLMERfNQOYozzDi0+lYE
	2046xQ8/pQ1ZB9B/l1xH7bHgQe2OTc/2AXEQOMqxlk+kSCOtlTeUdq17tYgr2vY1/8K8ZA6rI5hEb
	vwHB7ofJJ9ZPau3pwvTzMY1//BBHWPFkQRU4rH3hY9huwbKKWbiWZXTNPmRrU77nwVU0rBshw/8cK
	zPKwxH6g==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rSkmz-00000007qQ0-3vSG;
	Wed, 24 Jan 2024 21:28:05 +0000
Date: Wed, 24 Jan 2024 21:28:05 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Dave Chinner <david@fromorbit.com>
Cc: Wedson Almeida Filho <wedsonaf@gmail.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Kent Overstreet <kent.overstreet@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-fsdevel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	Wedson Almeida Filho <walmeida@microsoft.com>
Subject: Re: [RFC PATCH 19/19] tarfs: introduce tar fs
Message-ID: <ZbGA5RPWGNsqRTuj@casper.infradead.org>
References: <20231018122518.128049-1-wedsonaf@gmail.com>
 <20231018122518.128049-20-wedsonaf@gmail.com>
 <ZbCap4F41vKC1PcE@casper.infradead.org>
 <ZbCetzTxkq8o7O52@casper.infradead.org>
 <CANeycqpk14H34NYiF5z-+Oi7G9JV00vVeqvyGYjaZunXAbqEWg@mail.gmail.com>
 <ZbF7lfiH4QAg3X8T@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZbF7lfiH4QAg3X8T@dread.disaster.area>

On Thu, Jan 25, 2024 at 08:05:25AM +1100, Dave Chinner wrote:
> On Wed, Jan 24, 2024 at 03:26:03PM -0300, Wedson Almeida Filho wrote:
> > So what is the recommended way? Which file systems are using it (so I
> > can do something similar)?
> 
> e.g. btrfs_read_dev_one_super(). Essentially, if your superblock is
> at block zero in the block device:
> 
> 	struct address_space *mapping = bdev->bd_inode->i_mapping;
> 
> 	......
> 
> 	page = read_cache_page_gfp(mapping, 0, GFP_NOFS);
>         if (IS_ERR(page))
>                 return ERR_CAST(page);
> 
>         super = page_address(page);
> 
> And now you have a pointer to your in memory buffer containing the
> on-disk superblock. If the sueprblock is not at block zero, then
> replace the '0' passed to read_cache_page_gfp() with whatever page
> cache index the superblock can be found at....

Just to modify this slightly ...

	folio = read_mapping_folio(mapping, pos / PAGE_SIZE);
	if (IS_ERR(folio))
		return ERR_CAST(folio);
	super = folio_address(folio) + offset_in_folio(folio, pos);

... and then in your shutdown path, you'll need to call folio_put().
Maybe that's easiest done in Rust by "leaking" the folio into the
in-memory super block so it doesn't get dropped at the end of the
function?

I don't think you need the GFP_NOFS.  We don't have a superblock yet, so
we can't call back into the filesystem.

