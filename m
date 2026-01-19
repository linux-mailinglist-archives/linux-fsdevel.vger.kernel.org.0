Return-Path: <linux-fsdevel+bounces-74384-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 62EBFD39FC8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 08:29:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 674BE300698F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 07:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B144F2F7445;
	Mon, 19 Jan 2026 07:29:36 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F82D2DCF55;
	Mon, 19 Jan 2026 07:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768807776; cv=none; b=cOBx4Yw/QnO4Ooi4lrwPa/GPUjNaAkpGdkxPhGFSPp1wOzMkj8xeQ4TDSmiNB3od+9bVHQM2GPdd8hT2WPHix1oTeciREeN74MeNMtt+RLHtJVa7DpZrT1nC9Gp6NGy8jce/7YiD1ElL7hGUPcGhnR69pDHTngh2oOsugy8PmeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768807776; c=relaxed/simple;
	bh=5vX2pYBl6L3owwiutM8AlYsiccSmpZTBvawvYfh4byc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F3FLd9VIKry5UHi2zOVxxZZSN3KH0Y3NFWtLWXHvB5As/m3UyM2aNoEn3Eo24m4faW8p1GFEG0JCEKkFFqufvV812kAY3knYbt9bPtRJDgSaL49J+Nm4ZcL7S4YsDBnMIoRHooHBL/41WUBOdKNFnD9wzkhUa4DxqHN4+4K2P4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 66950227A88; Mon, 19 Jan 2026 08:29:32 +0100 (CET)
Date: Mon, 19 Jan 2026 08:29:32 +0100
From: Christoph Hellwig <hch@lst.de>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Christoph Hellwig <hch@lst.de>, Hongbo Li <lihongbo22@huawei.com>,
	chao@kernel.org, brauner@kernel.org, djwong@kernel.org,
	amir73il@gmail.com, linux-fsdevel@vger.kernel.org,
	linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v15 5/9] erofs: introduce the page cache share feature
Message-ID: <20260119072932.GB2562@lst.de>
References: <20260116095550.627082-1-lihongbo22@huawei.com> <20260116095550.627082-6-lihongbo22@huawei.com> <20260116154623.GC21174@lst.de> <af1f3ff6-a163-4515-92bf-44c9cf6c92f3@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af1f3ff6-a163-4515-92bf-44c9cf6c92f3@linux.alibaba.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Sat, Jan 17, 2026 at 12:21:16AM +0800, Gao Xiang wrote:
> Hi Christoph,
>
> On 2026/1/16 23:46, Christoph Hellwig wrote:
>> I don't really understand the fingerprint idea.  Files with the
>> same content will point to the same physical disk blocks, so that
>> should be a much better indicator than a finger print?  Also how does
>
> Page cache sharing should apply to different EROFS
> filesystem images on the same machine too, so the
> physical disk block number idea cannot be applied
> to this.

Oh.  That's kinda unexpected and adds another twist to the whole scheme.
So in that case the on-disk data actually is duplicated in each image
and then de-duplicated in memory only?  Ewwww...


