Return-Path: <linux-fsdevel+bounces-20622-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E942F8D6307
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 May 2024 15:31:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A153C2892B4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 May 2024 13:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AD24158DAA;
	Fri, 31 May 2024 13:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="F9IakoLu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C22833CF1;
	Fri, 31 May 2024 13:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717162300; cv=none; b=h6zhatydowizK41bYsZQGN5i3wS376LFP0nVXvLNGNe/8yaZPZfrYLBWB8jAuQ5OSgjDRmbPalqoUDi7nlj5zKiSJyrx8CKv9jLYcUbia3YwAK/IoCXlapxUXb7AI0odOJhX1U01fKVKGHST8vZvI1dD4EMAlu+8KR5K+4efRpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717162300; c=relaxed/simple;
	bh=TkIEk5wzeceT/BFmLNrFp8yBH9ZXT5OYIGMv9WzP9kU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=htT2fdL2m4XnHW+g07gyl6M9obtODFgm6cieIhhXDQ8offiFYWs85g8C9m/w4WeOdtTD8axK0daSpALU93L+IJjIEeumCbLhKFVd5ApgTez21Yfysn36oG1Gt3X3v8XocymyZBk2l7umQvlZWttOcaL86Dn/DbWqDj2bZ9iDMIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=F9IakoLu; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ZnYJekxqs+YixkIAFqhWnZz9hWHwrTGHYqUHWnP5PR8=; b=F9IakoLuCEZorXEUpiAIFC9CTn
	OnQjknl1sgjgBHHW9/ahaYXquglI747gvuJWW/ZfHvmXSAWT0XrzsOvFK4Njs//5kxtCApNarBLxE
	5JirlPwAXPmYC7ESlz8PPDMNu7s0zlAK1v39qGhGfrYsyCRwDCjsXW/q31u9K8uwOry5XDoQbsrvx
	fzdl5mnhnux0J53XUutmnMkDb4gmAPnVavJbhDFs3bKlj0KtndGxP3UBm7BaGXftbNtFH2ibwcVBS
	WLM9J32lo3mnyvt7VyoIzovD7V0Qk6zib3UV+SlOTW26wjhm6jN5KCCTwX4j2CVjfMhb8yuOaKtFw
	fDT19pUQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sD2M4-0000000ALq6-1jvw;
	Fri, 31 May 2024 13:31:36 +0000
Date: Fri, 31 May 2024 06:31:36 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, djwong@kernel.org, hch@infradead.org,
	brauner@kernel.org, david@fromorbit.com, chandanbabu@kernel.org,
	jack@suse.cz, willy@infradead.org, yi.zhang@huawei.com,
	chengzhihao1@huawei.com, yukuai3@huawei.com
Subject: Re: [RFC PATCH v4 5/8] xfs: refactor the truncating order
Message-ID: <ZlnRODP_b8bhXOEE@infradead.org>
References: <20240529095206.2568162-1-yi.zhang@huaweicloud.com>
 <20240529095206.2568162-6-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240529095206.2568162-6-yi.zhang@huaweicloud.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

> +	write_back = newsize > ip->i_disk_size && oldsize != ip->i_disk_size;

Maybe need_writeback would be a better name for the variable?  Also no
need to initialize it to false at declaration time if it is
unconditionally set here.

> +		/*
> +		 * Updating i_size after writing back to make sure the zeroed
> +		 * blocks could been written out, and drop all the page cache
> +		 * range that beyond blocksize aligned new EOF block.
> +		 *
> +		 * We've already locked out new page faults, so now we can
> +		 * safely remove pages from the page cache knowing they won't
> +		 * get refaulted until we drop the XFS_MMAP_EXCL lock after the
> +		 * extent manipulations are complete.
> +		 */
> +		i_size_write(inode, newsize);
> +		truncate_pagecache(inode, roundup_64(newsize, blocksize));

Any reason this open codes truncate_setsize()?


