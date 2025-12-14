Return-Path: <linux-fsdevel+bounces-71263-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A9D8CBB65E
	for <lists+linux-fsdevel@lfdr.de>; Sun, 14 Dec 2025 04:27:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 19DD1300D491
	for <lists+linux-fsdevel@lfdr.de>; Sun, 14 Dec 2025 03:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E31D628727F;
	Sun, 14 Dec 2025 03:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="WLn6X98r"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F081C3F0C;
	Sun, 14 Dec 2025 03:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765682830; cv=none; b=Se6ZHRPZCbuc6tZl+Qme7xdkOqC5hhUS6vsnA3hHmuXsCNfAh4RmpUMIZPYii8hWpeLLLxSxSwj6wNLvf+Vas4bv11lKDfSDHeGWca0Bo/oSKCBlaQDT27VIX6sen9E7FnuXrm4d5G3Ot4CJqw1y2aVbw3zCHW8YDS1mFkqArx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765682830; c=relaxed/simple;
	bh=U0o4ImQQ6LAxIlM3X3XoWlen6sUXOs67Kcr5VJNwEgk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DmpuhQ9YMjfrYV2/PkHOYM582FMmKBlWu1IAL3VU7zNmGdqb/iBF7r1QqAFXGL4Zf3o9UBSRXymG53cwUqkgK1D3/vc70sjQyRLU+pP5BU81Maf6PhJsotdIFS/6lEX364A80q0YjBMKZ2DNzUpPZ6+lvoBFNOY43wxilgF7O0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=WLn6X98r; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=daKyAtCUV+qOiVIBB6oUwMd/W2Iw3WrV8/lwVUqgVdk=; b=WLn6X98rc27kiAai7WW2purgsD
	PKB6n2bP7EMLo9Pp0ws7+mM6eKdQlwNtQeE+E/YhV6MdDAgkSeOj03C5CoYibGm51ZliSFVXDODg9
	qG1d2iZjMPiZs6CKefsV/QPf0kHNL5EQmzF5Gz/KRYpwLaWFZlBbtwMGThm2YyV26ufmpd0gQxrM2
	lUqr2KPus2yAsz/nKm6I36FaT6EJeFGFeayXS0pEChOLLq3+c63uNHdNz7r59yjdpETdp8D4rSLqS
	BtNr72QOaHK/kw12Wixk1bzdZavqFztJ9xabDkrb3UHDuomnjMxvJUTd2Cigqfn7kbZv4Qyx7Y45e
	yVrr+RPA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99 #2 (Red Hat Linux))
	id 1vUcli-00000001vqe-1yAt;
	Sun, 14 Dec 2025 03:27:34 +0000
Date: Sun, 14 Dec 2025 03:27:34 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Hugh Dickins <hughd@google.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>,
	Christian Brauner <brauner@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, Linus Torvalds <torvalds@linux-foundation.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: shmem_rename() bugs (was Re: 6.19 tmpfs __d_lookup() lockup)
Message-ID: <20251214032734.GL1712166@ZenIV>
References: <47e9d03c-7a50-2c7d-247d-36f95a5329ed@google.com>
 <20251212050225.GD1712166@ZenIV>
 <20251212053452.GE1712166@ZenIV>
 <8ab63110-38b2-2188-91c5-909addfc9b23@google.com>
 <20251212063026.GF1712166@ZenIV>
 <2a102c6d-82d9-2751-cd31-c836b5c739b7@google.com>
 <bed18e79-ab2b-2a8f-0c32-77e6d27e2a05@google.com>
 <20251213072241.GH1712166@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251213072241.GH1712166@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sat, Dec 13, 2025 at 07:22:41AM +0000, Al Viro wrote:

> 	What I'm going to do is a couple of patches - one fixing
> the regression in this cycle (pretty much what you'd been testing),
> then a separate fix for stable offsets failure handling (present
> since 2023).  I'll feed them to Linus; I hoped to do that with
> old regression fixed first, to reduce the PITA for backports,
> but if I don't have that debugged tomorrow, I'll send the recent
> regression fix first.

OK, I think I've got it; see

git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git #fixes

individual patches in followups; the first one deals with this cycle
regression, the second - with older bug in shmem_rename() failure
exits.

Folks, please review.  If nobody objects, I'll send a pull request on
Monday.

