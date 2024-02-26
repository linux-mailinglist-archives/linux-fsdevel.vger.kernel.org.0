Return-Path: <linux-fsdevel+bounces-12810-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87441867673
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 14:26:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8CA01C27793
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 13:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CF8E128379;
	Mon, 26 Feb 2024 13:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eeBcRC4Y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B55D127B61;
	Mon, 26 Feb 2024 13:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708953994; cv=none; b=LrOOH+uCKjxREhGuwtNw3Tsw5d61OhQzI1sB2M2Ik5QODejixeJubBHIrUlLDUEQ5ONbexsOYu4tvYBjam5RSqTdgZ1b85H9+gxSt6MmzKtb/5vFUaSlPEoFyGn/JCQLeIHWgSLjbchxAnBpjvs97A0JYOU+Hr7kADGsvDb7/Wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708953994; c=relaxed/simple;
	bh=rULkbO3lv9VzQqjPXfntDdnRWFC3fHDArj2MtMhmDIM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eBd147tb2zhmuho1XF1XUN20o5RvoiQpmwwh8I+50ASqLwrAx5+eArUdp4cDxw6ieDeTi5MtpCzxiQ72ZY4dRda1KpGQfNX1tLGBtZ6cLCofBmvK1qbruGcqcrgFCA7M79hWrylBsdTeCg8jwZL6jbCLmfyZbnMSESbZXuFpT5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=eeBcRC4Y; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=+cq3hzUEhbXThrvu7ftbcKy0Wd8FG0mI00L77ictR6s=; b=eeBcRC4YHIM1lXSFhfDDRxapuW
	PdGoIztV67c2/pSrO1a13bqEIjN9KeeAornjhwyu+YHYNXvGnwfG9EZ0lM3RtED5g76Xn4S6HaGp4
	aX75OImTQXT7D7NrOVljjlxaCOoqN/Z8MaOQFzULiELU6uFzc0LKf/6xtcHppDdp0XhZSEce2ny0r
	hTVK2GBpe0vdSvJYjEwLmA/zz6MdqV+L//IhNuurwa8vVzs+E36cL3FbWicohSuDTWy87kzTSI1kw
	8zrAPIeBUxYBIVTkuK0HNFpz0sy1crOvU+DW8Q+eExiII0j/vmFCTkZ9Xt2EnFhknLZueT4CEL91L
	IY4m3JwA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1reb02-0000000HFGx-3ek1;
	Mon, 26 Feb 2024 13:26:30 +0000
Date: Mon, 26 Feb 2024 13:26:30 +0000
From: Matthew Wilcox <willy@infradead.org>
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, david@fromorbit.com,
	chandan.babu@oracle.com, akpm@linux-foundation.org,
	mcgrof@kernel.org, ziy@nvidia.com, hare@suse.de, djwong@kernel.org,
	gost.dev@samsung.com, linux-mm@kvack.org,
	Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH 13/13] xfs: enable block size larger than page size
 support
Message-ID: <ZdyRhpViddO9TKDs@casper.infradead.org>
References: <20240226094936.2677493-1-kernel@pankajraghav.com>
 <20240226094936.2677493-14-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240226094936.2677493-14-kernel@pankajraghav.com>

On Mon, Feb 26, 2024 at 10:49:36AM +0100, Pankaj Raghav (Samsung) wrote:
> @@ -1625,16 +1625,10 @@ xfs_fs_fill_super(
>  		goto out_free_sb;
>  	}
>  
> -	/*
> -	 * Until this is fixed only page-sized or smaller data blocks work.
> -	 */
>  	if (mp->m_sb.sb_blocksize > PAGE_SIZE) {
>  		xfs_warn(mp,
> -		"File system with blocksize %d bytes. "
> -		"Only pagesize (%ld) or less will currently work.",
> -				mp->m_sb.sb_blocksize, PAGE_SIZE);
> -		error = -ENOSYS;
> -		goto out_free_sb;
> +"EXPERIMENTAL: Filesystem with Large Block Size (%d bytes) enabled.",
> +			mp->m_sb.sb_blocksize);

WARN seems a little high for this.  xfs_notice() or xfs_info() would
seem more appropriate:

#define KERN_WARNING    KERN_SOH "4"    /* warning conditions */
#define KERN_NOTICE     KERN_SOH "5"    /* normal but significant condition */
#define KERN_INFO       KERN_SOH "6"    /* informational */


