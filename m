Return-Path: <linux-fsdevel+bounces-22916-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C9C891F04A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jul 2024 09:34:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 570A0284EB6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jul 2024 07:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 867B2143727;
	Tue,  2 Jul 2024 07:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dm983W0E"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78536130487;
	Tue,  2 Jul 2024 07:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719905647; cv=none; b=dN7eWF+hHS8yaSYVROJwsM+s2DbImL1xFsz8gcJLwfUBaQ6iBj5k3RekWE8tUz48X5DEtkIrC7EDTU9i48OhhQzw3hVQ2KKtxuvSqxaViazltDRzwe69JPDcOQ8f4HG2pHkY6RC0gmeDuUuZUZpr4AwnViggfw+wBjQG5xJDvVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719905647; c=relaxed/simple;
	bh=lA80AihC2eqTMmimgkJN1h68e1M+V+/njypX+oT5/ds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FtjRg4ZAxczZa2T2gkAJ9oqf2IhKjy5e0dnXFZ1X38awXTB0aB1BRkmFeX70+GEF0HRcqsb4//DDtDj0tddF/o5e7KyGryPvqkWlWdCzhISlWlHBr/Xk4Daypw+vM5Bmeu2Zn+JCXzPRvY/uIzpk/y/xTVDw2A/40gStoyQ0YLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=dm983W0E; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=OzDUA4LrKNelvvsq9HHXvMDITh/bxFk1FZFMFL1EbZ4=; b=dm983W0EMoSrZuYM4RGD/m4lo5
	uFVyGbtwzQFgeBUhCEMg4kAJlTt16PlXY0ctrCgu3qQYGuylcv7uxpuvm4E71DhXlNrQHChAFeKGg
	NhxQ4MZskhWNK3i8PdWOp1j9LbkLvLREgLwrgRyuQ8/b+6FeDX3Af22WBOlt90Wt0rkkhppMKkByS
	D6uWUV8uPx+IgJxye8mlRIeS7qtYU25uPCS2TO2fiIl1fMOIBkMoIZIKkSZV+LekzHl33Z4HSeoKC
	+VBarxoVgKjKSIu5ep5IetNbm+H1yD6EEAtOKc+gObU18sSoz41bq2UuGp7ty+YS9D0HkwSo5wsFq
	ZdvRJi0A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOY1b-00000005sVe-38ce;
	Tue, 02 Jul 2024 07:34:03 +0000
Date: Tue, 2 Jul 2024 00:34:03 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Dave Chinner <david@fromorbit.com>
Cc: Zhang Yi <yi.zhang@huaweicloud.com>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	djwong@kernel.org, hch@infradead.org, brauner@kernel.org,
	chandanbabu@kernel.org, John Garry <john.g.garry@oracle.com>,
	jack@suse.cz, yi.zhang@huawei.com, chengzhihao1@huawei.com,
	yukuai3@huawei.com
Subject: Re: [PATCH -next v6 1/2] xfs: reserve blocks for truncating large
 realtime inode
Message-ID: <ZoOta_ot6UNvB6i5@infradead.org>
References: <20240618142112.1315279-1-yi.zhang@huaweicloud.com>
 <20240618142112.1315279-2-yi.zhang@huaweicloud.com>
 <ZoIDVHaS8xjha1mA@dread.disaster.area>
 <b27977d3-3764-886d-7067-483cea203fbe@huaweicloud.com>
 <ZoKie9aZV0sHIbA8@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZoKie9aZV0sHIbA8@dread.disaster.area>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Jul 01, 2024 at 10:35:07PM +1000, Dave Chinner wrote:
> Sorry, but I don't really care what either John or Christoph say on
> this matter: xfs_inode_has_bigrtalloc() is recently introduced
> technical debt that should not be propagated further.

So send a patch to fix it.

> xfs_inode_has_bigrtalloc() needs to be replaced completely with
> xfs_inode_alloc_unitsize() and any conditional behaviour needed can
> be based on the return value from xfs_inode_alloc_unitsize(). That
> works for everything that has an allocation block size larger than
> one filesystem block, not just one specific RT case.

Only assuming we actually get these larger alloc sizes.  Which right
now we don't have, and to be honest I'm not sure they are a good
idea.  The whole larger alloc size thing has been a massive pain
to deal with, and we'll need good argument for furthering that pain.


