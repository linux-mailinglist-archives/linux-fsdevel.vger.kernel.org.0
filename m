Return-Path: <linux-fsdevel+bounces-41278-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03114A2D2AA
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Feb 2025 02:35:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 963D916D2DA
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Feb 2025 01:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B0BF84A2B;
	Sat,  8 Feb 2025 01:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="W3LD/dST"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B96D10F4;
	Sat,  8 Feb 2025 01:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738978520; cv=none; b=WATf7mCZPk/ZJAuXLe0Uda1i2W7ThgVyzPtKKIiuI7ttxMAMnuMPpMIF7Hz4maPGdeBLEnyKBvoikpzJRcryRgdUVgRKBHqmRqx11X8Hym2RCfohGpEMkMkJa0XiEfebofhtjVwigU82ub2KuehEjYM2mNjbcJJzI5Nm1uQG/gY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738978520; c=relaxed/simple;
	bh=2rttwtuTv47L02vXtJLve0o+H9HO5mf+HAVLx++Td6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CLmWq6UeDMLpKehEGo/zQnCmE85WyANlIPj6n10fNGon5tMgzEbvDFHbcFClu2H0sAECXFKnfIJZCiai3yNMu2C+YK8Hlc8jsrN95a2ExGwzQF1ZzskEbmA7lwH5e/RtbdYbfMblHySGd08SwFaJ2Ob2UJI0zhc+2qDF3dj1NLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=W3LD/dST; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=8ks+9m9ykw4HyZMMC3B3XHijPN5UcGs1i3XuYdh+tLk=; b=W3LD/dSTLiFmRzL8palH4K2Gdf
	SkWFdhchXmF+4jyBQqg03pbWDvH1ntHvgPO7bZaXE7gKPa44TAepH4FRsbSfYZGIYnVq6XIhVy41w
	htA4y7nfqakitdAER/XxRTguX9JqJJUtntP04w1Eshq8HtrjhxdDM8uikDSLMp58/+qOmdZ1R/ycx
	wXewcIsQXhdjWaPW3GLNwLngzAaLkPpFaVbwpyrbX3SSO6jQit0rNMeRn7u+Dwjt/6eI8/A96Fk6q
	thwsSmcbwLV+eXk8oT6ZYNkeOY6jOMRzibbhcBIJqKK6fW/pMIuzoxw1ZAg8ZG6DsrQzGZ5hzIwit
	GBgMx5lA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tgZkX-00000006rWl-3dq9;
	Sat, 08 Feb 2025 01:35:13 +0000
Date: Sat, 8 Feb 2025 01:35:13 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: NeilBrown <neilb@suse.de>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jeff Layton <jlayton@kernel.org>,
	Dave Chinner <david@fromorbit.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 13/19] VFS: lock dentry for ->revalidate to avoid races
 with rename etc
Message-ID: <20250208013513.GO1977892@ZenIV>
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
> On Thu, Feb 06, 2025 at 04:42:50PM +1100, NeilBrown wrote:
> > When we call ->revalidate we want to be sure we are revalidating the
> > expected name.  As a shared lock on i_rwsem no longer prevents renames
> > we need to lock the dentry and ensure it still has the expected name.
> 
> *blink*
> 
> We never had been guaranteed any lock on the parent - the most common
> call chain doesn't (and didn't) have it taken.
> 
> > So pass parent name to d_revalidate() and be prepared to retry the
> > lookup if it returns -EAGAIN.
> 
> I don't understand that one at all.  What's the point of those retries
> on -EAGAIN?  Rename (or race with d_splice_alias(), for that matter)
> can happen just as we return success from ->d_revalidate(), so we
> don't get anything useful out of that check.
> 
> What's more, why do we need that exclusion in the first place?
> The instance *is* given a stable parent reference and stable name,
> so there's no need for it to even look at ->d_parent or ->d_name.
> 
> It looks like a bad rebase on top of ->d_revalidate() series that
> had landed in -rc1, with the original variant trying to provide the
> guarantees now offered by that series.
> 
> Unless there's something subtle I'm missing here, I would suggest
> dropping that one.  Incidentally, d_update_trylock() would be
> better off in fs/dcache.c - static and with just one argument.

Sorry, lost a sentence here while editing:

The only remaining caller of d_update_trylock() would be the one in
__d_unalias(), just before the call of ->d_unalias_trylock() in there
and it gets NULL/NULL in the last two arguments.

> HOWEVER, if you do not bother with doing that before ->d_unalias_trylock()
> (and there's no reason to do that), the whole thing becomes much simpler -
> you can do the check inside __d_move(), after all locks had been taken.
> 
> After
>         spin_lock_nested(&dentry->d_lock, 2);
>         spin_lock_nested(&target->d_lock, 3);
> you have everything stable.  Just make the sucker return bool instead
> of void, check that crap and have it return false if there's a problem.
> 
> Callers other than __d_unalias() would just do WARN_ON(!__d_move(...))
> instead of their __d_move() calls and __d_unalias() would have
> 	if (__d_move(...))
> 		ret = 0;
> and screw the d_update_trylock/d_update_unlock there.
> 
> All there is to it...

