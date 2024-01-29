Return-Path: <linux-fsdevel+bounces-9410-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED107840B1F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 17:17:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A978228294D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 16:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD881155A52;
	Mon, 29 Jan 2024 16:17:19 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA002155A36;
	Mon, 29 Jan 2024 16:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706545039; cv=none; b=h2UoP9mseamGw6YPWwbiKMD4ZQSHeBloSZAXaZpfuDwB6Xp43S23Qcff03+zQNfyZSM8eMNHpaFzxexJTfLUHkCrh0purqLnpixP2qnX1E0S+uNeNt6LHmWTz7FD6oXWDE+q+iMbF4MUGmt6XvTRQ7oXNjFNoerpYEuAj7ANbq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706545039; c=relaxed/simple;
	bh=m7qmhTHYUhHopLfPvCBmOjswa9s0snKADpcc4FrVcGs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UxyI1VlQK+ROWhJo+146nwVxCDWv99x1ziisPQQFLdPXBIXhe+F25Ozg25RD/UOgia43UxcVw0LBl00Iu8bTV43I0ebili7SvxvmvsvadbkGqPoQd72aR2eIzS3kq3KgHsDbRrfIgLcR916UUUpO0YxrgjUBMr1qgXtK4osoGUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id D6A0E68C4E; Mon, 29 Jan 2024 17:17:14 +0100 (CET)
Date: Mon, 29 Jan 2024 17:17:14 +0100
From: Christoph Hellwig <hch@lst.de>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>, "Darrick J. Wong" <djwong@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH v2 07/34] xfs: port block device access to files
Message-ID: <20240129161714.GF3416@lst.de>
References: <20240123-vfs-bdev-file-v2-0-adbd023e19cc@kernel.org> <20240123-vfs-bdev-file-v2-7-adbd023e19cc@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240123-vfs-bdev-file-v2-7-adbd023e19cc@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

>  	if (mp->m_rtname) {
> -		error = xfs_blkdev_get(mp, mp->m_rtname, &rtdev_handle);
> +		error = xfs_blkdev_get(mp, mp->m_rtname, &rtdev_file);
>  		if (error)
>  			goto out_close_logdev;
>  
> -		if (rtdev_handle->bdev == ddev ||
> -		    (logdev_handle &&
> -		     rtdev_handle->bdev == logdev_handle->bdev)) {
> +		if (file_bdev(rtdev_file) == ddev ||
> +		    (logdev_file && file_bdev(rtdev_file) == file_bdev(logdev_file))) {

Please avoid the overly long line here.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

(note that this will probably have some not too bad merge conflict
with in-flight xfs work)

