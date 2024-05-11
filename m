Return-Path: <linux-fsdevel+bounces-19333-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C4AAF8C336F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 May 2024 21:28:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5091BB2127D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 May 2024 19:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5638208A9;
	Sat, 11 May 2024 19:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="kEUzg0Br"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0CC62032B
	for <linux-fsdevel@vger.kernel.org>; Sat, 11 May 2024 19:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715455711; cv=none; b=F+3D9uQByVIJPCWONsjbo1u1oSEYHHrxPB94RKCYdRJiZ1Vr6rFhVUSXOACVmWP8llLRn/AR+NW1XUpNLtvgMRuyJFgRsziHEG//39SWQJFyd9YVoiAPLV/FNTqaivjLqP8cohXmijkmTyXR/b3aGosm9m7UMlBOjhAR3a7nYjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715455711; c=relaxed/simple;
	bh=tQNzfVFKw8EOr6AsGtkb5Del8yFw29rp3PiF/mDg6BA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KbcdIq2oOf9RAVBP38m2XWBz7zIVJ0+IZhWkWvx535A6g+juCh3JnAYtJs8zSv6Vu3NCqrPdewU2MIb8NANvH4aXg0oB5aY4lMbi2qgyVXYAjkL6QKmEk+pTDFJAwcvbeo6M3A8rWZfia9dSw0KGopZeZaWu2Tk+yqkpkkUzAjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=kEUzg0Br; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ecR/uGj6O5964Er9mS4uklRntAmI+9jaOKUIE7oYKbg=; b=kEUzg0BrgPU4uMyCJ9k45hpgh5
	15CaopKhe+u4Rfj+Avh/P+ogfnDKhjl+CZ8b07tOhKBGzSD+WF0JGRYJ3GAsl+/7o7Smpfn4/nGpV
	yEC34hrsFkuKYih+6Q0EZfK2VLrhBUUc2iEnWN7wI91pehk1Xxsq8pEz2ZfDa7QFo9cNRSBqeVyCR
	gNYPU3XJ4QqgWm7qx8pER8aGgzoblbnTzx/Be5HaUy1Ke5zLsplOuLT5XuynpXh1EW5zr6dINbdwt
	tX49lPDU+v+GbUugpZBsADMv5vTTKsSdIgous/+8eGcUOWfY1LYg+wFPq+uvFKkQlAoCg8SIq65cd
	/7Cel0EA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1s5sOO-003oRS-1w;
	Sat, 11 May 2024 19:28:24 +0000
Date: Sat, 11 May 2024 20:28:24 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: brauner@kernel.org, jack@suse.cz, laoar.shao@gmail.com,
	linux-fsdevel@vger.kernel.org, longman@redhat.com,
	walters@verbum.org, wangkai86@huawei.com, willy@infradead.org
Subject: Re: [PATCH] vfs: move dentry shrinking outside the inode lock in
 'rmdir()'
Message-ID: <20240511192824.GC2118490@ZenIV>
References: <CAHk-=whvo+r-VZH7Myr9fid=zspMo2-0BUJw5S=VTm72iEXXvQ@mail.gmail.com>
 <20240511182625.6717-2-torvalds@linux-foundation.org>
 <CAHk-=wijTRY-72qm02kZAT_Ttua0Qwvfms5m5NbR4EWbS02NqA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wijTRY-72qm02kZAT_Ttua0Qwvfms5m5NbR4EWbS02NqA@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sat, May 11, 2024 at 11:42:34AM -0700, Linus Torvalds wrote:

> so we have another level of locking going on, and my patch only moved
> the dcache pruning outside the lock of the directory we're removing
> (not outside the lock of the directory that contains the removed
> directory).
> 
> And that outside lock is the much more important one, I bet.

... and _that_ is where taking d_delete outside of the lock might
take an unpleasant analysis of a lot of code.

We have places where we assume that holding the parent locked
will prevent ->d_inode changes of children.  It might be possible
to get rid of that, but it will take a non-trivial amount of work.

In any case, I think the original poster said that parent directories
were not removed, so I doubt that rmdir() behaviour is relevant for
their load.

