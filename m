Return-Path: <linux-fsdevel+bounces-57811-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C3C4B2572D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 01:04:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07BF0726ED3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 23:04:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B86A22FC863;
	Wed, 13 Aug 2025 23:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gULORzCb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 078F12F530B;
	Wed, 13 Aug 2025 23:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755126262; cv=none; b=Lco7pbKcRNLZPqix2GqraKyUr1wt0rgeDbpT114VALRGomnfL8JVxz3rDBf4Bt/HwlCE5h8lJa31z9AoiDLVCOLI3RrkdHdEqE5K/lkVgNVclJ/XMCJ1lbRGyrAQTysiAf8y7TV8LYIBZBKhwlkVHFNaXFtilCwc4mKtXf3ky5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755126262; c=relaxed/simple;
	bh=3F+ogyrYcJ8PY1I57KN+xxu49Rm1DOvKC0zBkVlpS24=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mJPc19zqY4UrPJ3rgMzgQYwazErsyB2fJNol85h4DaWtOt1mFkOfzNbmAFYcgDZ4FjEuJn7TYl3TPIXvNoOXokU3weFT/Mv650ID1OS6kfY1JL4vAYBmxl9w8zgdv6B2yYLfHacDWG4UxHwTCMr6x0kV6JHGGsdozNdiqp6UUxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gULORzCb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F5ADC4CEF5;
	Wed, 13 Aug 2025 23:04:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755126261;
	bh=3F+ogyrYcJ8PY1I57KN+xxu49Rm1DOvKC0zBkVlpS24=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=gULORzCbX4t52dAfG5DuKvm4YIIqfvOAx2w15GEnWcGA3zPp1j7Cf5X0DN1XTUtdv
	 n74MCqWqzp5i6s8L31cAIYg53ELJQ/y78Ez/QPWAtAMqFKENy687JX6LZtwcI1YySK
	 X/4AixLfnG9jFoOCWc1ggn2g0Agkl+XXXBRlStfpOCy03YBcMGgEJ8P4X0dasp2onI
	 ySv+D7D4PiGjXg6hX02QoDFlpOVGN/82cxQhy2q1soLdwF2tgPFkX+o6RBjn5T4ADE
	 HhxlAxjwmBcpTl+gyAlfkbcB5xyfUjjHWZvzun5VoZ0syqCiu4T32eftEcAdCVhLqA
	 dt4p4tG6o1mzg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id D4BCCCE0A48; Wed, 13 Aug 2025 16:04:19 -0700 (PDT)
Date: Wed, 13 Aug 2025 16:04:19 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Dominique Martinet <asmadeus@codewreck.org>,
	Nathan Chancellor <nathan@kernel.org>,
	kernel test robot <lkp@intel.com>,
	Dominique Martinet via B4 Relay <devnull+asmadeus.codewreck.org@kernel.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Christian Brauner <brauner@kernel.org>,
	David Howells <dhowells@redhat.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Andrew Morton <akpm@linux-foundation.org>, llvm@lists.linux.dev,
	oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	Maximilian Bosch <maximilian@mbosch.me>,
	Ryan Lahfa <ryan@lahfa.xyz>, Christian Theune <ct@flyingcircus.io>,
	Arnout Engelen <arnout@bzzt.net>, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/2] iov_iter: iterate_folioq: fix handling of offset >=
 folio size
Message-ID: <f389ac0d-de77-4443-9302-3d8895e39daf@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20250811-iot_iter_folio-v1-1-d9c223adf93c@codewreck.org>
 <202508120250.Eooq2ydr-lkp@intel.com>
 <20250813051633.GA3895812@ax162>
 <aJwj4dQ3b599qKHn@codewreck.org>
 <aJyVfWKX2eSMsfrb@black.igk.intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJyVfWKX2eSMsfrb@black.igk.intel.com>

On Wed, Aug 13, 2025 at 03:39:09PM +0200, Andy Shevchenko wrote:
> On Wed, Aug 13, 2025 at 02:34:25PM +0900, Dominique Martinet wrote:
> > Nathan Chancellor wrote on Tue, Aug 12, 2025 at 10:16:33PM -0700:
> > > >    1 warning generated.
> > > 
> > > I see this in -next now, should remain be zero initialized or is there
> > > some other fix that is needed?
> > 
> > A zero-initialization is fine, I sent a v2 with zero-initialization
> > fixed yesterday:
> > https://lkml.kernel.org/r/20250812-iot_iter_folio-v2-1-f99423309478@codewreck.org
> > 
> > (and I'll send a v3 with the goto replaced with a bigger if later today
> > as per David's request)
> > 
> > I assume Andrew will pick it up eventually?
> 
> I hope this to happen sooner as it broke my builds too (I always do now `make W=1`
> and suggest all developers should follow).

This build failure is showing up in my testing as well.

In the service of preventing bisection issues, would it be possible to
fold the fix into the original patch?

							Thanx, Paul

