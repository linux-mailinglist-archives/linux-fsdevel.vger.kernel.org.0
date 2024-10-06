Return-Path: <linux-fsdevel+bounces-31117-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B7BB991D90
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Oct 2024 11:55:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 592C61C2133F
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Oct 2024 09:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55DBD171E55;
	Sun,  6 Oct 2024 09:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m2oflHrO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1702163A9B
	for <linux-fsdevel@vger.kernel.org>; Sun,  6 Oct 2024 09:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728208533; cv=none; b=nKEjlC1+7a+uM6gdxikSQB/CjADuJd+bQBOINf03U3AdiUIVv/zSj+FlUV2M/AtWatgj4D83FSGtxFH+p7SVXk/FzmWmswbfN4iwE2WbZ6hPQ6p0nBtRSdCsZrI8z1GdpxZu+fqxpu7vtuCGBuyvDPOBu9F0+sLc/8IOc0Yg2s0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728208533; c=relaxed/simple;
	bh=EGGM1L5YByJdFQ4hLEGAN2lnEP8F3d43EaDsXTXajOA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c8IRb+3sx/f80xCu16ZlQWNhBnXqD1nUIJsvVy/bsZQCFC1Q1DWkJk3/SX78lGdMU5KTetUEWo52doxI/9UOuUOfoeucsrygwPa0QFzYWfV6TF/9IwLOaBLPUIM9ypYrIn/A7XSRSV4n2eRjMHKDpX5lMMO+sPiPMkqrWUIK2pI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m2oflHrO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4AAAC4CEC5;
	Sun,  6 Oct 2024 09:55:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728208533;
	bh=EGGM1L5YByJdFQ4hLEGAN2lnEP8F3d43EaDsXTXajOA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m2oflHrOV/cE5Yr9vl28rChEpvJNth2pEu84MLAx20+YZoXI+xLSgNZYinzBR6h7r
	 PvekdcetgTq3n5Q98OwQHABYtgmSyiUb9yxcOtZqlsrbHTepo0DA9VMAPVxWWgdq0q
	 ww27TwFJrSs5zcpCUY7RNQxVXqpCAdpu6q2yomDc1rDt+X+epwFB9W3kODrA9RTvgf
	 3xLlH7NVPIO4sKJnqiZdwIHQU8p+CXzF7saoq+EUWAq8rocMfAKV29blCG6qEFFchV
	 m0KSISocVeRXmHptSbEC6w+v3NxHI3Kq7yCFVF1U+/Ms7f8oCYYX7iTw3w3P0CZ61v
	 RQqrsQNAXM9TQ==
Date: Sun, 6 Oct 2024 11:55:29 +0200
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, 
	Thomas Gleixner <tglx@linutronix.de>, Jann Horn <jannh@google.com>
Subject: Re: [PATCH RFC 0/4] fs: port files to rcuref_long_t
Message-ID: <20241006-pfund-einreden-036466d1c003@brauner>
References: <20241005-brauner-file-rcuref-v1-0-725d5e713c86@kernel.org>
 <CAHk-=wj7=Ynmk9+Fm860NqHu5q119AiN4YNXNJPt=6Q=Y=w3HA@mail.gmail.com>
 <20241005220100.GA4017910@ZenIV>
 <CAHk-=whAwEqFKXjvYpnsq42JbE1GFoDR5LnmjjK_cOF4+nAhtg@mail.gmail.com>
 <20241005222836.GB4017910@ZenIV>
 <CAHk-=wgKmjuc8T_9mc7hWpBp1m_E+wkri-jFAD67AqkHZQjWPQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wgKmjuc8T_9mc7hWpBp1m_E+wkri-jFAD67AqkHZQjWPQ@mail.gmail.com>

On Sat, Oct 05, 2024 at 03:43:16PM GMT, Linus Torvalds wrote:
> On Sat, 5 Oct 2024 at 15:28, Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > You can keep sending SCM_RIGHTS packets filled with references
> > to the same file, for example...
> 
> Yeah, it's always SCM_RIGHTS or splice() that ends up having those
> issues.  But it's a really easy place to go "Oh, no, you can't do
> that".
> 
> > Anyway, which error would you return?  EBADF?
> 
> I really don't think it matters.
> 
> Come on - the only possible reason for two billion files is a bad
> user. Do we care what error return an attacker gets? No. We're not
> talking about breaking existing programs.
> 
> So EBADF sounds fine to me particularly from fget() and friends, since
> they have that whole case of "no such file" anyway.
> 
> For try_get_page(), we also still have the WARN_ON_ONCE() if it ever
> triggers. I don't recall having ever heard a report of it actually
> triggering, but I do think we would do the same thing for the file ref
> counting.

I really don't see the issue in making fget() _theoretically_ fail. And
I agree it would be a bug. We already have that WARN_ON() in get_file()
just to protect against completely theoretical overflow issues. If that
ever triggers anywhere we should worry about it.

> 
> Anyway, maybe making f_count a 32-bit thing isn't worth it, simply
> because 'struct file' is so much bigger (and less critical) than
> 'struct page' is anyway.
> 
> So I don't think that's actually the important thing here. If we keep
> it a 'long', I won't lose any sleep over it.

struct file is significantly smaller since the work I did the last two
cycles. So I don't think there's any pressure to go from long to int.

