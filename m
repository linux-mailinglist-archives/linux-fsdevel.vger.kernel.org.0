Return-Path: <linux-fsdevel+bounces-46061-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A44E5A8222D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Apr 2025 12:32:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 970301BA5BAD
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Apr 2025 10:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C82B825DAE8;
	Wed,  9 Apr 2025 10:31:59 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EABF1DDC23;
	Wed,  9 Apr 2025 10:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744194719; cv=none; b=JHnZF+BuyWoA8r/pwPALvTrWOb4TvDlk5QgeBcJzHq92Myh1tKtjedTrvSVoWutD10UUyuVf46rM3vC4XPcuC4ww4mEXTUGUgXEGFkt8F1N/p380WepZp6gwNloKvYH82FmySdLPclrWt+Ce/5hJX60eCLxbrluCyofFQ+t2x4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744194719; c=relaxed/simple;
	bh=Cup2omxbIn9Mcn/SeiY1fFGTnuLvFypmMrtA0yKrEqg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jmwHhbWW+bbIMqY/R1nNyNvD7ynJF11H8Mcv996tu6cH00PDLWMHTxApkO2mEvd0Me7my35Gz9x7nzfTXUNngdMkXOe8O5SATu6T1ukdX3FILdMa9cCFQ6zOwqP50hiabRsF29rQOziPGZya20Fz5ZIvUZnYtY6queC8N5pnTNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7E1E268CFE; Wed,  9 Apr 2025 12:31:48 +0200 (CEST)
Date: Wed, 9 Apr 2025 12:31:48 +0200
From: Christoph Hellwig <hch@lst.de>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-block@vger.kernel.org, dm-devel@lists.linux.dev,
	linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org, hch@lst.de,
	tytso@mit.edu, djwong@kernel.org, john.g.garry@oracle.com,
	bmarzins@redhat.com, chaitanyak@nvidia.com,
	shinichiro.kawasaki@wdc.com, yi.zhang@huawei.com,
	chengzhihao1@huawei.com, yukuai3@huawei.com, yangerkun@huawei.com
Subject: Re: [RFC PATCH -next v3 01/10] block: introduce
 BLK_FEAT_WRITE_ZEROES_UNMAP to queue limits features
Message-ID: <20250409103148.GA4950@lst.de>
References: <20250318073545.3518707-1-yi.zhang@huaweicloud.com> <20250318073545.3518707-2-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318073545.3518707-2-yi.zhang@huaweicloud.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Mar 18, 2025 at 03:35:36PM +0800, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> Currently, disks primarily implement the write zeroes command (aka
> REQ_OP_WRITE_ZEROES) through two mechanisms: the first involves
> physically writing zeros to the disk media (e.g., HDDs), while the
> second performs an unmap operation on the logical blocks, effectively
> putting them into a deallocated state (e.g., SSDs). The first method is
> generally slow, while the second method is typically very fast.
> 
> For example, on certain NVMe SSDs that support NVME_NS_DEAC, submitting
> REQ_OP_WRITE_ZEROES requests with the NVME_WZ_DEAC bit can accelerate
> the write zeros operation by placing disk blocks into

Note that this is a can, not a must.  The NVMe definition of Write
Zeroes is unfortunately pretty stupid.

> +		[RO] Devices that explicitly support the unmap write zeroes
> +		operation in which a single write zeroes request with the unmap
> +		bit set to zero out the range of contiguous blocks on storage
> +		by freeing blocks, rather than writing physical zeroes to the
> +		media.

This is not actually guaranteed for nvme or scsi.


