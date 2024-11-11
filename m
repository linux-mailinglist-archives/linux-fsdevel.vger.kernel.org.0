Return-Path: <linux-fsdevel+bounces-34330-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D2FC9C489B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 22:56:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F78BB296CA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 21:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A34E165F1D;
	Mon, 11 Nov 2024 21:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="tX65SyWB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE4B1A76C7;
	Mon, 11 Nov 2024 21:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731360497; cv=none; b=dLRh4M2xPgeCzoNEQ+BKpUvct6qs1FFUedyN/eWFf7lyPKKXCKM+lztOxdK6M73XjtNOxX69GKvf7lYPlKDHhdSz1YV4FLqQqKBXdspvxJ8qGHSIYINrtlUQVkFhTmHDRCox6v5uefD3iDZfw4bBZn4dxB15hMCRp8u0fXekkus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731360497; c=relaxed/simple;
	bh=MKck0WUr9zrFyVFMoMvEBe3dlfrJSiXJMGBFvq360Ww=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=ULO63KQh/3vuZtJMad/I93PY9EK171qYYU7yDaQCfov/IHcU0hfm6KV6MzVVF/iGO1SmPVhVexI33vOGiw+xoZxLaV/+vr3SWVyUYBZso0GcGdoVHVhBrz+ZIwcLyeE/32BrC5T3JXkPN51nbaqcLJZBL/BlSrQMj25PALEKU0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=tX65SyWB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE69AC4CECF;
	Mon, 11 Nov 2024 21:28:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1731360497;
	bh=MKck0WUr9zrFyVFMoMvEBe3dlfrJSiXJMGBFvq360Ww=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tX65SyWB6wVv47GbKniMWDNmqVNJczsuJLWohiA7q0kSPx93uoeltKz/wbbZRnemS
	 88IY7qlveQG4RCl1B986fdQWw+MWB2+CCwxbFG+eiDiMMIOLVXZ6ug0d08ozsHMUFs
	 YzIhdR9buTrSfY3DQC5OxqMBVgC33cbFCK9EOc6E=
Date: Mon, 11 Nov 2024 13:28:16 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: willy@infradead.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH RESEND V2 0/5] Fixes and cleanups to xarray
Message-Id: <20241111132816.3dcbb113241353e9a544adab@linux-foundation.org>
In-Reply-To: <20241111215359.246937-1-shikemeng@huaweicloud.com>
References: <20241111215359.246937-1-shikemeng@huaweicloud.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 12 Nov 2024 05:53:54 +0800 Kemeng Shi <shikemeng@huaweicloud.com> wrote:

> This series contains some random fixes and cleanups to xarray. Patch 1-3
> are fixes and patch 4-5 are cleanups. More details can be found in
> respective patches. 

As we're at -rc7 I'm looking to stash low-priority things away for
consideration after 6.13-r1.

But I don't know if all of these are low-priority things.  Because you
didn't tell me!

Please please always always describe the possible userspace-visible effects of
all fixes.  And all non-fixes, come to that.

So.  Please go through all of the patches in this series and redo the
changelogs, describing the impact each patch might have for our users.

If any of these patches should, in your opinion, be included in 6.12
and/or backported into -stable trees then it would be better to
separate them into a different patch series.  But a single patch series
is acceptable - I can figure this stuff out, if I'm given the necessary
information!  

Thanks.

