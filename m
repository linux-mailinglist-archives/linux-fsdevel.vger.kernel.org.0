Return-Path: <linux-fsdevel+bounces-18075-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD6F68B5349
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 10:39:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 633AB1F2134A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 08:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB2FC17BC9;
	Mon, 29 Apr 2024 08:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dvHTZnRK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EA8F17756;
	Mon, 29 Apr 2024 08:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714379945; cv=none; b=ZWF01QG0VBkkouY169qwPmDffUFmTcIJ2Z282i4veFkjcku5HXrIdShsSc/ABNelhddLku8Na5ceC7UgYtG8rTkz7QJrgWYdrEjeFanlTct2p66mxuHpoSP4dZjFoSlWy8siMvP8llKKVxarPCg7dNhOmlf7zSf1ZwKZevHMzMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714379945; c=relaxed/simple;
	bh=kKT3vU9O4ihHDvGWDgXmfSW0QpMDGrNMHiNJAh9IU0s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HdZdKsQ44xuOg/07u5OuC2sE4NzTxvZv52S3KfTIpFaiuRAujUk9ah0/R4PK4+yws6DSsLy4HXliKHzW7FMxOMXMm8/xsmj+8cSZyE2pnG8eNYlhWBFhYR65Q5GAzlrQWnuZpw3GsOcOilEDEyONYg9lwZBGK9F3kH0yM+cdpaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dvHTZnRK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72A98C113CD;
	Mon, 29 Apr 2024 08:39:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714379944;
	bh=kKT3vU9O4ihHDvGWDgXmfSW0QpMDGrNMHiNJAh9IU0s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dvHTZnRK1Z4CiPR1Jml4FtzPhNj/yNrsufUy8azbBy+eSelSJcFOQY2EThajHYxtr
	 WXSwEj2T1dSZxdmPWVc4AXl/xUz0MoMd4g9h92L5ehmm7ZgJiWYzoqnwIcyRGsDsBO
	 rp/zaU/pEaKCGAL82OkUYCe/LjBi3hJi72mToxEcP7nP912xhyf3AX9Sllf9TAzeWW
	 R6IaozJ8tLCddZF7CT2jWfioXFYrbWqd70X2zwmbz8aTA/i2NxntbsY+qlib1kGL63
	 bAdboNbKu/aoddf7psb/XWHV1Kz739u7iGY72YA9lspV8ziNuenLSQvUNNJd5IpK9h
	 8/AktcOLcqaMg==
Date: Mon, 29 Apr 2024 10:38:59 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org, 
	Jens Axboe <axboe@kernel.dk>, linux-btrfs@vger.kernel.org, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 3/7] swapon(2)/swapoff(2): don't bother with block size
Message-ID: <20240429-heilen-renitent-2096c9321041@brauner>
References: <20240427210920.GR2118490@ZenIV>
 <20240427211059.GC1495312@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240427211059.GC1495312@ZenIV>

On Sat, Apr 27, 2024 at 10:10:59PM +0100, Al Viro wrote:
> once upon a time that used to matter; these days we do swap IO for
> swap devices at the level that doesn't give a damn about block size,
> buffer_head or anything of that sort - just attach the page to
> bio, set the location and size (the latter to PAGE_SIZE) and feed
> into queue.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Looks good to me,
Reviewed-by: Christian Brauner <brauner@kernel.org>

