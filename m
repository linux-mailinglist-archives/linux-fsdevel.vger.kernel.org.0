Return-Path: <linux-fsdevel+bounces-48313-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECC64AAD2C6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 May 2025 03:25:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D15698641F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 May 2025 01:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C6D0155335;
	Wed,  7 May 2025 01:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BWSCbLO7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0556B13AA3E
	for <linux-fsdevel@vger.kernel.org>; Wed,  7 May 2025 01:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746581021; cv=none; b=i3Z68uDm0rf2BtR7UiL6gVkzcShCz8Gg4fJH6H+n6ntQm1+hFyNE8HUcflxYUMztNzELI0fcMUR7VYzLx9lxMk60YkVPpVmVt/DjeW2YYkudFFKTuYcWpe2tyYwtx5j+AbP44p72yQIQUd1jJwU+6jmPLIDsNd4rVnpYNh1n0aY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746581021; c=relaxed/simple;
	bh=F4eggE/XuvmFU6Dzpov5lbcFYVF1XKoy/tEW6B4VUpE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K73ytfqOixOvFIzolln03aEFo4aDOQBG1iDMBmIrm5E8vHqaNmS7HcmPBQQ6Ry2q9+aC2aVEhXCxmK1oBmLrX6zZww/gT5lg89kmAKe17DFRYIYBQkSoSSrsiEgEZjrb+CxOF08rMZQEb6ZytMuyWpvEEDMJcWsc6WzAQryVZuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BWSCbLO7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BC2EC4CEE4;
	Wed,  7 May 2025 01:23:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746581020;
	bh=F4eggE/XuvmFU6Dzpov5lbcFYVF1XKoy/tEW6B4VUpE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BWSCbLO7kICn4t9yIanA0ANkvU/GeY08csO1HjIbMev00UHlhYwxHXSF6mR9hKD1q
	 zL47fz8tUvnTBBFnq0aoXz+QUa0XpDvneSQaqWUQDnp2bSMtcJbb91vGtQed1a1Spv
	 CDDKNrLOzA5Ojwx6NnVc47Q43ZNl/oUalMsiNbFiSRLKvcxdDQlCRgD3dnfp2ywe+F
	 rp01ZSc9HIZc82kTJbe4XbWhiQm0oPmMfiaxG9NoDpJZpPQzt0KMOf9+ofJEr/D6n8
	 HjZBCRPe41Td4wK0ILNU+RfUhK2NjHQ/THLKbY/CKz3WRg/EMJbV3MK2gZsvla7Qye
	 tGgjpWz1ODIxQ==
Date: Wed, 7 May 2025 01:23:38 +0000
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Eric Sandeen <sandeen@redhat.com>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org,
	chao@kernel.org, lihongbo22@huawei.com
Subject: Re: [PATCH V3 0/7] f2fs: new mount API conversion
Message-ID: <aBq2GrqV9hw5cTyJ@google.com>
References: <20250423170926.76007-1-sandeen@redhat.com>
 <aBqq1fQd1YcMAJL6@google.com>
 <f9170e82-a795-4d74-89f5-5c7c9d233978@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f9170e82-a795-4d74-89f5-5c7c9d233978@redhat.com>

On 05/06, Eric Sandeen wrote:
> On 5/6/25 7:35 PM, Jaegeuk Kim wrote:
> > Hmm, I had to drop the series at the moment, since it seems needing more
> > work to deal with default_options(), which breaks my device setup.
> > For example, set_opt(sbi, READ_EXTENT_CACHE) in default_options is not propagating
> > to the below logics. In this case, do we need ctx_set_opt() if user doesn't set?
> 
> Hm, can you describe the test or environment that fails for you?
> (I'm afraid that I may not have all the right hardware to test everything,
> so may have missed some cases)
> 
> However, from a quick test here, a loopback mount of an f2fs image file does
> set extent_cache properly, so maybe I don't understand the problem:
> 
> # mount -o loop f2fsfile.img mnt
> # mount | grep -o extent_cache
> extent_cache
> #
> 
> I'm happy to try to look into it though. Maybe you can put the patches
> back on a temporary branch for me to pull and test?

Thank you! I pushed here the last version.

https://github.com/jaegeuk/f2fs/commits/mount/

What about:
# mount -o loop,noextent_cache f2fsfile.img mnt

In this case, 1) ctx_clear_opt(), 2) set_opt() in default_options,
3) clear_opt since mask is set?

And, device_aliasing check is still failing, since it does not understand
test_opt(). Probably it's the only case?

> 
> Thanks,
> - Eric
> 

