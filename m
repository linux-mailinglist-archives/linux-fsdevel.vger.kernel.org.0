Return-Path: <linux-fsdevel+bounces-15056-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 826518866C8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Mar 2024 07:34:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B437F1C2346B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Mar 2024 06:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 112B6107B6;
	Fri, 22 Mar 2024 06:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="tQvTg7IO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61282FBE4;
	Fri, 22 Mar 2024 06:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711089240; cv=none; b=mpQsZ4k+jHYWT1/ZCmH3j7v90WShYkmapDI8pBZFp79mN5WFZANutyceBB1ApiH//PMduJT89Fe0Vp2EE21YtiJMSyHinZhJBLittqBC14VjF/W0o9wyNROB5qPMiIm51OTsLk8KPBCVxLVjUA2q9o6oL3T5v5nT5WUdco+qQlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711089240; c=relaxed/simple;
	bh=EOZvWjDugJcFimCP04bdjbd5AdrBHZSGq1PB1mX3YvI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WXWjS5VIb9q1rEcUKHCkzatuJjouGjsYD/uaDdcWBN52hq0DYMaeecaKACVsIs+5iFNuMnYc3+j/zUHRQUOrJmRT1IJVp4+6XrBIrfA0daUvYt4x3GRsAzTR6K5RtMUXBmUzvC2cc/Zbk9tnJdMuLo2cBof/vJ/3JevSiZ2pR5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=tQvTg7IO; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=glri/vKotUbrSJNqM39pLtYkb0KC3SQXl8u3YXFujwc=; b=tQvTg7IOdij7qdx5bCpTRs/k6X
	xGcH1sMbYuwVOG3jYHUYkubA9AirkkwNnuTS2qVMobPmdRjM2E8/e8jisefcml11WmB9ZH/JuIbLl
	JT8Y7HoXemOh50+NCN3mQNoAqZkTl+XmQ8JF3BxkkeDi0SJB/T1sn7Teezy9q1A7z5fxldjidMhv5
	UxhmLBKePRP6VBlhJLzH7Sq8EqOETHR4ZaRrKKUkCxeDWJ0FOqGquw+E2SWnZ5k/uf8LpKRX2KQdV
	BR9cKKIUkiJBQto/2bANgTO/n5ofN+sqQBM+pJyofEMTJeLJTbZjMGcCZZLV8HjJdvRFmFiJVVfcq
	9SDDl6ew==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rnYTK-00EKUC-3A;
	Fri, 22 Mar 2024 06:33:47 +0000
Date: Fri, 22 Mar 2024 06:33:46 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: Christoph Hellwig <hch@lst.de>, jack@suse.cz, brauner@kernel.org,
	axboe@kernel.dk, linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org, yi.zhang@huawei.com,
	yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [RFC v4 linux-next 19/19] fs & block: remove bdev->bd_inode
Message-ID: <20240322063346.GB3404528@ZenIV>
References: <20240222124555.2049140-1-yukuai1@huaweicloud.com>
 <20240222124555.2049140-20-yukuai1@huaweicloud.com>
 <20240317213847.GD10665@lst.de>
 <022204e6-c387-b4b2-5982-970fd1ed5b5b@huaweicloud.com>
 <20240318013208.GA23711@lst.de>
 <5c231b60-a2bf-383e-e641-371e7e57da67@huaweicloud.com>
 <ea4774db-188e-6744-6a5b-0096f6206112@huaweicloud.com>
 <20240318232245.GA17831@lst.de>
 <c62dac0e-666f-9cc9-cffe-f3d985029d6a@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c62dac0e-666f-9cc9-cffe-f3d985029d6a@huaweicloud.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Mar 19, 2024 at 04:26:19PM +0800, Yu Kuai wrote:

> +void put_bdev_file(struct block_device *bdev)
> +{
> +       struct file *file = NULL;
> +       struct inode *bd_inode = bdev_inode(bdev);
> +
> +       mutex_lock(&bdev->bd_disk->open_mutex);
> +       file = bd_inode->i_private;
> +
> +       if (!atomic_read(&bdev->bd_openers))
> +               bd_inode->i_private = NULL;
> +
> +       mutex_unlock(&bdev->bd_disk->open_mutex);
> +
> +       fput(file);
> +}

Locking is completely wrong here.  The only thing that protects
->bd_openers is ->open_mutex.  atomic_read() is obviously a red
herring.

Suppose another thread has already opened the same sucker
with bdev_file_open_by_dev().

Now you are doing the same thing, just as the other guy is
getting to bdev_release() call.

The thing is, between your get_bdev_file() and increment of ->bd_openers
(in bdev_open()) there's a window when bdev_release() of the old file
could've gotten all the way through the decrement of ->bd_openers
(to 0, since our increment has not happened yet) and through the
call of put_bdev_file(), which ends up clearing ->i_private.

End result:

* old ->i_private leaked (already grabbed by your get_bdev_file())
* ->bd_openers at 1 (after your bdev_open() gets through)
* ->i_private left NULL.

Christoph, could we please get rid of that atomic_t nonsense?
It only confuses people into brainos like that.  It really
needs ->open_mutex for any kind of atomicity.

