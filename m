Return-Path: <linux-fsdevel+bounces-16419-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A2F689D506
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Apr 2024 11:00:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C52441C22B33
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Apr 2024 09:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56E5E7F47C;
	Tue,  9 Apr 2024 09:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E1rNTUKn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0B3D7E580;
	Tue,  9 Apr 2024 09:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712653217; cv=none; b=oMGHP1wqOfsb3ZN44guURkTFqBHcbFpn4jI2ldNS2owHVzXkpidO16u7gQB2PTumKDGKewvwfKRy7ytr4BZodaYAQaWIVjqW1aji25wle1MA7+ciLFF36w1DJ9E1AP9DTLTxpdVedwReBZj/y0wyQL95lymp5OOUUt9btdZPDFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712653217; c=relaxed/simple;
	bh=ibeYyPYUi2eA3S25RuPi3BCQEXm8vl3RMVIg9ekCW/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uG1klpWA5t0avXg1uJMWnwAumFllSd31m+Kurvd9ejVZ5HTs5PtxywubLPNI7WE0GxbR5wfd5900gECNs4CgU7DXPj3lfJhoGFjgFUybTfQTX15gQlGjUzKPQL/PZ9yR5QPYPxSc7W62UedHUYUScwYo3vMnSllyP9MlsRcHBA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E1rNTUKn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66245C433F1;
	Tue,  9 Apr 2024 09:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712653217;
	bh=ibeYyPYUi2eA3S25RuPi3BCQEXm8vl3RMVIg9ekCW/8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E1rNTUKn7xZSUk85/Lt1DaDyaxaq7una+DbDBicibeQdG4YLGPqs/rd2/D+PnnYKw
	 LfSJ+Qe+G5BnFpKg2ZZV98R0WT/+SnKr/ktAMAjAKP5k6WMVy+FOpnPpyKblsy5OwP
	 vL7zRR2aoWLBez5qUfCrOSU8ZIkEgfqhEO6ynJCIqP5gt4YY7Be/LPDdg7SILwp0g5
	 wv80TTTLNzBEkIJJOkGJu5v9bYOoDQbELtpHUU7deZRsJDnxLGsKuSCYaTQ9qah4Sr
	 aQSqayt3E3Zs3Q1/mg+vYDJ+zzzxZPsMhnzju+z4APMcTj7jc49dyueHTTR2E70TWc
	 R6q78PXOiVZOA==
Date: Tue, 9 Apr 2024 11:00:10 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Yu Kuai <yukuai1@huaweicloud.com>, jack@suse.cz, hch@lst.de, 
	axboe@kernel.dk, linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org, 
	yi.zhang@huawei.com, yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH vfs.all 22/26] block: stash a bdev_file to read/write raw
 blcok_device
Message-ID: <20240409-plural-schusselig-e7fed53aed65@brauner>
References: <20240406090930.2252838-1-yukuai1@huaweicloud.com>
 <20240406090930.2252838-23-yukuai1@huaweicloud.com>
 <20240406194206.GC538574@ZenIV>
 <20240406202947.GD538574@ZenIV>
 <3567de30-a7ce-b639-fa1f-805a8e043e18@huaweicloud.com>
 <20240407015149.GG538574@ZenIV>
 <21d1bfd6-76f7-7ffb-34a4-2a85644674fe@huaweicloud.com>
 <20240407030610.GI538574@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240407030610.GI538574@ZenIV>

On Sun, Apr 07, 2024 at 04:06:10AM +0100, Al Viro wrote:
> On Sun, Apr 07, 2024 at 10:34:56AM +0800, Yu Kuai wrote:
> 
> > Other than raw block_device fops, other filesystems can use the opened
> > bdev_file directly for iomap and buffer_head, and they actually don't
> > need to reference block_device anymore. The point here is that whether
> 
> What do you mean, "reference"?  The counting reference is to opened
> file; ->s_bdev is a cached pointer to associated struct block_device,
> and neither it nor pointers in buffer_head are valid past the moment
> when you close the file.  Storing (non-counting) pointers to struct
> file in struct buffer_head is not different in that respect - they
> are *still* only valid while the "master" reference is held.
> 
> Again, what's the point of storing struct file * in struct buffer_head
> or struct iomap?  In any instances of those structures?
> 
> There is a good reason to have it in places that keep a reference to
> opened block device - the kind that _keeps_ the device opened.  Namely,
> there's state that need to be carried from the place where we'd opened
> the sucker to the place where we close it, and that state is better
> carried by opened file.
> 
> But neither iomap nor buffer_head contain anything of that sort -
> the lifetime management of the opened device is not in their
> competence.  As the matter of fact, the logics around closing
> those opened devices (bdev_release()) makes sure that no
> instances of buffer_head (or iomap) will outlive them.
> And they don't care about any extra state - everything
> they use is in block_device and coallocated inode.
> 
> I could've easily missed something in one of the threads around
> the earlier iterations of the patchset; if that's the case,
> could somebody restate the rationale for that part and/or
> post relevant lore.kernel.org links?  Christian?  hch?
> What am I missing here?

The original series was a simple RFC/POC to show that struct file could
be used to remove bd_inode access in a wide variety of situations. But
as I've mentioned in that thread I wasn't happy with various aspects of
the approach which is why I never pushed forward with it. The part where
we pushed struct file into buffer_header was the most obvious one.

