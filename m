Return-Path: <linux-fsdevel+bounces-40304-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C9C1A220BB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2025 16:43:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1DD31888F1D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2025 15:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37D1D1DED6A;
	Wed, 29 Jan 2025 15:42:25 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A4351DDC2D
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jan 2025 15:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738165344; cv=none; b=BkJahdqq9FfDmk+JrM8PZFBqYhRuxbmf+CVaVMJJFvptG9NQG2UPH3azd+FC+SBwIlfhrKKyaWb5FYeVx0Hjw4fkO3PoOr0I94B9VhehbJhH0FP6Q5Y0ag9prw5RpJMGhhiRirNbqhaKtoP3mkuuWv2oPqlUU8idxzjKQNQuld4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738165344; c=relaxed/simple;
	bh=CUaMAJOWKUbREYdc4K/sKCxCM5oP+S1FQnJgXJn8nxg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tJCqYZdse37kUDHTi33PEOYhSeEUjbk+23t1z6/Gq9zdjgOElfLpdzeEBVYxLwS4fzkey1ZiabaWd3bocb99JkHcJhk9Q3DQ8YfFak+RbexgKH4bmaR26Tcp6e7/BJeIfy7mfkZz3hefCuW0rrliM1q2a2Sc986DxdCG/LMHMfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 5037968D07; Wed, 29 Jan 2025 16:42:18 +0100 (CET)
Date: Wed, 29 Jan 2025 16:42:18 +0100
From: Christoph Hellwig <hch@lst.de>
To: Kundan Kumar <kundan.kumar@samsung.com>
Cc: lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
	anuj20.g@samsung.com, mcgrof@kernel.org, joshi.k@samsung.com,
	david@fromorbit.com, axboe@kernel.dk, clm@meta.com, hch@lst.de,
	willy@infradead.org, gost.dev@samsung.com
Subject: Re: [LSF/MM/BPF TOPIC] Parallelizing filesystem writeback
Message-ID: <20250129154218.GA7369@lst.de>
References: <CGME20250129103448epcas5p1f7d71506e4443429a0b0002eb842e749@epcas5p1.samsung.com> <20250129102627.161448-1-kundan.kumar@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250129102627.161448-1-kundan.kumar@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Jan 29, 2025 at 03:56:27PM +0530, Kundan Kumar wrote:
> and b_more_io lists have also been modified to be per-CPU. When an inode needs
> to be added to the b_dirty list, we select the next CPU (in a round-robin
> fashion) and schedule the per-CPU writeback work on the selected CPU.

I don't think per-cpu is the right shard here.  You want to write
related data together.  A fіrst approximation might be inodes.

FYI, a really good "benchmark" is if you can use this parallel writeback
code to replace the btrfs workqueue threads spawned to handle checksumming
and compression.


