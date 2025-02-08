Return-Path: <linux-fsdevel+bounces-41299-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2786FA2D92C
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Feb 2025 23:07:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEE5C1666F3
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Feb 2025 22:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85962243955;
	Sat,  8 Feb 2025 22:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="j1K0utex"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDCF5243940;
	Sat,  8 Feb 2025 22:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739052419; cv=none; b=SN9sVUOnDzzHcCU1bbc1iteaN+8Gfdvkc100L0Le9PIKkOqradPIIHLfOpsifdFOO93z/jvQbYQpCEK+SuCtWapEVFjSS8dre7+zzVxSzbRmwXeKhNIjFBvnQytRyx3NyQRWP2asGaNVNlQ25Cf1iiQkhq3yfiFFM+QefdJnT6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739052419; c=relaxed/simple;
	bh=BkvGqVHelguYcJfNjWJNmwQvKceuPHWMIBbW53q5cA4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a9uelMAHwH7Je1LtUFX8A5PNevQjUPy8fKaxnDo3TklqW7kUn0HZspUIuEEyqPZ9VGKkk4wo1hF2RHhcMsYLtND56mJp2uwEEhzOynyozcxJt6gb1MmNGKrIhDNM0o9EFHpoVZahqmouCOU7wJTjBs48N01W+MyzjqzjWm36pQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=j1K0utex; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=pWyKX8jgkDA0yDIFXjvMwp7DOPNQgkz7lqE0A34gzB4=; b=j1K0utexd28OWhYUR4CEPX/3zD
	0P2czkyznuuDj+KOhdvz4RzfgZp07sd4EXo0uEWsvP5odt/lUbweTf+FlF22dNdvGPXbMThGjGHKE
	4y6EYla37Lcry8rVVWD4W8BP9XgAkgOt3N9LWI8ne2Prhh09N29wAvn+NmhbRKfHCK00LoWM7sAHm
	FdcLPPyDkx0DcGzwghsaCC0pBNjfOboyGZP7a+SuJ6eFq3gO7cAV5SoW2fdO0Pd/iqL0M5wMX1vRE
	NrkdJD80wcUEsTW/qiA3FLo8uTCAhDjpdf92lgKPKpLdSCktAm0uMXYYGxbwCFmhHgISRFrqH/yav
	VAepqqxg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tgsyT-00000007qwg-3XGu;
	Sat, 08 Feb 2025 22:06:53 +0000
Date: Sat, 8 Feb 2025 22:06:53 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: NeilBrown <neilb@suse.de>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jeff Layton <jlayton@kernel.org>,
	Dave Chinner <david@fromorbit.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 14/19] VFS: Ensure no async updates happening in
 directory being removed.
Message-ID: <20250208220653.GQ1977892@ZenIV>
References: <20250206054504.2950516-1-neilb@suse.de>
 <20250206054504.2950516-15-neilb@suse.de>
 <20250207210658.GK1977892@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250207210658.GK1977892@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Feb 07, 2025 at 09:06:58PM +0000, Al Viro wrote:
> On Thu, Feb 06, 2025 at 04:42:51PM +1100, NeilBrown wrote:
> > vfs_rmdir takes an exclusive lock on the target directory to ensure
> > nothing new is created in it while the rmdir progresses.  With the
> > possibility of async updates continuing after the inode lock is dropped
> > we now need extra protection.
> > 
> > Any async updates will have DCACHE_PAR_UPDATE set on the dentry.  We
> > simply wait for that flag to be cleared on all children.
> 
> > +static void d_update_wait(struct dentry *dentry, unsigned int subclass)
> > +{
> > +	/* Note this may only ever be called in a context where we have
> > +	 * a lock preventing this dentry from becoming locked, possibly
> > +	 * an update lock on the parent dentry.  The must be a smp_mb()
> > +	 * after that lock is taken and before this is called so that
> > +	 * the following test is safe. d_update_lock() provides that
> > +	 * barrier.
> > +	 */
> > +	if (!(dentry->d_flags & DCACHE_PAR_UPDATE))
> > +		return
> > +	lock_acquire_exclusive(&dentry->d_update_map, subclass,
> > +			       0, NULL, _THIS_IP_);
> 
> What the fuck?
> 
> > +	spin_lock(&dentry->d_lock);
> > +	wait_var_event_spinlock(&dentry->d_flags,
> > +				!check_dentry_locked(dentry),
> > +				&dentry->d_lock);
> > +	spin_unlock(&dentry->d_lock);
> > +	lock_map_release(&dentry->d_update_map);
> > +}
> 
> OK, I realize that it compiles, but it should've raised all
> kinds of red flags for anyone reading that.  return + <newline> is
> already fishy, but having the next line indented *less* than that
> return is firmly in the "somebody's trying to hide something nasty
> here" territory, even without parsing the damn thing.

Incidentally, that's where lockdep warnings you've mentioned are
coming from...

