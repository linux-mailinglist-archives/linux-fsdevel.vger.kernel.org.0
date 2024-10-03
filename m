Return-Path: <linux-fsdevel+bounces-30835-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0666698EA35
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Oct 2024 09:15:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEF321F22E51
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Oct 2024 07:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CB2984D12;
	Thu,  3 Oct 2024 07:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="k3tgUSMz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A68B21DFFC;
	Thu,  3 Oct 2024 07:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727939699; cv=none; b=uIpy4bUzsYYUai78cEohmrFsKaYiwJmSwxG9RWBGsHB/n8GpxyMZzQZkykSHNHzcdH+amIekvWMDiOd2m8Uc7IivD8Tkh3/NuIIZrxacGhREYN777HLw2EFPjWl0FaGd69ICuB/rLQZbEKdL6/5d4jEAcLIH7x/A5gQgrvAsQE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727939699; c=relaxed/simple;
	bh=3IsYUYYCGGJLE/p57mgakmSo12ZICbAhO/as9vkzV4U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j4U2gzOiRkiXq4GFFyZOzLoFhNL1+6dMN2tyaIM4gOhtzVPzV6TiS0y5zIsJJ5SJf3lpvIh2PVxDOKbN4Ag3Qpvp4xUUUlFGmW3pIXTl8yMET2ZXrXVYuDUtsGUpRFtjrs8uJ/TNCr00I2fEpx3TRw71FCXxC5LzqlB+fsxXEEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=k3tgUSMz; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=SgOwfGGb2m3r+Dll0TF2IecmdG0GsiD0yl8k3HWmmYc=; b=k3tgUSMzKxR3CMi2Zj3DXpzjsN
	sgXYDUvNfeiZm4nMxuoLJ6soKD4XEvLtcwnO4tLvZLT4hU+IwNIRgxFTIH65So05T6//IEEQFj1ep
	0iKmdqHgHCdtYMhyxHg5GbCZUvq/UE/6845rqXUkHuf9yBFENwaI276rkPGCptK1ouohYsW/VhZ1d
	+jlZ27N9yLX2mTx1h2Wn0DOdZ/8KXmBaYQd1vru0VSDTdET4NlV79DLQPDqU6salgbwv5yAGajGmI
	TCzdvyacJjStPDVwRPUR3dEyR1bkLT8/YIGvoiiluWHGhqKPp7bp7Y3vckEsU3tvODyv4Cjf2WWYC
	oQzaNLOA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1swG37-00000008N6l-1HRv;
	Thu, 03 Oct 2024 07:14:57 +0000
Date: Thu, 3 Oct 2024 00:14:57 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Dave Chinner <david@fromorbit.com>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-bcachefs@vger.kernel.org, kent.overstreet@linux.dev,
	torvalds@linux-foundation.org
Subject: Re: [PATCH 3/7] vfs: convert vfs inode iterators to
 super_iter_inodes_unsafe()
Message-ID: <Zv5EcaWsFYHhlMaI@infradead.org>
References: <20241002014017.3801899-1-david@fromorbit.com>
 <20241002014017.3801899-4-david@fromorbit.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241002014017.3801899-4-david@fromorbit.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

> diff --git a/block/bdev.c b/block/bdev.c
> index 33f9c4605e3a..b5a362156ca1 100644
> --- a/block/bdev.c
> +++ b/block/bdev.c
> @@ -472,16 +472,28 @@ void bdev_drop(struct block_device *bdev)
>  	iput(BD_INODE(bdev));
>  }
>  
> +static int bdev_pages_count(struct inode *inode, void *data)

This are guaranteed to operate on the bdev superblock, so just
hardcoding the s_inodes list seems fine here as it keeps the code
much simpler.


