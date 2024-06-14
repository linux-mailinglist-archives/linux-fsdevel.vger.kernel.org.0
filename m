Return-Path: <linux-fsdevel+bounces-21724-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48869909387
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Jun 2024 22:44:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E60DE1F24B2E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Jun 2024 20:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 598AB1A3BAA;
	Fri, 14 Jun 2024 20:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZBYgmEAD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B3F1487E4;
	Fri, 14 Jun 2024 20:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718397871; cv=none; b=OVBuZUidbQUYp/hfgPLT6rGUUmF+e+aSio4n8w6tSZHyOAU36FN8zbiBDAYiwQIX3M7L3+cYPN4E8ReT8VpgpxaKFGlbm8/mKYHkN1FtWO7DiVEGOqdPuPYgtvc0QWJz9CwCQ/ZV6fUBFFfLoYxcide8WzRInEg4Gj8ZWKJf76s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718397871; c=relaxed/simple;
	bh=7acY5nxtKrOBNP7jsAXMOQKC+Ju/JIz0d5ih0EDSMSQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SU6+1kxa+a0cHyzl6eLAJAQkv8GnmAT1ZN3NtRlxX4DsuQZv7MkFpOioufbUuA6pGFEL7l/JA42KmxZyCRSMka9UUnOs/ReC6gmq6E6MhxAfu/BDVe0Nb8ElFttL5zmVD6e0jRVwCd1GpLJT5WisIKsNG7E4Wk2tvxIH8HWKPnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZBYgmEAD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33CE2C2BD10;
	Fri, 14 Jun 2024 20:44:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718397871;
	bh=7acY5nxtKrOBNP7jsAXMOQKC+Ju/JIz0d5ih0EDSMSQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZBYgmEADBKWuuxp/V6ynOq0rRiB4A39K2G+dUt4g17Fzaq6oDjTdw+BebM3zHGyfi
	 +IYM279H2pBEleOmTvAhEXr3CRZMW/AgQ7wrh3b8pJBW9KYjfrYnjfg0Vz9LElORyJ
	 ki7QLcWln0CY9KE07Wgp5xgRSMnRQoXr+5rZdQF6jTgXURR7Ny/3xidw3yYhOiwxm0
	 13A3ZoDajafaDcCnlAQVTzCa4DUakLkR0f0WmC/0XKKeK0+Q2B3y5N5MPL+vi4fR9A
	 NPptkSCB8i1RASjkUFIQAjr3q/UQhXkwfLWxrl6Vrp1tC+L0IPxmWw/EeDHQtRYHV2
	 8gkm0Qmt8ZKlg==
Date: Fri, 14 Jun 2024 13:44:30 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Theodore Ts'o <tytso@mit.edu>
Cc: Linux Filesystem Development List <linux-fsdevel@vger.kernel.org>,
	fstests@vger.kernel.org
Subject: Re: Flaky test: generic:269 (EBUSY on umount)
Message-ID: <20240614204430.GD6147@frogsfrogsfrogs>
References: <20240612162948.GA2093190@mit.edu>
 <20240612194136.GA2764780@frogsfrogsfrogs>
 <20240613215639.GE1906022@mit.edu>
 <20240614041618.GA6147@frogsfrogsfrogs>
 <20240614182759.GF1906022@mit.edu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240614182759.GF1906022@mit.edu>

On Fri, Jun 14, 2024 at 07:27:59PM +0100, Theodore Ts'o wrote:
> On Thu, Jun 13, 2024 at 09:16:18PM -0700, Darrick J. Wong wrote:
> > 
> > Amusingly enough, I still have that patch (and generic/1220) in my
> > fstests branch, and I haven't seen this problem happen on g/1220 in
> > quite a while.
> 
> Remind me what your fstests git repo is again?

https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfstests-dev.git/log/?h=djwong-wtf

> The generic/750 test in my patch 2/2 that I sent out reproduces the
> problem super-reliably, so long as fsstress actually issues the
> io_uring reads and writes.  So if you have your patch applied which
> suppresses io_uring from fstress by default, you might need to modify
> the patch series to force the io_uring, at which point it quite nicely
> demonstrates the fsstress ; umount problem.  (It sometimes requires
> more rounds of fsstress ; umounts before it repro's on the xfs/4k, but
> it repro's really nicely on ext4/4k).

Hm, your g/750 test mounts and unmounts in a loop, which might be why
mine hasn't tripped yet.  I'll try applying it and report back.

--D
> 
> xfs/4k:
>   generic/750  Failed   3s
>   generic/750  Failed   1s
>   generic/750  Failed   33s
>   generic/750  Failed   1s
>   generic/750  Pass     33s
> ext4/4k:
>   generic/750  Failed   3s
>   generic/750  Failed   2s
>   generic/750  Failed   7s
>   generic/750  Failed   2s
>   generic/750  Failed   7s
> 
> 							- Ted
> 							

