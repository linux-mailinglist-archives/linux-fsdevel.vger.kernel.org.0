Return-Path: <linux-fsdevel+bounces-63439-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A3091BB9208
	for <lists+linux-fsdevel@lfdr.de>; Sat, 04 Oct 2025 23:19:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 508D73BDB79
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 Oct 2025 21:19:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 359F327CB0A;
	Sat,  4 Oct 2025 21:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="k9BG+bUc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F87119DF66;
	Sat,  4 Oct 2025 21:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759612756; cv=none; b=MNG7L6mNPO4Z30UzToRYQSTC1Jr7mjjKRIKFPbVQMSWOnIeN4gXVGkpXYUZdurTFWIbpJ6IHUF7GjAft1yOTbXhU26ROYBH6vPOLP1apEBHIlU+J8MjjSwJw0VBpiHfPcbnbYvgHbe3vrnlnUzyOhUb4I8fqAUhNd1UxA1LOYRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759612756; c=relaxed/simple;
	bh=a4i0WDfDD/1WjtOnt/a+bp/d7HUJuTDNeXkfWD0GC2g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jePmGkSAq7zkE9pLuuI5quNZcZO+YFmYZxHaUVyYIzcUhmoCk0+4wzyaBvxyVcOpzk0//+0pym98SQ7k1FFxDNEfrm1hH+HHv8FJkB3fSXyZrdt4minZ8rS3uE8k0/CEDiw3t4rNDbE4SLpzYG2liRRTbvpluTT0ypl/r4gSzqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=k9BG+bUc; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
	bh=a4i0WDfDD/1WjtOnt/a+bp/d7HUJuTDNeXkfWD0GC2g=; b=k9BG+bUcSymbO6LRhkTI02JDeL
	vMMHw/elVbteR1giDoXVn/MR2zLhet4ADehCa2GwikQqJ68ve+b8h8hvlIw0qfkGj7EeHBzTe9n7N
	eEPOJlBjvH3Xpgywft3nr+ZyZDHcfM8juKpxUbzmsID40D39kH/Na6C7yRakMyT0wsPi+78F36gmi
	z4aaRwY2TZSwPaHjp965SS2LxWBwSt1HUvgs3JEMJs953lWqBR2N25OghVASYxABbPL/LEpvewmsK
	f2FD+47Rjb5utyCdpyYbApFMlR9OsLsuqza+iSY5C/6YntnATMq9k7Q858BYF33bxB1dTkGrKsxPO
	ACrhvQLw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v59em-0000000FnCA-49kD;
	Sat, 04 Oct 2025 21:19:09 +0000
Date: Sat, 4 Oct 2025 22:19:08 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Miquel =?iso-8859-1?Q?Sabat=E9_Sol=E0?= <mssola@mssola.com>
Cc: linux-fsdevel@vger.kernel.org, brauner@kernel.org,
	linux-kernel@vger.kernel.org, jack@suse.cz
Subject: Re: [PATCH] fs: Use a cleanup attribute in copy_fdtable()
Message-ID: <20251004211908.GD2441659@ZenIV>
References: <20251004210340.193748-1-mssola@mssola.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251004210340.193748-1-mssola@mssola.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sat, Oct 04, 2025 at 11:03:40PM +0200, Miquel Sabaté Solà wrote:
> This is a small cleanup in which by using the __free(kfree) cleanup
> attribute we can avoid three labels to go to, and the code turns to be
> more concise and easier to follow.

Have you tried to build and boot that?

That aside, it is not easier to follow in that form - especially since
kfree() is *not* the right destructor for the object in question.
Having part of destructor done via sodding __cleanup, with the rest
open-coded on various failure exits is confusing as hell.

RAII has its uses, but applied unidiomatically it ends up being a mess
that is harder to follow and reason about than the dreadful gotos it
replaces.

NAKed-by: Al Viro <viro@zeniv.linux.org.uk>

