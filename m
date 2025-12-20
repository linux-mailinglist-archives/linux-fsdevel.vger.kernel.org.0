Return-Path: <linux-fsdevel+bounces-71805-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A44CCD3900
	for <lists+linux-fsdevel@lfdr.de>; Sun, 21 Dec 2025 00:54:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 33BBA30076A4
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Dec 2025 23:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 255642FC003;
	Sat, 20 Dec 2025 23:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="FgnjQ4HP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA1C21B91D;
	Sat, 20 Dec 2025 23:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766274892; cv=none; b=MAeTx4n2T2eF5u4FIgQRJ4ypgmgtQCFKBl/nZKtyjBzwoYIbgmQiCf7bScCjF4ssrHfbE2P91/RGIO0QurbloL/E8yuzczpOyoK1jQ8Aqx8oGJgCgRItU3tP50G88h0NNfNFDsIDGlUlMdrc1Pqg5AoEojNyf2ORUlKj0AnH6rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766274892; c=relaxed/simple;
	bh=AuK77p+yohH3kZOplLj1zN5mN+iIBy6gY89oh6lU5ow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nQrv0vdbc4e5Q42HguUrRELAfPwwzfIj/n/+UFfbSNSXkGVDmFkd5rcokeptqozam11gELYWY/KEBbXOavXBKtK3mccoDc0Z6FB0I1JzzZae6aPSFv99cJFDVpUHtcwY8KKSwVDdhcjOqPbPxN4hi++VvpyGOQ1R40AbY1Vbqgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=FgnjQ4HP; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id DB01114C2D6;
	Sun, 21 Dec 2025 00:54:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1766274881;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HHQ+u9WV3/UmY5FAfmxUeuQIkZysbZpJfbXHEk2ME6s=;
	b=FgnjQ4HP4jh29C7rx2bjoXfWjS/oe35mArIv7kB6BJHnl7ZYQPSkzjNQqpmeo1euCJu2wP
	T17PHcAmAtRejYT/LinDnL7Ah1Hi43VpaBS/NZf8TAhtYOBWRaYgVZxU57TevMV3uZ99H2
	Wfc23RFTBi6waR8lrlM9xI1w7oNzrJRJiPeZpArH1BSm+OzVdQ/uEZNTz6cU+EbLqulYMB
	fh5tpBoKrgGPdkBFSZ428prXExeJfa4M+wYX4DdhYNoJi0YRDbKtvyny5nmhIw6R/A/75b
	91gCEGkHbUTprwpOiTSrXUkwUDmrREJ8mC4+S+nPaBE0pbKM3EkJal8pXSTstg==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 490b3aa1;
	Sat, 20 Dec 2025 23:54:36 +0000 (UTC)
Date: Sun, 21 Dec 2025 08:54:21 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: David Howells <dhowells@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Chris Arges <carges@cloudflare.com>,
	Matthew Wilcox <willy@infradead.org>,
	Steve French <sfrench@samba.org>, v9fs@lists.linux.dev,
	netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] netfs: Fix early read unlock of page with EOF in middle
Message-ID: <aUc3Lcy_u4FgnwjA@codewreck.org>
References: <938162.1766233900@warthog.procyon.org.uk>
 <8618918.T7Z3S40VBb@weasel>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8618918.T7Z3S40VBb@weasel>

Christian Schoenebeck wrote on Sat, Dec 20, 2025 at 03:55:09PM +0100:
> I had bisected this mmap() data corruption to e2d46f2ec332 ("netfs: Change the 
> read result collector to only use one work item"). So maybe adding a Fixes: 
> tag for this as suggested by Dominique?

Yes, I had also confirmed the bug starts occuring since that commit (and
the fix works on that point in the tree as well), please add:
Fixes: e2d46f2ec332 ("netfs: Change the read result collector to only use one work item")

That aside, your commit message looks good to me:
Acked-by: Dominique Martinet <asmadeus@codewreck.org>

Thank you for having taken the time to look at it!
-- 
Dominique Martinet | Asmadeus

