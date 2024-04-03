Return-Path: <linux-fsdevel+bounces-16084-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2A62897BC4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Apr 2024 00:46:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F15941C23EAE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 22:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40AE015623A;
	Wed,  3 Apr 2024 22:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="t2ncr//f"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF2C01757A;
	Wed,  3 Apr 2024 22:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712184355; cv=none; b=XV0ZlqXRhdSpHd2bUCoC3QzVordKlsrMX68mi6jVa5hqmYJv81sb7VuTMHMomPcCrR/bxWis5DQ5kEqmfZl9aCuGw8UYaMzHS0R5Wu7KqpfmbtPSOy+UkTMK1CuLyHYmqwhjX1kvwA4hAV2N6A37m5KGQ/GO428FbKA5m8LSDQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712184355; c=relaxed/simple;
	bh=Wl13HCQUnod0lTUKQ6DNuqqLHcv1UPBQ6Mocvat/Q3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OrH3uBCPSMVU0Ltm9TKU9jkyIxQHhV4Y0cuZrRrQqRkg3S5vpgWyzsR8A3gE8Em9iaZIZ+kfpGfcGkEQEJHAbkQKiVJz911ZjXkUSLlUWP8xlWS/L4ZnoWdWMP9+RnRuWGBFx4LyxOEYDa2MlNOJ3XWc+Wz4mdvX6JwPMDpwkqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=t2ncr//f; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=zlKZnL7sDm8BDCMejJeZM50ZtuMxH0tQsMbjPb3yHD8=; b=t2ncr//fpGvPtpESJNxRb6/ovo
	c8kDk5LFRDFeqtIIPAWZbXg37VJMBMuLM/WrbBwybND37YVoNxDknuqeN4Xzx4n0yyAeyzIpXpD8n
	aRVrbdxNoGlYBges4TbCTHcW+TYHr5QBZYfmd/uYwq6HaTcmvZlvePB78sLuJFjRgp6/6R0bxL2nF
	QFdzEU0ksQQEYlIl4+vky3ogrI2/xGnyFkZMmoVNm7SiLB5q72L5gfUKSC/wxWD8fSciZFOQJtuYD
	Vzc2GB6F6rX/U93Bbdlsfwg1coD6Hc0w4G9ooDWlpfQe/RkjSnuy3VTFTdUqRruF87O2IGYqfJLC7
	4hfCSTGQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rs9Md-005Bdo-27;
	Wed, 03 Apr 2024 22:45:51 +0000
Date: Wed, 3 Apr 2024 23:45:51 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-fsdevel@vger.kernel.org, brauner@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] userfaultfd: convert to ->read_iter()
Message-ID: <20240403224551.GN538574@ZenIV>
References: <20240403140446.1623931-1-axboe@kernel.dk>
 <20240403140446.1623931-3-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240403140446.1623931-3-axboe@kernel.dk>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Apr 03, 2024 at 08:02:53AM -0600, Jens Axboe wrote:
> -		if (count < sizeof(msg))
> +		if (iov_iter_count(to) < sizeof(msg))
>  			return ret ? ret : -EINVAL;
>  		_ret = userfaultfd_ctx_read(ctx, no_wait, &msg, inode);
>  		if (_ret < 0)
>  			return ret ? ret : _ret;
> -		if (copy_to_user((__u64 __user *) buf, &msg, sizeof(msg)))
> +		_ret = copy_to_iter(&msg, sizeof(msg), to);
> +		if (_ret < 0)
>  			return ret ? ret : -EFAULT;

Take a look in uio.h - you'll see

size_t copy_to_iter(const void *addr, size_t bytes, struct iov_iter *i)

in there.  See the problem?

> +	fd = get_unused_fd_flags(O_RDONLY | (flags & UFFD_SHARED_FCNTL_FLAGS));
> +	if (fd < 0)
> +		goto err_out;

Same comment as for the previous patch.

