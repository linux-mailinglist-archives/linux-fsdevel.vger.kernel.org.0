Return-Path: <linux-fsdevel+bounces-51400-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 015D9AD66ED
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 06:48:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 597233AD3B5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 04:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BB201DF75D;
	Thu, 12 Jun 2025 04:47:53 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6027FD;
	Thu, 12 Jun 2025 04:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749703672; cv=none; b=uk5mF5hmMglefp61kYSX8uvBn9ZV2eC0kOHcx3xNCHyKPX/e+cRU5wRa7pKg21zTgbZ33/G6BUYElUoQc14FYQSAv/B6CZsMjdw3PVUD1S0rSxkqTWinNV4DJreg78LX8sccXPQTOcMGRC9TIs7UzCX9xbQHA1iNmHG9yeuv6dI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749703672; c=relaxed/simple;
	bh=eYItOdFLi7G0YIaWAGU9SVXHNxF9FM0zycgn2Pn9pKE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UcoMGTBdvWpK8pAbu0jWo/EAzdT7zseGvt1Q8SLTDTipcI53cFvW8lvlWw+AUvMSuE3tCsqMx6lKlvoJlKIGxmxsdn4K8+VBGV5W3UTzN6qGz3feaVgh2KaR/DPqTSnLNa4mjWV5tr/qNesnWZ1jzRjXQo4AtDmlJJrr9rNmcIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7C82B68D09; Thu, 12 Jun 2025 06:47:44 +0200 (CEST)
Date: Thu, 12 Jun 2025 06:47:44 +0200
From: Christoph Hellwig <hch@lst.de>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-block@vger.kernel.org,
	dm-devel@lists.linux.dev, linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, tytso@mit.edu, djwong@kernel.org,
	john.g.garry@oracle.com, bmarzins@redhat.com, chaitanyak@nvidia.com,
	shinichiro.kawasaki@wdc.com, brauner@kernel.org,
	martin.petersen@oracle.com, yi.zhang@huawei.com,
	chengzhihao1@huawei.com, yukuai3@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH 01/10] block: introduce BLK_FEAT_WRITE_ZEROES_UNMAP to
 queue limits features
Message-ID: <20250612044744.GA12828@lst.de>
References: <20250604020850.1304633-1-yi.zhang@huaweicloud.com> <20250604020850.1304633-2-yi.zhang@huaweicloud.com> <20250611060900.GA4613@lst.de> <343f7f06-9bf6-442f-8e77-0a774203ec3f@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <343f7f06-9bf6-442f-8e77-0a774203ec3f@huaweicloud.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Jun 11, 2025 at 03:31:21PM +0800, Zhang Yi wrote:
> >> +/* supports unmap write zeroes command */
> >> +#define BLK_FEAT_WRITE_ZEROES_UNMAP	((__force blk_features_t)(1u << 17))
> > 
> > 
> > Should this be exposed through sysfs as a read-only value?
> 
> Uh, are you suggesting adding another sysfs interface to expose
> this feature?

That was the idea.  Or do we have another way to report this capability?


