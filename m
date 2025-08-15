Return-Path: <linux-fsdevel+bounces-57981-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92EBDB2788F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Aug 2025 07:36:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FEF8AC1EFC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Aug 2025 05:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71B8229D288;
	Fri, 15 Aug 2025 05:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1acX8gnF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B17242D66;
	Fri, 15 Aug 2025 05:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755236026; cv=none; b=aDIFft0T6Cg3fXvbuev38nqdRipyie8CdYp3lnYKJlkhOISOl1WgIK0lpHPNGIut+8/Jp299GWGsYZ2MTc9bcXL0Z63Y6RBFcuR0KdytQdTEfIKw1+xdhjm1eUGXKm1eUyPCFL1FvxCMgbff/Jjw7nY6ltGoCFb0NMYvZX7eVUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755236026; c=relaxed/simple;
	bh=5pmEnpk4P+ndbonyan2VBiYanHohRCT0mNUzn8ef6Jw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uCn6sfAbMdp/+dXyCLQicymWGZ1eXdu4ngGWFuh3qavEdnPGwE6iMHVq/Kr2jvYLHcf67W15z35bgX+ZkIV5+fX4RNUQ34+q60KKJKmLn0RQvbvGFkOrsQzC7t2155+eLosrA+G/e4c5jXj6P8wj2h3THga7SsSU0hIo3S7DZ2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1acX8gnF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 923C0C4CEF4;
	Fri, 15 Aug 2025 05:33:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755236026;
	bh=5pmEnpk4P+ndbonyan2VBiYanHohRCT0mNUzn8ef6Jw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=1acX8gnFQCkziGbYVwXTdj9BgkJt06DgtflG9KQNRnqNIt+UE43nvvq7RtqS8j+TO
	 DIT37U+VhXVk1Tmo2KjQJ/IaQC3QxZHPJnNumrOKk9NIFQf1jf3eWt9D8ct/fb16Pq
	 xhXRyIEUjs6wiBS4B4K5vjigRUpIaLwvw1zT2g0k=
Date: Fri, 15 Aug 2025 07:33:41 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Naresh Kamboju <naresh.kamboju@linaro.org>, stable@vger.kernel.org,
	patches@lists.linux.dev, linux-kernel@vger.kernel.org,
	torvalds@linux-foundation.org, akpm@linux-foundation.org,
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
	f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
	hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
	qemu-devel@nongnu.org,
	Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
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
Message-ID: <2025081536-resonate-wafer-6699@gregkh>
References: <20250812173419.303046420@linuxfoundation.org>
 <CA+G9fYtBnCSa2zkaCn-oZKYz8jz5FZj0HS7DjSfMeamq3AXqNg@mail.gmail.com>
 <2025081300-frown-sketch-f5bd@gregkh>
 <aJ5EupUV9t0jToY3@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJ5EupUV9t0jToY3@google.com>

On Thu, Aug 14, 2025 at 01:19:06PM -0700, Namhyung Kim wrote:
> Hello,
> 
> Thanks for the report!
> 
> On Wed, Aug 13, 2025 at 02:50:49PM +0200, Greg Kroah-Hartman wrote:
> > On Wed, Aug 13, 2025 at 05:46:26PM +0530, Naresh Kamboju wrote:
> > > Long story:
> > > 1)
> > > The perf gcc-13 build failed on x86_64 and i386.
> > > 
> > > Build regression: qemu-arm64 ARM64_64K_PAGES ltp syscalls swap fsync
> > > fallocate failed.
> > > 
> > > > Ian Rogers <irogers@google.com>
> > > >     perf topdown: Use attribute to see an event is a topdown metic or slots
> > > 
> > > Build error:
> > > 
> > > arch/x86/tests/topdown.c: In function 'event_cb':
> > > arch/x86/tests/topdown.c:53:25: error: implicit declaration of
> > > function 'pr_debug' [-Werror=implicit-function-declaration]
> > >    53 |                         pr_debug("Broken topdown information
> > > for '%s'\n", evsel__name(evsel));
> > >       |                         ^~~~~~~~
> > > cc1: all warnings being treated as errors
> > 
> > Already fixed.
> 
> Are you sure?  I'm not seeing the fix.  Can you share the commit id?

I dropped the offending perf patch:
	https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git/commit/?id=4199b872a5585e025f62886724f4f9ae80e014ae

Did that not work for you?

thanks,

greg k-h

