Return-Path: <linux-fsdevel+bounces-74525-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E3BFED3B75A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 20:33:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3B47E3026F3B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 19:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 323F72C15A0;
	Mon, 19 Jan 2026 19:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jw7k18TD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B20DC2475E3;
	Mon, 19 Jan 2026 19:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768851192; cv=none; b=W5f69SQ7qV8sI7+G1CfvmQG9KID1UPVH0R6pFadM+qWOAHgttap2EAsfpBhLh3bbZch0XF2UBivV+2o6vZHBL0TiMkqQ1JbipC1j5uJsnbqajLqGMPWdrkG3KJX6SuFy41P0MygSGnl8CGNwE2UgA3SoExl0IYbnJqJHF3P52wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768851192; c=relaxed/simple;
	bh=DRwpJER0zNtSisDlkiJN+FTgXeZjOjDYzJNLIcn5ABk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XF9AkStbdQj6PLkwN9kyFJTmZQbyTiTqHhDU2+OcmyssKKBJ16Anea8AKidwBqMV2hyg8qA3W9KJbVuVQ8CMSibbym9I3eNdt+FBm7SKrH9nmCh+9Xu1gzhxyqgDXyZvBZVhN0j+bn2WfCP+uIpo+3MCLjZm7a9KNn9mLi+zvlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jw7k18TD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D422AC116C6;
	Mon, 19 Jan 2026 19:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768851192;
	bh=DRwpJER0zNtSisDlkiJN+FTgXeZjOjDYzJNLIcn5ABk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jw7k18TD+nCinzSLCmqVLxQkjg5CgI7PnZdMEwclGtPNqjYkv75T9CBDSzRqmhX0u
	 kx17q8IjvxsNPC+l9alIryTVAy5smNgyar40kJYHj17+XBJA+540VQmnIvT5fikUGj
	 TsymiyMNwaQKQjtj6lMmNnzfuN4Vwn/H1Xlg13ieA/3Ebeg/UCX39/oaXxSO/kYyhR
	 Kd3MTq69spYuw5hRebVSN3a+l3dIYI2tWzXgG2q1Jd/m6XmmC97c7Io92EOut/d+fY
	 HnW7c2NcOm/rzAgYDYnG6IDd1YYJtUJ5C9nZXxZ0+jY75m4jTfPi+/BhiJvngOMa72
	 iUuaEbQfF+Aag==
Date: Mon, 19 Jan 2026 11:32:42 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Andrey Albershteyn <aalbersh@redhat.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Matthew Wilcox <willy@infradead.org>, fsverity@lists.linux.dev,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	aalbersh@kernel.org, david@fromorbit.com, tytso@mit.edu,
	linux-ext4@vger.kernel.org, jaegeuk@kernel.org, chao@kernel.org,
	linux-f2fs-devel@lists.sourceforge.net
Subject: Re: fsverity metadata offset, was: Re: [PATCH v2 0/23] fs-verity
 support for XFS with post EOF merkle tree
Message-ID: <20260119193242.GB13800@sol>
References: <cover.1768229271.patch-series@thinky>
 <aWZ0nJNVTnyuFTmM@casper.infradead.org>
 <op5poqkjoachiv2qfwizunoeg7h6w5x2rxdvbs4vhryr3aywbt@cul2yevayijl>
 <aWci_1Uu5XndYNkG@casper.infradead.org>
 <20260114061536.GG15551@frogsfrogsfrogs>
 <5z5r6jizgxqz5axvzwbdmtkadehgdf7semqy2oxsfytmzzu6ik@zfvhexcp3fz2>
 <6r24wj3o3gctl3vz4n3tdrfjx5ftkybdjmmye2hejdcdl6qseh@c2yvpd5d4ocf>
 <20260119063349.GA643@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260119063349.GA643@lst.de>

On Mon, Jan 19, 2026 at 07:33:49AM +0100, Christoph Hellwig wrote:
> While looking at fsverity I'd like to understand the choise of offset
> in ext4 and f2fs, and wonder about an issue.
> 
> Both ext4 and f2fs round up the inode size to the next 64k boundary
> and place the metadata there.  Both use the 65536 magic number for that
> instead of a well documented constant unfortunately.
> 
> I assume this was picked to align up to the largest reasonable page
> size?  Unfortunately for that:
> 
>  a) not all architectures are reasonable.  As Darrick pointed out
>     hexagon seems to support page size up to 1MiB.  While I don't know
>     if they exist in real life, powerpc supports up to 256kiB pages,
>     and I know they are used for real in various embedded settings
>  b) with large folio support in the page cache, the folios used to
>     map files can be much larger than the base page size, with all
>     the same issues as a larger page size
> 
> So assuming that fsverity is trying to avoid the issue of a page/folio
> that covers both data and fsverity metadata, how does it copy with that?
> Do we need to disable fsverity on > 64k page size and disable large
> folios on fsverity files?  The latter would mean writing back all cached
> data first as well.
> 
> And going forward, should we have a v2 format that fixes this?  For that
> we'd still need a maximum folio size of course.   And of course I'd like
> to get all these things right from the start in XFS, while still being as
> similar as possible to ext4/f2fs.

Yes, if I recall correctly it was intended to be the "largest reasonable
page size".  It looks like PAGE_SIZE > 65536 can't work as-is, so indeed
we should disable fsverity support in that configuration.

I don't think large folios are quite as problematic.
ext4_read_merkle_tree_page() and f2fs_read_merkle_tree_page() read a
folio and return the appropriate page in it, and fs/verity/verify.c
operates on the page.  If it's a page in the folio that spans EOF, I
think everything will actually still work, except userspace will be able
to see Merkle tree data after a 64K boundary past EOF if the file is
mmapped using huge pages.

The mmap issue isn't great, but I'm not sure how much it matters,
especially when the zeroes do still go up to a 64K boundary.

If we do need to fix this, there are a couple things we could consider
doing without changing the on-disk format in ext4 or f2fs: putting the
data in the page cache at a different offset than it exists on-disk, or
using "small" pages for EOF specifically.

But yes, XFS should choose a larger alignment than 64K.

- Eric

