Return-Path: <linux-fsdevel+bounces-67407-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E40FC3E674
	for <lists+linux-fsdevel@lfdr.de>; Fri, 07 Nov 2025 04:57:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D31554E5967
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Nov 2025 03:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECC97225788;
	Fri,  7 Nov 2025 03:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nF9QGrLL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B5A13B2A0;
	Fri,  7 Nov 2025 03:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762487834; cv=none; b=eNFDCK7LUin0is408wzN9RyUb5uLM9UllFoPGrpMyiJdplfV3ROeExV9D9MiVnAgaVlKOzGv2RkYtwgRLjRB0+b3Cm1QMz8S2MYS0dUkAsAuWaOeLR4WilCS4WQOBTV4zwwvdaVlW2Pp7mmZVgwMeJB4E52EhA7xYoH/vFrSX/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762487834; c=relaxed/simple;
	bh=rN1ZwN1I45020nzvwYbgC37BspZ2A2ja3waZRSu0TmE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vu3dxo7dxc1USct5q3A9A2Mkp3wzLi8oLxCjw6Ph2SerwacjI3KyjaTw8VObDvgCPcULvpxOF/B7lKZJ9H2X9RrKXtDMJJz4zPM+fVRE1ahEsbcDQxorihJWmZNmldR6WO/BCV6YQd7GiWHNdnfF5XD9iwEVKBZN6AAmfqZrt0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nF9QGrLL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AAB4C116B1;
	Fri,  7 Nov 2025 03:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762487833;
	bh=rN1ZwN1I45020nzvwYbgC37BspZ2A2ja3waZRSu0TmE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nF9QGrLLVG96PONV+TEhyN7pt2F1eiJvIe5G782uDEd850OCSYotIoei6y6ASjuGe
	 6I7S98s8ez12u8BkMlBSuCNYsUpC9elKMQGs/BoKt3JmXjpMDQotGNVwCtjc6UdCdp
	 BBDLni25UvIWuXTg8DweAjUqC6kjNEwzWQJYaj+8M9bWV+1NLYYNqYwh5blWmYE29d
	 gFtMQk7TIQI0vbAO2e149zzv5E++8GD0iv9Sh3Fcut5AmAW0vb7jvMh1XmjjLwBCva
	 O8dGfBOt/by5QCgR6qHw6yukASjdAwRp1ctI6RvNaIf8CECvlzMS8ILOOo2DDcNDMR
	 Tu2XB61XS9d4g==
Date: Thu, 6 Nov 2025 19:55:33 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Vlastimil Babka <vbabka@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Harry Yoo <harry.yoo@oracle.com>, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-fscrypt@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 4/9] fscrypt: pass a real sector_t to
 fscrypt_zeroout_range_inline_crypt
Message-ID: <20251107035533.GB47797@sol>
References: <20251031093517.1603379-1-hch@lst.de>
 <20251031093517.1603379-5-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251031093517.1603379-5-hch@lst.de>

On Fri, Oct 31, 2025 at 10:34:34AM +0100, Christoph Hellwig wrote:
> While the pblk argument to fscrypt_zeroout_range_inline_crypt is
> declared as a sector_t it actually is interpreted as a logical block
> size unit, which is highly unusual.  Switch to passing the 512 byte
> units that sector_t is defined for.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/crypto/bio.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)

Looks fine, though of course fscrypt_zeroout_range() itself still takes
a 'sector_t pblk' argument.

Reviewed-by: Eric Biggers <ebiggers@kernel.org>

- Eric

