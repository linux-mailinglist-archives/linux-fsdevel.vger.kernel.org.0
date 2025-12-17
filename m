Return-Path: <linux-fsdevel+bounces-71541-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B9702CC6B54
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Dec 2025 10:08:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BC6D53005517
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Dec 2025 09:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4652C341049;
	Wed, 17 Dec 2025 09:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="MobHtdD1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7EF326E717;
	Wed, 17 Dec 2025 09:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765962479; cv=none; b=oiYHp3BOBSYTJIl7XleSuR+rYWTv/weUs4Fu3+Qz9gyGarW63UVtUq+6ffvFCoPtOKG9OE/ukG76mp16IEdH03CWKYk341DoWGJWZ1AS35aHV/IQ//1KCAdMUjREKx/coLm2SAVwiD5Ly3rQspL9VjOGZrNWYS0W7jl+I99Q7Eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765962479; c=relaxed/simple;
	bh=GA1bhgGnyk1sYuCfwrsQ1ttkmchJsJ9jqwEnNQtuG2E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ljy9uVt1zmPw94Fk5n/N4lIFLahfE2ldZnkugT3MO86GxTEYD9iVPTcYhui1S0xmo0uyRx8pnzvcBApbytmEGe1Xh6uIPmE7SBmXCbkLrCe1NKLgGd0g6vIv8/VeH5LlSkcfDMhaRPZRCD9dgLGQ3j1KoiPuWP4RKZ4mLKqW5/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=MobHtdD1; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=2WasXgbIP38suIbs7VaM9G7TNlzXyGIoQnp4hS5b+VU=; b=MobHtdD1kv5/Lki/xow23AX1KP
	a+TjPNJbN7FWQa1LUkJrkD8bIH9HVE3xzLjyvGqSh8IFi/xt+xXChnQi6N2SQQedaP/A7LFYoVHSP
	vTWM0XP9124VUognlHtiGg6sucJ+nRPKMrjhJ829yriBHPcVp+0uGqjOsk6JVXPS5KqIvydBJ2ZYz
	fiGgHwQ9rggBOAIOKe7JzPZfT84jH8c5zu0oC7SnE13XeNqUazhV+++Qrph7ox6VfI++zGgxXJJBs
	gwLeMcVnHJV04gyzXaAJHCS2EJyQl3fbW5xANUcmUyRTmvIOz5fhLEKrLUrLidrHnfh7IcI0UAi7N
	eNRZquug==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99 #2 (Red Hat Linux))
	id 1vVnWL-0000000E8Lk-3tQo;
	Wed, 17 Dec 2025 09:08:33 +0000
Date: Wed, 17 Dec 2025 09:08:33 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: brauner@kernel.org, jack@suse.cz, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, clm@meta.com
Subject: Re: [PATCH v2] fs: make sure to fail try_to_unlazy() and
 try_to_unlazy() for LOOKUP_CACHED
Message-ID: <20251217090833.GS1712166@ZenIV>
References: <20251217084704.2323682-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251217084704.2323682-1-mjguzik@gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Dec 17, 2025 at 09:47:04AM +0100, Mateusz Guzik wrote:
> Otherwise the slowpath can be taken by the caller, defeating the flag.
> 
> This regressed after calls to legitimize_links() started being
> conditionally elided and stems from the routine always failing
> after seeing the flag, regardless if there were any links.
> 
> In order to address both the bug and the weird semantics make it illegal
> to call legitimize_links() with LOOKUP_CACHED and handle the problem at
> the two callsites.
> 
> Pull up ->depth = 0 to drop_links() to avoid repeating it in the
> callers.
> 
> One remaining weirdness is terminate_walk() walking the symlink stack
> after drop_links().

What weirdness?  If we are not in RCU mode, we need to drop symlink bodies
*and* drop symlink references?

