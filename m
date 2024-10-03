Return-Path: <linux-fsdevel+bounces-30867-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AB0F898EF00
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Oct 2024 14:19:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3FA7DB2223B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Oct 2024 12:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B12BB17BB3A;
	Thu,  3 Oct 2024 12:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HEKnmmiu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E09B2175D5E;
	Thu,  3 Oct 2024 12:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727957913; cv=none; b=jnOJXLHJVJCuZi34kd4ay5HD1fWA2nF6XM+WXAEgXsGUCJBFg4Jm/YtRX1o3OC2WCFJo8WDzKngGZnzRFGEFfON0EI1XYnvoRuksDzXkF+kLbZALEYaIN4uEzzyxD1ePiOdQ3GtIDR3SbC8kURLJcQEp2Nc2pTLHiD5d5wHcvSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727957913; c=relaxed/simple;
	bh=DX0aHifQC4WELy6VLEwRfvKr/72TiqNrVSFL+hCFC+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G3bPqSkmrRuyvxH/GXaCIz8GLb8sYQftUmPhuRe0rnfnraT4O/A+wX62ijnY6+M9JJCZbAPDoxSkHnCnKu9U+x1Uw5lgQ60Z2psdVjZrQ3ujqwesoQ/byhJipIHiiGYnSYZHzkjoPqOtLryt0o8MOTUNCG5AXh7t7RZc51FennU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=HEKnmmiu; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=iBvY2gXYSh/TM+TYCJrZe7vw2NoIcGXx/ni8wo0f1Uc=; b=HEKnmmiu98Gmhus8N0xI/pIG0U
	O3KutQ6ZBnCZK8obQbnj8mgsHPiL6XqgtmAdh5/ziShQ1HR3lEGu7JKti04jg55Ls3nrI8ZOo7vHe
	EiJXWma/yZmKdjfmeld4ZD6XlSPim+0GZilat6L4reSkVjEcRygFmJXnTR2Ov5ChuBh6vkc/tGzVN
	6h1AMeS890dvTvit/3bwaw5XcK7H/kB+vXzo/oNlThi2GZLqFv3GzI/PVuhTKrRmlfU+WHul2+pGq
	32VshirSexE+W3LL7uaE43PiWHBmbEZ2250PcvM5NCEKpXCkERv0xjJbHJl4HbUaBoVsO2QGG3N5m
	MlUlgP5w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1swKms-0000000902a-3slT;
	Thu, 03 Oct 2024 12:18:30 +0000
Date: Thu, 3 Oct 2024 05:18:30 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jan Kara <jack@suse.cz>
Cc: Dave Chinner <david@fromorbit.com>, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-bcachefs@vger.kernel.org,
	kent.overstreet@linux.dev, torvalds@linux-foundation.org
Subject: Re: [RFC PATCH 0/7] vfs: improving inode cache iteration scalability
Message-ID: <Zv6Llgzj7_Se1m7H@infradead.org>
References: <20241002014017.3801899-1-david@fromorbit.com>
 <20241003114555.bl34fkqsja4s5tok@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241003114555.bl34fkqsja4s5tok@quack3>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Oct 03, 2024 at 01:45:55PM +0200, Jan Kara wrote:
> /* Find next inode on the inode list eligible for processing */
> #define sb_inode_iter_next(sb, inode, old_inode, inode_eligible) 	\
> ({									\
> 	struct inode *ret = NULL;					\

<snip>

> 	ret;								\
> })

How is this going to interact with calling into the file system
to do the interaction, which is kinda the point of this series?

Sure, you could have a get_next_inode-style method, but it would need
a fair amount of entirely file system specific state that needs
to be stashed away somewhere, and all options for that looks pretty
ugly.

Also even with your pre-iget callback we'd at best halve the number
of indirect calls for something that isn't exactly performance
critical.  So while it could be done that way, it feels like a
more complex and much harder to reason about version for no real
benefit.

> #define for_each_sb_inode(sb, inode, inode_eligible)			\
> 	for (DEFINE_FREE(old_inode, struct inode *, if (_T) iput(_T)),	\
> 	     inode = NULL;						\
> 	     inode = sb_inode_iter_next((sb), inode, &old_inode,	\
> 					 inode_eligible);		\
> 	    )

And while I liked:

	obj = NULL;

	while ((obj = get_next_object(foo, obj))) {
	}

style iterators, magic for_each macros that do magic cleanup are just
a nightmare to read.  Keep it simple and optimize for someone actually
having to read and understand the code, and not for saving a few lines
of code.


