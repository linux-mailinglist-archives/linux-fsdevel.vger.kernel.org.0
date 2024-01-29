Return-Path: <linux-fsdevel+bounces-9470-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D19DA8416D7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jan 2024 00:29:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D54828537B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 23:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8CF215AAA5;
	Mon, 29 Jan 2024 23:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jRmN35v5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3435351C31;
	Mon, 29 Jan 2024 23:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706570872; cv=none; b=Fa1LRX0MDLpk78Zo1eGH5GCugbGjo9M8cHI/mq/Z/K5zRHOw76Wu8Hb/loMwn+IgeZahxDlnxUWrzgadngwsV7kLYwVMST67uTSScf1mNx3K1+c0AXdGOryOA16WmjK3cj/muF50hOK7SL5cCgMAmRQPNbXDSf5mYXyC4aMND3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706570872; c=relaxed/simple;
	bh=Mdn+J9ySgQDC0oIOmuVaL01BXzHtXOiqj1R6pkOEXjg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ekTC58hXogbq0e8yOLfKACq89qR1SnoHrKJKSmhIbBrthlWpPskbh5qPf2POnWh1LG7Dxy5RRGWOT/y/SaYWsvKXfZ4DZ/gLgsY8cYzzGlUqfYQ6diar1CGkk+BJam2c8ZLRyqavbryJeVXXPfFWFhV4jbFBwo2Q9Y+ED9yf0k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jRmN35v5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1237C433C7;
	Mon, 29 Jan 2024 23:27:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706570871;
	bh=Mdn+J9ySgQDC0oIOmuVaL01BXzHtXOiqj1R6pkOEXjg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=jRmN35v5/TLg+E/6GKrLcZzc40NYxmcq8gYRNw3u3sie30Rz+d4av7V7MegSsvqxG
	 KAiuOGk8tu1E8XEbv7dckuFrLaVvYOpq53UYRA227YbeEkM9B2tRSdYDDjlpShY8Rg
	 t89UsvoRUr8Xjtv/+1ilsuMwibhwjrERvpTSDoPSFskCTLvL24IQNVeLqQduEKgJcC
	 JqA7KuJS+iTk3EagquaUHipVQpJUytNEzUi33la2Et2MbK9oVD12OV2tPIqOg7zsY3
	 ymEpmNGW3zFiJot8m6q+DnJAvGWXMjv93tIrljuszNfyQhfzZTx3LriKq9mqEaCvH0
	 Ff5p4GJAKdBfw==
Message-ID: <cb6d6cc2-25bd-4ce1-baa8-9ba94672977b@kernel.org>
Date: Tue, 30 Jan 2024 08:27:48 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/5] f2fs: guard blkdev_zone_mgmt with nofs scope
Content-Language: en-US
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>,
 Naohiro Aota <naohiro.aota@wdc.com>, Johannes Thumshirn <jth@kernel.org>,
 Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>,
 Mikulas Patocka <mpatocka@redhat.com>, dm-devel@lists.linux.dev,
 Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
 David Sterba <dsterba@suse.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
 Chao Yu <chao@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-btrfs@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
References: <20240128-zonefs_nofs-v3-0-ae3b7c8def61@wdc.com>
 <20240128-zonefs_nofs-v3-4-ae3b7c8def61@wdc.com>
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20240128-zonefs_nofs-v3-4-ae3b7c8def61@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/29/24 16:52, Johannes Thumshirn wrote:
> Guard the calls to blkdev_zone_mgmt() with a memalloc_nofs scope.
> This helps us getting rid of the GFP_NOFS argument to blkdev_zone_mgmt();
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research


