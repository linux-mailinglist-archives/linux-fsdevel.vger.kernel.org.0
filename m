Return-Path: <linux-fsdevel+bounces-35252-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CD479D320D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2024 03:09:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB1EFB22071
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2024 02:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDC4774C08;
	Wed, 20 Nov 2024 02:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="WtBX6dvO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B9939ACC;
	Wed, 20 Nov 2024 02:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732068534; cv=none; b=N6DjnIWZlF4AXvO8p9jel4lHRwntowazoxRBGmMUrSq8dmb9QPd9ahl+JPPQ/dvGo8lg4G2E3T63VXGdYEQCuPq0xVSHx3dhvsRWtM4xRctYwq1aGX6skAAKBwxAy2F7oBUNhMrtNFNHS9LFaihmteEqd0Drk5kTAbUjxaoQbQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732068534; c=relaxed/simple;
	bh=0G9xqB8ZIVEdNzw42qgAjYDc6kCXvIHjzIgN5O4aQE8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CNPxVFaSj8+cwWRPOGa2r6SLha3BZu98rvDJ2FfwriONmntqieYLLZLyupSz5/eK9uCHu92DShmKsL89Hi0Sj9k4eVhzMkoRTN9K1cAXXzJzL/sS3PtL1EwmDIFWz62MP5DfiPs/GfZnn9b9knzS/RTj1AGX5/ULZCBWLKs+ZtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=WtBX6dvO; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=EoKXj/IRh35Cf3Umy93Mvyit2mCVDr48IlOQcgDFWtg=; b=WtBX6dvOtCrGQUwuFXix9QeM/c
	Ytl67DmCmHapJUPYFGi1GuZ5CvZykEtPkHskAoyg3RRGeHV8VvhAUNhCwcNW4+2w7H3oomgXY42tV
	AhXAYqQ8y7MeaKeiNLR/X6uPth2JCpbRn5Lqn75tJEQ55r0V6gWdid915GBchhCCLxy3GezKVoteK
	V22COoJblqUcBrDsgB+xxZdFTfaQO4SvkW33l6XJp9ddinGAzk9REIZRpEbnDw/KdawqTwgPSd5fo
	ndiLfg8Jgs9UZKNoKT5+hNoT5+scpgEwz1GrRwHudoibdibVWEYSp75PfjXjf/ORI4DV/AIi505Pp
	Oax1TzNw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tDa97-0000000H8Sr-0F7f;
	Wed, 20 Nov 2024 02:08:45 +0000
Date: Wed, 20 Nov 2024 02:08:45 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Jeongjun Park <aha310510@gmail.com>, brauner@kernel.org, jack@suse.cz,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] fs: prevent data-race due to missing inode_lock when
 calling vfs_getattr
Message-ID: <20241120020845.GK3387508@ZenIV>
References: <20241117165540.GF3387508@ZenIV>
 <E79FF080-A233-42F6-80EB-543384A0C3AC@gmail.com>
 <20241118070330.GG3387508@ZenIV>
 <3pgol63eo77aourqigop3wrub7i3m5rvubusbwb4iy5twldfww@4lhilngahtxg>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3pgol63eo77aourqigop3wrub7i3m5rvubusbwb4iy5twldfww@4lhilngahtxg>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Nov 20, 2024 at 02:44:17AM +0100, Mateusz Guzik wrote:

> > Pardon me, but I am unable to follow your reasoning.
> > 
> 
> I suspect the argument is that the overhead of issuing a syscall is big
> enough that the extra cost of taking the lock trip wont be visible, but
> that's not accurate -- atomics are measurable when added to syscalls,
> even on modern CPUs.

Blocking is even more noticable, and the sucker can be contended.  And not
just by chmod() et.al. - write() will do it, for example.

> Nonetheless, as an example say an inode is owned by 0:0 and is being
> chowned to 1:1 and this is handled by setattr_copy.
> 
> The ids are updated one after another:
> [snip]
>         i_uid_update(idmap, attr, inode);
>         i_gid_update(idmap, attr, inode);
> [/snip]
> 
> So at least in principle it may be someone issuing getattr in parallel
> will happen to spot 1:0 (as opposed to 0:0 or 1:1), which was never set
> on the inode and is merely an artifact of hitting the timing.
> 
> This would be a bug, but I don't believe this is serious enough to
> justify taking the inode lock to get out of. 

If anything, such scenarios would be more interesting for permission checks...

