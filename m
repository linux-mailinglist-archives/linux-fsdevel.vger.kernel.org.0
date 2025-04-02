Return-Path: <linux-fsdevel+bounces-45533-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEA08A79209
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Apr 2025 17:20:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 771C17A02CE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Apr 2025 15:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E26A823A99F;
	Wed,  2 Apr 2025 15:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jVStg4s5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A2C728382;
	Wed,  2 Apr 2025 15:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743607206; cv=none; b=udqiyJNIhRwROCTQC+bCv1568j20sZCkwXusm7yH3FEHZPcmHGdSPTGwcC1t5xtG07vRBVdxi/oqdaAW08pbJ7P9FvPVIZeqj7gTBWX+MLPkKp5lKFtV1oxDDW7ohWXE2aNlMkwRAvOx8KZwxSJPWHttpJrjzR6gjSyTyhyoMuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743607206; c=relaxed/simple;
	bh=RF67FA7KLWM7yXZbl1Og9wynn8w4dU551JL/aWox2SY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y3A6WoVLMKREeovUrp0FKxd5gblIMOdhZ6T/NFxv/0LjwyivW1ILF4EBN/urwaEBRe9OIcSOXFvQZKfo19RjF543QGKwuAh8JbAiEwUedg2Zcl69INgzSLY/2TEIAG3W7AwRS603b9E4AMqWjp7+BhS6+bS7G2InaqX+X0yvRcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jVStg4s5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C255C4CEDD;
	Wed,  2 Apr 2025 15:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1743607205;
	bh=RF67FA7KLWM7yXZbl1Og9wynn8w4dU551JL/aWox2SY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jVStg4s59mQvS3H6luFFXqrZZr7oeovy6DGIH4c08aDLWBDBjpHQ7+PGhIjXHvHRd
	 yph+HtUtbfxYXsGD/Dlvrdz2wdztsy8mxSMAf+jF9rhP9j/wIBVGFgEUxgXw9p2RmB
	 9x4pUNf4iqO9+/KK70lM+AIWYgWuhweYRzrR4s00=
Date: Wed, 2 Apr 2025 16:18:37 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Wang Zhaolong <wangzhaolong1@huawei.com>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>, edumazet@google.com,
	ematsumiya@suse.de, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-net@vger.kernel.org,
	smfrench@gmail.com, zhangchangzhong@huawei.com, cve@kernel.org,
	sfrench@samba.org
Subject: Re: Fwd: [PATCH][SMB3 client] fix TCP timers deadlock after rmmod
Message-ID: <2025040248-tummy-smilingly-4240@gregkh>
References: <ac39f5a1-664a-4812-bb50-ceb9771d1d66@huawei.com>
 <20250402020807.28583-1-kuniyu@amazon.com>
 <36dc113c-383e-4b8a-88c1-6a070e712086@huawei.com>
 <2025040200-unchanged-roaming-52b3@gregkh>
 <e6537aa9-6fe7-47e4-afd3-9da549ce12a1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e6537aa9-6fe7-47e4-afd3-9da549ce12a1@huawei.com>

On Wed, Apr 02, 2025 at 05:15:44PM +0800, Wang Zhaolong wrote:
> > On Wed, Apr 02, 2025 at 12:49:50PM +0800, Wang Zhaolong wrote:
> > > Yes, it seems the previous description might not have been entirely clear.
> > > I need to clearly point out that this patch, intended as the fix for CVE-2024-54680,
> > > does not actually address any real issues. It also fails to resolve the null pointer
> > > dereference problem within lockdep. On top of that, it has caused a series of
> > > subsequent leakage issues.
> > 
> > If this cve does not actually fix anything, then we can easily reject
> > it, please just let us know if that needs to happen here.
> > 
> > thanks,
> > 
> > greg k-h
> Hi Greg,
> 
> Yes, I can confirm that the patch for CVE-2024-54680 (commit e9f2517a3e18)
> should be rejected. Our analysis shows:
> 
> 1. It fails to address the actual null pointer dereference in lockdep
> 
> 2. It introduces multiple serious issues:
>    1. A socket leak vulnerability as documented in bugzilla #219972
>    2. Network namespace refcount imbalance issues as described in
>      bugzilla #219792 (which required the follow-up mainline fix
>      4e7f1644f2ac "smb: client: Fix netns refcount imbalance
>      causing leaks and use-after-free")
> 
> The next thing we should probably do is:
>    - Reverting e9f2517a3e18
>    - Reverting the follow-up fix 4e7f1644f2ac, as it's trying to fix
>      problems introduced by the problematic CVE patch

Great, can you please send patches now for both of these so we can
backport them to the stable kernels properly?

>    - Addressing the original lockdep issue properly (Kuniyuki is working
>      on a module ownership tracking patch, though it hasn't been merged yet)
> 
> Regardless of the status of Kuniyuki's lockdep fix, the CVE patch itself
> is fundamentally flawed and should be rejected as it creates more problems
> than it solves.

Ok, I'll go reject that now, thanks.

greg k-h

