Return-Path: <linux-fsdevel+bounces-20921-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AA448FAC36
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2024 09:39:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 287D41F21880
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2024 07:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10E451411E0;
	Tue,  4 Jun 2024 07:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GI261o57"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4680F1EB30;
	Tue,  4 Jun 2024 07:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717486771; cv=none; b=FdzOn4M3TR9xulbXJGtnZrZPFYA+DHn6tVjGZvTKPouJLEDNWlGgfXyNJYITQUJA0K6VFiyDDVc8ZQK6plrPNWL7pvfLvg+xSqo2LfPF/hsMzsR+DwUPhkzmye8/nb7FnAJLmVwrYyDjlztILYUV35AsIANClfL8E7Ah3HSrS0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717486771; c=relaxed/simple;
	bh=IwRk73FI7oCSvA9GoThk9eEnhOPDGRbbqcPOdPVc2Uw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qUzx9cG0SUqbRDiM/U2xVcpFMCV2roMQJ9RZOqPEBgz8PioWDzB+rSaoDmNpVStQ1YywYe+GAAGBiv0HSEN9Ok+VmmfAqFQi4lcpA4Pit7uMlqqjUcVFByDtc/GPYLT6e+hPzr51LNyZN+Us3yxgkCkz866GysabXcHyNirkuVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GI261o57; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11995C32782;
	Tue,  4 Jun 2024 07:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717486770;
	bh=IwRk73FI7oCSvA9GoThk9eEnhOPDGRbbqcPOdPVc2Uw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=GI261o576gg25/lggqNDA2SfXlSJn3QRY7AGVwcyAmBUOY2+2/Skb/bS1BUCh9qWl
	 QKz3Jh5M82o5F/6PUgsBq0Gsh7DHrbgUxYPptG+VI9WDVVcsarzvpz92mvCFUSRn4w
	 dsA3PAUnRTIlKggNkbrr+yewxURwwu2pgA4udfQ7PsravITSz0hF0RNkvPEsXjrDW0
	 wgwdLoaBdgKRYI4xl7pgSc9vSh2CdAzwjhxH4xcArykbw0zJHnERyQlz+xAu/TMLtL
	 Yd9pQ9MINSEdazBen1lLjskybIkbgnHTDxCdtLFQWOH/x3vJ71IiKQwnw36Gv4Ljfd
	 jhhldACaNEbJQ==
Message-ID: <5441b256-494a-4344-89fd-ee8c5a073f8b@kernel.org>
Date: Tue, 4 Jun 2024 16:39:25 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v20 00/12] Implement copy offload support
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>,
 Nitesh Shetty <nj.shetty@samsung.com>
Cc: Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>,
 Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>,
 Mikulas Patocka <mpatocka@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 martin.petersen@oracle.com, bvanassche@acm.org, david@fromorbit.com,
 damien.lemoal@opensource.wdc.com, anuj20.g@samsung.com, joshi.k@samsung.com,
 nitheshshetty@gmail.com, gost.dev@samsung.com, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 dm-devel@lists.linux.dev, linux-nvme@lists.infradead.org,
 linux-fsdevel@vger.kernel.org
References: <20240604043242.GC28886@lst.de>
 <393edf87-30c9-48b8-b703-4b8e514ac4d9@suse.de>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <393edf87-30c9-48b8-b703-4b8e514ac4d9@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/4/24 16:16, Hannes Reinecke wrote:
> On 6/4/24 06:32, Christoph Hellwig wrote:
>> On Mon, Jun 03, 2024 at 10:53:39AM +0000, Nitesh Shetty wrote:
>>> The major benefit of this copy-offload/emulation framework is
>>> observed in fabrics setup, for copy workloads across the network.
>>> The host will send offload command over the network and actual copy
>>> can be achieved using emulation on the target (hence patch 4).
>>> This results in higher performance and lower network consumption,
>>> as compared to read and write travelling across the network.
>>> With this design of copy-offload/emulation we are able to see the
>>> following improvements as compared to userspace read + write on a
>>> NVMeOF TCP setup:
>>
>> What is the use case of this?   What workloads does raw copies a lot
>> of data inside a single block device?
>>
> 
> The canonical example would be VM provisioning from a master copy.
> That's not within a single block device, mind; that's more for copying 
> the contents of one device to another.

Wouldn't such use case more likely to use file copy ?
I have not heard a lot of cases where VM images occupy an entire block device,
but I may be mistaken here...

> But I wasn't aware that this approach is limited to copying within a 
> single block devices; that would be quite pointless indeed.

Not pointless for any FS doing CoW+Rebalancing of block groups (e.g. btrfs) and
of course GC for FSes on zoned devices. But for this use case, an API allowing
multiple sources and one destination would be better.

-- 
Damien Le Moal
Western Digital Research


