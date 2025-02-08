Return-Path: <linux-fsdevel+bounces-41277-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7759EA2D2A2
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Feb 2025 02:30:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9767F188E84E
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Feb 2025 01:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A7AB49641;
	Sat,  8 Feb 2025 01:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="b00C3waP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2946610F4;
	Sat,  8 Feb 2025 01:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738978248; cv=none; b=K15oPZ1CQ1DP8uRcIrDKFc9fxSjY3tCX3awhTPBmXVq1UuR4z9n8la1Q2djQvU6EUHHED3MEkcitQpuH9qXEhw//fk04uTFH92A4AdaaMV5EJ6QR92Wt0t1msxBjvgI72m1VhhUjERXCOMbJFltBX5ivwogRS9lQwsssc3SmcQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738978248; c=relaxed/simple;
	bh=bFQ4atIycqrRZyxcW30QPm70rhGGXboosEnRYvw6Qio=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R33ncA2bP/mIgv/zcVBjNP4rNlLUC4zZgXxirCtS4JCcy7IkOU54xiVX+JnY67ClFouh9NQfa0M1r6S63UDcNtra0ZO6zt0iQQnmjcWqLWvojRMlPtw911nhQvPjEvq1HiHO/ba9lZfEjKM4ekQ6c9nXhl3a4XJhP931urlIAMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=b00C3waP; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=tVNwohITDlPUn2rKH7AtEmSPnKP0QcfF4nwAQBgoQZM=; b=b00C3waPYgjU1YiEOgqzO4NpOW
	XQf3gvM8owE5GF8AKKnKBJPzRvLcoA4cQvcqHjxWNiVENv/9EBY4dlQYGhq08do+DP0AbmRaV0Rjh
	I4SJIwAMak+BQp2rP9iC15h5rtHMKPBMFjLWcMT320KJUh0CSqmYRGi/TT30IaIBYi1Rmz1Z/JQ/A
	z885rUEVi5wagzYj+qs5PXavJN5czxOTKaY249miGg0XTqypt0waSIbrXxG5CZY4aPLHELWgamFUO
	fQVjfmSq90HxZECNLQrlthWUfp9bv/gphiLpGTGjhNL1ugwMZIu40Ncy6uocBPViBnEhPh216gfZZ
	U+GgjRnw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tgZgB-00000006rGF-2TGR;
	Sat, 08 Feb 2025 01:30:43 +0000
Date: Sat, 8 Feb 2025 01:30:43 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: NeilBrown <neilb@suse.de>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jeff Layton <jlayton@kernel.org>,
	Dave Chinner <david@fromorbit.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 13/19] VFS: lock dentry for ->revalidate to avoid races
 with rename etc
Message-ID: <20250208013043.GN1977892@ZenIV>
References: <20250206054504.2950516-1-neilb@suse.de>
 <20250206054504.2950516-14-neilb@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250206054504.2950516-14-neilb@suse.de>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, Feb 06, 2025 at 04:42:50PM +1100, NeilBrown wrote:
> When we call ->revalidate we want to be sure we are revalidating the
> expected name.  As a shared lock on i_rwsem no longer prevents renames
> we need to lock the dentry and ensure it still has the expected name.

*blink*

We never had been guaranteed any lock on the parent - the most common
call chain doesn't (and didn't) have it taken.

> So pass parent name to d_revalidate() and be prepared to retry the
> lookup if it returns -EAGAIN.

I don't understand that one at all.  What's the point of those retries
on -EAGAIN?  Rename (or race with d_splice_alias(), for that matter)
can happen just as we return success from ->d_revalidate(), so we
don't get anything useful out of that check.

What's more, why do we need that exclusion in the first place?
The instance *is* given a stable parent reference and stable name,
so there's no need for it to even look at ->d_parent or ->d_name.

It looks like a bad rebase on top of ->d_revalidate() series that
had landed in -rc1, with the original variant trying to provide the
guarantees now offered by that series.

Unless there's something subtle I'm missing here, I would suggest
dropping that one.  Incidentally, d_update_trylock() would be
better off in fs/dcache.c - static and with just one argument.

HOWEVER, if you do not bother with doing that before ->d_unalias_trylock()
(and there's no reason to do that), the whole thing becomes much simpler -
you can do the check inside __d_move(), after all locks had been taken.

After
        spin_lock_nested(&dentry->d_lock, 2);
        spin_lock_nested(&target->d_lock, 3);
you have everything stable.  Just make the sucker return bool instead
of void, check that crap and have it return false if there's a problem.

Callers other than __d_unalias() would just do WARN_ON(!__d_move(...))
instead of their __d_move() calls and __d_unalias() would have
	if (__d_move(...))
		ret = 0;
and screw the d_update_trylock/d_update_unlock there.

All there is to it...

