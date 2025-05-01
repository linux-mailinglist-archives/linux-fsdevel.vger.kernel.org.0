Return-Path: <linux-fsdevel+bounces-47856-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B2791AA6336
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 May 2025 20:52:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22ED54682D9
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 May 2025 18:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17162224AEB;
	Thu,  1 May 2025 18:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kJn2wlQx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 546D52153FB;
	Thu,  1 May 2025 18:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746125563; cv=none; b=BGyQRvXnwzGtLOZLq78P4i4jd7CT2v/8/3aXtfP4tO/pV0JHfn7hsKFDLvVeZgtiUdyFMtqUd1FunjGqivMSTHQmRJ63praHLjH1DvHWSPFpJ4r8D4rpxhn3SLlSD/76QQys2XPJK7/hucYlYwkicyx8CQB1akuQc/ERbjCM7gM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746125563; c=relaxed/simple;
	bh=/AnbYT/N758HU/OHD81/fqVlOKJgQ2wfd8QggmxRAWM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bEQ4P6mAo+wqGNEjYCVbzjpjmc3PwbkoEhZPj9/RxDwI+bMNBV+sp0HyN7lZj5ZiuULEHzyD7v2hw0JWfKw7TVZ6naG2JEkL6Dn9/V9vBE5y5lAogjUcr8jxkE/9FUibu3vTNMTpOWbZfJpMTz469HvxRnrhNUj3hYmJ+PwxoEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kJn2wlQx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3EBAC4CEE3;
	Thu,  1 May 2025 18:52:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746125560;
	bh=/AnbYT/N758HU/OHD81/fqVlOKJgQ2wfd8QggmxRAWM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=kJn2wlQxiIP49PSRhCtGXSoGQXuZC6qDea6EbcYfvgVblpKGveGAqPc1bi2yOJn4Y
	 YBwgA9577hjHPzaOovZ0Ho7bob9FnTrFWwQbc86kUYzkqS6wZ/meDRwCee+JURmlB4
	 BZ1GAN4xQrmm/Ar5h3scXV2Lg9rKO0amdaQLayCS+wRlzUmfsRr3XKmldFCgeo1Cwb
	 dkDk+HHyCK4+l/EBy18PBeseW5Gv/mH5NPfhbLsjcYF31q591mBxFTviSXKN61VNvM
	 L3U8SpUhb3ctFVvvXIQSV7y4TqlZE7wF+zqnOuCXIC1p5u1eQyrGhb7sJKVorEnc6O
	 8ygQ3lH9GWPNw==
Message-ID: <0907232a-e36a-4826-aea6-8b633d67fd68@kernel.org>
Date: Fri, 2 May 2025 03:52:37 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/19] block: add a bio_add_vmalloc helpers
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, "Md. Haris Iqbal" <haris.iqbal@ionos.com>,
 Jack Wang <jinpu.wang@ionos.com>, Coly Li <colyli@kernel.org>,
 Kent Overstreet <kent.overstreet@linux.dev>,
 Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>,
 Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
 David Sterba <dsterba@suse.com>, Andreas Gruenbacher <agruenba@redhat.com>,
 Carlos Maiolino <cem@kernel.org>, Naohiro Aota <naohiro.aota@wdc.com>,
 Johannes Thumshirn <jth@kernel.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>, slava@dubeyko.com,
 glaubitz@physik.fu-berlin.de, frank.li@vivo.com,
 linux-bcache@vger.kernel.org, dm-devel@lists.linux.dev,
 linux-btrfs@vger.kernel.org, gfs2@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
 linux-pm@vger.kernel.org
References: <20250430212159.2865803-1-hch@lst.de>
 <20250430212159.2865803-5-hch@lst.de>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20250430212159.2865803-5-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/1/25 06:21, Christoph Hellwig wrote:
> Add a helper to add a vmalloc region to a bio, abstracting away the
> vmalloc addresses from the underlying pages and another one wrapping
> it for the simple case where all data fits into a single bio.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good to me.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research

