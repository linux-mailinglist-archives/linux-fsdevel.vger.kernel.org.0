Return-Path: <linux-fsdevel+bounces-31240-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C678299356C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 19:53:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56ED4B218F6
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 17:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEBDF1DDA3E;
	Mon,  7 Oct 2024 17:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HRM4xLEw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42B6E1DD897;
	Mon,  7 Oct 2024 17:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728323571; cv=none; b=uv9jiIeR715CEzVIEnu5GcpvAayrEMhrxrp9hMcd3y6N2fUR35fkqWPCsIkVxM2jcKsngG0pDvA2sGefFIZwsxM5XBvV0kxcHZzmlka0O7kr0JPzbbgFhpKMKWsGR82shIw60QxLYtpkYhyc4VUiakprYSgc4E5fQS6eywPdUls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728323571; c=relaxed/simple;
	bh=T3H78K5yItVdz/AHvM9otK2ENeO8RoR/mpvFdNRh7Gs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GGnRSAp1Yy19Y8RWYBYovLZNA4pbuBC1gmnomdX6GvsJrciMzNW9mEr5mJZuiw5IwCepx6a6V4wDd6gHZha7mxECXszJazNfEr2XTKoCV1XRD4z+x2KS7yie4R492Cw7j1HwLzcXHeMktoV4rq1PVlZqeh7OznZ38OnTF0kbhjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HRM4xLEw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 030C2C4CEC7;
	Mon,  7 Oct 2024 17:52:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728323571;
	bh=T3H78K5yItVdz/AHvM9otK2ENeO8RoR/mpvFdNRh7Gs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HRM4xLEwpnNi+wQoqT3I5dlQyRAxD7/01jsy47+DZwVl8aP1XKWzKbLU15G2KLEfs
	 9s3fhDqvRNU9gX/kVZjZp7jO5YMjhGREsVdY/PGctlNw2OsUXjXfdrbzz7IrrSfDci
	 Y5kqySAGJ17MTrEib7loGCTm/RxrKS204bzbCk2MLOy4IZImoKGxADZlVTThIzaaqx
	 4OYhnNL42NWFPf1jux400P9o0aVQE/JjcqAunG5dL0b5phWgKqhyXB3LI8yJzwTghk
	 zQapmb9Eera6pUEOC5PeyPpLqL01eme8dwQjnM2Kh6hILbshUv8Wmzo9GTUdY4LDqC
	 yNeuU8Vs9U4iw==
Date: Mon, 7 Oct 2024 10:52:50 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Tang Yizhou <yizhou.tang@shopee.com>, hch@infradead.org,
	willy@infradead.org, akpm@linux-foundation.org,
	chandan.babu@oracle.com, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH v2 3/3] xfs: Let the max iomap length be consistent with
 the writeback code
Message-ID: <20241007175250.GP21853@frogsfrogsfrogs>
References: <20241006152849.247152-1-yizhou.tang@shopee.com>
 <20241006152849.247152-4-yizhou.tang@shopee.com>
 <20241007163609.fkwiybr3nnw7utnc@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241007163609.fkwiybr3nnw7utnc@quack3>

On Mon, Oct 07, 2024 at 06:36:09PM +0200, Jan Kara wrote:
> On Sun 06-10-24 23:28:49, Tang Yizhou wrote:
> > From: Tang Yizhou <yizhou.tang@shopee.com>
> > 
> > Since commit 1a12d8bd7b29 ("writeback: scale IO chunk size up to half
> > device bandwidth"), macro MAX_WRITEBACK_PAGES has been removed from the
> > writeback path. Therefore, the MAX_WRITEBACK_PAGES comments in
> > xfs_direct_write_iomap_begin() and xfs_buffered_write_iomap_begin() appear
> > outdated.
> > 
> > In addition, Christoph mentioned that the xfs iomap process should be
> > similar to writeback, so xfs_max_map_length() was written following the
> > logic of writeback_chunk_size().
> 
> Well, I'd defer to XFS maintainers here but at least to me it does not make
> a huge amount of sense to scale mapping size with the device writeback
> throughput. E.g. if the device writeback throughput is low, it does not
> mean that it is good to perform current write(2) in small chunks...

Yeah, I was wondering if it still makes sense to throttle incoming
writes given that iomap will just call back for more mappings anyway.

--D

> 								Honza
> 
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
> 

