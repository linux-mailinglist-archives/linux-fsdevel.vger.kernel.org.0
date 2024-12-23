Return-Path: <linux-fsdevel+bounces-38016-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 07A429FA9F6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Dec 2024 06:19:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A83F1886173
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Dec 2024 05:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6307323AD;
	Mon, 23 Dec 2024 05:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="NHxA2Sb6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E7DA1372;
	Mon, 23 Dec 2024 05:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734931185; cv=none; b=hMEMimBk+vdskJEa0SeZscNeDz3XRXgW62NqCpJsW96+Hv5+rSKxoDrcWy+O2s24ByaeS5p+E0yo3meXZG69gOWpeiyAW9TxVbu30SkvRPYQZW092hQFguNc4sECOlTEnJ0IcEdlAyptS3jSii7VybufPtwH0FohzfhLGugcNHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734931185; c=relaxed/simple;
	bh=6MdN8RrmW5gjEXsdY8pW9F6MEF81x5AxH7x/pCGkhCQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ORR/59WwFIIZAjDBU0cfLr37ibgKJRWdFwWpc60xeVa7etjvIzsRfql7UKkRar91K6pfQ4ZOXC8U+lYcVJeXddlremrTaLH6w1BZg1GpCuRUQacRz0hfnZ3+B41iLSnJmn6Yn9XRw9XDBvOG7XW8fd3wSxMmT+cMO6ZhR+jF0bU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=NHxA2Sb6; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=+Jk03EvDp5uVljz8NJwNHNASqMr3YLkjSEcRWzvD2fo=; b=NHxA2Sb6SuVTV7Tv9et165csAu
	0yPv4h0PCTld10rLIuM27If4vOjlcnuTQ00xXrYven9BOfNC5RtBb2bliiCVzClsYRRJYUPds5Lye
	Vn15FMzbnH83QQh8jVqlP1hK6qOWOjAyzezNb/Nmu5Mbj4tv4Ot4jYi5PH+dlmnZh+kiXIBXInfh5
	MX7ast4QGUK1ZzGs2zU2fEgrQW/2WezIG+2EU8OImy7FO44qzojsRCWkzRW+i0FanDzB7VLpUwr6X
	rQpg4hMKj73jwffB8G01YRXbSvUztGFg6oUJM6z8q+OOeM/RdLIZ+Ii9j6av6DmKEiD21/2GlgolC
	Ztb1ClGw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tPaqz-0000000BCbi-1RNc;
	Mon, 23 Dec 2024 05:19:41 +0000
Date: Mon, 23 Dec 2024 05:19:41 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: NeilBrown <neilb@suse.de>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/11] VFS: take a shared lock for create/remove
 directory operations.
Message-ID: <20241223051941.GK1977892@ZenIV>
References: <20241220030830.272429-1-neilb@suse.de>
 <20241220030830.272429-11-neilb@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241220030830.272429-11-neilb@suse.de>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Dec 20, 2024 at 01:54:28PM +1100, NeilBrown wrote:

> Once the exclusive "update" lock is obtained on the dentry we must make
> sure it wasn't unlinked or renamed while we slept.  If it was we repeat
> the lookup.

> +		if (
> +			/* Was unlinked while we waited ?*/
> +			d_unhashed(dentry) ||
> +			/* Or was dentry renamed ?? */
> +			dentry->d_parent != base ||
> +			dentry->d_name.hash != last->hash ||
> +			!d_same_name(dentry, base, last)
> +		) {
> +			rcu_read_unlock();
> +			spin_unlock(&dentry->d_lock);
> +			lock_map_release(&dentry->d_update_map);
> +			dput(dentry);
> +			goto retry;
> +		}
> +		rcu_read_unlock();
> +	}
> +	dentry->d_flags |= DCACHE_PAR_UPDATE;
> +	spin_unlock(&dentry->d_lock);

... and now __d_unalias() moves it to new place, making all the checks
you've just done completely useless.

