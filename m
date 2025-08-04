Return-Path: <linux-fsdevel+bounces-56675-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E015B1A860
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Aug 2025 19:11:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38FEB7AB5E2
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Aug 2025 17:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1A9728B40D;
	Mon,  4 Aug 2025 17:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BqkUr1ie"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27566286D4C;
	Mon,  4 Aug 2025 17:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754327467; cv=none; b=tt1YVFQlJXPQ5+1Nu/0KGl3hwiTOv5Mti94HeQ2gc406b9iNGNU8U6Qdz9vESEobXEBNXRW57X2/QdGjDpyV4K8CNgH7okpBMhFPgrkwL+3mI7msz4iclsp6a1vNbUOgrFQ2jJmAgPuBVgBjjuwVK00JEsSZ7rl6axQBB+y2gsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754327467; c=relaxed/simple;
	bh=QY212mSDy/8Wgzf+MqX1YcqzwSHQd8UphfmbaJNCy5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fZKayyMcsliFOvE4+K7dT1RkinyxLUJzjJgZM7p84xKiBrU93fib9Jww4GVPig08HRyqDBYT5NCqdX+U4oFh82PbC9smAiL4C85Ky1873kpnL8z3+TucWPOy/Z0LQQiee0m5i3Dhv6JvF16vRwDW7RY/JNf51wRRQEaFqqaRlwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BqkUr1ie; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEB89C4CEF6;
	Mon,  4 Aug 2025 17:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754327465;
	bh=QY212mSDy/8Wgzf+MqX1YcqzwSHQd8UphfmbaJNCy5Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BqkUr1ieUeT6g1/wkZqLy5DxZDM3TWBgG7lm/2BCPlWDku3Mz7piw8TtXMyyp8AFO
	 nAJjCKXYfETQdBg0POCPsm2b24pC3Dz4DqksdkQTWZFJ3aV7jC7KF/3HgKxT+PYFWC
	 CAcsE5DLxWq66BQ81mBWicgLQ4PNqjusAiEmnVo0o3RkuxlggD5ZT8mt8JSzEvcxwK
	 SuUq7jCIlrTw9h/g1sC4shydqFNES5WDSrCkusd1x86/804MsV258vHAh4+bhPwgzj
	 YKwUtnahZMQLr4QvZ58DU1s/exV8WE1Q3muNHR2ad2tojlRmQXdYzHE8J3/TiL7UhB
	 LPVIWI+aNLq3A==
Date: Mon, 4 Aug 2025 11:11:02 -0600
From: Keith Busch <kbusch@kernel.org>
To: Hannes Reinecke <hare@suse.de>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	snitzer@kernel.org, axboe@kernel.dk, dw@davidwei.uk,
	brauner@kernel.org
Subject: Re: [PATCH 3/7] block: simplify direct io validity check
Message-ID: <aJDppvHXW8rspmVx@kbusch-mbp>
References: <20250801234736.1913170-1-kbusch@meta.com>
 <20250801234736.1913170-4-kbusch@meta.com>
 <065d699a-1edb-4712-9857-021c58c5e5c2@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <065d699a-1edb-4712-9857-021c58c5e5c2@suse.de>

On Mon, Aug 04, 2025 at 08:55:36AM +0200, Hannes Reinecke wrote:
> On 8/2/25 01:47, Keith Busch wrote:
> >   static bool blkdev_dio_invalid(struct block_device *bdev, struct kiocb *iocb,
> >   				struct iov_iter *iter)
> >   {
> > -	return iocb->ki_pos & (bdev_logical_block_size(bdev) - 1) ||
> > -		!bdev_iter_is_aligned(bdev, iter);
> > +	return (iocb->ki_pos | iov_iter_count(iter)) &
> > +			(bdev_logical_block_size(bdev) - 1);
> 
> Bitwise or? Sure?

Yep, this is correct. We need to return an error if either the size or
offset are not aligned to the block size. "Or"ing the two together gets
us a single check against the logical block size mask instead of doing
each individually. 

