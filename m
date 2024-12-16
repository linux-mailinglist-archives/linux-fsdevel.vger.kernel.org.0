Return-Path: <linux-fsdevel+bounces-37499-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 340C79F3431
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Dec 2024 16:15:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2AD157A1894
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Dec 2024 15:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF4A914884F;
	Mon, 16 Dec 2024 15:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rucnCWFs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D0F21428F1;
	Mon, 16 Dec 2024 15:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734362115; cv=none; b=ARRZpQE27k1SstFdCjU0XaJha5XGwrBMP3f1fLj3ZfZLENv0n5ztTRJOxHmiGKyFdgv3sFlf+2SmLRwwH754KE5R8yNFMdoSF+rbUMIdWqRt+tKRL6j2mOs9R9SfF4LUe17vkAifGN7GX/FgNbE5Dj3Z6HwzgjEB6cXJrwxsLKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734362115; c=relaxed/simple;
	bh=oqn7m++z92YKzLcM7I7BOCOf+zLfx+DeRE9j+vYm4Mg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FMzTk3eL3pEeiOG4Lw1BGYc4+UBM0T7Etgwztc+PvOof5P2zvhoYOGEtOyfzSVxfnZw3q34wpnOeVAbZvyTUvJySYiBmZFdMN75yuJWv3ywPsgzkqZ6sMDa1sNmOLWiNx3fX2qmLmzIv9TyFA8Z5sSGnh+hScIVxh58i3ZaY5Xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=rucnCWFs; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=UAxhW2VS3ciMu90+mJWA3Of57pK38CvimvduuwTMsiQ=; b=rucnCWFs3yNleygejbrbYC7yLF
	QoKqn6iMtUF3avK9eAbl+t+KhAxv5DnXUwpMu3Ckh+ryFjb2gzgm2d1Dn3l4lwHfGb72xPsqczv1a
	DKlg0xrkDGeMGw2zz9bSNWaQb/SEpZ/xGr8wa7DTxhcdlSPEO223Q6BtShsXDwcQOI++2ydjyKadV
	zAf5ZNXfIjPFgj9+j3HsWQF0NrQJmFggjdnutB63OZpXAvMICEZH1ZIrPuIx1DAclVZycZnm9Pgd0
	Peq7Y2fc/pSSj/rW8wMVNwHVRVlzuBxLCK1JyPYF6XPsDqz2lvtHTf/Qy3eNwY7FwxQYVsm3tPUIm
	jh+TIFJQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tNCoP-0000000HNSD-018X;
	Mon, 16 Dec 2024 15:15:09 +0000
Date: Mon, 16 Dec 2024 15:15:08 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, tytso@mit.edu,
	adilger.kernel@dilger.ca, jack@suse.cz, yi.zhang@huawei.com,
	chengzhihao1@huawei.com, yukuai3@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH v4 01/10] ext4: remove writable userspace mappings before
 truncating page cache
Message-ID: <Z2BD_JLfuZ9VVwhQ@casper.infradead.org>
References: <20241216013915.3392419-1-yi.zhang@huaweicloud.com>
 <20241216013915.3392419-2-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241216013915.3392419-2-yi.zhang@huaweicloud.com>

On Mon, Dec 16, 2024 at 09:39:06AM +0800, Zhang Yi wrote:
>  $mkfs.ext4 -b 1024 /dev/vdb
>  $mount /dev/vdb /mnt
>  $xfs_io -t -f -c "pwrite -S 0x58 0 4096" -c "mmap -rw 0 4096" \
>                -c "mwrite -S 0x5a 2048 2048" -c "fzero 2048 2048" \
>                -c "mwrite -S 0x59 2048 2048" -c "close" /mnt/foo
> 
>  $od -Ax -t x1z /mnt/foo
>  000000 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58
>  *
>  000800 59 59 59 59 59 59 59 59 59 59 59 59 59 59 59 59
>  *
>  001000
> 
>  $umount /mnt && mount /dev/vdb /mnt
>  $od -Ax -t x1z /mnt/foo
>  000000 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58
>  *
>  000800 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>  *
>  001000

Can you add this to fstests please so we can be sure other filesystems
don't have the same problem?

