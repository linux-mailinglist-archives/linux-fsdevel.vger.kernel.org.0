Return-Path: <linux-fsdevel+bounces-23168-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D73CA927EB8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jul 2024 23:43:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 887381F22F34
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jul 2024 21:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F7AD143C6A;
	Thu,  4 Jul 2024 21:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="VV2WdGEH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B359139597;
	Thu,  4 Jul 2024 21:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720129395; cv=none; b=rHr9PMFRBo1Xhpy2DVTSZs0kzapXLJ9vuFQesxPC9ib2Q5pyYFuZL3HaFY/34p5o5YcM0peWeHAqcvNhlxpP9ZuRWLQTsFufbvkWa5QmWZK/6Pw058GW4ACBFlsDfvFBK3YOvYrfI5q/A1LmuptOwSNCvblclRxqVKetmmCm85Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720129395; c=relaxed/simple;
	bh=ORCTI28kcPZ+T9WFEjn8Gmk6DoOOg52mkX8tCVjAOBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rJ4xVe5VbGFaN5vCpEs6UkihpSZQZsXWfWzMz+r0nqUN4ndCaHxsaCpZvJ+eCT4rqxyYSpUg5c2VbBltYt7IUyiitr3nabYtgcJaxQdl2mtW93a5i9RsitoUs9S915gkw3EU/WyeNG6zmbyErv1LtYAHi9pIfZtySMiJL8FN+t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=VV2WdGEH; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4WFVWL1p6nz9sWV;
	Thu,  4 Jul 2024 23:43:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1720129390;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+asQs8BiTWsATZC/YS+ImJyYz4Vi8EoYIPY31Z46OSw=;
	b=VV2WdGEH7qVfiVhz32vHVD8dJTipxZhRc3rPzoump8dE2q+x/ihJfX1wBIGq66FKLMiGG7
	pPUvXiZysoxXo8HIV6yo8hL48r9RyZMzmq6hIllgxrcp61lInVVOdINGxjilcW0h3UTKNT
	EadDAz0EPFK3V3pqkEyEqG4UJG5ipWuaxOOVRSXxHZ/QwRdPwaBsslSNEb8qkAwQQ+BKal
	wDUBK4Pe5gNOPY3C8nQV10eORKdRG4fovKHn5GnszK7CxwrCLJTLvbgjTUqsAnYVFtu6oY
	18ASEHsK4hkvVnPU8XNjyur0aQx9fdPkf6ahJa88s9XB4u8VfdtyznQJXx/AdA==
Date: Thu, 4 Jul 2024 21:43:07 +0000
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: Mikulas Patocka <mpatocka@redhat.com>
Cc: Li Dong <lidong@vivo.com>, Damien Le Moal <dlemoal@kernel.org>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	Johannes Thumshirn <jth@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>,
	"open list:DEVICE-MAPPER  (LVM)" <dm-devel@lists.linux.dev>,
	open list <linux-kernel@vger.kernel.org>,
	opensource.kernel@vivo.com, linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org
Subject: Re: Non-power-of-2 zone size (was: [PATCH] dm-table:fix zone
 block_device not aligned with zonesize)
Message-ID: <20240704214307.kyxivjkvshcqggt6@quentin>
References: <20240704151549.1365-1-lidong@vivo.com>
 <cd05398-cffa-f4ca-2ac3-74433be2316c@redhat.com>
 <c4ee654e-3120-e1a9-80b6-cb7073aa5c1a@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c4ee654e-3120-e1a9-80b6-cb7073aa5c1a@redhat.com>

> I grepped the kernel for bdev_zone_sectors and there are more assumptions 
> that bdev_zone_sectors is a power of 2.
> 
> drivers/md/dm-zone.c:           sector_t mask = bdev_zone_sectors(disk->part0) - 1
> drivers/nvme/target/zns.c:      if (get_capacity(bd_disk) & (bdev_zone_sectors(ns->bdev) - 1))
> drivers/nvme/target/zns.c:      if (sect & (bdev_zone_sectors(req->ns->bdev) - 1)) {
> fs/zonefs/super.c:      sbi->s_zone_sectors_shift = ilog2(bdev_zone_sectors(sb->s_bdev));
> fs/btrfs/zoned.c:       return (sector_t)zone_number << ilog2(bdev_zone_sectors(bdev));
> fs/btrfs/zoned.c:	zone_info->zone_size_shift = ilog2(zone_info->zone_size);
> include/linux/blkdev.h: return sector & (bdev_zone_sectors(bdev) - 1);
> fs/f2fs/super.c:	if (nr_sectors & (zone_sectors - 1))
> 
> So, if we want to support non-power-of-2 zone size, we need some 
> systematic fix. Now it appears that Linux doesn't even attempt to support 
> disks non-power-of-2 zone size.

FYI, I sent the patches to add non-power-of-2 zone size support to the
block layer [0] a long time back. Sadly, it was not finally merged upstream.
Android wanted this support, so for now it is in the Android tree.

-- 
Pankaj Raghav

[0] https://lore.kernel.org/linux-block/20220923173618.6899-1-p.raghav@samsung.com/

