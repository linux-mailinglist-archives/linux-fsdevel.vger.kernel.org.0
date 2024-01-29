Return-Path: <linux-fsdevel+bounces-9413-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F230840B39
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 17:22:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60E2A1C21B3B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 16:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FCBB156973;
	Mon, 29 Jan 2024 16:22:09 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42CEB155315;
	Mon, 29 Jan 2024 16:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706545328; cv=none; b=Ky961kOoJroAjdug2ekXJV54LwvBPSh41nzQMejLFgFfCbS+MCe17snPSdROxJw6S0c68KooZ51stbTua0CVBv93NjHnhNiTSEkDC/bctBxshhvnXz4LqXaHDt+Sfi0LLNZ7ODAuhiMABVePCmIu5pASmZ1rzJ4imCt96Kp6qFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706545328; c=relaxed/simple;
	bh=zpXRdj/r4Omz6ZXgpKQTiMZYh37PWeL0U+UNtcxXkn0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DZfELjVfOkseoPTRvycQ6vm+0UgPFf640zckiLZITVQkeG5KMHqlYrTXGt6k6yuOJML3HCOGVKLlYJTEDBqzEl2kCUXa2nibwWmZP7ju7e5nonuX0JNC1MF3rC9wU5dFdc9e5BPoqVwrA0S35QqdZF9g42l+1EcmllTufUAKBng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 54F1768C4E; Mon, 29 Jan 2024 17:22:03 +0100 (CET)
Date: Mon, 29 Jan 2024 17:22:03 +0100
From: Christoph Hellwig <hch@lst.de>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>, "Darrick J. Wong" <djwong@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH v2 29/34] bdev: make struct bdev_handle private to the
 block layer
Message-ID: <20240129162203.GI3416@lst.de>
References: <20240123-vfs-bdev-file-v2-0-adbd023e19cc@kernel.org> <20240123-vfs-bdev-file-v2-29-adbd023e19cc@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240123-vfs-bdev-file-v2-29-adbd023e19cc@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

> +	ret = devcgroup_check_permission(
> +		DEVCG_DEV_BLOCK, MAJOR(dev), MINOR(dev),
> +		((mode & BLK_OPEN_READ) ? DEVCG_ACC_READ : 0) |
> +			((mode & BLK_OPEN_WRITE) ? DEVCG_ACC_WRITE : 0));

Somewhat weird formatting here with DEVCG_DEV_BLOCK not on the
same line as the opening brace and the extra indentation after
the |.  I would have expected something like:

	ret = devcgroup_check_permission(DEVCG_DEV_BLOCK,
		MAJOR(dev), MINOR(dev),
		((mode & BLK_OPEN_READ) ? DEVCG_ACC_READ : 0) |
		((mode & BLK_OPEN_WRITE) ? DEVCG_ACC_WRITE : 0));

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

