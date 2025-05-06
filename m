Return-Path: <linux-fsdevel+bounces-48231-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 64E0CAAC37B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 14:11:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DDCA523648
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 12:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A553B27F758;
	Tue,  6 May 2025 12:10:22 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB3DB27F4F6;
	Tue,  6 May 2025 12:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746533422; cv=none; b=VYExxYIDt+1ZZZaejhPF2Dv4gSilaFhXkL+Ye7LKswAAzVG7quMZcNH/9R15uaqOPRsAZ+xwCA9jxglh4wtYNkqOcT/XSnf8l3738cYfihh+4iT9XyBIoAt31ttzlkXVW8MBs4od37YWDCAQQNnflsAaFa5CadLTYyLFHrg9ov4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746533422; c=relaxed/simple;
	bh=zy4zsbjSc/YMSb4tg4xGMGlyXNyP8B5hyhAO1dO8M7g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=osnhMWVMU3cr71UY67AhG1CYR4Cz4+iZzfvNuZMarm50ZBwJGKeVTQhvqQbHTYGbHqUKHjx/lGo9JyO7U61PxEpAxAU+nEmdB4Dz8XMpFT9cMqhMN0KpoTZpxAO7SvckYfhm16KzLaDlXvP0QtiTbVQb0p9eE6EPFWHSY6LekrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 49E8368AA6; Tue,  6 May 2025 14:10:12 +0200 (CEST)
Date: Tue, 6 May 2025 14:10:12 +0200
From: Christoph Hellwig <hch@lst.de>
To: Zhang Yi <yi.zhang@huaweicloud.com>, dhowells@redhat.com,
	brauner@kernel.org
Cc: Christoph Hellwig <hch@lst.de>, "Darrick J. Wong" <djwong@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-block@vger.kernel.org, dm-devel@lists.linux.dev,
	linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	tytso@mit.edu, john.g.garry@oracle.com, bmarzins@redhat.com,
	chaitanyak@nvidia.com, shinichiro.kawasaki@wdc.com,
	yi.zhang@huawei.com, chengzhihao1@huawei.com, yukuai3@huawei.com,
	yangerkun@huawei.com
Subject: Re: [RFC PATCH v4 07/11] fs: statx add write zeroes unmap attribute
Message-ID: <20250506121012.GA21705@lst.de>
References: <20250421021509.2366003-1-yi.zhang@huaweicloud.com> <20250421021509.2366003-8-yi.zhang@huaweicloud.com> <20250505132208.GA22182@lst.de> <20250505142945.GJ1035866@frogsfrogsfrogs> <20250506050239.GA27687@lst.de> <20250506053654.GA25700@frogsfrogsfrogs> <20250506054722.GA28781@lst.de> <c3105509-9d63-4fa2-afaf-5b508ddeeaca@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c3105509-9d63-4fa2-afaf-5b508ddeeaca@huaweicloud.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, May 06, 2025 at 07:25:06PM +0800, Zhang Yi wrote:
> +       if (request_mask & STATX_WRITE_ZEROES_UNMAP &&
> +           bdev_write_zeroes_unmap(bdev))
> +               stat->result_mask |= STATX_WRITE_ZEROES_UNMAP;

That would be my expectation.  But then again this area seems to
confuse me a lot, so maybe we'll get Christian or Dave to chim in.


