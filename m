Return-Path: <linux-fsdevel+bounces-47401-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CCDC8A9CF60
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Apr 2025 19:18:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2904A4E2836
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Apr 2025 17:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 916D71F4717;
	Fri, 25 Apr 2025 17:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yl16MbLP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE3CC19ADA2;
	Fri, 25 Apr 2025 17:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745601471; cv=none; b=IPycG8c4QzRpjU015MwcrP80E3txxlnKTFo2hYwbSqxdKzPNb+zM4yAtxlsoivasSyEUumisKxQ2Q/MEanwCHt2CQNnUZl4OqHuuifTKc27l7gBYaSPTvvpY4mtpIBczu/r9gbq72czXooknU4u+rujT3MM90hkDQyvdyRYmo2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745601471; c=relaxed/simple;
	bh=EdI29Ss64zXdYsQf20jTXjZQcMvHSbEmwXB5dgL/mqM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fz4GADOv1G/P/KEgEAMZKIoNhGwFGsV7AuxFjZkXxKw4xHiIdYhXvtybQhd8uxWshhK+JyDpKC17LIQ/tD23Wc6X1NOUGd2TB6m1uey1lf8CzPX4zYyEUm5HM0qzy7p7B7hdbbUEVsqWHt3vBozqhBmu+/XCIAOSJFiDzAEaaUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yl16MbLP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7A61C4CEE4;
	Fri, 25 Apr 2025 17:17:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745601470;
	bh=EdI29Ss64zXdYsQf20jTXjZQcMvHSbEmwXB5dgL/mqM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Yl16MbLPtG7xiMmMahB+CsG4U3HIzCWo0Pv1Qg/9ZhMq/1qTrS4Mo294Ea6PSS2nW
	 gjyqmBvkw16oi99a+5z8SNG0WtN7O7wuWmCOHInVLbWh48Z/HA7nzX5moG8Z1QYjbn
	 vzPuDiAsk5fHyVKtDsL6drDq+jRmHK0uHKk3hExqSyWPpuW0+zYweWlIeePrMOExij
	 rC4lkJzs9t2kXTbAVEYNHdA+RaKV8WuRzE+CJFE6bEfMt3Dm5Fd38/pIA68OX0/Q12
	 hU9XHMXz16RK80YApnO1CaXjmjWq1UySESLeFEaRRVPT0MMeBizRBrv/Z1lbhSRK/6
	 eOYXkZeD+6Thw==
Date: Fri, 25 Apr 2025 13:17:45 -0400
From: Nathan Chancellor <nathan@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Christian Brauner <brauner@kernel.org>,
	Heiko Carstens <hca@linux.ibm.com>, gregkh@linuxfoundation.org,
	rafael@kernel.org, dakr@kernel.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Xiao Ni <xni@redhat.com>
Subject: Re: [PATCH] devtmpfs: don't use vfs_getattr_nosec to query i_mode
Message-ID: <20250425171745.GA3071749@ax162>
References: <20250423045941.1667425-1-hch@lst.de>
 <20250425100304.7180Ea5-hca@linux.ibm.com>
 <20250425-stehlen-koexistieren-c0f650dcccec@brauner>
 <20250425133259.GA6626@lst.de>
 <D865215C-0373-464C-BB7D-235ECAF16E49@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D865215C-0373-464C-BB7D-235ECAF16E49@kernel.org>

On Fri, Apr 25, 2025 at 08:40:23AM -0700, Kees Cook wrote:
> 
> 
> On April 25, 2025 6:32:59 AM PDT, Christoph Hellwig <hch@lst.de> wrote:
> >On Fri, Apr 25, 2025 at 12:12:36PM +0200, Christian Brauner wrote:
> >> > That is: if dev_mynode(dev, inode) is not true some random value will be returned.
> >> 
> >> Don't bother resending, Christoph.
> >> I've already fixed this with int err = 0 in the tree.
> >
> >Thanks!  Let me use this as a platform to rant about our option
> >defaults and/or gcc error handling.  It seems like ever since we started
> >zeroing on-stack variables by default gcc stopped warnings about using
> >uninitialized on-stack variables, leading to tons of these case where
> >we don't catch uninitialized variables.  Now in this and in many cases
> >the code works fine because it assumed zero initialization, but there are
> >also cases where it didn't, leading to new bugs.

I don't think developers can assume that zero initialization is
universally available because 1. there are supported compiler versions
that might not support it and 2. someone may have turned it off or
switched to pattern initialization. Isn't default initialization of
variables supposed to be viewed more as a mitigation against missed
initializations than something to be relied on implicitly? We still want
to know unambiguously and explicitly what the default value of variables
should be.

> This isn't the case: the feature was explicitly designed in both GCC
> and Clang to not disrupt -Wuninitialized. But -Wuninitialized has been
> so flakey for so long that it is almost useless (there was even
> -Wmaybe-uninitialized added to try to cover some of the missed

Right, the fact that GCC does not warn on uninitialized variables is
somewhat self inflicted for the kernel because of 6e8d666e9253 ("Disable
"maybe-uninitialized" warning globally"); I say somewhat because I
understand that the warning was disabled for false positives but it does
mean that there are no true positives either.

> diagnostics). And it's one of the many reasons stack variable zeroing
> is so important, since so much goes undiagnosed. :(
> 
> Fixing -Wuninitialized would be lovely, but it seems no one has been
> able to for years now.

I think clang at one point had a similar problem to GCC's
-Wmaybe-uninitialized (it is -Wconditional-uninitialized there) and that
is how -Wsometimes-uninitialized came into existence. Perhaps GCC could
explore something similar to help gain back some coverage?

There is another big difference between clang and GCC's -Wuninitialized
is that clang's -Wuninitialized will trigger whenever a variable is
guaranteed to be used initialized at its first use, regardless of what
control flow may happen between the declaration and that point, whereas
GCC may turn it into a -Wmaybe-uninitialized.

https://godbolt.org/z/MYxeozc36

Cheers,
Nathan

