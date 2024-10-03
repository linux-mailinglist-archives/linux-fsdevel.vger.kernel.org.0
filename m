Return-Path: <linux-fsdevel+bounces-30839-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECE3598EA88
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Oct 2024 09:39:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30A1FB22D2C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Oct 2024 07:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 177B312C460;
	Thu,  3 Oct 2024 07:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gvZoT49b"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1485613D8A3;
	Thu,  3 Oct 2024 07:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727941088; cv=none; b=QX7cjHS+3NPsw1XF8DdU13yXrvLHaFOzYzTl7fh4+aFuC3PKgXH1uZZllV1xiXA/sHCKf5AsZqrBlJAOsRW5oeIJ+k2a80s/nBxEi0uRbL2LsJMDvs4V3DFNUkE4jBXcWKkhouWCLQ/DMDiiT91mHGormpcBb61jA8EvfhBI6ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727941088; c=relaxed/simple;
	bh=Z8vxIMP8M5qWA1eWQH4xk72EVHr7rDe+WWkK7RKFCKk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e2db529ixbUAuhNOhapE6jb+Z4W62mDgi5i2QUAbeF5BhUGatCovigvz/gARSKmQ1K0O+EAi6qqlKUVTl1FJL8G5Rjglw0emosBX62eg81pzor4BKxLfpc7loNkk2rsHHlyM7Z029KF3LhKgA0+01TgGTUKQRbaOp4Vhqp1w4H8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=gvZoT49b; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=8OnmhiQjCnWTVMeAh5YC42peUZpmpY/M4dDvvKxMHi4=; b=gvZoT49bQWyRtbkYqv0gR67IkY
	lso8bhxu9Y17FdTd36poSIFeQYYQ4I/XQIv9Vu78yjP+9ZJvaUSQxqK8EEB31QrmBCwZC4THB+kKK
	y7R+sQ2cGAfUNclQTeP7Hxy0pbJKjtW1KublKGmQaIsxZY5tyfG5csw67GTLqykHAFv+tB+Y6A0zP
	xaT5nBf92OoESVvE+tSUCm11d38Lpn7kfp4XPruqVjd/sfO72t2jYe1nibEzQzqVTlaLrubEuAgvv
	j5YWHJkJwXTGL0MZj5JAEEKbSg+Ln4QdTwjoqBZ33tj6fcrVmsMI9aZZNvvSRHUYVCq4eRAF7z+5B
	uWGeBC3g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1swGPV-00000008P6G-2Qbd;
	Thu, 03 Oct 2024 07:38:05 +0000
Date: Thu, 3 Oct 2024 00:38:05 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Dave Chinner <david@fromorbit.com>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-bcachefs@vger.kernel.org, kent.overstreet@linux.dev,
	torvalds@linux-foundation.org,
	=?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@linux.microsoft.com>,
	Jann Horn <jannh@google.com>, Serge Hallyn <serge@hallyn.com>,
	Kees Cook <keescook@chromium.org>,
	linux-security-module@vger.kernel.org, Jan Kara <jack@suse.cz>,
	Amir Goldstein <amir73il@gmail.com>
Subject: Re: lsm sb_delete hook, was Re: [PATCH 4/7] vfs: Convert
 sb->s_inodes iteration to super_iter_inodes()
Message-ID: <Zv5J3VTGqdjUAu1J@infradead.org>
References: <20241002014017.3801899-1-david@fromorbit.com>
 <20241002014017.3801899-5-david@fromorbit.com>
 <Zv5GfY1WS_aaczZM@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zv5GfY1WS_aaczZM@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Oct 03, 2024 at 12:23:41AM -0700, Christoph Hellwig wrote:
> On Wed, Oct 02, 2024 at 11:33:21AM +1000, Dave Chinner wrote:
> > --- a/security/landlock/fs.c
> > +++ b/security/landlock/fs.c
> > @@ -1223,109 +1223,60 @@ static void hook_inode_free_security_rcu(void *inode_security)
> >  
> >  /*
> >   * Release the inodes used in a security policy.
> > - *
> > - * Cf. fsnotify_unmount_inodes() and invalidate_inodes()
> >   */
> > +static int release_inode_fn(struct inode *inode, void *data)
> 
> Looks like this is called from the sb_delete LSM hook, which
> is only implemented by landlock, and only called from
> generic_shutdown_super, separated from evict_inodes only by call
> to fsnotify_sb_delete.  Why did LSM not hook into that and instead

An the main thing that fsnotify_sb_delete does is yet another inode
iteration..

Ay chance you all could get together an figure out how to get down
to a single sb inode iteration per unmount?


