Return-Path: <linux-fsdevel+bounces-46902-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B077A960D6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 10:17:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 000BB7ABA8C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 08:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 916661F0E34;
	Tue, 22 Apr 2025 08:17:42 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81EFB8632B;
	Tue, 22 Apr 2025 08:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745309862; cv=none; b=KXTs73qWN+wlYh+y0XCOTvhD4Rf9WBqgXHehkIv4R0UazzdPaHYsKs4MKUpWZ3ES3fDJ4w3UclAPLU9RRuqQ+NBZyVBJSOVeJDWyBRlkP8SHwB+tXGUe76EbBqg+PimGj/bFOBAEW7indmqzq9WsNc9eVe0FbUtbbctDcIlk510=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745309862; c=relaxed/simple;
	bh=RtxmEEkdtmZ0sE8AF47rmj86Q5wcp/CwSKLGEbccWgs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b27xjJWZ4/2Y7oE31EhqpiLdbuIlrpFxqs4YYFyuPrp2B+1KkgA5odWz3VGpehbj6Rz2PLhtpeuXlbDuVOkUAGkvYBTeQqOPUlQNZzUG8kPifHdr/CJwlPOg+1voU5p4FdlM/2QKPVidLSx0gheRWyhip4PAKn0I9N5CxgJFOfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id B908D68AA6; Tue, 22 Apr 2025 10:17:36 +0200 (CEST)
Date: Tue, 22 Apr 2025 10:17:36 +0200
From: hch <hch@lst.de>
To: Christian Brauner <brauner@kernel.org>
Cc: hch <hch@lst.de>, Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	"viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
	"axboe@kernel.dk" <axboe@kernel.dk>,
	"djwong@kernel.org" <djwong@kernel.org>,
	"ebiggers@google.com" <ebiggers@google.com>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] fs: move the bdex_statx call to vfs_getattr_nosec
Message-ID: <20250422081736.GA674@lst.de>
References: <20250417064042.712140-1-hch@lst.de> <xrvvwm7irr6dldsbfka3c4qjzyc4zizf3duqaroubd2msrbjf5@aiexg44ofiq3> <20250422055149.GB29356@lst.de> <20250422-angepackt-reisen-bc24fbec2702@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250422-angepackt-reisen-bc24fbec2702@brauner>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Apr 22, 2025 at 10:15:48AM +0200, Christian Brauner wrote:
> > -	bdev = blkdev_get_no_open(backing_inode->i_rdev);
> > +	if (!(request_mask & (STATX_DIOALIGN | STATX_WRITE_ATOMIC)))
> > +		return;
> 
> This leaks the block device reference if blkdev_get_no_open() succeeds.
> 
> > +
> > +	bdev = blkdev_get_no_open(d_backing_inode(path->dentry)->i_rdev);

The one removed by the patch above, or the one added after the check
below? :)


