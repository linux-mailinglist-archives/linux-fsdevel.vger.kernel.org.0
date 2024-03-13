Return-Path: <linux-fsdevel+bounces-14263-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74CA187A31A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Mar 2024 07:57:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A67DF1C20DBC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Mar 2024 06:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86A8814ABA;
	Wed, 13 Mar 2024 06:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p+S0YrI1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF9F12B6F;
	Wed, 13 Mar 2024 06:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710313013; cv=none; b=tCmshVfeBNqETu1moDVMexABqjv7kjinxl7iB23ZeyDqCrHw7KJq2l5zQSqfFieuq3zWkxLsZ3mfI/4LAKWDQj2QaFgnVWge8RvfEaaKbp31bfcsvAJGOZ3A+G0QEgUp92ScwwIoSvSAi28NomBJdJ1ReUF7cpedhEcR/jyJkQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710313013; c=relaxed/simple;
	bh=hiVJVy2J1WYdmMP8tCylIk90eePUiGn1ZL9eybLPr0k=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=G8+Ju153959QcCvYU8emCZ7a1vvCHRNGmj7BgZ7qrJ/dGblneXIblbqNmWpZu7G1pk2skZD5qMi7OA7+rDZB9hprovMYwHPPm+iKhlwNzWo2PyGBrRonjQUq8fDnZS3oZ4aBm4DPPT1yZ6Xepq4FDY6gK1zqPHSDrgv3Q/gdp/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p+S0YrI1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE960C433C7;
	Wed, 13 Mar 2024 06:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710313012;
	bh=hiVJVy2J1WYdmMP8tCylIk90eePUiGn1ZL9eybLPr0k=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:From;
	b=p+S0YrI1ML2VvuU9VXsbW4EZkWluRXu09Hggp7c4YMUVYJm/d7N8iTVlWR1PkIUX2
	 +Z3yV4QlxmvoEfO/cTDDNvck49zRAE3VFb+aGdCd+m+gZyOnJT7enDpJ83x/ojvoIG
	 dbRpHZBPLNeH1b7AWbPw2UvbHjc0ss/wJHyarF/k4u0wThWHH9BUPThFNfu6u7D/uS
	 T9H3EGKpgTrcR8MKF6fT49v7mOsTCSWuJJMVeerF3bU4IErwYeY61pzgXSdpQa030Q
	 p7DPMNNw4CDAsbeSet/lLowUdhTwbaEEKExTXfWHucOhcCaVa4jiBEsHbj/hHeaSkX
	 8YLVjQd1uoOvQ==
References: <87r0gmz82t.fsf@debian-BULLSEYE-live-builder-AMD64>
 <ZepcRgdO39xIrXG2@dread.disaster.area>
User-agent: mu4e 1.10.8; emacs 27.1
From: Chandan Babu R <chandanbabu@kernel.org>
To: Dave Chinner <david@fromorbit.com>
Cc: akiyks@gmail.com, cmaiolino@redhat.com, corbet@lwn.net,
 dan.carpenter@linaro.org, dchinner@redhat.com, djwong@kernel.org,
 hch@lst.de, hsiangkao@linux.alibaba.com, hughd@google.com, kch@nvidia.com,
 kent.overstreet@linux.dev, leo.lilong@huawei.com,
 linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
 longman@redhat.com, mchehab@kernel.org, peterz@infradead.org,
 sfr@canb.auug.org.au, sshegde@linux.ibm.com, willy@infradead.org
Subject: Re: [ANNOUNCE] xfs-linux: for-next updated to 75bcffbb9e75
Date: Wed, 13 Mar 2024 12:23:17 +0530
In-reply-to: <ZepcRgdO39xIrXG2@dread.disaster.area>
Message-ID: <87o7bihb66.fsf@debian-BULLSEYE-live-builder-AMD64>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Mar 08, 2024 at 11:31:02 AM +1100, Dave Chinner wrote:
> On Thu, Mar 07, 2024 at 03:16:56PM +0530, Chandan Babu R wrote:
> Hi Chandan,
>
> I'm finding it difficult to determine what has changed from one
> for-next update to the next because there's only a handful of new
> commits being added to this list.
>
> In this case, I think there's only 1 new commit in this update:
>
>>       [75bcffbb9e75] xfs: shrink failure needs to hold AGI buffer
>
> And I only found that out when rebasing my local tree and that patch
> did not apply.
>
> When I was doing these for-next tree updates, I tried to only send
> out the list of commits that changed since the last for-next tree
> update rather than the whole lot since the base kernel it was
> started from. That made it easy for everyone to see what I'd just
> committed, as opposed to trying to find whether their outstanding
> patches were in a big list already committed patches...
>
> Up to you, but I'm bringing it up because I am finding it difficult
> to track when one of my patches has been committed to for-next right
> now...
>

You are right. I didn't realize this problem. I will limit for-next
announcements to include only new patches that were added/removed to/from the
existing pile.

-- 
Chandan

