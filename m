Return-Path: <linux-fsdevel+bounces-46847-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B783EA95792
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Apr 2025 22:51:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FD163B2CB0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Apr 2025 20:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABE6B1F0E39;
	Mon, 21 Apr 2025 20:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t0hJs5As"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE001E04BD;
	Mon, 21 Apr 2025 20:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745268678; cv=none; b=K5FV6M8BvfZDJsv/mDt78S0sfGTzvs/HIm0MCJs7Ng+YWxfOZwv22uOo12PbP0/b/hVKoOb/3EItwvsx1txQK5JMJT0hRBHHIBT5RMLCgclxdZQjNjP7d9DyduSssAUT2ePPrB2lfUMx3GOHAmt6kJEmzlnHgu5jh7c9bxe/QNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745268678; c=relaxed/simple;
	bh=sd5i5Jq7v4SbWLrtzx7XhX6wPDUp1T51o/uIZRf+Gf4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I+KRBzz1u+h+VqurqveR5JXTyYfOZdngGiGSiAt7wTvF/KwRoaKILuZd5bPnt349Fvb5bFq8+9J5OSXR/PHt3RcFe0VQa3x8QTcTlxJgrB5s2Zaeyl6AmfANm/cbQe+8L+PmoOS2gfMOibIVGpGI21SaqCL3iO6KF8XMmPXV3xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t0hJs5As; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D605C4CEE4;
	Mon, 21 Apr 2025 20:51:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745268677;
	bh=sd5i5Jq7v4SbWLrtzx7XhX6wPDUp1T51o/uIZRf+Gf4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=t0hJs5AsBHMkHb9SC5LxuhJJPE9b0q27pq75fOQWl+yHEG5ntraesJJMdjEKMM9jc
	 +x9iHZHzVPGqZWehu/g3Kav59nPL2s3o6aqdP1+5HhsJ6R5czotKxfsEfcbdbnQKi7
	 OFCVvQKF2LrrJMajna5ghgcK3ZkV7BGIX2Z0I0bsHIngqpL/WLg8cLGmmzoe/9/ZjF
	 2bTBXNzapAR82nQ/NeTOIYLvCvzbPefuJIOX2C3mYyNA82kcNES8ttEm2dzFMej2CM
	 418sIEfQwysqaSquF/J1GfWFgRjJdIYx7QC3UKy3MM7mHkTWSDDLaKS9+M2p1AqJOD
	 Cf1OH3FKFVRBQ==
Date: Mon, 21 Apr 2025 13:51:16 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: cem@kernel.org, hch@lst.de, shinichiro.kawasaki@wdc.com,
	linux-mm@kvack.org, mcgrof@kernel.org,
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	willy@infradead.org, hch@infradead.org, linux-block@vger.kernel.org
Subject: Re: [PATCHSET V2] block/xfs: bdev page cache bug fixes for 6.15
Message-ID: <20250421205116.GF25700@frogsfrogsfrogs>
References: <174525589013.2138337.16473045486118778580.stgit@frogsfrogsfrogs>
 <8cb99c46-d362-4158-aa1e-882f7e0c304a@kernel.dk>
 <98e7e90e-0ebe-4cbc-96f3-ce7f536d8884@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <98e7e90e-0ebe-4cbc-96f3-ce7f536d8884@kernel.dk>

On Mon, Apr 21, 2025 at 02:26:54PM -0600, Jens Axboe wrote:
> On 4/21/25 2:24 PM, Jens Axboe wrote:
> > On 4/21/25 11:18 AM, Darrick J. Wong wrote:
> >> Hi all,
> >>
> >> Here are a handful of bugfixes for 6.15.  The first patch fixes a race
> >> between set_blocksize and block device pagecache manipulation; the rest
> >> removes XFS' usage of set_blocksize since it's unnecessary.
> >>
> >> If you're going to start using this code, I strongly recommend pulling
> >> from my git trees, which are linked below.
> >>
> >> With a bit of luck, this should all go splendidly.
> >> Comments and questions are, as always, welcome.
> > 
> > block changes look good to me - I'll tentatively queue those up.
> 
> Hmm looks like it's built on top of other changes in your branch,
> doesn't apply cleanly.

Yeah, I'm still waiting for hch (or anyone) to RVB patches 2 and 3.

--D

> -- 
> Jens Axboe

