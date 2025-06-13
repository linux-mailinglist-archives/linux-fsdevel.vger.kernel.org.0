Return-Path: <linux-fsdevel+bounces-51552-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A615AD82CC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jun 2025 07:56:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8EE63AF1F9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jun 2025 05:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 637BB255F52;
	Fri, 13 Jun 2025 05:56:40 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7750924BD02;
	Fri, 13 Jun 2025 05:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749794200; cv=none; b=gQAbIigBw2CgzlYIZaYcSdtDNu4ikQFU8es+B0wdUXH2/Dckz+HNez3ryq+CvITQWCdrsRAbmT0NE5ufGdtrw7d37gj6demuMmLGPCnIjFbh1ABbb5bFtc8+MW+p0CCDUS4y+yZxJE0lyxdJkwywXVfVpsAGVipFOKHXBWngGKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749794200; c=relaxed/simple;
	bh=io5BXOPc4jFBDMuVyRKt3aPppnfyj24wph+x9b0pNhE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZUEwgFeMObg6Wjx4Rq3EBVvZzyHquHAJRXA3I1EmDwCtHgIxf+c1PvbKTA+QKczajGCVWl43izrccJJWy9brXgzQfjunXZUV3XqjsQCaDUlvKl2Gx/lcZrx6lLTWQiB3ZUBsEm7LRLjV8dQhb41Ub0WjN5pq1uh0qK/NxTdHmdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id F3C4268CFE; Fri, 13 Jun 2025 07:56:30 +0200 (CEST)
Date: Fri, 13 Jun 2025 07:56:30 +0200
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
Message-ID: <20250613055630.GA9119@lst.de>
References: <20250604020850.1304633-1-yi.zhang@huaweicloud.com> <20250604020850.1304633-2-yi.zhang@huaweicloud.com> <20250611060900.GA4613@lst.de> <343f7f06-9bf6-442f-8e77-0a774203ec3f@huaweicloud.com> <20250612044744.GA12828@lst.de> <41c21e20-5439-4157-ad73-6f133df42d28@huaweicloud.com> <20250612150347.GK6138@frogsfrogsfrogs> <3569a77f-1f38-4764-b1e3-d0075775c7bb@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3569a77f-1f38-4764-b1e3-d0075775c7bb@huaweicloud.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Jun 13, 2025 at 11:15:41AM +0800, Zhang Yi wrote:
> Yeah, this solution looks good to me. However, we currently have only
> two selections (none and unmap). What if we keep it as is and simply
> hide this interface if BLK_FEAT_WRITE_ZEROES_UNMAP is not set, making
> it visible only when the device supports this feature? Something like
> below:

I really hate having all kinds of different interfaces for configurations.
Maybe we should redo this similar to the other hardware/software interfaces
and have a hw_ limit that is exposed by the driver and re-only in
sysfs, and then the user configurable one without _hw.  Setting it to
zero disables the feature.


