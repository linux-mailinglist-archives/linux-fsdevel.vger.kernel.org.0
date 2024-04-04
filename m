Return-Path: <linux-fsdevel+bounces-16100-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2D208982DD
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Apr 2024 10:11:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C7CE28A161
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Apr 2024 08:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49219679ED;
	Thu,  4 Apr 2024 08:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="dfbD9D7B"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9EF55CDE4;
	Thu,  4 Apr 2024 08:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712218291; cv=none; b=RLUHPsDPdNWVvWXttH0xWDnd/FEVQI931dDhozHt3VkALF0avAcEk0x4byV1hdrjlFzX0dnWyS7G8v5C7dDmAY5n0ggp0v0zESlb8k7IXy2x282ReRG9YKVDpWz0uRwS5G5s5x3qCBel4iIHLwwCMiqtnExmNgRBHWYRc66kI2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712218291; c=relaxed/simple;
	bh=Np/ATqeBvhdlucSIywisivuAlnZMAqOyGIALpnO61+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BshL5aBAG6FFgoTzzGvb6Eo1f24TUTjq+cQNdiKcjdbZKW4qalBwqB9BKhGC+gT9m3Ho3E/p7V68ZB79bBnYIJL+NAKz5SWeRVYjqMfyVDjP2bYlSQRuOqBGBFDf3E8ogG9skgQL5ggFqxpqLEQx0tbQi9VebrHWvzMqhfpkZfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=dfbD9D7B; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=27elc/0JyttPz1kY3/vtLS2LPISJSolxcUu3hILMtfU=; b=dfbD9D7BwYukgL6jr+GhbCiugb
	7d5jwRK2BpCBg1hAgy8LvJPy/5FJY0aRr7s//zLeYAhu6pwquFoj4WbTN8KQnqnP7mfQhvhU5RWUK
	mzoe9xPN4/E3egGdvUhkEDKB12LpVU1mVkfZTes5Mr8yAj/myTpww3vyQoR8a2OsH18ZE6hjYHC7s
	+QA5kL/FlNz3RQSjcPcSTPq4XoQUaKrlfkt6CPu6hz/y97HLs15ZtnWjZ8HNjxYkM05SSOaVYW9X8
	8E+iFK0TiZM0luE69GQmEIpIcK6vevJtVntsD3x0Lv0jk8f5gCbmvFI86eUAPO7bxPX4C+sMKPhI0
	DclA6n3A==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rsIBu-005Rj8-1f;
	Thu, 04 Apr 2024 08:11:22 +0000
Date: Thu, 4 Apr 2024 09:11:22 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Amir Goldstein <amir73il@gmail.com>
Cc: syzbot <syzbot+9a5b0ced8b1bfb238b56@syzkaller.appspotmail.com>,
	gregkh@linuxfoundation.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
	tj@kernel.org, valesini@yandex-team.ru,
	Christoph Hellwig <hch@lst.de>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: [syzbot] [kernfs?] possible deadlock in kernfs_fop_llseek
Message-ID: <20240404081122.GQ538574@ZenIV>
References: <00000000000098f75506153551a1@google.com>
 <0000000000002f2066061539e54b@google.com>
 <CAOQ4uxiS5X19OT2MTo_LnLAx2VL9oA1zBSpbuiWMNy_AyGLDrg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxiS5X19OT2MTo_LnLAx2VL9oA1zBSpbuiWMNy_AyGLDrg@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, Apr 04, 2024 at 09:54:35AM +0300, Amir Goldstein wrote:
> 
> In the lockdep dependency chain, overlayfs inode lock is taken
> before kernfs internal of->mutex, where kernfs (sysfs) is the lower
> layer of overlayfs, which is sane.
> 
> With /sys/power/resume (and probably other files), sysfs also
> behaves as a stacking filesystem, calling vfs helpers, such as
> lookup_bdev() -> kern_path(), which is a behavior of a stacked
> filesystem, without all the precautions that comes with behaving
> as a stacked filesystem.

No.  This is far worse than anything stacked filesystems do - it's
an arbitrary pathname resolution while holding a lock.
It's not local.  Just about anything (including automounts, etc.)
can be happening there and it pushes the lock in question outside
of *ALL* pathwalk-related locks.  Pathname doesn't have to
resolve to anything on overlayfs - it can just go through
a symlink on it, or walk into it and traverse a bunch of ..
afterwards, etc.

Don't confuse that with stacking - it's not even close.
You can't use that anywhere near overlayfs layers.

Maybe isolate it into a separate filesystem, to be automounted
on /sys/power.  And make anyone playing with overlayfs with
sysfs as a layer mount the damn thing on top of power/ in your
overlayfs.  But using that thing as a part of layer is
a non-starter.

