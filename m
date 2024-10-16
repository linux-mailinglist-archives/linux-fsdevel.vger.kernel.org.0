Return-Path: <linux-fsdevel+bounces-32102-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63DB99A09CD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2024 14:29:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA9E4B25361
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2024 12:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96CB0208D70;
	Wed, 16 Oct 2024 12:29:27 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD54208201;
	Wed, 16 Oct 2024 12:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729081767; cv=none; b=dwWuBBGwCVK/9Ogyf7K7yoJsfMV6RxZ49fGpNCfru6rvPsouqMgfOcnRegohesu4wtyUT8TJHbkrZ9YoE3JGm5eIoiK7I1cj///m6k6m7oeiw9VOeb15XZM1FPlyBsGOfav/bjVNZGUluL3ZgEYc8EPgS8qIUcqrZIqRFU+U86g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729081767; c=relaxed/simple;
	bh=quJy7OyTVPUJydXzkU5nLlXJrJQIf6Ag65j0Fo9Ug2A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IyGT//N9Vs5V6A04JY9hzsN44Qb76RhYLD6f3Ug0g0uYCx4NF7CHHvJYQ4Zo7QBXhdhcl4Mln+aR7GSuxXcnVjKsToNqhD6gPQH2U6Nj8u8GhX0zQZYb47/bfeS3XM22GNeB4Ms2sotN+obM32oTmZuX0hFfVcKnEwko9fqVkOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 33669227AAE; Wed, 16 Oct 2024 14:29:20 +0200 (CEST)
Date: Wed, 16 Oct 2024 14:29:19 +0200
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: axboe@kernel.dk, brauner@kernel.org, djwong@kernel.org,
	viro@zeniv.linux.org.uk, jack@suse.cz, dchinner@redhat.com,
	hch@lst.de, cem@kernel.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, hare@suse.de,
	martin.petersen@oracle.com, catherine.hoang@oracle.com,
	mcgrof@kernel.org, ritesh.list@gmail.com, ojaswin@linux.ibm.com
Subject: Re: [PATCH v9 3/8] block: Add bdev atomic write limits helpers
Message-ID: <20241016122919.GA18025@lst.de>
References: <20241016100325.3534494-1-john.g.garry@oracle.com> <20241016100325.3534494-4-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241016100325.3534494-4-john.g.garry@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Oct 16, 2024 at 10:03:20AM +0000, John Garry wrote:
> +static inline unsigned int
> +bdev_atomic_write_unit_min_bytes(struct block_device *bdev)
> +{
> +	if (!bdev_can_atomic_write(bdev))
> +		return 0;

Aren't the limits always zero when the block device doesn't support
atomic writes and we can skip these checks?

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


