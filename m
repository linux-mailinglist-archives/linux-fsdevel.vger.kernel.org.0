Return-Path: <linux-fsdevel+bounces-20617-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09E4D8D620F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 May 2024 14:42:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B0891C23560
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 May 2024 12:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D76171586F6;
	Fri, 31 May 2024 12:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OGMKFbLI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3532B1E498;
	Fri, 31 May 2024 12:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717159359; cv=none; b=Z+E8Gvd9ANDFqMo7ggsnzTbQB0QE5AN7Obodj+Sdig90FX0UoqjnG6H6yQ7hHnSKh2aloKzvQKPorTQbDM9EmTIun1jKB8wk8AgixPPNZ5j87Dd4zF65E+YwgKazXCdBMFuF5ke40lpC3DhjqhdhuTWlVL0MA7mRbyMxMxIycH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717159359; c=relaxed/simple;
	bh=qTBh2HpM9SAloF1wlUWaGIyEti34WcbewwJilEn4a5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uqy4fy2Eov7dY1zi/lSwdicR9kNjIB/YJiBDMvyDJnIzSAZngaPwsE7rbtz7S6leXvuK2v+xsYOLtX99bivOGdoF1WqNtmayWSQVUggMDqYIwenqom3K6O9OoC1wWqm+jxqolLpxhjptQ3Mwhp+G01kVl4/HUGlxzyhyhpDHCsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=OGMKFbLI; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=PG064AjeQrSESy4LpL2Nyv1xiftbRyDQaqAqFgklnuI=; b=OGMKFbLIoQflKOSrBsT7/12+Nj
	cIhVbEUocTGZ6Oey/QUjOhfM1ozm2dour/2V+UKtcOm/NUF6OXtojXsQnaGmaDWE9opLNXCSU6rTf
	evp5MprXAKSAPHwLEGpXpYcDFsOqd8CWv/BiEI0rkayaq/VnleRyRMAaNvjIjah56UT85I1NehNo/
	bsAiekXOld1RFYVyMb2uyJgXrxSIwHin3+YUbbOxe+wPQ8muw8nX3qqpDHvkGMgnJei5RDhjbTjFw
	iSP3QLH0NEr8QX/vP4X7X6Ng0UewlEHjLhaCfHF86+to9Ty+O+KgDpVJyAq/31FCVjrCqmgr/z7rO
	oaCdQhYQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sD1af-0000000AEip-35Oh;
	Fri, 31 May 2024 12:42:37 +0000
Date: Fri, 31 May 2024 05:42:37 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, djwong@kernel.org, hch@infradead.org,
	brauner@kernel.org, david@fromorbit.com, chandanbabu@kernel.org,
	jack@suse.cz, willy@infradead.org, yi.zhang@huawei.com,
	chengzhihao1@huawei.com, yukuai3@huawei.com
Subject: Re: [RFC PATCH v4 7/8] xfs: reserve blocks for truncating realtime
 inode
Message-ID: <ZlnFvWsvfrR1HBZW@infradead.org>
References: <20240529095206.2568162-1-yi.zhang@huaweicloud.com>
 <20240529095206.2568162-8-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240529095206.2568162-8-yi.zhang@huaweicloud.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

> -	error = xfs_trans_alloc(mp, &M_RES(mp)->tr_itruncate, 0, 0, 0, &tp);
> +	resblks = XFS_IS_REALTIME_INODE(ip) ? XFS_DIOSTRAT_SPACE_RES(mp, 0) : 0;

This probably wants a comment explaining that we need the block
reservation for bmap btree block allocations / splits that can happen
because we can split a written extent into one written and one
unwritten, while for the data fork we'll always just shorten or
remove extents.

I'd also find this more readable if resblks was initialized to 0,
and this became a:

	if (XFS_IS_REALTIME_INODE(ip))
		resblks = XFS_DIOSTRAT_SPACE_RES(mp, 0);


