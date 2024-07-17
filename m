Return-Path: <linux-fsdevel+bounces-23887-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E88639344C0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jul 2024 00:24:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E49F1C21979
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jul 2024 22:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97C664F218;
	Wed, 17 Jul 2024 22:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EqSZ/kTb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC9D3BBEB;
	Wed, 17 Jul 2024 22:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721255038; cv=none; b=PHuuQiOpu/J10hZ89iysQfPqJ72LfKdKXWtzlU5PXGC1BIqdf6LMcN7UeyeZzpj6kiubifSEaiQed9Uxrk4mxgs/bg33IIk4jPAgbIuaMDJLbHjKC8vAQ2fOtcxKdUHTbaQB3ST7UdsNYRbrEs/qYchHvtSJQ9QuCwwGALEPhLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721255038; c=relaxed/simple;
	bh=lVte0NjxgcA/RIrwcGCMqJelccj6in8YLPIu7QjUJ94=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VMM1LtvO0+FiC0bXJX12q4eZJZ+GbXZEtjiLLwzWPxXPp0jGvm/MUOrEsSQU0ESY2M3SY3CrgNJnWvshv9okJGNLsofDa0NhQixQoiwb8BIXQNgfTMzFJ8bD15mrX8XNE1ixAvGy5PbjrVniSOhGrDZZOV36fanOX63K19+f/Ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EqSZ/kTb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F365C2BD10;
	Wed, 17 Jul 2024 22:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721255037;
	bh=lVte0NjxgcA/RIrwcGCMqJelccj6in8YLPIu7QjUJ94=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EqSZ/kTb0yENo4g8xgwq6oW20Jm2cUhCWp+6LGPXJY+yfVs6bsyXSYESYHSIF3KFF
	 BMnyBbQatBUrThevej6hETgTAEdE3Cy41tXhOwdXCuj08M386PQcnS8nGeL6R4cdu2
	 QLHT9j5Fika+1kVGR8YJsvW5WjTNw8kh+BhEHeN4M6bbjTX/eF4c9duUAvpDNknV9m
	 1B5/rc+7e+FMemHgb1t5SSn/AQApGZVj4t7ZF6YL/HyFfOGX/BEYcBEwlO3+Oa4dT7
	 lQqeJczc59Uuj1ERRP6//1TEDBvhHPhoaqgG2EXbM3BPaX1fJDQxNLyFwSjhKw0Vjj
	 kWDZeoAh+PAUg==
Date: Wed, 17 Jul 2024 15:23:56 -0700
From: Kees Cook <kees@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Adrian Ratiu <adrian.ratiu@collabora.com>,
	linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org, kernel@collabora.com,
	gbiv@google.com, inglorion@google.com, ajordanr@google.com,
	Doug Anderson <dianders@chromium.org>, Jeff Xu <jeffxu@google.com>,
	Jann Horn <jannh@google.com>,
	Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH] proc: add config to block FOLL_FORCE in mem writes
Message-ID: <202407171520.FD49AE35@keescook>
References: <20240717111358.415712-1-adrian.ratiu@collabora.com>
 <202407171017.A0930117@keescook>
 <CAHk-=wi3m98GCv-kXJqRvsjOa+DCFqQux7pcmJW9WR8_n=QPqg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wi3m98GCv-kXJqRvsjOa+DCFqQux7pcmJW9WR8_n=QPqg@mail.gmail.com>

On Wed, Jul 17, 2024 at 11:16:56AM -0700, Linus Torvalds wrote:
> On Wed, 17 Jul 2024 at 10:23, Kees Cook <kees@kernel.org> wrote:
> >
> > For this to be available for general distros, I still want to have a
> > bootparam to control this, otherwise this mitigation will never see much
> > testing as most kernel deployments don't build their own kernels. A
> > simple __ro_after_init variable can be used.
> 
> Oh, btw, I looked at the FOLL_FORCE back in 2017 when we did this:
> 
>     8ee74a91ac30 ("proc: try to remove use of FOLL_FORCE entirely")
> 
> and then we had to undo that with
> 
>     f511c0b17b08 (""Yes, people use FOLL_FORCE ;)"")
> 
> but at the time I also had an experimental patch that worked for me,
> but I seem to have only sent that out in private to the people
> involved with the original issue.
> 
> And then that whole discussion petered out, and nothing happened.
> 
> But maybe we can try again.
> 
> In particular, while people piped up about other uses (see the quotes
> in that commit f511c0b17b08) they were fairly rare and specialized.
> 
> The one *common* use was gdb.
> 
> But my old diff from years ago mostly still applies, so I resurrected it.
> 
> It basically restricts FOLL_FORCE to just ptracers.
> 
> That's *not* good for some of the people that piped up back when (eg
> Julia JIT), but it might be a more palatable halfway state.
> 
> In particular, this patch would make it easy to make that
> SECURITY_PROC_MEM_RESTRICT_FOLL_FORCE config option be a "choice"
> where you pick "never, ptrace, always" by just changing the rules in
> proc_is_ptracing().

So the original patch could be reduced to just the single tristate option
instead of 3 tristates? I think that would be a decent middle ground,
and IIUC, will still provide the coverage Chrome OS is looking for[1].

-Kees

[1] https://lore.kernel.org/lkml/CABi2SkWDwAU2ARyMVTeCqFeOXyQZn3hbkdWv-1OzzgG=MNoU8Q@mail.gmail.com/

-- 
Kees Cook

