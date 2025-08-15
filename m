Return-Path: <linux-fsdevel+bounces-58039-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41AC1B283C4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Aug 2025 18:24:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E385A1D037C2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Aug 2025 16:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 180803093B3;
	Fri, 15 Aug 2025 16:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nUphFxrW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3A31607A4;
	Fri, 15 Aug 2025 16:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755275045; cv=none; b=Q0yQwC8ZBR05TtXsxm8UItkRMCq1D6wp+UNIcodEnENn9gDfLLaZltaBXop1WgjVhE3u1chSkXQG7WiTiOzqm6oIAjVjM6LAp9juYbhbHaL4550c6UR6xDxtGQmqo5Gta6r2CALkykRoYx0JI8XCwPYDR13I/z8EOLJCnLaVij8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755275045; c=relaxed/simple;
	bh=4W3MexmDLIj0LLuVBsUoXVIfys/oLMGtURiFQUEH13U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lDr6JeuicKkTay8B93GF1HoJVzfVG3Jt+ftyGNYNCHyvD5tduuAoONrIjcPreD4cD4jEf1wMTmTZbhW7MEGqDsFkv5XuoU/12LhuqBGISuKNdZZ9g+bIz8EJNtmxyr/dxC9LDUFGY46h9SihH1gocl3NxrmiLyclVh3NAxOhNfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nUphFxrW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1B60C4CEEB;
	Fri, 15 Aug 2025 16:24:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755275045;
	bh=4W3MexmDLIj0LLuVBsUoXVIfys/oLMGtURiFQUEH13U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nUphFxrWKV+6n7KpkD3VVRbo27xzyyN/vWebfUiwoAS3RvQSWcpYef5mbG32vq0xD
	 Hj0/e3bePcSFamI9nK1ma1Z1tJgmnKrGZNeX7nNEd7c2k/TECv6Usta5G6k2J1kTXq
	 LsLm0KSBqNf5NIpDJGBe/pMGF4IRBd7RfiQ0AFAHXmAiB/AdFCFFEAZWTG5KJ1UEeH
	 gx7uzJLw+iJTkPJ6nbo75iUvpli22kP4Ea4eVzyFa0QL+rwrRi3uUMsyrZOzUynbnX
	 vzx4mQ8pLbKA4C23C8MVuQVsKobT/zIxnc9HN1TNS3GmfWQ6VfTQjsBHkx+jBmRUuP
	 bmqcMI4Wr142Q==
Date: Fri, 15 Aug 2025 09:24:01 -0700
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
Message-ID: <aJ9fIUkM04HhRgSR@google.com>
References: <20250812173419.303046420@linuxfoundation.org>
 <CA+G9fYtBnCSa2zkaCn-oZKYz8jz5FZj0HS7DjSfMeamq3AXqNg@mail.gmail.com>
 <2025081300-frown-sketch-f5bd@gregkh>
 <aJ5EupUV9t0jToY3@google.com>
 <2025081536-resonate-wafer-6699@gregkh>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2025081536-resonate-wafer-6699@gregkh>

On Fri, Aug 15, 2025 at 07:33:41AM +0200, Greg Kroah-Hartman wrote:
> On Thu, Aug 14, 2025 at 01:19:06PM -0700, Namhyung Kim wrote:
> > Hello,
> > 
> > Thanks for the report!
> > 
> > On Wed, Aug 13, 2025 at 02:50:49PM +0200, Greg Kroah-Hartman wrote:
> > > On Wed, Aug 13, 2025 at 05:46:26PM +0530, Naresh Kamboju wrote:
> > > > Long story:
> > > > 1)
> > > > The perf gcc-13 build failed on x86_64 and i386.
> > > > 
> > > > Build regression: qemu-arm64 ARM64_64K_PAGES ltp syscalls swap fsync
> > > > fallocate failed.
> > > > 
> > > > > Ian Rogers <irogers@google.com>
> > > > >     perf topdown: Use attribute to see an event is a topdown metic or slots
> > > > 
> > > > Build error:
> > > > 
> > > > arch/x86/tests/topdown.c: In function 'event_cb':
> > > > arch/x86/tests/topdown.c:53:25: error: implicit declaration of
> > > > function 'pr_debug' [-Werror=implicit-function-declaration]
> > > >    53 |                         pr_debug("Broken topdown information
> > > > for '%s'\n", evsel__name(evsel));
> > > >       |                         ^~~~~~~~
> > > > cc1: all warnings being treated as errors
> > > 
> > > Already fixed.
> > 
> > Are you sure?  I'm not seeing the fix.  Can you share the commit id?
> 
> I dropped the offending perf patch:
> 	https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git/commit/?id=4199b872a5585e025f62886724f4f9ae80e014ae
> 
> Did that not work for you?

Oh sorry, I misunderstood you.  I thought you have a fix.

Thanks,
Namhyung


