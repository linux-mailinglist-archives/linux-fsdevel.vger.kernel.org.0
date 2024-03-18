Return-Path: <linux-fsdevel+bounces-14781-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65EDF87F3F8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Mar 2024 00:22:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C4BB1F22C5C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Mar 2024 23:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DA7F5EE6F;
	Mon, 18 Mar 2024 23:22:52 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C295E095;
	Mon, 18 Mar 2024 23:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710804172; cv=none; b=m11bMA6e+vyJmsurDM3Jcv0rR11tFgPxr3fo9Pxl8QUMCRFj69GwY+2AOFPOs0djNi2LXncMg+f9fhVusEvhIaG8ENUC9augefVcGvPjuYkI7jhzBmwe8u7zCtt8TprbG2fbIyqYPjIcsUidaG7aTeRzydLsOM0QCdD5U5niiRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710804172; c=relaxed/simple;
	bh=HX7LG/+liOyF9Yphtpxw/AdVLRbvPxASNf7gfobkwRQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZKyGQmcSxJEmKBDwcAYNFpUIyM2Kmqqdom/7JTzRnzam9D/wgnnpEx9mAlXmZleRb2charNzkUXRFlmTf3LwTY5SlqlxJ5R2EnZ60U8iChalGmZHXSAUi66Kqngn6nzW/fmgWcV6xKq7BHtPnx8umP6FyYQPpRRYnBgmZr4e0iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6364068CFE; Tue, 19 Mar 2024 00:22:45 +0100 (CET)
Date: Tue, 19 Mar 2024 00:22:45 +0100
From: Christoph Hellwig <hch@lst.de>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: Christoph Hellwig <hch@lst.de>, jack@suse.cz, brauner@kernel.org,
	axboe@kernel.dk, linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org, yi.zhang@huawei.com,
	yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [RFC v4 linux-next 19/19] fs & block: remove bdev->bd_inode
Message-ID: <20240318232245.GA17831@lst.de>
References: <20240222124555.2049140-1-yukuai1@huaweicloud.com> <20240222124555.2049140-20-yukuai1@huaweicloud.com> <20240317213847.GD10665@lst.de> <022204e6-c387-b4b2-5982-970fd1ed5b5b@huaweicloud.com> <20240318013208.GA23711@lst.de> <5c231b60-a2bf-383e-e641-371e7e57da67@huaweicloud.com> <ea4774db-188e-6744-6a5b-0096f6206112@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ea4774db-188e-6744-6a5b-0096f6206112@huaweicloud.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Mar 18, 2024 at 03:19:03PM +0800, Yu Kuai wrote:
> I come up with an ideal:
>
> While opening the block_device the first time, store the generated new
> file in "bd_inode->i_private". And release it after the last opener
> close the block_device.
>
> The advantages are:
>  - multiple openers can share the same bdev_file;
>  - raw block device ops can use the bdev_file as well, and there is no
> need to distinguish iomap/buffer_head for raw block_device;
>
> Please let me know what do you think?

That does sound very reasonable to me.


