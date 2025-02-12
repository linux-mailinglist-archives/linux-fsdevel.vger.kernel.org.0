Return-Path: <linux-fsdevel+bounces-41612-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE28EA33167
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2025 22:22:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CF5F1889152
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2025 21:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51578202F76;
	Wed, 12 Feb 2025 21:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="CHhBeumA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3247F1FBC8D;
	Wed, 12 Feb 2025 21:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739395353; cv=none; b=XC7SLYNWXfLzFSYdzx/Jr02NA3DfU8Zv6U/pDdh+42cxRkM5gg2G5cUuPc6YVxJZEKVJEvfH0ojqN8NbWOWb6DCsp/3AobtODqKZuNJK2H/VW59Xc8I7SeQ0/r5wjHKxEEY7pMOfyO1qsxrziVb/V4T045YGx3BzrcYrSaWSRIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739395353; c=relaxed/simple;
	bh=PoBlEMfQTSMufbEiPa+IrPLrOUuKE/M8lscKWh1S2ac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GlY0JFnQjfMVGMw9fjsU99CtelmXKZV5fK+bTC9wNVI/ERTA3AzeQ6/fpfIrKjbxgeAg7Or2keo9FrjhBLX+JMblvBEvCmzL935cb0HeSwSHzt9ptSn/ZkXDRR9dDqHDPDS7YtqZkkgL2sWUVJQGswJMpYuTvRV9YN4DUeRFcbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=CHhBeumA; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=wNfKIudWNdfYXV5PNGLPwpKFO8o6tni+M+HQxSvvREM=; b=CHhBeumAzMZ3Srxlj+O9WB4Itp
	fixabDjZrQFHK4F8iZTeGC7YN5ghl1K5AcQl+xLpIKfMRVcYEg0I8tvTbt1xS7Ld9DH4CNUb9Eg5Q
	KeWnSSTZ0VaCpfiJSBXko72bNhFthpORykcbOksZaX+16BMZoJo/H89vDYezcHhn/lK0Nei+tEafO
	Ez+jdr/vt/hduifmjvlxFpNb3UCL0ZVFfSAbGZ6HI54fDK0YdmS9Syzr2QN2L0YIywOD6ag/cqgs9
	cxOWwysYBUqUVCT+I4fdbkMZVVHRWgLgNBGYa/ibYspuAkhu9g8pth3KnNi9P+UrAGScetObG7Gnt
	cvpOcREg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tiKBg-0000000C8p2-14zS;
	Wed, 12 Feb 2025 21:22:28 +0000
Date: Wed, 12 Feb 2025 21:22:28 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: NeilBrown <neilb@suse.de>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jeff Layton <jlayton@kernel.org>,
	Dave Chinner <david@fromorbit.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 13/19] VFS: lock dentry for ->revalidate to avoid races
 with rename etc
Message-ID: <20250212212228.GS1977892@ZenIV>
References: <20250206054504.2950516-1-neilb@suse.de>
 <20250206054504.2950516-14-neilb@suse.de>
 <20250208013043.GN1977892@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250208013043.GN1977892@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sat, Feb 08, 2025 at 01:30:43AM +0000, Al Viro wrote:
> HOWEVER, if you do not bother with doing that before ->d_unalias_trylock()
> (and there's no reason to do that), the whole thing becomes much simpler -
> you can do the check inside __d_move(), after all locks had been taken.
> 
> After
>         spin_lock_nested(&dentry->d_lock, 2);
>         spin_lock_nested(&target->d_lock, 3);
> you have everything stable.  Just make the sucker return bool instead
> of void, check that crap and have it return false if there's a problem.

... except that this requires telling __d_move() that it's an unalias -
on normal move dentries will have been locked by the caller.  Might
make sense to turn that bool exchange argument into an enum...

Let me play with that a bit and see what falls out...

