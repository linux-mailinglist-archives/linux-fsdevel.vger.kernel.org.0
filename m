Return-Path: <linux-fsdevel+bounces-2537-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A4387E6D69
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 16:27:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04901280FEA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 15:27:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FED62031D;
	Thu,  9 Nov 2023 15:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OfwV9zHu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A2A200D8
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Nov 2023 15:27:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2452CC433C7;
	Thu,  9 Nov 2023 15:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699543648;
	bh=TAC8GrMS1iWXRdIT7ky6wWnZYga5w8jot/FlqiT3lj8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OfwV9zHumFhI0A/4fISY+CzA3G/TtC5LzZwofxxW6Aqg8cB2WtbBn3COoddJQCY3z
	 uAkGorrghqUNttchhvh8F4I9hRwb/LtMfNnWzR0pwZsfHcu/NkbiZPOHK1pCDPsGMm
	 AsppMnJ5mqomYO0db4SFZFR9ilDFb6EgiAV0zjAAonEuSJRcpSYACXpf4yQk73dqmj
	 6devsfnNsV0myxMsir0tH84G1vJpEIZBexY6Wj23/xlQDQRqzwyxWIPQqM+zFvpuGw
	 Yhr7xAR5IvNUsPlUIKKSv3bOeEB2AOufTfpoqlB2RlOYYxO2YZaZPf7UyNmhNU225m
	 k2ZbFY+XpTrjQ==
Date: Thu, 9 Nov 2023 16:27:24 +0100
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 13/22] __dentry_kill(): get consistent rules for victim's
 refcount
Message-ID: <20231109-autohandel-aktenordner-058cd044cb13@brauner>
References: <20231109061932.GA3181489@ZenIV>
 <20231109062056.3181775-1-viro@zeniv.linux.org.uk>
 <20231109062056.3181775-13-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231109062056.3181775-13-viro@zeniv.linux.org.uk>

On Thu, Nov 09, 2023 at 06:20:47AM +0000, Al Viro wrote:
> Currently we call it with refcount equal to 1 when called from
> dentry_kill(); all other callers have it equal to 0.
> 
> Make it always be called with zero refcount; on this step we
> just decrement it before the calls in dentry_kill().  That is
> safe, since all places that care about the value of refcount
> either do that under ->d_lock or hold a reference to dentry

Also worth noting that dentry_kill() is marked with
__releases(dentry->d_lock).

I'm usually pretty liberal with lockdep_assert asserts as well because
it gives nice splats on testing kernels and makes for much faster review
because the assumptions are visible directly in the helper.

> in question.  Either is sufficient to prevent observing a
> dentry immediately prior to __dentry_kill() getting called
> from dentry_kill().
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Looks good to me,
Reviewed-by: Christian Brauner <brauner@kernel.org>

