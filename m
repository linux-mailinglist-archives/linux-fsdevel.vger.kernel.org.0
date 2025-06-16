Return-Path: <linux-fsdevel+bounces-51708-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E169EADA7C0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jun 2025 07:39:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A641D188EEB5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jun 2025 05:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D76181DC998;
	Mon, 16 Jun 2025 05:39:09 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F336135947;
	Mon, 16 Jun 2025 05:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750052349; cv=none; b=e58LyCl1K9vOD1xd9YHnfrweQuEjorVFVQ8A8s8cSHhb8tlSeFyskBl3qm+H1JYWoE9BMDi1KjGncCa8cSvEFceCBk3gMGk+Eq50VoQi675WBPkHzBb6aUCkNzkgHkWXIwyibAsaz/lseQPG3kbkcYf6+f1CxCHd9OBJlaR5LHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750052349; c=relaxed/simple;
	bh=STav/yxP0DU2hAiPDTbOJaqsMjK8vZu+DSN1dLJfplU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iBj7pAJ3bQTJ1eUMd5OpW9oaXSaXkagPxahu2I/FpvX6HK90GAMAKtPnDkC7SoX2r9Bp5XEl1SexaaU+FfuYwIVRreD9TI3X5F2bQK3kFQgPxt15tD0FM+1/ckYaeOBxZzwfiIP0LmjcxKQSYVUQM2TG0A277HoS2NLB3G7bkfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2C15E68BFE; Mon, 16 Jun 2025 07:39:02 +0200 (CEST)
Date: Mon, 16 Jun 2025 07:39:01 +0200
From: Christoph Hellwig <hch@lst.de>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: "Darrick J. Wong" <djwong@kernel.org>, Christoph Hellwig <hch@lst.de>,
	linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-block@vger.kernel.org, dm-devel@lists.linux.dev,
	linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	tytso@mit.edu, john.g.garry@oracle.com, bmarzins@redhat.com,
	chaitanyak@nvidia.com, shinichiro.kawasaki@wdc.com,
	brauner@kernel.org, martin.petersen@oracle.com, yi.zhang@huawei.com,
	chengzhihao1@huawei.com, yukuai3@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH 01/10] block: introduce BLK_FEAT_WRITE_ZEROES_UNMAP to
 queue limits features
Message-ID: <20250616053901.GA1533@lst.de>
References: <20250604020850.1304633-2-yi.zhang@huaweicloud.com> <20250611060900.GA4613@lst.de> <343f7f06-9bf6-442f-8e77-0a774203ec3f@huaweicloud.com> <20250612044744.GA12828@lst.de> <41c21e20-5439-4157-ad73-6f133df42d28@huaweicloud.com> <20250612150347.GK6138@frogsfrogsfrogs> <3569a77f-1f38-4764-b1e3-d0075775c7bb@huaweicloud.com> <20250613055630.GA9119@lst.de> <20250613145433.GF6134@frogsfrogsfrogs> <3d749264-6fdd-458f-a3a8-35d2320193b3@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3d749264-6fdd-458f-a3a8-35d2320193b3@huaweicloud.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Sat, Jun 14, 2025 at 12:48:26PM +0800, Zhang Yi wrote:
> >> Maybe we should redo this similar to the other hardware/software interfaces
> >> and have a hw_ limit that is exposed by the driver and re-only in
> >> sysfs, and then the user configurable one without _hw.  Setting it to
> >> zero disables the feature.
> > 
> > Yeah, that fits the /sys/block/foo/queue model better.
> > 
> 
> OK, well. Please let me confirm, are you both suggesting adding
> max_hw_write_zeores_unmap_sectors and max_write_zeroes_unmap_sectors to
> the queue_limits instead of adding BLK_FEAT_WRITE_ZEROES_UNMAP to the
> queue_limits->features. Something like the following.

Yes.

> Besides, we should also rename max_write_zeroes_sectors to
> max_hw_write_zeroes_sectors since it is a hardware limitation reported
> by the driver.  If the device supports unmap write zeroes,
> max_hw_write_zeores_unmap_sectors should be equal to
> max_hw_write_zeroes_sectors, otherwise it should be 0.

We've only done the hw names when we allow and overwrite or cap based
on other values.  So far we've not done any of that to
max_write_zeroes_sectors.


