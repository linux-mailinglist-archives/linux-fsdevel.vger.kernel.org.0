Return-Path: <linux-fsdevel+bounces-48232-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AD03AAC398
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 14:13:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEB163B0EF1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 12:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB68827FB0C;
	Tue,  6 May 2025 12:11:08 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D9B27F738;
	Tue,  6 May 2025 12:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746533468; cv=none; b=oPMRsmqq3Qh0NwB/6LUfCO1nXCilFLLlKHbGVX/zQq4+RGKnsoWBc/IWbM/VfMoLDFLULZ4bzXoEtEAE/U0JO0FFDXygG8BAFPgpY9Sl9iOVDAmoiODd3lboEVGhDmW+okcT0G+rqMHvpgrU2bRYeSqkHVHmfBZ4s/o1Tebp6BQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746533468; c=relaxed/simple;
	bh=Z42DKWzQrGFUA4xxtScwUk/kQFCHLo2DdyxI1glwSG4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q6P1G0E7UpYH5r4bdhsx939M7ilJnZPsLwMp4HO2eMfttzuT3lMVUO5/6LfG/j+Ye5qEzIlfeSKGaDD+qQCHLJxX/tUqGMSgPm61QHAwuj9i0Ir3kQTrUXbTg6IgCoY48I9ND1BL1LXw8jMt8gMwvkJ1Qofyb3x8K9Gh9cRpNkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 27FBC68AA6; Tue,  6 May 2025 14:11:03 +0200 (CEST)
Date: Tue, 6 May 2025 14:11:02 +0200
From: Christoph Hellwig <hch@lst.de>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: Christoph Hellwig <hch@lst.de>, "Darrick J. Wong" <djwong@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-block@vger.kernel.org, dm-devel@lists.linux.dev,
	linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	tytso@mit.edu, john.g.garry@oracle.com, bmarzins@redhat.com,
	chaitanyak@nvidia.com, shinichiro.kawasaki@wdc.com,
	brauner@kernel.org, yi.zhang@huawei.com, chengzhihao1@huawei.com,
	yukuai3@huawei.com, yangerkun@huawei.com
Subject: Re: [RFC PATCH v4 07/11] fs: statx add write zeroes unmap attribute
Message-ID: <20250506121102.GA21905@lst.de>
References: <20250421021509.2366003-1-yi.zhang@huaweicloud.com> <20250421021509.2366003-8-yi.zhang@huaweicloud.com> <20250505132208.GA22182@lst.de> <20250505142945.GJ1035866@frogsfrogsfrogs> <c7d8d0c3-7efa-4ee6-b518-f8b09ec87b73@huaweicloud.com> <20250506043907.GA27061@lst.de> <64c8b62a-83ba-45be-a83e-62b6ad8d6f22@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64c8b62a-83ba-45be-a83e-62b6ad8d6f22@huaweicloud.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, May 06, 2025 at 07:16:56PM +0800, Zhang Yi wrote:
> Sorry, but I don't understand your suggestion. The
> STATX_ATTR_WRITE_ZEROES_UNMAP attribute only indicate whether the bdev
> and the block device that under the specified file support unmap write
> zeroes commoand. It does not reflect whether the bdev and the
> filesystems support FALLOC_FL_WRITE_ZEROES. The implementation of
> FALLOC_FL_WRITE_ZEROES doesn't fully rely on the unmap write zeroes
> commoand now, users simply refer to this attribute flag to determine
> whether to use FALLOC_FL_WRITE_ZEROES when preallocating a file.
> So, STATX_ATTR_WRITE_ZEROES_UNMAP and FALLOC_FL_WRITE_ZEROES doesn't
> have strong relations, why do you suggested to put this into the ext4
> and bdev patches that adding FALLOC_FL_WRITE_ZEROES?

So what is the point of STATX_ATTR_WRITE_ZEROES_UNMAP?


