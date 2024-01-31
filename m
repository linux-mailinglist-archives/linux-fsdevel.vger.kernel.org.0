Return-Path: <linux-fsdevel+bounces-9630-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E053C8437F0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 08:32:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89970289C12
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 07:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A4F757339;
	Wed, 31 Jan 2024 07:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sXgRqJl/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF04755E72;
	Wed, 31 Jan 2024 07:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706686356; cv=none; b=GJShbXggWe1S+orNiQeWk/uXef4eS/o21IBkKzx5VdfdB1nZnXwNvzzXzmvJRMUY8OY60OplkJvWDkzaNszr+KG2ya8/O/PLhKecxXYDvjMh0YUgrsdpPemc+X6bhWgx/hsDuy4H8CWsN3P7CqJ9J0AJBxFeggWOxAys2W8dIkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706686356; c=relaxed/simple;
	bh=sxA/BQif6UosZYq9bEM7P35Kp7rNc5yXcyj9qFUfD4o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=plvCMfUKKL55nr5jgSUAMCsCJMtQzfVXPXIXrrosAOLWWWoGlNYmjk9ygF5/PMXB6CVtD7R5n1LJQrd6P8VnQT1kbz3DpThoq8zGKjnsHrwzExkSIIp9WzY+obPs0CdhExQL9XxTQ6kPJrMuzfo5lFTFYNI4WbxqNX9aTO3Pekk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sXgRqJl/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB2C4C433C7;
	Wed, 31 Jan 2024 07:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706686355;
	bh=sxA/BQif6UosZYq9bEM7P35Kp7rNc5yXcyj9qFUfD4o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=sXgRqJl/mMi2kUmYZA/bTZQ70FhzSCKpqsJprAywphSWPE15pORJFWbnfKjrJ8FqL
	 FbArM8c44OdB1yyxg99MPlRtVdaX2d36hFPLV2AIVx6sK5wuRFanJeAmmkeosV2jeO
	 i/tEvG5AAbqeAW/XsqxaSasMNCN9W/WIfyupoc/USjWkoFBPzkcYi+XaYHcMORh6mG
	 bZ6HHZH/1YaM9xkgVDWPrRkj0gPXkQPS1y8kM6feJtdxy7PdpZ8fI9sAxeuqlUijBF
	 H/mkTru9fO3Nf9nW21Ssl6kU7nEjmd5iZKNHS78J3STgJ4BuvnPKcX2HN0sirrqqx+
	 2DFYmNgfg0rLg==
Message-ID: <a73d0808-b6ae-4d78-9846-379b83540c72@kernel.org>
Date: Wed, 31 Jan 2024 15:32:26 +0800
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
 Damien Le Moal <dlemoal@kernel.org>, Naohiro Aota <naohiro.aota@wdc.com>,
 Johannes Thumshirn <jth@kernel.org>, Alasdair Kergon <agk@redhat.com>,
 Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>,
 dm-devel@lists.linux.dev, Chris Mason <clm@fb.com>,
 Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
 Jaegeuk Kim <jaegeuk@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-btrfs@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
References: <20240128-zonefs_nofs-v3-0-ae3b7c8def61@wdc.com>
 <20240128-zonefs_nofs-v3-4-ae3b7c8def61@wdc.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20240128-zonefs_nofs-v3-4-ae3b7c8def61@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/1/29 15:52, Johannes Thumshirn wrote:
> Guard the calls to blkdev_zone_mgmt() with a memalloc_nofs scope.
> This helps us getting rid of the GFP_NOFS argument to blkdev_zone_mgmt();
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

