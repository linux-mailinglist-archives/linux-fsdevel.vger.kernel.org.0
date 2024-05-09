Return-Path: <linux-fsdevel+bounces-19192-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F8918C11B8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 May 2024 17:10:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 449F31F22743
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 May 2024 15:10:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ECC815E81F;
	Thu,  9 May 2024 15:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MD080vjH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B10D23D978;
	Thu,  9 May 2024 15:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715267396; cv=none; b=AL9CXRJMLWXkLZNjmOXaJikh0FmBLbR7RYHSU0E5UPQmX7f6fBBAcsGqALjTGMm2i9iySam82h5NHVGdfiqs1vJtxgVSmE763KM933vIZkVMgo3pk9PXq/XEFmunZrcvOPVWLXxkiSTtw8TvBTijvzUE7YblUSD7CzR5TxUPH/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715267396; c=relaxed/simple;
	bh=LDRB5h++1Bmx8L1UYublREI5KmY1jV7zloFWJs7b9xw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A2XeMQTNx8EWgb5ssnWAEEMObs5JL5XvCrY9Rg6GbP/Yg/b9R2AQH98iB7+m4G3Cy3QnCaXqe/IpEqCEnd1T3i/TO5qB61EFgYkqpuoy0wxxnNQMYtYaD2PiEmVjC5olLCe5DUz4xu5LNyMhJWegwJfc9S8EryRmeXg+m26Flh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MD080vjH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EF55C116B1;
	Thu,  9 May 2024 15:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715267396;
	bh=LDRB5h++1Bmx8L1UYublREI5KmY1jV7zloFWJs7b9xw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MD080vjH7BbzzrPAmRqgt2FOfWZajb17ls12aeoeKSm/pE6h+6p2z58ZCWbA9Kphk
	 2Rgs58GYlP2bQ5tLNk02kbkRPld0mPgWoMFprS1LHX9phnVo3g+yUbj+G0DAJzfmeH
	 FjHK2RSvTita/yHkWGXWRkusxyJUK/R+Isae1XngY3xpJ/IPA9NPTWCYJdirsN/M7N
	 ut5mDjFBi3f7cVAywiaNR/BT6ryZh903P1lE20izTrk2SJj8enE0FsUDHFgnQsCkZV
	 gaw7wk6QviNLatCGptjNYg0roqtaRfQ1nj07OzkAL+Ovx7dIdf4QyQNfoxLY5obWeb
	 QTXgEIglVt3dw==
Date: Thu, 9 May 2024 08:09:55 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Eric Biggers <ebiggers@kernel.org>, aalbersh@redhat.com,
	linux-xfs@vger.kernel.org, alexl@redhat.com, walters@verbum.org,
	fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 25/26] xfs: make it possible to disable fsverity
Message-ID: <20240509150955.GL360919@frogsfrogsfrogs>
References: <171444680291.957659.15782417454902691461.stgit@frogsfrogsfrogs>
 <171444680792.957659.14055056649560052839.stgit@frogsfrogsfrogs>
 <ZjHlventem1xkuuS@infradead.org>
 <20240501225007.GM360919@frogsfrogsfrogs>
 <20240502001501.GB1853833@google.com>
 <20240508203148.GE360919@frogsfrogsfrogs>
 <ZjxZRShZLTb7SS3d@infradead.org>
 <20240509144542.GJ360919@frogsfrogsfrogs>
 <Zjzmho9jm2wisUPj@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zjzmho9jm2wisUPj@infradead.org>

On Thu, May 09, 2024 at 08:06:46AM -0700, Christoph Hellwig wrote:
> On Thu, May 09, 2024 at 07:45:42AM -0700, Darrick J. Wong wrote:
> > How do you salvage the content of a fsverity file if the merkle tree
> > hashes don't match the data?  I'm thinking about the backup disk usecase
> > where you enable fsverity to detect bitrot in your video files but
> > they'd otherwise be mostly playable if it weren't for the EIO.
> 
> Why would you enable fsverity for DVD images on your backup files?

xfs doesn't do data block checksums.

I already have a dumb python program that basically duplicates fsverity
style merkle trees but I was looking forward to sunsetting it... :P

--D

