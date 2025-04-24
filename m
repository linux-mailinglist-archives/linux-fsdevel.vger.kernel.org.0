Return-Path: <linux-fsdevel+bounces-47170-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB9FBA9A227
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 08:31:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F1175A4D4D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 06:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8B89205502;
	Thu, 24 Apr 2025 06:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KE5YnjeL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD9DB1E0083;
	Thu, 24 Apr 2025 06:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745475970; cv=none; b=F+AEFpaiQapUT5kMJiOUTJv8rLp0qYa3QHlymfB9VEw9SDr7n1uVC3RZ5reabLy1/djiH7pnqwYNIwF7s3325EkOeRajQRpGUZNxc6S7nzaGbENjZVejHYwNDkkSaqBLOV7UyMYjGEW5s04r5mBY4sGRQ/ApwFrCfp6o4CCEU6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745475970; c=relaxed/simple;
	bh=mxSIkGwRgFfWToysHIuZeo9xE0ZCdWZ47rICJOBvA1E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OiEHnuWfvc1KYpRG+HBno7C/a1A4b3eX7LSxPTgBzDrFfh0t9YVcvAP9KsSrtaI8sjKK/oDR46eai/gPzjfTldqOePHkpzBBCPgw1r+jvNcCWL1i77ujE3Qg4jpUjW5yNL4S2prJJmuA4sv18uRyt3qB5mNzJzw1WvfLvNC1yy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KE5YnjeL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D8DBC4CEEA;
	Thu, 24 Apr 2025 06:26:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745475969;
	bh=mxSIkGwRgFfWToysHIuZeo9xE0ZCdWZ47rICJOBvA1E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=KE5YnjeLr1Ywx1K23We7IaNb6UZ8b8xHtoyL0ELEISg8OnqNhZvRO27X8L3UEM3j1
	 DyOnTsleuuh3eIFQgGwBK+DfH3oqDBXovipkxt4bX0NP43RYz5uHDAcHWGrPny4kC2
	 vRlV3MOtbl4NWSIg2dc2l4j8s69kzb8IoYhN1d3unixehSX/LUHufzad9MYE+Nptxb
	 3iG4yg1SBcAI7fDKnw6t3N//QCuq0Vdaul9/z2pxvQ7ki/YkS6ocZTdF+UfF7jBM1p
	 RPwTDjU7jpDY95ingWLvIycthRGS4QhivQS8bgGPkr4MUyy5aHa7P60OFyoHSiDfUU
	 FiloAW9VAqpOg==
Message-ID: <5221c8c6-d125-4347-98f7-f1fccc0b9eb5@kernel.org>
Date: Thu, 24 Apr 2025 15:26:05 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 17/17] PM: hibernate: split and simplify hib_submit_io
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
 <20250422142628.1553523-18-hch@lst.de>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20250422142628.1553523-18-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/22/25 23:26, Christoph Hellwig wrote:
> Split hib_submit_io into a sync and async version.  The sync version is
> a small wrapper around bdev_rw_virt which implements all the logic to
> add a kernel direct mapping range to a bio and synchronously submits it,
> while the async version is slightly simplified using the
> bio_add_virt_nofail for adding the single range.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks OK to me.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research

