Return-Path: <linux-fsdevel+bounces-14782-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E3F087F429
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Mar 2024 00:39:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F880B22A86
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Mar 2024 23:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F453626D5;
	Mon, 18 Mar 2024 23:35:25 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A501A626BC;
	Mon, 18 Mar 2024 23:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710804924; cv=none; b=QOs86vHu2zNHo0hJPkXUKLT6iCEji9Zt/MI1L3WyOBDf17zcJgOFldf+fVoupI1y12NRiqpvlEzBxoW5bVZrR94RY2LsmrHRtX2DzJqJ8C9iFUZgdJAJ6Ij1S5tKvTEnaXc4Q+VmY75Qi/fuGQQrISoEAdAuXJ3Q4RP6SjM1fHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710804924; c=relaxed/simple;
	bh=p7qM0iAaddZW/6udQz75AYjb5Mrw3uNz9HTax7Z+4Xo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ccuqSVGKfIXrEkTWAwGYBPBbdHmOi9MFCwj3OFeh4E3jhe34AEGIuxINBoM9RvAzBo2WQPD8UsONzr/gNXJFKJi7o9mnXIBoq2daIdgeJRq0JyQypFcFDO3WTgs5AaFH3bsZKW2fkCnUFeI2jpAeiHRvasDtTc2TJQmX1vykqec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id AF0A168CFE; Tue, 19 Mar 2024 00:35:17 +0100 (CET)
Date: Tue, 19 Mar 2024 00:35:17 +0100
From: Christoph Hellwig <hch@lst.de>
To: Christian Brauner <brauner@kernel.org>
Cc: Yu Kuai <yukuai1@huaweicloud.com>, Christoph Hellwig <hch@lst.de>,
	jack@suse.cz, axboe@kernel.dk, linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org, yi.zhang@huawei.com,
	yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [RFC v4 linux-next 19/19] fs & block: remove bdev->bd_inode
Message-ID: <20240318233517.GA17983@lst.de>
References: <20240222124555.2049140-1-yukuai1@huaweicloud.com> <20240222124555.2049140-20-yukuai1@huaweicloud.com> <20240317213847.GD10665@lst.de> <022204e6-c387-b4b2-5982-970fd1ed5b5b@huaweicloud.com> <20240318013208.GA23711@lst.de> <5c231b60-a2bf-383e-e641-371e7e57da67@huaweicloud.com> <ea4774db-188e-6744-6a5b-0096f6206112@huaweicloud.com> <20240318-umwirbt-fotowettbewerb-63176f9d75f3@brauner> <20240318-fassen-xylofon-1d50d573a196@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240318-fassen-xylofon-1d50d573a196@brauner>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Mar 18, 2024 at 11:29:17AM +0100, Christian Brauner wrote:
> Don't forget:
> 
> mknod /my/xfs/file/system b 8 0
> 
> which means you're not opening it via devtmpfs but via xfs. IOW, the
> inode for that file is from xfs.

Yes.  file_inode() for block devices is always the "upper" fs, which can
be any file system supporting device nodes.  file->f_mapping->host will
always be the bdevfs inode, and nothing in the I/O path should ever be
using file_inode().

