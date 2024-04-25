Return-Path: <linux-fsdevel+bounces-17820-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72D4B8B2936
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 21:57:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3FBC1C2161B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 19:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 659C3152539;
	Thu, 25 Apr 2024 19:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="pgriXwx/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95CEF152166;
	Thu, 25 Apr 2024 19:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714075026; cv=none; b=eH/U68nKvKttgXQPxVEq8IFGEGe61jVcxQ09KvdZuYd/lEbr4KgvKYXGfJrjKsZnAlmqE+xlqrmbTz9XS18VlUjPvq81pkkFW6IHwtMtGlxfTKk4o1+elrKt90Nsjot5Vy7tvKM9SvhMGe2kub2pJq6524Vxx+X2FYDo1M9xCHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714075026; c=relaxed/simple;
	bh=ENsPijiBLPkygVuePXiydvtaqV4bDRuBpdHOorh1o9g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b91+K1lMWcCUFpsURqB0E7NzNvdqnIwoior8biguJ1LgiB3OT6EqQxNz1sKdP9aR6JrcnsL5wkBPzg8QVu34z12lGIHcyBcEru+4pYVj27wStKKBf/1IVLnCGalPs3XD/9+TFfs5fu8ZkpfKeJ1oRJ0UXBitoKhCoESBR0alKtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=pgriXwx/; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=eILpV+5dzVjq3i7uAxGvV41eymZM+WTPsHd+WOMhJ1Q=; b=pgriXwx/ks1PAKUA/GdhkEri1L
	/aD3F4nz0JrENdPI3ygJrYk3k66f16C9Hm01Pim0udg+UbDzgwpzIgIhCNAu2LvW0urK22MPFyn0Z
	/ocZS0Cw0dUJhL6/ZFd8N+5a7XDqz4MUcHyulnhgMu3IWte5mFzCTgGh1CZzCrPTxxMW9U2xVpiPC
	nnOJEZcLPcDeAL7cZNNMJCU14FY8ssE+eiyGUp1DcCIcniwYQWOjrf4vrgynGp1TNRvTiqmi2dRSi
	OAnW3yKgDyJOyOSSRt/UaEVuGYvndXqTptde8syp5T1qFLqH+LhTGKsx2l+kUfV/N08Ei92sKFfNS
	FJRjFJjA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1s05Cz-004KOq-2u;
	Thu, 25 Apr 2024 19:56:42 +0000
Date: Thu, 25 Apr 2024 20:56:41 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Yu Kuai <yukuai1@huaweicloud.com>, jack@suse.cz, hch@lst.de,
	brauner@kernel.org, axboe@kernel.dk, linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org, yi.zhang@huawei.com,
	yangerkun@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH vfs.all 08/26] erofs: prevent direct access of bd_inode
Message-ID: <20240425195641.GJ2118490@ZenIV>
References: <20240406090930.2252838-1-yukuai1@huaweicloud.com>
 <20240406090930.2252838-9-yukuai1@huaweicloud.com>
 <20240407040531.GA1791215@ZenIV>
 <a660a238-2b7e-423f-b5aa-6f5777259f4d@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a660a238-2b7e-423f-b5aa-6f5777259f4d@linux.alibaba.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Apr 12, 2024 at 12:13:42AM +0800, Gao Xiang wrote:
> Hi Al,
> 
> On 2024/4/7 12:05, Al Viro wrote:
> > On Sat, Apr 06, 2024 at 05:09:12PM +0800, Yu Kuai wrote:
> > > From: Yu Kuai <yukuai3@huawei.com>
> > > 
> > > Now that all filesystems stash the bdev file, it's ok to get inode
> > > for the file.
> > 
> > Looking at the only user of erofs_buf->inode (erofs_bread())...  We
> > use the inode for two things there - block size calculation (to get
> > from block number to position in bytes) and access to page cache.
> > We read in full pages anyway.  And frankly, looking at the callers,
> > we really would be better off if we passed position in bytes instead
> > of block number.  IOW, it smells like erofs_bread() having wrong type.
> > 
> > Look at the callers.  With 3 exceptions it's
> > fs/erofs/super.c:135:   ptr = erofs_bread(buf, erofs_blknr(sb, *offset), EROFS_KMAP);
> > fs/erofs/super.c:151:           ptr = erofs_bread(buf, erofs_blknr(sb, *offset), EROFS_KMAP);
> > fs/erofs/xattr.c:84:    it.kaddr = erofs_bread(&it.buf, erofs_blknr(sb, it.pos), EROFS_KMAP);
> > fs/erofs/xattr.c:105:           it.kaddr = erofs_bread(&it.buf, erofs_blknr(sb, it.pos),
> > fs/erofs/xattr.c:188:           it->kaddr = erofs_bread(&it->buf, erofs_blknr(sb, it->pos),
> > fs/erofs/xattr.c:294:           it->kaddr = erofs_bread(&it->buf, erofs_blknr(sb, it->pos),
> > fs/erofs/xattr.c:339:           it->kaddr = erofs_bread(&it->buf, erofs_blknr(it->sb, it->pos),
> > fs/erofs/xattr.c:378:           it->kaddr = erofs_bread(&it->buf, erofs_blknr(sb, it->pos),
> > fs/erofs/zdata.c:943:           src = erofs_bread(&buf, erofs_blknr(sb, pos), EROFS_KMAP);
> > 
> > and all of them actually want the return value + erofs_offset(...).  IOW,
> > we take a linear position (in bytes).  Divide it by block size (from sb).
> > Pass the factor to erofs_bread(), where we multiply that by block size
> > (from inode), see which page will that be in, get that page and return a
> > pointer *into* that page.  Then we again divide the same position
> > by block size (from sb) and add the remainder to the pointer returned
> > by erofs_bread().
> > 
> > IOW, it would be much easier to pass the position directly and to hell
> > with block size logics.  Three exceptions to that pattern:
> > 
> > fs/erofs/data.c:80:     return erofs_bread(buf, blkaddr, type);
> > fs/erofs/dir.c:66:              de = erofs_bread(&buf, i, EROFS_KMAP);
> > fs/erofs/namei.c:103:           de = erofs_bread(&buf, mid, EROFS_KMAP);
> > 
> > Those could bloody well multiply the argument by block size;
> > the first one (erofs_read_metabuf()) is also interesting - its
> > callers themselves follow the similar pattern.  So it might be
> > worth passing it a position in bytes as well...
> > 
> > In any case, all 3 have superblock reference, so they can convert
> > from blocks to bytes conveniently.  Which means that erofs_bread()
> > doesn't need to mess with block size considerations at all.
> > 
> > IOW, it might make sense to replace erofs_buf->inode with
> > pointer to address space.  And use file_mapping() instead of
> > file_inode() in that patch...
> 
> Just saw this again by chance, which is unexpected.
> 
> Yeah, I think that is a good idea.  The story is that erofs_bread()
> was derived from a page-based interface:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/fs/erofs/data.c?h=v5.10#n35
> 
> so it was once a page index number.  I think a byte offset will be
> a better interface to clean up these, thanks for your time and work
> on this!

FWIW, see #misc.erofs and #more.erofs in my tree; the former is the
minimal conversion of erofs_read_buf() and switch from buf->inode
to buf->mapping, the latter follows that up with massage for
erofs_read_metabuf().

Completely untested; it builds, but that's all I can promise.  Individual
patches in followups.

