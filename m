Return-Path: <linux-fsdevel+bounces-8540-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C79C7838DA0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 12:40:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 435FB1F249BB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 11:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42DCB5D8F5;
	Tue, 23 Jan 2024 11:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="MZfOxaH2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F5BC5D73B;
	Tue, 23 Jan 2024 11:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706010048; cv=none; b=ncXvCD2oD1Kk2GaK3/Y/2ic2rM+lG2KIGSdgnQmTDvWiOkM7J76uQelWvChIJMAZZTI+jqqhHq4wSHtKdISEIwBemRHG8zH9gbPPhvhNZs1fmcJdWG5D2ywjkax0q5/jSXgkbNvL7f15GO3atvldcN64hDMXmhjXNjNzPDwt5A8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706010048; c=relaxed/simple;
	bh=abrdKEWbRM2tgAz/9Jf8CGRQZdk11Te4jGrTOeM8q7o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y/xUfAQD/3F8zq2EMdbbHaTGAhYGlHPqLDrnQQhHNgnZIEyBf5xTRJta5Md4+RxFja5UvnZfRE768lmKtf7H/mRhm16Bg30x4wvN4HH4Y4iAThrDAme67VxGnOGnezYzwAXbZv0Ds6CUnvoKIwJgJwzaqKjjVckHrpQeC799sqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=MZfOxaH2; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=FQPrKo5NK2wqNWnanq7bvxczA2ikui+/OZAA2UKCstE=; b=MZfOxaH2P0LH9EHtr7SlRUsim0
	Anqh+IHA+0zj880rhmcvbRfiTIZFykG9ZBDLcT39Vt3G5TQS4F6M7nAhtm+Uj8RSDnOG2NVENgIup
	PHWROb3NbqhnwkqS9LbP0yAnrxcpGRsPd6gYfPN6lM4JBac2Dsuw9/VcZCLreTBzaK+27aIuXwWjJ
	opgkbUmFOvNzvvQvZ6iwF8WAm2LOizrcJcs59OC/v+VI5czcSTEfEdsnk4llM1U8cuzYoF/4DPX9r
	LeYBFZeq4YuchnNoTG7XrQUc1LPDbKFHVyz8VZmccJeyajPGeGE22Wkc65ptIv6ih/t7cTy3kSg1Q
	nRhksc0Q==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rSF91-00Cdxx-1c;
	Tue, 23 Jan 2024 11:40:43 +0000
Date: Tue, 23 Jan 2024 11:40:43 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Chandan Babu R <chandanbabu@kernel.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	linux-xfs@vger.kernel.org, brauner@kernel.org, jack@suse.cz
Subject: Re: [BUG REPORT] shrink_dcache_parent() loops indefinitely on a
 next-20240102 kernel
Message-ID: <20240123114043.GC2087318@ZenIV>
References: <87le96lorq.fsf@debian-BULLSEYE-live-builder-AMD64>
 <20240104043420.GT361584@frogsfrogsfrogs>
 <87sf3d8c0u.fsf@debian-BULLSEYE-live-builder-AMD64>
 <874jfbjimn.fsf@debian-BULLSEYE-live-builder-AMD64>
 <20240118063930.GP1674809@ZenIV>
 <87ede8787u.fsf@debian-BULLSEYE-live-builder-AMD64>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ede8787u.fsf@debian-BULLSEYE-live-builder-AMD64>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Jan 23, 2024 at 11:31:00AM +0530, Chandan Babu R wrote:
> 
> The result of the above suggested bisect operation is,
> 
> # git bisect log
> # bad: [0695819b3988e7e4d8099f8388244c1549d230cc] __d_unalias() doesn't use inode argument
> # good: [b85ea95d086471afb4ad062012a4d73cd328fa86] Linux 6.7-rc1
> git bisect start 'HEAD' 'v6.7-rc1' 'fs/'
> # good: [b33c14c8618edfc00bf8963e3b0c8a2b19c9eaa4] Merge branch 'no-rebase-overlayfs' into work.dcache-misc
> git bisect good b33c14c8618edfc00bf8963e3b0c8a2b19c9eaa4
> # good: [ef8a633ee84d8b57eba1f5b2908a3e0bf61837aa] Merge branch 'merged-selinux' into work.dcache-misc
> git bisect good ef8a633ee84d8b57eba1f5b2908a3e0bf61837aa
> # good: [53f99622a2b24704766469af23360836432eb88a] d_genocide(): move the extern into fs/internal.h
> git bisect good 53f99622a2b24704766469af23360836432eb88a
> # bad: [ce54c803d57ab6e872b670f0b46fc65840c8d7ca] d_alloc_parallel(): in-lookup hash insertion doesn't need an RCU variant
> git bisect bad ce54c803d57ab6e872b670f0b46fc65840c8d7ca
> # bad: [f7aff128d8c70493d614786ba7ec5f743feafe51] get rid of DCACHE_GENOCIDE
> git bisect bad f7aff128d8c70493d614786ba7ec5f743feafe51
> # first bad commit: [f7aff128d8c70493d614786ba7ec5f743feafe51] get rid of DCACHE_GENOCIDE
> 
> 
> commit f7aff128d8c70493d614786ba7ec5f743feafe51
> Author: Al Viro <viro@zeniv.linux.org.uk>
> Date:   Sun Nov 12 21:38:48 2023 -0500
> 
>     get rid of DCACHE_GENOCIDE
> 
>     ... now that we never call d_genocide() other than from kill_litter_super()

Huh?  So you are seeing that on merge of f7aff128d8c70493d614786ba7ec5f743feafe51 +
6367b491c17a34b28aece294bddfda1a36ec0377, but not on
f7aff128d8c70493d614786ba7ec5f743feafe51^ + 6367b491c17a34b28aece294bddfda1a36ec0377?

Wait a minute...  That smells like a d_walk() seeing rename_lock touched when it's
ascending from a subtree (for the reasons that have nothing to do with any changes of
the tree we are walking) and deciding to take another pass through the damn thing.
Argh...

But that should've been a problem for that commit on its own, regardless of the
merge with work.dcache2...  OTOH, it probably ended up as quiet memory leak without
that merge...

OK, could you verify that revert of that commit is enough to recover?  Short-term
that would be the obvious solution, assuming this is all that happens there.
Longer term I'd probably prefer to avoid using d_walk() there, but that's
a separate story.

