Return-Path: <linux-fsdevel+bounces-31326-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E71AA99497B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2024 14:24:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BE371F21D19
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2024 12:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D33B1DF26C;
	Tue,  8 Oct 2024 12:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="wMKZSAVf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C4FF1DE898;
	Tue,  8 Oct 2024 12:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728390185; cv=none; b=jU2K/QA8BgcrNuHiTx8RkjwWHAIgoVfQdDumxMkQBDUD0u8h2UdHHKglAWLZDKUNu9GdzrsUgeH/gfRAPWZydjv4z5XMF43zkQaPWBstgZXWvOusKNrVPEk2xu1kH+522l9OWKW8kooyRHfT/hT5S2osxly2vpVCFzAYR6/HVMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728390185; c=relaxed/simple;
	bh=oaTW+3j9yeNvgxRODXAtsCJmY5aEpjsfkgrxoSXjr3s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m49G4TDVBGh9ab9e/Mc88wKsEZS3TEvfzr/4IzyCHcjaMW/u5jsLQyMVcGz+G8HVMv962H7ajA/yGN/OH9An/NowIq4pTHTWqQgvuz8/tJ4lY5SBzLZvFPYWUFR5fB4RD83fptx3XgS5RveXklks1d2WqGdcCAZIJQQHJPKv7XU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=wMKZSAVf; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=uOucjaDDLBn6pVXhclYDmS9P5w8KdiUT3z9VmKsnsyQ=; b=wMKZSAVfys5mDit4w+XYZVptdZ
	VHuD8UX6YphYoaj4wONU+VkGn/uHro6xXS9tDHvoOb9jxAZGITTnXTkE92vsJSoRenRILUcvJFgNt
	x+LoxUzeaVrgezrIxXja1V+DfKYd+l/n83Y/LbXDPsrlHYF6qBlRBta7zDiM/XjLHQ5nnEnH5JjJn
	lS4s0H1WM7m1PVVZ908mMJa7X12JY7D9jaoUfhcX+erKtdvH+qkrqrvlHaJUHnVUjx231GTwJWlO8
	Z0WZ/r7NAOEgym1ntfuv1v+10mCVRVDwLo5mhSnNmbUOVhx+vD4pyMxDg+8jSOcWI/VxZ88HSWQoM
	/jEEikcg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sy9Ey-00000005nM4-1f73;
	Tue, 08 Oct 2024 12:23:00 +0000
Date: Tue, 8 Oct 2024 05:23:00 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	Allison Karlitskaya <allison.karlitskaya@redhat.com>,
	Chao Yu <chao@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org
Subject: Re: [PATCH 1/2] fs/super.c: introduce get_tree_bdev_by_dev()
Message-ID: <ZwUkJEtwIpUA4qMz@infradead.org>
References: <20241008095606.990466-1-hsiangkao@linux.alibaba.com>
 <ZwUcT0qUp2DKOCS3@infradead.org>
 <34cbdb0b-28f4-4408-83b1-198f55427b5c@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <34cbdb0b-28f4-4408-83b1-198f55427b5c@linux.alibaba.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Oct 08, 2024 at 08:10:45PM +0800, Gao Xiang wrote:
> But the error message out of get_tree_bdev() is inflexible and
> IMHO it's too coupled to `fc->source`.
> 
> > Otherwise just passing a quiet flag of some form feels like a much
> > saner interface.
> 
> I'm fine with this way, but that will be a treewide change, I
> will send out a version with a flag later.

I'd probably just add a get_tree_bdev_flags and pass 0 flags from
get_tree_bdev.


