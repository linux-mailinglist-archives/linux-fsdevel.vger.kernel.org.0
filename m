Return-Path: <linux-fsdevel+bounces-70582-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C9ECCA0D7F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 03 Dec 2025 19:14:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 70CB430094B4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Dec 2025 18:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89BDE398F86;
	Wed,  3 Dec 2025 18:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="m6HaoR9X"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E56952FB962;
	Wed,  3 Dec 2025 18:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764785079; cv=none; b=MtrpeOt+JH/GeJwAaUfmyJL27iCH5IpE7B9s4ZoDbJ7NlQYegZJLTalJDwd/24RcjPz1d3Q8NnjpfdPXn6a6W/vCUKgKcbRQRUTOD2GxfwguEi6+D84SsaeQ4oWGTtEolcrxJuOXUaMMJmlk3riz/Jymz0uZXwVri0nir/NS1pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764785079; c=relaxed/simple;
	bh=Se2PfxGlMP2oRTa5rQHeRfD2j2fYjzcv//v6ox5mTys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dYpcXPt6GjeCGqfhllfguUzy/ifOAJO/nXAPkjm5hS/RHwmoLqCKppxBctyfunj/9wSo+mdYnBHfaZ9jhWq0Xp1N/DbpNCSC5lYr9lP2QrSAZ2k54mcCDddNq9rVQ8EnIioQ1i8+bc9aI4aSCQAh/xq2B3Rit8Zl6A5tsakq99U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=m6HaoR9X; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=BiiCmM83gj8nnJg+Q05lk7LGEvwJXQOD7Xzr4jYNyao=; b=m6HaoR9X2nkIwoWIrWXb37Miiz
	F/2it5/akUUd0a+saZ4vxzTp6syli3LaRdiML/kv1ziH6todL8mdl13EEqeSq+hQaS55qayIMy9xM
	3iudv3BxzJOkZpuH7SZmzkDYMjc0LlgEj3Ps1GoMDYMbhqzCRRw22Q33EPuW1y56kuOa+UJ4o6L1L
	0kv8VYGgCsdNt9ED/hftIBBAy0afA4Yo8AnQEBW84lTbOs9rQhgoQvDE8uqPFoMFmnqZ9IaXmKKYG
	IkzHNm+xdOI+lp396gtbx2ERkW2+ix+EccOmN6D+GpBzOqRHod3kuoqoQFaO7v7Rhj3yOvlnNthgo
	vmxdiKXg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99 #2 (Red Hat Linux))
	id 1vQrDY-0000000BsuX-0efU;
	Wed, 03 Dec 2025 18:04:44 +0000
Date: Wed, 3 Dec 2025 18:04:44 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Dominique Martinet <asmadeus@codewreck.org>
Cc: Eric Sandeen <sandeen@redhat.com>, v9fs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	ericvh@kernel.org, lucho@ionkov.net, linux_oss@crudebyte.com,
	eadavis@qq.com, Remi Pommarel <repk@triplefau.lt>
Subject: Re: [PATCH V3 5/4] 9p: fix cache option printing in v9fs_show_options
Message-ID: <20251203180444.GG1712166@ZenIV>
References: <20251010214222.1347785-1-sandeen@redhat.com>
 <20251010214222.1347785-5-sandeen@redhat.com>
 <54b93378-dcf1-4b04-922d-c8b4393da299@redhat.com>
 <20251202231352.GF1712166@ZenIV>
 <c1d0a33e-768a-45ee-b870-e84c25b04896@redhat.com>
 <aTBRdeUvqF4rX778@codewreck.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aTBRdeUvqF4rX778@codewreck.org>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, Dec 04, 2025 at 12:04:21AM +0900, Dominique Martinet wrote:
> Eric Sandeen wrote on Tue, Dec 02, 2025 at 07:09:42PM -0600:
> > >> -		seq_printf(m, ",cache=%x", v9ses->cache);
> > >> +		seq_printf(m, ",cache=0x%x", v9ses->cache);
> > > 
> > > What's wrong with "cache=%#x"?
> > 
> > Nothing, presumably - I did not know this existed TBH.
> > 
> > (looks like that usage is about 1/10 of 0x%x currently)
> 
> I don't have any preference here, but I've folded in %#x when applying
> because why not -- I've been seeing it slightly more often lately so I
> guess it's the "modern way" of doing this.

In 4BSD libc by October 1980, part of ANSI C variants all way back to C89.
Covered in K&R 2nd edition ('88); 3BSD didn't have it, neither did v7,
so I'd guess that it was done at some point in 1980, possibly late 1979.

So it's hardly something newfangled...

