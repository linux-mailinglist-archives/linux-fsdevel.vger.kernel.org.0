Return-Path: <linux-fsdevel+bounces-4067-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1A6C7FC372
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Nov 2023 19:36:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B50D282753
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Nov 2023 18:36:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 565BF37D12
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Nov 2023 18:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DTHgE9PP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D3FE37D37;
	Tue, 28 Nov 2023 17:18:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7251DC433C7;
	Tue, 28 Nov 2023 17:18:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701191905;
	bh=V7IKAf0Hbu6oP2LSWp5l10ZwtBSliEPvVOx9m0gWfYQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DTHgE9PPklBAMdua0Gq+s/PRw++bw+Gj2frl4hyn3VWGoVDnO+zsrE+nNNl9kJCnm
	 Aif6OPqLGkuMeO87bQeZNkZxecGgE35op+PwvNVEC2SVi6UE42oxDvc1NCf0whVyze
	 u8jJwbYkbzVJX9f4i+TBbmFu3kC7Li++6kX/8uQ9anTcQ4LX74JdAzadEKlFWGdl5W
	 h4rVFVKK67H6Cj6TLoi6TfcG2mi/7B1FgCnuhoSHVgdEqmLzIa4r2Lgph6KRcxAgDc
	 GLP7RCT6Ldry21zdNGa0876otyOA+nuP48lukN/ibWTlhZV9gY3exB+auhSbDec+Yn
	 v/iSmyghEjysQ==
Date: Tue, 28 Nov 2023 09:18:23 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Sergei Shtepa <sergei.shtepa@linux.dev>
Cc: axboe@kernel.dk, hch@infradead.org, corbet@lwn.net, snitzer@kernel.org,
	mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
	viro@zeniv.linux.org.uk, brauner@kernel.org,
	linux-block@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Sergei Shtepa <sergei.shtepa@veeam.com>
Subject: Re: [PATCH v6 11/11] blksnap: prevents using devices with data
 integrity or inline encryption
Message-ID: <20231128171823.GA1148@sol.localdomain>
References: <20231124165933.27580-1-sergei.shtepa@linux.dev>
 <20231124165933.27580-12-sergei.shtepa@linux.dev>
 <20231127224719.GD1463@sol.localdomain>
 <6cabaa42-c366-4928-8294-ad261dae0043@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6cabaa42-c366-4928-8294-ad261dae0043@linux.dev>

On Tue, Nov 28, 2023 at 12:00:17PM +0100, Sergei Shtepa wrote:
> But I haven't tested the code on a device where hardware inline encryption is
> available. I would be glad if anyone could help with this.
> > 
> > Anyway, this patch is better than ignoring the problem.  It's worth noting,
> > though, that this patch does not prevent blksnap from being set up on a block
> > device on which blk-crypto-fallback is already being used (or will be used).
> > When that happens, I/O will suddenly start failing.  For usability reasons,
> > ideally that would be prevented somehow.
> 
> I didn't observe any failures during testing. It's just that the snapshot
> image shows files with encrypted names and data. Backup in this case is
> useless. Unfortunately, there is no way to detect a blk-crypto-fallback on
> the block device filter level.

Huh, I thought that this patch is supposed to exclude blk-crypto-fallback too.
__submit_bio() calls bio->bi_bdev->bd_filter->ops->submit_bio(bio) before
blk_crypto_bio_prep(), so doesn't your check of ->bi_crypt_context exclude
blk-crypto-fallback?

I think you're right that it might actually be fine to use blksnap with
blk-crypto-fallback, provided that the encryption is done first.  I would like
to see a proper explanation of that, though.  And we still have this patch which
claims that it doesn't work, which is confusing.

- Eric

