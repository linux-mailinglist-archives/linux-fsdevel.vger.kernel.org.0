Return-Path: <linux-fsdevel+bounces-53480-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FE1EAEF7AE
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 14:03:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20768189E276
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 12:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F610273812;
	Tue,  1 Jul 2025 11:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HemWTvUu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E03B2749F0
	for <linux-fsdevel@vger.kernel.org>; Tue,  1 Jul 2025 11:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751370961; cv=none; b=hm71sParnHOq+yhsC+vORMZ/i4IWtAc7KkqnTOX23oJa0acCbUaV8AR0OnB9t4vMybNIiBx6XbNFya1XQzR0BnyVlkLCwGSOgPUql1p1NR3AQoyNJRgbvkC5LryVWw5kMC+jyUw9+OZGhnjzvvfnGi7GKPSmzr+OqcDD2LXTUyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751370961; c=relaxed/simple;
	bh=hqYmV04BuIvsP+4yiPlISnoIa5ByMtUNduveXJSHHXs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nqezZWRRt6z9zT5KE8Ji6GPcoc0nHI1VkRIfKh2Xi5evIItCBE6gzcvCKJq1EFb8FGcR09/r4QULl5ZzLsw09zTgywe9UVJOMKxJQ46eGgkyx4IJmNe2PvFrYug5fq3G8wVEWdCRnidCnyw26ydU7l1N2HXww7kB0K/I4YdUQz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HemWTvUu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 167D7C4CEF1;
	Tue,  1 Jul 2025 11:55:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751370961;
	bh=hqYmV04BuIvsP+4yiPlISnoIa5ByMtUNduveXJSHHXs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HemWTvUu4diQrFc7t2gjV8J7bGUCJ9YWYUpriA1UpB6gwRW9aVZHthI06X3asRuyI
	 3WgUoEostmQDGf6qqggjvkRq6WmP9VjJsENGJ5ZuXYg8BIUbvNKGFUil2/34x392tL
	 7Y3EpzonHwL22ZJHdgSy54EBy2m5JGRjAkafTIBv+rL1A2tnLBuDgTuszXLFOty1qp
	 I6Pl0cnytHC9rVg+I/kdjEiFSr61cRJkcxD8DJ7WaMPVRLCgmrLIVPhFHgMw+ppS72
	 n9rt5Ykt1O/DjT74Gh5qey5RfnWqVpfPW2WsB92H+D+h4O5jx1J0Evg42jQ90zodNH
	 yZ/Assc4N3XcQ==
Date: Tue, 1 Jul 2025 13:55:57 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	NeilBrown <neil@brown.name>, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC][PATCH] fix proc_sys_compare() handling of in-lookup
 dentries
Message-ID: <20250701-bohnenkraut-hautpflege-f10802996013@brauner>
References: <20250630072059.GY1880847@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250630072059.GY1880847@ZenIV>

On Mon, Jun 30, 2025 at 08:20:59AM +0100, Al Viro wrote:
> [In #fixes, I'll send a pull request in a few days unless anybody objects]
> 
> There's one case where ->d_compare() can be called for an in-lookup
> dentry; usually that's nothing special from ->d_compare() point of
> view, but proc_sys_compare() is... unique.
> 
> The thing is, /proc/sys subdirectories can look differently for
> different processes.  Up to and including having the same name
> resolve to different dentries - all of them hashed.
> 
> The way it's done is ->d_compare() refusing to admit a match unless
> this dentry is supposed to be visible to this caller.  The information
> needed to discriminate between them is stored in inode; it is set
> during proc_sys_lookup() and until it's done d_splice_alias() we really
> can't tell who should that dentry be visible for.
> 
> Normally there's no negative dentries in /proc/sys; we can run into
> a dying dentry in RCU dcache lookup, but those can be safely rejected.
> 
> However, ->d_compare() is also called for in-lookup dentries, before
> they get positive - or hashed, for that matter.  In case of match
> we will wait until dentry leaves in-lookup state and repeat ->d_compare()
> afterwards.  In other words, the right behaviour is to treat the
> name match as sufficient for in-lookup dentries; if dentry is not
> for us, we'll see that when we recheck once proc_sys_lookup() is
> done with it.
> 
> Fixes: d9171b934526 ("parallel lookups machinery, part 4 (and last)")
> Reported-by: NeilBrown <neilb@brown.name>
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

