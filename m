Return-Path: <linux-fsdevel+bounces-57958-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 142D5B2701D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 22:19:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0994AAA39BF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 20:19:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19767259C9C;
	Thu, 14 Aug 2025 20:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y7hyQGZy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F6921C176;
	Thu, 14 Aug 2025 20:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755202749; cv=none; b=PwPqgoOW3+8m83v2FKSr1GNO+A6ctPAF9tcp8zk478cYGtinbT4cj72WbPQXt1jZW+V1zqMDMf76wrK1P3nnooEYwbaN2Nei55AMrl787GJ8QUlyev+WqOXHKV8HUfMZIN3mcyCJ/zLlSi4nMX1Gjr/o6QNgoDoTlkPN1eWQYus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755202749; c=relaxed/simple;
	bh=OHrO9CYBzmjrP66VACTYaSpcj8ifkdq3OgNAHusx3JQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cl/mriYBWRu1zW/Y9PWeVytJdJe66gOPTK2MjA9tBEdulRweR/f1xzklqmF6RlD/dZUcAe7cwkiqyPULokxeMkvYgFVRxyInFE+biUwk0fDEsTXHMUC7+khTDQXZle8w/VNsSDstLAXqePi1ZWQIekCWM74I676jy1KYd09PVbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y7hyQGZy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 672F9C4CEED;
	Thu, 14 Aug 2025 20:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755202748;
	bh=OHrO9CYBzmjrP66VACTYaSpcj8ifkdq3OgNAHusx3JQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y7hyQGZy4wJOUZwphyJ1zqJnMhPkpykp6rMI1llau9JN9K1hTU9fbXk1wEcwcEbkX
	 thotSCZ6wWOIJ6Q3j7XV7Ipv4F1k/8BPo50sKt3VlEn4bsSFVgAfTvuu/YqmfX906f
	 Fwejtesxl1N4j1RXmgcq+cxUTA/Okk/knKVrky/3YwePFuRnpaJGrgE+LcjYr6GvhW
	 Ep7GoSvIwOFQmRKGuuoh7Y1etIbuMCtDGntHuouK0da3/w6NUql4AYBeV96G5cppxB
	 FQUr5dVHSAsM3WkIK9MormninvpPwy/jO+OOi4HKo/Dj4AwDU3czKZglNBwMrs7R2x
	 xVbdtOshIOa2Q==
Date: Thu, 14 Aug 2025 13:19:06 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Naresh Kamboju <naresh.kamboju@linaro.org>, stable@vger.kernel.org,
	patches@lists.linux.dev, linux-kernel@vger.kernel.org,
	torvalds@linux-foundation.org, akpm@linux-foundation.org,
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
	f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
	hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
	qemu-devel@nongnu.org,
	Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Anders Roxell <anders.roxell@linaro.org>,
	Ben Copeland <benjamin.copeland@linaro.org>,
	LTP List <ltp@lists.linux.it>, chrubis <chrubis@suse.cz>,
	Petr Vorel <pvorel@suse.cz>, Ian Rogers <irogers@google.com>,
	linux-perf-users@vger.kernel.org,
	Zhang Yi <yi.zhang@huaweicloud.com>,
	Joseph Qi <jiangqi903@gmail.com>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-ext4 <linux-ext4@vger.kernel.org>
Subject: Re: [PATCH 6.16 000/627] 6.16.1-rc1 review
Message-ID: <aJ5EupUV9t0jToY3@google.com>
References: <20250812173419.303046420@linuxfoundation.org>
 <CA+G9fYtBnCSa2zkaCn-oZKYz8jz5FZj0HS7DjSfMeamq3AXqNg@mail.gmail.com>
 <2025081300-frown-sketch-f5bd@gregkh>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2025081300-frown-sketch-f5bd@gregkh>

Hello,

Thanks for the report!

On Wed, Aug 13, 2025 at 02:50:49PM +0200, Greg Kroah-Hartman wrote:
> On Wed, Aug 13, 2025 at 05:46:26PM +0530, Naresh Kamboju wrote:
> > Long story:
> > 1)
> > The perf gcc-13 build failed on x86_64 and i386.
> > 
> > Build regression: qemu-arm64 ARM64_64K_PAGES ltp syscalls swap fsync
> > fallocate failed.
> > 
> > > Ian Rogers <irogers@google.com>
> > >     perf topdown: Use attribute to see an event is a topdown metic or slots
> > 
> > Build error:
> > 
> > arch/x86/tests/topdown.c: In function 'event_cb':
> > arch/x86/tests/topdown.c:53:25: error: implicit declaration of
> > function 'pr_debug' [-Werror=implicit-function-declaration]
> >    53 |                         pr_debug("Broken topdown information
> > for '%s'\n", evsel__name(evsel));
> >       |                         ^~~~~~~~
> > cc1: all warnings being treated as errors
> 
> Already fixed.

Are you sure?  I'm not seeing the fix.  Can you share the commit id?

I don't see the failure on my machine with gcc 14 but I also cannot
find what's the fix.

Thanks,
Namhyung


