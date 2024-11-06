Return-Path: <linux-fsdevel+bounces-33719-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E58229BDEA6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Nov 2024 07:16:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20C0B1C22DAE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Nov 2024 06:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76AA31922E5;
	Wed,  6 Nov 2024 06:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1fTkmcG0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B1C36C;
	Wed,  6 Nov 2024 06:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730873778; cv=none; b=I4//3pmFUSngBkaX7lfDLWQQZc6cK5eD1XRiQm8abpHBPwH3Zu2h8XBgtAOfRw60M/tucj3F25v/A2Bgml+APM8got4yRy19VVY1UJKupBFOhKZbooBDXsmOaFkp6LK6/DYApwK9FEXGHNbIoTbIQVnj8gUB91cuyobdgnX5NOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730873778; c=relaxed/simple;
	bh=pQlq7hHPU1Y1m8Iq0RTWGhBrUrFVOfLg2Zpy9RE9zsU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JNf05SuadmXuW1R1VqvpCRvZgDuHpQ7p3zrsOHjjmm7fYK41ZFKYWzNF/e0aJUmdKZk4GXhWIhRUxbobMdF9UJFPrdn16kDOHi1E6dPZa0vIlADCwApZEdFtclAj2iPi4LvZKux8SX8zYyUnQ3jDjKKuYAfm4X4H5etSOsDqnXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1fTkmcG0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C2CAC4CECD;
	Wed,  6 Nov 2024 06:16:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730873778;
	bh=pQlq7hHPU1Y1m8Iq0RTWGhBrUrFVOfLg2Zpy9RE9zsU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=1fTkmcG0N/uvrisql3iDehlDzBNxDNe9oSfkHDOaITMwxsTkdkYbtTOC9lGFg1dwl
	 eMRGjVGRQcsNNJJ3jMsXvMea55ta6/60nim8jexRPhGVrhD/NnBNGv5hgahleeqztB
	 pR75KwmvLCaR4VCYlltAkgEgUf3CMOSWOzvwUlZQ=
Date: Wed, 6 Nov 2024 07:16:00 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: stable@vger.kernel.org, harry.wentland@amd.com, sunpeng.li@amd.com,
	Rodrigo.Siqueira@amd.com, alexander.deucher@amd.com,
	christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com,
	daniel@ffwll.ch, viro@zeniv.linux.org.uk, brauner@kernel.org,
	Liam.Howlett@oracle.com, akpm@linux-foundation.org,
	hughd@google.com, willy@infradead.org, sashal@kernel.org,
	srinivasan.shanmugam@amd.com, chiahsuan.chung@amd.com,
	mingo@kernel.org, mgorman@techsingularity.net, yukuai3@huawei.com,
	chengming.zhou@linux.dev, zhangpeng.00@bytedance.com,
	chuck.lever@oracle.com, amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, maple-tree@lists.infradead.org,
	linux-mm@kvack.org, yi.zhang@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH 6.6 00/28] fix CVE-2024-46701
Message-ID: <2024110625-earwig-deport-d050@gregkh>
References: <20241024132009.2267260-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241024132009.2267260-1-yukuai1@huaweicloud.com>

On Thu, Oct 24, 2024 at 09:19:41PM +0800, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> Fix patch is patch 27, relied patches are from:
> 
>  - patches from set [1] to add helpers to maple_tree, the last patch to
> improve fork() performance is not backported;

So things slowed down?

>  - patches from set [2] to change maple_tree, and follow up fixes;
>  - patches from set [3] to convert offset_ctx from xarray to maple_tree;
> 
> Please notice that I'm not an expert in this area, and I'm afraid to
> make manual changes. That's why patch 16 revert the commit that is
> different from mainline and will cause conflict backporting new patches.
> patch 28 pick the original mainline patch again.
> 
> (And this is what we did to fix the CVE in downstream kernels).
> 
> [1] https://lore.kernel.org/all/20231027033845.90608-1-zhangpeng.00@bytedance.com/
> [2] https://lore.kernel.org/all/20231101171629.3612299-2-Liam.Howlett@oracle.com/T/
> [3] https://lore.kernel.org/all/170820083431.6328.16233178852085891453.stgit@91.116.238.104.host.secureserver.net/

This series looks rough.  I want to have the maintainers of these
files/subsystems to ack this before being able to take them.

thanks,

greg k-h

