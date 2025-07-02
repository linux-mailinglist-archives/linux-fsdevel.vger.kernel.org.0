Return-Path: <linux-fsdevel+bounces-53599-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8816AF0E1A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 10:32:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6162D3AFA15
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 08:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26DF723A9BF;
	Wed,  2 Jul 2025 08:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QLscwfSi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87BE323A9A3
	for <linux-fsdevel@vger.kernel.org>; Wed,  2 Jul 2025 08:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751445110; cv=none; b=Wh3CDsi9fGgJkhhvTuN475hcI/eeLAKeAwzQhXqTzAjscCIOXlxMwg3Mxe7b3veTqzrK4rqz6N4+h60QXL2OFpxGWj59TXVh/iR4TJ7Qp209P6S9QjUbYvZat/1czedPfMQqeUfNHhjstSOfCfAk6YIxgf34Eon30B2sUvavogQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751445110; c=relaxed/simple;
	bh=q+uoPqTqXAi6aqnxj9a/mQdnZrMzOXh+taKZFl/lDHA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DA6P7lsnQOHNejVZZx2EBar4IJmwcpG4cpXeUwaqhIp/tkkatUTMd0q0f79LOVb/RSuvAszP7k1vgnvzQyKJiir1vb/shG7fobZijKPDvzLpnsn7S4uGLHgTvwcX7528QtxuPwHZiqf613M01WNbBycpP51iNaqc1lRDW5BsdFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QLscwfSi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5665C4CEED;
	Wed,  2 Jul 2025 08:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751445110;
	bh=q+uoPqTqXAi6aqnxj9a/mQdnZrMzOXh+taKZFl/lDHA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QLscwfSi4jH+3QW1g82KWKJsGPCMDq08nKXqvRe3rGlGBBSuMmxDtTP8d1GdxIjIX
	 0G8LyqEeNIqnL7baJcDJyloMJaLF6KYinpUI8S39PT77KjH+JBMlEhDukoL6LJU2Lp
	 b3RYMMP224Q3nt9bia44IutRWR70xehmrfIkD2+KVTaTndUvmkvJnNfsEUmOL3+PMM
	 Rbac0IL6EfnCREsHnWNo00lMe3KFEgg3x483E5u5Kp8DIq5QxR5UQxhMNljzr4tidw
	 6HfECYB5jmoCyRRBLBxziPl2IE3nkqQYqS0b+II6mAElV1LzUALJ7bv3uSxrTw/YUG
	 avxz7CazfOLwA==
Date: Wed, 2 Jul 2025 10:31:45 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, 
	"Ahmed S. Darwish" <darwi@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH][RFC] fold fs_struct->{lock,seq} into a seqlock
Message-ID: <20250702-zahnpasta-klischee-5b9b048a5b12@brauner>
References: <20250702053437.GC1880847@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250702053437.GC1880847@ZenIV>

On Wed, Jul 02, 2025 at 06:34:37AM +0100, Al Viro wrote:
> 	The combination of spinlock_t lock and seqcount_spinlock_t seq
> in struct fs_struct is an open-coded seqlock_t (see linux/seqlock_types.h).
> 	Combine and switch to equivalent seqlock_t primitives.  AFAICS,
> that does end up with the same sequence of underlying operations in all
> cases.
> 	While we are at it, get_fs_pwd() is open-coded verbatim in 
> get_path_from_fd(); rather than applying conversion to it, replace with
> the call of get_fs_pwd() there.  Not worth splitting the commit for that,
> IMO...
> 
> 	A bit of historical background - conversion of seqlock_t to
> use of seqcount_spinlock_t happened several months after the same
> had been done to struct fs_struct; switching fs_struct to seqlock_t
> could've been done immediately after that, but it looks like nobody
> had gotten around to that until now.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Fun, I wondered about this when I some seqlock stuff in pidfs a few
weeks ago,
Reviewed-by: Christian Brauner <brauner@kernel.org>

