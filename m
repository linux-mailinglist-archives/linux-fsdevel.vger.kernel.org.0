Return-Path: <linux-fsdevel+bounces-15058-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 065608866E7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Mar 2024 07:41:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 388511C23735
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Mar 2024 06:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1006118EC3;
	Fri, 22 Mar 2024 06:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="o2mIpHFa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D8C81170D;
	Fri, 22 Mar 2024 06:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711089605; cv=none; b=Waf3ZV+nooBgB+nM8hFJlA3M37eeIIRt6LgEJ3TG3+x6rYyZtrz+LscsHpm0ltloMM0J51e3JsBM5NTn05hGLpSgZCtWsKk0s5qhoiDI+C7vHoGGQxOsm8vJ1T1j43CxRDwSmcKsJAZeh5yORtagzjWEXkEWs8jNJrEyozpzOME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711089605; c=relaxed/simple;
	bh=29hLko/Jr7H8xJFSRYu3ewxVf5dCg4UdNfDDUPV0OQY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=orBCzucAmR93ptXEomxnBkmF2l+jPt767jVJwTuBRpGCLc+VLJ7LRv1cbQFV/9j65kvKwMTl1W1Dhu0FqjRq8YRjLxri1fB1Qz4Qx+OHIPVaK2hSDGztRr3zXMVrmdF6xXdmkDOmc/o7Ay2CQUbYUwaXnWoSlZIuTc8U9yEmSag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=o2mIpHFa; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=oJcZrzZCo5AkTnLJKFS7QB8znxJHvbpkqsB5dW0jHH4=; b=o2mIpHFalEtmEbo7aiwpUVnHkh
	6ucWJVB4X4/4UxcXrKvXR+68W0QNn6lQFz6yknjJDlRVAZNui37QvwWrUKnJGS6usB2ohoKL55BOM
	VGoh+tOozhZt8CNJLYufODme3QDAppeWfzFCfi6tB3ebK+bqMfH7Y3MglTqA7LJzoo8JNkxD0Sy2F
	5pnKfL3rwyhQSTsDRRwEc+weJSPJ5ixkCFr8vrwau+K78V+OK1/O6fz36klubJy2LHpQeRJsTJXqb
	NOdawZKXjkNG+0iUccrrQBpLt57KBCB1Mthtru8tCFvwjYM5OpbqjV5vbWMIuhG8v6AuDshEEU/yH
	zdEYv5uA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rnYZH-00EKgl-0v;
	Fri, 22 Mar 2024 06:39:55 +0000
Date: Fri, 22 Mar 2024 06:39:55 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>,
	brauner@kernel.org, axboe@kernel.dk, linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org, yi.zhang@huawei.com,
	yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [RFC v4 linux-next 19/19] fs & block: remove bdev->bd_inode
Message-ID: <20240322063955.GM538574@ZenIV>
References: <20240317213847.GD10665@lst.de>
 <022204e6-c387-b4b2-5982-970fd1ed5b5b@huaweicloud.com>
 <20240318013208.GA23711@lst.de>
 <5c231b60-a2bf-383e-e641-371e7e57da67@huaweicloud.com>
 <ea4774db-188e-6744-6a5b-0096f6206112@huaweicloud.com>
 <20240318232245.GA17831@lst.de>
 <c62dac0e-666f-9cc9-cffe-f3d985029d6a@huaweicloud.com>
 <20240321112737.33xuxfttrahtvbej@quack3>
 <240b78df-257e-a97c-31ff-a8b1b1882e80@huaweicloud.com>
 <20240322063718.GC3404528@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240322063718.GC3404528@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Mar 22, 2024 at 06:37:18AM +0000, Al Viro wrote:
> On Thu, Mar 21, 2024 at 08:15:06PM +0800, Yu Kuai wrote:
> 
> > > blkdev_iomap_begin() etc. may be an arbitrary filesystem block device
> > > inode. But why can't you use I_BDEV(inode->i_mapping->host) to get to the
> > > block device instead of your file_bdev(inode->i_private)? I don't see any
> > > advantage in stashing away that special bdev_file into inode->i_private but
> > > perhaps I'm missing something...
> > > 
> > 
> > Because we're goning to remove the 'block_device' from iomap and
> > buffer_head, and replace it with a 'bdev_file'.
> 
> What of that?  file_inode(file)->f_mapping->host will give you bdevfs inode
> just fine...

file->f_mapping->host, obviously - sorry.

