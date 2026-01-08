Return-Path: <linux-fsdevel+bounces-72693-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 08EC6D00752
	for <lists+linux-fsdevel@lfdr.de>; Thu, 08 Jan 2026 01:23:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 49511302A96D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jan 2026 00:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0119417A2F0;
	Thu,  8 Jan 2026 00:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q3mmKFVV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 560A513D638;
	Thu,  8 Jan 2026 00:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767831793; cv=none; b=orB1YpQPojFROWpdHYU915mm4LKirNpgb07BsmZ21SUp15wyLpan9TVKje7mkKiDBrOx1cOdEHLij0RTAkvSr75VL6C4OIg0XqnY1fYUl6UtoSNb286kZ9xVoRjHK1Ty3rQYhXxFCZxTm0MY3wIIKObpohLHkSImdSethjNnb3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767831793; c=relaxed/simple;
	bh=g9IA4Aqk4f7eWargh/5arYrMSoqYV+tkbHbKIfwiL8c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y/yYu3LGwJops5M2LANrQcrWRHqEBxV3AdjlT02WtUhVUz4wkvXj88xGgPe0I+AT1tOlYQXWKNrWMkhHFAB44YaxACg8ufS6WEa78yD01+sTI5tj8MQRB1bhWsMtRMNehf/Rk/WDoz0YM3A2JSg1NNqonRUGn6l/fDEqLf66snk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q3mmKFVV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CA54C4CEF1;
	Thu,  8 Jan 2026 00:23:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767831790;
	bh=g9IA4Aqk4f7eWargh/5arYrMSoqYV+tkbHbKIfwiL8c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q3mmKFVVlh5maDmhjnwF2u4evdMR1O9gltWM7CgSejgw8LVjbhTm0kmJcc/iKuZ9u
	 NKK6i/DN5yC2vJ7qpNv999h4ciJmKMKZz7d21miyyhjh30qfq068qhKrQ4HGY88BHj
	 +o60/WiakWMZMKxiSrfG+nelRRwvisVy9gC4sb/NNBdTdbdIHiSo28kaoATbqCGm+F
	 Se1H0uZ2pSMeJe37LX9ChOLEf3627VKI2kfG0rgGOR3Uvg45qPcF3WgxpOrCBmHK8V
	 41k/qawCnf+x7FcWfTC+e5udNc9K9ujqIZfLuPf1lbJVPleJrYTqCcjkSEnQPZPDRK
	 KTNld/p3aTDmA==
Date: Wed, 7 Jan 2026 16:22:50 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-fscrypt@vger.kernel.org
Subject: Re: [PATCH 7/9] blk-crypto: use mempool_alloc_bulk for encrypted bio
 page allocation
Message-ID: <20260108002250.GA2614@sol>
References: <20260106073651.1607371-1-hch@lst.de>
 <20260106073651.1607371-8-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260106073651.1607371-8-hch@lst.de>

On Tue, Jan 06, 2026 at 08:36:30AM +0100, Christoph Hellwig wrote:
> +out_free_enc_bio:
> +	/*
> +	 * Add the remaining pages to the bio so that the normal completion path
> +	 * in blk_crypto_fallback_encrypt_endio frees them.  The exact data
> +	 * layout does not matter for that, so don't bother iterating the source
> +	 * bio.
> +	 */
> +	for (; enc_idx < nr_enc_pages; enc_idx++)
> +		__bio_add_page(enc_bio, enc_pages[enc_idx++], PAGE_SIZE, 0);
> +	bio_io_error(enc_bio);

There's a double increment above.

Otherwise this looks okay.

- Eric

