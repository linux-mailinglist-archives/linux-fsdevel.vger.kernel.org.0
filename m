Return-Path: <linux-fsdevel+bounces-45990-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A41E7A80E3F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Apr 2025 16:36:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 857924E0DCC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Apr 2025 14:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2C591DEFEC;
	Tue,  8 Apr 2025 14:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sUw48Dfz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AEBE1A9B34;
	Tue,  8 Apr 2025 14:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744122720; cv=none; b=QxVPKk/QKVWUilowI5fKvaQOIM2dGaiDT62uZFmjm2eRLxvImPlZNJw4gxv0so7L60KLiRGCzDwd2+ypReUh4/wv0JzCL+L04vvzR60qATvviSIIYvdK9pSHkZJ7A271g7fEAU6nz4oLhhrfyeW2lQnER7Shfxdpve5lV7lkg9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744122720; c=relaxed/simple;
	bh=j4cd2D37hpE76RXAdqlaRaN8aQ0v29wGqTICClpRPv4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nk5Kws8syyhmxGa0CmDvBDt1EB+FvkLg79LZgcAnNhBigUhlm1dwqeOeFF5zWsJZveL7Q81pD3Tz5gTORR8XaEqJ6WeO+tVY1DOc3L3NIPZcXeWtu2NigyCHJ5Mc5cXY6OPQXhs0Li1rkyNdWjmEkyskPvMxUyTa1v7MseP0zL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sUw48Dfz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80A0FC4CEE7;
	Tue,  8 Apr 2025 14:31:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744122718;
	bh=j4cd2D37hpE76RXAdqlaRaN8aQ0v29wGqTICClpRPv4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sUw48DfzIvfgKXtGQex132eS1LkX3ponero0pb3bDwowIeyDVbz/r+Wadb9gU1puJ
	 paNXmxhr4yHNfoQiZUmp6BG1q2K87wDzYUc44BBuygL2DLeFds4ZtmkiNBat9ko2hJ
	 YEaiTBgG5g6CBf4T8j5oad/slkIOVHtJXG61wArBeAsD1Hj2ADggGoUEdPZOnClenv
	 F9tGE1CEu5MajFasq5JRHcUhi1GFo8m5lMRSn0INLo+uQdnyeXA36aWjTK13IWDvvx
	 tb/yCoyIFtiOL0+GJ5k6tRTthHCqK6ZE7kL18ltcQnWSwv7ALcaEncnwxHMefLtuIJ
	 CZdi5xJqsRdYA==
Date: Tue, 8 Apr 2025 07:31:57 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Phillip Lougher <phillip@squashfs.org.uk>
Cc: Jan Kara <jack@suse.cz>, Andreas Gruenbacher <agruenba@redhat.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
	Carlos Maiolino <cem@kernel.org>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: Recent changes mean sb_min_blocksize() can now fail
Message-ID: <20250408143157.GI6266@frogsfrogsfrogs>
References: <86290c9b-ba40-4ebd-96c1-d3a258abe9d4@squashfs.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86290c9b-ba40-4ebd-96c1-d3a258abe9d4@squashfs.org.uk>

On Tue, Apr 08, 2025 at 06:33:53AM +0100, Phillip Lougher wrote:
> Hi,
> 
> A recent (post 6.14) change to the kernel means sb_min_blocksize() can now fail,
> and any filesystem which doesn't check the result may behave unexpectedly as a
> result.  This change has recently affected Squashfs, and checking the kernel code,
> a number of other filesystems including isofs, gfs2, exfat, fat and xfs do not
> check the result.  This is a courtesy email to warn others of this change.

Thanks for the heads up.  xfs always passes in BBSIZE (aka 512) and
doesn't use the bdev pagecache so I think it's unaffected by failures.

--D

> The following emails give the relevant details.
> 
> https://lore.kernel.org/all/2a13ea1c-08df-4807-83d4-241831b7a2ec@squashfs.org.uk/
> https://lore.kernel.org/all/129d4f39-6922-44e9-8b1c-6455ee564dda@squashfs.org.uk/
> 
> Regards
> 
> Phillip
> 

