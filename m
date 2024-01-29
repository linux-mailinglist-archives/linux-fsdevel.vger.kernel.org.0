Return-Path: <linux-fsdevel+bounces-9469-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F35D8416D2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jan 2024 00:29:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90F1DB236D0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 23:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DB6B15A487;
	Mon, 29 Jan 2024 23:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HDQpxYG+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B55524B4;
	Mon, 29 Jan 2024 23:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706570841; cv=none; b=JXHipHacMI53H/21U1JoP2zX2pDfemDAGcovXJX8mBbWESo+D9tNFEhXIqotbACjHUZEzRa5ROZaD9BZsrwYpjE63/TARtqd3S/XSMXb91Co61wbitbCgaLJq3On3bL39WtWghPyG12jaIBEohIlkrn8cTlctnzlfjV9s+WeKtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706570841; c=relaxed/simple;
	bh=DWcUvH+PKWSEd4GyAqc2dx7y2J0qGqIrXW/FrQm0G0s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Fqkt+WJ7lOFG+n0N0fk3r4T4xYDpp7sd+6FFZX8JBjHOcYFAXoRVAS1SLu/dCQ3kQroG1kSQy63OuBSNXWFfUcA9K3GPQpYE+/Bc6EqoZNJnkmcJVG5PyBvaSnmHP7nyGNaVZWIrQb7ifQIBaDNllkSa1TIIhX5MWDzoq4Qhfp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HDQpxYG+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56009C433F1;
	Mon, 29 Jan 2024 23:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706570841;
	bh=DWcUvH+PKWSEd4GyAqc2dx7y2J0qGqIrXW/FrQm0G0s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=HDQpxYG+LgbG4d8+cVulHIpQIvwQ4Q/z15d4yrLO8SSy1WWcuWxOKQChKZr4WGFwo
	 0IMQbgiBrOUbZIwRu2uHzLfpLM/fJK8WNdEdy1t/Ki213Ic/4x16lZ/PNdIUi6PON9
	 6kjjUYPRwi/roGjStwOpzyhUME/oPHZUP8yomMiheuYYhS4xv4n39Lk+ocFmJO0Zij
	 nNZ3MS/N9X6IEtIfbwGcHQh5OM8uosJFsnEouxTITskevZA4lr268h1XrxT+4e2t3l
	 o7DiaoiuMC85wSkLqyN3haUeJhrgXLBVILmDj3nDt/keuL/uJzwDzZrIGZEcBnKl3h
	 +ZyBgR48wRN1Q==
Message-ID: <9e787a31-8aa1-48ad-8488-770146475365@kernel.org>
Date: Tue, 30 Jan 2024 08:27:18 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/5] btrfs: zoned: call blkdev_zone_mgmt in nofs scope
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
 <20240128-zonefs_nofs-v3-3-ae3b7c8def61@wdc.com>
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20240128-zonefs_nofs-v3-3-ae3b7c8def61@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/29/24 16:52, Johannes Thumshirn wrote:
> Add a memalloc_nofs scope around all calls to blkdev_zone_mgmt(). This
> allows us to further get rid of the GFP_NOFS argument for
> blkdev_zone_mgmt().
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Looks OK to me.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>


-- 
Damien Le Moal
Western Digital Research


