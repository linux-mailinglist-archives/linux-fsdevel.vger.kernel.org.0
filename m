Return-Path: <linux-fsdevel+bounces-74175-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9385BD334E9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 16:49:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C3A9D30250B6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 15:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A99B133B94B;
	Fri, 16 Jan 2026 15:46:59 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3773A26E6F4;
	Fri, 16 Jan 2026 15:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768578419; cv=none; b=W2M7IWd1kjB0YtVs9WfidlYLwdUzrw9X1245tV0zlhRek+zz/QXvK3oTIXsz5kk955Ul6EKQf5dgQ4ztZF/GDj3UCjTPhlI05JlLqOfZnC/hZVL9svLR3Q2hzGPJuft6w7n+HSC2zwNJUV64g9gCvnu4FLhEsD5i9ARc/2oJtU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768578419; c=relaxed/simple;
	bh=ioZGJ9aF3SgmD6kqdlrAN6I3gtXfPAueGiLQaQxCQgU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iwHfCJDof0IDgBQqk8Xh/GZC8ePuTeIn7F/YxgHoxkg+wG8CKC5IciCtqJIayA0yXyqw528ejcFzVoHZCMheXBh9p+ZfhOGPb360HymyJdY/1Cxrc/8gspEE1U3RTnS53/O3ffozejvPD3kQKe/1JEtueujuGWen58IYCKKv88I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 001B3227AA8; Fri, 16 Jan 2026 16:46:54 +0100 (CET)
Date: Fri, 16 Jan 2026 16:46:54 +0100
From: Christoph Hellwig <hch@lst.de>
To: Hongbo Li <lihongbo22@huawei.com>
Cc: hsiangkao@linux.alibaba.com, chao@kernel.org, brauner@kernel.org,
	djwong@kernel.org, amir73il@gmail.com, hch@lst.de,
	linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v15 9/9] erofs: implement .fadvise for page cache share
Message-ID: <20260116154654.GD21174@lst.de>
References: <20260116095550.627082-1-lihongbo22@huawei.com> <20260116095550.627082-10-lihongbo22@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260116095550.627082-10-lihongbo22@huawei.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Jan 16, 2026 at 09:55:50AM +0000, Hongbo Li wrote:
> +static int erofs_ishare_fadvise(struct file *file, loff_t offset,
> +				      loff_t len, int advice)
> +{
> +	return vfs_fadvise((struct file *)file->private_data,
> +			   offset, len, advice);

No need to cast a void pointer.


