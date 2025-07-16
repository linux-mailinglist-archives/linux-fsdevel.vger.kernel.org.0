Return-Path: <linux-fsdevel+bounces-55172-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17B38B0779F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 16:09:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A99FA188623A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 14:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 906C221C192;
	Wed, 16 Jul 2025 14:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SB6tTMd4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A4C21A43C
	for <linux-fsdevel@vger.kernel.org>; Wed, 16 Jul 2025 14:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752674943; cv=none; b=AgG5kAJyetfUIz/jVcvbIC0/v5V3N5ravIGE5JTnJqYTKRWl3lleJgDW+OvYshCw/BmTdDwNxB/vInnqNTfmaQOsmQ96m3js0kJpqR5zaRKbsY5ea5Rn5ZngoK6SXL/7bLLfjdNBT3ZeZhxX0XjDCTHC9SEM2srjd2zgmRgz6Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752674943; c=relaxed/simple;
	bh=2i8GN6RTlx/yez0Wt3obsNkhoJJYVAJaRMM4o4FG0Nw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=keIsYvcuP6c12mqPuJtA9O+qVEG/iT0G6am8WnGsSzAWMoLT87NYIaSxO7nyDJ5dosS0Zh81AmdL9Ocyyu+jaUE8BcokhN/O87HX9HsxPJSGSXI5uHOfscBqNJ9Ic9Inlp1QNKW2gJv8Uh8HQrrVho+nwOY6K5NRlORcSlAZYKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=SB6tTMd4; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=emTrL+HwIRjzDNfaGNwv3cD2nmvcMwLojlHZNCLSU+8=; b=SB6tTMd4ETFqElk+vFI9TefWsu
	FYp04/wgXa/Mv2AFL4MaLAA6DcUOJe8ehXmhzTAwvjMeaDoKAiFMTBVKgOVbikuUUQfDQzZflxGFl
	JTWUZa4hCi1ZpZrsUayeMQrxj2SyHIon3d/APBDCCkiz47KLM9TtJQTNOZ2uRoUMqNPHa5QPML8fh
	MFEQqC+L6NAiQskSSJIzgDS7DTa5qDOFU3aDjt0Q1T7PlbgWOmjMKaD95P4mXnnkgrLcx/6lMEzFx
	CiRpJM4FOAPfAKQAVneFMm17ITi3WE7pX83W7rJqdPN0IwbQ5yDYW6c/Z+0vU2VvM94nEw43fiG6c
	elI/t6Ng==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uc2oY-0000000GmI9-0C2C;
	Wed, 16 Jul 2025 14:08:54 +0000
Date: Wed, 16 Jul 2025 15:08:53 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Jan Kara <jack@suse.com>, Jens Axboe <axboe@kernel.dk>,
	Josef Bacik <josef@toxicpanda.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC DRAFT DOESNOTBUILD] inode: free up more space
Message-ID: <aHeydTPax7kh5p28@casper.infradead.org>
References: <20250715-work-inode-fscrypt-v1-1-aa3ef6f44b6b@kernel.org>
 <20250716112149.GA29673@lst.de>
 <20250716-unwahr-dumpf-835be7215e4c@brauner>
 <a24e87f111509bed526dd0a1650399edda9b75c0.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a24e87f111509bed526dd0a1650399edda9b75c0.camel@kernel.org>

On Wed, Jul 16, 2025 at 08:38:08AM -0400, Jeff Layton wrote:
> On Wed, 2025-07-16 at 14:19 +0200, Christian Brauner wrote:
> > On Wed, Jul 16, 2025 at 01:21:49PM +0200, Christoph Hellwig wrote:
> > > On Tue, Jul 15, 2025 at 04:35:24PM +0200, Christian Brauner wrote:
> > > > Unless there are severe performance penalties for the extra pointer
> > > > dereferences getting our hands on 16 bytes is a good reason to at least
> > > > consider doing this.
> > > > 
> > > > I've drafted one way of doing this using ext4 as my victim^wexample. I'd
> > > > like to hear some early feedback whether this is something we would want
> > > > to pursue.
> > > 
> > > I like getting rid of the fields.  But adding all these indirect calls
> > > is a bit nasty.
> > > 
> > > Given that all these fields should be in the file system specific inode
> > > that also embeddeds the vfs struct inode, what about just putting the
> > > relative offset into struct inode_operations.
> > > 
> > > e.g. something like
> > > 
> > > 	struct inode_operations {
> > > 		...
> > > 		ptrdiff_t		i_crypto_offset;
> > > 	}
> > > 
> > > struct inode_operations foofs_iops {
> > > 	...
> > > 
> > > 	.i_crypto_offset = offsetoff(struct foofs_inode), vfs_inode) -
> > > 		offsetoff(struct foofs_inode, crypt_info);
> > > }
> > > 
> > > static inline struct fscrypt_inode_info CRYPT_I(struct inode *inode)
> > > {
> > > 	return ((void *)inode) - inode->i_op->i_cryto_offset;
> > > }
> > 
> > Sheesh, ugly in a different way imho. I could live with it. I'll let
> > @Jan be the tie-breaker.
> > 
> > I've started working on this so best tell me soon... :)
> 
> I agree with HCH. Both of these methods are equally ugly, but we
> eliminate extra function call by just storing the offset.
> 
> It may also make things simpler for debugging with drgn and the like
> too. You can just do the pointer math with the info inside struct inode
> instead of having to track down an extra function call, etc.

struct inode {
	...
};

struct filemap_inode {
	struct inode		inode;
	struct address_space	i_mapping;
	struct fscrypt_struct	i_fscrypt;
	struct fsverity_struct	i_fsverity;
	struct quota_struct	i_quota;
};

struct ext4_inode {
	struct filemap_inode inode;
	...
};

saves any messing with i_ops and offsets.

