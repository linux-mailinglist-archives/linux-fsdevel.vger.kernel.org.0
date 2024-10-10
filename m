Return-Path: <linux-fsdevel+bounces-31610-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 34E42998E2D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2024 19:17:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E2821C24952
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2024 17:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C3B919C57D;
	Thu, 10 Oct 2024 17:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="uq9z9CSu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FFB4199FBB;
	Thu, 10 Oct 2024 17:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728580633; cv=none; b=tZEJ/qoFeKNRJuKOnWKilViK7R065qV9BeWZ9m63J0M0Y4ibkoKRnR4gfaAXaoPjMIpAMuVx/jwr620/VQeJRAHrWyQ8M94IjK5mIkHcx2NnxpPMmfaks6g9ddYC98xXNrG1I3Hs21uUaKHRmRmUeowpxbc+EW7n/CSFy5zD0kY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728580633; c=relaxed/simple;
	bh=Mqrc/RqiIfUlt4QRnh3oGXGClJEOCxUluibn5jNLHp4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=llsXLRerTZaOsQXQXLpuyuaif2cqYtwdI4ypQ8Kau6m2OAxZimz1AejOW/rCC/nuq9wyBjsecDkQxRwE3KSOd0eUHuyCzf/DYPaA5bIdeJVs4FoNbeRULhPFGFknveDuf2HxzjfxSTctZt8Xhnt0paq+ZhRCJ8PuZ6V7uHP7xeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=uq9z9CSu; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=h+cK7z+ivNy4JuWC9N2vR4jluhoKiT/Fza/vwiCjng0=; b=uq9z9CSuJmsRKpWpng0qwP425B
	FD6x/0EHivi9oJwc/EpdVTrNfiytb1VGlEL0rX6F54C9aLtQUp9EkgkcXAPbc0buWGAR4W8tm9Q8K
	sf2P5qx+bOdYJhWd5kqmvAHf9zWfXbeeXyfX7nC0ly3eMIUlP3mtG5FhvTATPlDCFk+dgHaC+2wgU
	ITbdomD1muBEv3cC/bsvShfnEjGXOjbKfBh8YQt5Wq3kLJ4Eau2RXZCD2bU54BXWXrJ0GVs1AqtgL
	FJfu1K0xq7XHkI1k6UBjSjFpeV2i9k20FE3Bnkxup/p9ouUeB8PW2/1PzAT2+ELCojFuDikedUru8
	dFTSJqHQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sywmh-00000002UvW-1oco;
	Thu, 10 Oct 2024 17:17:07 +0000
Date: Thu, 10 Oct 2024 18:17:07 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Ye Bin <yebin@huaweicloud.com>
Cc: brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, yebin10@huawei.com,
	zhangxiaoxu5@huawei.com
Subject: Re: [PATCH 2/3] sysctl: add support for drop_caches for individual
 filesystem
Message-ID: <20241010171707.GB4017910@ZenIV>
References: <20241010112543.1609648-1-yebin@huaweicloud.com>
 <20241010112543.1609648-3-yebin@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241010112543.1609648-3-yebin@huaweicloud.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, Oct 10, 2024 at 07:25:42PM +0800, Ye Bin wrote:

> +	if (sscanf(buffer, "%u:%u:%u", &major, &minor, &ctl) != 3)
> +		return -EINVAL;
> +
> +	if (ctl < *((int *)table->extra1) || ctl > *((int *)table->extra2))
> +		return -EINVAL;
> +
> +	sb = user_get_super(MKDEV(major, minor), false);
> +	if (!sb)
> +		return -EINVAL;

Odd user interface aside, you do realize that you've just grabbed ->s_umount
from inside a ->write() instance?  Considering how much can be grabbed
under ->s_umount... Ow.

IOW, I very much doubt that doing that kind of stuff from sysctl is a good
idea - if nothing else, we'll end up with syzbot screaming its head off
about many and varied potential deadlocks, as soon as it discovers that one.
And I wouldn't swear that all of those would be false positives.

