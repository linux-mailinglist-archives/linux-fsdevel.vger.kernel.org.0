Return-Path: <linux-fsdevel+bounces-5130-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1ECC808330
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 09:37:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3026B1C21C99
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 08:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91B5D30CE2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 08:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="krkfNWZA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9029710D;
	Wed,  6 Dec 2023 23:47:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=z4F9mXba7tQFHVOT8cGkh5EdqUdPN0Rtt/hd54yhsuc=; b=krkfNWZAhP3Hqm1os41tpMbqjm
	eV6+pyGL0O4Z3WWCx+pT06eUxdvu2j4tSXGOIfjTVkHs5SoNpWuNf0iyJAa8njFd0yQpoB2+DcDU6
	B8+R+BtLKvZ0bP8QQKQvQxfxjtE9JFCkHjxZvbKEeJQskbCjv3smlKyuVpVsY/Eq+KoAjQsv6/IqX
	ozfzkKEoZZeCHQXuIi6DSUwFOZGSljne5pUYQEkTOdeL6HGorjcWKhjquxU2osE1MD8YfAoXuFvUC
	QAkHlYbdAmSVlIOOCngDIDJxRLUuEpSfeG9W3iFcY7liSWdDlU+ooO4FCYIo21oZh8cex0YuTEYF5
	4vSHHScQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rB96H-00C7D3-2w;
	Thu, 07 Dec 2023 07:47:13 +0000
Date: Wed, 6 Dec 2023 23:47:13 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Sergei Shtepa <sergei.shtepa@linux.dev>
Cc: axboe@kernel.dk, hch@infradead.org, corbet@lwn.net, snitzer@kernel.org,
	mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
	viro@zeniv.linux.org.uk, brauner@kernel.org,
	linux-block@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Sergei Shtepa <sergei.shtepa@veeam.com>
Subject: Re: [PATCH v6 10/11] blksnap: Kconfig and Makefile
Message-ID: <ZXF4geWqVrwMe8Xr@infradead.org>
References: <20231124165933.27580-1-sergei.shtepa@linux.dev>
 <20231124165933.27580-11-sergei.shtepa@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231124165933.27580-11-sergei.shtepa@linux.dev>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

> +config BLKSNAP_DIFF_BLKDEV
> +	bool "Use an optimized algorithm to store difference on a block device"
> +	depends on BLKSNAP
> +	default y
> +	help
> +	  The difference storage for a snapshot can be a regular file or a
> +	  block device. We can work with a block device through the interface
> +	  of a regular file. However, direct management of I/O units should
> +	  allow for higher performance.

Is there much of a point in making this option?

Btw, Linus hates defaul y, so we should not have one in there.

> +config BLKSNAP_CHUNK_DIFF_BIO_SYNC
> +	bool "Use a synchronous I/O unit processing algorithm for the snapshot image"
> +	depends on BLKSNAP
> +	default n

n the default default, so no need to add it.  But unless there is a
really good reason to have two different bio submission mechanisms
upstream I'd strongly suggest dropping one of them and this option.


