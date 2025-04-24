Return-Path: <linux-fsdevel+bounces-47166-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CC2CA9A18D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 08:21:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9B55461771
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 06:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 733161E1DEC;
	Thu, 24 Apr 2025 06:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mGTFOS/z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E5F1B0F19;
	Thu, 24 Apr 2025 06:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745475643; cv=none; b=ftv69wsxY1uVfCWQfArnyTbLRqC1Xoo3CiiZ9J9y5tVvbWO6lKaYSZxChb0QJPiMe12KG8HE7jkq38emh2vUlo65iRpekdCvpPg6OrYgH537X3WQc1Q2tM0VOCCEmMKM5MA35RxztTkta7umJxW7pKq3068wmmx/LoxrUAe21t4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745475643; c=relaxed/simple;
	bh=dwYQkBO2LcdIccYmfP+l9N2F4HoZ6fR32ZCHy1xVZuI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k5TVvqXwnFfUmt7sMZrXodMDGmfNbF3d3Vv03wA+fpuyTweY9UH7A57EmJJgnPOgagRNoRGb8CFCqusjzbFG6SPDm/bYzGqAUsAU81KFNNVJXPNpAKxiOLwupOaeSIKqIuOi5OI8qT/BCSrL8+ZEdiHhm1tq8O21IXypk4H9cmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mGTFOS/z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65CD9C4CEE3;
	Thu, 24 Apr 2025 06:20:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745475643;
	bh=dwYQkBO2LcdIccYmfP+l9N2F4HoZ6fR32ZCHy1xVZuI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=mGTFOS/zJzqxH9zOfI/Rmc81xM1J+jgk3CObJxEmvqnEkgd4yFyZtDeVOy8JkGf4V
	 AiPVo0gMvvHjf3id6CmpjgrQyWji1ohxfOQt560QoJBKjMxCc3Oi8E0KFwb/Iux+Em
	 1rAoEHFpYNxkJTv70Q6lIEB3RKncmV/gH+cBRT4oToTTXwBhCSTW0VGpScTxhIEHNk
	 QfPU15hwSlPnbY/9pmaiwj4wZ7MOmLGHHGCttO/qaDEHhgoLvryMiflxoVUfgteDga
	 mTMaGTo1A4BfBVqViRF1wiZPY2b7xUbCtXV8VRIV6TkZ4H5ht8UbQ+tPmqr3NgM9IY
	 FHAMVzPyv+h2g==
Message-ID: <1a384893-e338-4da6-b76a-dd3e0f42d0dc@kernel.org>
Date: Thu, 24 Apr 2025 15:20:39 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/17] btrfs: use bdev_rw_virt in scrub_one_super
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, "Md. Haris Iqbal" <haris.iqbal@ionos.com>,
 Jack Wang <jinpu.wang@ionos.com>, Coly Li <colyli@kernel.org>,
 Kent Overstreet <kent.overstreet@linux.dev>,
 Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>,
 Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
 David Sterba <dsterba@suse.com>, Andreas Gruenbacher <agruenba@redhat.com>,
 Carlos Maiolino <cem@kernel.org>, Naohiro Aota <naohiro.aota@wdc.com>,
 Johannes Thumshirn <jth@kernel.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>,
 linux-bcache@vger.kernel.org, dm-devel@lists.linux.dev,
 linux-btrfs@vger.kernel.org, gfs2@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
 linux-pm@vger.kernel.org
References: <20250422142628.1553523-1-hch@lst.de>
 <20250422142628.1553523-14-hch@lst.de>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20250422142628.1553523-14-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/22/25 23:26, Christoph Hellwig wrote:
> Replace the code building a bio from a kernel direct map address and
> submitting it synchronously with the bdev_rw_virt helper.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks OK to me.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research

