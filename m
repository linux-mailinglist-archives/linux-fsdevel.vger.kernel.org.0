Return-Path: <linux-fsdevel+bounces-40206-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E990A2049D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jan 2025 07:47:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36F0D3A311A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jan 2025 06:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAA231DDC04;
	Tue, 28 Jan 2025 06:46:30 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC9404A1A;
	Tue, 28 Jan 2025 06:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738046790; cv=none; b=s1uJzGoY3lgEwA7kLpzRbchfezBdxpSvHzEW41zpfaz1Jo3+10x14sVlnxa1tmZN5tY62lAaCAEjm7zkZYDgM7YugETqZ0ZH1lNA2Hg+dQ//RHj9K7TitToSfgl+wUZkhmgH9/PiT+pTkSGt+vNK/goUY7vEi4w4mg6HJ+keBpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738046790; c=relaxed/simple;
	bh=rVnd4OQDVd4OqwxlUo00uQu3kfTHjII4+z4jJBMNvmE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fNhd9Kc7nJK7aUj7QlUgOKkLQBbVqAr/9DRDwc4mqUay0r4j+b0bmxI0TOuRxKNxQg9TpILeDRZuPSbvZvm9P/eDo+XuZh8Kwj/vjNX3CvF3bwJTDt3on8ROsh3Ep+KbZ3hi7cmiKtmBlmyw5261ahpJokXzLbRcmDlt2y66ge0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0FEF168D05; Tue, 28 Jan 2025 07:46:24 +0100 (CET)
Date: Tue, 28 Jan 2025 07:46:23 +0100
From: Christoph Hellwig <hch@lst.de>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-block@vger.kernel.org, dm-devel@lists.linux.dev,
	linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org, hch@lst.de, tytso@mit.edu,
	djwong@kernel.org, yi.zhang@huawei.com, chengzhihao1@huawei.com,
	yukuai3@huawei.com, yangerkun@huawei.com
Subject: Re: [RFC PATCH v2 2/8] nvme: set BLK_FEAT_WRITE_ZEROES_UNMAP if
 device supports DEAC bit
Message-ID: <20250128064623.GB21401@lst.de>
References: <20250115114637.2705887-1-yi.zhang@huaweicloud.com> <20250115114637.2705887-3-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250115114637.2705887-3-yi.zhang@huaweicloud.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

I think you also need to add BLK_FEAT_WRITE_ZEROES_UNMAP to the list
of features supported by the nvme-mpath stacking driver in
nvme_mpath_alloc_disk, so that this gets propagated to multipathed
devices.

Otherwise this looks good to me.


