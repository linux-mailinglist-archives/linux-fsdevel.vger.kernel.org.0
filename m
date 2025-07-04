Return-Path: <linux-fsdevel+bounces-53911-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA42AAF8D7E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jul 2025 11:06:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A32775806D2
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jul 2025 09:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 430EB2F4A17;
	Fri,  4 Jul 2025 08:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QzTOMSo5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A1A52F4338;
	Fri,  4 Jul 2025 08:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751619453; cv=none; b=HiJdDt7+YA42Nlpzgj35PQm38e58pmDhd3k7ZaaZ4pU90RcIw+tuwr1ZUCx9JbLrTFNcW5p13SL9UypZnKDpZZwNDC36ZEYQpFrcYuPx+rggLeAHlvd+C2HODifWzrNEB6fDXJAbA4cAeMEoYviTfn2P0K1eSDmf9qZqpqugQdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751619453; c=relaxed/simple;
	bh=o90RWgAF1Lp2VvgsXOZIKfZyE0Mb8YK3dri/sMUw57c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=clIY+BxpZy3qaP54GFm/8A5s5A5O5737Kyec+VaxFR3OXK7YjMNG2y1JmoYOmNPFsyPUOlpNbJNVfa01oGh5Ve17A/NQRH9xF9gGyjLRlvE4jID3/hlOHSfBODgSmgANkI3jnaC5DcsZVdqL7Blt3ltEofJdWqOiBGiLGichA8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QzTOMSo5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0F37C4CEE3;
	Fri,  4 Jul 2025 08:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751619451;
	bh=o90RWgAF1Lp2VvgsXOZIKfZyE0Mb8YK3dri/sMUw57c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QzTOMSo5YhsDdBmnwvnp4KQANEMPvCDQK+ZGiltALUbRRgDxhH3Uz2gT5k5iRUbMP
	 3JNW2GRG4PholHPOElxupx8/Rpkar9WCcQBjlnnn1etQry/5Zs+TRKbNhjAbq7Irgq
	 EYGy9ejAC3iy7ua7JMg4ZH7sEX3DohgMDyGsRrzu47eju+EwUWIY89uRvvY48RFQ5I
	 IK+EzHIDWvKt88EHv7n61KSjUo2y2VL4CwF0hEbZ6LwkP1dzspephJXEBje+MJnLnA
	 fgSom+CiLQeLWE+VNLpQsP/B1dFeeeO/tK6bcE+B+WUnyh8Uaqyqka9Wuo31bJaW0z
	 DWhLLE9q3hK2A==
Date: Fri, 4 Jul 2025 10:57:27 +0200
From: Christian Brauner <brauner@kernel.org>
To: Laura Brehm <laurajfbrehm@gmail.com>
Cc: linux-kernel@vger.kernel.org, Laura Brehm <laurabrehm@hey.com>, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/2] coredump: fix PIDFD_INFO_COREDUMP ioctl check
Message-ID: <20250704-badeanstalt-eurem-b944cdc46c4c@brauner>
References: <20250703120244.96908-1-laurabrehm@hey.com>
 <20250703120244.96908-3-laurabrehm@hey.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250703120244.96908-3-laurabrehm@hey.com>

On Thu, Jul 03, 2025 at 02:02:44PM +0200, Laura Brehm wrote:
> In Commit 1d8db6fd698de1f73b1a7d72aea578fdd18d9a87 ("pidfs,
> coredump: add PIDFD_INFO_COREDUMP"), the following code was added:
> 
>     if (mask & PIDFD_INFO_COREDUMP) {
>         kinfo.mask |= PIDFD_INFO_COREDUMP;
>         kinfo.coredump_mask = READ_ONCE(pidfs_i(inode)->__pei.coredump_mask);
>     }
>     [...]
>     if (!(kinfo.mask & PIDFD_INFO_COREDUMP)) {
>         task_lock(task);
>         if (task->mm)
>             kinfo.coredump_mask = pidfs_coredump_mask(task->mm->flags);
>         task_unlock(task);
>     }
> 
> The second bit in particular looks off to me - the condition in essence
> checks whether PIDFD_INFO_COREDUMP was **not** requested, and if so
> fetches the coredump_mask in kinfo, since it's checking !(kinfo.mask &
> PIDFD_INFO_COREDUMP), which is unconditionally set in the earlier hunk.
> 
> I'm tempted to assume the idea in the second hunk was to calculate the
> coredump mask if one was requested but fetched in the first hunk, in
> which case the check should be
>     if ((kinfo.mask & PIDFD_INFO_COREDUMP) && !(kinfo.coredump_mask))
> which might be more legibly written as
>     if ((mask & PIDFD_INFO_COREDUMP) && !(kinfo.coredump_mask))
> 
> This could also instead be achieved by changing the first hunk to be:
> 
>     if (mask & PIDFD_INFO_COREDUMP) {
> 	kinfo.coredump_mask = READ_ONCE(pidfs_i(inode)->__pei.coredump_mask);
> 	if (kinfo.coredump_mask)
> 	    kinfo.mask |= PIDFD_INFO_COREDUMP;
>     }
> 
> and the second hunk to:
> 
>     if ((mask & PIDFD_INFO_COREDUMP) && !(kinfo.mask & PIDFD_INFO_COREDUMP)) {
> 	task_lock(task);
>         if (task->mm) {
> 	    kinfo.coredump_mask = pidfs_coredump_mask(task->mm->flags);
>             kinfo.mask |= PIDFD_INFO_COREDUMP;
>         }
>         task_unlock(task);
>     }
> 
> However, when looking at this, the supposition that the second hunk
> means to cover cases where the coredump info was requested but the first
> hunk failed to get it starts getting doubtful, so apologies if I'm
> completely off-base.
> 
> This patch addresses the issue by fixing the check in the second hunk.
> 
> Signed-off-by: Laura Brehm <laurabrehm@hey.com>
> Cc: brauner@kernel.org
> Cc: linux-fsdevel@vger.kernel.org
> ---

Yes, that looks correct to me. Thanks for the fix!

