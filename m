Return-Path: <linux-fsdevel+bounces-54480-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73188B0014E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 14:12:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21869487903
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 12:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDAEF2586EA;
	Thu, 10 Jul 2025 12:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LBTOtfAU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC45241664;
	Thu, 10 Jul 2025 12:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752149496; cv=none; b=eCUqbOXBcMB2ZJfvUFyIbXmcqKQihXJJci45AacvgjoNvD7QN4+Lno3Qbg19rlx5MKLz0/EVRN4uzch0QleNggw074dCVle2BA5JdBdHIsE4ooRGQt7FmTHMvlShV0OhJxJ7Zz6EKo+zGIery3ziJbTzL1I/fS5CxaQMxtBSUrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752149496; c=relaxed/simple;
	bh=tUT68e6Q8IKXdlF8aaRcx77PZdPTzcKSQIzQYR02AQA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TJDf5rF7a2xScCRCOsVzRqcQnO9m0Z/gjnL3f8OETOQuB/z1lXmx6XDvP38HpBpzxV2fDkh8vEFTrff1uRGjTY6DJ15/LiQt0/AjHoS3gkzFAeJ8vbiUv97D80FH31jq9AgSKAHVrIXCXEM/WLxPzw1fmIUxQq+0cfD6KzQn4N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LBTOtfAU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 542F3C4CEE3;
	Thu, 10 Jul 2025 12:11:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752149494;
	bh=tUT68e6Q8IKXdlF8aaRcx77PZdPTzcKSQIzQYR02AQA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LBTOtfAUyAstWFgBpC3YlBfuVTH2LN/6eBNw78s78xfUv8B9xnZsW+VCHie78Q2Ky
	 VaeNylNO5zv18Tt/Zh4b7F0MzuhM/I112yMqoKXyjrqh/9FElF2Y6VSNszxiHVE/SP
	 3PwaQOl6GqFEhUDxCgoJisX/s6CHUR9hd6/xnRUSlrFeCX1U/Si0GlGyJUqj1GiUfX
	 SXLLakzuEdaAoypuL3tHNTYkgi2J90VWx1ZcT69hp9CnetbI5zQGuGreo9//1/A1KM
	 o9pSxQUr48tO/TQ/hDS//z5o7pegnSpcxrQYdrUVb0GvMj6tvpEehJC2YeDhTglZYO
	 xCK32e5uH/Fzg==
Date: Thu, 10 Jul 2025 14:11:26 +0200
From: Christian Brauner <brauner@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Christoph Hellwig <hch@infradead.org>, Arnd Bergmann <arnd@kernel.org>, 
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org, Anuj Gupta <anuj20.g@samsung.com>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, Kanchan Joshi <joshi.k@samsung.com>, 
	LTP List <ltp@lists.linux.it>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Benjamin Copeland <benjamin.copeland@linaro.org>, rbm@suse.com, Naresh Kamboju <naresh.kamboju@linaro.org>, 
	Anders Roxell <anders.roxell@linaro.org>, Jens Axboe <axboe@kernel.dk>, 
	Pavel Begunkov <asml.silence@gmail.com>, Alexey Dobriyan <adobriyan@gmail.com>, 
	"Darrick J. Wong" <djwong@kernel.org>, Eric Biggers <ebiggers@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] block: fix FS_IOC_GETLBMD_CAP parsing in
 blkdev_common_ioctl()
Message-ID: <20250710-ehegatte-undicht-6b71310cb1ef@brauner>
References: <20250709181030.236190-1-arnd@kernel.org>
 <20250710-passen-petersilie-32f6f1e9a1fc@brauner>
 <aG92abpCeyML01E1@infradead.org>
 <14865b4a-dfad-4336-9113-b70d65c9ad52@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <14865b4a-dfad-4336-9113-b70d65c9ad52@app.fastmail.com>

> Christian's version using the copy_struct_{from,to}_user()
> aims to avoid most of the problems. The main downside I see
> here is the extra complexity in the kernel. As far as I can
> tell, this has mainly led to extra kernel bugs but has not
> actually resulted in any structure getting seamlessly
> extended.

We extended ioctls multiple times seemlessly and other than this bug
right here I'm not aware of anything serious. Not liking it is fine of
course but saying "this caused a bug so go away" I won't take all too
seriously, sorry.

I don't want to go down the road of structure revisions for stuff in the
generic layer. Others can do whatever they see fit ofc and userspace can
then have its usualy ifdeffery and structure layout detection party
instead of a clean generic solution. I'd rather clean up the necessary
vetting bits and properly document how this can be done.

