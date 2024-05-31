Return-Path: <linux-fsdevel+bounces-20641-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 51C9B8D6524
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 May 2024 17:07:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16BEDB2D42E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 May 2024 15:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C366B73464;
	Fri, 31 May 2024 15:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fLTihaM8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26EC27483;
	Fri, 31 May 2024 15:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717167617; cv=none; b=JDC/80kIhkUV28jvCK0Of/B8xxhtwMrSej6LRqcPlczxat4N3wRAjefDLjp0W6n/Tc/sNz0pmGmz7tJMRVs1SRlwbhWrkjcZkdvYIEgI/mNcPgc3M9cMS7pjSdefPRUgvQk+bnoNBtxizBukrgeazdWc5NxwIZN48rN0cRNyDg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717167617; c=relaxed/simple;
	bh=oHjJ3ge5Oy2UenWzWYCDHU9h8HZVrZIgr4dbqGF2JYI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SCAtr2G0XceqeIlinUEvgTDpD1pJRNXOS/DnMTVlSPSuvMy+XPKfdneL1TEHbhQN/iy1zSDXtJHAs/0blmrUblb3qIBZCD+nzShE8lfZ6B2iSboqvut1EIjhxYVVZRPDKB8f/SbfTQg1BZgzhtY0FpTxtaoAI0E0swp3c/e1PQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fLTihaM8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A88DC116B1;
	Fri, 31 May 2024 15:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717167616;
	bh=oHjJ3ge5Oy2UenWzWYCDHU9h8HZVrZIgr4dbqGF2JYI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fLTihaM8uhf8S4bQ24cMMo9PFjcBjm1r9poKMCfnpvSKZIo2uyE76MniP84yBbO46
	 WFsj05gHbaftfJYMHi9ggHyH/XIcyBDAgE6z5ckcZl2LTS14+fNeSmraIDVyCFWz5P
	 bJNH88ug57pC82N5g7GdRfevaz3W9hlhjYhZWDU1S+cCEG1dWjo9hLDZGiHQmENayW
	 HLav5+/ZXvAzn+NqOuy4YEYGqlTec3oK58LNwDWOY18DbHuxi4XjKQ7/5bsUFuvVMf
	 bb1ky8R7NHfgf/RScZv5yPb4ty8TPIky1W3jnrxxYlNybXPgOT/1PVPvYdp1GoMQ2T
	 C3FYhbPW1QpWg==
Date: Fri, 31 May 2024 08:00:16 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Zhang Yi <yi.zhang@huaweicloud.com>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	brauner@kernel.org, david@fromorbit.com, chandanbabu@kernel.org,
	jack@suse.cz, willy@infradead.org, yi.zhang@huawei.com,
	chengzhihao1@huawei.com, yukuai3@huawei.com
Subject: Re: [RFC PATCH v4 8/8] xfs: improve truncate on a realtime inode
 with huge extsize
Message-ID: <20240531150016.GL52987@frogsfrogsfrogs>
References: <20240529095206.2568162-1-yi.zhang@huaweicloud.com>
 <20240529095206.2568162-9-yi.zhang@huaweicloud.com>
 <ZlnUorFO2Ptz5gcq@infradead.org>
 <20240531141210.GI52987@frogsfrogsfrogs>
 <Zlnbht9rCiv-d2un@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zlnbht9rCiv-d2un@infradead.org>

On Fri, May 31, 2024 at 07:15:34AM -0700, Christoph Hellwig wrote:
> On Fri, May 31, 2024 at 07:12:10AM -0700, Darrick J. Wong wrote:
> > There are <cough> some users that want 1G extents.
> > 
> > For the rest of us who don't live in the stratosphere, it's convenient
> > for fsdax to have rt extents that match the PMD size, which could be
> > large on arm64 (e.g. 512M, or two smr sectors).
> 
> That's fine.  Maybe to rephrase my question.  With this series we
> have 3 different truncate path:
> 
>  1) unmap all blocks (!rt || rtextsizse == 1)
>  2) zero leftover blocks in an rtextent (small rtextsize, but > 1)
>  3) converted leftover block in an rtextent to unwritten (large
>    rtextsize)
> 
> What is the right threshold to switch between 2 and 3?  And do we
> really need 2) at all?

I don't think we need (2) at all.

There's likely some threshold below where it's a wash -- compare with
ext4 strategy of trying to write 64k chunks even if that requires
zeroing pagecache to cut down on fragmentation on hdds -- but I don't
know if we care anymore. ;)

--D

