Return-Path: <linux-fsdevel+bounces-71183-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E9FACB7F48
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Dec 2025 06:34:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B3DD03062236
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Dec 2025 05:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26CC530DED5;
	Fri, 12 Dec 2025 05:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="TuQVDuyz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7757F219EB;
	Fri, 12 Dec 2025 05:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765517669; cv=none; b=JfnkN1vQlN7sbHs4ED4KofC9+VQ+eD1chJQfXtOgYXF6lotZMaWAwWNwsV+qqLNt9VK5q/fvkJ12FjmbMWNa+BLYcOk8dZ/f83sI0Ma7vZ4nNYr8l0JUfBxDn3e/F/AcCZvcpPJAmFxdVlIHf4aFNT7xWnSmVCp3G94KxQppaIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765517669; c=relaxed/simple;
	bh=0qOm0uXZUYlw7aWWFGnoUOjakY8EtMnJboqrZO0bzUw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SxMolakzEjyYOxMNvBCPkI7h7QAt3LXh+FAeXTcm50W+B5GcRPf/sI9tN+7vsSVWVmbAC4c9Xl7D8Bp3V1ufKx4oRnl4ZcY+uLyPliYm/y6DPwix3Qc0JbfrUNyshfRWRXoqbzRJuBq9pOUZTnNSGQ9gm6unQq59Q4KjmzU2+5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=TuQVDuyz; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=TlpYrSosOBmNWlnFfYJnHh8ac0VqsZN0gBrjnGMp98E=; b=TuQVDuyzmfD1zEEjoneYjUYdl1
	EtEYQ17Hm6dGjcPhp0LIuKcuz2d26+57P12EoYAdxnuOq/5yG+LrSaC81afa2nNA61A28jFRpx3uK
	cOrHuq80BCyjoy7Ihzht6mPKIHtiIguODQa4N+AOvhk7N/zdocgFPqdcpoLJb79JImlm3u2VureMX
	86PQ8wUxGbjfX8IaSbYC5OnniGmsX+7pjdxr+vQzm8bzoOM+vrwP2hTa9V7Wq1vh04NNECKCcLtlW
	3g5r+3lD9vPMnHSxwGPQSA0m0z25tC0ARqh12CjSzS+M2ug/ek8b7GPef9AbTzKhXsjncxBYJ/JDD
	a/jwk5jQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99 #2 (Red Hat Linux))
	id 1vTvnp-0000000B92D-01cz;
	Fri, 12 Dec 2025 05:34:53 +0000
Date: Fri, 12 Dec 2025 05:34:52 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Hugh Dickins <hughd@google.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: 6.19 tmpfs __d_lookup() lockup
Message-ID: <20251212053452.GE1712166@ZenIV>
References: <47e9d03c-7a50-2c7d-247d-36f95a5329ed@google.com>
 <20251212050225.GD1712166@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251212050225.GD1712166@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Dec 12, 2025 at 05:02:25AM +0000, Al Viro wrote:
> On Thu, Dec 11, 2025 at 07:56:38PM -0800, Hugh Dickins wrote:
> 
> > Of course, 2313598222f9 ("convert ramfs and tmpfs") (of Feb 26 2024!)
> > comes out as the first failing commit, no surprise there.
> > 
> > I did try inserting a BUG_ON(node == node->next) on line 2438 of
> > fs/dcache.c, just after __d_lookup's hlist_bl_for_each_entry_rcu(),
> > and that BUG was immediately hit (but, for all I know, perhaps that's
> > an unreliable asserition, perhaps it's acceptable for a race to result
> > in a momentary node == node->next there).
> 
> Hmm...  Could you check if we are somehow hitting d_in_lookup(dentry)
> in d_make_persistent()?

Another question: is it a CONFIG_UNICODE build and are you running with
casefolding anywhere in the vicinity?  If so, does this thing reproduce
without that?

Because that's one potential area of difference between shmem and ramfs
(as well as just about anything else where tree-in-dcache might be
relevant); if that's where the breakage happens, it would narrow the
things down nicely...

