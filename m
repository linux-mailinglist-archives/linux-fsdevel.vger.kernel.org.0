Return-Path: <linux-fsdevel+bounces-73847-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C73CAD21AD9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 23:58:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B792B302039A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 22:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EB05346E6D;
	Wed, 14 Jan 2026 22:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L4YHLINd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB97338B986;
	Wed, 14 Jan 2026 22:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768431477; cv=none; b=bcxIwkJ0ettodbPRFEmjMSEyeKv0LetDNEd4lNw0+x7+hIyTqtC3RorA4BoghvK7hou4NTsavGZxcZNJx3VKcp5NZgsQYdF0SJCXIFi8CvZNdmrfW2V26HvGKvG9WdRRoJgqPZ5yh9vZGkXUcSUGGfZYYdfngakU0GAr6nFLuiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768431477; c=relaxed/simple;
	bh=WVOAdeU8DJOWzMqoZai67L9g4/roZ0KcG0SakzwYK18=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p0pHJ3+rQ4PlRC1NXAzHzCVDu0pb8NTf+PuovTVYb1T8SkweHDLDf/ohCMj5rGFfvrUoszN/LkmmhKyorir/l3XPP3ZimRuNDF3xsHK49BXpxQ1Ssewi93hiKPBxm+hZsj+awWI9hltuCuKWd4zmIg1dzi0c78D08jSX4xy4fA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L4YHLINd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1D6DC19425;
	Wed, 14 Jan 2026 22:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768431477;
	bh=WVOAdeU8DJOWzMqoZai67L9g4/roZ0KcG0SakzwYK18=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L4YHLINdPEgZrZ1L24OejkcqvxC3UAFn8fmNONVc1I6faxBOe3pYJAdZXs9s4/KH6
	 eacZYDQNbaUl5BrUtOqPH3z9UtjJqDGYmqzUVp3ZKOHucppJtTgU78mR78o3AtwOLy
	 CbUIek64ZVqAmKcYzo1gVU7eZLZFSAAYNKkF4DbpoBYLH6QR86Kprq5ohkuYR3mq3f
	 GGpsz9I4FgSWcs71fD0IjdC+OL1H/iNWDXIXEaWHhHFAJY2o1VpgPfhA7FZ23I6xL7
	 wuL3Jv3ZxAQW8XtWcxhpofgeRu3WwVW2OojhMCR1DB5VUAaDExZG41Bu9Rn7VFeMSj
	 Sj3mXI4V7Rb9Q==
Date: Wed, 14 Jan 2026 14:57:56 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>,
	Carlos Maiolino <cem@kernel.org>, Qu Wenruo <wqu@suse.com>,
	Al Viro <viro@zeniv.linux.org.uk>, linux-block@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 12/14] iomap: support ioends for direct reads
Message-ID: <20260114225756.GQ15551@frogsfrogsfrogs>
References: <20260114074145.3396036-1-hch@lst.de>
 <20260114074145.3396036-13-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260114074145.3396036-13-hch@lst.de>

On Wed, Jan 14, 2026 at 08:41:10AM +0100, Christoph Hellwig wrote:
> Support using the ioend structure to defer I/O completion for
> direcvt reads in addition to writes.  This requires a check for the

  direct

> operation to not merge reads and writes in iomap_ioend_can_merge.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

...and I think this patchset wires up the first place the iomap ioend
code actually gets used for completions, right?

If the answer is 'yes' and with the typo fixed,
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  fs/iomap/ioend.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/fs/iomap/ioend.c b/fs/iomap/ioend.c
> index 86f44922ed3b..800d12f45438 100644
> --- a/fs/iomap/ioend.c
> +++ b/fs/iomap/ioend.c
> @@ -299,6 +299,14 @@ EXPORT_SYMBOL_GPL(iomap_finish_ioends);
>  static bool iomap_ioend_can_merge(struct iomap_ioend *ioend,
>  		struct iomap_ioend *next)
>  {
> +	/*
> +	 * There is no point in merging reads as there is no completion
> +	 * processing that can be easily batched up for them.
> +	 */
> +	if (bio_op(&ioend->io_bio) == REQ_OP_READ ||
> +	    bio_op(&next->io_bio) == REQ_OP_READ)
> +		return false;
> +
>  	if (ioend->io_bio.bi_status != next->io_bio.bi_status)
>  		return false;
>  	if (next->io_flags & IOMAP_IOEND_BOUNDARY)
> -- 
> 2.47.3
> 
> 

