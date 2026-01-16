Return-Path: <linux-fsdevel+bounces-74174-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A29B1D33513
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 16:50:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8FA7730A1327
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 15:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB7BA3126C0;
	Fri, 16 Jan 2026 15:46:29 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A02D230D0F;
	Fri, 16 Jan 2026 15:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768578389; cv=none; b=KjgQ6lFREzIlJDTdL6+NpLV+EqrcfRipwxgL+4RfzBxp7oSzx00V1zDUJWa197CBKbS0noADwZXArqQcOB/vik2WeXXm0+7VeJE0mOIHyrEzpuKy70kR+33WEM4R6hXUpUs6HTE6xqLfR1MW0DjsBp9o1BWM5K9mdXFcxjEVfmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768578389; c=relaxed/simple;
	bh=dpRy89BxEd+YQ6yREa+lpDXvh1sYzvOPvZSXJlX38Ag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cR0ntchXMqJkxhr88i6V9eRLdH2gqwFih9/v1UkJRw4IEoYx7BzHfeUmpZlpRzUZihpL3TsrQJbIw1piwTSSPHXJdZ9oNkN2KLRcX8YueN/ciyZNGGKST3AhCecW499sqbiTkul37sW9HcGBhSqzsDhG2wTALXKM5DDC1FPOf0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id E123B227AA8; Fri, 16 Jan 2026 16:46:23 +0100 (CET)
Date: Fri, 16 Jan 2026 16:46:23 +0100
From: Christoph Hellwig <hch@lst.de>
To: Hongbo Li <lihongbo22@huawei.com>
Cc: hsiangkao@linux.alibaba.com, chao@kernel.org, brauner@kernel.org,
	djwong@kernel.org, amir73il@gmail.com, hch@lst.de,
	linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v15 5/9] erofs: introduce the page cache share feature
Message-ID: <20260116154623.GC21174@lst.de>
References: <20260116095550.627082-1-lihongbo22@huawei.com> <20260116095550.627082-6-lihongbo22@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260116095550.627082-6-lihongbo22@huawei.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

I don't really understand the fingerprint idea.  Files with the
same content will point to the same physical disk blocks, so that
should be a much better indicator than a finger print?  Also how does
the fingerprint guarantee uniqueness?  Is it a cryptographically
secure hash?  In here it just seems like an opaque blob.

> +static inline int erofs_inode_set_aops(struct inode *inode,
> +				       struct inode *realinode, bool no_fscache)

Factoring this out first would be a nice little prep patch.
Also it would probably be much cleaner using IS_ENABLED.

> +static int erofs_ishare_file_open(struct inode *inode, struct file *file)
> +{
> +	struct inode *sharedinode = EROFS_I(inode)->sharedinode;

Ok, it looks like this allocates a separate backing file and inode.


