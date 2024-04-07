Return-Path: <linux-fsdevel+bounces-16315-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01D8C89AE64
	for <lists+linux-fsdevel@lfdr.de>; Sun,  7 Apr 2024 06:05:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 065B81C21A84
	for <lists+linux-fsdevel@lfdr.de>; Sun,  7 Apr 2024 04:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15E765227;
	Sun,  7 Apr 2024 04:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="I0FbE14k"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B359917C9;
	Sun,  7 Apr 2024 04:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712462745; cv=none; b=VEdq5afjfd0d40OL1JdNbcxQAnloIcEmAtSL/p/Jl9GfPcjwfPsK4jYv82HNUUDcEEmXg9fjbb1HsZ7KPLls+fR3KyYCAfD93LeuzPn2sJUXTx6KnANQ6NtN5d56DlCOw2i8d3VnxLTnrqTk33cv6cgv+uaL0+KkVhAoEXl9FkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712462745; c=relaxed/simple;
	bh=2zOxKTK748jzWdXZlTTHJqYBb4BEVBRJsLy9y5LZykI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oGDzG1CjNFmxVIoFkHttvmOJvugLNsXhQrZ3WrYXLJHCeDjrF72Iwp4o9EDH8M7wvfW9m7sg8TSXIbjnusBz/xXDkIp8uI2QASNTGqaAUB159V/DAzFKt0yp5x5YE28PWsBrknZct1MAhNFvqB6Ph6avnlntXvPVDAa/47NFi98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=I0FbE14k; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=3m0cb8Y3VgDCnrty4kDLlar+Op9J+Vtf3ITQc/9to14=; b=I0FbE14kXEK/VzQLeMWjSXIkNw
	PBfB+0Ol0D8ZKqRxLrjQUISLNTbrVG8aYMlCPWxBeVJ3IQxwPOi4hQZ4H7l/LyJ6N4ND7h40Ac9qb
	znhhs+e+wTQtYnZM3ZeAKpYhCHCnUiyPNrZ/BMzLCRdDEHKM9RzSz0B3Bgto03ybSqGUlNKPLAn7e
	LSWjZ1CtR17A/tsYHMa30eSi/q68g76tn5mDa40+7gETPZYm54mk3Awxd6Znu/VnWtHQmeFrwY42+
	PDPsYPgr6dG7nOx8+PjFINlsh4eqh5h9NBN1zif/m4oY2Xh05V/PWGcIj1TUed1MXs15KTLLCZ83/
	ZfWuQYLQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rtJmd-007ae1-0f;
	Sun, 07 Apr 2024 04:05:31 +0000
Date: Sun, 7 Apr 2024 05:05:31 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: jack@suse.cz, hch@lst.de, brauner@kernel.org, axboe@kernel.dk,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	yi.zhang@huawei.com, yangerkun@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH vfs.all 08/26] erofs: prevent direct access of bd_inode
Message-ID: <20240407040531.GA1791215@ZenIV>
References: <20240406090930.2252838-1-yukuai1@huaweicloud.com>
 <20240406090930.2252838-9-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240406090930.2252838-9-yukuai1@huaweicloud.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sat, Apr 06, 2024 at 05:09:12PM +0800, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> Now that all filesystems stash the bdev file, it's ok to get inode
> for the file.

Looking at the only user of erofs_buf->inode (erofs_bread())...  We
use the inode for two things there - block size calculation (to get
from block number to position in bytes) and access to page cache.
We read in full pages anyway.  And frankly, looking at the callers,
we really would be better off if we passed position in bytes instead
of block number.  IOW, it smells like erofs_bread() having wrong type.

Look at the callers.  With 3 exceptions it's
fs/erofs/super.c:135:   ptr = erofs_bread(buf, erofs_blknr(sb, *offset), EROFS_KMAP);
fs/erofs/super.c:151:           ptr = erofs_bread(buf, erofs_blknr(sb, *offset), EROFS_KMAP);
fs/erofs/xattr.c:84:    it.kaddr = erofs_bread(&it.buf, erofs_blknr(sb, it.pos), EROFS_KMAP);
fs/erofs/xattr.c:105:           it.kaddr = erofs_bread(&it.buf, erofs_blknr(sb, it.pos),
fs/erofs/xattr.c:188:           it->kaddr = erofs_bread(&it->buf, erofs_blknr(sb, it->pos),
fs/erofs/xattr.c:294:           it->kaddr = erofs_bread(&it->buf, erofs_blknr(sb, it->pos),
fs/erofs/xattr.c:339:           it->kaddr = erofs_bread(&it->buf, erofs_blknr(it->sb, it->pos),
fs/erofs/xattr.c:378:           it->kaddr = erofs_bread(&it->buf, erofs_blknr(sb, it->pos),
fs/erofs/zdata.c:943:           src = erofs_bread(&buf, erofs_blknr(sb, pos), EROFS_KMAP);

and all of them actually want the return value + erofs_offset(...).  IOW,
we take a linear position (in bytes).  Divide it by block size (from sb).
Pass the factor to erofs_bread(), where we multiply that by block size
(from inode), see which page will that be in, get that page and return a
pointer *into* that page.  Then we again divide the same position
by block size (from sb) and add the remainder to the pointer returned
by erofs_bread().

IOW, it would be much easier to pass the position directly and to hell
with block size logics.  Three exceptions to that pattern:

fs/erofs/data.c:80:     return erofs_bread(buf, blkaddr, type);
fs/erofs/dir.c:66:              de = erofs_bread(&buf, i, EROFS_KMAP);
fs/erofs/namei.c:103:           de = erofs_bread(&buf, mid, EROFS_KMAP);

Those could bloody well multiply the argument by block size;
the first one (erofs_read_metabuf()) is also interesting - its
callers themselves follow the similar pattern.  So it might be
worth passing it a position in bytes as well...

In any case, all 3 have superblock reference, so they can convert
from blocks to bytes conveniently.  Which means that erofs_bread()
doesn't need to mess with block size considerations at all.

IOW, it might make sense to replace erofs_buf->inode with
pointer to address space.  And use file_mapping() instead of
file_inode() in that patch...

