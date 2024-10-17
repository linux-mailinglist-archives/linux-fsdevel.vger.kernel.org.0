Return-Path: <linux-fsdevel+bounces-32222-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1FBF9A2738
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2024 17:45:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3A7D1C25B3D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2024 15:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AE2C1DF25E;
	Thu, 17 Oct 2024 15:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uGtOCC0K"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B1F51DED7D;
	Thu, 17 Oct 2024 15:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729179883; cv=none; b=bb+Lyj2Ii0dnRhQ8xx0AyH5g+Bc3YQcCsFwZfGAB1xX5JO2CIuTyfFbAyL0Abe7H6mxWjDnkSdK4Ns4HlloqkjAr+FSUiLavvJcj2cRH1uLfRd0EYEPMzYqGV8o1CI66VVtZBNlIvVlsfiGT8F+zXPddC7LSrkyuLXzJM6AWvgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729179883; c=relaxed/simple;
	bh=YyMF8CAbGHfi2Sw0wRiqwANy0JpymXK7ZZYD+DPBNbM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DMF1upTt16MhP293thhuAL7suE7OWFMNmc84B+gtAnC1B6+C7Cxnpe0BodcMylwKg6D/3fR3mIyxluQ8KssBnL0Caw7tUt55MG3HScMIMnz1SSZhrbhcx1pTU1VkCTap5WzllpaF+ytT7Ek2w08ra6ocGoSkjWqIzzDnaarWzhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uGtOCC0K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEC1EC4CEC3;
	Thu, 17 Oct 2024 15:44:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729179883;
	bh=YyMF8CAbGHfi2Sw0wRiqwANy0JpymXK7ZZYD+DPBNbM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uGtOCC0KZ+nQG3KRlBLvL3qkiKVlc9OuxDmzeY/a0qZE1JclZl0IvwCA7qJx1bePC
	 J+ICr6c0I5o4mWgMbRUDPMezx9EHk7I0I1VJIClLE1pySihpdyWuHoKH1rPGUIjEnJ
	 rRNeb269IyZtZEvF1uaNvjtBRoEhjzXSs9Muo2HfP6swFWuzSOrAAkXIWgOz8lFlFm
	 UxsKN2UtuWSUZUwbH6WREbBggDHkXWKHPmJ5GlQpc9ta5szoU88MMOwrCUxx1Td7CU
	 UxsbMHQKBgsY3Gmf+Sw07HFzvaGBDMZOV8w8WX6yy6KiAE+uz60bnhgU8wKueSmQPy
	 xEw2/sh6hsewA==
Date: Thu, 17 Oct 2024 09:44:39 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Kanchan Joshi <joshi.k@samsung.com>, axboe@kernel.dk, hare@suse.de,
	sagi@grimberg.me, martin.petersen@oracle.com, brauner@kernel.org,
	viro@zeniv.linux.org.uk, jack@suse.cz, jaegeuk@kernel.org,
	bcrl@kvack.org, dhowells@redhat.com, bvanassche@acm.org,
	asml.silence@gmail.com, linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org,
	linux-block@vger.kernel.org, linux-aio@kvack.org,
	gost.dev@samsung.com, vishak.g@samsung.com, javier.gonz@samsung.com
Subject: Re: [PATCH v7 0/3] FDP and per-io hints
Message-ID: <ZxEw5-l6DtlXCQRO@kbusch-mbp.dhcp.thefacebook.com>
References: <CGME20240930182052epcas5p37edefa7556b87c3fbb543275756ac736@epcas5p3.samsung.com>
 <20240930181305.17286-1-joshi.k@samsung.com>
 <20241015055006.GA18759@lst.de>
 <8be869a7-c858-459a-a34b-063bc81ce358@samsung.com>
 <20241017152336.GA25327@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241017152336.GA25327@lst.de>

On Thu, Oct 17, 2024 at 05:23:37PM +0200, Christoph Hellwig wrote:
> If you want to do useful stream separation you need to write data
> sequentially into the stream.  Now with streams or FDP that does not
> actually imply sequentially in LBA space, but if you want the file
> system to not actually deal with fragmentation from hell, and be
> easily track what is grouped together you really want it sequentially
> in the LBA space as well.  In other words, any kind of write placement
> needs to be intimately tied to the file system block allocator.

I'm replying just to make sure I understand what you're saying:

If we send per IO hints on a file, we could have interleaved hot and
cold pages at various offsets of that file, so the filesystem needs an
efficient way to allocate extents and track these so that it doesn't
interleave these in LBA space. I think that makes sense.

We can add a fop_flags and block/fops.c can be the first one to turn it
on since that LBA access is entirely user driven.

