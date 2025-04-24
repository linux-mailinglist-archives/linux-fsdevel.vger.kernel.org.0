Return-Path: <linux-fsdevel+bounces-47165-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5912AA9A188
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 08:21:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BF911946DB1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 06:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA7CF1F2BA4;
	Thu, 24 Apr 2025 06:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SzsArKoX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3BE11EBFF0;
	Thu, 24 Apr 2025 06:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745475606; cv=none; b=SbpZUWr+bWaNSAP3RsVuQEvjTqeyTvke6nhh7nPvkDSywI87ZqqcXZllB09WchjqsaH7DRJKCtsQ4i4Q1maXM4ocjv01VY1prdCAcq4SRPBZ8VZiMJTo4Sa35e72cCc4RUx7TiXey7R/VKOyTLGNKF6WDLdlbStPWU9voIaAaOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745475606; c=relaxed/simple;
	bh=+L39Ae08F8aF0lyBrJ/Zb8HGpDl2dpXYS0G2Y7jTJyA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TUzyBNGdCH6He0tScXy0dQ9p/AsP6/2juLF2MA+olyvtJsNJji4sLzezog2uMNeJ1o1GhElp+Xfn4SWVoqFmEuTk/fbyqWThxs1YUikLyKTDYUyhpdjjezG885RwwRxwc5dMXyK4F8l9dpvNqp/85g4GNJIYh48pyjrdm7VP/r4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SzsArKoX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31C65C4CEED;
	Thu, 24 Apr 2025 06:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745475605;
	bh=+L39Ae08F8aF0lyBrJ/Zb8HGpDl2dpXYS0G2Y7jTJyA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=SzsArKoXQY8HkORCjv3APfxLsV57mC+Ct4HcAz19CyatsJKnMHhhfw/4ReDfvpYzq
	 Wy7wjujjUR+eJ7Xg15OLtxFknnzNFmtkh8ddly8UKgVi7wUclrLHT/tlJtygL7VCqg
	 oQDHg6W1TKhC9Bn9KMSgSnM7ltVgKuyqoPBkTV1iAG0qyRUga9cDjcy5kc0gNH+S7M
	 Czx/BAPRtkYozvevv5C9f2xOuNbmCb0rTy+tyrIzDImJx6+nmninrmfcrYnJ2saKHS
	 mAMY04TdsO1uikWTsj/KzjohN/W/HxT9onqM+OHmbWGyMJOC+JvA00dof2p0Hj/mtf
	 yRCvNAKUxklGg==
Message-ID: <4a481adc-2137-427b-9347-a5eafbd471e8@kernel.org>
Date: Thu, 24 Apr 2025 15:20:01 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/17] xfs: simplify xfs_rw_bdev
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
 <20250422142628.1553523-13-hch@lst.de>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20250422142628.1553523-13-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/22/25 23:26, Christoph Hellwig wrote:
> Delegate to bdev_rw_virt when operating on non-vmalloc memory and use
> bio_add_vmalloc to insulate xfs from the details of adding vmalloc memory
> to a bio.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks OK to me.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research

