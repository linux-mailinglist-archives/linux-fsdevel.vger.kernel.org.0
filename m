Return-Path: <linux-fsdevel+bounces-71988-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2869ACDA2FD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Dec 2025 18:58:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DC30B30562E9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Dec 2025 17:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DBCB35029B;
	Tue, 23 Dec 2025 17:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="cRGgJKOc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3AC3350288
	for <linux-fsdevel@vger.kernel.org>; Tue, 23 Dec 2025 17:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766512242; cv=none; b=syO/P9BWfCd18bNjWGK668bbnU9hatuJEX9OLSowpCyLiMVqTwez2mMfsEvjq+7o68IR0LRfr+RV1PoK2pGMgT960RZ36bqlL6UpToWTLwPMHTB3NcmGiTaREdi040WISJCC0CFgIQw6oRATenZomjp3jZNtLZ+S7/zG/+Hpu2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766512242; c=relaxed/simple;
	bh=1L0JcjKjUiZ0M6l7c2rIcSf6OFTJmW2mMmtZQzrsHVg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G9TiMsfn0144LOMTeZQ1Ls+T1KYz9cQL8aHbJTctQfYdrP5+rc8T28HFYI0QQsZCHVgHzctjooE8lHLw25DJkEuV+ViCSskup61TrsGny0hgWiOMvRl4OmKyYGQfZHLS0vzJo7794QhVi2v1Xllhty0f5JsrDG7dDP0h1ZOBAY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=cRGgJKOc; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=V3xELkGb5rihbexLGeefbl/htIOV8XG31wmfQOflumo=; b=cRGgJKOc/pHSRuE2qN9OrRQQXL
	fhm4R6yZTRT2TUVUjjNN7cw037ZrlHet/NxVA0Y2FY/XiKm5RzldKm8JTLLa6X/YKT0nlvhLjj1ZV
	ktL4YQBhCguUBYEqY3O1RmQv9DE+PS+thi3X49yWsIOPn+of53hAZ555rODrfUbzrfj1K8i2WKrta
	BtH5RUyskzWX7SsZ1/d9cFa3gAq8ipsXwvzIIFYYJikHsZ0RXOu3mgi7QsmCgXwhc+KdPJdRUFDSM
	abwRJIoypYIb1XVEFwAN9eFS2jCBCPDCfdhQ7gZ0lMaUABiyUFyQdLzrUkfOoPJB570atGKrEzFzw
	eZmdRwxA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99 #2 (Red Hat Linux))
	id 1vY6Xg-00000006R8R-0U3k;
	Tue, 23 Dec 2025 17:51:28 +0000
Date: Tue, 23 Dec 2025 17:51:28 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Andrei Topala <topala.andrei@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs: allow rename across bind mounts on same superblock
Message-ID: <20251223175128.GC1712166@ZenIV>
References: <20251223173803.1623903-1-topala.andrei@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251223173803.1623903-1-topala.andrei@gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Dec 23, 2025 at 05:38:03PM +0000, Andrei Topala wrote:
>   Currently rename() returns EXDEV when source and destination are on
>   different mounts, even if they're bind mounts of the same filesystem.
>   This forces userspace (mv) to fall back to slow copy+delete.
> 
>   Change the check from comparing mount pointers to comparing superblocks,
>   which allows renaming across bind mounts within the same filesystem.

... which destroys the use of bind mount as rename boundary.  Why is that
a good idea?

