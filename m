Return-Path: <linux-fsdevel+bounces-16608-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D668A89FB6B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Apr 2024 17:23:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13FCF1C2301D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Apr 2024 15:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9281116E870;
	Wed, 10 Apr 2024 15:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kOJYsqU6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00BC716E874
	for <linux-fsdevel@vger.kernel.org>; Wed, 10 Apr 2024 15:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712762613; cv=none; b=uFTvIsHbBUMyeWPrO9d7ix0GeB7kQtIwb9No/Hn2KMX4O2OW3hm7stBe7fbyS3e2hH0lh2TYRmkQ9YekXmmpaSNxeWXzQTD41Ct64sIgm3lgls6RdsXOzBIulbhoLgntbDy8yXcmOvmlzw4rBnlxD2Vq97IhOOPV9nJc94jOE8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712762613; c=relaxed/simple;
	bh=/R+bxs7aa4Yp5oegab8DgNkRt1e3UpF3q8zLXZXOz/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nJ+TIucNVXvd+tXpVj1RsJn2LTdjaPEWw0sYSHkg0lNDvaiDB/SYj1IdFMEfbz1vPUMJckrqUOtQIcDBDOSWju4IYZL7nkGxpXrZ1soLRh7+fthlhVRmmgcCWEk5n0gZu+RukhfIXYULoKZad2R1rQgzt3VolEXpO2c38j+J5t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kOJYsqU6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFD31C433F1;
	Wed, 10 Apr 2024 15:23:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712762611;
	bh=/R+bxs7aa4Yp5oegab8DgNkRt1e3UpF3q8zLXZXOz/o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kOJYsqU6HGkzqghfJv8dUY7vhQmP9bUHQNF0DEX7aE9xMd5XYFoqFTG+G154kZP8h
	 sw6c9sVNiyzBdeEdo9T2gG5K04kLNh1QqYVBJgdZ5vJXcfqNq6cALSnqg6zp5RGvmz
	 i257wZfy+NB9pwtd1hh5YCBbcTQsTm6EitfueeM+OL7ToTB+chKLhmzAaWE+rg14Tu
	 TXnznIPfbNIi3/MnxbUnE1rp5b1Ij9bGxdtTTTzkqOqFRCjSZCDGF9Q4+6PwNm03yG
	 wysCDUUHW3U4VO51Mda5xplNHjIgpueA3eD0qpyODtNivVBXP7yoJ5lyTeVvYwiBvy
	 tojfuR3huKKvg==
Date: Wed, 10 Apr 2024 17:23:25 +0200
From: Christian Brauner <brauner@kernel.org>
To: John Groves <John@groves.net>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, John Groves <jgroves@micron.com>, john@jagalactic.com
Subject: Re: [PATCH 1/1] sget_dev() bug fix: dev_t passed by value but stored
 via stack address
Message-ID: <20240410-umzog-neugierig-56fbce5987e4@brauner>
References: <cover.1712704849.git.john@groves.net>
 <7a37d4832e0c2e7cfe8000b0bf47dcc2c50d78d0.1712704849.git.john@groves.net>
 <20240410-mitnahm-loyal-151d4312b017@brauner>
 <6i3kr6pyyvbrcnp6pwbltn4xam6eirydficleubd4bhdlsx3uu@kh6t7zai4pai>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6i3kr6pyyvbrcnp6pwbltn4xam6eirydficleubd4bhdlsx3uu@kh6t7zai4pai>

> I don't think &dev makes sense here - it was passed by value so its
> address won't make sense outside the current context, right?. It seems

I don't follow, we only need that address to be valid until sget_dev()
returns as sget_key isn't used anymore. And we store the value, not the
address. Other than that it's a bit ugly it's fine afaict. Related
issues would exist with fuse or gfs2 where the lifetime of the key ends
right after the respective sget call returns. We could smooth this out
here by storing the value in the pointer via
#define devt_to_sget_key(dev) ((void *)((uintptr_t)(dev)))
#define sget_key_to_devt(key) ((dev_t)((uintptr_t)(key)))
but I'm not sure it's necessary. Unless I'm really missing something.

