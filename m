Return-Path: <linux-fsdevel+bounces-19332-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AE108C336A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 May 2024 21:24:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 559E11C20DD2
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 May 2024 19:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 627601CD0C;
	Sat, 11 May 2024 19:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="rQLIZjcF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5AC21B974
	for <linux-fsdevel@vger.kernel.org>; Sat, 11 May 2024 19:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715455455; cv=none; b=AmQcrZMYuRMCJHuf1doaIUKnIG22Am5Qi3jISnWT3D/04S7A17iYY8v55pqPzSokVA4fEvFAUBABkxkh4LCdN7BjNeA/cC10l1TVRGo2fzCWAbX/tguAeqjazfbhbWRD0LVkO7HIm0ehLZT1yYoA0NQziAP9+jIGpJqgGBnplT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715455455; c=relaxed/simple;
	bh=gLILplmxGDTlLyJMm/euQKA/mzHeV1tf5YkbBSM/JHI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MUIxJ2wmMIpTR9lS+6nh1QYYsaiTHFGNJ56nhf9X7tN9fSf6IFejZ9+SYipzRIr1aww7/3LvbbVo27tTmVVbqEnsRV7E8OGX6lnMNS92PUBKjpu3UrlEDmlaWb3P4O0qVnZ+nCK0hm7XNlqiGlNk2nh8cVN0C2FbDrA81g+IuQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=rQLIZjcF; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=+YiaHwPhntQe91ji9K9VjQNqEp6NpRQjld0AN7pMsW8=; b=rQLIZjcF750mDPau9X/CH46I0V
	4Kn3D9SDbP2zh5LK3Zb2GijIWSSWzRQXA9wRVSTKA8t+6dsOzrGX8+C1eaiIqwxeq+/8+lCF9/BCb
	NB22/EYGBwoKnuHZtM9+mO/5fCp857d5LMC6bmZarH167oSxZZFbidV7Y1vN5hUueI7ZJzF0mRiBu
	+Kb/04DtQump+Z39zJ7O7EqxrgrlkMGg2cLUkeE4qb62b8bQnp4eciGQDf2QNv//4+G1lhTMLw880
	I8hesqRNkIEGAMMx0JmAkTZMlLCrn0VuOV1VlYK3CMOMBlNx79ePkuE5eP3mcs96Eo1sRoTjPZUMr
	5zR4yjBw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1s5sKB-003oBz-1T;
	Sat, 11 May 2024 19:24:03 +0000
Date: Sat, 11 May 2024 20:24:03 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: brauner@kernel.org, jack@suse.cz, laoar.shao@gmail.com,
	linux-fsdevel@vger.kernel.org, longman@redhat.com,
	walters@verbum.org, wangkai86@huawei.com, willy@infradead.org
Subject: Re: [PATCH] vfs: move dentry shrinking outside the inode lock in
 'rmdir()'
Message-ID: <20240511192403.GB2118490@ZenIV>
References: <CAHk-=whvo+r-VZH7Myr9fid=zspMo2-0BUJw5S=VTm72iEXXvQ@mail.gmail.com>
 <20240511182625.6717-2-torvalds@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240511182625.6717-2-torvalds@linux-foundation.org>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sat, May 11, 2024 at 11:26:26AM -0700, Linus Torvalds wrote:
> Yafang Shao reports that he has seen loads that generate billions of
> negative dentries in a directory, which then when the directory is
> removed causes excessive latencies for other users because the dentry
> shrinking is done under the directory inode lock.
> 
> There seems to be no actual reason for holding the inode lock any more
> by the time we get rid of the now uninteresting negative dentries, and
> it's an effect of just code layout (the shared error path).
> 
> Reorganize the code trivially to just have a separate success path,
> which simplifies the code (since 'd_delete_notify()' is only called in
> the success path anyway) and makes it trivial to just move the dentry
> shrinking outside the inode lock.

Wait, I thought he had confirmed that in the setup in question directories
were *not* removed, hadn't he?

I've no objections against that patch, but if the above is accurate it's
not going to help...

