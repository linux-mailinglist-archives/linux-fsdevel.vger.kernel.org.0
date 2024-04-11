Return-Path: <linux-fsdevel+bounces-16686-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7964B8A169E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Apr 2024 16:06:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3206A289D11
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Apr 2024 14:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F88614EC69;
	Thu, 11 Apr 2024 14:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="eineBExc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10BA14EC65;
	Thu, 11 Apr 2024 14:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712844264; cv=none; b=ugAjZ2jIOBvWgyF1hBujnrFMxpB253OXtjAQrzQGbwyM2Rz+I4s975pFjZIqvkKXhhcg7PpPLQ5hLqP/3HcG/p1umMsQ+LfDPkpThD32AKN8uYhwhs8vgzxmnC8SuMUoaE87WaTEO4nDSX3gueEVERECqG3YIFoEOWD3Y7dm4JA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712844264; c=relaxed/simple;
	bh=gihQwpakVutMbLBonTVuKNz5kxcJWSPGQwRN437WK1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cpGUxGR3iTNH79kwgFVLyHszxTaAg9HbehfjhxRUG/MCaKEF/gjzmCStE+8G4IJsg/uyYqnFbOL2mSpcSk6EJuRGQRnvvz0gT481V1LEjPeY7eLIuiRBGHwCFCNjHKL7JZDC0jjSwUmGw6M8RxFuXnFP4dKLR4VtKFk6dEz2lcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=eineBExc; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=MtUwAGjJnFuYECwzi8OJUzaGZ1EJ3z4laESCtNlddXE=; b=eineBExcCtD8BX5/XfaNzhNJcu
	PZLmkMYLCBVL7Msr8Pd+UA0gV+RzAy6TBxZBKh+24+VZEj+YrEbyErOFpPxXNpkF2glql3lHqbXBl
	w7NWiNdmK6yHL1lX4aeAjKPQCFTuPqpwgoztINm2Lcj5SOTnaDpgJMrNiMlJ/K+zius7v80fv6Yz0
	HhZ1iMb85SzpcifrL8ammEhueovB4qVnuOjhpgdoBE6scI5C59RvqMAHxuRbMvUeHor98BlcVcfIA
	mcG8nRC95KQtwwETOfwgsnpJ9i5RqMLT/TiAGV17X/dJB8wQQgDfh+LLIpGG3BXSwBqvJ/bh5IYrf
	a6FMdNGg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1ruv2A-00AXIJ-07;
	Thu, 11 Apr 2024 14:04:10 +0000
Date: Thu, 11 Apr 2024 15:04:09 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Yu Kuai <yukuai1@huaweicloud.com>, hch@lst.de,
	axboe@kernel.dk, linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org, yi.zhang@huawei.com,
	yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH vfs.all 22/26] block: stash a bdev_file to read/write raw
 blcok_device
Message-ID: <20240411140409.GH2118490@ZenIV>
References: <3567de30-a7ce-b639-fa1f-805a8e043e18@huaweicloud.com>
 <20240407015149.GG538574@ZenIV>
 <21d1bfd6-76f7-7ffb-34a4-2a85644674fe@huaweicloud.com>
 <20240407030610.GI538574@ZenIV>
 <8f414bc5-44c6-fe71-4d04-6aef3de8c5e3@huaweicloud.com>
 <20240409042643.GP538574@ZenIV>
 <49f99e7b-3983-8074-bb09-4b093c1269d1@huaweicloud.com>
 <20240410105911.hfxz4qh3n5ekrpqg@quack3>
 <20240410223443.GG2118490@ZenIV>
 <20240411-logik-besorgen-b7d590d6c1e9@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240411-logik-besorgen-b7d590d6c1e9@brauner>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, Apr 11, 2024 at 01:56:03PM +0200, Christian Brauner wrote:
> On Wed, Apr 10, 2024 at 11:34:43PM +0100, Al Viro wrote:
> > On Wed, Apr 10, 2024 at 12:59:11PM +0200, Jan Kara wrote:
> > 
> > > I agree with Christian and Al - and I think I've expressed that already in
> > > the previous version of the series [1] but I guess I was not explicit
> > > enough :). I think the initial part of the series (upto patch 21, perhaps
> > > excluding patch 20) is a nice cleanup but the latter part playing with
> > > stashing struct file is not an improvement and seems pointless to me. So
> > > I'd separate the initial part cleaning up the obvious places and let
> > > Christian merge it and then we can figure out what (if anything) to do with
> > > remaining bd_inode uses in fs/buffer.c etc. E.g. what Al suggests with
> > > bd_mapping makes sense to me but I didn't check what's left after your
> > > initial patches...
> > 
> > FWIW, experimental on top of -next:
> 
> Ok, let's move forward with this. I've applied the first 19 patches.
> Patch 20 is the start of what we all disliked. 21 is clearly a bugfix
> for current code so that'll go separately from the rest. I've replaced
> open-code f_mapping access with file_mapping(). The symmetry between
> file_inode() and file_mapping() is quite nice.
> 
> Al, your idea to switch erofs away from buf->inode can go on top of what
> Yu did imho. There's no real reason to throw it away imho.
> 
> I've exported bdev_mapping() because it really makes the btrfs change a
> lot slimmer and we don't need to care about messing with a lot of that
> code. I didn't care about making it static inline because that might've
> meant we need to move other stuff into the header as well. Imho, it's
> not that important but if it's a big deal to any of you just do the
> changes on top of it, please.
> 
> Pushed to
> https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git vfs.super
> 
> If I hear no objections that'll show up in -next tomorrow. Al, would be
> nice if you could do your changes on top of this, please.

Objection: start with adding bdev->bd_mapping, next convert the really
obvious instances to it and most of this series becomes not needed at
all.

Really.  There is no need whatsoever to push struct file down all those
paths.

And yes, erofs and buffer.c stuff belongs on top of that, no arguments here.

