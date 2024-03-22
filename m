Return-Path: <linux-fsdevel+bounces-15057-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE4058866D1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Mar 2024 07:37:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A48C4286191
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Mar 2024 06:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4EF3C8E2;
	Fri, 22 Mar 2024 06:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="rc1bhDop"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F7A4409;
	Fri, 22 Mar 2024 06:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711089447; cv=none; b=fB3HM9fkLD6a542HFf4NzYvCp+sSxfFSqvjC3PeHsmJ6YmRVLgRQVhwkmaFsVX1CeoMTbmHg/pOpUJGvjxarAVpksyMLGwuyqBnCk0e6GkC90pyQPqfK/jUl6NUYtPqJab0UftCn6K26Po6ZnSkwWU4BuOZpUoOX6Z0ogla4AMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711089447; c=relaxed/simple;
	bh=ZOAVBBgkHWek4uDQ6MpxrBJ8Rw+1PUhZJ9//e/w1GeU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aisHqhHiTAvw1I38oEdUjOLq5w4Wi16w5TJT3fZdJ9oIAodZUlAE09QgXlIQ9WQ6cg0A/j+PzZprec32+qZ2AdDl5A/cK29iCTCCUhBD7G85xBu1N11IXlGUVaf5gA2viSXp2Z+DUGTafMJpoGA4mxY13R9x9Z8o5yBN605aShs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=rc1bhDop; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=4kBWhiGCfPrbhEtVUhUkNEMgXUc2o2ze+To2gCv5Z6w=; b=rc1bhDopqrdmZhMRYxJhHV6B61
	uyPEcDJ3fISQ7oXhdfZYBTRMRMgCdpzHHn4xkqtMXR1YBSQb9DN+dX+CbVjSLlb5RAuBaz5uvDg0d
	bBXdg3yP21vJldvBsZj8TcJsITMVMx2d6mLRKhMdrzbPhhvTU3LW3HQY8SUmwhkSBMVMApH9kCUv6
	QSXp+BS7KUkB1cg1CfvTaPq5oG4d0qc3tFL3ktudG+yLzusNwY7NsMGaqSzjNUrsuoh4Xy88ybwGA
	0xuAFJ18WtPoAN1nBc+OHfJHTt39wgp78GBF0rIlVwrzKKvutHGlIWq39fyVYkyGpMa6IaV34iZjm
	LhnWeKtA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rnYWk-00EKb8-1H;
	Fri, 22 Mar 2024 06:37:18 +0000
Date: Fri, 22 Mar 2024 06:37:18 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>,
	brauner@kernel.org, axboe@kernel.dk, linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org, yi.zhang@huawei.com,
	yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [RFC v4 linux-next 19/19] fs & block: remove bdev->bd_inode
Message-ID: <20240322063718.GC3404528@ZenIV>
References: <20240222124555.2049140-20-yukuai1@huaweicloud.com>
 <20240317213847.GD10665@lst.de>
 <022204e6-c387-b4b2-5982-970fd1ed5b5b@huaweicloud.com>
 <20240318013208.GA23711@lst.de>
 <5c231b60-a2bf-383e-e641-371e7e57da67@huaweicloud.com>
 <ea4774db-188e-6744-6a5b-0096f6206112@huaweicloud.com>
 <20240318232245.GA17831@lst.de>
 <c62dac0e-666f-9cc9-cffe-f3d985029d6a@huaweicloud.com>
 <20240321112737.33xuxfttrahtvbej@quack3>
 <240b78df-257e-a97c-31ff-a8b1b1882e80@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <240b78df-257e-a97c-31ff-a8b1b1882e80@huaweicloud.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, Mar 21, 2024 at 08:15:06PM +0800, Yu Kuai wrote:

> > blkdev_iomap_begin() etc. may be an arbitrary filesystem block device
> > inode. But why can't you use I_BDEV(inode->i_mapping->host) to get to the
> > block device instead of your file_bdev(inode->i_private)? I don't see any
> > advantage in stashing away that special bdev_file into inode->i_private but
> > perhaps I'm missing something...
> > 
> 
> Because we're goning to remove the 'block_device' from iomap and
> buffer_head, and replace it with a 'bdev_file'.

What of that?  file_inode(file)->f_mapping->host will give you bdevfs inode
just fine...

