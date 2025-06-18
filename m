Return-Path: <linux-fsdevel+bounces-52005-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BD31BADE2D8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 07:02:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 032F0189D36F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 05:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08C7B1F4C85;
	Wed, 18 Jun 2025 05:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="gbjrNghd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A2B22AD14;
	Wed, 18 Jun 2025 05:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750222925; cv=none; b=u6s0oTxHNlQphLpZRs26i6NyfqSLHXhp9kUL9PNEYvcn9azsPPC0oaxsTL2rAUx8SrcgQJj0CUdY6ut2y2XRypgVWRgfm9M9JH7Tymj0gG761YgxTc2qmxXm7ZzmsOxfihPotuquogeoY/UMPkFbVe1QK1vCCOlk9SxcUaT3vyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750222925; c=relaxed/simple;
	bh=7BMaVoYFIpb49CInRnrRacJqN0drhlg/3qU8w6fNkqg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eoKn7JN8XhbklaxD8cV+yCp167Q3KCdcfTGPACzdBuu2YGQhEclkM0QTUo2TAUh0dpzjQGY4qgw3xVlQoLJVGiQIrAIPwd6AHHxjGOmlF6+OWpuTBwDbiBHCdjJLVMMeqHonjNgp57+82ZZTiqRtkyaNuAT7Z8kRohPUE5KtQ3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=gbjrNghd; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=EIzXAoutPERb2KcFrdG9kd3CXke7qUGSorRKl3GVGyg=; b=gbjrNghdwxHQVkXqeSz1SthNcJ
	s6dQpxuAcN1RmZagh0jvGDyUYyp9FT+0bWU2KY03pI4ImrNfpix/xFmGzFLg9ne/2poStWFE8UFcH
	Wjdk9xlSYieaFnfx/xtg0hULEc5PxJyeQQixMUIBPuIoeUB0A+r9FzKshbkV7tNOrMjWU445fv15y
	iSO8qZnrUWNqibfZCZSNopTMElFMjDY89lzj0JBYDLpHimtFEWUwQxY2lfos0ALVY/dKhfQC/A8xJ
	HylRqBB/F/FX9JDITX50dYX7c+b7zl5KBSf+GwkcNmBRcvFigf9i3gbxQOpfl8L1NyHpWZlBF203c
	lVBXn5FQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uRkvw-00000005gJ6-1xAH;
	Wed, 18 Jun 2025 05:02:00 +0000
Date: Wed, 18 Jun 2025 06:02:00 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Edward Adam Davis <eadavis@qq.com>
Cc: syzbot+1aa90f0eb1fc3e77d969@syzkaller.appspotmail.com,
	almaz.alexandrovich@paragon-software.com, brauner@kernel.org,
	jack@suse.cz, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, ntfs3@lists.linux.dev,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] fs: Prevent non-symlinks from entering pick link
Message-ID: <20250618050200.GP1880847@ZenIV>
References: <685120d8.a70a0220.395abc.0204.GAE@google.com>
 <tencent_7FB38DB725848DA99213DDB35DBF195FCF07@qq.com>
 <20250618045016.GO1880847@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250618045016.GO1880847@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Jun 18, 2025 at 05:50:16AM +0100, Al Viro wrote:

> NAK.  This is not the first time that garbage is suggested and no,
> we are not going to paper over that shite in fs/namei.c.
> 
> Not going to happen.
> 
> You ARE NOT ALLOWED to call make_bad_inode() on a live inode, period.
> Never, ever to be done.
> 
> There's a lot of assertions it violates and there's no chance in
> hell to plaster each with that kind of checks.
> 
> Fix NTFS.  End of story.

To elaborate a bit: if you look at the end of e.g. their attr_set_size(),
you'll see
out:
        if (is_bad) {
bad_inode:
		_ntfs_bad_inode(&ni->vfs_inode);
	}
	return err;
}

This is a bug.  So are similar places all over the place there.
You are not supposed to use make_bad_inode() as a general-purpose
"something went wrong, don't wanna see it anymore" tool.

And as long as it stays there, any fuzzing reports of ntfs are pretty
much worthless - any of those places (easily located by grepping for
_ntfs_bad_inode) can fuck the kernel up.  Once ntfs folks get around
to saner error recovery, it would make sense to start looking into
fuzzing that thing again.  Until then - nope.  Again, this is *NOT*
going to be papered over in a random set of places (pretty certain
to remain incomplete) in VFS.

