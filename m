Return-Path: <linux-fsdevel+bounces-2525-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 854F87E6C99
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 15:46:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D158FB20BF8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 14:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10F5C1E52F;
	Thu,  9 Nov 2023 14:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P9aUwvww"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41AF41DFF0
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Nov 2023 14:46:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEE89C433C7;
	Thu,  9 Nov 2023 14:46:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699541185;
	bh=w7bv7Zjc4JltfYe6lZhQWG6nyKV+DPfME2hxVRwfnX8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P9aUwvwwyQMQCnfEELfVcZXECrCsK5PkkM1AzWT6dU0pq9bJUXqmBbxAI4Vg25zoT
	 Nz6sbKs16/PO2V33wRhx28IX+GB/LWBTgCxUdqL2NRHj8AqNVIspr6qrDIKgv/eMg/
	 MXTGfXmCXeai8VWWa9ede1Mc48uWtc3etE+OQeDSaRanZ7U5Y6tCaEdESZgiXqAU8i
	 VqTwPaFj+5kYZHMCuDNJbHBq9DQG8aQKeadwkV8gOPAYHq2j25tQejDyZC7ljqq5zX
	 OdfNPF0X5HgnIabV5nTLIDN77M5sLQ9hPUEOFq7V8yJ1MFvO5UwhkrRxOI6Si2M2Y4
	 +M8/wIhurDE+A==
Date: Thu, 9 Nov 2023 15:46:21 +0100
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 09/22] fast_dput(): handle underflows gracefully
Message-ID: <20231109-ansetzen-waben-e4559960285c@brauner>
References: <20231109061932.GA3181489@ZenIV>
 <20231109062056.3181775-1-viro@zeniv.linux.org.uk>
 <20231109062056.3181775-9-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231109062056.3181775-9-viro@zeniv.linux.org.uk>

On Thu, Nov 09, 2023 at 06:20:43AM +0000, Al Viro wrote:
> If refcount is less than 1, we should just warn, unlock dentry and
> return true, so that the caller doesn't try to do anything else.

That's effectively to guard against bugs in filesystems, not in dcache
itself, right? Have we observed this frequently?

> 
> Taking care of that leaves the rest of "lockref_put_return() has
> failed" case equivalent to "decrement refcount and rejoin the
> normal slow path after the point where we grab ->d_lock".
> 
> NOTE: lockref_put_return() is strictly a fastpath thing - unlike
> the rest of lockref primitives, it does not contain a fallback.
> Caller (and it looks like fast_dput() is the only legitimate one
> in the entire kernel) has to do that itself.  Reasons for
> lockref_put_return() failures:
> 	* ->d_lock held by somebody
> 	* refcount <= 0
> 	* ... or an architecture not supporting lockref use of
> cmpxchg - sparc, anything non-SMP, config with spinlock debugging...
> 
> We could add a fallback, but it would be a clumsy API - we'd have
> to distinguish between:
> 	(1) refcount > 1 - decremented, lock not held on return
> 	(2) refcount < 1 - left alone, probably no sense to hold the lock
> 	(3) refcount is 1, no cmphxcg - decremented, lock held on return
> 	(4) refcount is 1, cmphxcg supported - decremented, lock *NOT* held
> 	    on return.
> We want to return with no lock held in case (4); that's the whole point of that
> thing.  We very much do not want to have the fallback in case (3) return without
> a lock, since the caller might have to retake it in that case.
> So it wouldn't be more convenient than doing the fallback in the caller and
> it would be very easy to screw up, especially since the test coverage would
> suck - no way to test (3) and (4) on the same kernel build.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Looks like a good idea,
Reviewed-by: Christian Brauner <brauner@kernel.org>

