Return-Path: <linux-fsdevel+bounces-10987-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D00884F9B9
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 17:37:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDA221F237E5
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 16:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31B157B3F3;
	Fri,  9 Feb 2024 16:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="FSTbVW6P"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C6A7B3D1
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 Feb 2024 16:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707496613; cv=none; b=T45LycllZX72VjxsAr/uniWAsS7aEkK1ukuUUKcaRHb2pli/tTY0iF/d4oiD9xqwkwAOoy2FAyOUTDYvZZd9TwXCGc/X/cNRF3FmUbjLxM72kD5KTPLjekIex5ipFHYnDIUl8T/ZpRBWjNhR2mBfnvwMDU1v2kYuwiumH8Iu+R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707496613; c=relaxed/simple;
	bh=/AE1H+OrhUdRbYZncgCyaiVeqGri3bI4xE/lSfbbuAg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OB2mxa7wxoMj2vjZbzMYQEtEWHd1VF+XZHWMVUn0NsFx21zYHp3p8gt5AZp7kdKSBl8ZtSZUzN76LAxNJgJd82xd8arGeWsBaEyCltwYPUEsrHYMcGoXfjGegaUb/CMiegJhFgkjXk0xxFCGWDnDYAmHrFCQUScKdVkyK5xFZKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=FSTbVW6P; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=JYPwv5nf79wQp7dvamybvTyIQ6FenV1h4xi8o+FKCEQ=; b=FSTbVW6PXuddu/swoP5ml6gtav
	dbPQB8D9URwvaLedNgIhh7yu3pMndQKsV1vKqysRz9fXzR/YGYn/PB7ZYV49xi/vP/pE05nV1bb9q
	ZXpd/7tIWvyFPcUkH3xST7pTvFeEQvcinFdy5oqvZB81wYZw5/qJSBWZC9rrIxHEfa8ktM/Do5KHD
	eJxeqYpU/VGEhJar6zqDc6qlODmezqdx1XEQybQiATkade6L1gtCH2iXypJr1HqdFmZTjGfw9py9Q
	GW2QaZIyMnhp0SYaET8njqE9SPi6/EH161m/cAoStr4k0U+9m6qWUOUNBVftya7IAaaoYj+oTj/Zt
	JLDS1DIA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rYTrq-004JWC-0S;
	Fri, 09 Feb 2024 16:36:46 +0000
Date: Fri, 9 Feb 2024 16:36:46 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Christian Brauner <brauner@kernel.org>
Cc: Dmitry Antipov <dmantipov@yandex.ru>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	linux-fsdevel@vger.kernel.org, lvc-project@linuxtesting.org
Subject: Re: [PATCH] [RFC] fs: prefer kfree_rcu() in fasync_remove_entry()
Message-ID: <20240209163646.GD608142@ZenIV>
References: <20240209125220.330383-1-dmantipov@yandex.ru>
 <20240209-hierzu-getrunken-0b1a3bfc7d16@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240209-hierzu-getrunken-0b1a3bfc7d16@brauner>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Feb 09, 2024 at 03:22:15PM +0100, Christian Brauner wrote:
> On Fri, Feb 09, 2024 at 03:52:19PM +0300, Dmitry Antipov wrote:
> > In 'fasync_remove_entry()', prefer 'kfree_rcu()' over 'call_rcu()' with dummy
> > 'fasync_free_rcu()' callback. This is mostly intended in attempt to fix weird
> > https://syzkaller.appspot.com/bug?id=6a64ad907e361e49e92d1c4c114128a1bda2ed7f,
> > where kmemleak may consider 'fa' as unreferenced during RCU grace period. See
> > https://lore.kernel.org/stable/20230930174657.800551-1-joel@joelfernandes.org
> > as well. Comments are highly appreciated.
> > 
> > Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
> > ---
> 
> Yeah, according to commit ae65a5211d90 ("mm/slab: document kfree() as
> allowed for kmem_cache_alloc() objects") this is now guaranteed to work
> for kmem_cache_alloc() objects since slab is gone. So independent of
> syzbot this seems like a decent enough cleanup.

Sure, but we'd better make very sure that it does *NOT* get picked by any
-stable prior to 6.4.

